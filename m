Return-Path: <linux-fsdevel+bounces-58428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB71AB2E9AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65455E2ACB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575E51E493C;
	Thu, 21 Aug 2025 00:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4lg0oan"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64FA1DDA15
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737347; cv=none; b=ay5voEV1VKT3us0YfmuYRYQskj7ZmAui2TcrtumldgIgNr14+NEfN7nhqYGcP5yrIL2068GlGU0kNQch6DUvNPR0e0yRAIU9OmPpwuSplE8geJaqOQYR/TMO0OBInUENvipuEhetW54hP6ZlE70H+it2iAVyCeecjwagOH1Cb1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737347; c=relaxed/simple;
	bh=T91Z24Aj91YbWCARuFSZNugTGTqYeW7XbqfIuS3hgbQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IVFeEeiPCmVfMt6UCAIVgBFyZ8CPj9nadfqfSLxFsILHN+NR1DCMFciftlUpNSNAEfyPzPSyv4KTxYjG/2mJjrL1gL4lONlDGCDGHsQ0YzEBTO+8hGPt/TJyAmvZMBq7n9ZJvbcJQAKmuB7dIbN4XMbSdCYDf7ebw6mMsTnFxIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4lg0oan; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F193C4CEE7;
	Thu, 21 Aug 2025 00:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737347;
	bh=T91Z24Aj91YbWCARuFSZNugTGTqYeW7XbqfIuS3hgbQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=e4lg0oanx6MCb61qUKPchPcxVnSeQl7fEARP9NiFYQd/duYHI+a6GvBQuR95r93fL
	 J6yObc2x+JFqsXlPoP+PcsColhbcExpjCTRTB/YXo1Z4moDm8M2NMneYXUR4+jMuZl
	 7DfTVFbol93I+R4ZTLzXmlo5Ks/vkfsV2cUaZSfWBTY0B9YdAPbUf66MgS95jr6Jhs
	 YY6Vfz9OatWne9DAmMXhBNCPzI9k2OSdy+5m6ggRQR1s1S3LLcySmBeiKC2LPvdpt8
	 PaIxW2u/80oGTDmyjBRL1oundSUef2y6xuljwLKMsvHQNTWtcvdiF1oqUb+LjeTQkH
	 mb5YOZVEh1okw==
Date: Wed, 20 Aug 2025 17:49:06 -0700
Subject: [PATCHSET RFC v4 4/4] libfuse: implement syncfs
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <175573712188.20121.2758227627402346100.stgit@frogsfrogsfrogs>
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

Implement syncfs in libfuse so that iomap-compatible fuse servers can
receive syncfs commands.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-attrs
---
Commits in this patchset:
 * libfuse: wire up FUSE_SYNCFS to the low level library
 * libfuse: add syncfs support to the upper library
---
 include/fuse.h          |    5 +++++
 include/fuse_lowlevel.h |   16 ++++++++++++++++
 lib/fuse.c              |   31 +++++++++++++++++++++++++++++++
 lib/fuse_lowlevel.c     |   19 +++++++++++++++++++
 4 files changed, 71 insertions(+)


