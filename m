Return-Path: <linux-fsdevel+bounces-41450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF87A2F949
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 20:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74592188A27F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 19:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D5E24E4A3;
	Mon, 10 Feb 2025 19:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFSjluhs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E30A24E4A6
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 19:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216724; cv=none; b=FXomI2LgRjyanEL4s106f2I26PeuM2m1nmPI0NEKOka29GxIdBBvYZi0Czr9C2ZA0cWZvWoGlqn/AtYDIjpYWFmAz9B/V2zkqc9aTxT4sJ1hQo7ABJLibh2/C6klQjcD3rXVhHvvNmtkBUC9dbfCrQMzxh3/lphptuF82wGlq+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216724; c=relaxed/simple;
	bh=YmxZVquIfuzN0yi8pIPoqE/kuWCEjwQIrkVF8kUQOhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gs1d8YLinume8awFz3daTp6rm4+y6VHeB7xGVjmXTTrzI9tZLpTsoqTRRHrjGAj+oEBF2ptL7Z/h/t8kMfsOx+5OUwyKQ2qLUWEzHYXDRayE5hZv8UxjGy1mps0XPk71O1qkZBOSF24WVYW58VD/EaGWFekhqcEh0sv7yXmCflk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YFSjluhs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739216722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=syWQXAn3cOmG6FhmrbnuZsvrrh5ERmXR+dINB6h2IWY=;
	b=YFSjluhs7fnFDqdzVdL79k9lFBEDmZwoKHNDyLPORVB6LYhKUQrQrf4SeMTK6fVQA4A6ti
	y48xOVkPRR8K3IfKBafQg6TgWGuq2VC2Vuv2SO7qUZCGSfP7I37F6J1jCk48Vot9WV9LGB
	7Ybw419ib9bZipGfOv8rtDr1saEJ3Uc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-MTz3TJE4NQ6WYoTjABNTMQ-1; Mon, 10 Feb 2025 14:45:20 -0500
X-MC-Unique: MTz3TJE4NQ6WYoTjABNTMQ-1
X-Mimecast-MFC-AGG-ID: MTz3TJE4NQ6WYoTjABNTMQ
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5de623ada8cso1503794a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 11:45:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216719; x=1739821519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=syWQXAn3cOmG6FhmrbnuZsvrrh5ERmXR+dINB6h2IWY=;
        b=R4j0M8VbRC1VliHeXlYJnDg+m2B5++TZ3Z9oai8nJ+NfgXIiaeimCDekor3DPJxg2g
         XEJ5n0JnOhW87jYkdqXkMeeTKqcX7HK9iB/NpBvwYP8z5+zO2phVCYEf0ZXlbJbvGtj5
         eCBIJS1w/7IqchTcEYnULDMQIp29AbEgXiU5bRqoGgv51jZF77L8P/AOX5swTITYfF7r
         5Tky/TP20t3z/QHgZBd4ZVTsKIw2k1NSVYEYUpwHhppUeBmEK/se4JFtcIexMTXu5g3U
         wlgg4V3OeOqbgpchPcasfyHF1HUL3wNRFi2xH6EAIohkNJ7ePTI94PeyrhX3crG8G90R
         X3SQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh5CnwGDv4c7NUjvr0kUCeBT7RPI4PBZoshdxD+Eek0vDXhxTXAcn/rFDF5Y13RuuQtboEasUbzCrZ8etO@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz4bHf03j5qsiYHiH36slm2uEC0yCgoF/8t2t/IiDyyw6HriYE
	KJYOMbiRGs066fzZfxp3RrMFEYINYcBIa75tz0FjbYcA5MM0xxqviKdLOmCgqRxZWtPrpUMkfmV
	WKXJirzCPLL/g96TfqJLk/dyvsUJ61CpisqneV0sptHFmwHMCyRhtc7rwmG5H8+LsNvQKYWpC+g
	==
