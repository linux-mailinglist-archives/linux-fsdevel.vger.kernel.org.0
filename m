Return-Path: <linux-fsdevel+bounces-33392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818C59B8898
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 02:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D2C2829C8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 01:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5E275809;
	Fri,  1 Nov 2024 01:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrzzFBns"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D6622318;
	Fri,  1 Nov 2024 01:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730425050; cv=none; b=ctP+Tw8tuCKOZBTbMtC9Jsg0jhjdrSUphLUpniZhM0mSkuxtnbl6a0zGD1huNdqzMf+mL7KFfFhR0WmU/uEtEgxR3MOmndbI16NER5nEqyxuZ3MjhaMvBLcirAaa7V2A7U+bJJc2CYp4W/PJABRZLEGPxsvyRXuO96JHK+uu4XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730425050; c=relaxed/simple;
	bh=D8MiN/KZJADEV5fUFXo9y71ewtg1mf1HWR/NiNxIxwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fbB02SEeZimxOwXdh/8Yl8SeHnd8F56l4JnluRB4cQ3T7ZbnywTHEK85XxlyU4A+8AarN0vT8djF8u+5wpq7Xi4zli5JhyPykOxB+h5Rx2HjkPl3Q6aNXXWezNiSXm+SsetxpZFNHvDkBqq6Nye7dD9utAq4HGFmMES26iJNTNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrzzFBns; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71ec997ad06so1240336b3a.3;
        Thu, 31 Oct 2024 18:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730425044; x=1731029844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9FFHCorsd27i7xjZdZ8bkwsKx5GCCI+P4Z2Pee224OM=;
        b=MrzzFBnsq40i+uXd3eOAq6iWk3jd04goWyMJ8covEYsB5XkkJCyMKM4l1Mbm+lgatE
         fjkF7NdyrVl+8sIq4rfcVMBsuG2JzFrsPfViSMGJ58yxgsAKlF3xlNUzRdHVGTSFwj9M
         nC/YOXNIMqwdIrTxLrpmgXJkxZjNEqfH0PsfWivy9omBmRP7TMVhnp8/wWA9CjF99ihO
         EfVICIbZJVSZZjvJSN/5inG3qhMft1knxTXd3ouM10EIZZ5bnFxcpqH6n2ONPpn89NaY
         CCc26s7hX/awLJ693g9MgPNipEty2eBROODpcRRkhONNtb7PcQQAgalJYl5ec8mHAPk7
         9hrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730425044; x=1731029844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9FFHCorsd27i7xjZdZ8bkwsKx5GCCI+P4Z2Pee224OM=;
        b=rodo14pOSaSW+tW4R3ez9ghwm+gNRsoEdBMjdFnv6GYSXKbxITXSyxd3ersouNm6iC
         j1IqVZdwpfomjq/7/+7FKD1NcEw+m4hcgN+/VXpQ2R1NnaNrhRJzzQYe8A8dC6eePAAg
         1ZYmULDHCj5y8pycYcaxTwq+Flpmg1YFbgAVr37I/YWgKl8amMMVrUtpwJCKcHsXjsLP
         w61RADW4BmvTTyT17Jv6TXUdp0x6UwvMMZE1nL5576Hq+mrHvPqG/s0+X+Y6Pkv0GEIn
         VZF2hcZeYNSVOU0QFixwrEE3OBm8uZU7s6ZcEuij5yD7QL4fyNs3uIlEKcEJZ+8WqYSM
         mgkA==
X-Forwarded-Encrypted: i=1; AJvYcCUj/atGl6JxsG/K5ZdP6y41fvmwQuUfFMk+zuCh9BKVauAIZ+i2P9XTSpCd/3DO4R7193tqmvFCWahxV8LN@vger.kernel.org, AJvYcCVAjH+4sxajJJD1MZo0JkCL+9pUe27XAV4JxxKxQE/3uBKEA0wtZLJezfWQg1B/SR2ADpdl6Id05/FZc5vM@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe9r8iVFLiDvGIuks50ez9aYdTSu9AeBcsnxrnzsd8xdY4/RBj
	tMZyTkw0Xr2LLAQJUN5WtSbUCZNbUQJrFm6ax2RHA7WrzSb9z/tg
X-Google-Smtp-Source: AGHT+IFZSrvUeoYN7irqFVuvD9v+lKuJUO5HFu6A3eE/DCPlL+EcSeHgU9zylt7Aesl5HOcmD2QL1A==
X-Received: by 2002:a05:6a00:2d95:b0:720:2eda:dfd1 with SMTP id d2e1a72fcca58-720ab492841mr11781853b3a.18.1730425044377;
        Thu, 31 Oct 2024 18:37:24 -0700 (PDT)
Received: from xqjcool.lan (d209-121-228-72.bchsia.telus.net. [209.121.228.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c3897sm1772048b3a.127.2024.10.31.18.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 18:37:23 -0700 (PDT)
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
Date: Thu, 31 Oct 2024 18:34:44 -0700
Message-ID: <20241101013444.28356-1-xqjcool@gmail.com>
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


