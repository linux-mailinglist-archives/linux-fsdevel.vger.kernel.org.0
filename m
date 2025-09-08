Return-Path: <linux-fsdevel+bounces-60574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6932B495C1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 18:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F5EE20485D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 16:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CCC3115A9;
	Mon,  8 Sep 2025 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="BUFHA77e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F154310785
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349640; cv=none; b=NYJyljajV7SHPelKJN/QGEp42cAkIvcEkX7zwdGzWaSGttowb0woOSwgDa4Izx3dfKnZAQue3UdFYyv2ef05P+kTsrXTg1TF4LTcgIg4nM/pIw4u5C06C/0iNc/JZ3tOHqRRX7cglxqGzPFoC2KW6rwLFqzhnp5Ks3aJB3832qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349640; c=relaxed/simple;
	bh=+vkaI5ZT9MLlnriDLDmEJpD4xCCxTT2lOxENtw3F3ks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hLbhkxDKkSuIJuFhKcqubO9vzvwBzDA2alWnjp2XGzE8KdOVMvL/arQwBqtZob5jabGRjk1mmYozohnOiAmajrEh3eREs+JQd6oezhbmVVq60byg831kunp50XHshrEQ2Q49FTpeFoFKFYb3D38l9qIwr2OUJWO1oUUF2PyVFys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=BUFHA77e; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-721c6ffab58so36493826d6.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Sep 2025 09:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1757349637; x=1757954437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7aH48sARri1tjmPkaUxfeb9p/pVFZ0oqSNGlJ0Jei0U=;
        b=BUFHA77eDhnv4MFUrkSvMDfP9hmvD66Pyt4+WSU6tLMe9vWga4oMqi3UkH1SpdbRxb
         0qwY6fmEhMm3KgTTjTRQDHWd/42TNKhJfT7+YDJZXzTSpLxAtUYdC13wzjjBPaQQqTJF
         9u88GnJx2HXbyltmRKLwpRg74sVo+LvC+YpDkqX2CFR9nQtl1m3TqcZkmmazHOOvzBi1
         uFEhrHHXF32L4viF6EWu7kOsm4KZNsyuK5w7loOB8hbFQcJCNZdq6Dk85BN1gmfzL4oW
         klI5CxDfwdGv/NmO+5Kk+4dNAXzNxSX1TW4zRfZJwKlxKSa5Tqx/b6Py6BQvuk3W/1Oi
         pwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757349637; x=1757954437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7aH48sARri1tjmPkaUxfeb9p/pVFZ0oqSNGlJ0Jei0U=;
        b=OfZVr/RbmpsXaiP8ZBjHg9mZK6HXBvOZSqssL35L5DOJw/3m6FbxSePfcEfIAjxnOD
         hhDTLyUS8ugJZFr83EGDw0rDuiOrXGeeTn3/PC8GfOJSYSjNVrFw03lbiUvxBoO4IDPP
         +oSKRshP5+O2OIGab66pTu589iTBt4HFWITgtixcgZ2kqmHY5Y8aETE9Gqsa+L7VQrcq
         85xgCSXV/lxrw2dl8oFV3CoQ3wvE3DYL/dcZXV3TMuzSsfE4ker1ToLi5bjOGByiVdsB
         7BbnLXEg40XBAMKnhG6okg7F0zs5qpjwKcJ5Ic0T0/UL2zV5Zh5ycvxZ7oW2wQzhyUFR
         1LSA==
X-Forwarded-Encrypted: i=1; AJvYcCWiJYfoA1uktiWlsIskCd1hzpiRr7ofwgSGVOZxXecxDnErT3vgng+ZgjT4VpPO7Nk6D58HOq1vvza8F30k@vger.kernel.org
X-Gm-Message-State: AOJu0YzhmUntJwhC8wQvqscBRZef6s0loEEPYlArvfn4+roRw+cG4Shr
	sf6cBShCxTJMbbASRDbljYCa2WHElC+nmK74Y5Yi8zCsOFDTypiSNPhY3hwQO06G7xk=
