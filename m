Return-Path: <linux-fsdevel+bounces-38314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE5B9FF417
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jan 2025 14:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8421882580
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jan 2025 13:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4586C1E0DF2;
	Wed,  1 Jan 2025 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJzPSe6g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37361E0E06
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jan 2025 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735736445; cv=none; b=rHnPzUbJeO0JHMBi2fQMOmbKbe9+LD86Og2vuDk8yvIQOBnnRymXiXNF8zl7YEMV/NJ1z+eD+74Xnuyxrl1tKvA5IIRxODjUVmtO65UZWG5RIyp4XKE+lWfIpuuuIfmoM+j8VSGRmC52QxnNaB11arLtJg9beU5fW0kZDohT/uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735736445; c=relaxed/simple;
	bh=vaxsK/YB9vZNL+3D+lylxfFlg77Qk3GBAxK0/SKxh2o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e1KeOL3sJMc2WTahWKTgfmX2FDuui2T6yqtH/6V3kobg4iGJej1xuqIreLb9ZuakBlMaWuGFDBOfqaQ2qJKN6Wmbg9WjYV1/QYhBGUwqZrI0ZT64ZoDBxncKt+Bw58V/AglK53H/C9Dy+TncM12i+b4Yf6/FiiRVJQ+HzWDcZlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJzPSe6g; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4361c705434so77360635e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jan 2025 05:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735736442; x=1736341242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0PKnUCiC3n34OIj6JelUlU6EARZj+ZRcslbmssATB1Y=;
        b=mJzPSe6g6AGETdTCkIUyZ11vFBjX+lT9J9ZfVoCa9FqH5/Qw4tkClwZGzYhAVbQC9D
         4fSGl86rC4yC85uNgxCAKnCSg6AbAV/u8lTxTd/zwFg/m4znjyrgWkOsd1ftzK/AzCPQ
         nIMFyjFJo5m0+mbzT1M6sy0BboxuNd+Nso+mdaolGH8c8m/h9Sh+uhtVp5ppZ1SMZZ0r
         1E16EwpsDuxK3VfNLUetkUSpEw7050kq56g0xoOc9c9NiS8wbUIaWP4w/cHKJuYcGOuE
         KYms+LZG2UNFZbnfumeTo62aArHozRYtKJtaHzzxqm4Bq7ia2Gl3hh8oWlzJ74eI15gN
         B6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735736442; x=1736341242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0PKnUCiC3n34OIj6JelUlU6EARZj+ZRcslbmssATB1Y=;
        b=KUj6k5uA4JL4w3If/rC7hy9ZF/fhDyToWZr4SUhNAzN48eSrkxzh82c1vdusAmhwY9
         EaQwNPgkVGHMJNvPKAknIgr+KXIYgCHbaw/jzMV1VcJ/P4DXV+jMsIJZ7ijLjf9AXAee
         d5JtcZBZt/4RXt8DkLPA7zZaPXjYaMdM/tRdIy5Su2gXzbcCMzw57snKYiBTkbLMU4ID
         lu6dGtcZggcZH2a9k8VxP6amoFKs9IathHOX1QaAQf4njCqpcCGBplsDrrIM9c2QPXjP
         8go5IWEpDpDM4NTK3k1ge09fFmeg7Pxb5H0xGtDdksmdG4WFuN6IAPSbuSDtygZw/nHL
         77/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWU+R+UqfhnhzZxX+497fQtkOn1AifP7gfe8/1cUqUaU7fiVThPvlh9kyDvfERUhMG60UDNFKRTp9cLg76k@vger.kernel.org
X-Gm-Message-State: AOJu0YwAs57IWRHu96qJHOV6Z6AcwNqtRwJiMRC30JeeDiMk+CNGQ+sH
	0Ys8LNzxR4u+5d7Q7H/WJBOCucgaa7Wj3MxLzD0fxrQlyWOQHS3Q
X-Gm-Gg: ASbGncv10rK99Yf1eL9bkn3Jgl2omVjyK5u8U9mKcLlZAJtnjvw4qxWjiLsVpnLjkKp
	muUL6DggeHTEJ6Kxd1q5l4Mc/BGyGBagIVrftEByaIQCHaGS8pvv5XYrBP4gGFjnKgs0420o5ll
	F4zKop8kw1gq2DExSZim5q8U0Gd5FfmrYiJShpvqA+gTzk4bI0Uqfz9+wkb65GVtpSfSjret1Bk
	vq3ZsJvqxYhNhxsJB/lFcqVGldL1+Ad2jVcDoJCTInYqw9Awhs76MW9DwkF5qUtxyAj54nVdHHv
	SaeSW1nhz+XxJP6KWQlr/htajda6Qta9souoSAjkaI9HLOr7a95kYg==
X-Google-Smtp-Source: AGHT+IHvG3MozpMOreguX60tqbwPMwciOJM/38MICii5NW3mBPurkGimbjm7UHUUKA3BpOzWAVtCwg==
X-Received: by 2002:a05:6000:471e:b0:382:31a1:8dc3 with SMTP id ffacd0b85a97d-38a222007dcmr39989020f8f.35.1735736441631;
        Wed, 01 Jan 2025 05:00:41 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e4ebsm35654866f8f.85.2025.01.01.05.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2025 05:00:41 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	linux-fsdevel@vger.kernel.org,
	Prince Kumar <princer@google.com>
Subject: [PATCH] fuse: respect FOPEN_KEEP_CACHE on opendir
Date: Wed,  1 Jan 2025 14:00:37 +0100
Message-Id: <20250101130037.96680-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The re-factoring of fuse_dir_open() missed the need to invalidate
directory inode page cache with open flag FOPEN_KEEP_CACHE.

Fixes: 7de64d521bf92 ("fuse: break up fuse_open_common()")
Reported-by: Prince Kumar <princer@google.com>
Closes: https://lore.kernel.org/linux-fsdevel/CAEW=TRr7CYb4LtsvQPLj-zx5Y+EYBmGfM24SuzwyDoGVNoKm7w@mail.gmail.com/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Miklos,

I verified the fix using:
passthrough_ll -d -o source=/src,cache=always /mnt

and watching debug prints from repeating 'ls /mnt' invocations.

With current upstream, dir cache is kept even though passthrough_ll
never sets keep_cache in opendir.

passthrough_hp always set keep_cache together with cache_readdir,
so it could not have noticed this regression.

I've modified passthrough_ll as follows to test the keep_cache flag:

        fi->fh = (uintptr_t) d;
<       if (lo->cache == CACHE_ALWAYS)
>       if (lo->cache != CACHE_NEVER)
                fi->cache_readdir = 1;
>       if (lo->cache == CACHE_ALWAYS)
>               fi->keep_cache = 1;
        fuse_reply_open(req, fi);
        return;

Thanks,
Amir.

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 494ac372ace07..e540d05549fff 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1681,6 +1681,8 @@ static int fuse_dir_open(struct inode *inode, struct file *file)
 		 */
 		if (ff->open_flags & (FOPEN_STREAM | FOPEN_NONSEEKABLE))
 			nonseekable_open(inode, file);
+		if (!(ff->open_flags & FOPEN_KEEP_CACHE))
+			invalidate_inode_pages2(inode->i_mapping);
 	}
 
 	return err;
-- 
2.34.1


