Return-Path: <linux-fsdevel+bounces-56691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A248B1AA4C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 23:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E933BBE1D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 21:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9241823BCFF;
	Mon,  4 Aug 2025 21:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2mEivut"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2C4634
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Aug 2025 21:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754341849; cv=none; b=LH1zuoTNgB+/aCSPpTMY+Ay0Ywl9TgumdT2KEEFwRjPgaZ5cyY+BtjMnRRZLR0s6vBEinNsgdueGXKZPDotj+mAa/NurhG+HH8dZG3sIGsVVfSFSkyPZwfsmHtufpc+OzVSBCvJmXbvjS770YHGANLw7ipTNhUWTN5VieB+ly3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754341849; c=relaxed/simple;
	bh=gWZ5CFnZrZloV5PT+6IdUiKajYp5viisUj/4FnCJ9t4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gARUkGajj1syg0BT1k04/NXMSU5smsLllu9xONt90LAgjYxVf4egix5xohao+gUjaXhPkC/An97B4lySZoEcDCZipU/FKO1W2wDLNGDLfMNpef+ioUjWR1nwhq7DmioF6I4eh1XVKhsCQu2zBLv7E71bCmnfTnUAhdt5cj5kkl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2mEivut; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23ffa7b3b30so35882025ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Aug 2025 14:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754341847; x=1754946647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHvDMc+lEP45RzdNZnW/LnW1yObaHq09ajd3YQq0Tas=;
        b=B2mEivutTKW9KpN9lCNWWSDTRw5vdyHGOjXZUws6lZMFxhHiI5rE1wpeKtzI8JIvXS
         CXvJ/nGtRzKG7UJmY7BgN8mKc8gVW6A3fH7q4RoRkaNZbUET22+hD7zhsnz0e/808iig
         GFN/nLhnVFUVUAEGTIOm9CEha2D3UJVrYWPvFc5hfp383jzKZ5wdZ7BEzCQ+Xnw+5lXm
         AbMKFgZO2L4gBLI+Vb+ioB65wrKgqqPDR+oakQMlytiOnOjDjkb570AHyUIABxhDCgI3
         VbhubObO5oQqCxMmy6OOZsIiFKspbz2nJ7cD2ChlWcCc6hKaeUk73+YJ/24muRziPP+m
         QL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754341847; x=1754946647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHvDMc+lEP45RzdNZnW/LnW1yObaHq09ajd3YQq0Tas=;
        b=idpfWnZ92zK8MVfD3RuWlMeI1A9wKQ56IQbh1LMzd1oK1uZhGJ/9fqf9Y1F3le05Jn
         5Rzb0Ndq/lLgtk1DOxUtdmYp8xlujIs4BOyJgEd73c6zCQvPdS6nb+8yaobNTiUG0hhP
         EZpQCSqZ2IPFFLZx3tYlMqwMZV7GQqiIQjIHIge/GgnKM7D60F8TYnJh/hjsd0Z+HxmY
         qQ2PdYXn6FtZilTWV7y6r0ITNi8AoGBtYZRYHyo1I7QqFV5oHpeJ9McPu+XHiog4KpQJ
         q822rig3GhMZp5W/aqQBaTGVauocevdaE78kgTblqujEyYSvERiNLDssNfy58443hN45
         SiYA==
X-Forwarded-Encrypted: i=1; AJvYcCWbwiEG9q5FdbFngeW8vBOd2hHJVJeY/a8+xwfYOeHLM7NYThDZdyKB0ZTd5boKmU1CbrFsLrraJvpXgMeP@vger.kernel.org
X-Gm-Message-State: AOJu0YxOBpVoNlO0c7sPICU9tPA/Mouagew3Y6VATsxiFDKTc1L4swmd
	nNPdgCOD71hML7/VEFROCh0/VKQNQjksxDbIMnoSX3Wl4tqlXZx3DhAp
