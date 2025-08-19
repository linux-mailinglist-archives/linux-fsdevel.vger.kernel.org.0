Return-Path: <linux-fsdevel+bounces-58343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40721B2CF1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 00:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27362528230
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 22:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2126353375;
	Tue, 19 Aug 2025 22:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeHd16bj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06A0353365;
	Tue, 19 Aug 2025 22:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755641454; cv=none; b=g8KK6LjDaEB3nmvbxgZ0ZK7+OxogrZDSQIPvrRnDk0NXS4IW5PrSWKzrWTcXYWey5r5TzQ7LrYml+qAruQ7L7sJx7nsD58IgXOlX0IV8KfJ3A81X1GL8X56+W0t63rr18iCwy8BgbNv9Z359qX9R1tqfnJVr4MgFuQbDH1NA9rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755641454; c=relaxed/simple;
	bh=RzHLAM+vR1yfQ2rkga0oh98udZ9Hjq/Uod6Q+MZyEiE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eLJLsn0MOwe0XgDx2HuLrBi+UZoKeJF6itQ39dqUF4HMpSN44v2wUjLz3Qhn23Sc+jDH7fU/DPBu8ar2tbXtuEF1+DhP8DjW+b4UXi/TWi6ILgITJuqcSXFUy4S+L8TLJJzKyd8hiMQN7vqz1pT7uXI7acrjPQd3W0lEF0b5Q9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeHd16bj; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32326e7baa1so4678612a91.3;
        Tue, 19 Aug 2025 15:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755641452; x=1756246252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TeiT9OcLQWUgDSxLdNOtplAV1IBPLuJOw6NQPgmPO9A=;
        b=NeHd16bj4mAfjCSmUaxH+kqQyQ6/94KCbOa2fX237ldTC3Z/MQ4u4dBMBR48uBmIUp
         8rkdjCV/In70uoPbSmi9ynPLuf2QfE+aBPOF395LmH+eDD7raBVL/CkKhA3fqDwD803o
         w2ZSorpXrGsyOKjbXZoCdzxgenJNugPuBQkS3ipItH7KqO8e8Ar2iCSxDVirWAi1A4Gi
         uXrPHJx1rZtuxW0SkbTLYFQN4+3ZtfD2DytvMo9Q9B4SVm9igzR6VVuRxHJxTR8J+mm1
         9Daa/RrzcALMsP778cN7GWBljImlXGIrxizhTVjOqAwouNwKAGRENgtlbobet93i24Fz
         3NZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755641452; x=1756246252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TeiT9OcLQWUgDSxLdNOtplAV1IBPLuJOw6NQPgmPO9A=;
        b=pW+HFgfTyXPMuOw4EC2jOvWIVnZMCYNwx7tbFO5QLDC6p0GEjoxD1j0edcPZdnt9RS
         mMGLFm1X/mcn8ulPw18f2kAHj0JSsm5fMR6H5rt8JQyY5zhayu0BovO/QTed7Jmk86ny
         k2rXwM1Tu3/U92tNtCCpagDZsyn1rioznCQg9wgqapT0MZclp6Sdui1AUZ/RbLjWReEX
         E+9CNa1ZeZ3KmkCcrHYNjsthsRAPhcycUsylP5dqNKzLNHKTERy70/uhONPUP9snZ3d4
         k1qqdpt9vNooFCxcB6mY63kmtIRQCl/LaKJsg/zPlnTluA2mmsyyFEaLqWw9yGa0bAt9
         iRBw==
X-Forwarded-Encrypted: i=1; AJvYcCXbDTkQNcD/8ng7YuijQis1X17rfC08qkI5ZOoPlKFSfgGPxhqEIQGpc8mbOcENePhvxbMc3B00E4Mi8w5G@vger.kernel.org, AJvYcCXt4G2qFrq/FdIoDSghARt8IWzIpE47EsXyXRXAn5RNRBiaG32PyKVCMrkHTCEpLgMysEW2GbT3I3MkCATM@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzz2NO4Pk7N1fUJGQTGP4a2l9aTAMSr8777lgVhHeniRYo3KzA
	ll9aEq7BzRrND2bnmNedh1zaqo4Hylt7M8i7U2asU9Nj1++Q6liVKH8p
X-Gm-Gg: ASbGncsH5UrlnB5u3y69vV4Uev/StiV57VPU9Z4UqQ6KKgH4a21zuJOVFw5wMZTkaLp
	mIfMngV+7o0bHzpSFe+5GlQAFKNkuzRu1h+wX8I5Nj4EDLX5htEZwi/njIt6iLpz4Eat7ZWKU8z
	sGfZYRJBCvcezB+BDBNaww25b9EoHy5xvpaJNcJp++F+74w54XXzoF/NfYmqLc7RhGpGBL/hDy+
	NF4rCnAzfdG3kEWwSganEK98WfRxCmSIdnvomIeuLnXUjUj+g1LG3CGlj5iACGREIhtidk5+Nyj
	mOSDbDF1qwX/wEcpJDJhzg60aA33gSwcPbaeAv7cdtNraIuro//UTpJg4FRHQEUN4MIBUgAEgQR
	DLTOFuetZMgQOL72HiyHSxE50spXFhvL29TXwr97v
X-Google-Smtp-Source: AGHT+IGjxpyaU3AbdAKpHGLdcRBSqbJ20gt7oHp2uWKijTuRiqhD65a32hUUDw3KEbuDIxmi/S9LRw==
X-Received: by 2002:a17:90b:560b:b0:311:eb85:96df with SMTP id 98e67ed59e1d1-324e13e0f8emr912988a91.17.1755641452024;
        Tue, 19 Aug 2025 15:10:52 -0700 (PDT)
Received: from jaimin-latitude.. ([2401:4900:4e6e:b7b2:534:4b72:c385:7243])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-245ed4ccb33sm6936675ad.100.2025.08.19.15.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 15:10:51 -0700 (PDT)
From: Jaimin Parmar <parmarjaimin.19@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Jaimin Parmar <parmarjaimin.19@gmail.com>
Subject: [PATCH] fs: document 'name' parameter in name_contains_dotdot()
Date: Wed, 20 Aug 2025 03:40:42 +0530
Message-Id: <20250819221042.170078-1-parmarjaimin.19@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the following kernel-doc warning in include/linux/fs.h:

  WARNING: ./include/linux/fs.h:3287 function parameter 'name' not described in 'name_contains_dotdot'

The function comment for name_contains_dotdot() did not describe its
@name argument.
Updated the function comment by adding @name parameter description.

Fixes: 0da3e3822cfa ("fs: move name_contains_dotdot() to header")
Signed-off-by: Jaimin Parmar <parmarjaimin.19@gmail.com>

diff --git a/include/linux/fs.h b/include/linux/fs.h
index d7ab4f96d705..74fe7f445c6c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3281,6 +3281,7 @@ static inline bool is_dot_dotdot(const char *name, size_t len)
 
 /**
  * name_contains_dotdot - check if a file name contains ".." path components
+ * @name: file name or path string to check
  *
  * Search for ".." surrounded by either '/' or start/end of string.
  */
-- 
2.34.1


