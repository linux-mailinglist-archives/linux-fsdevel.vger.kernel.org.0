Return-Path: <linux-fsdevel+bounces-67357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2322FC3CFED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 19:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527223BAFAF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 18:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F027D34F246;
	Thu,  6 Nov 2025 18:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4XyW7vN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91296EACE
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762452075; cv=none; b=WcUPRSEpHrJNGz2cudADnmRAqW2Z5Qby45Urj08EURmjt4eDOPrFwqZvYnMdrqmYjiNWhclTHdUGkMwPV/RIwwhqsQ0ZKdbetB3cemfVQTBunGemD7fUs/RF/DHHL1PJlfTpDCdCXjy1gYJyBP1oo1iJYxyDcofDA0lzv1B9PPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762452075; c=relaxed/simple;
	bh=d6fcH4YBy4tJrSO/61Sxb3Q4+XTZBualHoVt8LZv+l4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N3P6duiPn5G+vqwDLpIODhhggjl+8blfKF+1juCtXUgM3wHWW0v8mHoxbc5cnTs+89Fvidv2TZ/22cA23bcohZk3Xw8sA6w5rJJmGeTt0goV7CQ/XnBp/JqDt44ULjzKLkl50/cXpFJmek8pTgdPBRk0I8ElexXscr5XTaC2Rxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4XyW7vN; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b714b1290aeso160709466b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 10:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762452071; x=1763056871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2T3N0BT2STs8n+iZkoEMWI+F1MMhUxu61N6/yM0vzrc=;
        b=H4XyW7vNizeqxrowPTLAfeOBkxdjSJITunlBteHpteph+J+7BmYmJCpR9GrFefnTTY
         6nZipxgJ1VsZ41P0dGGWhJqrSOhiAemwl6HohvZVI4zDTK/VThxaM4QARJZ2wVFOPtRn
         90oB05KIAkDTE6XFXDh9ySSGNPKt/2ZNo1bFKI1nzutr9tBLe+W2s+2/qc9ATVQ6NxYF
         opKDplbrNWInoix5Pir7KA9QAt4ig5OudhDDU8wPkTjNULayXg5VZX0MsSbZcXPof6CJ
         mljex2KoNGh0VOdAMvKaMes93OGIqGHv7VXc4oMJkvrP5MNecRl91Iw920w7WttD9AHo
         he7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762452071; x=1763056871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2T3N0BT2STs8n+iZkoEMWI+F1MMhUxu61N6/yM0vzrc=;
        b=QdkfEKpckKDsyih8orgIcpoVX/qmdUU5re4cMUF0+4Rk5fUSa4o5wsX1MDu0Rw81pD
         UVnDyLwkAMHNLwFuJmAxogVzIjaQXeF0SkvbUZhyKm5MPj7DTpcnEC0rpSjM+B7V8pQE
         PnoHIppI2UfebLY+QyLBTUQ+V6ktuXS/XbWkCTkmMIMNNZZPsfewpWLNFa4BYTFyvxnM
         I0DHdCvaP0cizSlRrll4i2a/Ak4dJ6jZHtyP+TMAm1Nj3qPCRTFifZxAdk7VwppdpJDF
         waaBuBIlUH8s8c2fHONqQvc265gW9UZpyIjdCrNZ4ncZX3xulZ0bzaoWr88JvQ4Tcw+E
         lkag==
X-Forwarded-Encrypted: i=1; AJvYcCUKGzD8uaMEeZo3/SzAbxNnV2+0YDdsKP9QTi5FEPy7mwYLjamls45VcnMCyYsFq9nMpEmWYuS5mwcbxuwY@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr1ebYiVo9CTeTvxWxwa1eOhTbC0CLVPeyaytsHVJ3xay3DyqD
	X6rzG6hYik+DxEDF9pPjLYe8sQ8Blt+RveF0SjYPPhvlThstfbEvrI9/
