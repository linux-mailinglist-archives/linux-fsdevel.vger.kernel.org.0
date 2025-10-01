Return-Path: <linux-fsdevel+bounces-63200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27492BB1AED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 22:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C931C1C6791
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 20:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA222F0C46;
	Wed,  1 Oct 2025 20:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sg4bTlQY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6C825B663
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 20:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759350440; cv=none; b=IfuXR/KVyIcNR22u6cunuVHsvDZT77H1LQ5Nxr+Ja0fMdzdjcekveUA4dGWVKsLz5RD3bj/IFYvpO7sfFovBaxj+/uMqtKsQ+ZfRgg6oeTLgLeeG1SyEPoizxJ1ixDVgpUY/hxMNWOwwEY8mcacUmz4m6rZVq+mFFHCLR8eS6bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759350440; c=relaxed/simple;
	bh=G963DtS/1FnUYe8Bk64aERAuIQSpK29BvJuSKXZoyJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cTFxYdWpMMcIaHkk99ynj8AhZOfx+Gb6GSRCwNqPz4sXFWudCEslc8Xdf1No/x0mEjl00Jfo8qBAiUvVZjzlCUxbSEgtt5+hzr0zX66Mo5RZJ8vJKr1gFhzHCURZZ04oHeiS5N41xM1SJDgFkB/GmXY9Kk7EHMFs8xYqe36dO2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sg4bTlQY; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27ee41e074dso2487835ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Oct 2025 13:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759350439; x=1759955239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Y2TB2deAhvzJ9TnIqGPiw7EFDMg7t0R4+4KfZC05qo=;
        b=Sg4bTlQYx2n+eCGcFsR0VvyMOfoXzyyjTaGy8GADmnlY0wxmr+toLg88lpj92+G7E/
         kIvwXxuad1I/fon/LeERqF1gRdbdbLMpDCv8urjcd65awb7eP+vf5ea3O3UCYtdELbmM
         4dJUkpWjFpqfIFNx4bG8zfw0fUDQqA1RN4YGLseb8atelBuUZkRKOYAanRDnak/z7/r0
         Pmh2Bq9xg5UdjeTu1aCzUQvDclXFxib2rDiQnPeRcYhijJmtK/G6NKhqyNbxveJylOXT
         /2wvR9vlEeNsP7Ug3TtyOxhUaNGpjiNmn4/lbf/mTqv+8D8JPaNaEvD9AqmJTvS8nCSq
         MdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759350439; x=1759955239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Y2TB2deAhvzJ9TnIqGPiw7EFDMg7t0R4+4KfZC05qo=;
        b=bVcFQZpB50EYlxeuM4UAJLRIQoUEk0BGaVn140TbvM2Ai1ZF2BwjTBjTco9mcdB3cZ
         A7/sGLSvwqEGj1q1FDt67pZvIRE4XMgTChzUGOKOdBbUPvQIHbz22dLna3mY0tvmUGeL
         tQeJ39PXMZM/WFY6OsvRWGIp3OKMEf5awoME8AsmH9yXSr3XaB5p/+gkyv4zo+0C1D87
         Qflg6kWBw7YS3WptBrmyNtrJPIV2O9sCYco9eeO0ZDAjyNqhkxIHAqG/9tCHvXnwFZiF
         cc/J9t4On8ehnMODSZwiTVCb+pt1QrlvTndqiB2prVtLaJ8AEZgScleSAm0eOlIZMaFe
         zDeQ==
X-Gm-Message-State: AOJu0Yz1Y/42JxocEEfFeDfS61Izs3OIufeEu5KIZVBJgbZqioujqmaD
	QDbQqtkjeB/ytgsEZHALtW72Ee6APeIJEZyH1UDRPi/l3J01o2HdFmKq
X-Gm-Gg: ASbGncsHiQ35A4GVdeI+JLiV2mW5nWWrdAahWEqEY4y+GdmdgYHGC9eEdega9xqKL5y
	1KMMXdWaHN7DLjDAetNJYREPtNWCw386aVXuwfzGa/9LE2RTVjphQImOXdv7rXRpLfVa695KgAR
	uhNQkafbC4ppEN9BD0gCOJj8M0hLGu9sFou1ucv3iILY5a24LgXgY7HJdOYSTDi8WJ0DZiBWLfv
	hw8MHrGz8fdSceD6JAzmVOG2YEhlZLKRuyLxTZscymW6u/uDj0nluY2guaXSAOkAdWcjAtOLIUo
	YcdTYytvkkfGXRv0tL9hI4soOVrdbci0J9Kkir5kboSu632q6Jo9fM9OXsH172otWGCwMqpJbed
	OQsvYTsDHajk89nYlZHLZ6ZSf0KT/8ygMOEGCXHHa8dg7ciy5n5RjXWQnHkMFNzwYXOEUgyo5CV
	43ng5/Dc11qHLUEUISouelDDV7V/aGcOr5shy1GA==
