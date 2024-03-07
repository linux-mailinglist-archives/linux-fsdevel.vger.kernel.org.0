Return-Path: <linux-fsdevel+bounces-13862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2563874CDB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 12:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180121F23815
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 11:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460C885269;
	Thu,  7 Mar 2024 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHWEWf9u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2853385277
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 11:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809346; cv=none; b=Z89ugwlw+bps6NUf6O/sfo0Sy3dl9c8yveGJPJVtr9KchiKlONWLyP0I4xO6VVdoRQ5ivEDrJOMlSDTCirJol40Iiqx+yNZgS08LanHHsvnt4IrSHF5SB/LDPal1VDwWgBAT0tWe0aK66QtWClxnGcBWNysskQUz84HhI6ioXzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809346; c=relaxed/simple;
	bh=IbuU5cpOt420V29ONwOifcPW/3aVME6yzHFDe5gsTxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ooznTP9hF/oEly7RJMkPoelbgGCrfqIyskxITf7ta5qTkHyC/Mq00lcGlq14e4/TrU9SpOCkAFqH8NapGWL0Y+vMrJYZass59haX6VggoxArPEVlDmkej+b9x0kOCaJ8PQdAeZkx7F9Z7XACyUTvQIAkgXPgmYD0XZ1h3vGB3Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DHWEWf9u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709809344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bowjdvADPqPbbMJAv78SEAOB2sDLU3RVgb2xFBl2V9E=;
	b=DHWEWf9uC0906Bri3/3wlemKZbLIjgnvi4CHNctNZcRVw+sU9x8/h2F+kVZEZ29FKBB9b7
	v02YN+77EH9vCj1reQ4zpRshhWKHUVI1TRysWkQ3g54veCycUMmj5tgjppjHuWuu02bz6V
	uChIurqLKVs5SviRdQwXr0we1umw9yM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-2bxVuccvPVSkZnXE9v4EGw-1; Thu, 07 Mar 2024 06:02:22 -0500
X-MC-Unique: 2bxVuccvPVSkZnXE9v4EGw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4130b4b6676so3668395e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Mar 2024 03:02:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709809340; x=1710414140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bowjdvADPqPbbMJAv78SEAOB2sDLU3RVgb2xFBl2V9E=;
        b=bXc0bBW6mohjT3BHgZKWxi8TMQXT2N02K02/11OkDzdE3rl4XWQBCqRWyDEBOMCz/Z
         xo6Pf1ISY4iRKrkO2B5KdXIRDjjP5plubyIWZCjiFuQokAj9dVHzYSSPaePGdC4+hVe7
         0o1pzQD1H9XGxiYK4BV/x7F/Nn2lVIKDVRzWGLNUwau5NjQXaoHMY1AvLYUwk7i6lpIN
         RWnSXkupjZMC/cPsClTDFzSEAshLtHecGOVhFKDg1XDRhfajSO8TuKkwBJrCuXgAGOv9
         LPG67FEqF3VTvBP2V2biNBGu3s7Rg/KkmnhoRSmnd/uoV6YfMJJAJy17k9R4W5r2O7ny
         JeGw==
X-Forwarded-Encrypted: i=1; AJvYcCXg+jxlUi6jhq1Pwm34vP1Z88ors1VIrSts9corwhCE7YxHt04OL5Z/IHgLHEuFfENjt+7UFCh9jgSwm7QZaufwg96v5ofRaEjLG4RTOA==
X-Gm-Message-State: AOJu0YwdVRfiQqQKNtMUk0R00Cop5ZP/XdIraZhdM07LxVe1SHeQwa5N
	Ul3+RKIEZ0OfPP8LCz3vGd3PjgsF3tt0DJ1Rw+fNFBIZEH7BjLjPqc4BRYILuSlcS5yQpxpRLkF
	6tEkxRrvElyhBk+VhwOYHbm5Z+RHz5TxV+0nvfKqcGYLi3tPQHwHvOiQQSlMkMauZb+mcv+Y=