X-Gm-Gg: ASbGncvhDdKR4ubpmBUKL/ELySy0KLelLIAtXE+2yHGC3AXLfUrnkc4yPpFl1jDVoMg
	M7BVTE1Obu/2MlhEqmFUBDnpacMDVRqOb+OuayT5hGB2bq7pvljaTEtmeyZLuM3nA2uRCGuHxM+
	sCm4PFDDZTMXQhNpRn3NUyD3xgm6BDddlbBt6YkVJWx7shsTzk27yCHWfLwZf1P8uXu9UqeuIc+
	+nW0ktJKClnWlwV7BfYMbWkA4tdJuneMqA2NwVV6g8/DDPsEyhR8DMFYL/1/qCMouKt2GQtzp6P
	b4/F4jNhUmTM4c3DyOlo5HEx0A9j2ACGudhp53499d6BfSAIbada4BrZh/etry7ky8OJnUG72gT
	dxGgZ5zNUhUCRWJP39kRn+DP0ZFK2evaUZSHVFfBVUtGhV9203vYV+mC3DPeyExF625w0HP5Q9g
	p35XHYnjFmxMjjdigPRwCuO3bZiddcIsJEgriDtSU2rhZc2T4n
X-Google-Smtp-Source: AGHT+IHjp607z6cdgZ7HFt5E5SFL6QJoNHGzb+TT6QDSql6CaQ0lp76FRbpfISADQTjtlAYn9VTXPA==
X-Received: by 2002:a17:907:9607:b0:b70:b5b9:1f82 with SMTP id a640c23a62f3a-b72c0abcb78mr4492966b.31.1762452070474;
        Thu, 06 Nov 2025 10:01:10 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa0f1bbsm15430466b.65.2025.11.06.10.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 10:01:09 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	torvalds@linux-foundation.org,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 0/4] permission check avoidance during lookup
Date: Thu,  6 Nov 2025 19:00:58 +0100
Message-ID: <20251106180103.923856-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To quote from patch 1:
<quote>
Vast majority of real-world lookups happen on directories which are
traversable by anyone. Figuring out that this holds for a given inode
can be done when instantiating it or changing permissions, avoiding the
overhead during lookup. Stats below.

A simple microbench of stating /usr/include/linux/fs.h on ext4 in a loop
on Sapphire Rapids (ops/s):
before: 3640352
after:  3797258 (+4%)
</quote>

During a kernel build about 90% of all lookups managed to skip
permission checks in my setup, see the commit message for a breakdown.

WARNING: more testing is needed for correctness, but I'm largely happy
with the state as is.

WARNING: I'm assuming the following bit is applied:
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 78ea864fa8cd..eaf776cd4175 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5518,6 +5518,10 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
                goto bad_inode;
        brelse(iloc.bh);
 
+       /* Initialize the "no ACL's" state for the simple cases */
+       if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR) && !ei->i_file_acl)
+               cache_no_acl(inode);
+
        unlock_new_inode(inode);
        return inode;

Lack of the patch does not affect correctness, but it does make the
patch ineffective for ext4. I did not include it in the posting as other
people promised to sort it out.

Discussion is here with an ack from Jan:
https://lore.kernel.org/linux-fsdevel/kn44smk4dgaj5rqmtcfr7ruecixzrik6omur2l2opitn7lbvfm@rm4y24fcfzbz/T/#m30d6cea6be48e95c0d824e98a328fb90c7a5766d
and full thread:
https://lore.kernel.org/linux-fsdevel/kn44smk4dgaj5rqmtcfr7ruecixzrik6omur2l2opitn7lbvfm@rm4y24fcfzbz/T/#t

v2:
- productize
- btrfs and tmpfs support

Mateusz Guzik (4):
  fs: speed up path lookup with cheaper MAY_EXEC checks
  ext4: opt-in for IOP_MAY_FAST_EXEC
  btrfs: opt-in for IOP_MAY_FAST_EXEC
  tmpfs: opt-in for IOP_MAY_FAST_EXEC

 fs/attr.c          |  1 +
 fs/btrfs/inode.c   | 12 +++++-
 fs/ext4/inode.c    |  2 +
 fs/ext4/namei.c    |  1 +
 fs/namei.c         | 95 +++++++++++++++++++++++++++++++++++++++++++++-
 fs/posix_acl.c     |  1 +
 fs/xattr.c         |  1 +
 include/linux/fs.h | 21 +++++++---
 mm/shmem.c         |  9 +++++
 9 files changed, 134 insertions(+), 9 deletions(-)

-- 
2.48.1


