Return-Path: <linux-fsdevel+bounces-45280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D2DA757B4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 20:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154FF165C72
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 19:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261921DF728;
	Sat, 29 Mar 2025 19:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8g1lElf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E401DFFD;
	Sat, 29 Mar 2025 19:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743276518; cv=none; b=EUMt8tuXGj8PCh0OUUwL8cZoJyM1SC5uumk/6HZOWaPlqEDxSj5dDrY2DxMNKDxYhgTOpo1xLUkH6NLRiUi7SL6LCqTbieZ0PWFxs1iyBmWYzjsJ9b0XiIvSwV4CmMSBUHIv5wVZkSfz0DjeGOp7qcjr42OzgGA+vMV/0TLI00o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743276518; c=relaxed/simple;
	bh=++S7QQTwaH4YhI6Wvp+IqM6/HcddEcjmU81sR/PWQL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjXs3Fn/pUJ4EGageR/xqLbo+M1OnouN8R1y1JTWXM6faqGknsdQaVYOTW3fwbmHQoG/AsqMuUE5FlAsAYJ4zvDHij/Tywh3pTq0x+/XJrZunl3xtZURHZyxz0X06mdvoSZr4oYwZDZ0tVUCm9x2Sb9YHGjKty7jHRoFvcLs8PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8g1lElf; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39c13fa05ebso180440f8f.0;
        Sat, 29 Mar 2025 12:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743276515; x=1743881315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvAkmVV9tm09uIJej0UQSMOp7YUz6NyWFznc1x/nc9E=;
        b=a8g1lElfunW6lgbnh+wu+1UxoENRp4I1Uj32kctScOpN2MLWFFaM2oh9HjiQlNw9Wd
         Hwd4NzpkRcv6L2sPocubFKvFYdxRDCvtnjGaupXgYjDe9zSXBT/e6obIoMifG5ew1/B1
         FzRjMbDKxyXnn5P7Ao39CyuiTolsFzZvvR5fsE0wtIVaDeQz5K85iYnplWy6arxOHkUm
         aM96dA/+IQ3YyGPt/8wBNw244huQRPuHOmXumQGja24xI27PIZfEAncMI3khi+RK87tb
         BItuAmiXTGiJ/Iu7knNwCeicPwcxk3JDosIjVopjVcGqNzWiHiKuBvCA7Qoy05jfaRE2
         NIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743276515; x=1743881315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvAkmVV9tm09uIJej0UQSMOp7YUz6NyWFznc1x/nc9E=;
        b=vMB7b3lISqraroD/h/4/Ss0AeHVA/LjnZCZYYTU7NvXFlpHPbJ9lOFVw1Zmwkge/W3
         R2QMG6Xd4dEhcHtLXKv5ljt9OQQKUvEVrrIVYPA8BIxeLRUu0oDWnjsH7dYCmTKFTHpD
         l5mz83HlVsP5CcAVOlm0VGyHvV6SfcaQMic/EK9VIX6MCEBg+NMsis4vAcZRUPLaG++y
         GB1p0hb9izmFJmgma0YfJ3G+Rnarnk9VvIRlL2xV6JTMAQsK05b7n4kmiGHK4C1Uvtve
         0iOYYRZUX0uqRRCNp/77ebZow7yHKAKVz3a9FjH93c0LbzQfllfCGajX268G19z1WSs3
         Kjrg==
X-Forwarded-Encrypted: i=1; AJvYcCWG672IDCrFK0aZxx/moybBnAZkUMvz5ksE7eQyc5HhcLsP/a7mIMmq/XJ42x9o5c0Pk3detANF4drbgtpW@vger.kernel.org, AJvYcCWHiwhA5RV55DNxF44xk471Ja7nN3MkM0MreQBIrMdv5BvgiC7ErT17JJD+md2mXSiMhyeW4HlBj1rWRNay@vger.kernel.org
X-Gm-Message-State: AOJu0YyD5F8P8juJeXuY3x9IYogwbc491LUX0PHg3WFhZHLu38+AbrlP
	1vLx3mwk9loBEFE0UaX7lEo/u7pwFtutLkzsxIhO76IED3l09Nlt
X-Gm-Gg: ASbGncvC5cig0+1Lg9N3DmnzBbuTioJAifuJzQGsfflmQxNv+qd/RLjl2To83KYkJbc
	IBaz83+RPUgubkHDRg4mNP05HDrJCx47Tvmo8x7yNFzw5sD0eD8lpp4V0NuxcNfRHclD7VLYWkO
	nSlt6jI3jjYcyX/t266zkfnKSSWkQN3DrgV3mhWD78ubeYW5TPDbbX30ekQn8sQBdBnpv9zu7V2
	nveMAsk2Yp77qsFn946YzQd0fqVpAMJCwy1nx55/Jq/3C7ggV4Af8n5p1e0GLQSK1Gv2ZWSFof5
	Wf52A3nj/+b64+G5svztzXT+3OGQNC3Hv4WuM8+YnhHh2xGZA31qVzTxJ0A9
X-Google-Smtp-Source: AGHT+IF6jKgNsXS+1Lh91/3+sKWhlighE7/PsHDc9tYpPIxHV46U6ToM64y1C1jPf9SQfL4AsWlKiw==
X-Received: by 2002:a5d:6d8d:0:b0:39a:ca04:3dff with SMTP id ffacd0b85a97d-39c1211805dmr2687659f8f.40.1743276514967;
        Sat, 29 Mar 2025 12:28:34 -0700 (PDT)
Received: from f.. (cst-prg-15-56.cust.vodafone.cz. [46.135.15.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b79e141sm6553400f8f.77.2025.03.29.12.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 12:28:34 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 1/2] proc: add a helper for marking files as permanent by external consumers
Date: Sat, 29 Mar 2025 20:28:20 +0100
Message-ID: <20250329192821.822253-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250329192821.822253-1-mjguzik@gmail.com>
References: <20250329192821.822253-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This avoids refing trips on use, added with VFS in mind but should be
helpful elsewhere as well.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/proc/generic.c       | 6 ++++++
 include/linux/proc_fs.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index a3e22803cddf..ae86554bb271 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -668,6 +668,12 @@ struct proc_dir_entry *proc_create_single_data(const char *name, umode_t mode,
 }
 EXPORT_SYMBOL(proc_create_single_data);
 
+void proc_make_permanent(struct proc_dir_entry *de)
+{
+	pde_make_permanent(de);
+}
+EXPORT_SYMBOL(proc_make_permanent);
+
 void proc_set_size(struct proc_dir_entry *de, loff_t size)
 {
 	de->size = size;
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index ea62201c74c4..0b6fcef4099a 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -105,6 +105,7 @@ struct proc_dir_entry *proc_create_single_data(const char *name, umode_t mode,
 		int (*show)(struct seq_file *, void *), void *data);
 #define proc_create_single(name, mode, parent, show) \
 	proc_create_single_data(name, mode, parent, show, NULL)
+void proc_make_permanent(struct proc_dir_entry *);
  
 extern struct proc_dir_entry *proc_create_data(const char *, umode_t,
 					       struct proc_dir_entry *,
-- 
2.43.0