X-Gm-Gg: ASbGncuJpBQmL6/skTKGcxNadXweGP5ZAz15IQ73Qsv4FoXqJsfhg6p5MNhW2oXe3Dx
	l4OKlEXlyEcaYUvsqPoTelAYszPWKz6wmthTmid64hwV2RQECcfSEL2yVfFz+Wdf8nZV21vvLIG
	C3/5Lh9UoVOsP3Lb3Lpe+e7qfTphvjJJfZVlzeLnaYRNUht6Lvp6o7BWHEkB29dY/1BlP81LhWP
	ByFpc3RL4g9qztCiTzaNTRqB5BH4joOWd7uBxa1GiOmpbPCyzqj6Q29vFJ6NlVR4ubTh4Q+XjOH
	Z8K301Vl0d27A4GiHRh/2iXPjaSTsl0awVW2JWorE3N+fAWLLI/seA==
X-Received: by 2002:a17:907:94d5:b0:ab7:6c50:5f19 with SMTP id a640c23a62f3a-ab789aed850mr1685234766b.31.1739216719223;
        Mon, 10 Feb 2025 11:45:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTh1rYRjxqc9Hckzii4MFPMys+FRZP22pUg+8f92LmqHsvmatwOVrUh70dujPwDuo2gFVTqw==
X-Received: by 2002:a17:907:94d5:b0:ab7:6c50:5f19 with SMTP id a640c23a62f3a-ab789aed850mr1685233166b.31.1739216718890;
        Mon, 10 Feb 2025 11:45:18 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (84-236-3-29.pool.digikabel.hu. [84.236.3.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7922efbb7sm702006666b.2.2025.02.10.11.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 11:45:18 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/5] ovl: don't require "metacopy=on" for "verity"
Date: Mon, 10 Feb 2025 20:45:09 +0100
Message-ID: <20250210194512.417339-5-mszeredi@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210194512.417339-1-mszeredi@redhat.com>
References: <20250210194512.417339-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the "verity" mount option to be used with "userxattr" data-only
layer(s).

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/params.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 54468b2b0fba..7300ed904e6d 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -846,8 +846,8 @@ int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
 		config->uuid = OVL_UUID_NULL;
 	}
 
-	/* Resolve verity -> metacopy dependency */
-	if (config->verity_mode && !config->metacopy) {
+	/* Resolve verity -> metacopy dependency (unless used with userxattr) */
+	if (config->verity_mode && !config->metacopy && !config->userxattr) {
 		/* Don't allow explicit specified conflicting combinations */
 		if (set.metacopy) {
 			pr_err("conflicting options: metacopy=off,verity=%s\n",
@@ -945,7 +945,7 @@ int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
 	}
 
 
-	/* Resolve userxattr -> !redirect && !metacopy && !verity dependency */
+	/* Resolve userxattr -> !redirect && !metacopy dependency */
 	if (config->userxattr) {
 		if (set.redirect &&
 		    config->redirect_mode != OVL_REDIRECT_NOFOLLOW) {
@@ -957,11 +957,6 @@ int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
 			pr_err("conflicting options: userxattr,metacopy=on\n");
 			return -EINVAL;
 		}
-		if (config->verity_mode) {
-			pr_err("conflicting options: userxattr,verity=%s\n",
-			       ovl_verity_mode(config));
-			return -EINVAL;
-		}
 		/*
 		 * Silently disable default setting of redirect and metacopy.
 		 * This shall be the default in the future as well: these
@@ -986,10 +981,6 @@ int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
 			pr_err("metacopy requires permission to access trusted xattrs\n");
 			return -EPERM;
 		}
-		if (config->verity_mode) {
-			pr_err("verity requires permission to access trusted xattrs\n");
-			return -EPERM;
-		}
 		if (ctx->nr_data > 0) {
 			pr_err("lower data-only dirs require permission to access trusted xattrs\n");
 			return -EPERM;
-- 
2.48.1


