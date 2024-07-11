Return-Path: <linux-fsdevel+bounces-23570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2A492E7F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 14:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5CA1C22AA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 12:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446EC15B12C;
	Thu, 11 Jul 2024 12:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cubp6C1r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAFC15B0F9;
	Thu, 11 Jul 2024 12:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720699688; cv=none; b=iI3S6GMlRlKCEMmEb9+ynniq9lQSk6yHwrhIum3qwXoXZxjrfs4z9geFVU/R4nWVK+ZgxMVeLi8ACubE8m7K9XMNM2SK2IKQ0dAiL4ZYg+scpv3p5g7oae0Y0koRZQ7Obyx6MyfAqu2NAoUA4lqwr+ZKRvAoim3vNmE3+72zNrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720699688; c=relaxed/simple;
	bh=Rt3vjJFO+CEJTPCuDMU3cXSRgjx+LU0VgCc5bI2odm8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=lj/03ecPGoK0O9dI+tWiah4TfEieomO4kbmzc7etmAcVxH2nAhO+IXVcY17CAEDaInXoAmPp2A5otn9JdQTjcYsTxwnZ4g/4HxxzGWeLA9Py3JJ50z85pEJr9i/Nw5YnQLkxTmWni4iVNKryl12H2x7Eg2aXtCnoufp6jJoZzJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cubp6C1r; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-70847d0cb1fso282600a34.3;
        Thu, 11 Jul 2024 05:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720699685; x=1721304485; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8ENQjADeiR5R3vbLYYe4DAzYWjc/ePRmz6jUJpNWtWU=;
        b=cubp6C1rYKNaQhQ6veO+5LxLu0Q0g6Xvo631HPwd/2gepzSq4ybAq8TxKTKZkYSfBv
         ZpKysLcMKhel17MhVwifgBH0eZAo3UA93TwSCPiJ2E6UmoigqZnLw1woni2RxU4t1eHy
         Dc2mHOnEFRK+afLoi8KT8Mqz7E3h6Cb8gXa8OiXe3rZRgN2xCz/YwsHsOQ3HJdXaKq8e
         D9CV2V7EuamHv5t/M64YO5JTBofpbGLK4LwgLPZpLT6U10IgdBVhAhAfmLus99zYeYtV
         XAm4RkLGHwtuTMqAIRTp69iCXJiYXSAa07vrRMiUnGK/3u347jKh7fCXXuWSZPj9cSeY
         taaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720699685; x=1721304485;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ENQjADeiR5R3vbLYYe4DAzYWjc/ePRmz6jUJpNWtWU=;
        b=rDtv33hUYlagrg1cV9lmdE/fZHLq86GBzEgJuiNwZrNzPW26t54JyTE+lgESHim/pz
         rhCZLRWtVzoTzowHCHgq51ITG+xtu6zwa3mBNiKkKtTZr3watrhaz6J8HVtPzB3Z09Kb
         FjGKSRjrJSDDSzTZtXE2bBlvC1IgWoxyvZATqQjVgk6n//eljUxV/3CZGrKKFj5Kat1Z
         9bkn1CcfWKhs7ZgfQGYqkR4YeHDTFk3bJzTDUi5n7ormcWI/zNPcLJCPHiuag8SmhL6b
         i0sGW9nVUHTBGHBwOKdFDdm3aknzVqk5rqq47sPIFS4DjFk1JBLDNoz/d6v6W+1xU+5V
         isZg==
X-Forwarded-Encrypted: i=1; AJvYcCWGTmmrMS8rFaPA9XbEIuWwLp6ZQ6WBcqK7YHxayoaDxNgmHcWL82XFJu+2HzFVMPlByIPrqxh/dx7CIucZ/zEr8XQkUPBmWi1cQIX7Usj9MK08RJpIagjdaes1jFoo1V4eNnLmuroC04g=
X-Gm-Message-State: AOJu0Yyq9cXpybOzs+VzjDDlO75z5RJ3Vz8oyvigf/SgkbmBJkZOKfeT
	FaHLUVASYz+jtvFwQ0mR7pf5zqs7yqyCTo75/3QlpHjTaEEBMenYLJ5OoXiiH42Gq12vpm2JgqA
	o4nR3NTm5G41LnPMIBb+pcSfjZ+V1sKqt
X-Google-Smtp-Source: AGHT+IFMohw23rJygJjf8sMep/cOyrHM4BSbce8oZSwqojIFc5mzqTDagMsS4md0gGzbuR0KEenCxEajdFY0OfNJLAE=
X-Received: by 2002:a9d:7490:0:b0:704:485b:412b with SMTP id
 46e09a7af769-704485b42f5mr6939471a34.20.1720699684927; Thu, 11 Jul 2024
 05:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Thu, 11 Jul 2024 21:07:53 +0900
