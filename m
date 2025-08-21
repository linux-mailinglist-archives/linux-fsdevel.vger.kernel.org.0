Return-Path: <linux-fsdevel+bounces-58432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD103B2E9B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986605E2B92
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938361F0E56;
	Thu, 21 Aug 2025 00:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nzym+/sw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC09218991E;
	Thu, 21 Aug 2025 00:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737410; cv=none; b=Cin08EXuQySDTGXW4P27cpIxq6by70tWbz1AIpcZCa6yFmtvqSpx34xAUucZbzhf6V3osnDIt/rx91SCqxYDmQwrqH2DDYkNA1TxF52cBkqcY2a8krZDI+cGgKOCYAmDl3vwoCor7lLbdMqrP6o4wgZfODOXLkjtgBLqg43IVaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737410; c=relaxed/simple;
	bh=D/Kksh+bYHitv4qSleEHwQXkStXIFOVtu0h1W5Efo0w=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pD3p+zZDRbyuyLiqCytqoC7Bvrcr2sr0e1kILcyECvjgAkxvW43ZtjIErftpZw2WrSvHd3F9zP2+EWJZwzXLo//PKzH72HckDa20i80QBfERFPYSo2mfIqebpUZs1CCjwy/YEYvtcszNYytXLY2XJxh6U8i7k0SOkLn7sz0yvCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nzym+/sw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DB4C4CEE7;
	Thu, 21 Aug 2025 00:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737409;
	bh=D/Kksh+bYHitv4qSleEHwQXkStXIFOVtu0h1W5Efo0w=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Nzym+/swX0qVE7f9G8CQFXYgIukjw46gKoZV8NzoO63coIXVGd7zmC773TxEGUMY2
	 8t6+6K3GLOqJUTReShR5wgTyrYG9LTgF6cjGX/s9mk1KFyMuH0zeQ5qZrcbqGTtHss
	 F5Fd5TKJkrTmk0u6k6ZjpLj6UClkrW2UI7swxypd4ewctZmugSfEL+3Q4zmRzqQ6UB
	 ztsteMNLzWIV4G6eMPBxEfPTSwcgFZwuWU8Jg4mePnEIO+3Z5hLERRS5QFlgGORt2E
	 7eYTUdgCUgqMvV5yIEBU/fOFQ3iImQPQAgh4WTopx43NolSW9jp/ro38stJR72dqKn
	 pS/+J85IebE2g==
Date: Wed, 20 Aug 2025 17:50:09 -0700
Subject: [PATCHSET RFC v4 4/6] fuse2fs: use fuse iomap data paths for better
 file I/O performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573714195.22718.16229398392414971041.stgit@frogsfrogsfrogs>
In-Reply-To: <20250821003720.GA4194186@frogsfrogsfrogs>
References: <20250821003720.GA4194186@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This series improves the performance (and correctness for some
filesystems) by adding the ability to cache iomap mappings in the
kernel.  For filesystems that can change mapping states during pagecache
writeback (e.g. unwritten extent conversion) this is absolutely
necessary to deal with races with writes to the pagecache because
writeback does not take i_rwsem.  For everyone else, it simply
eliminates roundtrips to userspace.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-iomap-cache
---
Commits in this patchset:
 * fuse2fs: enable caching of iomaps
 * fuse2fs: be smarter about caching iomaps
---
 misc/fuse2fs.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 misc/fuse4fs.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)


