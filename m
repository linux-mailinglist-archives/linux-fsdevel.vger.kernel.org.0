Return-Path: <linux-fsdevel+bounces-13379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A5086F2A6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 23:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3FA81F22017
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 22:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8327445941;
	Sat,  2 Mar 2024 22:01:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5C541C66
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Mar 2024 22:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709416886; cv=none; b=LobbpdJeCKlxzfoDtL+ER0VG47av4vFurXFVDXiK1rGZVXj2GzM+kxBJq5F1f/oGhvb3YsiSSUcyZZrjRpQYVqBDSVnuzrl6NoUg7FvtyQ36bdRkFnJavpLdux03u+pfdty7m/fKaZJFet+UsUEHgeWqNG3ABs+6sL6un6MKzR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709416886; c=relaxed/simple;
	bh=3EO6ZMy1gTMHAY2uEqHl8r8Jr/qiKttWxT3X05cpCxE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dHmeuRe/ZLRgararhR4GZVb2lTiK8Y2jChsfCJy7SeGkfiBcHANqPL4bswTZdr6c1tZFXcvZX6qdhIJMNiiYgYfko7oMv0Y3roFhONY7m0jzBNKX3pqB7q6Jvtj/nKnRD3LgvcY/nbM9IFJa0R/zQ8wY3Hr5tM46repccdzYhiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363c88eff5aso31096045ab.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Mar 2024 14:01:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709416883; x=1710021683;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3M34FWobjqPtnWOqzGg30ObKeBgydcgxPiKSeEQiOY=;
        b=kXaTZvVm1fMLWvwLPyth6Vohu66FB3QbXwVQmA0f8k1tnorJI3LGaHEtO0MTyErMDw
         BjIzfahbXua777mZGgNaOwzX2lYHt0AwKpp9aZUCkufaV2snbdw8pLQKXQHNkUE27exD
         p917FATZVibmmMUlIdZ7TvpW1xNrJe3jPmy8fK0ETv1mTzeBFnvGRb5x56ExXpJp1e2W
         SbgfB2YPrt08kJTj6MZL65uAz0mzFr54td7ZyfUjgZLPLZmW0+SzyZYTMiJA7AzlCLtJ
         JJOG2plL55aB4KO6pXjvOuO9qDkHeqB+32lfdaaUNuNCcLd0k3w4pRlWIwTjt+M2LGQ3
         HPuw==
X-Forwarded-Encrypted: i=1; AJvYcCWa7D4G0YH4ArYD+3LqppYbG6+ix7HSBMotPPrCl1ucx/ANvtM+x50Kh7UdbxQFiUdKsC/4iaNfPYh7h0obTB0BQrD4aJHBYODOJTGncA==
X-Gm-Message-State: AOJu0Yyd4UC+vTNvlu15ddTBzQMMNHlejKjSn4qL/hjutwhii2zslwck
	jNbrpljM3SDF3h0WnKu5b5aQDjgZQ2LLAwLeOJQ6FqtQudCdfJ6ovh+keRs4HBSfUAuV7gWcVBr
	h9wAgwxKje8PFaZBuXBdxM2DETz2vMD4nmmT/cIgYtak1NFlGAu5NRYk=
X-Google-Smtp-Source: AGHT+IEQa4oolF2z3xz9DIGmao/Pmt+aFKPGyEsZJoydvCaIAj6R2F1hXIyRP3YCclJJNKJtH7jISHo4Fhu+KOHiX0G8NcXA3nz3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a48:b0:365:21f4:7005 with SMTP id
 u8-20020a056e021a4800b0036521f47005mr348993ilv.4.1709416883620; Sat, 02 Mar
 2024 14:01:23 -0800 (PST)
