Return-Path: <linux-fsdevel+bounces-8285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A20678323C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 04:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AD3CB223AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 03:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2544A0C;
	Fri, 19 Jan 2024 03:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gICT4nbM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A7B4689;
	Fri, 19 Jan 2024 03:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705635026; cv=none; b=Sq2P+glbAkqPi/aA64PjrH5nNWtExpmOh+coNAb6OgiGr1n6qiPgvcU4kSPkYgRHs7ApjQJrvIcozARbQhKpnBL9WtaNsrlEk3zRZOnEwRGnOxKIh0PTbpTwFqj/RinNYlEXTPAUNyQkzzOERZf/9I0shTv5Pd/BZsdKIY1pmkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705635026; c=relaxed/simple;
	bh=6uVWemlDtYvlezteOXZUIaD3rPg6lCbKvGRezvrDVgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NkNE9r4KuyBRR6dmhefADgdrQsSXGauasTJzq3Ps68toqNjGpOMDIIp3X03U8APTP/NM9Sils2pTycP6wLsjmGScr08AHCFlbCi/hOeAtyuqZ7YIbRVGyUtbjV9J8ERTbjKYYKIs48awRpsQrp2sgs6FyiK20uwZEZ8CPFoMC60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gICT4nbM; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-337cf4ac600so245557f8f.3;
        Thu, 18 Jan 2024 19:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705635023; x=1706239823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8PlDy6DohOlkWdet1eQDLhV72QW5bd7hQpgAlm4lFjA=;
        b=gICT4nbMdbT3MQ1a3317yA3pCimBDQEWr8NAdsbfLZXPnW7rL6JVRJXUwc44cn2b4d
         F1ox1OS/JrVgo0TbU6N1QdCjAbMlFaiPSUUl0RJyavG7WADhWS1Ga6tN4CiV9kpnpF/J
         sWy7j4jsMvKjREhERpHpUCQYVCl/gl/c6XVImOp7Phe45iDJFH+5172S9sTLp4RUcWxi
         Rvdf7afgwKXZovyOS6bC0/I3MyrysD4OlTtWI41uweVpONM6/xn8yw3gbzSaIR4H7CT7
         wZLLd+APOYR6iOoH5bzdkevuGigmH84+/HXu9U3Nz0HgNqXrABDzrMCGPoJEcdU1Abi2
         hNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705635023; x=1706239823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8PlDy6DohOlkWdet1eQDLhV72QW5bd7hQpgAlm4lFjA=;
        b=XxSYNVrbPCPUX7W6K/dTohJNCHV9SOREpjMSsJA60QlKNtc98kHhIQvgkwhBHW+nn/
         XfIKkrqmli1XHDbNtpBu44S5XuCgW6KY1Lj9N4xPGrWrT4pxLwh3O1Ils9o453JIN3tk
         rC97nNxVGiZQr+td3+5zDVNa+bUUNUv51kRzWiJRkJAWzqZYL0lFPgqqn+vIHKUeHv9w
         TvDL23ACUVAwHSg1mJ0Y20nBR1HAopY1qrcjPbmgn3l8HvNF7ccsMEq/vWqG1uUm0nH7
         csL1m3lxwel6WGxeJ6/L3EideQAVlV/AYwG6RinghyllHY25vP4s98+BCsj7uEL39AfA
         jmzw==
X-Gm-Message-State: AOJu0YzwSUC1o4N18iwFHENw9i4lxxUJ8bwOJF8bOgGWoJkUEH4buoQv
	nruac7oFMJE8U44qfsNrF92vnuji7qOamWxTU1wS2gfstednoYJBn9YIJaZckQkma2nS
X-Google-Smtp-Source: AGHT+IGuGFh49pMYFibk584khzy5gXCLh3YZ6EM7bTpa/I4xkl2iUZvu6aho4nZPHkAylDpMkKJM7g==
X-Received: by 2002:a5d:4489:0:b0:337:b479:8177 with SMTP id j9-20020a5d4489000000b00337b4798177mr885376wrq.123.1705635022775;
        Thu, 18 Jan 2024 19:30:22 -0800 (PST)
Received: from codespaces-9bcaa2.5l3qix2zsxyefcxo0oi5bwpr2d.zx.internal.cloudapp.net ([172.166.193.70])
        by smtp.gmail.com with ESMTPSA id n5-20020adff085000000b00337b47ae539sm5355244wro.42.2024.01.18.19.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 19:30:22 -0800 (PST)
From: Suyao Qian <qiansuyao@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Suyao Qian <qiansuyao@gmail.com>
Subject: [PATCH] proc: remove unnecessary comment since removal of no_llseek
Date: Fri, 19 Jan 2024 03:30:04 +0000
Message-ID: <20240119033004.52937-1-qiansuyao@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

proc_lseek of NULL is checked during proc_reg_open(). Hence no longer
mandatory.

Fixes: 3f61631d47f1 ("take care to handle NULL ->proc_lseek()")
Signed-off-by: Suyao Qian <qiansuyao@gmail.com>
---
 include/linux/proc_fs.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index de407e7c3b55..7ad73ed0cb8a 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -32,7 +32,6 @@ struct proc_ops {
 	ssize_t	(*proc_read)(struct file *, char __user *, size_t, loff_t *);
 	ssize_t (*proc_read_iter)(struct kiocb *, struct iov_iter *);
 	ssize_t	(*proc_write)(struct file *, const char __user *, size_t, loff_t *);
-	/* mandatory unless nonseekable_open() or equivalent is used */
 	loff_t	(*proc_lseek)(struct file *, loff_t, int);
 	int	(*proc_release)(struct inode *, struct file *);
 	__poll_t (*proc_poll)(struct file *, struct poll_table_struct *);
-- 
2.43.0