X-Google-Smtp-Source: AGHT+IFSHOpmU+tiZFi1WwF/0IqSVMuQDH3frGeMOd5w+e2OLJaFmNhJOspRWyZINZN6L9DIiNzoBg==
X-Received: by 2002:a17:902:fc44:b0:27d:6777:2833 with SMTP id d9443c01a7336-28e7f319f34mr61832625ad.47.1759350438619;
        Wed, 01 Oct 2025 13:27:18 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:2f27:4b44:4a2e:f965])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1280a1sm4709695ad.51.2025.10.01.13.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 13:27:18 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isofs: fix inode leak caused by disconnected dentries from exportfs
Date: Thu,  2 Oct 2025 01:57:13 +0530
Message-ID: <20251001202713.2077654-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jan,

Thank you for the review. You're absolutely right - my initial explanation was incorrect. I've done extensive debugging to understand the actual mechanism causing the leak.

Root Cause Analysis
===================

The leak occurs specifically with CONFIG_JOLIET=y through the following sequence:

1. Joliet Root Switching During Mount
--------------------------------------

In isofs_fill_super(), when Joliet extensions are detected:
- Primary root inode 1792 is created with i_count=1, i_nlink=3
- During Joliet switching, iput(inode) is called on inode 1792
- i_count decrements to 0, but generic_drop_inode() returns false (i_nlink=3 > 0)
- Inode 1792 remains cached at i_count=0
- New Joliet root inode 1920 is created and attached to sb->s_root

Debugging output:
  [9.653617] isofs: switching roots, about to iput ino=1792, i_count=1
  [9.653676] isofs: after iput, getting new root
  [9.653880] isofs: old inode after iput ino=1792, i_count=0, i_nlink=3
  [9.654219] isofs: got new root ino=1920, i_count=1

2. open_by_handle_at() Triggers Reconnection
---------------------------------------------

When the system call attempts to resolve a file handle:
- exportfs_decode_fh_raw() calls fh_to_dentry() which returns inode 1856
- The dentry is marked DCACHE_DISCONNECTED
- reconnect_path() is invoked to connect the path to root
- This calls reconnect_one() to walk up the directory tree

3. Reference Accumulation in reconnect_one()
---------------------------------------------

I instrumented reconnect_one() to track dentry reference counts:

  [8.010398] reconnect_one: called for inode 1856
  [8.010735] isofs: __isofs_iget got inode 1792, i_count=1
  [8.011041] After fh_to_parent: d_count=1
  [8.011319] After exportfs_get_name: d_count=2
  [8.011769] After lookup_one_unlocked: d_count=3

The parent dentry (inode 1792) accumulates 3 references:
1. Initial reference from fh_to_parent()
2. Additional reference taken by exportfs_get_name()
3. Another reference taken by lookup_one_unlocked()

Then lookup_one_unlocked() creates a dentry for inode 1807:
  [8.015179] isofs: __isofs_iget got inode 1807, i_count=1
  [8.016169] lookup returns tmp (inode 1807), d_count=1

The code enters the tmp != dentry branch and calls dput(tmp), then goes to 
out_reconnected.

4. Insufficient Cleanup
-----------------------

For inode 1807, I traced through dput():
  [10.083359] fast_dput: lockref_put_return returned 0
  [10.083699] fast_dput: RETAINING dentry for inode 1807, d_flags=0x240043

The dentry refcount goes to 0, but retain_dentry() returns true because of 
the DCACHE_REFERENCED flag (0x40 in 0x240043). The dentry is kept in cache 
with refcount 0, still holding the inode reference.

For inode 1792:
  [10.084125] fast_dput: lockref_put_return returned 2

At out_reconnected, only one dput(parent) is called, decrementing from 3 to 2. 
Two references remain leaked.

5. Unmount Failure
------------------

At unmount time:
- shrink_dcache_for_umount() doesn't evict dentries with positive refcounts (1792)
- Doesn't aggressively evict retained dentries with refcount 0 (1807)
- Both inodes appear as leaked with i_count=1

  [10.155385] LEAKED INODE: ino=1807, i_count=1, i_state=0x0, i_nlink=1
  [10.155604] LEAKED INODE: ino=1792, i_count=1, i_state=0x0, i_nlink=1

Why shrink_dcache_sb() Works
=============================

Calling shrink_dcache_sb() in isofs_put_super() forces eviction of:
- Dentries with extra references that weren't properly released
- Retained dentries sitting in cache at refcount 0

This ensures cleanup happens before the superblock is destroyed.

Open Questions
==============

1. Are exportfs_get_name() and lookup_one_unlocked() supposed to take 
   references to the parent dentry that the caller must release? Should 
   reconnect_one() be calling dput(parent) multiple times, or are these 
   functions leaking references?

2. Is adding shrink_dcache_sb() in put_super() the appropriate fix, or 
   should this be handled in the reconnection error path when 
   reconnect_one() fails?

3. Does this indicate a broader issue with how exportfs handles parent 
   dentry references during failed path reconnections that might affect 
   other filesystems?

I can investigate further into the implementation of exportfs_get_name() 
and lookup_one_unlocked() to understand where exactly the extra references 
are taken if that would be helpful.

Best regards,
Deepanshu Kartikey

