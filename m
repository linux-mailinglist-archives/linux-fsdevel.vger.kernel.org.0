Return-Path: <linux-fsdevel+bounces-60990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BE1B540DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 05:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEFE21892141
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 03:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0CB234963;
	Fri, 12 Sep 2025 03:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="Lyy/LcKE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E1556B81
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 03:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757647598; cv=none; b=BNixk+tfremjjualpmAKt3JiHZg02zyD9zbdu9/09/apI12uI+HaSmib+meVDjNnmKtcBl/aVpGcMpSmkkS9hWaLMKlPGl32L/lrRlCVUaC4m1Mqv6Y+YanfXfB3MnlKkzGSmjDGCzSnnT6wI9WfHlGbhx04IveAs0wLxJas84E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757647598; c=relaxed/simple;
	bh=WoQ6z9quahn2OSBOqtcKWk0eGkNESupJ3iBVqZTm0xw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wgc14zFpv50+8C33NnNzTYxzP5IU92LZWIHuDAP71GnIVcrk1Vrqin6qJx0Kc7l05WCl4V1McN889nqafnfwE3RXYjGEAoAUfp084GZuooOvs0RxBDXW+lxB8UIKCxnaaFXBdUVz1dk50+FMfs3cpKu0/zNa0uaTOpRi7eQ4iQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=Lyy/LcKE; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-76b8fd4ba2cso396756d6.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 20:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1757647595; x=1758252395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4kVzdyrDOCzYvNzB91+jleTLDE1xgg7hanprf2gGI3s=;
        b=Lyy/LcKENnDeiL+1JtZK5/nO6/ryCORiHYtzRZLBWJrYk9CpUuznjejHmafl3dbjXI
         X1pTFpI0kogURAWzFgYjVudBb8fLNDJGZpiPrVBGV+uahAHSXuo6i2IOHEigQixJI5TE
         ErVv0aho5S2Pxl9NaTdp1uoFBRfg806msaZseXXdbkMMJ4xHVYMOFsdAN/CfW04MyU+9
         ShEvaGWm165f0wfvuMNPX+vWATrGcbQFDmPE40M7tVEg7TuuiajVrAjOqoOcq4Em7bp0
         ic/0Ok+97vrIxptU6OAjR6FAgSoHJWA8vVNHrCyoh0AaZqiexrNU8U2lHiTkjB0pUVNk
         5aJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757647595; x=1758252395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4kVzdyrDOCzYvNzB91+jleTLDE1xgg7hanprf2gGI3s=;
        b=vQOdgSdXkwYCqoZ1uSEuLJODBrn2fZP2/v0ejRAjHAbpQvxcFKPvYAQQHcOwHBpz7U
         yahLQR0WydFZNuXyHtSwvY8tvLsvZNMxx4wvbibBbRDs+7e3HtkwB+e4rkWU1zZY98Nt
         5VQ/ntBZIOxba/SC+K1Jp6oLsWs7z+88/Zd9nfnot2+jnAlOsEtr0+Tch2g9Q8V311S4
         SfVQ5OCISin0a7918a5ghg199sAi6a5w5QYfEqqE6lCwZDTBhJBvaIDbsTDNWNVuEzgc
         jRl2dnIUJx5xtxbyD2qNNrguMyzjz7u1aornzvrGXK+kG0H3Sd6g8Xbf83JXKWdbKcBx
         YEeA==
X-Gm-Message-State: AOJu0YxFFrBzkpNgXDO91mLaBPw5DsrKrTmmtfYqymmTYHMPuwmymCRO
	+5AVEx0PqGqISLhG61dhziKd6E/oEOorYLB2mg6bWlkgVSk3HsJ4ZWeeUu7ai8twPNs=
X-Gm-Gg: ASbGncsaNupkFK6NvwqmHTP1Tu+wfu9Omek3gMTtJWK0L5JEDWZgiCxaiWlHdQpSSog
	A/nS2VXoET0VYkWC0PqhviTiBKcN7B+5padKtyEeLB/jRVxJ3YzbRIZKdLf6DUfFyViDoN91R0e
	f1DT+nP6Vkkx9JmU713sKMIQ9aSetsNe4B7EtkPluRNEd7BBOuU3UBum7oGkI7DTIZCGNM0VOZf
	1zceSUO87C7iU+7H4hUX7bs6ftzkeKG4Ulrj2WyVG7tEjzA8KLKamc6/72feu1WLn90kREWW71V
	lo99YY872Y4OwfbEyxQdfdSFOixxccVQJVnRn31Azvg+RFxbO/9iMjSyu+zeShSk+9IeWToamqH
	u6yczltnAP4DilHfC8Qb6tzJvuhgR0vGTwVrM1TPW1eaQkxDd
X-Google-Smtp-Source: AGHT+IHwOPvghqdNM8F4zeNwWMV1Im3cKI9MoG9jNGONp6ffStJObi0wHmwwCeO/lc6VKRzZIUTtjA==
X-Received: by 2002:a05:6214:301a:b0:71b:9c1f:cf12 with SMTP id 6a1803df08f44-767c59f7793mr18114526d6.58.1757647594897;
        Thu, 11 Sep 2025 20:26:34 -0700 (PDT)
Received: from ethanf.zetier.com ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-763c19e7faesm20195776d6.72.2025.09.11.20.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 20:26:34 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cpgs@samsung.com,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH v7 0/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Date: Thu, 11 Sep 2025 23:26:18 -0400
Message-Id: <20250912032619.9846-1-ethan.ferguson@zetier.com>
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

v7:
Accepted changes from Yuezhang Mo <Yuezhang.Mo@sony.com>
* More accurate hint femp setting
* Logic simplification
* Reduced buffer_head usage
v6:
Moved creating new volume label dentry out of
exfat_get_volume_label_ptrs.
Use exfat_find_empty_entry to allocate new volume label dentry.
Better usage of hint_femp.
Use ALLOC_FAT_CHAIN in root directory.
Only allocate new volume label dentry when the label length > 0.
Link: https://lore.kernel.org/all/20250908164028.31711-1-ethan.ferguson@zetier.com/
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

 fs/exfat/dir.c       | 158 +++++++++++++++++++++++++++++++++++++++++++
 fs/exfat/exfat_fs.h  |   7 ++
 fs/exfat/exfat_raw.h |   6 ++
 fs/exfat/file.c      |  52 ++++++++++++++
 fs/exfat/namei.c     |   2 +-
 5 files changed, 224 insertions(+), 1 deletion(-)

-- 
2.34.1


