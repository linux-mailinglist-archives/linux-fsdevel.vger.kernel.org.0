Return-Path: <linux-fsdevel+bounces-9425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF43184117C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 19:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E79B1C24AAF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 18:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48D26F07E;
	Mon, 29 Jan 2024 18:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="AeVofTpH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12EF3F9DF
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 18:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551241; cv=none; b=YU6kZxsdNROVNRcDLCGeCYtilTuGu+d1UKNgQfjKoXjdF9BOjJulAgz1vIHSGaSpSw7MxOVRLszhZX+lATIR9znnUUOvYZQNS//Gl10HFu4prZKOzBIPNg0lCTYG//9BVL7M6qz1dYYycR41AY+aJzibimUCIacmlkUXg4uCDpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551241; c=relaxed/simple;
	bh=+2/eN+UB7DM5N4Kf88sZcovmSGYJHUxZ8t0rDt3dSZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mY2KtIql5484ECpZg3heX3Mj75GrQVfwNsev/hbfJUX3o4NDeqkQFJNHtOUGqB3pseqmokhT5AIvbl7lEfCeLOL09YwbpDmnDk0Qpb7JzcjFuCc8lh9Qebo2jJfajJPl7s/8Qauo6x7Gqd2iDX00vqF5ODGQMsAm55NAvpsuyWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=AeVofTpH; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 20EC53F131
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 18:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1706551237;
	bh=z/8e33kWm7ly4Fe64ik4Gfk0k1+G3TvDCuRamGvQ+i8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=AeVofTpHTV1TUeYBpnkSbRp8FxxiRiG+K0ryH7x0jN7ES8JbRsL4Ke2pMqJ3Jencm
	 Dvtj3Fi7j6KDl5PLmQwB9iB2i2emxPwA8hy8PO+lM1b8oaXu7xHXRe8vaorUoDEeDh
	 9s2XlgKv9hb7OHNdBcJmHHu/7ViMp0/hkvLDJCIIRABBnhJiyQzIc9S5kBmBvfZs8h
	 O+Aq+X4FiZvH2g9UEq9ofJ72IzPcWCO+pLftSZ7cdG3GkueUyg9qbsjjU4pm1UCrgf
	 WunUV8FNpH1Kv/SOejfgFlKsoecRdee9qajAZgXj5oh9Ug7uaEkrXz7oxODgaYg5fm
	 biablW40YWNDA==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a35247a5d8cso188059366b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 10:00:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551235; x=1707156035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/8e33kWm7ly4Fe64ik4Gfk0k1+G3TvDCuRamGvQ+i8=;
        b=vTFeSMmhGwZHx9/83qD3DTJDou2ZV9UCDB5GEPKgpTmYmIdTIcaq+Ji/yNkdXW8E/2
         91rnWDuQdjt/TJO8wbxZM5mze7GHb02Ze6bPR+S3o0/YCgWA8QaPlo2CxFlsM1z8CUl0
         Qfb6kbzgoR81gAq/2YWEmZgMo2OWgw2tGVi9MJJCNAJNPSHc0RIOGs4EET5OBZc96o1o
         ROrI9VCyxPKEVAznWZV/j2lp7jQw1n14+bdOO9gJC4AnMPei/BTrbBXTnpSEJVxwlnxV
         nAiZEvvlbNkGZY7kK+ATxjFh7ut1q0ll+gyNC8rJMOCznhDT4XKZiqb7AP4hRVtV7peL
         gF5g==
X-Gm-Message-State: AOJu0YyZZlDjaCAScA7VyXE6UWQ/Bzqe3+fYip8pNfFUyUOK9vTYbUcm
	xVrvagdxoWlY+oByhjaAIAsIdkcZ/NyD+ajnFvzJ1wlicv9EVGvWk4Y5HqqxpyMaV3g1rjfvxGF
	ycAFOcZ+jXiK6pESZr60d8p19XuCMJpA0Ri65s0/DyMd7RCV6w0MSMgpYuSAN3S91P2sk3ssYtg
	AbzeAiGZxwVLU=
X-Received: by 2002:a17:906:480f:b0:a35:91dd:b824 with SMTP id w15-20020a170906480f00b00a3591ddb824mr3549745ejq.56.1706551235615;
        Mon, 29 Jan 2024 10:00:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjepICdEjZ9sgpgf/utgdmkB4ffLgrf/oOsuPIdoXPCQXZXk/cnB662HBR3ndXC7rEEqGFOQ==
X-Received: by 2002:a17:906:480f:b0:a35:91dd:b824 with SMTP id w15-20020a170906480f00b00a3591ddb824mr3549738ejq.56.1706551235336;
        Mon, 29 Jan 2024 10:00:35 -0800 (PST)
Received: from localhost.localdomain ([91.64.72.41])
        by smtp.gmail.com with ESMTPSA id un8-20020a170907cb8800b00a2fb9c0337esm4147500ejc.112.2024.01.29.10.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 10:00:34 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: brauner@kernel.org
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] io_uring: use file_mnt_idmap helper
Date: Mon, 29 Jan 2024 19:00:24 +0100
Message-Id: <20240129180024.219766-2-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129180024.219766-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240129180024.219766-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's use file_mnt_idmap() as we do that across the tree.

No functional impact.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>
Cc: <io-uring@vger.kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 io_uring/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/xattr.c b/io_uring/xattr.c
index e1c810e0b85a..44905b82eea8 100644
--- a/io_uring/xattr.c
+++ b/io_uring/xattr.c
@@ -112,7 +112,7 @@ int io_fgetxattr(struct io_kiocb *req, unsigned int issue_flags)
 
 	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
 
-	ret = do_getxattr(mnt_idmap(req->file->f_path.mnt),
+	ret = do_getxattr(file_mnt_idmap(req->file),
 			req->file->f_path.dentry,
 			&ix->ctx);
 
-- 
2.34.1


