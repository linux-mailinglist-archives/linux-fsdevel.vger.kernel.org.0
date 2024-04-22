Return-Path: <linux-fsdevel+bounces-17368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FBD8AC45A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 08:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B374282EA7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 06:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92357481BA;
	Mon, 22 Apr 2024 06:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRSlv6Em"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778971802B
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Apr 2024 06:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713768016; cv=none; b=ujX60KRaLzwqVlRlzj3o2YKaM+1wf1a4TgSq+SEF/vmGBhbcH9BuceTIXf7rA/09vu4IclBTfy5cTsNygNqrwtFpTaYDWJNrMa5ER/bvL48Hn+e7nEHURi9gKtdRBLVcladsDlWNKexs+Lfn24l47T2o1B7MuJlwnIppnIz4F0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713768016; c=relaxed/simple;
	bh=pcYaF0YU6PZi3Ku/k1oGWr3IMvM6IdOBmRz7IWkyG5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R4vctjvPm5DhRVa8y12cAcQNIpMfoieTZVVupCuv5oVACE6Yq0ktfeKamW8rS9RnkqAgV1IoKk+9nKQv5PHYOkF/2Jkxc89vE1AV2crNtlajfpwEcuQe7vRxmewBmpN/vmz1KkWS2tEoSdE5JnT8pjfyj06JPQKvvrS848nknwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRSlv6Em; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2db101c11beso46408321fa.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Apr 2024 23:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713768013; x=1714372813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7tfQ6EVPCGz3ao8O4D9UwN8hwYPcdQ5m3SSswwth6y8=;
        b=hRSlv6EmU8Eh73ccGUu13R/mHGwNtn7IO8nh5spPTN2cj/klKHR5mDlL1Sq39++cTr
         kySM+Dj19ryQbWhwBcn5uqtlvnkkaGvya8kcUmtpanw1v0n58aJjtvS6HIYEllLC1Ben
         mzrQ4eEoBneNJgcoZNltIj3y5iDXvugGFySMqnajwXCmk0yVYzCeBCxAuKaj8g4cogqn
         U65opgEVqa31ovfFw4SxFHdbH2e6Mu3YA3EAahcKmn2qgD/grWgi3X7mJ2muAFLiEduP
         5Lp5woXKvaBuo4mievvmU4w1VYLkVjC6Ebq9J6H9/17PCwogbw8hA6Ze1jDu/vVR9bDk
         Ni2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713768013; x=1714372813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7tfQ6EVPCGz3ao8O4D9UwN8hwYPcdQ5m3SSswwth6y8=;
        b=azsiF7Z4Cgm6TEZq7/hny0PmHtsB0AxmX2YnnDgGEWKSvIE/VTDBOuNm+Bumw9z705
         WfasyzkwhzO/Pzb7wA4yrfFn1afYq9y48K2INSn451jklN1yOKFF2a+az2dKX+22YIrh
         4sNGuG76qXORYCpsR4YRRA61kVi5tE4B967Nmh4/2hhYHhF+ngX94jO/Amp/xZ2seFka
         i9h3udNpkRZS985dCmIaKkv5lLZ9ctrAxAaeF84HSfsukDpD9ZNPiKKH8daFU7EFTwNM
         UFGiwzBL1Bc6ptJxTssNHKObie/rMoRAYXOtIhxuHMCfQffo3qZuTIp1GJla6XKaUBkI
         aE9w==
X-Forwarded-Encrypted: i=1; AJvYcCXTfojGy+vzMb7s+fV7Kwgcc0N2uQrav9gd3BZ7ulJp53Fn+jq55GnUsJd/NVOq0QJGJKfAGBBuPSXD/fG+bkVyMpD9VyiYPQ1jSiXAlg==
X-Gm-Message-State: AOJu0YyMx9QBYBf/IVXKWwvZbP4okKXZnwoessWJqAJwXHR/icR3/VCC
	mvrld4LSW9zICNBNxzybLB/9yKMszUsc0Jt6Osv6JrYnIrWP9mpU0HrALg==
X-Google-Smtp-Source: AGHT+IEq7Aq7z8R6CxagCtE4FOoGODeryeSxOs4aZlufS/Q8EL/EQWEfyUb3WrzWZmFUttmhrRLCmA==
X-Received: by 2002:a2e:9895:0:b0:2d7:1a30:e881 with SMTP id b21-20020a2e9895000000b002d71a30e881mr5185823ljj.12.1713768012366;
        Sun, 21 Apr 2024 23:40:12 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan (85-250-214-4.bb.netvision.net.il. [85.250.214.4])
        by smtp.gmail.com with ESMTPSA id iv19-20020a05600c549300b004186c58a9b5sm15271353wmb.44.2024.04.21.23.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 23:40:11 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Daniel Rosenberg <drosen@google.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fuse: verify zero padding in fuse_backing_map
Date: Mon, 22 Apr 2024 09:40:08 +0300
Message-Id: <20240422064008.936525-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To allow us extending the interface in the future.

Fixes: 44350256ab94 ("fuse: implement ioctls to manage backing files")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/passthrough.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 1567f0323858..9666d13884ce 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -225,7 +225,7 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 		goto out;
 
 	res = -EINVAL;
-	if (map->flags)
+	if (map->flags || map->padding)
 		goto out;
 
 	file = fget(map->fd);
-- 
2.34.1


