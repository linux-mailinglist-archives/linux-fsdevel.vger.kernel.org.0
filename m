Return-Path: <linux-fsdevel+bounces-44945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B04DBA6EE28
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 11:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D05F1890FB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 10:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE46254B12;
	Tue, 25 Mar 2025 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lfu6v6mh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB617254AF8
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 10:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899607; cv=none; b=Z+oCptuuJ88Pv+QpooQ3PF8Tg8bj0qayR9vb4wOS7cBIq+cc7HwgFdo7gxchkg80yNBh1pXRCh3FV2Hap7FvRncKUI7EXFDIMawDWlm55X4CrJPFUSqoxKCIGXVex53G+00wq9Qya8g+5ww2MdP4op62mRYV3JR6n6TRT2uyWbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899607; c=relaxed/simple;
	bh=BkHIWKTP9JRXYjCX+MS6IytA1TJGjHbxJmx3B3dQ84k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFEz7ae0m1nP7AqCqznyQqExYQxIFFUV/YUFq9AhYOImEXgByaai8opksj8ajNEqM8Exu+i1d7o5NBXS3kuibkrq7YyuBvM8jbNEmx1br6CocfeJlkF9Nkk6oYvH4LAeDReS+DrYZF+IXiceXSwtYOyNvcmxQO8U3T2sFkrLit4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lfu6v6mh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742899603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WidvnqpHK1LBXH72ChmjyjnYZOjoCQtbOYDynNLa4zo=;
	b=Lfu6v6mh7bv/nx8/0JhAFaddosJ8BQzZi8qRHZcm2/vPzwK7F3Rk5yvhc3Aa8byaKnopvi
	LQ6FD3PFaWEDl0H0HzXl9UqsSJ6l3E/alr0WsqL2kNlY3unXnmGJq7hsfbOuNFL8o1vTv2
	OXfghcmXP8Hm+Es921HxTGXDyBk8k40=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-upThAIW4OVmOHxqjqPgvTA-1; Tue, 25 Mar 2025 06:46:42 -0400
X-MC-Unique: upThAIW4OVmOHxqjqPgvTA-1
X-Mimecast-MFC-AGG-ID: upThAIW4OVmOHxqjqPgvTA_1742899601
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-391315098b2so2132521f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 03:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742899601; x=1743504401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WidvnqpHK1LBXH72ChmjyjnYZOjoCQtbOYDynNLa4zo=;
        b=QC2iUYd0886nT6zeezX3SCboIoZMi4UBj0TgtDy0qQoaEgETCNfylF0vPLQiWkUAmw
         2lKkyS2k8r4t/erfFHpJLh7V1jIGLVQUFZpl6z8zrg+0gX2xfy0sst8uIBWa8g0UatvM
         sGIcETc96HeDsCrHPR5oX4LCGQwURAsJzmpDnL4835Uf+gSKY3ELr9b1OhRoHSErWrXK
         6bDMxNXRmP6KdJZ77dpdARqj1KP/nhiFFS9CbRY9d3uOQ/MXc0cgitcJ1VsYC5ugDJgc
         61o+mzUrTrhfsxt9zzhsby1Il3MNsczuWrTmLh4bNfZvQFJFU23pi6PP2b4TIVVzyux4
         /iPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu6luz490C5YwVKAcN2Z2F2C8JmXPZXvdQQ8PBc5HsfPYSRI4P3FNcb6T+GYmK1oeiQLyKNIRoxGVKwrVp@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ1PJLLAm1qg/+yMLzBGGSs2Rezezq5C17btqJY5TKIWRQq18e
	kHW+jzJsgfBh32PcNwrts5QFEZeK7fIJhw/bsh0IjK7/5mQ/gUIlCA3vP64XIOl8sZ/TYGFyRcT
	o5bHm1CmUW0momhNILedyDcyoHPSJkPa4LLpivj/noyBEg5UE/UeH1berPW2CCKo=
X-Gm-Gg: ASbGncvIp+nQRBimshgy1z1jLtQ3X8Y7BPvBYxOSjRaOdl5fp3dZgzA0dtrr5F/fOO/
	HHa1zuZqjicrJhvSt6B0ja4YKqjUp0xOjNahBEnwZ9XFhY5z6nl0QO1guGpL0bTeuCZ04NBHPUv
	JqAjYmFJhb2WiDw9QNxdC7HftBUm5MvmBX7i7WqTbDxpelVMIxOoKaIqvsW+HbfusctQ1faKLbp
	8XH4iNW/1KOoJ7Xx6sV+9jyRjXWBdkUFc/r4y0BEQzOBG+OUGjBFqu8tRXmKtZPjcke558R7rJd
	cMeui2PiZohw2YISPYd0gB/hwHKrLxFJYkW4GkrhfiJEDyEE7uYOwcm7E1h23GO+8tw=
X-Received: by 2002:a5d:588e:0:b0:38f:5057:5810 with SMTP id ffacd0b85a97d-3997f908f1fmr15015019f8f.25.1742899601424;
        Tue, 25 Mar 2025 03:46:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOqzs/UB9hDXfXqPQHH68eV/UQBGIP2lwnTzM8ArMxc4vQh3QnISBv6xLSA0bOPMzdEOH4ug==
X-Received: by 2002:a5d:588e:0:b0:38f:5057:5810 with SMTP id ffacd0b85a97d-3997f908f1fmr15014989f8f.25.1742899601049;
        Tue, 25 Mar 2025 03:46:41 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (87-97-53-119.pool.digikabel.hu. [87.97.53.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a50c1sm13572203f8f.38.2025.03.25.03.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 03:46:40 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	Giuseppe Scrivano <gscrivan@redhat.com>,
	Alexander Larsson <alexl@redhat.com>
Subject: [PATCH v2 5/5] ovl: don't require "metacopy=on" for "verity"
Date: Tue, 25 Mar 2025 11:46:33 +0100
Message-ID: <20250325104634.162496-6-mszeredi@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325104634.162496-1-mszeredi@redhat.com>
References: <20250325104634.162496-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the "verity" mount option to be used with "userxattr" data-only
layer(s).

Previous patches made sure that with "userxattr" metacopy only works in the
lower -> data scenario.

In this scenario the lower (metadata) layer must be secured against
tampering, in which case the verity checksums contained in this layer can
ensure integrity of data even in the case of an untrusted data layer.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/params.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 54468b2b0fba..8ac0997dca13 100644
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
-- 
2.49.0


