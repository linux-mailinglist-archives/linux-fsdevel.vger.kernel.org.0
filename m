Return-Path: <linux-fsdevel+bounces-2943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E88AD7EDC74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 08:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779FF280FFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 07:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56C810957;
	Thu, 16 Nov 2023 07:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmZThr+d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com [IPv6:2001:4860:4864:20::42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5D9120;
	Wed, 15 Nov 2023 23:57:43 -0800 (PST)
Received: by mail-oa1-x42.google.com with SMTP id 586e51a60fabf-1f48b6e0388so121874fac.0;
        Wed, 15 Nov 2023 23:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700121463; x=1700726263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/zP01sxmtmsF220wNPZnDB4E4Ss9Od2fBbOpBrQvCQo=;
        b=NmZThr+d9eVYMZzNP0iB390nkOs7IjovgGuc+xKBCKNFRZObT14kAcyIepuysRNgof
         ZAMCuRu6a8vOkxn8ot+bowOcjDFPrQpq4uxVvjUqJIprhl0fdQ0Qp+Yn1jFGzqSSiZ0/
         la/d3gB/vsWEahGZ95jjNCG12YTnMmvInDR4dFvpLNhEMDyeMjJ+8I9bg0ArPqkhy0AD
         a9xulmroKA0z5XjmYQZsEIqEi9dXbfeIZm3WdiHnMmYBX4h/cSI1d/DOBju/RjWaUTWY
         DTti8llbAXCiBL1FTomV4W1BlJWoNsaMAxkBfldiN2Qe0V8K72QozmxdLkPirXmkhoDN
         y75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700121463; x=1700726263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/zP01sxmtmsF220wNPZnDB4E4Ss9Od2fBbOpBrQvCQo=;
        b=gfjINUPSg7DA6es2B1l+t958FeDZOgfmadLbGx+S3uENm7BwQ1PQEfFl7JWClIvt18
         eX9V5OrvxRrTGcZCPfesdWaZJThoLpwuQJLUhAl/VS/PNMoLdrWm966rLrUtLHIlHpdH
         ufi/nPFtCMRasxuWH8L/PfP+/wTMvZUGIZJIbgu0pLI6Ur9YQA96nY9mrrBPTopPE+5M
         6hByNA4mPBNFLBHzsJbrYoHq3zOEs0TfaLOwSRT0gYEEP0Ad/7v2gN2wNEIODIjhc1kx
         Hj364WoYS9uwBFert1dbfdNGF+saTJ9lLEa6hIQq+RB0ltnu+0lso1PPt3SGEmPeseRe
         ZWfQ==
X-Gm-Message-State: AOJu0YykdS1tNjfs7fCz4mvuQVDStdbxBrm3izpZ6F4e2Quat+i55sy9
	AErSF71G2ge03mPTtAtmcTQ=
X-Google-Smtp-Source: AGHT+IGwP7qz/+86dFB+FfcdjQXc5Tv16c7EPco0kc6pBqaCNKC3lzVYd4aReuCbH4gcskvkXgp2pg==
X-Received: by 2002:a05:6871:5c47:b0:1e9:bbfe:6458 with SMTP id os7-20020a0568715c4700b001e9bbfe6458mr9725172oac.1.1700121463234;
        Wed, 15 Nov 2023 23:57:43 -0800 (PST)
Received: from hbh25y.mshome.net ([103.114.158.1])
        by smtp.gmail.com with ESMTPSA id z19-20020aa785d3000000b00690c0cf97c9sm3969890pfn.73.2023.11.15.23.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 23:57:42 -0800 (PST)
From: Hangyu Hua <hbh25y@gmail.com>
To: miklos@szeredi.hu,
	vgoyal@redhat.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] fs: fuse: dax: set fc->dax to NULL in fuse_dax_conn_free()
Date: Thu, 16 Nov 2023 15:57:26 +0800
Message-Id: <20231116075726.28634-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_dax_conn_free() will be called when fuse_fill_super_common() fails
after fuse_dax_conn_alloc(). Then deactivate_locked_super() in
virtio_fs_get_tree() will call virtio_kill_sb() to release the discarded
superblock. This will call fuse_dax_conn_free() again in fuse_conn_put(),
resulting in a possible double free.

Fixes: 1dd539577c42 ("virtiofs: add a mount option to enable dax")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 fs/fuse/dax.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 23904a6a9a96..12ef91d170bb 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -1222,6 +1222,7 @@ void fuse_dax_conn_free(struct fuse_conn *fc)
 	if (fc->dax) {
 		fuse_free_dax_mem_ranges(&fc->dax->free_ranges);
 		kfree(fc->dax);
+		fc->dax = NULL;
 	}
 }
 
-- 
2.34.1


