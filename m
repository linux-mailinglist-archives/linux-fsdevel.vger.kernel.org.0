Return-Path: <linux-fsdevel+bounces-62956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E75BA7923
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 00:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC3A17650F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Sep 2025 22:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37269291C11;
	Sun, 28 Sep 2025 22:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="R1/GTnWH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F74226D02
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 22:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759100031; cv=none; b=TeeYv4trUAU9V6Zh+m+msfmYMUkhTRpv7utzPPR2SEp500Z0Hkks0jySqGoLwqc+uR1q77s9dd0RO8gbLoyETycjOX20czQ7DeCZOo7BXUeQeuItH0l7oY0h8r3AdizyQcxWXMmDnEhn/KTSY0uy5CP1OL9TyvKQGRHnWO35XHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759100031; c=relaxed/simple;
	bh=0VVpeSIi2bQ5GS5ZK+m+hOIxkq/vqvxCrxOgKXtt8QU=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=i0n+bX0qYP0ulQsTTJJ5fHVXrsCQWI1n/yNZmWzzNtJ3U5JP+gKXb43F3Mp2sBMRKd8Jt4A7PsqK2ECk+4caVqMKFPXvTnCjLyy3UiM28gsOME3SS4ZdjUN+pZ97/dhGoiFcpc6RbOhgVS6zIbBXfvlmj5x6FNgJ1oexrrLoHhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=R1/GTnWH; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d5fe46572so53226207b3.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 15:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1759100027; x=1759704827; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tsipUAu1EP4C8FSlW8+mYDchI7CNm6sJwi/T8LyEncY=;
        b=R1/GTnWHpiwUDclQjl6ELTyZx3+12P4+HbHFjS2k68IYx+xOEoVveAQcWbA+wAkmaE
         N6Q2/yBupAN5sJWHFwEpslmxuDuyZ+nKo5ATSYG9+fdGGDUc/XxsPnof9xyGWY1qPhOR
         YcCLFqPsuZMCfDFMzr4mkENuBa391Nii3gcJuYSHxGvVdBvtRgozK+Xr7kSi1U8BVK4b
         ayy0ly73Z4DAddMXFX4Ff2xzDcREBH8IVqr50XI2aV0pamGS4G2j7IRZh1nLRvNLYIkb
         G/tkos3cYDCYESJ/vGW6QJZ/02WZqbByG8Jl3Nt0d8TbOh55n0GFetZiM8IgUt9HB0XG
         uxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759100027; x=1759704827;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt:date:cc
         :to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tsipUAu1EP4C8FSlW8+mYDchI7CNm6sJwi/T8LyEncY=;
        b=Akx4mi8Ir7BvQAGnoPqV1DnVfWb0psArEjoNITTGshnwUsV5htrCfayfOzhczqPC6Z
         ckMq1YOBBwosNU5Nyq1yfXfIzDN0Rc70EC1QXiQN8jCVty4VFvmLjVlQdiTbaByxvjrF
         emR5QmqPL0dc5lzQD5zmCUaCJehE+DDX9fORkGNxbgxp+iRMkRLne0nf+Tg5kjSMMkbx
         d1LYSVKP3pjhCbtDQJoOjAXijiedFgQ1cR/ct/8l9lZpOKexdeVmKEBqg2VitNO8HYce
         O5nBVMhIGoTvQRoRalkIGi2DWlp8Uv2qENK5kfiI4uXtsrCSNtY2z0i0KpYOvM4MxxoT
         2vlw==
X-Gm-Message-State: AOJu0Yx4uyH6WfdfnBZx++TdjbfP9lXp9AlAJPSBHYoMsPq6CtUzt0SQ
	cMD8vld+69iry5PWWlgTloR/rwCc1O9H5GLDBtLVZTBuG8HPDoPGWgIWcr+W+1hvAROrmFXsiTa
	fBk7P
