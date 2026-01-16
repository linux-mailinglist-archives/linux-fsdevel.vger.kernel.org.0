Return-Path: <linux-fsdevel+bounces-74263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BBCD38A26
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 00:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0B3B3026FCF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 23:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5B8322B90;
	Fri, 16 Jan 2026 23:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lI7zXNQq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8949315775
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 23:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768606291; cv=none; b=noETdbRb5nWbU8GyHIwl1UbJrNEG3iP2fS23VC3N6r7ueGBgAB1lqVz7r8NrLF51TNsGJhbb/PeXID+MOD10WabOgBD3OJHBxvsy2M6kyRQ+evVHtD1i4ZjkobojYXZyKUMqEaNTMaTetbPV/eXgmflWe94ny/KPZi+W27UbHWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768606291; c=relaxed/simple;
	bh=F+kZeMexWtQKde2dJlSnSScoagreLhL3Ac0mm4y6W5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gl9h3efuZNAXKW40QXQKoXe/wHRJPaO1ATyacmrpLrwyVdNEQOBX9JjtLepllgyyb2lpd4o6jFMCRzvz1e081/Ds/dXR2oas388fLBOe1BsNLVW/6AY+Hdv3Fu3nCqmE8ietW6GgFLZpCBsT6fYRovaxsr5C3luTlKjC4BlDlpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lI7zXNQq; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-81f46b5e2ccso1485963b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 15:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768606289; x=1769211089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWu0xJoZ2lXzLlzZvtC7iw+OrNL48tfG2EiEU6ep6XM=;
        b=lI7zXNQq2RG4P57vgTj2RIUV0ihfl2tZ6Yst3w8wXJ5tX+nPwe3dNuKye1KT8LWO1P
         W3TVGen1k7U4crAJ+sQXRa3MeseQdJHLEkYkRah0LelFJnzVQ8wzsC4tm3BRoSJWWHPw
         G/apRASfN0P7iJT56pFj7db4yfg/noGG4jAzEjuN5IxtUm4mWmggR65zVMZNP2XZwYoU
         /rLzubDLxFwyMurICg6a5D1/1VAxO+pN0b1/Y3mMieYAwIf5r4THkEefuZtTUeScP1eX
         pj5OPueiK2B82PHYlWuOMt3qyG5verBCviU3QtOe5qFXJ0xrG3fu+U7dvHUPYXptfAY6
         vIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768606289; x=1769211089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tWu0xJoZ2lXzLlzZvtC7iw+OrNL48tfG2EiEU6ep6XM=;
        b=pm2hZO0edg/2u26jvjhOehijr/WfEkjJztz4Ida341Q7pb/R8iK/0px1GwI1sy6WfT
         kvuug0YAjZ8GhSgTD58hHPsTokHJOrTinJCEcONhYsWebHA61XYzqeekCMAJVo8mSZ16
         c4wZilz/nVJmsWmUSBjSCymuMBLhfUOd0mOUCecWNJ67L2wZmb90bIS1Cw+n2Gvi+ABt
         AWX5q66DBHZaDgCal4WE3MLkFmNCAB7m+TpN3IEG1Np4xa/okzzCMK+Z1nO0KqsdUG81
         4aW0fWc1fs8gFbebaI+u4d1MZyUiS/TvJlkQZMJvpwGvL8pzP/6O0UcWSwZOcxnu5kEg
         ylvg==
X-Forwarded-Encrypted: i=1; AJvYcCWlw/BluNJGElQv1G7AWOyaA6e6A0F6Yyr8SUmMJjktBdKjs70RmbktfKkYwTCPyiEpvs5Iuqk2pIij71fS@vger.kernel.org
X-Gm-Message-State: AOJu0YwO9KpSKOfYAicFeSZ09rBBNslGWZuMedQEkHzNV4Oymf12FU23
	vW2usShSFoaNwUUGfS6k9gzbWR65p0GwNTGZaz5+OYM817kQNzn7CROy