Date: Sat, 02 Mar 2024 14:01:23 -0800
In-Reply-To: <0000000000002be12a0611ca7ff8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001f13040612b4a2f4@google.com>
Subject: Re: [syzbot] [lsm?] [integrity?] KMSAN: uninit-value in ima_add_template_entry
From: syzbot <syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com>
To: dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	paul@paul-moore.com, roberto.sassu@huawei.com, roberto.sassu@huaweicloud.com, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    5ad3cb0ed525 Merge tag 'for-v6.8-rc2' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15fdefac180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=80c7a82a572c0de3
dashboard link: https://syzkaller.appspot.com/bug?extid=7bc44a489f0ef0670bd5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11917b26180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1256096a180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a148235ac5b1/disk-5ad3cb0e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4b06f4d02ad6/vmlinux-5ad3cb0e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7fff06beed25/bzImage-5ad3cb0e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/adece4ed9c9c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com

erofs: (device loop0): mounted with root inode @ nid 36.
=====================================================
BUG: KMSAN: uninit-value in ima_add_template_entry+0x52b/0x870 security/integrity/ima/ima_queue.c:172
 ima_add_template_entry+0x52b/0x870 security/integrity/ima/ima_queue.c:172
 ima_store_template security/integrity/ima/ima_api.c:122 [inline]
 ima_store_measurement+0x371/0x8d0 security/integrity/ima/ima_api.c:376
 process_measurement+0x2c6e/0x3ef0 security/integrity/ima/ima_main.c:367
 ima_file_check+0xb3/0x100 security/integrity/ima/ima_main.c:557
 do_open fs/namei.c:3647 [inline]
 path_openat+0x4d09/0x5ad0 fs/namei.c:3802
 do_filp_open+0x20d/0x590 fs/namei.c:3829
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1404
 do_sys_open fs/open.c:1419 [inline]
 __do_sys_open fs/open.c:1427 [inline]
 __se_sys_open fs/open.c:1423 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1423
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

<Zero or more stacks not recorded to save memory>

