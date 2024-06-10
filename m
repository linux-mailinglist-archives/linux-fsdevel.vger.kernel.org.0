Return-Path: <linux-fsdevel+bounces-21355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94098902994
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 21:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43CBD285B2D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 19:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D921509B3;
	Mon, 10 Jun 2024 19:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/SqQyqQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1E914F9F9;
	Mon, 10 Jun 2024 19:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718049528; cv=none; b=Gtz6pBsJPRO1A/CtQDZsNA1fWaChZpqPZvb243ezldYWeA1TateKZXMiNHXhoekLnxSHEZmBIEd6TcOtVneeWxjYul23qqSOlP3B2Q+Ul1m+GzgwF+2wcnvxmxfdoBKgAlGWZ+TRytpCjcYzlaa2SPCC+D8g9fNUB2GvenRyavc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718049528; c=relaxed/simple;
	bh=MQRPna/48QhZ1v0/gMd7kyf8YGX6lSvsn1kVRPs5xA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMxXV1qZ4k1JhrKA/3u7adbinCG/gD4CPTRLUOxMRZOxNZiLKwgPyhmWvRHmnd3K2334nLtwSgme9mTomijZZXe3+n5Oyzo8DBPUIxLBS4dFoNuGd1J25QDptpq80gWJIBsg5uzSDANJM+xXLfyle5uidGp2KVizapv/hHlRwJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/SqQyqQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4217926991fso23810385e9.3;
        Mon, 10 Jun 2024 12:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718049525; x=1718654325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBXDKgjyA4bti1zoOZEiYHZlT+/fD+8yvyhyrG3GC+0=;
        b=R/SqQyqQfEOF+zV9qKQsJ0C8cxZ2pa6Xo6B/pMB7hCXK8Lw7bZZDZdUS4cLl7DEDH6
         UMqkgS7d+gNNXD0i0SHnDgp+a5zWYiVj0C1dConI8Xxzd/Bx2sjskY70zf8zU4IcCany
         w6Rp7yR8PGe3X51W0ZDPCtEjZpxe0U4huafCr69kl6ukx5pN/JP5RYjALi5SYB3V/X0C
         kGz7zuzXVhJBWKUPGHeMYEAjwxmbGGj2+bifKia3r50HczKzGKHPZbsQRKgtYN9VHFHN
         TJqFxkyTDLcWpmWMSk16zeb1yLsowv6j5kfqc/jfAap5A60B5b3+fnpdJ1VpkvPalNp7
         i9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718049525; x=1718654325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBXDKgjyA4bti1zoOZEiYHZlT+/fD+8yvyhyrG3GC+0=;
        b=h4+lSCbepZlQ721etDdeavktq5uuk0M+eQacqZJLdq+32iIjh1HRlZ7sOTcZi9IuEd
         LmTOoBK0VtzTrEic9B0V+I5KtoExVBONhiG1r4zCdqiZloonJFyr96dxiw2YUx5tZ+u9
         Mf1ZnSBOK6y05i7PD3vsTmhNxd7eVlxaJVB8BdCWJHyBjJoyAGU4Ptx1WZnHfBldMufu
         wU76Zas8uUCx8aByedDuMMxvi9O7jNLTu0DzyxntEoXlksTZLPXCiRA0ar/SbTCSHq+L
         ENAXdQM/bqput9OpuGahiEN8Egc9JG67o2RrCrjRy+UV3puqOMzYN24YuzpJOhhj7KpI
         1Kgg==
X-Forwarded-Encrypted: i=1; AJvYcCXQBWh9V3LlcpULoQiqYiGdHCdZd0tQ0mi1W/H6ed17d+dJjBTEWqno4J0YGZkwwDG99g0sEHgMe+YpnNYiCxfB46ZlfjXaEkosdlxOnnDg/CsKkCTnlyvXRh4km+McVCe/KhwZX1Z+NRIHPK44x34vwAUu+H0WJpKARhGH1wclIDWp2O+/RbCl
X-Gm-Message-State: AOJu0YxDCeXV9+TehhhtXwuh0rQEgFWn7TwH5WUTgs8gF+pIYg8jKjZM
	kNVxbWZIq4pkozbfkbyxIRS4jUHR6rURFLe2fQu9VbPn3Smj8tdS
X-Google-Smtp-Source: AGHT+IG0fpXZNBzDums/MT8G2xkgn7xYswtGjINuHLxISwYPK9WdqGySSZPAbrtl+YRy6NSor822Rg==
X-Received: by 2002:a05:600c:4e88:b0:421:79ae:a2cc with SMTP id 5b1f17b1804b1-42179aea3f2mr59343665e9.15.1718049525187;
        Mon, 10 Jun 2024 12:58:45 -0700 (PDT)
Received: from f.. (cst-prg-65-249.cust.vodafone.cz. [46.135.65.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c19e97dsm151766105e9.5.2024.06.10.12.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 12:58:44 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	josef@toxicpanda.com,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 2/2] btrfs: use iget5_locked_rcu
Date: Mon, 10 Jun 2024 21:58:28 +0200
Message-ID: <20240610195828.474370-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240610195828.474370-1-mjguzik@gmail.com>
References: <20240610195828.474370-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With 20 threads each walking a dedicated 1000 dirs * 1000 files
directory tree to stat(2) on a 32 core + 24GB ram vm:

before: 3.54s user 892.30s system 1966% cpu 45.549 total
after:  3.28s user 738.66s system 1955% cpu 37.932 total (-16.7%)

Benchmark can be found here: https://people.freebsd.org/~mjg/fstree.tgz

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4883cb512379..457d2c18d071 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5588,7 +5588,7 @@ static struct inode *btrfs_iget_locked(struct super_block *s, u64 ino,
 	args.ino = ino;
 	args.root = root;
 
-	inode = iget5_locked(s, hashval, btrfs_find_actor,
+	inode = iget5_locked_rcu(s, hashval, btrfs_find_actor,
 			     btrfs_init_locked_inode,
 			     (void *)&args);
 	return inode;
-- 
2.43.0


