Return-Path: <linux-fsdevel+bounces-61490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA8DB58921
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B82348025B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E4A1A0711;
	Tue, 16 Sep 2025 00:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDJ8gNh2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A0D19E7F9;
	Tue, 16 Sep 2025 00:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982211; cv=none; b=J148m0Jmb+YvA1ONWuGePECIxYdHLEoe+3O6XvyoKScLgrUCsD3kJAdsMazJz0Qpk05P4fANwfWHQ5VFdc1SgjwSeMvdMijKra0vDp34nb7gA94a4VPDr9EAi33TkZuCR/Xrp0xLdNQCuedkQG75yX5IWvgfeTS6adLYYiRbvSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982211; c=relaxed/simple;
	bh=9Xd8GxSos5Qz1BGxdT+w1iPD9eVgqkrRRMVpPPQi2rU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L3KPvkVLcndAK0qdHgfB4zYcZnIPsX47J+Aqgnz4gxEu6UKa218L0J9BcJVf2lFwXn/y1IWCwudYzl8eMcpgm5v5PEpnRi/INkmtviJFVkJM2Xh8oYnuoXyC3/DcR0zpPVgF27hHd4Bkt9ChmQainKa/hvjyQNGmoL52o6jANf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDJ8gNh2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07DDC4CEF1;
	Tue, 16 Sep 2025 00:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982210;
	bh=9Xd8GxSos5Qz1BGxdT+w1iPD9eVgqkrRRMVpPPQi2rU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=hDJ8gNh2yQt7ZJR5HWbTrSnfjbOko0R1pYureS+WrffPtPZrbI8BshzofSkuXtVDp
	 R1/Av5m64R2ybZlTTidiF8Z6g0B4FIpramGnF6V7iNGALplYPt0+9WAj3HEskAm0EU
	 NmiXyjyauMFzltXVSm4zu785SZ2aiHHTvObybYxJ6Ce7gs1Xb404hrrjmzOi6dG3XE
	 uTCLKGtzpdLKCXJnCAaEKFy/+Bhdqo1BxvN1isTi+gmZJYe9JvJbj09vJehe4F9Oiu
	 82zy933DvM4VJhpx5nscU2A6aiqveHzk5aAOgQ9icy15saRR3hS8wF5Yv/CN/QAraD
	 KJePDXp7nfVCg==
Date: Mon, 15 Sep 2025 17:23:30 -0700
Subject: [PATCHSET RFC v5 7/9] fuse2fs: cache iomap mappings for even better
 file IO performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798162643.391696.6878173028466397793.stgit@frogsfrogsfrogs>
In-Reply-To: <20250916000759.GA8080@frogsfrogsfrogs>
References: <20250916000759.GA8080@frogsfrogsfrogs>
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
 * fuse2fs: enable iomap
---
 fuse4fs/fuse4fs.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++++----
 misc/fuse2fs.c    |   50 +++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 96 insertions(+), 8 deletions(-)


