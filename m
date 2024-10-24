Return-Path: <linux-fsdevel+bounces-32706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 448569AE08E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 11:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E422D1F22794
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 09:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E242B1B3929;
	Thu, 24 Oct 2024 09:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnXnblp+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA3018B488;
	Thu, 24 Oct 2024 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761970; cv=none; b=ezpes/Skl6ASZoJXSapd5+cgfcghi5bE8pmIBg3T5kkvmCE2TdlV21fom0ett8wCQ3xusiGpzSAcTF1g+WtJXUYjFVb66DoL8SQ7E/TZNacTYDIO3YqOu+9GDeNxrPKzLnkhDAnIivAzY8KLy4RXHa310Ndbf9U/czv90Zypws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761970; c=relaxed/simple;
	bh=vBHlee0LROU624Z/HgMJod1wQjJ2rFq5nyQvfqIhDz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ohCQFwnTU1ErYWX9lK7qMFQLgVFyO0ezyTZ2leZnMy5RJi2rL1KNqSbQYh6115bWjB4uAEeSHMZ8wKQH94U870Rr00d4QJkL44WC9SJx0+EmLaQdG04rQTd2rxMDjqwDZ+AB5yChEIqYdGoDTwgiZ9hTEahB7UBpyW0p4KBr2C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnXnblp+; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e5ae69880so473216b3a.2;
        Thu, 24 Oct 2024 02:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729761968; x=1730366768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pGF6TyANvflPh6CZa162RB2n0/RNch+lIADjec8h/Og=;
        b=LnXnblp+OUZrJU7+vOTj35fexzpSJhvUYAvqxA8U5zpCjOLNhYINf7Gvzl1Joy1Jls
         40zhX2yaMY52hjltLUY+HD7/aX5ym5SDaL4lTPe1h3nXHUxmXmLPedT79lQF4CEMT48B
         S+qdo5AQGCyNYXkx5fAS3wDwmK5txzyRPjNtYw5LXkYhIOzO9sSJyA1dd83ILyyEaDLy
         PauywOgDC90h44AG0geapZZhqESyTWa8URDGUKkKqye9xR+WaSxoS5TCIJolUsrT+C5w
         JEQD2N3fKrE9YnfrNoBPU+xGR2xGBloYa8tJl0VRv3jsAV3rJMv6V+Z8dFgmzsWwEfJ8
         sc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729761968; x=1730366768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pGF6TyANvflPh6CZa162RB2n0/RNch+lIADjec8h/Og=;
        b=FjBHPHh7yWX+qUicEy2uGjwU4lSMoM5Qgcm23y1rT9WsoHnjhh2NHeg+3BFD9Il2Dc
         eNDnS949rzpTphGvTf4/4v05bwRkycye3i6x3syVUfgXhwRLkzUykjiuPp7R0+XGwQBf
         7kBINF/ypqj7/TkjjcoAreFTpWaAGZpj/dRHRykWFaok7Pcfg0/mX1vHYQX0Il8NCStN
         NYgR0omhZl6WcQ+BerPQ1S5i5Xv8jbaXGhyR+Iqi9+XmrARTVh0is10DjEWm3MFF9/h2
         8sJYo1KqFuNd+oe5K9jfSx98fn9mbedNseqfjv0Bh/zY8LGPQjJs+ShxXi7x2RkoRpFa
         3MIg==
X-Forwarded-Encrypted: i=1; AJvYcCUsalmgvMVqUh3jZKwMuCbd0Jm510nA2hySIMSXipQOPxCjBN6Dpl9wNtgFtqe7xPgbEHtPHW7GEbaA3c7A@vger.kernel.org, AJvYcCWEY7vr+UwoAKWLyA7hCEK1O93osjfkVQAxpYbGLX+mHZ0VH9Jk8ao1naIKRCdKH6+cbuXiZhxHIbWkW/ms@vger.kernel.org, AJvYcCWK5FGJKrCtif6JSWyliw0AOvoIBfIcGSZgVdRYGZnZ/VkM7OljjDN9Sw+uUV87eFRft7AOnhVH4dZgNA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVS2D9MsRc1pr1j9P2Lsj+czVYEQOiPPhemJihiLNp1JRyYtsx
	k3dsaNftcFYDt0tnEOCWKjZIxqTs4xX1vdFEqvbIfTbRVR4IWqJ4
X-Google-Smtp-Source: AGHT+IE15ZjMMvQ1vh5h3TPi2AHeW+S1IN5rkOGZCLQWaXRqL873ZenE+fejwaqXp2y8xmIXILujUw==
X-Received: by 2002:a05:6a00:4f89:b0:71e:795f:92f0 with SMTP id d2e1a72fcca58-72030a51dc1mr7292597b3a.3.1729761967528;
        Thu, 24 Oct 2024 02:26:07 -0700 (PDT)
Received: from carrot.. (i118-19-49-33.s41.a014.ap.plala.or.jp. [118.19.49.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d774fsm7608906b3a.106.2024.10.24.02.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:26:06 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 00/12] nilfs2: Finish folio conversion
Date: Thu, 24 Oct 2024 18:25:34 +0900
Message-ID: <20241024092602.13395-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Andrew, please queue this series for the next cycle.

This series converts all remaining page structure references in nilfs2
to folio-based, except for nilfs_copy_buffer function, which was
converted to use folios in advance for cross-fs page flags cleanup.

This prioritizes folio conversion, and does not include buffer head
reference reduction, nor does it support for block sizes larger than
the system page size.

The first eight patches in this series mainly convert each of the
nilfs2-specific metadata implementations to use folios.  The last four
patches, by Matthew Wilcox, eliminate aops writepage callbacks and
convert the remaining page structure references to folio-based.  This
part reflects some corrections to the patch series posted by Matthew.

It has passed operation checks and load tests with different block
sizes on multiple environments, including 32-bit kernel, and is
sufficiently stable.

Thanks,
Ryusuke Konishi


Matthew Wilcox (Oracle) (4):
  nilfs2: Remove nilfs_writepage
  nilfs2: Convert nilfs_page_count_clean_buffers() to take a folio
  nilfs2: Convert nilfs_recovery_copy_block() to take a folio
  nilfs2: Convert metadata aops from writepage to writepages

Ryusuke Konishi (8):
  nilfs2: convert segment buffer to be folio-based
  nilfs2: convert common metadata file code to be folio-based
  nilfs2: convert segment usage file to be folio-based
  nilfs2: convert persistent object allocator to be folio-based
  nilfs2: convert inode file to be folio-based
  nilfs2: convert DAT file to be folio-based
  nilfs2: remove nilfs_palloc_block_get_entry()
  nilfs2: convert checkpoint file to be folio-based

 fs/nilfs2/alloc.c    | 148 +++++++++--------
 fs/nilfs2/alloc.h    |   4 +-
 fs/nilfs2/cpfile.c   | 383 +++++++++++++++++++++++--------------------
 fs/nilfs2/dat.c      |  98 +++++------
 fs/nilfs2/dir.c      |   2 +-
 fs/nilfs2/ifile.c    |  10 +-
 fs/nilfs2/ifile.h    |   4 +-
 fs/nilfs2/inode.c    |  35 +---
 fs/nilfs2/mdt.c      |  40 +++--
 fs/nilfs2/page.c     |   4 +-
 fs/nilfs2/page.h     |   4 +-
 fs/nilfs2/recovery.c |  17 +-
 fs/nilfs2/segbuf.c   |  17 +-
 fs/nilfs2/sufile.c   | 160 +++++++++---------
 14 files changed, 485 insertions(+), 441 deletions(-)

-- 
2.43.0


