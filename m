Return-Path: <linux-fsdevel+bounces-13104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACC186B40A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 17:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E6C31C256C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 16:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386FF15D5C8;
	Wed, 28 Feb 2024 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDFdP1JM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3524615D5B9
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 16:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136147; cv=none; b=JUTc3onWhk2OaSQQR7NkKlIkbsmcuZyW7GCcZ7YY3dGS+9vGU+r/FRR/1rG+FlTq8b691qRiGiRsEB+A/qi379eOcPEEMr6EKB5sRNhAU5Osj4bGdl41aNG5YoSA61/tyx73PdlUV23ao/5K+GlNx2/aO88lxt7Lh2UtRKnDoeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136147; c=relaxed/simple;
	bh=TCHW8nniWCVaSjBjSAlAylrWTlDHg/Z7IwHcvKcnHHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJQYOeb7GftmZfaMbJlTwajaXRvHfwEaWKR5sgYgU/GPMaF4V6zzQHX0CjQskX7V3mP/nbOobuqpikrBw0G32Sn6iNpM+UjrJx7CyazP4dbng/0nt1rtsfwDPRfsVhFr263/40A4uUWtOQqmMe9seg593QFmFf5rFGoLDF6tCyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eDFdP1JM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709136144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=czKZlhI6mYWrYYIePiKqSQJGybasOe5lcTQz0bhQ7fs=;
	b=eDFdP1JMzJaaF6PP4iR5BWLpzJReTvMZcNvT8YSXj67EYWI8tKg8jxDgj54oekY5Q6XHpN
	jceSXR+XzvVDFurigR2Iuo653uuX47+0vgh5ef7QM9IAae0M3xNO9AMufXENvvKcubk/V8
	6Ge6YWZ7tZbSFsEuEfgQjIhO0cUpwmg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-tKOEEzpeMSaPzXwFkiI5rg-1; Wed, 28 Feb 2024 11:02:23 -0500
X-MC-Unique: tKOEEzpeMSaPzXwFkiI5rg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-565317b6490so2685278a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 08:02:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709136141; x=1709740941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czKZlhI6mYWrYYIePiKqSQJGybasOe5lcTQz0bhQ7fs=;
        b=HK4C3eByDcqQ1pK/algd0aXjy4CV8GX70D4Yt7LluJK59+OU4y7dxXQw+qYHcZxEtp
         TSZWNlW2IrHhxzmR5UH428UXRMZR8IKmc5zr2a+nxzpjE2gCZf1eCy38wgbAgLvbg8lt
         /FLk8CHQWJr3wU8VVo7D2Cf2FfLgPZ5EboKd5MISw3REbuork+pxgF/3nVgqy/ckQi+d
         /qs2tedrjmwvhYlPOo2KBloMuibBRGYdpkjeOMv/LnDeR/W8WXw52PP0Bcfx53xYo2YR
         xqBDCwuMyzRc3ursq85kchKmnKspSyz4nnfKjZh5z+wkgzxCnbi5+amZWdm1jZtOZNVk
         dZ0Q==
X-Gm-Message-State: AOJu0YwV9NcChWuyX+b42U6C2pCckqrFKG74sOFSQqjrQXgcB+Gw69vV
	CeT37PPjVvIHgtqvsMfgnALrtUP/YqsfNA+9DdEGcvvGBN0l9NEJyq3SPakUF/+raVdplcyPGic
	J38fBfBvYjgDToQb0lfwSaWuqyqG2dnmLU6450mBJc+2LLm3rPF1slqGM2CaXSKOoeDqVwVwafl
	D7QQ26+kjk7wQUHYTCAiIyfeTivep14xIYW787DNbgg3j6QB8=
X-Received: by 2002:aa7:c348:0:b0:566:1684:5037 with SMTP id j8-20020aa7c348000000b0056616845037mr5109135edr.17.1709136141052;
        Wed, 28 Feb 2024 08:02:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcC5RcVyEqEx26jzMgxPvBzJ+TmciqblhqUbm9uqRsHnK22ULH4l9jv24j2zrRZYcI24NnjQ==
X-Received: by 2002:aa7:c348:0:b0:566:1684:5037 with SMTP id j8-20020aa7c348000000b0056616845037mr5109119edr.17.1709136140759;
        Wed, 28 Feb 2024 08:02:20 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (fibhost-66-166-97.fibernet.hu. [85.66.166.97])
        by smtp.gmail.com with ESMTPSA id ij13-20020a056402158d00b00565ba75a739sm1867752edb.95.2024.02.28.08.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 08:02:19 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: 
Cc: linux-fsdevel@vger.kernel.org,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 4/4] fuse: use FUSE_ROOT_ID in fuse_get_root_inode()
Date: Wed, 28 Feb 2024 17:02:09 +0100
Message-ID: <20240228160213.1988854-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228160213.1988854-1-mszeredi@redhat.com>
References: <20240228160213.1988854-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

...when calling fuse_iget().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index aa0614e8791c..0a59062deb30 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -979,7 +979,7 @@ static struct inode *fuse_get_root_inode(struct super_block *sb, unsigned mode)
 	attr.mode = mode;
 	attr.ino = FUSE_ROOT_ID;
 	attr.nlink = 1;
-	return fuse_iget(sb, 1, 0, &attr, 0, 0);
+	return fuse_iget(sb, FUSE_ROOT_ID, 0, &attr, 0, 0);
 }
 
 struct fuse_inode_handle {
-- 
2.43.2


