Return-Path: <linux-fsdevel+bounces-13864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB5E874CDF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 12:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6C2B1F237FD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 11:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C041272DD;
	Thu,  7 Mar 2024 11:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JTxKS9Uq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835F7126F3C
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809352; cv=none; b=bod1zYzEQnnw/4U2fGAqE4ut54bwdxkQxLVGTzasLPp/KW8QuC7agUTq3YfAjQl1i17rTrRvcFMRTlfBNEfVOM3gK/KAPQxf40lGsJKqfg5nieJ+NW9MBLxDGDeER3jb114/vbk7Usx3U2KyzJ72/ikMD1KcgiycNIh7BQN7K04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809352; c=relaxed/simple;
	bh=0QSQnxyjKd0GA5iCm7uDjwuB0eToFvjoyYNhhg6+cLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3Hneqyo58YUBmSkCHc23/sPEEwY34kOArAtsCCEkwzkBHPmjvRFgUVdzI1yd5oFcH4mLZUFiQEIfc+aXEqbMVA7CU5a2dACSak9S2zhuykefYTvay7wLpaDZp6JAnNnpV7bVh0xqAurrH1o6GlCff5iwNMP79XVwfWw3l94fH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JTxKS9Uq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709809349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sqEbdTxhH+AlXN0X2BsJ2SrYEHV0BB3bqwnGH/m+9AE=;
	b=JTxKS9UqfjlgvJHrL8HKhkf+jomlLc/byYLGQxPO1zxfkxeeyd9bU1i3Y7uQm1Nmo6kKbt
	e/TsYXjPcNUYxuEoSe5qG7g8CRSo+H5ftVIJGdcScAe6O+3p7EtxNi1zKM+f19wuxvDwJ6
	zYlfXy0cakD0TautNxTCtLisnnY9WA0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-f4UVVnabNzWkrdvwIM7rYA-1; Thu, 07 Mar 2024 06:02:27 -0500
X-MC-Unique: f4UVVnabNzWkrdvwIM7rYA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-412e992444eso3662365e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Mar 2024 03:02:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709809346; x=1710414146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqEbdTxhH+AlXN0X2BsJ2SrYEHV0BB3bqwnGH/m+9AE=;
        b=bjkA4b1S3mikQ1+j+46Oh6gWVjb2j7ovz6JU4nFoZ13uU+q1OaGuc3A7Z7Vc0qqo9/
         mgl5FOmbnuFeXyLqwfAArOJaWZdDSh4F1i57fHJfZn1y+QOjKQQF6hVj1npb/SaQvHxy
         rdYu8j05ty7dvv1hN2EghmL3tNuzUGtSIngZF9lPkh661EULOgIQrjsMRKbBfuvqiE43
         T30NbVTe8djQGowXjqGx9vyvBMQ5XRck6ORYFtenZNjaG2dgPcYcBl0azdVy16BvHufh
         KWkz0LRL03AnrcfpX6LyeZZHoxezTLVdFVRCepEmoubOT2wKm8fpIOKkTqG0rQp2MLNH
         FtzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXye6l1rbvU7CIn8Kei/u76ad3t9rXQ0qMuYiTSIAmbteTdn9EfHENEin9eDLlmWt2yKCczhNypn42KBYMFB5sWPDozkPLx+Q2gUQJgJA==
X-Gm-Message-State: AOJu0Yy1hBradll7brE9wgaYXPJax+TwbsOrmBiJzpA9iXyU+q2mpIg+
	/mDPd98ogiZ4qsAexOhPGQVVjVrg1kzlwOLAVVE6SUxnN0cbPRjaJcsUyd2dZ4NaXYsKhvA/Qix
	SJsI3hrgCBs2mc5v4i+C7fGgU3g4hWo+hR7nTQbbXjr04RT5dVKo/xWbqvhsdskk=
