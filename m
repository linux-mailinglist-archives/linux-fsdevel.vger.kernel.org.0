Return-Path: <linux-fsdevel+bounces-59344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0D6B37CBE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 10:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2154B1B27765
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 08:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CAE31CA45;
	Wed, 27 Aug 2025 08:03:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9008B31A553
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 08:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756281831; cv=none; b=uiKmOEcVqOkxm56uWlyE7t0g2TaZ31TZbsXtDa3jzQ5m3AEBVpW8Yqa5aQrlE28Fydr+9IAQknVA1gSLLnZToisHPafqH8LhfUIM+gSWChgota1W1EyffOqWsRsWBBeOHBtQH6hU6YrQ0dpGR6lEHT+zyJmBuVc9lsUxOqhDpyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756281831; c=relaxed/simple;
	bh=GKFP0cKg8X36DYXTs4AnKInFPQYLUC25oeO1ip+uIVo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=pyFoUIrPfwfbMSpY6NjkKd4Ct6HUjY9cABmK/YQ76Yi3lL6NYvJV/dpuGdxRS+syLY2P9/nMR1ueZdoPVqs1w1D36+4UCVpTMa9Q05LHiKlzuFO5jGzO7SmfQT8umC6WPCSQHHrNkTeCL+ZESLtRLEEX+l+x9YUNRFOMDLzFm5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e6766c3935so79910365ab.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 01:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756281829; x=1756886629;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xXVGAuQnn9XzlKQXqXAG7puergh7qbhhO9p5PMqXgkw=;
        b=o0PEKkTPOQK08+ZN+f/zZA+7UNgJEzrgyg2A6Av2KwONepE1/Puk0+pvOjOifcyAtl
         5fHKoXiUacQM35DgX2sqNxHkAwoSjg0a3ocn5uHx4NJRi0ik80JVBHvnWkOW/tqVE09f
         TlUXvOLlOGpZTlSblfNIGIBEk5h7OUns3yMhHFP0ksadQbD64R8LM5ioSIRfogZ799Tp
         RKBswg31kKNDcZf2inRQ1C9mXI//akZPxKbyWvFRhAaEdDKh5m66wgCpMkrGt5dHYBDb
         /4rF+U9BM2nHObsJE7MnMNRashQjIaYEgE3C+xxtmcfcZu0oCsINnvhOOyTdsS+bncEx
         Cabg==
X-Forwarded-Encrypted: i=1; AJvYcCWat8IriOiNOH9jj9Jqi4vpohhFmA1bHCaEstqOBKEjlTFP1WtTghYVq6m3i6Vjmllg1aYLBhaSux5YAZ4a@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlyf5XKy9hseKooaUxm5wov9a1PhrmC56wWb0RnbzkmoifV+5K
	TsxNWsi+hx7gU8P4EJjllcJcZ13uK2x/ShTvSbO22a/K2zuVyF5/97sJ7RBpqc1247nEWRt/uIB
	V+rkvO1cR5mISotPUj4tDGw8JDausFQuzp1ewieLBpGFqkUguVQpCPkPlvFc=
X-Google-Smtp-Source: AGHT+IHgGgCW/4gHUt8t/levoYYyVNCC5/Uo1Faz0rZusbCMW0pjQ6aBYk5jawEFHvtzIMDbLkK5lYOmXgLbgGbFV0yzSJsjx3T1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4813:b0:3ea:114c:83a6 with SMTP id
 e9e14a558f8ab-3ea114c860fmr227055435ab.1.1756281828839; Wed, 27 Aug 2025
 01:03:48 -0700 (PDT)
Date: Wed, 27 Aug 2025 01:03:48 -0700
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68aebbe4.a70a0220.3cafd4.0011.GAE@google.com>
Subject: [syzbot ci] Re: fs: rework inode reference counting
From: syzbot ci <syzbot+ci0d448b9d8cb534fd@syzkaller.appspotmail.com>
To: amir73il@gmail.com, brauner@kernel.org, josef@toxicpanda.com, 
	kernel-team@fb.com, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v2] fs: rework inode reference counting
