Return-Path: <linux-fsdevel+bounces-71707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA4FCCE49D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 03:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36EB23059AFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 02:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F1F3A1E72;
	Fri, 19 Dec 2025 02:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1BZS6TP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B4518A6A8
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 02:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766112392; cv=none; b=ABNKDMlx/b8Bwj3TUm8ZHur+wKrpUwdB4093Jb1PnpnDWw8UqI/WVVwnzSLpF3OFMDNCJQpvOPju3070U9EDeCe2GaBi3G12k3Bbx7iI+Y6JwALsamXWR/29LRpIUYWIDm00enQnZPdNweeAGUlNe3qCGugCOsIkWWqMwFk2R2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766112392; c=relaxed/simple;
	bh=XiWwx/yBvL5qhtur1OJ6r0Qtve5kN/UAKMQDFDv8Kk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1248l11aWI8jok7jh2H78MJcIkqUNQjlA56YpIP08KX8L9TBJrw6X6Aqv0JfQMNH4yZOqyP2RvoD/1T5EpQeAwAdNNW2iC+rOpKxohfUGWue854Ku25rU5Q8hDhZbaJobvcDZSUCmCMR48wDd+VjG/3SBqhBuZVpKFhmn3U4yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1BZS6TP; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34c718c5481so1236020a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 18:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766112390; x=1766717190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFsNe5Gu995f8GfU2RxaYzwbXM91ZCVhfkD06BV90tM=;
        b=Y1BZS6TPUnq8Feck1MFWnCld6/zExTaeWXLQKLKM4OUMoViWjahE8UIOsjkesjTCJE
         Sy7pPi1n8vemNQtDgzEbaOS1mJHxdIzLbvrWAiXNdXXApP+J7AOtb3KruVOuQckGUs01
         ziR8Y0yL8VlNopQ3Xmd1fwrP1OEkLQ2MabZyztTwauCHsnZ+OzlC5Dg9iydATKv0EU50
         /TbI0fsUAMz4xsqpxuveOREsM2CSqr9dLbAgBiucxVFJB5eobpqlL40aWVgwJzfBa0Te
         fE2c1pcVPiaJ5PXlPo6g8/C4jwpaCokLTVXlemHHUPzYKdNKiOfUTp4zShhJ2BFERblz
         mIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766112390; x=1766717190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KFsNe5Gu995f8GfU2RxaYzwbXM91ZCVhfkD06BV90tM=;
        b=wdeuIqHS71zKnYVrOi5pXcsKPCTYkRDPqAl3qdLgNJFzAuM9gb4N3eU+ItHMb+GTsO
         kzT+ZjZ7wg9sgB1aMK0QFZunptpYpAcnGLrgGczc7LMWhhB6+C0BMepnM7n/YiwLVXY3
         S5BVNRKGC9p6Uk0qkc0/xHSrvqM2UgosXY+DGddS1qo9XjG2MwDUlo8vxtPgTE2OJXhx
         tcfZPCor582rI+4GEIIoQ0KHoIkcy4tGUr7GKj+bDMLBeBrKMbiCFB31D8y9nMe5Gvp5
         4oK8pQKQu/ltwjN0DNb65NHTKK/EdRMEkDQgsJh5K/9A5M7G71R6CmocdVAoEA9SIX0/
         k1PA==
X-Forwarded-Encrypted: i=1; AJvYcCV2Gb0pLCTRJw17koxZA+dp5WmaT4IoIU4b39QY3+HKOEG7C9cS0elNS+DjaJV3JYiZID92akVyFBFoncVx@vger.kernel.org
X-Gm-Message-State: AOJu0YwRNlqpYJrpCLT3ekbnB+IYnv3AjpHmgpqSy+pYL37XoqlQwaFt
	7ffy3FsCEe3sx1bDIBYkAE7mbRzO6d4G53cR7Yluy4fDwjR/rhiMsy7r
X-Gm-Gg: AY/fxX465Sa5l0+JQkFMhMgNhLQZRMW3FmzxbaKOcGSpfZ6ZQnohq+TLsBQuDsLgRVF
	D+DX7JaNE8gLEUYZYOz1hSMFJlY5nxiLDDGl94zZvJd4yzcQ0gyfdQw/JBkdFdttfQtpVM9hKJ9
	jG3XZXNhkKOcVXKAR0XEbVuXScODRPIqCemIUuiZy3e8IddjMIfXnnr/O8G7SAIEDPHIDmkMQjG
	T77kdFoGt7UTX9CkspsUvXxtgxEoOp18T4SlIL+w/GgvLL/JAW55jUzUEphq256rHhZ34dykd+B
	8YLYD57OwP3/k6AjK5R34s6BZbUYcPgwCrgERc8MWfakKGFD3ACc3eOoXJmzUL47JjVewjbCXwk
	9KfsfaGZpHNG7rpYsYGiM1aPZDh9u0jI8RiVUEOaJODJGV7gcC0Qj92M8wgfUdTTuSN2uj6fa+V
	9DsVBTr/LPLZY=
X-Google-Smtp-Source: AGHT+IHkU71PXijduVFd6PPXorUpSNEqDrq9sIeFWm+ycCSns0lZPhrMo3c2ywSEXzz17ORUE2E8/A==
X-Received: by 2002:a17:90b:4d87:b0:340:e521:bc73 with SMTP id 98e67ed59e1d1-34e921371c5mr978885a91.5.1766112389734;
        Thu, 18 Dec 2025 18:46:29 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e9223aab0sm723451a91.13.2025.12.18.18.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 18:46:28 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 6CF944001B5F; Fri, 19 Dec 2025 09:46:26 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 2/2] VFS: fix __start_dirop() kernel-doc warnings
Date: Fri, 19 Dec 2025 09:46:20 +0700
Message-ID: <20251219024620.22880-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219024620.22880-1-bagasdotme@gmail.com>
References: <20251219024620.22880-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1286; i=bagasdotme@gmail.com; s=Zp7juWIhw0R1; h=from:subject; bh=XiWwx/yBvL5qhtur1OJ6r0Qtve5kN/UAKMQDFDv8Kk4=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJkuu/+dvchy9riQV0rQi+XZZaVv54vIuOozrz+WH+do4 j5RlaG2o5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABOp2cXwP/FBj2VfiqZtxPsL YpcSxHTjJq/W/b+bf+6dD0td/72VPMXwP+z1sWkt0XaL/q92c5swOa7gXcQaPtZz77snRqrM+P9 0MRMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx report kernel-doc warnings:

WARNING: ./fs/namei.c:2853 function parameter 'state' not described in '__start_dirop'
WARNING: ./fs/namei.c:2853 expecting prototype for start_dirop(). Prototype was for __start_dirop() instead

Fix them up.

Fixes: ff7c4ea11a05c8 ("VFS: add start_creating_killable() and start_removing_killable()")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 fs/namei.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index bf0f66f0e9b92c..91fd3a786704e2 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2836,10 +2836,11 @@ static int filename_parentat(int dfd, struct filename *name,
 }
 
 /**
- * start_dirop - begin a create or remove dirop, performing locking and lookup
+ * __start_dirop - begin a create or remove dirop, performing locking and lookup
  * @parent:       the dentry of the parent in which the operation will occur
  * @name:         a qstr holding the name within that parent
  * @lookup_flags: intent and other lookup flags.
+ * @state:        task state bitmask
  *
  * The lookup is performed and necessary locks are taken so that, on success,
  * the returned dentry can be operated on safely.
-- 
An old man doll... just what I always wanted! - Clara