X-Gm-Gg: ASbGncsh3moavrDXZZ1JANY+JLFvCDKEa2/6oZ7Q8xAvATCSHixenHFpUnyYIusvTBV
	erJ6b+B6MheYRn/fpAaunyGp47oYiEddJJuyWZ3jU5QIGu5QvLNEXlqu0uq8A1DxwegHT4/oDWA
	mW4RouIsGN6MTgmlaO1FUX2esc717FPGSnbngYT5Zd0vNJFbweS3VTeOntqCw04EVStKbaSBmE8
	BTnZBayXfXEfPgQYPLOa/dvO7BWHNLwFFus/xqwZnBH0rjBhe9RwBGPjjgj4wn096T7ruGL7HG9
	3lXQaUa+BjK80OXcQmyRwZQoHXRsjV3mRTSg+utT56U8LCKVzYOjt7wpS2qKdphYy9/Kp3XDEAz
	DC0cBEurSDpcGF1ekRb5O1jzwz1Bftm+vJkx4DdMy9y+DU+CR
X-Google-Smtp-Source: AGHT+IHeCs3mzJUVBUfpFzvIyt6k/471lMNGsYJ3oUPFdyt4l+rbrBgDca6rTrRLdwfp8Xxp21VYmA==
X-Received: by 2002:ad4:5965:0:b0:72c:3873:2e43 with SMTP id 6a1803df08f44-739322fe85dmr113949406d6.25.1757349637220;
        Mon, 08 Sep 2025 09:40:37 -0700 (PDT)
Received: from ethanf.zetier.com ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-72a2d06b9b5sm88751706d6.70.2025.09.08.09.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 09:40:36 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Cc: cpgs@samsung.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH v6 0/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Date: Mon,  8 Sep 2025 12:40:27 -0400
Message-Id: <20250908164028.31711-1-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for reading / writing to the exfat volume label from the
FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls.

Implemented in similar ways to other fs drivers, namely btrfs and ext4,
where the ioctls are performed on file inodes.

v6:
Moved creating new volume label dentry out of
exfat_get_volume_label_ptrs.
Use exfat_find_empty_entry to allocate new volume label dentry.
Better usage of hint_femp.
Use ALLOC_FAT_CHAIN in root directory.
Only allocate new volume label dentry when the label length > 0.
v5:
Change behavior to only allocate new cluster when no useable dentries
exist.
Leverage exfat_find_empty_entry to handle this behavior, and to set
inode size.
Update inode hint_femp to speed up later search efforts.
Link: https://lore.kernel.org/all/20250903183322.191136-1-ethan.ferguson@zetier.com/
v4:
Implement allocating a new cluster when the current dentry cluster would
be full as a result of inserting a volume label dentry.
Link: https://lore.kernel.org/all/20250822202010.232922-1-ethan.ferguson@zetier.com/
v3:
Add lazy-loading of volume label into superblock.
Use better UTF-16 conversions to detect invalid characters.
If no volume label entry exists, overwrite a deleted dentry,
or create a new dentry if the cluster has space.
Link: https://lore.kernel.org/all/20250821150926.1025302-1-ethan.ferguson@zetier.com/
v2:
Fix endianness conversion as reported by kernel test robot
Link: https://lore.kernel.org/all/20250817003046.313497-1-ethan.ferguson@zetier.com/
v1:
Link: https://lore.kernel.org/all/20250815171056.103751-1-ethan.ferguson@zetier.com/

Ethan Ferguson (1):
  exfat: Add support for FS_IOC_{GET,SET}FSLABEL

 fs/exfat/dir.c       | 162 +++++++++++++++++++++++++++++++++++++++++++
 fs/exfat/exfat_fs.h  |   7 ++
 fs/exfat/exfat_raw.h |   6 ++
 fs/exfat/file.c      |  80 +++++++++++++++++++++
 fs/exfat/namei.c     |   2 +-
 5 files changed, 256 insertions(+), 1 deletion(-)

-- 
2.34.1


