Return-Path: <linux-fsdevel+bounces-41793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A71A37601
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 17:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14AD716C28F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 16:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A40D19CD0B;
	Sun, 16 Feb 2025 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="G/71Qlyf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B271993BD;
	Sun, 16 Feb 2025 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739724634; cv=none; b=QSXz4l6JZnDIgHIwZgwc45GskJonN4Ni9ownHNVy90hOVHNQJjziQTpRNoigKCvV12+qh+sDNy72s9PziFbznOY/o26hYwRuTGH2hVuEcbrfhOi3TiRFfmaZhzQ+p2vd8HWi7viaiS8k7gzjDE550LwZeoivQiCCHFKlIgn0oY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739724634; c=relaxed/simple;
	bh=K8160Mpl70SxTgtjMA/0Q+r9PBVwXxxO9s5QYPkl8aw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G8tF46deF1eAMoC+PD4iqqRCrJo09brpqjexksswyfcHAkT/I6yjMxq7qFEVtHr7hDYMFaPfTG7tQn6cdu5TDi8+Wk459pDVCG8ftfsEvk8kbnss00uPiRcWzyraMnCQYnXWgzN0lkP5rwXbxj3JaVR+eGBJycAnSvGajv8HwMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=G/71Qlyf; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=GuJjkzhA/wxq6jSIF/WL5nNUMyBZkTHRN/TfStd13Ks=; b=G/71QlyfRee1MbPwJBS7D94Jds
	TFLe+ku8YKFGPTerJNTl0/Z0f9SYMhZhDAZJq55CrodjM5SegC+cjzvwndhiXNc9FNkQWiG84B5iD
	fws/7fDkx3Ke3peQ6e0u/EpJRbp3gnDUATm5mw4hpmW54mhD/SPWWjHUd6uYx3/vT9s6WzWbs62VK
	9dUDeK+x1pNkukzHmcrO5fbV96TUU6AGZlQLtPWOf6J6g1cxM8GRBc7Eq2wCHOlytA6AGZVBHqjHC
	G+a7E7HKvcJrANWWUGgV1+KWo8RkfQOWwEzKMbthQR4rg7agrYO6S8WLwgVZoAIFU2T0uQWWHbP7X
	CtmUG3MA==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tjhqM-005FJd-Cg; Sun, 16 Feb 2025 17:50:16 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Bernd Schubert <bschubert@ddn.com>
Cc: Dave Chinner <david@fromorbit.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matt Harvey <mharvey@jumptrading.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luis Henriques <luis@igalia.com>
Subject: [PATCH v5 0/2] fuse: allow notify_inval for all inodes
Date: Sun, 16 Feb 2025 16:50:06 +0000
Message-ID: <20250216165008.6671-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

In this version, invalidate_inodes() needs to be exported to be used by
fuse_reverse_inval_all().  This is a big simplification of this function,
which now simply calls shrink_dcache_sb() and invalidate_inodes().

It's clear that inodes still being referenced will not be invalidated --
but that's already the case for the single inode NOTIFY_INVAL_INODE fuse
operation.  

* Changes since v4
- Replaced superblock inodes iteration by a single call to
  invalidate_inodes().  Also do the shrink_dcache_sb() first. (Dave Chinner)

* Changes since v3
- Added comments to clarify semantic changes in fuse_reverse_inval_inode()
  when called with FUSE_INVAL_ALL_INODES (suggested by Bernd).
- Added comments to inodes iteration loop to clarify __iget/iput usage
  (suggested by Joanne)
- Dropped get_fuse_mount() call -- fuse_mount can be obtained from
  fuse_ilookup() directly (suggested by Joanne)

(Also dropped the RFC from the subject.)

* Changes since v2
- Use the new helper from fuse_reverse_inval_inode(), as suggested by Bernd.
- Also updated patch description as per checkpatch.pl suggestion.

* Changes since v1
As suggested by Bernd, this patch v2 simply adds an helper function that
will make it easier to replace most of it's code by a call to function
super_iter_inodes() when Dave Chinner's patch[1] eventually gets merged.

[1] https://lore.kernel.org/r/20241002014017.3801899-3-david@fromorbit.com


Luis Henriques (2):
  vfs: export invalidate_inodes()
  fuse: add new function to invalidate cache for all inodes

 fs/fuse/inode.c           | 33 +++++++++++++++++++++++++++++++++
 fs/inode.c                |  1 +
 fs/internal.h             |  1 -
 include/linux/fs.h        |  1 +
 include/uapi/linux/fuse.h |  3 +++
 5 files changed, 38 insertions(+), 1 deletion(-)


