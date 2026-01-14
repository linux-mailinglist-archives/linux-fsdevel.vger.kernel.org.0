Return-Path: <linux-fsdevel+bounces-73753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 479B4D1F8FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 729E0304A7EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 14:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C3F30E0EC;
	Wed, 14 Jan 2026 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MYO+AUtA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NsfCHvG6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DFB238D42
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768402435; cv=none; b=UCoyAW179h0sIeM0B7gxd5nik9JK+mYS9v60SiTT6wtm38UHvQ3YXYLt5dfmMLBT1EuCSyhuxyoEkv1fxWpfMUqYKmS819DPCkFSMt178sQIvi9I3YMkiYbSPCjYUbHFnJ/nwuYseX/7iRHgIrKUwlhxZOJ85iF/jWrfsJcZ1yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768402435; c=relaxed/simple;
	bh=7wsEMWdZT+etNQ8y4C1TMhiCUVWWjOXgBdWDphdhvmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jC4pWkPbSQW7Z8wG9PJ8nYu8UP6CMy8jpwx/UlEypKW8ghQ1YVV+4xNoT/HBtIKyI8FVOCRAXzSQZ7w21L9WlrjOfbgTVaGV/3hWGX1GsicZWhN9XxLmTxieycxSeUFAM8EZFZvWQulXIiMFmlsSh7JcI7VADAb9EpXVIBMeuP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MYO+AUtA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NsfCHvG6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768402433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9FUi+TbOC/UnTqrVb1GvOrPEnLyuxLs5m5hPMhYA4bg=;
	b=MYO+AUtAk7CdC/fXNl4e+XHceahDIU39/Lwfh6hXOgVv+7h4sKdhOczXxcHKzQVAoDjgUz
	StHrPlUvvbKIwAqfTiQhLS1nP6fSfOzgMC4EY9s6JCvG5gEqmOspnji4PfPPGOqQIhn4Ya
	U9t+e0qIEh6IGynnBswxmyMMogMO+ko=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-HtNjUL9UMH2kAE31O1Q-9w-1; Wed, 14 Jan 2026 09:53:52 -0500
X-MC-Unique: HtNjUL9UMH2kAE31O1Q-9w-1
X-Mimecast-MFC-AGG-ID: HtNjUL9UMH2kAE31O1Q-9w_1768402430
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b876b03afc5so114791266b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 06:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768402430; x=1769007230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FUi+TbOC/UnTqrVb1GvOrPEnLyuxLs5m5hPMhYA4bg=;
        b=NsfCHvG6LPuea3FXm93XA7MkQ9kqPMVrqv5RbMWGBowVyzpaVhDqxFm59IvaRD8R0A
         uM0US3FxYBOi4fRhfUrtJATKtX4WJKDSt5nvsWc4bZWMM2Yt5lXvJiVBu9QUJo3TGjKs
         KwF8AxVaqhc1CsP06FgZ26Zaz1PdF5gyqRwqbRdzjThySKn6O48KHSFn2pGlJRB3zhXf
         EwbdUtBR/oU8kY4TQuTChb49XG1Z+Lccv/Y3m12MHKADX+oPbwp7//bTmwsclAHmJl2D
         mPNjJjaujb5VLYlCcxpP4OkzubHAWDBng0ZC0G8zkSAegub5PD0nhmPbIYUeVLgXcONf
         2avQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768402430; x=1769007230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9FUi+TbOC/UnTqrVb1GvOrPEnLyuxLs5m5hPMhYA4bg=;
        b=wRSXSrlyoK1OQDC8l+4ri4vgdk1CEkseCyXp/U6OsCew7PEULx0o+ZHGrSocnNhrN9
         sVFxzp3X1VEoDyGlg5eKEphwB6Qm5OVKqXLLNI55+o5aicp1fIQz+n9zbszZyjXXOuNH
         PYy8aOtEl2iPM4vF4ULWx87wqekLOHdDTrQN2w8EXmAiXxcuOhvCpYOrz3fWvri39NkD
         P+q86o+b+H0S5tQ29eFDGLBawZahwNCoGRBXRuUo3/WHJqU6MMBJWxGura9AKUocs8tq
         +7oKPiJT8PbauSMpGJDJFmlakGaXfaf6lldJpo39ku5GCjcgiIj9FS22WI5XdtTUvp86
         yPKQ==
