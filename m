Return-Path: <linux-fsdevel+bounces-60191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5A5B428B7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 20:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DCEE1BA13D0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 18:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A82F1624C0;
	Wed,  3 Sep 2025 18:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="RNG3T+bw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEB72C21F6
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756924412; cv=none; b=s1knCGhGEdm71R8NjoZ02r/I3685Dty6IQMMUu1cKjisyHbZQY3TROzAe6NX28G9g1Ew9HTJGMUXDrQlI9HyWYKYfHB3RqjBUUIq4qLrm04sEkGtdE2Z8ik8WMRqLMu749rdPfMOKhAIDIJc7H/DqphZHJFBWvaeahveuoO+j2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756924412; c=relaxed/simple;
	bh=0qgglxasLkzPr6XRpOEKv7fQ2J/IzxLLXQTec8udKmU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ph+ds/OqjugxFmnvF0q8bF5OA0lee8TuZ1IJZ4XsuQg/wLsUYy0gkKDjlGsbE/1DxXCW7L5aWbXUg8J25VKe05D2jipU8LyvCGAXXB4vjKEBcebpsg01+GyvjZRrZgUGbxH00glSo/W2yuyavDCs9C8sLg4gkyzgtUJXpiutLBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=RNG3T+bw; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-7221ce7e814so1170596d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Sep 2025 11:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1756924410; x=1757529210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S879IOAS7I2KrrMY7ilhyLTemY3z54jAwRhHsZnwFTo=;
        b=RNG3T+bwgjM6CDFIZsb93nDEtjxJmAeY6MhmKlu9mgsgW3g/qGOEQ04FPZ+SYV7/9C
         HZFZITicOu9KRSNVpEoNGj59GMOVpxwYItKnD9V1UYVbT2sxL2XfzHOLGMxq4v+8njlA
         NAEDIxaLbqFjbHg914/euxGuS+OYOZ3HEKYI4M8vAtZ1h+48oSO46V5L6Mee2VVx5MVM
         WVJmYtrxR0n9KhC1cLlvT05Em/BNYBylcmPRbPaBBIYZzPa3XkaebvkU43z/EYCOLRWc
         Aw+gtQ4njMljl5Wp9PDLOYnnBnz8TL+UxpAMantc401e7iJxQXQAhQKbFaAUNdWs6hvM
         LJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756924410; x=1757529210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S879IOAS7I2KrrMY7ilhyLTemY3z54jAwRhHsZnwFTo=;
        b=E4ufy8lrotEKegw/t78zXQE7CBUCyhit1w7voqt3QEZ4YfGPYZVBKFu3b2uDB/MUyf
         Jf4e4NrJ7TpeLs0wvZ/fCs7nlbUkT1XbvnC10/5mvOZ0Oj3hEN0R5hcFQLL+FuEU3rra
         Y1m+Yf4CE2cSMC0s6olmuzxO8XcNm1o2s+HHQsbrtvt2NMJXuWN5O8rJSbv32LZ41Cc2
         nNz1LA4tgaT6jGptGTAeZQWVfuNCXar0fKbiByq6UbFh/kpaC1ycjB2uDvTxfUKQz7YC
         oTxyf3C82bR0iNmxaBB0dLRKsw/9W/+FqDs63JcKc43zNP56nb2DSQ8p18pjB8mI0vu4
         RAZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9UhUzHW3dk45dXrcpe4z+7HkQTnuxwB1FhJsu2LgTxEzMAz+wWPcP4Sphd7/0f1IprIBNHpgw0dnm+5z5@vger.kernel.org
X-Gm-Message-State: AOJu0Yz64aH+1KZWG0tkfljFpmeMjsig6HmDseKolPzfsHb+qm1cFfAC
	Z5OTGL8OW4/xwE1Dc5L9Kkl3ETJlD1L5s8s/8zrjlhuNd1mIk48nybol2rqoIMf3WEU=
X-Gm-Gg: ASbGnctnbQC5gwSuvr4TOSuZipthely4bczB6MC+zSMe3QhOzPv5ixBKOr2GpSW0xwE
	ppmZCs/b6yy8+uAJ9tGGl/hXi04OSqHr6geMNTEm6ZWBh4gjj2s/qZoLes+bmQYzA1bpmrneWsw
	macjXxz5CzbgG46ttM3LwjSSkLc5eAwKaf9cJQo/MPX3iIbxiGsmwgBy5nk46xPzJknBhVj8GGr
	PiWQwbRQBMHal0mr2VUoFavYE8V5f3W6vnmImwEWpI/tsolME4k8SoMRsk85qOKXSHkmYv+kL0j
	5AzDDoEzERbLdZVEL+BkVyhncYq8VmoAy1RZwVrA3yyZE543F7+8qaDBb5hJCDnpAlf+HmkykEp
	vqxtJDWp7RpquYSuHXWpRrAfAeHYr7EB7O1F7lQ==
X-Google-Smtp-Source: AGHT+IHf52BqKSn+x2MgFKInih4yT+Gwmue5zsea2Bfw0PtVlqwJUW1IjdXrNUhs6WCY1OjVT8eXUg==
X-Received: by 2002:a05:6214:2e85:b0:722:25e8:b488 with SMTP id 6a1803df08f44-72225e8c257mr45633516d6.27.1756924409618;
        Wed, 03 Sep 2025 11:33:29 -0700 (PDT)
Received: from ethanf.zetier.com ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-72160017b64sm28699916d6.55.2025.09.03.11.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 11:33:28 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Cc: cpgs@samsung.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH v5 0/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Date: Wed,  3 Sep 2025 14:33:21 -0400
Message-Id: <20250903183322.191136-1-ethan.ferguson@zetier.com>
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

v5:
Change behavior to only allocate new cluster when no useable dentries
exist.
Leverage exfat_find_empty_entry to handle this behavior, and to set
inode size.
Update inode hint_femp to speed up later search efforts.
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

 fs/exfat/exfat_fs.h  |   7 ++
 fs/exfat/exfat_raw.h |   6 ++
 fs/exfat/file.c      |  80 +++++++++++++++++++++
 fs/exfat/namei.c     |   2 +-
 fs/exfat/super.c     | 165 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 259 insertions(+), 1 deletion(-)

-- 
2.34.1


