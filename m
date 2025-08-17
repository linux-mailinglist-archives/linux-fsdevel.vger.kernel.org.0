Return-Path: <linux-fsdevel+bounces-58082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF02BB29103
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 02:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D76D4E533D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 00:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6317C41AAC;
	Sun, 17 Aug 2025 00:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="A/+ENWGZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ABC2576F
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Aug 2025 00:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755390665; cv=none; b=nCdlQ4wj8P7bhWxB1pGJYyx22HpmvLuv8Ir6cDCaBp9zB7Ubn8a59n6ISoiqQ+mHXSyqXP/3yKVIiNVq3F0dLEp34NXmeNAQONILqcdmT5cyat+ZyWwbSxWk5poSH+v6O8TRnSb3KvwoXVLT56TQskgp7J8ChIUdyZ6wyfl2d8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755390665; c=relaxed/simple;
	bh=x5kKEdqAtqNqNebOaHqfVFdxNqQXrM4MCJceyaZ88dE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YYv61ssLjDbMCB7Op20HDlk0Efm5dzs7mT06BB6FrYsRlGHKJMFgwrT5Jn9J2tWAJ0AboYHtL5OPvjNGZ/7qhMd/lfv1tFPAHzoZk+XS2T8e3tz5802oQ28cLJF9Tp4+iYj1NmklJi+ek6i0I6YdSuxV6PJS8ehzNDfi2kC+nKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=A/+ENWGZ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e870621163so216863585a.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Aug 2025 17:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1755390661; x=1755995461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jcl7rsZFszSewcnT88rggLmO7NWAsdqT18aHbHiVN6c=;
        b=A/+ENWGZurkND4Ms4qh7kHQbTAKPZ4HEBQq6sPC+DwBVY6CDJzORXyiMpiyjLcVtyU
         Wc21fKLElbgo//OlIsICg/J819S4cHtRcLCdDXpG7KU5I7EjphFDxdm3IWK9PFFxnggS
         zsFV2epWKA5Pc1Na3PPq9OF8ZL9zOAtjJH1m5uIWnHV/1C4VOsqvYxSlpu2i5BN2WXYR
         9Hfnaq4epyvsnEtg0/XkpOJwwCTGYctoeFA5an79IhkA/jEy/C/fiZ6euwqFzbLLVl+U
         /k8dD8/L4Rgb4CymoPt0sP6A4clqMtJ3+Sk2GvuMV1FYm/o5MizTNjIf7SoTFgj+rOrK
         dCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755390661; x=1755995461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jcl7rsZFszSewcnT88rggLmO7NWAsdqT18aHbHiVN6c=;
        b=fXSdSDno6wHNFSBVeQCt7XmlNN2X7jVE90hg8w0IYSEBwDtERlKM0ntr0/6UwFt+tL
         9ixvcZaYl1E1PTxE2vMp/egoKZTTJ4yOPaZPrwov2LoKTnbav7wHcWpEOWu/1tqgREr3
         BhoESj1TG/wmryr1DD2OJh3jtx6ygw7EzSVN6QSWDDtAsbHD7HoE21GeLPrrrQdKxexH
         C+BipfIRGgeqLD62pYIHLx2r1ol3Rj3ox3zVcjQTaZowtHq8329ErWFG80MvCv3rllLS
         jeO9UlfPo2Hv0UbwtJWV5s/UUukdXKmVIKXRMCidp8/sue59jLS91TjRU+Kgklhm/k3m
         fgHA==
X-Forwarded-Encrypted: i=1; AJvYcCXJQ7OyO1LMkXxlZeWQTE6PcfGTACPh+/1LpSMeGaIgnkmmyiSjCeVE1K/CPiwzZ1EsNia0yDY5tDo3OL9p@vger.kernel.org
X-Gm-Message-State: AOJu0YwVLipaSfQsjjNDg7ou+nHpfexQGvooURU3goAyAeOdk3bMKLmF
	DNix6M+QpOZEzSjRjLDFktkrC8xMY17V/SZUmWEA/B7gLPpqHl7qGe+SvrxLUV9ammdDWXryAV5
	biY9w
X-Gm-Gg: ASbGncsQrVSZmFDaMwcEC7zm/6dqMv1x6XcTHOpwurG5jtF7rt8P4xMrHyTYM5jcnVK
	M2d6SmNFfB4vd7i+1ttTMIA8XYWtEvgtNU2y3b5EilActMJyqxma1YNz63IVH6OyEVTnULptJRq
	nysDw6k5M9O8rOCX226l6zYr1E9vktK+fs9qwPgEly+GHmtEapO6c1NKVMQ9UhqECbtM4xzGVtx
	0vQ2FcCG2gNPPRzno1g0mFy+HFBGdRfFdVo7Jt+J+Zl/gr4MGG8jo7MMMHPK04Iq5YbR/JTj8iR
	ZR0lOpW7Ak9N6nJIWffEy4NPnKhxuDgutixgH5Y/L11xQChcurgmiAolfiUC/aBFyEB0nygu3VY
	qqS1RsXgghcCpyKbyzcix3vImJgNXsok+A/jL4yi7frliYMQu
X-Google-Smtp-Source: AGHT+IEEAXUblqUo1pTCJqPCUcZNM3yyVVRue/pei3fvPjMKqyyO3FGgVdLsySEbi7BC0g+mx86jqA==
X-Received: by 2002:a05:620a:4515:b0:7e8:3fed:a09a with SMTP id af79cd13be357-7e87df4b3a2mr835441485a.9.1755390661307;
        Sat, 16 Aug 2025 17:31:01 -0700 (PDT)
Received: from ethanf.zetier.com ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e1c42e5sm342402885a.65.2025.08.16.17.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 17:31:00 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH v2 0/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Date: Sat, 16 Aug 2025 20:30:45 -0400
Message-Id: <20250817003046.313497-1-ethan.ferguson@zetier.com>
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

v2:
Fix endianness conversion as reported by kernel test robot
v1:
Link: https://lore.kernel.org/all/20250815171056.103751-1-ethan.ferguson@zetier.com/

Ethan Ferguson (1):
  exfat: Add support for FS_IOC_{GET,SET}FSLABEL
  exfat: Fix endian conversion

 fs/exfat/exfat_fs.h  |  2 +
 fs/exfat/exfat_raw.h |  6 +++
 fs/exfat/file.c      | 56 +++++++++++++++++++++++++
 fs/exfat/super.c     | 99 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 163 insertions(+)

-- 
2.50.1


