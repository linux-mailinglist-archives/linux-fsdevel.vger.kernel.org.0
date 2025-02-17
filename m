Return-Path: <linux-fsdevel+bounces-41852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D74D4A384BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 14:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0532C7A2C21
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 13:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1359921CC7B;
	Mon, 17 Feb 2025 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="BLwPzHCZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ACA216E35;
	Mon, 17 Feb 2025 13:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799166; cv=none; b=elZBUoju6pf6bwIP/wE6KrtWi7quqMdaeOef5WW7RIRF8Sj3b56CrfNvSsU/K8fNJl7nZNdKt3WyMlejvJ3mWW7sNweR7jyPgG97BK9V78BQnbPhwJQ4vyfGkQdqPAMAEGix47gozBBFNWMbrxCFOF+KS/qiELlVLfdUNCUjiPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799166; c=relaxed/simple;
	bh=/peew0N0sYIEeywo5Qi44geS0So+iTeYQWeqk48ZKnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lRA/6K15Pn3oJpYdf6lolyu0DnsijuC4y0zmKWTCRiBVn+0OsHDE/gVJY4rDAg+NcPUs0rhJrVUDhXe5m2naLacizcg46LisEDwea7Btknx4aw/oLCaH1/P2vjvKiHwe5RLb2CyCUZSsK7oDU0APGjesnqMMLRqkfSTo2CUIHts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=BLwPzHCZ; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Mrpii7aiMFOF7c2Q6EMdLlKuMvw80fO9NyNXLvoPESc=; b=BLwPzHCZ3fpXoGLIsCiP6VAtW6
	LLBuHDxjXuAdlJFXzuCssgP5PIfzC6JxtER4jdCVEqSIK5f6IoTkF+FPQb7LOeAiOzh/KAmPVgjCC
	aodPuc+u+czzSm/2+ovwXyajjF0ukMCDWc0P1YF4GTroTY3TlcQKIzADrgHn45JsEtB+4Q1Zm4Ljo
	+58ZorSLEMUid5hiv509t6Mvw9I+xga/Pqwy+xNzXUeEdD+xYn35k1wnd/mVlA7PwwI5BW1pUyqeC
	6xe85OTJ4lTJboqVlJovWaZhAPNoHmJld10MA5lmfCjx4sv18mhMQRp3C1b+ylwTduiAKiJiCp2dJ
	O253GvcQ==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tk1EV-006AK6-QT; Mon, 17 Feb 2025 14:32:29 +0100
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
Subject: [PATCH v6 0/2] fuse: allow notify_inval for all inodes
Date: Mon, 17 Feb 2025 13:32:26 +0000
Message-ID: <20250217133228.24405-1-luis@igalia.com>
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

* Changes since v5
- Added missing iput() in function fuse_reverse_inval_all()

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

 fs/fuse/inode.c           | 34 ++++++++++++++++++++++++++++++++++
 fs/inode.c                |  1 +
 fs/internal.h             |  1 -
 include/linux/fs.h        |  1 +
 include/uapi/linux/fuse.h |  3 +++
 5 files changed, 39 insertions(+), 1 deletion(-)