X-Received: by 2002:a05:600c:4ec9:b0:412:ef25:aa91 with SMTP id g9-20020a05600c4ec900b00412ef25aa91mr5115711wmq.18.1709809340673;
        Thu, 07 Mar 2024 03:02:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYF+HpiuxhQAvUoex5tPttsDJk6McYDOiAp5uXUQ4YE6sEf/l3M2Ps2IwQLKOzA/wVD0apaQ==
X-Received: by 2002:a05:600c:4ec9:b0:412:ef25:aa91 with SMTP id g9-20020a05600c4ec900b00412ef25aa91mr5115701wmq.18.1709809340434;
        Thu, 07 Mar 2024 03:02:20 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (92-249-208-180.pool.digikabel.hu. [92.249.208.180])
        by smtp.gmail.com with ESMTPSA id v12-20020a05600c470c00b00412b4dca795sm2332625wmo.7.2024.03.07.03.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 03:02:19 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/4] ovl: get rid of iterate wrapper
Date: Thu,  7 Mar 2024 12:02:06 +0100
Message-ID: <20240307110217.203064-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240307110217.203064-1-mszeredi@redhat.com>
References: <20240307110217.203064-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 3e3271549670 ("vfs: get rid of old '->iterate' directory operation")
added a wrapper around ovl_iterate() to lock the inode exclusive.

Use the overlayfs private inode lock instead to provide exclusive locking.

Add ovl_inode_lock()/_unlock() to ovl_iterate() and replace
inode_lock/_unlock() with the ovl_ variant in ovl_dir_llseek() and
ovl_dir_release().

This replacement is valid, because the inode lock was taken only to provide
exclusion between these functions (for other files referring to the same
inode).

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/readdir.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index b894a97f8ef8..edee9f86f469 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -758,6 +758,7 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 	if (!ctx->pos)
 		ovl_dir_reset(file);
 
+	ovl_inode_lock(file_inode(file));
 	if (od->is_real) {
 		/*
 		 * If parent is merge, then need to adjust d_ino for '..', if
@@ -806,6 +807,7 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 	}
 	err = 0;
 out:
+	ovl_inode_unlock(file_inode(file));
 	revert_creds(old_cred);
 	return err;
 }
@@ -815,7 +817,7 @@ static loff_t ovl_dir_llseek(struct file *file, loff_t offset, int origin)
 	loff_t res;
 	struct ovl_dir_file *od = file->private_data;
 
-	inode_lock(file_inode(file));
+	ovl_inode_lock(file_inode(file));
 	if (!file->f_pos)
 		ovl_dir_reset(file);
 
@@ -845,7 +847,7 @@ static loff_t ovl_dir_llseek(struct file *file, loff_t offset, int origin)
 		res = offset;
 	}
 out_unlock:
-	inode_unlock(file_inode(file));
+	ovl_inode_unlock(file_inode(file));
 
 	return res;
 }
@@ -929,9 +931,9 @@ static int ovl_dir_release(struct inode *inode, struct file *file)
 	struct ovl_dir_file *od = file->private_data;
 
 	if (od->cache) {
-		inode_lock(inode);
+		ovl_inode_lock(inode);
 		ovl_cache_put(od, inode);
-		inode_unlock(inode);
+		ovl_inode_unlock(inode);
 	}
 	fput(od->realfile);
 	if (od->upperfile)
@@ -966,11 +968,10 @@ static int ovl_dir_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-WRAP_DIR_ITER(ovl_iterate) // FIXME!
 const struct file_operations ovl_dir_operations = {
 	.read		= generic_read_dir,
 	.open		= ovl_dir_open,
-	.iterate_shared	= shared_ovl_iterate,
+	.iterate_shared	= ovl_iterate,
 	.llseek		= ovl_dir_llseek,
 	.fsync		= ovl_dir_fsync,
 	.release	= ovl_dir_release,
-- 
2.44.0


