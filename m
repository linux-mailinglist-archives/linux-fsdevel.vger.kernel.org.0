Return-Path: <linux-fsdevel+bounces-33397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 079AF9B88B0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 02:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CC94B21F17
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 01:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B9B80027;
	Fri,  1 Nov 2024 01:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjzI1Y7U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD8A3F9CC;
	Fri,  1 Nov 2024 01:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730425172; cv=none; b=i3I+wtW7HR1YWNjZ//A08cYL1jXc8vrVNFYtvfPLpW7SYLYryJSupu9HxyuFg+l6ApTUVxV6JumWeiViuP06GNjIy5xj3XMG/jLSfsxpF+1xrsq5krGYQ6BrSisYKNAknWV2MuGdgVk46C2jtqFpRvxrucTz6nSwPJR1tCIH//U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730425172; c=relaxed/simple;
	bh=D8MiN/KZJADEV5fUFXo9y71ewtg1mf1HWR/NiNxIxwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wsk5+R3sdDFg0f+XDHhZDIaZG3J9MZzXqVknX3350Xr1bgv6r/uaAyGkx0FbfsQAbMSmXLjWBZjtd+Uo8xsy/D6OhRcfsUffOiigileJ0YIDCKjTAj9EVefN3EM5QhCIe9GuAE4M0S4xY11/6vLqUeVnlWoWKAmVagXv8HDrS/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjzI1Y7U; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e3010478e6so1145630a91.1;
        Thu, 31 Oct 2024 18:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730425165; x=1731029965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9FFHCorsd27i7xjZdZ8bkwsKx5GCCI+P4Z2Pee224OM=;
        b=AjzI1Y7UW+SYKDFe6Uf3TqZj1FVsVAYAmRcbC7nCP2ERiuO3dyhps9V39i1Y6AJ48O
         QnIh/i/GotNiy3bT+rrK8jjJF5qos82DAvkgTm1b69UT85xtoucXafCQcEeqeadjECvz
         tRcI7yycYn0O3c4prS6HKgn2m343GVWe+pNKpaWfKR/mJRuBeREZgtC1EgKQX00X0vs8
         V4Kg7/H5awRR0B6VXp4kr3buGChEySZZlypO8Cm43O0Ceu+crc5pObcNNtN737xI/j3C
         S2IThzmDWleC4Cmp6oMSDZFWyT627AtCr53rI+Eo8+ediPTQxCQDp7XYXhVgzwDd1ydh
         oeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730425165; x=1731029965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9FFHCorsd27i7xjZdZ8bkwsKx5GCCI+P4Z2Pee224OM=;
        b=W7tNKdV4CimwUmcf/6jg4LJ59cfWysnR7jEzUXIzjVf/NlKUMjtIFsNCbcFW/e9oac
         Q03u2ZhNMWreiEKC/k5ecu5CyPv/cHrRCqKzGQ6KcyTvSbX8XXk0CkaJySIiJQCxuibU
         gG8jelyWWxcdMS8n7fbfH73/Whx5jOLpX9cnPzEljg1z6FJjT8m1SZrHXS7uGihq7FCp
         IV4jh6A7Hlwswwnr+yhbDaZ/mHDuZ3IsOpxZheSyr4t0cVQ+0i1pLg+eRsNU4041e2/t
         Bobsfu/lls7By2dAF2lUwqFs6NLm2q28R3NJrB5g1xPVYCAbJPtc08z7i7gl0ZGlsko3
         H1kA==
X-Forwarded-Encrypted: i=1; AJvYcCWt+lpYCi02LNf3GWlVMI+dcTEo2Ypv6hWuHHcdTPhtKe0KtkPnsmUBjK+/6eotTwlRkksC0je5IQsqaJA5@vger.kernel.org, AJvYcCX9z98VrtTAX5R7219Dl9U/t5CvpZ0DjwHJ6nyxrNmz/X3rYlX2sr9iG4nvQJZ+t7bfiVMWJEriDb9z/M82@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0zHo4zNxLWLt+IyCawHT+Vo+FkM4sWl7CN/NUqoe6zUrcG/h8
	nU3sueVcYO4rlTErNAa6AK2zYBlgjkdXkF61yrx1j3Q3k3EPNMWI