Uninit was stored to memory at:
 sha256_transform lib/crypto/sha256.c:117 [inline]
 sha256_transform_blocks+0x2dbf/0x2e80 lib/crypto/sha256.c:127
 lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
 sha256_update+0x2fb/0x340 lib/crypto/sha256.c:136
 crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
 crypto_shash_update+0x75/0xa0 crypto/shash.c:70
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:496 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0x1816/0x3cc0 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x44d/0xdd0 security/integrity/ima/ima_api.c:290
 process_measurement+0x2936/0x3ef0 security/integrity/ima/ima_main.c:359
 ima_file_check+0xb3/0x100 security/integrity/ima/ima_main.c:557
 do_open fs/namei.c:3647 [inline]
 path_openat+0x4d09/0x5ad0 fs/namei.c:3802
 do_filp_open+0x20d/0x590 fs/namei.c:3829
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1404
 do_sys_open fs/open.c:1419 [inline]
 __do_sys_open fs/open.c:1427 [inline]
 __se_sys_open fs/open.c:1423 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1423
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 sha256_transform lib/crypto/sha256.c:117 [inline]
 sha256_transform_blocks+0x2dbf/0x2e80 lib/crypto/sha256.c:127
 lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
 sha256_update+0x2fb/0x340 lib/crypto/sha256.c:136
 crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
 crypto_shash_update+0x75/0xa0 crypto/shash.c:70
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:496 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0x1816/0x3cc0 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x44d/0xdd0 security/integrity/ima/ima_api.c:290
 process_measurement+0x2936/0x3ef0 security/integrity/ima/ima_main.c:359
 ima_file_check+0xb3/0x100 security/integrity/ima/ima_main.c:557
 do_open fs/namei.c:3647 [inline]
 path_openat+0x4d09/0x5ad0 fs/namei.c:3802
 do_filp_open+0x20d/0x590 fs/namei.c:3829
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1404
 do_sys_open fs/open.c:1419 [inline]
 __do_sys_open fs/open.c:1427 [inline]
 __se_sys_open fs/open.c:1423 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1423
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 BLEND_OP lib/crypto/sha256.c:61 [inline]
 sha256_transform lib/crypto/sha256.c:91 [inline]
 sha256_transform_blocks+0xf33/0x2e80 lib/crypto/sha256.c:127
 lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
 sha256_update+0x2fb/0x340 lib/crypto/sha256.c:136
 crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
 crypto_shash_update+0x75/0xa0 crypto/shash.c:70
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:496 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0x1816/0x3cc0 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x44d/0xdd0 security/integrity/ima/ima_api.c:290
 process_measurement+0x2936/0x3ef0 security/integrity/ima/ima_main.c:359
 ima_file_check+0xb3/0x100 security/integrity/ima/ima_main.c:557
 do_open fs/namei.c:3647 [inline]
 path_openat+0x4d09/0x5ad0 fs/namei.c:3802
 do_filp_open+0x20d/0x590 fs/namei.c:3829
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1404
 do_sys_open fs/open.c:1419 [inline]
 __do_sys_open fs/open.c:1427 [inline]
 __se_sys_open fs/open.c:1423 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1423
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 BLEND_OP lib/crypto/sha256.c:61 [inline]
 sha256_transform lib/crypto/sha256.c:92 [inline]
 sha256_transform_blocks+0xf7d/0x2e80 lib/crypto/sha256.c:127
 lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
 sha256_update+0x2fb/0x340 lib/crypto/sha256.c:136
 crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
 crypto_shash_update+0x75/0xa0 crypto/shash.c:70
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:496 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0x1816/0x3cc0 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x44d/0xdd0 security/integrity/ima/ima_api.c:290
 process_measurement+0x2936/0x3ef0 security/integrity/ima/ima_main.c:359
 ima_file_check+0xb3/0x100 security/integrity/ima/ima_main.c:557
 do_open fs/namei.c:3647 [inline]
 path_openat+0x4d09/0x5ad0 fs/namei.c:3802
 do_filp_open+0x20d/0x590 fs/namei.c:3829
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1404
 do_sys_open fs/open.c:1419 [inline]
 __do_sys_open fs/open.c:1427 [inline]
 __se_sys_open fs/open.c:1423 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1423
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 BLEND_OP lib/crypto/sha256.c:61 [inline]
 sha256_transform lib/crypto/sha256.c:93 [inline]
 sha256_transform_blocks+0xfb5/0x2e80 lib/crypto/sha256.c:127
 lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
 sha256_update+0x2fb/0x340 lib/crypto/sha256.c:136
 crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
 crypto_shash_update+0x75/0xa0 crypto/shash.c:70
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:496 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0x1816/0x3cc0 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x44d/0xdd0 security/integrity/ima/ima_api.c:290
 process_measurement+0x2936/0x3ef0 security/integrity/ima/ima_main.c:359
 ima_file_check+0xb3/0x100 security/integrity/ima/ima_main.c:557
 do_open fs/namei.c:3647 [inline]
 path_openat+0x4d09/0x5ad0 fs/namei.c:3802
 do_filp_open+0x20d/0x590 fs/namei.c:3829
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1404
 do_sys_open fs/open.c:1419 [inline]
 __do_sys_open fs/open.c:1427 [inline]
 __se_sys_open fs/open.c:1423 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1423
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 LOAD_OP lib/crypto/sha256.c:56 [inline]
 sha256_transform lib/crypto/sha256.c:82 [inline]
 sha256_transform_blocks+0x2c35/0x2e80 lib/crypto/sha256.c:127
 lib_sha256_base_do_update include/crypto/sha256_base.h:63 [inline]
 sha256_update+0x2fb/0x340 lib/crypto/sha256.c:136
 crypto_sha256_update+0x37/0x60 crypto/sha256_generic.c:39
 crypto_shash_update+0x75/0xa0 crypto/shash.c:70
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:496 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0x1816/0x3cc0 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x44d/0xdd0 security/integrity/ima/ima_api.c:290
 process_measurement+0x2936/0x3ef0 security/integrity/ima/ima_main.c:359
 ima_file_check+0xb3/0x100 security/integrity/ima/ima_main.c:557
 do_open fs/namei.c:3647 [inline]
 path_openat+0x4d09/0x5ad0 fs/namei.c:3802
 do_filp_open+0x20d/0x590 fs/namei.c:3829
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1404
 do_sys_open fs/open.c:1419 [inline]
 __do_sys_open fs/open.c:1427 [inline]
 __se_sys_open fs/open.c:1423 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1423
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 memcpy_to_iter lib/iov_iter.c:65 [inline]
 iterate_kvec include/linux/iov_iter.h:85 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:251 [inline]
 iterate_and_advance include/linux/iov_iter.h:271 [inline]
 _copy_to_iter+0x125a/0x2520 lib/iov_iter.c:186
 copy_page_to_iter+0x419/0x870 lib/iov_iter.c:381
 copy_folio_to_iter include/linux/uio.h:181 [inline]
 filemap_read+0xbf4/0x14d0 mm/filemap.c:2654
 generic_file_read_iter+0x136/0xad0 mm/filemap.c:2784
 __kernel_read+0x724/0xce0 fs/read_write.c:434
 integrity_kernel_read+0x77/0x90 security/integrity/iint.c:221
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:485 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0x1743/0x3cc0 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x44d/0xdd0 security/integrity/ima/ima_api.c:290
 process_measurement+0x2936/0x3ef0 security/integrity/ima/ima_main.c:359
 ima_file_check+0xb3/0x100 security/integrity/ima/ima_main.c:557
 do_open fs/namei.c:3647 [inline]
 path_openat+0x4d09/0x5ad0 fs/namei.c:3802
 do_filp_open+0x20d/0x590 fs/namei.c:3829
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1404
 do_sys_open fs/open.c:1419 [inline]
 __do_sys_open fs/open.c:1427 [inline]
 __se_sys_open fs/open.c:1423 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1423
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 __alloc_pages+0x9a6/0xe00 mm/page_alloc.c:4590
 alloc_pages_mpol+0x62b/0x9d0 mm/mempolicy.c:2133
 alloc_pages mm/mempolicy.c:2204 [inline]
 folio_alloc+0x1da/0x380 mm/mempolicy.c:2211
 filemap_alloc_folio+0xa5/0x430 mm/filemap.c:975
 page_cache_ra_unbounded+0x2cc/0x960 mm/readahead.c:247
 do_page_cache_ra mm/readahead.c:299 [inline]
 page_cache_ra_order+0xe31/0xee0 mm/readahead.c:544
 ondemand_readahead+0x157d/0x1750 mm/readahead.c:666
 page_cache_sync_ra+0x724/0x760 mm/readahead.c:693
 page_cache_sync_readahead include/linux/pagemap.h:1300 [inline]
 filemap_get_pages+0x4c4/0x2bd0 mm/filemap.c:2498
 filemap_read+0x59e/0x14d0 mm/filemap.c:2594
 generic_file_read_iter+0x136/0xad0 mm/filemap.c:2784
 __kernel_read+0x724/0xce0 fs/read_write.c:434
 integrity_kernel_read+0x77/0x90 security/integrity/iint.c:221
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:485 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0x1743/0x3cc0 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x44d/0xdd0 security/integrity/ima/ima_api.c:290
 process_measurement+0x2936/0x3ef0 security/integrity/ima/ima_main.c:359
 ima_file_check+0xb3/0x100 security/integrity/ima/ima_main.c:557
 do_open fs/namei.c:3647 [inline]
 path_openat+0x4d09/0x5ad0 fs/namei.c:3802
 do_filp_open+0x20d/0x590 fs/namei.c:3829
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1404
 do_sys_open fs/open.c:1419 [inline]
 __do_sys_open fs/open.c:1427 [inline]
 __se_sys_open fs/open.c:1423 [inline]
 __x64_sys_open+0x275/0x2d0 fs/open.c:1423
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 0 PID: 5012 Comm: syz-executor394 Not tainted 6.8.0-rc6-syzkaller-00238-g5ad3cb0ed525 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