https://lore.kernel.org/all/cover.1756222464.git.josef@toxicpanda.com
* [PATCH v2 01/54] fs: make the i_state flags an enum
* [PATCH v2 02/54] fs: add an icount_read helper
* [PATCH v2 03/54] fs: rework iput logic
* [PATCH v2 04/54] fs: add an i_obj_count refcount to the inode
* [PATCH v2 05/54] fs: hold an i_obj_count reference in wait_sb_inodes
* [PATCH v2 06/54] fs: hold an i_obj_count reference for the i_wb_list
* [PATCH v2 07/54] fs: hold an i_obj_count reference for the i_io_list
* [PATCH v2 08/54] fs: hold an i_obj_count reference in writeback_sb_inodes
* [PATCH v2 09/54] fs: hold an i_obj_count reference while on the hashtable
* [PATCH v2 10/54] fs: hold an i_obj_count reference while on the LRU list
* [PATCH v2 11/54] fs: hold an i_obj_count reference while on the sb inode list
* [PATCH v2 12/54] fs: stop accessing ->i_count directly in f2fs and gfs2
* [PATCH v2 13/54] fs: hold an i_obj_count when we have an i_count reference
* [PATCH v2 14/54] fs: add an I_LRU flag to the inode
* [PATCH v2 15/54] fs: maintain a list of pinned inodes
* [PATCH v2 16/54] fs: delete the inode from the LRU list on lookup
* [PATCH v2 17/54] fs: remove the inode from the LRU list on unlink/rmdir
* [PATCH v2 18/54] fs: change evict_inodes to use iput instead of evict directly
* [PATCH v2 19/54] fs: hold a full ref while the inode is on a LRU
* [PATCH v2 20/54] fs: disallow 0 reference count inodes
* [PATCH v2 21/54] fs: make evict_inodes add to the dispose list under the i_lock
* [PATCH v2 22/54] fs: convert i_count to refcount_t
* [PATCH v2 23/54] fs: use refcount_inc_not_zero in igrab
* [PATCH v2 24/54] fs: use inode_tryget in find_inode*
* [PATCH v2 25/54] fs: update find_inode_*rcu to check the i_count count
* [PATCH v2 26/54] fs: use igrab in insert_inode_locked
* [PATCH v2 27/54] fs: remove I_WILL_FREE|I_FREEING check from __inode_add_lru
* [PATCH v2 28/54] fs: remove I_WILL_FREE|I_FREEING check in inode_pin_lru_isolating
* [PATCH v2 29/54] fs: use inode_tryget in evict_inodes
* [PATCH v2 30/54] fs: change evict_dentries_for_decrypted_inodes to use refcount
* [PATCH v2 31/54] block: use igrab in sync_bdevs
* [PATCH v2 32/54] bcachefs: use the refcount instead of I_WILL_FREE|I_FREEING
* [PATCH v2 33/54] btrfs: don't check I_WILL_FREE|I_FREEING
* [PATCH v2 34/54] fs: use igrab in drop_pagecache_sb
* [PATCH v2 35/54] fs: stop checking I_FREEING in d_find_alias_rcu
* [PATCH v2 36/54] ext4: stop checking I_WILL_FREE|IFREEING in ext4_check_map_extents_env
* [PATCH v2 37/54] fs: remove I_WILL_FREE|I_FREEING from fs-writeback.c
* [PATCH v2 38/54] gfs2: remove I_WILL_FREE|I_FREEING usage
* [PATCH v2 39/54] fs: remove I_WILL_FREE|I_FREEING check from dquot.c
* [PATCH v2 40/54] notify: remove I_WILL_FREE|I_FREEING checks in fsnotify_unmount_inodes
* [PATCH v2 41/54] xfs: remove I_FREEING check
* [PATCH v2 42/54] landlock: remove I_FREEING|I_WILL_FREE check
* [PATCH v2 43/54] fs: change inode_is_dirtytime_only to use refcount
* [PATCH v2 44/54] btrfs: remove references to I_FREEING
* [PATCH v2 45/54] ext4: remove reference to I_FREEING in inode.c
* [PATCH v2 46/54] ext4: remove reference to I_FREEING in orphan.c
* [PATCH v2 47/54] pnfs: use i_count refcount to determine if the inode is going away
* [PATCH v2 48/54] fs: remove some spurious I_FREEING references in inode.c
* [PATCH v2 49/54] xfs: remove reference to I_FREEING|I_WILL_FREE
* [PATCH v2 50/54] ocfs2: do not set I_WILL_FREE
* [PATCH v2 51/54] fs: remove I_FREEING|I_WILL_FREE
* [PATCH v2 52/54] fs: remove I_REFERENCED
* [PATCH v2 53/54] fs: remove I_LRU_ISOLATING flag
* [PATCH v2 54/54] fs: add documentation explaining the reference count rules for inodes

and found the following issue:
kernel build error

Full report is available here:
https://ci.syzbot.org/series/ccd4eafa-7a13-48d6-93b6-f40c03262bea

***

kernel build error

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      fab1beda7597fac1cecc01707d55eadb6bbe773c
arch:      amd64
compiler:  Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
config:    https://ci.syzbot.org/builds/162c03ae-2d30-4085-ab1e-a2dd1c8403eb/config

fs/bcachefs/fs.c:350:20: error: incompatible pointer types passing 'struct bch_inode_info *' to parameter of type 'const struct inode *' [-Werror,-Wincompatible-pointer-types]

***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

