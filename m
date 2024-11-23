Return-Path: <linux-fsdevel+bounces-35650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 962D29D6AB9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 19:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4326BB22138
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 18:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5AA1531C1;
	Sat, 23 Nov 2024 18:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHJ0pD+N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB2413D531;
	Sat, 23 Nov 2024 18:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732385610; cv=none; b=ADy+BRTrKSoVT3K5SVB8TkJiHyEa9EeYx+LcUphDi7ZsUXidkj3vK3FxrP3ybDU7dbjvknZ3MYI33Y+OdWL/pDat2JEhGgwsA2SCcRb7hznw2wCI/ZqEOWMuMPicmpixxAU3zL1onFAsn+OoH+p+4k64WqD/QX+uFrLEa8r7d10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732385610; c=relaxed/simple;
	bh=3yuaf8wLNYOLNE2OcdI3jAv0e14pIlTWgpltyhkp7T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=piNv8Pif6e67YPYVpxux+qtp4i+QJD2MA7s1h+aIlzAG5pzDgQK5eTqvCmNVoh7tbtxrfQ45mKWlNZSTeXwLISsJAjE9OZCOpdEclh0qbohJpWvcvz40bN379HJuaA5pW1ohIeqXv6mjroOq5/bxDOCtJbEb7k0PATXz5avlpjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHJ0pD+N; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ea4c5b8fbcso2310010a91.0;
        Sat, 23 Nov 2024 10:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732385608; x=1732990408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tg3VWdEHX6oI8z2oKUcIZ37Iko16y24re5yLowPrn/U=;
        b=QHJ0pD+NWOeUz5rWkE9bWm8ru2Th0bj11UP3uABVJuTGrTHa/qXQRpNged5SDi+mK1
         8xoPmnYtQgRiiVf/HO77a8mTDf86bUktKGl8mucd71qblSwy34x871u70YkxIHT3d7W/
         zqBGyJ9NrQEHG/m18yFeEu5fL0cAFoHFVL/qjZWpMpRaychkcLgH/P54pvJSrj4gpAEk
         qHTYSVU0mF+sA0TazlFYBSm/y4KwK9EnLzP9baR6NzXMVzjniVvbuoBdVj41TdsQl13h
         aVzImPoO/1BrVhO2kHzd3ebK1a4Txn92z4DK72qxRKkf6/3G1Rg8Yo0WnlOGUP2SQfFT
         RDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732385608; x=1732990408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tg3VWdEHX6oI8z2oKUcIZ37Iko16y24re5yLowPrn/U=;
        b=ejZnTvq4BlP+jNLTr0TdzKax8ZHw4gCjFh2SSuRKkCW31knHLE/L3Uk+CaqYdzb8Uf
         mUL+XDhDCEZBoV0vPMASC92CvoGpulwRAInWzLwMa+8rlwWPpaslcI3+AxOfdcX9Vb3z
         +EOJQ3R3towwYOd8IrOFQRTIahuRfmD7PoXsZrkJILOiZzhS1ORUyxws5J7/uyDyZ7iv
         Uf8pVGsr8Sxo0DZWr6NUuuQsFM65XzmqaNZxSczXP3zyQe6X7Ku7dnRgoGTawDneJxQe
         Hv8U3MY/BIl+w6dOMpqsFlEVLEu4CtKvgxvhaG/rP0H3DYfBCK4jii6yptjP4G7Yb5OP
         B+tA==
X-Forwarded-Encrypted: i=1; AJvYcCUEpchNN2v8HTyABTB5/Jue0llcusx5ikCNxBRpwoumNxAjA3mUAHSaWvnjiW8cqNOx1KDvkR2MUGY21B/F@vger.kernel.org, AJvYcCXCXBvApknd3Cg5uNE5wkQHudBj9Jwqw4/H5ElYxSrn82KcFxZ7C6jlp4ewZgUtpz7YXJqlbuWerst1VTbB@vger.kernel.org
X-Gm-Message-State: AOJu0YzHKXrmW8C/taH3CpR7F9l8Y+nFZCaTW1D/NhlmHXm4EoGSwMUa
	PVwVN2x/3gHnGrtBIoEjKYmu666ph4wpmj6Qz5ZlqwerfyIR4DeX
X-Gm-Gg: ASbGncsXeC+FyCkwLTIDYt9TUbpVPFwhluPWnZk+7DHq+V6h3ykoqXuQemnpS08oc+P
	y2Ix2a/OTT53s5SuVBm8bciwEFGKST6EmjKNYM7mXag4jRWQVhFXF0wDyl5BeV/pr8rfo7YJlaM
	QxBCdEvj0pQZLApDVAfrsFdlTB8YKHDwU9rzrlDUXyIQaFzMkpe2v/oB/kPcCWndJJEXG2aPrZo
	bciL4V/rVK0wFgCkpBtDp5J52NX/bPXUPQYj49T5v2owAMd0Zc/kUk2rQwb4lMizQ==