X-Gm-Gg: ASbGnctppgDqT53DTz8ZVMaQzSTNT/h5J1M0qsViM0LL3vPEBu/yz6nT4AjmvPoPmls
	IQTHRrPoe02Q7r2JdMqz3rS3w6W1c6WRVM19fS6r9LCNeB42Zsjwg2i3H1N7GNOQ+2X+X5zFrR+
	6763Ho1l8ESebXr0NNP/JT9FUC2+n97fW7nsLtzirGM0cnVU3YTzDIOrlN4PmBNEj+ej2J4AyxM
	cPnrppdZ9nINd3RRz8Vhjl0luUsDCMmx3Lt/KxWqr2W3Ls1pgfMXwg6C+li9/m2wEQCO2/Q+WOc
	XNcnTPHKNqJvYrTXgjapio1KTZ7pnJgofOXQWrWqJ16YhM/tZHSOdUc08YbGsNMQnqd0znqL7II
	CwQ9i3EYhKH9xr+bDqRgbWnpoFcmEpydf/65oRLIE0Rk=
X-Google-Smtp-Source: AGHT+IFxfmw6bRyIR2IwkHb5utvFAULR50JmEUTkyc5LWroTpUlpZyoVb9jhMZWs9o/GRwe0mCVwLQ==
X-Received: by 2002:a05:690e:2414:b0:636:100c:ab with SMTP id 956f58d0204a3-6361d40c493mr12471764d50.13.1759100027473;
        Sun, 28 Sep 2025 15:53:47 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:31fd:891c:187:9be2])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-eb383870d7asm3026887276.8.2025.09.28.15.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:53:46 -0700 (PDT)
Message-ID: <5d45d2ba2504ca365ac36c65cbcc6db413bf7e98.camel@dubeyko.com>
Subject: [GIT PULL] hfs/hfsplus changes for 6.18-rc1
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: torvalds@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com, Chenzhi Yang
	 <yang.chenzhi@vivo.com>, Kang Chen <k.chen@smail.nju.edu.cn>
Date: Sun, 28 Sep 2025 15:53:45 -0700
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello Linus,

This pull request contains several fixes of syzbot reported
issues, HFS/HFS+ fixes of xfstests failures, and rework of
HFS/HFS+ debug output subsystem.

Kang Chen has fixed a slab-out-of-bounds issue in hfsplus_uni2asc()
when hfsplus_uni2asc() is called from hfsplus_listxattr().
Yang Chenzhi has fixed a crash in hfsplus_bmap_alloc() if record
offset or length is larger than node_size.
Yangtao Li made correction of returning error code from
hfsplus_fill_super() if Catalog File contains corrupted record
for the case of hidden directory's type.

The KMSAN uninit-value issue has been fixed in hfs_find_set_zero_bits()
by exchanging the kmalloc() on kzalloc() call. The KMSAN uninit-value
issue in hfsplus_delete_cat() has been fixed by proper initialization
of struct hfsplus_inode_info in the hfsplus_iget() logic. The KMSAN
uninit-value issue in __hfsplus_ext_cache_extent() has been fixed by
exchanging the kmalloc() on kzalloc() in hfs_find_init().

The slab-out-of-bounds issue could happen in hfsplus_strcasecmp()
if the length field of struct hfsplus_unistr is bigger than
HFSPLUS_MAX_STRLEN. The issue has been fixed by checking
the length of comparing strings. And if the strings' length
is bigger than HFSPLUS_MAX_STRLEN, then the length is corrected
to this value.

The generic/736 xfstest fails for HFS case because HFS volume
becomes corrupted after the test run. The main reason of
the issue is the absence of logic that corrects
mdb->drNxtCNID/HFS_SB(sb)->next_id (next unused CNID) after
deleting a record in Catalog File. It was introduced
a hfs_correct_next_unused_CNID() method that implements
the necessary logic.

The following changes since commit
8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git
tags/hfs-v6.18-tag1

