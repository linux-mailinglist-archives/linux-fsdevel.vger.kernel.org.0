Return-Path: <linux-fsdevel+bounces-38170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A72869FD78B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 20:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEE377A0425
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 19:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851E71F8696;
	Fri, 27 Dec 2024 19:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrFv7GSt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D14482F2;
	Fri, 27 Dec 2024 19:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735328079; cv=none; b=k840hkiLUBn7aWp3Qbt3mYR1SB0c8iRBXgjNYPo9IGx2dWGSpOImhDk1AotlcW6Vt4GUuJ7c6lHvRK5JG1aXhZScsYLO9i3XByu7W3TrnuCjD8YB14ijcjPGssr5Z2RwZjadjTwfsBOIs9XJ2JHt3nSXIVAUF3pAP7LCe+kg6RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735328079; c=relaxed/simple;
	bh=bXnzQF/iE1rymYNUyll/mQvo5W/u2SeFykwZWYBBBG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=natQWHZYZgpeSXVxqrs7Bozwl3P/mkNGomaPqqniiAfVvk4yaeQmUsKbWZzsVeGV7/2Vfb4Q9rUPwUYz5by+xJUlOFKLpvureOu6k4D9RLKylxOf2W58+LqqDJ9j2YDvD6WtKtamWTgj69UezxG5I/b5g5fhCUhO+xLSvKzNJ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrFv7GSt; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e479e529ebcso8109899276.3;
        Fri, 27 Dec 2024 11:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735328077; x=1735932877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bUuKkL45Y/vxXeIA1LRW7+wDczGH+LX/gXPh888ARPM=;
        b=nrFv7GStgWkWTwv5IH6tp2B0i8bHsZCvcNJd3IjJ/T1GcblzoDY9OHK2GeW+1vYPyl
         6jRRs/Mk5cjIu/LBf7AcyS/djgK2UeHsXoErN44oIbUOtYWbivnPw4cWbxqSRkoSs9ja
         DWR70LhLZJbpCTN/yq6lnXBuatrm8E5ytLK+0kNSZScGPfP7AQGwD1T+O9oBoRlA/W0H
         bYgPGdr5Hf8E/4dHPYwoZy0CbTo2q6/8idLYhLqB0PfZKzsRKWuJBv4sOp2XExW8cLcI
         uvo0j+Ce2dnZ+e2lhZQ50rBiJxdDnf3q4bILWK1r9fUhBkzJBz3Cf0/ULr66EXaNq+jw
         jQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735328077; x=1735932877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUuKkL45Y/vxXeIA1LRW7+wDczGH+LX/gXPh888ARPM=;
        b=RiluZTPzGbje/dOX6YdYNveCRP7avCtVgNTlPxMNWAroW3Jhk8flReY5qcdKyULXg9
         zEciRXzrsrquBLotL70sK5WLn45CryZHEDW7ppQoFhR3UoUBeuc+D/LTsUU1MjbAH7//
         h4wAkc2kl5uWvIUMeuuulH7TyQALDNegQmzFLs5LKCQFiHivLaNoLyS3NjzApMuS/mPI
         6Mt6IBq31ObXdEdb9DdR15x+/2fc731xA6Yc8SmgHI8fIJRg0j08axF6ZKqYJOFZR7bU
         vqKfjpakzTDZslZMozrBj9Gt0Tiq1okARgmlNt2pceRtFr92J1QPNzDG+sPptrNoTX8g
         8e9w==
X-Gm-Message-State: AOJu0Yz7SsHG/prt4XFc15rBghuXbISPARv5HL5d9BhA7tDFGeI8cMqx
	6fXpxwYk+YJGtqIKHAls3C6KrQouZrv9eCAAEXZdSpciTlssyTpD8s32wA==
X-Gm-Gg: ASbGnctqNRNs3ig2Oniu9f6+y9aJhxxBzmrAG/pI0u6ObbMTag+cEjEAK3yG2Wq/saG
	fpGfGKJ1I0xgEDuzgzKjhGL0j7otoeioju6962noPkJGISJPD/8j4TLf8xv/YoVsELpI9xQDxLP
	yh64ryRTYJ/W5ivwfTOqqt3CuBf+pKU2eAh5uxbi9Pvabgbl6ty5s0OYb3a0kaO9N6z/zzW7qfd
	KDp3K9OGdGiXFxA9ierDJBAf3EJa9ELg9aFINYw9gh+UUUcDWF/GQ==
X-Google-Smtp-Source: AGHT+IHsbfMYc6bGSURhRwSgXkyfFCJW0kqIzk9nq1G+LpgdSACQsr3NH+S3aEs1nZzXojlijqY6bA==
X-Received: by 2002:a05:6902:2801:b0:e4a:9ef8:804b with SMTP id 3f1490d57ef6-e538c25d684mr16778631276.19.1735328077189;
        Fri, 27 Dec 2024 11:34:37 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:8::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e537cbeb784sm4678348276.10.2024.12.27.11.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 11:34:36 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	bfoster@redhat.com,
	djwong@kernel.org,
	nirjhar@linux.ibm.com,
	kernel-team@meta.com
Subject: [PATCH v2 0/2] fstests: test reads/writes from hugepages-backed buffers
Date: Fri, 27 Dec 2024 11:33:09 -0800
Message-ID: <20241227193311.1799626-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a recent bug in rc1 [1] that was due to faulty handling for
userspace buffers backed by hugepages.

This patchset adds generic tests for reads/writes from buffers backed by
hugepages.

[1] https://lore.kernel.org/linux-fsdevel/p3iss6hssbvtdutnwmuddvdadubrhfkdoosgmbewvo674f7f3y@cwnwffjqltzw/

Changelog:
v1: https://lore.kernel.org/linux-fsdevel/20241218210122.3809198-1-joannelkoong@gmail.com/
- Refactor out buffer initialization (Brian)
- Update commit messages of 1st patch (Brian)
- Use << 10 instead of * 1024 (Nirjhar)
- Replace CONFIG_TRANSPARENT_HUGEPAGE check with checking
  'sys/kernel/mm/transparent_hugepage/' (Darrick)
- Integrate readbdy and writebdy options 
- Update options of generic/759 to include psize/bsize

Joanne Koong (2):
  fsx: support reads/writes from buffers backed by hugepages
  generic: add tests for read/writes from hugepages-backed buffers

 common/rc             |  13 +++++
 ltp/fsx.c             | 108 +++++++++++++++++++++++++++++++++++++-----
 tests/generic/758     |  22 +++++++++
 tests/generic/758.out |   4 ++
 tests/generic/759     |  26 ++++++++++
 tests/generic/759.out |   4 ++
 6 files changed, 166 insertions(+), 11 deletions(-)
 create mode 100755 tests/generic/758
 create mode 100644 tests/generic/758.out
 create mode 100755 tests/generic/759
 create mode 100644 tests/generic/759.out

-- 
2.47.1