X-Google-Smtp-Source: AGHT+IFe7yUTW8Zy8xp6HGcEUJRGWfXgagHJd97k1DPmATdS2e6a25O4OwpAwbp6FQdqOqQwZI1+vg==
X-Received: by 2002:a17:90b:4b0c:b0:2ea:a9ac:eeec with SMTP id 98e67ed59e1d1-2eb0cbc715cmr11118732a91.18.1732385608169;
        Sat, 23 Nov 2024 10:13:28 -0800 (PST)
Received: from localhost.localdomain ([119.28.17.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0cfe4b25sm3662235a91.11.2024.11.23.10.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 10:13:27 -0800 (PST)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: alexjlzheng@gmail.com
Cc: adobriyan@gmail.com,
	alexjlzheng@tencent.com,
	brauner@kernel.org,
	flyingpeng@tencent.com,
	jack@suse.cz,
	joel.granados@kernel.org,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mcgrof@kernel.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH 6/6] fs: synchronize the access of fs.file-max and fs.nr_open
Date: Sun, 24 Nov 2024 02:13:22 +0800
Message-ID: <20241123181323.184391-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.41.1
In-Reply-To: <20241123180901.181825-1-alexjlzheng@tencent.com>
References: <20241123180901.181825-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/file_table.c    |  9 ++++++++-
 include/linux/fs.h |  1 +
 kernel/sysctl.c    | 18 ++++++++++++++----
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 43838354ce6d..4c0113912d9b 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -37,6 +37,8 @@ struct files_stat_struct files_stat = {
 	.max_files = NR_FILE
 };
 
+DECLARE_RWSEM(file_number_sem);
+
 /* SLAB cache for file structures */
 static struct kmem_cache *filp_cachep __ro_after_init;
 static struct kmem_cache *bfilp_cachep __ro_after_init;
@@ -102,8 +104,13 @@ EXPORT_SYMBOL_GPL(get_max_files);
 static int proc_nr_files(const struct ctl_table *table, int write, void *buffer,
 			 size_t *lenp, loff_t *ppos)
 {
+	int ret;
+
+	down_read(&file_number_sem);
 	files_stat.nr_files = get_nr_files();
-	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
+	ret = proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
+	up_read(&file_number_sem);
+	return ret;
 }
 
 static struct ctl_table fs_stat_sysctls[] = {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 931076faadde..f8f983e5dde6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -90,6 +90,7 @@ extern void __init files_maxfiles_init(void);
 extern unsigned long get_max_files(void);
 extern unsigned int sysctl_nr_open;
 extern struct files_stat_struct files_stat;
+extern struct rw_semaphore file_number_sem;
 
 typedef __kernel_rwf_t rwf_t;
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index d8ce18368ab3..cf860d0e2c8b 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -951,18 +951,22 @@ int proc_douintvec_minmax(const struct ctl_table *table, int write,
 int proc_douintvec_nropen_minmax(const struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
+	int ret;
 	unsigned int file_max;
 	struct do_proc_douintvec_minmax_conv_param param = {
 		.min = (unsigned int *) table->extra1,
 		.max = (unsigned int *) table->extra2,
 	};
 
+	down_write(&file_number_sem);
 	file_max = min_t(unsigned int, files_stat.max_files,
 			*(unsigned int *)table->extra2);
 	if (write)
 		param.max = &file_max;
-	return do_proc_douintvec(table, write, buffer, lenp, ppos,
+	ret = do_proc_douintvec(table, write, buffer, lenp, ppos,
 				 do_proc_douintvec_minmax_conv, &param);
+	up_write(&file_number_sem);
+	return ret;
 }
 
 /**
@@ -1150,14 +1154,20 @@ int proc_doulongvec_minmax(const struct ctl_table *table, int write,
 int proc_doulongvec_maxfiles_minmax(const struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
+	int ret;
 	unsigned long *min = table->extra1;
 	unsigned long *max = table->extra2;
-	unsigned long nr_open = sysctl_nr_open;
+	unsigned long nr_open;
 
-	if (write)
+	down_write(&file_number_sem);
+	if (write) {
+		nr_open = sysctl_nr_open;
 		min = &nr_open;
-	return __do_proc_doulongvec_minmax(table->data, table, write,
+	}
+	ret = __do_proc_doulongvec_minmax(table->data, table, write,
 			buffer, lenp, ppos, 1l, 1l, min, max);
+	up_write(&file_number_sem);
+	return ret;
 }
 
 /**
-- 
2.41.1