Message-ID: <CAB=+i9SmrqEEqQp+AQvv+O=toO9x0mPam+b1KuNT+CgK0J1JDQ@mail.gmail.com>
Subject: Possible circular dependency between i_data_sem and folio lock in
 ext4 filesystem
To: Linux Memory Management List <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org
Cc: max.byungchul.park@sk.com, byungchul@sk.com, 
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi folks,

Byungchul, Gwan-gyeong and I are investigating possible circular
dependency reported by a dependency tracker named DEPT [1], which is
able to report possible circular dependencies involving folio locks
and other forms of dependencies that are not locks (i.e., wait for
completion).

Below are two similar reports from DEPT where one context takes
i_data_sem and then folio lock in ext4_map_blocks(), while the other
context takes folio lock and then i_data_sem during processing of
pwrite64() system calls. We're reaching out due to a lack of
understanding of ext4 and file system internals.

The points in question are:

- Can the two contexts actually create a dependency between each other
in ext4? In other words, do their uses of folio lock make them belong
to the same lock classes?

- Are there any locking rules in ext4 that ensure these two contexts
will never be considered as the same lock class?

Best,
Hyeonggon

==== Report 1: Possible circular dependency between fsync() and pwrite64() ====
[  402.888557] ===================================================
[  402.888967] DEPT: Circular dependency has been detected.
[  402.888967] 6.9.0-rc7 #145 Not tainted
[  402.888967] ---------------------------------------------------
[  402.888967] summary
[  402.888967] ---------------------------------------------------
[  402.888967] *** DEADLOCK ***
[  402.888967]
[  402.888967] context A
[  402.888967]     [S] lock(&ei->i_data_sem:0)
[  402.888967]     [W] dept_page_wait_on_bit(PG_locked_map:0)
[  402.888967]     [E] unlock(&ei->i_data_sem:0)
[  402.888967]
[  402.888967] context B
[  402.888967]     [S] (event requestor)(PG_locked_map:0)
[  402.888967]     [W] lock(&ei->i_data_sem:0)
[  402.888967]     [E] dept_page_clear_bit(PG_locked_map:0)
[  402.888967]
[  402.888967] [S]: start of the event context
[  402.888967] [W]: the wait blocked
[  402.888967] [E]: the event not reachable
[  402.888967] ---------------------------------------------------
[  402.888967] context A's detail
[  402.888967] ---------------------------------------------------
[  402.888967] context A
[  402.888967]     [S] lock(&ei->i_data_sem:0)
[  402.888967]     [W] dept_page_wait_on_bit(PG_locked_map:0)
[  402.888967]     [E] unlock(&ei->i_data_sem:0)
[  402.888967]
[  402.888967] [S] lock(&ei->i_data_sem:0):
[  402.888967] ext4_map_blocks (fs/ext4/ext4.h:1936 fs/ext4/inode.c:622)
[  402.888967] stacktrace:
[  402.888967] ext4_map_blocks (fs/ext4/ext4.h:1936 fs/ext4/inode.c:622)
[  402.888967] ext4_do_writepages (fs/ext4/inode.c:2164
fs/ext4/inode.c:2216 fs/ext4/inode.c:2679)
[  402.888967] ext4_writepages (fs/ext4/inode.c:2768)
[  402.888967] do_writepages (mm/page-writeback.c:2619)
[  402.888967] __filemap_fdatawrite_range (mm/filemap.c:431)
[  402.888967] file_write_and_wait_range (mm/filemap.c:789)
[  402.888967] ext4_sync_file (fs/ext4/fsync.c:158)
[  402.888967] __x64_sys_fsync (./include/linux/file.h:47
fs/sync.c:213 fs/sync.c:220 fs/sync.c:218 fs/sync.c:218)
[  402.888967] do_syscall_64 (arch/x86/entry/common.c:53
arch/x86/entry/common.c:85)
[  402.888967] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[  402.888967]
[  402.888967] [W] dept_page_wait_on_bit(PG_locked_map:0):
[  402.888967] __filemap_get_folio (./include/linux/pagemap.h:1054
./include/linux/pagemap.h:1049 mm/filemap.c:1900)
[  402.888967] stacktrace:
[  402.888967] folio_wait_bit_common (./include/linux/page-flags.h:873
mm/filemap.c:1224)
[  402.888967] __filemap_get_folio (./include/linux/pagemap.h:1054
./include/linux/pagemap.h:1049 mm/filemap.c:1900)
[  402.888967] pagecache_get_page (mm/folio-compat.c:94)
[  402.888967] ext4_mb_load_buddy_gfp (./include/linux/pagemap.h:757
fs/ext4/mballoc.c:1634)
[  402.888967] ext4_mb_regular_allocator (fs/ext4/mballoc.c:2898)
[  402.888967] ext4_mb_new_blocks (fs/ext4/mballoc.c:6205)
[  402.888967] ext4_ext_map_blocks (fs/ext4/extents.c:4317)
[  402.888967] ext4_map_blocks (fs/ext4/inode.c:623)
[  402.888967] ext4_do_writepages (fs/ext4/inode.c:2164
fs/ext4/inode.c:2216 fs/ext4/inode.c:2679)
[  402.888967] ext4_writepages (fs/ext4/inode.c:2768)
[  402.888967] do_writepages (mm/page-writeback.c:2619)
[  402.888967] __filemap_fdatawrite_range (mm/filemap.c:431)
[  402.888967] file_write_and_wait_range (mm/filemap.c:789)
[  402.888967] ext4_sync_file (fs/ext4/fsync.c:158)
[  402.888967] __x64_sys_fsync (./include/linux/file.h:47
fs/sync.c:213 fs/sync.c:220 fs/sync.c:218 fs/sync.c:218)
[  402.888967] do_syscall_64 (arch/x86/entry/common.c:53
arch/x86/entry/common.c:85)
[  402.888967]
[  402.888967] [E] unlock(&ei->i_data_sem:0):
[  402.888967] (N/A)
[  402.888967] ---------------------------------------------------
[  402.888967] context B's detail
[  402.888967] ---------------------------------------------------
[  402.888967] context B
[  402.888967]     [S] (event requestor)(PG_locked_map:0)
[  402.888967]     [W] lock(&ei->i_data_sem:0)
[  402.888967]     [E] dept_page_clear_bit(PG_locked_map:0)
[  402.888967]
[  402.888967] [S] (event requestor)(PG_locked_map:0):
[  402.888967] stacktrace:
[  402.888967] filemap_add_folio (mm/filemap.c:948)
[  402.888967] __filemap_get_folio (mm/filemap.c:1960)
[  402.888967] ext4_da_write_begin (fs/ext4/inode.c:2885)
[  402.888967] generic_perform_write (mm/filemap.c:4000)
[  402.888967] ext4_buffered_write_iter (./include/linux/fs.h:800
fs/ext4/file.c:302)
[  402.888967] ext4_file_write_iter (fs/ext4/file.c:698)
[  402.888967] vfs_write (./include/linux/fs.h:2110
fs/read_write.c:497 fs/read_write.c:590)
[  402.888967] __x64_sys_pwrite64 (fs/read_write.c:705
fs/read_write.c:715 fs/read_write.c:712 fs/read_write.c:712)
[  402.888967] do_syscall_64 (arch/x86/entry/common.c:53
arch/x86/entry/common.c:85)
[  402.888967] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[  402.888967]
[  402.888967] [W] lock(&ei->i_data_sem:0):
[  402.888967] ext4_da_get_block_prep (fs/ext4/ext4.h:1936
fs/ext4/ext4.h:3600 fs/ext4/inode.c:1745 fs/ext4/inode.c:1817)
[  402.888967] stacktrace:
[  402.888967] ext4_da_get_block_prep (fs/ext4/ext4.h:1936
fs/ext4/ext4.h:3600 fs/ext4/inode.c:1745 fs/ext4/inode.c:1817)
[  402.888967] __block_write_begin_int (fs/buffer.c:2108)
[  402.888967] ext4_da_write_begin (fs/ext4/inode.c:2896)
[  402.888967] generic_perform_write (mm/filemap.c:4000)
[  402.888967] ext4_buffered_write_iter (./include/linux/fs.h:800
fs/ext4/file.c:302)
[  402.888967] ext4_file_write_iter (fs/ext4/file.c:698)
[  402.888967] vfs_write (./include/linux/fs.h:2110
fs/read_write.c:497 fs/read_write.c:590)
[  402.888967] __x64_sys_pwrite64 (fs/read_write.c:705
fs/read_write.c:715 fs/read_write.c:712 fs/read_write.c:712)
[  402.888967] do_syscall_64 (arch/x86/entry/common.c:53
arch/x86/entry/common.c:85)
[  402.888967] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[  402.888967]
[  402.888967] [E] dept_page_clear_bit(PG_locked_map:0):
[  402.888967] ext4_da_write_end (./include/linux/instrumented.h:68
./include/linux/atomic/atomic-instrumented.h:32
./include/linux/page_ref.h:67 ./include/linux/mm.h:1134
./include/linux/mm.h:1140 ./include/linux/mm.h:1507
fs/ext4/inode.c:2986 fs/ext4/inode.c:3028)
[  402.888967] stacktrace:
[  402.888967] folio_unlock (./include/linux/page-flags.h:858
(discriminator 2) mm/filemap.c:1510 (discriminator 2))
[  402.888967] ext4_da_write_end (./include/linux/instrumented.h:68
./include/linux/atomic/atomic-instrumented.h:32
./include/linux/page_ref.h:67 ./include/linux/mm.h:1134
./include/linux/mm.h:1140 ./include/linux/mm.h:1507
fs/ext4/inode.c:2986 fs/ext4/inode.c:3028)
[  402.888967] generic_perform_write (mm/filemap.c:4011)
[  402.888967] ext4_buffered_write_iter (./include/linux/fs.h:800
fs/ext4/file.c:302)
[  402.888967] ext4_file_write_iter (fs/ext4/file.c:698)
[  402.888967] vfs_write (./include/linux/fs.h:2110
fs/read_write.c:497 fs/read_write.c:590)
[  402.888967] __x64_sys_pwrite64 (fs/read_write.c:705
fs/read_write.c:715 fs/read_write.c:712 fs/read_write.c:712)
[  402.888967] do_syscall_64 (arch/x86/entry/common.c:53
arch/x86/entry/common.c:85)
[  402.888967] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[  402.888967] ---------------------------------------------------
[  402.888967] information that might be helpful
[  402.888967] ---------------------------------------------------
[  402.888967] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[  402.888967] Call Trace:
[  402.888967]  <TASK>
[  402.888967] dump_stack_lvl (lib/dump_stack.c:118)
[  402.888967] print_circle (./include/linux/instrumented.h:96
./include/linux/atomic/atomic-instrumented.h:592
kernel/dependency/dept.c:149 kernel/dependency/dept.c:886)
[  402.888967] ? hlock_class (./arch/x86/include/asm/bitops.h:227
./arch/x86/include/asm/bitops.h:239
./include/asm-generic/bitops/instrumented-non-atomic.h:142
kernel/locking/lockdep.c:228)
[  402.888967] ? extend_queue (./include/linux/list.h:150
./include/linux/list.h:183 kernel/dependency/dept.c:898
kernel/dependency/dept.c:927)
[  402.888967] cb_check_dl (kernel/dependency/dept.c:1244)
[  402.888967] bfs (kernel/dependency/dept.c:984)
[  402.888967] ? __pfx_cb_check_dl (kernel/dependency/dept.c:1220)
[  402.888967] ? hlock_class (./arch/x86/include/asm/bitops.h:227
./arch/x86/include/asm/bitops.h:239
./include/asm-generic/bitops/instrumented-non-atomic.h:142
kernel/locking/lockdep.c:228)
[  402.888967] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  402.888967] ? mark_lock (kernel/locking/lockdep.c:4666)
[  402.888967] ? __pfx_bfs (kernel/dependency/dept.c:954)
[  402.888967] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  402.888967] ? __add_dep (./include/linux/list.h:150
./include/linux/list.h:169 kernel/dependency/dept.c:1214)
[  402.888967] add_dep (kernel/dependency/dept.c:1579)
[  402.888967] ? hlock_class (./arch/x86/include/asm/bitops.h:227
./arch/x86/include/asm/bitops.h:239
./include/asm-generic/bitops/instrumented-non-atomic.h:142
kernel/locking/lockdep.c:228)
[  402.888967] ? __pfx_add_dep (kernel/dependency/dept.c:1560)
[  402.888967] ? __pfx_from_pool (kernel/dependency/dept.c:351)
[  402.888967] ? __pfx_mark_lock (kernel/locking/lockdep.c:4649)
[  402.888967] ? hlock_class (./arch/x86/include/asm/bitops.h:227
./arch/x86/include/asm/bitops.h:239
./include/asm-generic/bitops/instrumented-non-atomic.h:142
kernel/locking/lockdep.c:228)
[  402.888967] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  402.888967] __dept_wait (kernel/dependency/dept.c:1641
kernel/dependency/dept.c:2381)
[  402.888967] ? __filemap_get_folio (./include/linux/pagemap.h:1054
./include/linux/pagemap.h:1049 mm/filemap.c:1900)
[  402.888967] ? __pfx___lock_acquire (kernel/locking/lockdep.c:5005)
[  402.888967] ? __lock_acquire (kernel/locking/lockdep.c:5146
(discriminator 9))
[  402.888967] ? __pfx___dept_wait (kernel/dependency/dept.c:2359)
[  402.888967] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  402.888967] ? lock_acquire (kernel/locking/lockdep.c:467
kernel/locking/lockdep.c:5776 kernel/locking/lockdep.c:5739)
[  402.888967] ? __filemap_get_folio (./include/linux/pagemap.h:1054
./include/linux/pagemap.h:1049 mm/filemap.c:1900)
[  403.025017] dept_wait (kernel/dependency/dept.c:2446)
[  403.025017] folio_wait_bit_common (./include/linux/page-flags.h:873
mm/filemap.c:1224)
[  403.025017] ? __pfx_folio_wait_bit_common (mm/filemap.c:1212)
[  403.025017] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  403.025017] ? filemap_get_entry (mm/filemap.c:1835)
[  403.025017] ? __pfx_filemap_get_entry (mm/filemap.c:1835)
[  403.025017] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  403.025017] ? lock_is_held_type (kernel/locking/lockdep.c:5507
kernel/locking/lockdep.c:5845)
[  403.025017] __filemap_get_folio (./include/linux/pagemap.h:1054
./include/linux/pagemap.h:1049 mm/filemap.c:1900)
[  403.025017] pagecache_get_page (mm/folio-compat.c:94)
[  403.025017] ext4_mb_load_buddy_gfp (./include/linux/pagemap.h:757
fs/ext4/mballoc.c:1634)
[  403.025017] ext4_mb_regular_allocator (fs/ext4/mballoc.c:2898)
[  403.025017] ? __pfx_ext4_mb_regular_allocator (fs/ext4/mballoc.c:2786)
[  403.025017] ? ext4_mb_normalize_request.constprop.0 (fs/ext4/mballoc.c:4540)
[  403.025017] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  403.025017] ? __kasan_slab_alloc (mm/kasan/common.c:341)
[  403.025017] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  403.025017] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  403.025017] ? kmem_cache_alloc (mm/slub.c:3858)
[  403.025017] ext4_mb_new_blocks (fs/ext4/mballoc.c:6205)
[  403.025017] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  403.025017] ? kasan_save_track (./arch/x86/include/asm/current.h:49
mm/kasan/common.c:60 mm/kasan/common.c:69)
[  403.025017] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  403.025017] ? __kasan_kmalloc (mm/kasan/common.c:391)
[  403.025017] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  403.025017] ? __kmalloc (mm/slub.c:3980)
[  403.025017] ? __pfx_ext4_mb_new_blocks (fs/ext4/mballoc.c:6126)
[  403.025017] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  403.025017] ? ext4_find_extent (fs/ext4/extents.c:815 fs/ext4/extents.c:953)
[  403.025017] ext4_ext_map_blocks (fs/ext4/extents.c:4317)
[  403.025017] ? __is_insn_slot_addr (kernel/kprobes.c:312)
[  403.025017] ? __pfx___lock_acquire (kernel/locking/lockdep.c:5005)
[  403.025017] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  403.025017] ? __kernel_text_address (kernel/extable.c:79)
[  403.025017] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  403.025017] ? unwind_get_return_address
(arch/x86/kernel/unwind_orc.c:369 arch/x86/kernel/unwind_orc.c:364)
[  403.025017] ? __pfx_stack_trace_consume_entry (kernel/stacktrace.c:83)
[  403.025017] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  403.025017] ? arch_stack_walk (arch/x86/kernel/stacktrace.c:26)
[  403.025017] ? __pfx_ext4_ext_map_blocks (fs/ext4/extents.c:4128)
[  403.025017] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  403.025017] ? ext4_map_blocks (fs/ext4/ext4.h:1936 fs/ext4/inode.c:622)
[  403.025017] ? __pfx_lock_acquire (kernel/locking/lockdep.c:5742)
[  403.025017] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  403.025017] ? stack_trace_save (kernel/stacktrace.c:123)
[  403.045075] ? __pfx_stack_trace_save (kernel/stacktrace.c:114)
[  403.045075] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  403.045075] ? dept_ecxt_enter (kernel/dependency/dept.c:2768
(discriminator 1))
[  403.045075] ? __pfx_down_write (kernel/locking/rwsem.c:1577)
[  403.045075] ? ext4_es_lookup_extent
(./include/trace/events/ext4.h:2313 fs/ext4/extents_status.c:1047)
[  403.045075] ext4_map_blocks (fs/ext4/inode.c:623)
[  403.045075] ? __pfx_ext4_map_blocks (fs/ext4/inode.c:481)
[  403.045075] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  403.045075] ? __kasan_slab_alloc (mm/kasan/common.c:341)
[  403.045075] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  403.045075] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  403.045075] ? ext4_alloc_io_end_vec (fs/ext4/page-io.c:61)
[  403.045075] ext4_do_writepages (fs/ext4/inode.c:2164
fs/ext4/inode.c:2216 fs/ext4/inode.c:2679)
[  403.045075] ? __pfx_ext4_do_writepages (fs/ext4/inode.c:2512)
[  403.045075] ? stack_trace_save (kernel/stacktrace.c:123)
[  403.045075] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  403.045075] ? dept_ecxt_enter (kernel/dependency/dept.c:2768
(discriminator 1))
[  403.045075] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  403.045075] ? lock_is_held_type (kernel/locking/lockdep.c:5507
kernel/locking/lockdep.c:5845)
[  403.045075] ext4_writepages (fs/ext4/inode.c:2768)
[  403.045075] ? __pfx_ext4_writepages (fs/ext4/inode.c:2754)
[  403.045075] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  403.045075] ? ext4_buffered_write_iter (fs/ext4/file.c:303)
[  403.045075] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  403.045075] ? lock_release (kernel/locking/lockdep.c:5442
kernel/locking/lockdep.c:5794)
[  403.045075] do_writepages (mm/page-writeback.c:2619)
[  403.045075] ? dept_ecxt_exit (kernel/dependency/dept.c:2948)
[  403.045075] ? __pfx_do_writepages (mm/page-writeback.c:2602)
[  403.045075] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  403.045075] ? up_write (./arch/x86/include/asm/atomic64_64.h:91
./include/linux/atomic/atomic-arch-fallback.h:2852
./include/linux/atomic/atomic-long.h:268
./include/linux/atomic/atomic-instrumented.h:3391
kernel/locking/rwsem.c:1374 kernel/locking/rwsem.c:1632)
[  403.045075] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  403.045075] ? llist_add_batch (lib/llist.c:33 (discriminator 14))
[  403.045075] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  403.045075] ? llist_add_batch (lib/llist.c:33 (discriminator 14))
[  403.045075] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  403.045075] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  403.045075] ? hlock_class (./arch/x86/include/asm/bitops.h:227
./arch/x86/include/asm/bitops.h:239
./include/asm-generic/bitops/instrumented-non-atomic.h:142
kernel/locking/lockdep.c:228)
[  403.045075] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  403.045075] ? __lock_acquire (kernel/locking/lockdep.c:5146
(discriminator 9))
[  403.045075] __filemap_fdatawrite_range (mm/filemap.c:431)
[  403.045075] ? __pfx___filemap_fdatawrite_range (mm/filemap.c:423)
[  403.045075] file_write_and_wait_range (mm/filemap.c:789)
[  403.045075] ext4_sync_file (fs/ext4/fsync.c:158)
[  403.045075] ? srso_return_thunk (arch/x86/lib/retpoline.S:224)
[  403.045075] __x64_sys_fsync (./include/linux/file.h:47
fs/sync.c:213 fs/sync.c:220 fs/sync.c:218 fs/sync.c:218)
[  403.045075] do_syscall_64 (arch/x86/entry/common.c:53
arch/x86/entry/common.c:85)
[  403.045075] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[  403.045075] RIP: 0033:0x7f93ccae65eb
[  403.045075] RSP: 002b:00007f93c1dfde50 EFLAGS: 00000293 ORIG_RAX:
000000000000004a
[  403.045075] RAX: ffffffffffffffda RBX: 00000000003e0000 RCX: 00007f93ccae65eb
[  403.045075] RDX: 000055f93c6e639d RSI: 00007f93c1dfde70 RDI: 0000000000000014
[  403.045075] RBP: 00007f93c1dffebc R08: 0000000000000000 R09: 00007f93c1dfde70
[  403.045075] R10: 0000000000000180 R11: 0000000000000293 R12: 0000000000000014
[  403.045075] R13: 00007f93c1dfde70 R14: 000055f93c702004 R15: 0000000000802000
[  403.045075]  </TASK>

