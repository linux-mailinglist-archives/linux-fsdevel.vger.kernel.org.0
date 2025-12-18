Return-Path: <linux-fsdevel+bounces-71641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F032ECCAF7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 09:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 395CF30C383A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 08:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90199332EBC;
	Thu, 18 Dec 2025 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjrbhFHC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E683328FC
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766046898; cv=none; b=pYISmXnl1IQkVDxGtthokv3mh7TI0blYCdZWSwUSL8ZSh7tCmYM/XJb9SkBLL7WhFo+hSLGcJUKgxsv6JD+Nj+PyzXaQuzM4fqLjtrq2vT4vfi/A4AT5I1325mWM5NvyYDEpanWPAkS+rM7hMtyMRmYFK4uC/+yB+4+RHgMrR7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766046898; c=relaxed/simple;
	bh=dCE9Ifsy53U4i9ZoCVgrqAcptT5uW4tuuXml9xDq4zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrEhSJuXD+VUr1RebKTe4wUylVDno04uXFxzor08xw/LupaghezKVnWIU/9CeanyE/7EeHuk4rpCsijkbZxOMfcd18xYhipYEQfp2wTCzEwt7ydfYqxAbQaha5SWUhRj9YMNrtkTNuL9QCg2nEgn2euIEcW8N0b/ZUWm0xkTXyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjrbhFHC; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34a4078f669so399345a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 00:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766046897; x=1766651697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9L/4yXbNzZtfTE9c852n7Fp8KTBsMqoDKIABPL39CrI=;
        b=CjrbhFHCstA6qwCDHzdiTY47+pYBz/08InOpQozv+81UUcmi2B1BBTI1/Q2HJoqaF8
         vpkve7YqbKQgraerg+nTsUJ7XYmNthfwqUED7wX5yRQfuFWqCk46iC67qodJu/i1Bcid
         IpTvng05F9AndDDZEQe4UJKLp3aKLqaLfAXlH/YSyGJe5kR7x2eFAhhzRxmWqKZHPtlT
         h9Frxvjbu2QM4HC0IxP6/urF8uGf/UrX8MC1GSU3WH7lBcXOd//CeKBX/Kblygu0+J5O
         G0FeSZw/HX47aIw3nZvsAMNtc/jqCb/L1EXVwkCMmteNhqd3Jl2xpmkzVTYXKnS0jq+K
         csTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766046897; x=1766651697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9L/4yXbNzZtfTE9c852n7Fp8KTBsMqoDKIABPL39CrI=;
        b=XmjM1P3hHTbJQ97GTCfs2Nr0grnRDlHvYgxFll+bLeEPgtEXkp63mnWK25Jb/gw05m
         vEibFjdIe1nwOyoZY/IZVz1oUQANMdSPOtGqycZ8a8x3rh0rnYos1rQZkfg/FSpyQ/pb
         NiKueP4pyof96KJVtI//DdELpqhB5ywMcEAClDZ+CG8fsgx5aOnQFOmDDGWq5Ykq62E8
         +YiOHLZa8Aml0MBABg437m+hZhzQYsdWzGN3OOASegpLSK7Oe80wxNGfhbBYhjlLlLF/
         Rl4sRezyRW6xdnCb7ZVCWSRff+B0V/wVkYH9mDzvduBB2zY4pe/quwFJ5P2m/cR2oXyH
         z7VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZIiygmjkWNfR4HaQbKmYvYadyflNgWL1ozeXw90fp4VO8BTuVevOKd2jDnm5MnhgiDCP07eIdG4Ajq6cA@vger.kernel.org
X-Gm-Message-State: AOJu0YwR8W30R3Awo0sbx1niQMgwm1LPM7YUMJIm9S8DrAU1PrE59Jav
	RNNLIPAhlzLOaAy/lo6cysrWnmlqwloTNZsQGRd6irWcOQfbIqnoRG+6
X-Gm-Gg: AY/fxX7680ntIWmBraPfZKNGTmDTsK1bPc1MRnyvVsjQdH4k5V3By9/EsYR1rH6ITto
	DSmmxepEPd1tKCj8Oh0557YHPF10F68DR+/yp32Crp49XG8GFVeQrmF4s/uIfKjzmXXDSe+5I+E
	xrxtkS7h5TqvxaR1nbEhRjQho6K5Ylr/5VGKvVdk71Jy547h9Ld+LqaWvn5KZBnVr9vGj9UxD8S
	i/2YLh4PbzXbHIYIS1V2ADzPngVk70DTQ1rtqmF6zT5FUBj/O8vBUKaRfGmr6NSkaIRc/SUmd78
	PCUNo9eWRny6BNyePGRN/pwckDh+LRdGe+yKe0M5zFKDfXQp143YoPftHtBZO/PdPeInu9fwh7r
	7BxWw52ZH7Fn3OQ1d4THQcf7i8OJ461e6dnfLe1fgKd7jDOwwqkREHu0pSSVgOpNyuhxWEUAmw5
	7B+j3qHWh6Ew3duArWgg==
X-Google-Smtp-Source: AGHT+IF8Q9BdMmqhbAVQ4qV8HNi3zBRv3TUTvevnsq02uzeL7adFqJTN9eY/yfoIkHFNyvSao5q+JQ==
X-Received: by 2002:a17:90b:1345:b0:34c:fe57:278c with SMTP id 98e67ed59e1d1-34cfe5731d8mr4275323a91.34.1766046896789;
        Thu, 18 Dec 2025 00:34:56 -0800 (PST)
Received: from localhost ([2a03:2880:ff:58::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe1427026dsm1822183b3a.46.2025.12.18.00.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 00:34:56 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 14/25] fuse: refactor io-uring header copying to ring
Date: Thu, 18 Dec 2025 00:33:08 -0800
Message-ID: <20251218083319.3485503-15-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218083319.3485503-1-joannelkoong@gmail.com>
References: <20251218083319.3485503-1-joannelkoong@gmail.com>
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


