Return-Path: <linux-fsdevel+bounces-21402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 953359038AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 12:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB981F22C8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 10:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6741B17B507;
	Tue, 11 Jun 2024 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxp//18r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4020E558A5;
	Tue, 11 Jun 2024 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718101009; cv=none; b=O4WJ+1nO+jJQu6M2rcndPlNxN0wjNvHYvtsQqYgMth2JFytxoG6/bIeFCDGREbzECVewgOqmcGG9XQxVUgFO+YV2QTN+Y4saodEUFWzqiu2sb/vJSoN7MTshh3miNfXRyoID57AL1IcYTwxyqElMH74IOD48Pf/75M9St3j4Ylw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718101009; c=relaxed/simple;
	bh=MQRPna/48QhZ1v0/gMd7kyf8YGX6lSvsn1kVRPs5xA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9fkSig/N8oIfdW9cPn7od5rwBdE9LcB6d/KvQygH7tk35V9YL0BJbBIDHQwMAAuTPcjeTi+ltPbDRIy0kVtmC1YfWsiHl2dKmR91hozJVg2pUMR97CGFOXZob4JEL2NEfR2BrksmCZgNtX/EJEe3CY9TDOANQaUPIiN2cB66d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxp//18r; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ebed33cb67so10101651fa.0;
        Tue, 11 Jun 2024 03:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718101006; x=1718705806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBXDKgjyA4bti1zoOZEiYHZlT+/fD+8yvyhyrG3GC+0=;
        b=dxp//18rW0ewoZtrFiET76ROU7tdDKsWbeZ4BfVcluN8X140MAlKqfjsH0yiWpdN1i
         qDGklu1aXX9izwXNJvTy0iROCug873Sq05OQFz1yqCfwb52EkDhsHn9XobdBjzV4tmZD
         9Yfb42T7tiXdwj7KuaN/YpqC2iW/xsI2f+0u+rNA95+WF3Mq8IisprKJhmDR8E7kJGE8
         B8fw2bGARx4MooKDCe1c2Ell9hpUeCWIDSHjknOTiRky1WKfe29qd5EktLCftKwc6a9r
         lBgGvhd0hWa6Tqlm3jrXwaMXL2WknmBhEg8P9HhDeP7eByNIe4euv4bLF7AOj6FSAy4y
         1eNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718101006; x=1718705806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBXDKgjyA4bti1zoOZEiYHZlT+/fD+8yvyhyrG3GC+0=;
        b=YlGO1QylrAebxPoxyPHm/E4xv9DQlE8Nx8c4Tr2Svu+nrJ6ehCGpcSTqLSVP0DjQ98
         D8raocHkEqIA1/9IepfSsGVYw6iQ5uLW56Bate7spGbf87YcznT7f2Z7/eyqYbSGNrEo
         QrGYgvAUPOOWt1WUyWtdzPV6bESeJnppucTSXr8ObwRbMqyuVegUSbkIeM5MPVPgy258
         hIwsk8fYpVSwl0GVDkpHi2W2oN/+83/W+fkR0Aui6xPuyFRVtpjIGAjQNisBBg0+JStW
         0O+yLurEldXEyscNqy2ZvNL95l0RFEBl78msTn9hQX+NbCFvxjMpAxvcMN7EKWO6OBR4
         iMSw==
X-Forwarded-Encrypted: i=1; AJvYcCWpY8VOT1QD7n8DSg64cOPoyhVZrBKRla9NIzSUFFg5DWSwcWuAL9sH41hc1MkE8Xvblsn4zvCc+3en21TJrEuxNhxFMdLVAVXV/iY6rYtlxJJeoZ46HftMTc/9niHX+wDWDpmEYyDwed2mVcQLQXxT4vzN3ctyXs0ArLhxCrberiDBVmCpkF+q
X-Gm-Message-State: AOJu0YwgkUvOFK2c9/LgRlJfVBPSIKSy3FpTcmVIgLBNMQCMI3yIRs12
	A/MpeRQW7cYUtd0zT4Aqdpp7TaqxF1F5Z9DQwUQumGieA0Z77cVc
X-Google-Smtp-Source: AGHT+IF0VrjbGIbQhYRCMf5xKuAStpvCpyCTUseU0aJVLNkpwIUPOJqRq3CzC+nvJ0hAxLInKiGKeA==
X-Received: by 2002:a2e:a443:0:b0:2e9:768a:12ae with SMTP id 38308e7fff4ca-2eadce33be3mr78826211fa.22.1718101006134;
        Tue, 11 Jun 2024 03:16:46 -0700 (PDT)
Received: from f.. (cst-prg-65-249.cust.vodafone.cz. [46.135.65.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c1aa1desm173481275e9.11.2024.06.11.03.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 03:16:45 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	josef@toxicpanda.com,
	hch@infradead.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 2/2] btrfs: use iget5_locked_rcu
Date: Tue, 11 Jun 2024 12:16:32 +0200
Message-ID: <20240611101633.507101-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611101633.507101-1-mjguzik@gmail.com>
References: <20240611101633.507101-1-mjguzik@gmail.com>
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