==== Report 2: Possible circular dependency between mkdir() and pwrite64()
[   19.908810] DEPT: Circular dependency has been detected.
[   19.908810] 6.9.0-rc7 #52 Not tainted
[   19.908810] ---------------------------------------------------
[   19.908810] summary
[   19.908810] ---------------------------------------------------
[   19.908810] *** DEADLOCK ***
[   19.908810]
[   19.908810] context A
[   19.908810]     [S] lock(&ei->i_data_sem:0)
[   19.908810]     [W] dept_page_wait_on_bit(PG_locked_map:0)
[   19.908810]     [E] unlock(&ei->i_data_sem:0)
[   19.908810]
[   19.908810] context B
[   19.908810]     [S] (event requestor)(PG_locked_map:0)
[   19.908810]     [W] lock(&ei->i_data_sem:0)
[   19.908810]     [E] dept_page_clear_bit(PG_locked_map:0)
[   19.908810]
[   19.908810] [S]: start of the event context
[   19.908810] [W]: the wait blocked
[   19.908810] [E]: the event not reachable
[   19.908810] ---------------------------------------------------
[   19.908810] context A's detail
[   19.908810] ---------------------------------------------------
[   19.908810] context A
[   19.908810]     [S] lock(&ei->i_data_sem:0)
[   19.908810]     [W] dept_page_wait_on_bit(PG_locked_map:0)
[   19.908810]     [E] unlock(&ei->i_data_sem:0)
[   19.908810]
[   19.908810] [S] lock(&ei->i_data_sem:0):
[   19.908810] [<ffffffffa83e460d>] ext4_map_blocks+0x20d/0x5f0
[   19.908810] stacktrace:
[   19.908810]       ext4_map_blocks+0x20d/0x5f0
[   19.908810]       ext4_getblk+0x7a/0x2e0
[   19.908810]       ext4_bread+0xb/0x70
[   19.908810]       ext4_append+0x88/0x190
[   19.908810]       ext4_init_new_dir+0xd6/0x180
[   19.908810]       ext4_mkdir+0x19d/0x340
[   19.908810]       vfs_mkdir+0x151/0x230
[   19.908810]       do_mkdirat+0x85/0x130
[   19.908810]       __x64_sys_mkdir+0x46/0x70
[   19.908810]       do_syscall_64+0xc8/0x1d0
[   19.908810]       entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   19.908810]
[   19.908810] [W] dept_page_wait_on_bit(PG_locked_map:0):
[   19.908810] [<ffffffffa823de44>] __filemap_get_folio+0x1f4/0x240
[   19.908810] stacktrace:
[   19.908810]       folio_wait_bit_common+0x289/0x360
[   19.908810]       __filemap_get_folio+0x1f4/0x240
[   19.908810]       pagecache_get_page+0xd/0x40
[   19.908810]       ext4_mb_init_group+0x73/0x320
[   19.908810]       ext4_mb_prefetch_fini+0x7d/0xa0
[   19.908810]       ext4_mb_regular_allocator+0x4c0/0xde0
[   19.908810]       ext4_mb_new_blocks+0xa04/0x10d0
[   19.908810]       ext4_ind_map_blocks+0x7e5/0xbb0
[   19.908810]       ext4_map_blocks+0x2da/0x5f0
[   19.908810]       ext4_getblk+0x7a/0x2e0
[   19.908810]       ext4_bread+0xb/0x70
[   19.908810]       ext4_append+0x88/0x190
[   19.908810]       ext4_init_new_dir+0xd6/0x180
[   19.908810]       ext4_mkdir+0x19d/0x340
[   19.908810]       vfs_mkdir+0x151/0x230
[   19.908810]       do_mkdirat+0x85/0x130
[   19.908810]
[   19.908810] [E] unlock(&ei->i_data_sem:0):
[   19.908810] (N/A)
[   19.908810] ---------------------------------------------------
[   19.908810] context B's detail
[   19.908810] ---------------------------------------------------
[   19.908810] context B
[   19.908810]     [S] (event requestor)(PG_locked_map:0)
[   19.908810]     [W] lock(&ei->i_data_sem:0)
[   19.908810]     [E] dept_page_clear_bit(PG_locked_map:0)
[   19.908810]
[   19.908810] [S] (event requestor)(PG_locked_map:0):
[   19.908810] stacktrace:
[   19.908810]       __filemap_get_folio+0xdf/0x240
[   19.908810]       ext4_da_write_begin+0xf1/0x2b0
[   19.908810]       generic_perform_write+0xca/0x210
[   19.908810]       ext4_buffered_write_iter+0x5d/0xe0
[   19.908810]       vfs_write+0x3d3/0x580
[   19.908810]       __x64_sys_pwrite64+0x92/0xc0
[   19.908810]       do_syscall_64+0xc8/0x1d0
[   19.908810]       entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   19.908810]
[   19.908810] [W] lock(&ei->i_data_sem:0):
[   19.908810] [<ffffffffa83e31d9>] ext4_da_get_block_prep+0x1b9/0x400
[   19.908810] stacktrace:
[   19.908810]       ext4_da_get_block_prep+0x1b9/0x400
[   19.908810]       __block_write_begin_int+0x155/0x570
[   19.908810]       ext4_da_write_begin+0x11d/0x2b0
[   19.908810]       generic_perform_write+0xca/0x210
[   19.908810]       ext4_buffered_write_iter+0x5d/0xe0
[   19.908810]       vfs_write+0x3d3/0x580
[   19.908810]       __x64_sys_pwrite64+0x92/0xc0
[   19.908810]       do_syscall_64+0xc8/0x1d0
[   19.908810]       entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   19.908810]
[   19.908810] [E] dept_page_clear_bit(PG_locked_map:0):
[   19.908810] [<ffffffffa83eb9bd>] ext4_da_write_end+0xbd/0x3b0
[   19.908810] stacktrace:
[   19.908810]       ext4_da_write_end+0xbd/0x3b0
[   19.908810]       generic_perform_write+0x11c/0x210
[   19.908810]       ext4_buffered_write_iter+0x5d/0xe0
[   19.908810]       vfs_write+0x3d3/0x580
[   19.908810]       __x64_sys_pwrite64+0x92/0xc0
[   19.908810]       do_syscall_64+0xc8/0x1d0
[   19.908810]       entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   19.908810] ---------------------------------------------------
[   19.908810] information that might be helpful
[   19.908810] ---------------------------------------------------
[   19.908810] CPU: 0 PID: 378 Comm: mkdir Not tainted 6.9.0-rc7 #52
[   19.908810] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[   19.908810] Call Trace:
[   19.908810]  <TASK>
[   19.908810]  dump_stack_lvl+0x68/0xa0
[   19.908810]  print_circle+0x690/0x6b0
[   19.908810]  ? __pfx_cb_check_dl+0x10/0x10
[   19.908810]  cb_check_dl+0x5c/0x70
[   19.908810]  bfs+0xca/0x1a0
[   19.908810]  add_dep+0xaa/0x170
[   19.908810]  __dept_wait+0x1ef/0x580
[   19.908810]  ? __filemap_get_folio+0x1f4/0x240
[   19.908810]  dept_wait+0x9d/0xb0
[   19.908810]  ? __filemap_get_folio+0x1f4/0x240
[   19.908810]  folio_wait_bit_common+0x289/0x360
[   19.908810]  ? srso_return_thunk+0x5/0x5f
[   19.908810]  ? filemap_get_entry+0x109/0x1e0
[   19.908810]  __filemap_get_folio+0x1f4/0x240
[   19.908810]  pagecache_get_page+0xd/0x40
[   19.908810]  ext4_mb_init_group+0x73/0x320
[   19.908810]  ext4_mb_prefetch_fini+0x7d/0xa0
[   19.908810]  ext4_mb_regular_allocator+0x4c0/0xde0
[   19.908810]  ? lock_release+0xbd/0x280
[   19.908810]  ? fs_reclaim_acquire+0x4e/0xf0
[   19.908810]  ext4_mb_new_blocks+0xa04/0x10d0
[   19.908810]  ? srso_return_thunk+0x5/0x5f
[   19.908810]  ? srso_return_thunk+0x5/0x5f
[   19.908810]  ext4_ind_map_blocks+0x7e5/0xbb0
[   19.908810]  ? srso_return_thunk+0x5/0x5f
[   19.908810]  ? lock_acquire+0xc0/0x2d0
[   19.908810]  ? ext4_map_blocks+0x20d/0x5f0
[   19.908810]  ? srso_return_thunk+0x5/0x5f
[   19.908810]  ext4_map_blocks+0x2da/0x5f0
[   19.908810]  ? srso_return_thunk+0x5/0x5f
[   19.908810]  ? lock_release+0xbd/0x280
[   19.908810]  ? srso_return_thunk+0x5/0x5f
[   19.908810]  ext4_getblk+0x7a/0x2e0
[   19.908810]  ext4_bread+0xb/0x70
[   19.908810]  ext4_append+0x88/0x190
[   19.908810]  ext4_init_new_dir+0xd6/0x180
[   19.908810]  ext4_mkdir+0x19d/0x340
[   19.908810]  vfs_mkdir+0x151/0x230
[   19.908810]  do_mkdirat+0x85/0x130
[   19.908810]  __x64_sys_mkdir+0x46/0x70
[   19.908810]  do_syscall_64+0xc8/0x1d0
[   19.908810]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   19.908810] RIP: 0033:0x7f4cbd4b4047
[   19.908810] Code: 1f 40 00 48 8b 05 49 2e 0e 00 64 c7 00 5f 00 00
00 b8 ff ff ff ff c3 66 2e 0f 1f 84 0000 00 00 00 66 90 b8 53 00 00 00
0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 19 2e 0e 00 f7 d8 64 89 01
48
[   19.908810] RSP: 002b:00007fffa8322d78 EFLAGS: 00000246 ORIG_RAX:
0000000000000053
[   19.908810] RAX: ffffffffffffffda RBX: 000055947ace3c30 RCX: 00007f4cbd4b4047
[   19.908810] RDX: 0000000000000000 RSI: 00000000000001ff RDI: 00007fffa8323e2d
[   19.908810] RBP: 00007fffa8323e20 R08: 0000000000000000 R09: 000055947ace3d60
[   19.908810] R10: fffffffffffffd8c R11: 0000000000000246 R12: 00000000000001ff
[   19.908810] R13: 00007fffa8322ef0 R14: 00007fffa8323e2d R15: 0000000000000000
[   19.908810]  </TASK>