for you to fetch changes up to
f32a26fab3672e60f622bd7461bf978fc72f29ec:

  hfs/hfsplus: rework debug output subsystem (2025-09-24 16:30:34 -
0700)

----------------------------------------------------------------
hfs updates for v6.18

- hfs/hfsplus: rework debug output subsystem
- hfsplus: fix slab-out-of-bounds read in hfsplus_strcasecmp()
- hfsplus: fix slab-out-of-bounds read in hfsplus_uni2asc()
- hfs: clear offset and space out of valid records in b-tree node
- hfs: add logic of correcting a next unused CNID
- hfsplus: fix KMSAN uninit-value issue in hfsplus_delete_cat()
- hfs: fix KMSAN uninit-value issue in hfs_find_set_zero_bits()
- hfs: make proper initalization of struct hfs_find_data
- hfsplus: fix KMSAN uninit-value issue in __hfsplus_ext_cache_extent()
- hfs: validate record offset in hfsplus_bmap_alloc
- hfsplus: return EIO when type of hidden directory mismatch in
hfsplus_fill_super()
- MAINTAINERS: update location of hfs&hfsplus trees

----------------------------------------------------------------
Kang Chen (1):
      hfsplus: fix slab-out-of-bounds read in hfsplus_uni2asc()

Viacheslav Dubeyko (8):
      hfsplus: fix KMSAN uninit-value issue in
__hfsplus_ext_cache_extent()
      hfs: make proper initalization of struct hfs_find_data
      hfs: fix KMSAN uninit-value issue in hfs_find_set_zero_bits()
      hfsplus: fix KMSAN uninit-value issue in hfsplus_delete_cat()
      hfs: add logic of correcting a next unused CNID
      hfs: clear offset and space out of valid records in b-tree node
      hfsplus: fix slab-out-of-bounds read in hfsplus_strcasecmp()
      hfs/hfsplus: rework debug output subsystem

Yang Chenzhi (1):
      hfs: validate record offset in hfsplus_bmap_alloc

Yangtao Li (2):
      MAINTAINERS: update location of hfs&hfsplus trees
      hfsplus: return EIO when type of hidden directory mismatch in
hfsplus_fill_super()

 MAINTAINERS                |   4 ++
 fs/hfs/bfind.c             |  12 +++--
 fs/hfs/bitmap.c            |   4 +-
 fs/hfs/bnode.c             |  28 +++++-----
 fs/hfs/brec.c              |  35 +++++++++---
 fs/hfs/btree.c             |   2 +-
 fs/hfs/catalog.c           | 129
+++++++++++++++++++++++++++++++++++++++++++--
 fs/hfs/extent.c            |  19 +++----
 fs/hfs/hfs_fs.h            |  39 ++------------
 fs/hfs/inode.c             |  25 ++++++---
 fs/hfs/mdb.c               |  20 ++++---
 fs/hfs/super.c             |   4 ++
 fs/hfsplus/attributes.c    |   8 +--
 fs/hfsplus/bfind.c         |  12 +++--
 fs/hfsplus/bitmap.c        |  10 ++--
 fs/hfsplus/bnode.c         |  69 +++++-------------------
 fs/hfsplus/brec.c          |  10 ++--
 fs/hfsplus/btree.c         |  10 +++-
 fs/hfsplus/catalog.c       |   6 +--
 fs/hfsplus/dir.c           |   2 +-
 fs/hfsplus/extents.c       |  27 +++++-----
 fs/hfsplus/hfsplus_fs.h    |  85 ++++++++++++++++-------------
 fs/hfsplus/super.c         |  41 ++++++++++----
 fs/hfsplus/unicode.c       |  48 +++++++++++++++--
 fs/hfsplus/xattr.c         |  10 ++--
 include/linux/hfs_common.h |  20 +++++++
 26 files changed, 442 insertions(+), 237 deletions(-)
 create mode 100644 include/linux/hfs_common.h