X-Gm-Message-State: AOJu0Yw7S0ZJz6ixcEq5iyGDFZWLc5cMD6zuuY7Id7gcp1TBOKB1za3a
	ejFX5dX/pKwmc6Ogi9Jf7VjEIVMAZVKECn3YknZLC916owgKpAKeBle3aqAU75tcOW0nEwHIVFj
	fMEcDilw7b7SX4StKEoHj60H8zZbfaLfuPPQEf+wN/BwvKn3m5h8L8onix8Q1ywmzY287NEE7rb
	E3jKCcNc7tSyRuBHsVi75pdUZeWDnseOG92jK6pXm4xfy07zicJTM=
X-Gm-Gg: AY/fxX77J3OGiHl0IbZ3Ps+Ezs6n1SszrLsxPPN4tI8bwYksFl+mW19TIuB/4w6yKsE
	a49GxN7Pai2EkADrJFaHB8qPgv+nULXw39nBPgDPKJukgUfyp3uM0wdniDkAuquooTPTE1E4DCK
	bUnT2ru6LpgORxGGV33tFE7IYjvR0Cu9vSEh+bAnF2eYD9yM8ytO27JR69wmQNTx5z7/zR3Eo4r
	FR9Umopn0pWRlsptcH76TG0hhAlfzIhn6a2Z+qaHDF8BV6z+V0NqHwAHsCrUrOYtVhl8IDtay7x
	bEhvYf5MsVuBer7romuRZrFsKiPQjLOtEccbThV3MkCugVVzgTNgFOjMJ7dRjUB2IDADjtuUrFk
	zRgIibn45dvzQRrU1teiuTGPF8J2jDUxAPD2JZSsxtA9PG+twqi3nyGIQDuzfcIgq
X-Received: by 2002:a17:906:4784:b0:b87:2f29:2060 with SMTP id a640c23a62f3a-b876108aad9mr304618366b.26.1768402429706;
        Wed, 14 Jan 2026 06:53:49 -0800 (PST)
X-Received: by 2002:a17:906:4784:b0:b87:2f29:2060 with SMTP id a640c23a62f3a-b876108aad9mr304615866b.26.1768402429222;
        Wed, 14 Jan 2026 06:53:49 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (193-226-246-7.pool.digikabel.hu. [193.226.246.7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf6d5absm23059608a12.33.2026.01.14.06.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 06:53:48 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Luis Henriques <luis@igalia.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 2/6] fuse: make sure dentry is evicted if stale
Date: Wed, 14 Jan 2026 15:53:39 +0100
Message-ID: <20260114145344.468856-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114145344.468856-1-mszeredi@redhat.com>
References: <20260114145344.468856-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

d_dispose_if_unused() may find the dentry with a positive refcount, in
which case it won't be put on the dispose list even though it has already
timed out.

"Reinstall" the d_delete() callback, which was optimized out in
fuse_dentry_settime().  This will result in the dentry being evicted as
soon as the refcount hits zero.

Fixes: ab84ad597386 ("fuse: new work queue to periodically invalidate expired dentries")
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dir.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 2f89804b9ff3..cd6c92be7a2c 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -172,6 +172,10 @@ static void fuse_dentry_tree_work(struct work_struct *work)
 			if (time_after64(get_jiffies_64(), fd->time)) {
 				rb_erase(&fd->node, &dentry_hash[i].tree);
 				RB_CLEAR_NODE(&fd->node);
+				spin_lock(&fd->dentry->d_lock);
+				/* If dentry is still referenced, let next dput release it */
+				fd->dentry->d_flags |= DCACHE_OP_DELETE;
+				spin_unlock(&fd->dentry->d_lock);
 				d_dispose_if_unused(fd->dentry, &dispose);
 				spin_unlock(&dentry_hash[i].lock);
 				cond_resched();
-- 
2.52.0