X-Received: by 2002:a05:600c:5185:b0:412:f6cd:ad8f with SMTP id fa5-20020a05600c518500b00412f6cdad8fmr3261506wmb.4.1709809345924;
        Thu, 07 Mar 2024 03:02:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtDWB/ZSmiASu9PIAgyOKOj+RelMGT3+2vbYtyDguf96RbKmQmpuXxyZtBIwzZwrxTs3pJ0A==
X-Received: by 2002:a05:600c:5185:b0:412:f6cd:ad8f with SMTP id fa5-20020a05600c518500b00412f6cdad8fmr3261485wmb.4.1709809345487;
        Thu, 07 Mar 2024 03:02:25 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (92-249-208-180.pool.digikabel.hu. [92.249.208.180])
        by smtp.gmail.com with ESMTPSA id v12-20020a05600c470c00b00412b4dca795sm2332625wmo.7.2024.03.07.03.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 03:02:23 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/4] ovl: clean up struct ovl_dir_cache use outside readdir.c
Date: Thu,  7 Mar 2024 12:02:08 +0100
Message-ID: <20240307110217.203064-4-mszeredi@redhat.com>
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

Remove unnecessary forward declaration in super.c and move helper functions
that are only used inside readdir.c

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/overlayfs.h |  2 --
 fs/overlayfs/readdir.c   | 10 ++++++++++
 fs/overlayfs/super.c     |  2 --
 fs/overlayfs/util.c      | 10 ----------
 4 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index ee949f3e7c77..167dc37f804c 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -470,8 +470,6 @@ struct inode *ovl_inode_lowerdata(struct inode *inode);
 struct inode *ovl_inode_real(struct inode *inode);
 struct inode *ovl_inode_realdata(struct inode *inode);
 const char *ovl_lowerdata_redirect(struct inode *inode);
-struct ovl_dir_cache *ovl_dir_cache(struct inode *inode);
-void ovl_set_dir_cache(struct inode *inode, struct ovl_dir_cache *cache);
 void ovl_dentry_set_flag(unsigned long flag, struct dentry *dentry);
 void ovl_dentry_clear_flag(unsigned long flag, struct dentry *dentry);
 bool ovl_dentry_test_flag(unsigned long flag, struct dentry *dentry);
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index b98e0d17f40e..4a20a44b34f2 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -61,6 +61,16 @@ struct ovl_dir_file {
 	struct file *upperfile;
 };
 
+static struct ovl_dir_cache *ovl_dir_cache(struct inode *inode)
+{
+	return inode && S_ISDIR(inode->i_mode) ? OVL_I(inode)->cache : NULL;
+}
+
+static void ovl_set_dir_cache(struct inode *inode, struct ovl_dir_cache *cache)
+{
+	OVL_I(inode)->cache = cache;
+}
+
 static struct ovl_cache_entry *ovl_cache_entry_from_node(struct rb_node *n)
 {
 	return rb_entry(n, struct ovl_cache_entry, node);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 2eef6c70b2ae..2413d3107335 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -26,8 +26,6 @@ MODULE_DESCRIPTION("Overlay filesystem");
 MODULE_LICENSE("GPL");
 
 
-struct ovl_dir_cache;
-
 static struct dentry *ovl_d_real(struct dentry *dentry,
 				 const struct inode *inode)
 {
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index a8e17f14d7a2..cfe625717c47 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -421,16 +421,6 @@ const char *ovl_lowerdata_redirect(struct inode *inode)
 		OVL_I(inode)->lowerdata_redirect : NULL;
 }
 
-struct ovl_dir_cache *ovl_dir_cache(struct inode *inode)
-{
-	return inode && S_ISDIR(inode->i_mode) ? OVL_I(inode)->cache : NULL;
-}
-
-void ovl_set_dir_cache(struct inode *inode, struct ovl_dir_cache *cache)
-{
-	OVL_I(inode)->cache = cache;
-}
-
 void ovl_dentry_set_flag(unsigned long flag, struct dentry *dentry)
 {
 	set_bit(flag, OVL_E_FLAGS(dentry));
-- 
2.44.0


