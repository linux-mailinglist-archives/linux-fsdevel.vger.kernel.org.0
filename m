Return-Path: <linux-fsdevel+bounces-29302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870D1977DFF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 12:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16261C246B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 10:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005591D86CF;
	Fri, 13 Sep 2024 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmGa26lM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5511D58A8
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Sep 2024 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726224630; cv=none; b=lPYxEey6NmtHyGmjqgfrDGPiRq6ybmJQaHq67e+CzyAo48/uN5Ehv1fqvU+NvAgAwYnvQik6nzZ5UD+IczP0a3JIwRc7j/ReniHZoCcZZQPFO2pYvZoLtClBzeIiYhQVpAPQf2ruQFlcCWagfpn4MKmaSX53MP/cLAY92WfR/E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726224630; c=relaxed/simple;
	bh=rEEcsJ039eX41mzFLp5bdyuff8+mApDI/sRZfPUkZx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lR0oOZNPw1awwk5Xg4rhjCUUAkdeyg8+wGp6Kz+NLR9AX5ddE2XJrvHaehyg/oOMy7og2GS44ZwkNyiUoNp35xF/gvgsKcPtO6A0lsO+e0K/U/UhGR0ORgVHzOmWt3pgtoj7ePPOIK+dHHU5RAQQSU+dDvZ6SmbhuRZwr9p6xL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UmGa26lM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726224627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z7bETkgUI//Sz6YDEQxAli6k+5RVj6aOL7WAEo2V3co=;
	b=UmGa26lMX0TGXi/vHHPKEcPs/Tsd/x9dXc3sK/sJr8u+TAMuJ2b15TlRcDcny02pYLmYsm
	+8QYVvo4s40LOZNPiGAIDycpcgLJein7GrbRwxNMzJ53D4+MhyMys0vz9UHnMsfhYZXAQk
	1h5og0qRU9BrdLn4djlPZ1A1+kSf3jo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-_ir7OUJQMnyS3YAqXUBdDg-1; Fri, 13 Sep 2024 06:50:26 -0400
X-MC-Unique: _ir7OUJQMnyS3YAqXUBdDg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb808e9fcso5383005e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Sep 2024 03:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726224625; x=1726829425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z7bETkgUI//Sz6YDEQxAli6k+5RVj6aOL7WAEo2V3co=;
        b=RJrsDNtS6FMppKvmrorrk3HSeVn2F+4tOF1+8FuDMZ3a2IemMM6nMXEZnb6yqQqRT0
         2ou7knwRhUG0s7y5aUXGReySvnn4VBrlCOq4oSHw4a11cj9/qPOu1L60ENnjMbKtKJoZ
         DM8IMLHHDUvXQRfsbTj3tI1iq9VJcDdzOFyi9lCTobITtKceXDHBI1EkvPOQxQMk2AaO
         KqgrlCA/cIRY3LxJkis0MrRaoJqyW3+6F/6Kw+gGh+JYF8W2V4VUpbvw3HPX4/5g17AC
         4sPvHQ78/NXZL+D9XOkMADxrttyhssfZYLPZULlVGsxtSudTGAEhEe2y5ekX2sCVNdjR
         YcDA==
X-Gm-Message-State: AOJu0Yy3CUHDP7e0UOyGPj86FG1f7ETqZdzhU4VMtIOcbt7niIyKaTKN
	syN3f9TC7t7t9dM0n4f+zNcCRE8MOqGgpAdkTB19QFXOFDg7zuh0Q6t2ztfbv1z/bB9WAgvEy3y
	UcvXlAXszOvChltX1+EDzeD6qQ6wrI8NzyPnYcl0LgHi1oCirSwsGUIGp9qXqzvOtMdyhugrGjj
	DabicK06M036QwePpxzqmHdjc3zRJEbtOgcjeD5hUZWluNz4U=
X-Received: by 2002:a05:600c:1e1e:b0:426:6f27:379a with SMTP id 5b1f17b1804b1-42d9081b3c0mr20403795e9.13.1726224624807;
        Fri, 13 Sep 2024 03:50:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTYcqH4xQ/RCyGL6dmpQRu6Qiu092aOj+m2lkGstgqmc8FBiw6z+c8a3T97hpitF0VhMdTYA==
X-Received: by 2002:a05:600c:1e1e:b0:426:6f27:379a with SMTP id 5b1f17b1804b1-42d9081b3c0mr20403595e9.13.1726224624194;
        Fri, 13 Sep 2024 03:50:24 -0700 (PDT)
Received: from maszat.com (85-66-37-25.pool.digikabel.hu. [85.66.37.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc1375189sm119797665e9.1.2024.09.13.03.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 03:50:23 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH] fuse: allow O_PATH fd for FUSE_DEV_IOC_BACKING_OPEN
Date: Fri, 13 Sep 2024 12:47:01 +0200
Message-ID: <20240913104703.1673180-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only f_path is used from backing files registered with
FUSE_DEV_IOC_BACKING_OPEN, so it makes sense to allow O_PATH descriptors.

O_PATH files have an empty f_op, so don't check read_iter/write_iter.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/passthrough.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 9666d13884ce..ba3207f6c4ce 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -228,15 +228,11 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 	if (map->flags || map->padding)
 		goto out;
 
-	file = fget(map->fd);
+	file = fget_raw(map->fd);
 	res = -EBADF;
 	if (!file)
 		goto out;
 
-	res = -EOPNOTSUPP;
-	if (!file->f_op->read_iter || !file->f_op->write_iter)
-		goto out_fput;
-
 	backing_sb = file_inode(file)->i_sb;
 	res = -ELOOP;
 	if (backing_sb->s_stack_depth >= fc->max_stack_depth)
-- 
2.46.0