X-Google-Smtp-Source: AGHT+IFCEJNjZwm1qOmxWKm+Co6hGzWHRmIhT9mzcx0gTfNRnxvq9g9F6cdVIiccXXKItgrBb0x7Kg==
X-Received: by 2002:a17:90b:2786:b0:2e2:af04:8b64 with SMTP id 98e67ed59e1d1-2e94c29ea04mr2640610a91.7.1730425165285;
        Thu, 31 Oct 2024 18:39:25 -0700 (PDT)
Received: from xqjcool.lan (d209-121-228-72.bchsia.telus.net. [209.121.228.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fbe7119sm4002219a91.40.2024.10.31.18.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 18:39:24 -0700 (PDT)
From: Qingjie Xing <xqjcool@gmail.com>
To: christophe.jaillet@wanadoo.fr,
	willy@infradead.org,
	brauner@kernel.org,
	adobriyan@gmail.com,
	akpm@linux-foundation.org,
	xqjcool@gmail.com
Cc: viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] proc: Add a way to make proc files writable
Date: Thu, 31 Oct 2024 18:39:20 -0700
Message-ID: <20241101013920.28378-1-xqjcool@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide an extra function, proc_create_single_write_data() that
act like its non-write version but also set a write method in
the proc_dir_entry struct. Alse provide a macro
proc_create_single_write to reduces the boilerplate code in the callers.

Signed-off-by: Qingjie Xing <xqjcool@gmail.com>
---
 fs/proc/generic.c       | 18 ++++++++++++++++++
 include/linux/proc_fs.h |  8 +++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index dbe82cf23ee4..0f32a92195fc 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -641,6 +641,7 @@ static const struct proc_ops proc_single_ops = {
 	.proc_read_iter = seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
+	.proc_write	= proc_simple_write,
 };
 
 struct proc_dir_entry *proc_create_single_data(const char *name, umode_t mode,
@@ -658,6 +659,23 @@ struct proc_dir_entry *proc_create_single_data(const char *name, umode_t mode,
 }
 EXPORT_SYMBOL(proc_create_single_data);
 
+struct proc_dir_entry *proc_create_single_write_data(const char *name,
+		umode_t mode, struct proc_dir_entry *parent,
+		int (*show)(struct seq_file *, void *), proc_write_t write,
+		void *data)
+{
+	struct proc_dir_entry *p;
+
+	p = proc_create_reg(name, mode, &parent, data);
+	if (!p)
+		return NULL;
+	p->proc_ops = &proc_single_ops;
+	p->single_show = show;
+	p->write = write;
+	return proc_register(parent, p);
+}
+EXPORT_SYMBOL(proc_create_single_write_data);
+
 void proc_set_size(struct proc_dir_entry *de, loff_t size)
 {
 	de->size = size;
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 0b2a89854440..488d0b76a06f 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -102,7 +102,13 @@ struct proc_dir_entry *proc_create_single_data(const char *name, umode_t mode,
 		int (*show)(struct seq_file *, void *), void *data);
 #define proc_create_single(name, mode, parent, show) \
 	proc_create_single_data(name, mode, parent, show, NULL)
- 
+struct proc_dir_entry *proc_create_single_write_data(const char *name,
+		umode_t mode, struct proc_dir_entry *parent,
+		int (*show)(struct seq_file *, void *), proc_write_t write,
+		void *data);
+#define proc_create_single_write(name, mode, parent, show, write) \
+	proc_create_single_write_data(name, mode, parent, show, write, NULL)
+
 extern struct proc_dir_entry *proc_create_data(const char *, umode_t,
 					       struct proc_dir_entry *,
 					       const struct proc_ops *,
-- 
2.43.0