X-Gm-Gg: AY/fxX4cSJKrEpMTe5Fx6rhCcZfSQ0pN8x4o4UVhNulpZbEoHylgzhbIp4N8KO+8T3K
	dwIiZNjkDtIURv/CNUgsUfYovtVGmNqKClLVerCiT+uVHNxdWt/6+8ZzC31t0GtVPRR1nUG0LdW
	yLnN0r6cM/3dhe5kdQ13WbSHzRFZMRyzceFjeJJgUErEE2YuiCAQFTSWBBrof3DBbOIrigmBWbk
	jdm+8N56c1Qq03LmWIcoPBo0xlX9tjkfZTwEBCan9eiHPqIcLeLAdhk9Ky+lAEi/11kBAn4T1+3
	RsRzN9KLFgW2B8lGLFdXgZ0ZL6pdFaCTb5zlLa0N+Mf+urVWdWDW3MuPE/7P5POmtPp7pQI4kYU
	0/Lt7/6rS37+MmCh0MsMrxDqUVpzizdmcmFQwASxVs+K2GcnbKTejtawlCeHWuIBPl5Z3nb2uoa
	d/UKQucg==
X-Received: by 2002:a05:6a21:6b17:b0:38d:f0f3:b958 with SMTP id adf61e73a8af0-38dfe60ca5dmr4535168637.23.1768606289296;
        Fri, 16 Jan 2026 15:31:29 -0800 (PST)
Received: from localhost ([2a03:2880:ff:55::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf249c24sm2956893a12.11.2026.01.16.15.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 15:31:29 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk,
	miklos@szeredi.hu
Cc: bschubert@ddn.com,
	csander@purestorage.com,
	krisman@suse.de,
	io-uring@vger.kernel.org,
	asml.silence@gmail.com,
	xiaobing.li@samsung.com,
	safinaskar@gmail.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 14/25] fuse: refactor io-uring header copying to ring
Date: Fri, 16 Jan 2026 15:30:33 -0800
Message-ID: <20260116233044.1532965-15-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116233044.1532965-1-joannelkoong@gmail.com>
References: <20260116233044.1532965-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move header copying to ring logic into a new copy_header_to_ring()
function. This consolidates error handling.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 1efee4391af5..7962a9876031 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -575,6 +575,18 @@ static int fuse_uring_out_header_has_err(struct fuse_out_header *oh,
 	return err;
 }
 
+static __always_inline int copy_header_to_ring(void __user *ring,
+					       const void *header,
+					       size_t header_size)
+{
+	if (copy_to_user(ring, header, header_size)) {
+		pr_info_ratelimited("Copying header to ring failed.\n");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 				     struct fuse_req *req,
 				     struct fuse_ring_ent *ent)
@@ -637,13 +649,11 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 		 * Some op code have that as zero size.
 		 */
 		if (args->in_args[0].size > 0) {
-			err = copy_to_user(&ent->headers->op_in, in_args->value,
-					   in_args->size);
-			if (err) {
-				pr_info_ratelimited(
-					"Copying the header failed.\n");
-				return -EFAULT;
-			}
+			err = copy_header_to_ring(&ent->headers->op_in,
+						  in_args->value,
+						  in_args->size);
+			if (err)
+				return err;
 		}
 		in_args++;
 		num_args--;
@@ -659,9 +669,8 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 	}
 
 	ent_in_out.payload_sz = cs.ring.copied_sz;
-	err = copy_to_user(&ent->headers->ring_ent_in_out, &ent_in_out,
-			   sizeof(ent_in_out));
-	return err ? -EFAULT : 0;
+	return copy_header_to_ring(&ent->headers->ring_ent_in_out, &ent_in_out,
+				   sizeof(ent_in_out));
 }
 
 static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
@@ -690,14 +699,8 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
 	}
 
 	/* copy fuse_in_header */
-	err = copy_to_user(&ent->headers->in_out, &req->in.h,
-			   sizeof(req->in.h));
-	if (err) {
-		err = -EFAULT;
-		return err;
-	}
-
-	return 0;
+	return copy_header_to_ring(&ent->headers->in_out, &req->in.h,
+				   sizeof(req->in.h));
 }
 
 static int fuse_uring_prepare_send(struct fuse_ring_ent *ent,
-- 
2.47.3


