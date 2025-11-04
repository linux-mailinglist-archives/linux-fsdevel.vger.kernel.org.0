Return-Path: <linux-fsdevel+bounces-66872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A53D8C2EE01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 02:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B893B012B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 01:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B39236A8B;
	Tue,  4 Nov 2025 01:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b="i1d9XUag"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0011921ABBB
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 01:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762220931; cv=none; b=mS9rEc6ktWu+HIj0RxmyeFgkb9vhx5bRlEBjjRHEcAloLTqDmGaGrQWLYP7FozbRZpVHdtsrRsBtuBs0tPxpLUsk9EhaJSJbtrP+4Cox5dWkPSA99vfImtqoCd13/HdHORMQtLKZ5u2aaL2L2VOPNe6/u/OyENfcRrp9Zz4p0cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762220931; c=relaxed/simple;
	bh=8n7yRExyFgHYfUULPtG7ZIubacmLiDD6ZcsL4aI2anM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QG/z3rqP/g5MSHOmrHxnG5R9S/e6TDpayShnAvK+1g2gA/GiXhQcQRtP8g7JgqxZi4tkuFupTW77l/VQsXmzu7O205PwfIz+z5RTSyk1Tv/Pgf3HwGU9mL2QykVCZCBKMQTVg67GMtV8iZFYCRAr80+Upsl322GficZcs9y45zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com; spf=pass smtp.mailfrom=gvernon.com; dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b=i1d9XUag; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gvernon.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gvernon.com; s=key1;
	t=1762220927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OeOQKsQrYLAJRjnO5Q4cmqKi/VkAf2NQPTMDZnSIUtg=;
	b=i1d9XUagKKoN86iEgNvJzl+vyvt85A0WdS3Q4XMKKTWF2KV5zGKKNNxZT+CoPX7e2Bunpz
	Amc7OcbtUwW2EOvIkLmEoetFvGeGzZPsOXWW14deax+VsHJx7bO+0R4q8pM430KaoqjomV
	UGTTXo0Ntf/+ophro8UJ0BI9qh5oiIaeeoQZSF1vHOHBcq+JnfFW1zdV7HRq8xIRhNuqkr
	lcX7xRRN4C4jwGvvtEAvAD/AvTqqFLW7NtLZm4XgfHTD7LHLAovUSwEY/vnB2kQbUmSybk
	pn3+2YNwUG3mpuQuPF0sw2zZ3JMvr0gkHb3NDFSrg4WSUuRxLxYYmfdl0Y0Wug==
From: George Anthony Vernon <contact@gvernon.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	skhan@linuxfoundation.org
Cc: George Anthony Vernon <contact@gvernon.com>,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	penguin-kernel@i-love.sakura.ne.jp
Subject: [PATCH v2 0/2] hfs: Validate CNIDs read from filesystem
Date: Tue,  4 Nov 2025 01:47:35 +0000
Message-ID: <20251104014738.131872-2-contact@gvernon.com>
In-Reply-To: <d2b28f73-49c8-4e30-9913-01702da4dfe4@I-love.SAKURA.ne.jp>
References: <d2b28f73-49c8-4e30-9913-01702da4dfe4@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Changes from V1->V2:
- is_valid_cnid prototype now takes u32 and u8 types
- Add fsck advice in dmesg
- Replace make_bad_inode calls in hfs_read_inode with gotos
- Reuse same check in hfs_write_inode
- Disallow HFS_POR_CNID, HFS_BAD_CNID, and HFS_EXCH_CNID
- Add Tetsuo's patch to mine and make it a patch series

This patch series contains two patches which work together to prevent
bad catalog records from being read. Previously it was possible for a
malformed HFS filesystem image to reach a BUG() in writeback. I propose
to fix this by verifying that CNIDs are allowed ones when constructing
an inode in hfs_read_inode(). Tetsuo Handa's additional check in
hfs_fill_super makes sure the root inode's CNID is correct, handling an
edge case where the records' directory CNID > 15.

I think we should continue returning BUG() in hfs_write_inode() because
it is a filesystem implementation error if we ever allow an inode to be
constructed from a bad CNID. Now we properly guard our reads in
hfs_read_inode(), records with bad CNIDs should not get so far as to
initialise inodes which are queued for writeback.

I'm suggesting to disallow HFS_POR_CNID because there is no 'real'
record with that CNID or corresponding file, it doesn't make sense to
present an inode for it to the VFS when it exists only as a dummy
reference in our internal btree. Similarly I'm suggesting to disallow
HFS_BAD_CNID and HFS_EXCH_CNID because not only are they for internal
use, but we also do not implement bad blocks or exchange file
functionality in the Linux driver.

Thank you to Slava and Tetsuo for the feedback on V1.

George Anthony Vernon (2):
  hfs: Validate CNIDs in hfs_read_inode
  hfs: Update sanity check of the root record

 fs/hfs/inode.c | 67 +++++++++++++++++++++++++++++++++++++++-----------
 fs/hfs/super.c |  2 +-
 2 files changed, 54 insertions(+), 15 deletions(-)

-- 
2.50.1