X-Gm-Gg: ASbGncvvxrqh9sJwmeqPb4SjqXD6Fa3WigUWLwS1B4wKEFoASEon/raPSLzClZrknhC
	NprWa3AHnhfSy2vtwpH1c3b51Bb+3GpfIUHL+kxISN5dddg0p5f11sH43G9t5iTVn5CvIrbfocJ
	dssHaHrph48V7Z9J/B+pPpLPTdwt2yvbH7AGebXn3R81z7HvMF2HS0yrYk3C/LcJYB/xdZKGDLM
	BoyDLnXRXIT9Z7MSL/ZOCMsKFUYMIHHdDN4TCy+qn4d+Jq2maPVnvKDtB+ldFZVQbUgA2G2SUCY
	o9XmArtLJANlOVgASnKJKaFfB/QMhp+4t2zLVnjTRaeMBZSDPItonikQBv7ZQHt/oJUvlj01gML
	KgZy16lw32yVgndQp
X-Google-Smtp-Source: AGHT+IGC1lHzFDIYCI1zdJ/MCVjIG4Dthc7liQy/7xqYYGEZhpQycBcbJHqJ6j0cOy2DNKUEXeGBlQ==
X-Received: by 2002:a17:903:2351:b0:240:71a5:f30 with SMTP id d9443c01a7336-24246f86a58mr160708595ad.22.1754341846916;
        Mon, 04 Aug 2025 14:10:46 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8ab3da8sm116713395ad.175.2025.08.04.14.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 14:10:46 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: djwong@kernel.org,
	willy@infradead.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v1 2/2] fuse: add blksize configuration at mount for non-fuseblk servers
Date: Mon,  4 Aug 2025 14:07:43 -0700
Message-ID: <20250804210743.1239373-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250804210743.1239373-1-joannelkoong@gmail.com>
References: <20250804210743.1239373-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows fuse servers to pass in at mount time the blocksize that
should be used for its inodes. Previously this was only supported for
fuseblk servers and non-fuseblk servers could only specify blocksize
dynamically through server replies (which is now disallowed).

This gives a way for non-fuseblk fuse servers to specify the blocksize.
The block size must be a power of 2 and >= FUSE_DEFAULT_BLKSIZE (which
is also already a requirement for fuseblk servers).

If the blocksize option is not set, the blocksize will be the default
value (FUSE_DEFAULT_BLKSIZE for fuseblk servers and PAGE_SIZE for
non-fuseblk servers).

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/inode.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 280896d4fd44..23ebc59d0825 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -871,8 +871,9 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 		break;
 
 	case OPT_BLKSIZE:
-		if (!ctx->is_bdev)
-			return invalfc(fsc, "blksize only supported for fuseblk");
+		if (result.uint_32 < FUSE_DEFAULT_BLKSIZE ||
+		    !is_power_of_2(result.uint_32))
+			return invalfc(fsc, "Invalid blksize");
 		ctx->blksize = result.uint_32;
 		break;
 
@@ -1806,8 +1807,8 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 			goto err;
 #endif
 	} else {
-		sb->s_blocksize = PAGE_SIZE;
-		sb->s_blocksize_bits = PAGE_SHIFT;
+		sb->s_blocksize = ctx->blksize;
+		sb->s_blocksize_bits = ilog2(sb->s_blocksize);
 	}
 
 	sb->s_subtype = ctx->subtype;
@@ -2007,7 +2008,6 @@ static int fuse_init_fs_context(struct fs_context *fsc)
 		return -ENOMEM;
 
 	ctx->max_read = ~0;
-	ctx->blksize = FUSE_DEFAULT_BLKSIZE;
 	ctx->legacy_opts_show = true;
 
 #ifdef CONFIG_BLOCK
@@ -2017,6 +2017,8 @@ static int fuse_init_fs_context(struct fs_context *fsc)
 	}
 #endif
 
+	ctx->blksize = ctx->is_bdev ? FUSE_DEFAULT_BLKSIZE : PAGE_SIZE;
+
 	fsc->fs_private = ctx;
 	fsc->ops = &fuse_context_ops;
 	return 0;
-- 
2.47.3


