Return-Path: <linux-fsdevel+bounces-58219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9576DB2B43C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 00:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32F1B176962
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 22:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F09258EFC;
	Mon, 18 Aug 2025 22:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="UCh4garz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778141ADC83
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 22:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755557565; cv=none; b=RbqOe2Bh3f5DNhCqtoExGXcvQvHQN5dXCuz6XRIxsETYayGyzdlV4wWpkB3afC5yk7wmNBI64WJtF8CV2GgpxEn1UYsg66eRxq+Ehc72pHJ8r+OMfRkQ+zC9sC3Uzee2lm8a+mRzX9qHBMqj8s7cf2JBQ/Co/MHP1lRFwjSDvgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755557565; c=relaxed/simple;
	bh=uAtOe4JAfQN9tB3ZVJgYd3XJSXCOVI/7SARoh0YulkI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IJd31yvYvJ2WBYOMCda4FlQV4HPKvzpbuPJAvBaZqQIGMlbvt5AOg2G6Hz2ObhYUn24552cG9SVkrL+T/mKEzqhGFhvn6nY7+CiObkwyhL2Bi2+J891X08dNA5Flt/BOL+RI9tKNCSnsPuZrziEjfXWo0TClIdImQHI/ziAiP8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=UCh4garz; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d60150590so36384967b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 15:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1755557562; x=1756162362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JdccKd4aMbFqM0yC3qdwefVL92Lats1m4Pce6jgFllQ=;
        b=UCh4garzNQq4NorUEh8M8NXQOZ1FQ9ltPs9V2Ug5lnnN+CzHpT7hH6FJSUDov3kXmC
         k38l4Fv5pr0qyTfsgaZTA1TBmX+JC9kJV/im8pDBjX/EA2ObZlR7HXOS5eXVP/xrNUjb
         S89HgQlzeLW3jYomZPvtnZkk4CTx7jwNRhHD6h3Yk1QDWPOBiHJVFcMgVFNpG/ugKVwo
         /tidzgSGlzuBTmlAvJXa3GqSa/K/rayO5F8ZmbZYZ7gY9UKgAr+X6yDq61Ft5sVNyJI2
         mMaPLWSRpSwSOb0D/G4ZVgx4gjBLGC72cd4Z44gVtl6yvPSpPWkJkYRCO1I/D5DBB5yg
         FlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755557562; x=1756162362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JdccKd4aMbFqM0yC3qdwefVL92Lats1m4Pce6jgFllQ=;
        b=WEfUmNvT7VKRTA9xmzSyIVeUlUH2ZJdl+BtTQkX3KeHrbkdGwsk9SH/WbOg3KFHrbk
         RRwxGbVZ6BpTs40uWVWjohEb6nS8OCzIn8p52DLVu3Yc9ii3kcU9rmlDFH5N3XfMKX/p
         qux9mHt4mvZEfVaPUqWruKsh0wRDsy3e1ylHCWm4Hnaf9yfqHa+ObvScBUTwWDsaCfHP
         Oivja9H3Rpbtu9UMKcYbVYVj03fZMGOxHg61sBnConjZJWmPcTSRcoTH7/M34ClFPE3i
         I64ExZI/0moxAF66L5++By0ZZp64lecUrI7hNgz57HRXzVgh0LyAWiGfUEebFZraRB7U
         aBsA==
X-Forwarded-Encrypted: i=1; AJvYcCWTrjdJeoTZG3J4JB8KE5BB3n3CHarXWaGWCQhjj5XdFdhIz2EJO3i9bAH5MjTM5cXQLEsKuFqiWJFJkQml@vger.kernel.org
X-Gm-Message-State: AOJu0YyW7FlO2QuhGpfgNL21ppw5OX/Etd40mmCfDPkOOvpJcG8kJR0u
	keP19XObE8L9cN2h5UczPD03+mLsYymlKCpzrdcR09Cd78G0jJ6+IeZALNOjVqQGkII=
X-Gm-Gg: ASbGncs7ylM+0fMWneKb8hrOuAxPH9uYweU7p5R+cn21zQKZ4SstPjwuL1Ffqalxrxj
	z5/I0AYEhISZ1GxXVuukrjYs7wF80rc0y33QUhi5F3Wq1sKW1aaxVQLfoHopY4nP4PKo3Au4ybA
	nvxU4gLukDx0Lcdemb2Zdg3rdzDwDtM14B/af0mA7YJZKdsHLcBQrYgF/j86KzcikHdmv2RGr+8
	bKC3N+sHYoPlL53p4ijaRs9f+rtMHpmf6w5gRTY9bPdOzXu+9ZZR1KiTPNSr3cX6jO99Dmp8N6s
	ucLEIdI8xuxDXKuj/KzUOQgs2t8N2FvhkuSwEzLRXFPu9F6ncWW4UsufmNXW43chHxCS+0nYO4S
	+r3rlhUYY9sNol8Zmzuk1A8cv5OR4b1M4tQ==
X-Google-Smtp-Source: AGHT+IHV2DsKYukz0ToL/QUwJmZIASeuLWzocqNPY2bDPD/ioupP0VqUikMShauFWenGbnurM19gxQ==
X-Received: by 2002:a05:690c:6f12:b0:71e:7053:281 with SMTP id 00721157ae682-71f9d4983e5mr6616627b3.8.1755557562222;
        Mon, 18 Aug 2025 15:52:42 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:a996:9117:6d16:a41d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6def6b41sm25125477b3.37.2025.08.18.15.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 15:52:41 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	syzbot <syzbot+55ad87f38795d6787521@syzkaller.appspotmail.com>
Subject: [PATCH] hfsplus: fix KMSAN uninit-value issue in __hfsplus_ext_cache_extent()
Date: Mon, 18 Aug 2025 15:52:32 -0700
Message-Id: <20250818225232.126402-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The syzbot reported issue in __hfsplus_ext_cache_extent():

[   70.194323][ T9350] BUG: KMSAN: uninit-value in __hfsplus_ext_cache_extent+0x7d0/0x990
[   70.195022][ T9350]  __hfsplus_ext_cache_extent+0x7d0/0x990
[   70.195530][ T9350]  hfsplus_file_extend+0x74f/0x1cf0
[   70.195998][ T9350]  hfsplus_get_block+0xe16/0x17b0
[   70.196458][ T9350]  __block_write_begin_int+0x962/0x2ce0
[   70.196959][ T9350]  cont_write_begin+0x1000/0x1950
[   70.197416][ T9350]  hfsplus_write_begin+0x85/0x130
[   70.197873][ T9350]  generic_perform_write+0x3e8/0x1060
[   70.198374][ T9350]  __generic_file_write_iter+0x215/0x460
[   70.198892][ T9350]  generic_file_write_iter+0x109/0x5e0
[   70.199393][ T9350]  vfs_write+0xb0f/0x14e0
[   70.199771][ T9350]  ksys_write+0x23e/0x490
[   70.200149][ T9350]  __x64_sys_write+0x97/0xf0
[   70.200570][ T9350]  x64_sys_call+0x3015/0x3cf0
[   70.201065][ T9350]  do_syscall_64+0xd9/0x1d0
[   70.201506][ T9350]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   70.202054][ T9350]
[   70.202279][ T9350] Uninit was created at:
[   70.202693][ T9350]  __kmalloc_noprof+0x621/0xf80
[   70.203149][ T9350]  hfsplus_find_init+0x8d/0x1d0
[   70.203602][ T9350]  hfsplus_file_extend+0x6ca/0x1cf0
[   70.204087][ T9350]  hfsplus_get_block+0xe16/0x17b0
[   70.204561][ T9350]  __block_write_begin_int+0x962/0x2ce0
[   70.205074][ T9350]  cont_write_begin+0x1000/0x1950
[   70.205547][ T9350]  hfsplus_write_begin+0x85/0x130
[   70.206017][ T9350]  generic_perform_write+0x3e8/0x1060
[   70.206519][ T9350]  __generic_file_write_iter+0x215/0x460
[   70.207042][ T9350]  generic_file_write_iter+0x109/0x5e0
[   70.207552][ T9350]  vfs_write+0xb0f/0x14e0
[   70.207961][ T9350]  ksys_write+0x23e/0x490
[   70.208375][ T9350]  __x64_sys_write+0x97/0xf0
[   70.208810][ T9350]  x64_sys_call+0x3015/0x3cf0
[   70.209255][ T9350]  do_syscall_64+0xd9/0x1d0
[   70.209680][ T9350]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   70.210230][ T9350]
[   70.210454][ T9350] CPU: 2 UID: 0 PID: 9350 Comm: repro Not tainted 6.12.0-rc5 #5
[   70.211174][ T9350] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   70.212115][ T9350] =====================================================
[   70.212734][ T9350] Disabling lock debugging due to kernel taint
[   70.213284][ T9350] Kernel panic - not syncing: kmsan.panic set ...
[   70.213858][ T9350] CPU: 2 UID: 0 PID: 9350 Comm: repro Tainted: G    B              6.12.0-rc5 #5
[   70.214679][ T9350] Tainted: [B]=BAD_PAGE
[   70.215057][ T9350] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   70.215999][ T9350] Call Trace:
[   70.216309][ T9350]  <TASK>
[   70.216585][ T9350]  dump_stack_lvl+0x1fd/0x2b0
[   70.217025][ T9350]  dump_stack+0x1e/0x30
[   70.217421][ T9350]  panic+0x502/0xca0
[   70.217803][ T9350]  ? kmsan_get_metadata+0x13e/0x1c0

[   70.218294][ Message fromT sy9350]  kmsan_report+0x296/slogd@syzkaller 0x2aat Aug 18 22:11:058 ...
 kernel
:[   70.213284][ T9350] Kernel panic - not syncing: kmsan.panic [   70.220179][ T9350]  ? kmsan_get_metadata+0x13e/0x1c0
set ...
[   70.221254][ T9350]  ? __msan_warning+0x96/0x120
[   70.222066][ T9350]  ? __hfsplus_ext_cache_extent+0x7d0/0x990
[   70.223023][ T9350]  ? hfsplus_file_extend+0x74f/0x1cf0
[   70.224120][ T9350]  ? hfsplus_get_block+0xe16/0x17b0
[   70.224946][ T9350]  ? __block_write_begin_int+0x962/0x2ce0
[   70.225756][ T9350]  ? cont_write_begin+0x1000/0x1950
[   70.226337][ T9350]  ? hfsplus_write_begin+0x85/0x130
[   70.226852][ T9350]  ? generic_perform_write+0x3e8/0x1060
[   70.227405][ T9350]  ? __generic_file_write_iter+0x215/0x460
[   70.227979][ T9350]  ? generic_file_write_iter+0x109/0x5e0
[   70.228540][ T9350]  ? vfs_write+0xb0f/0x14e0
[   70.228997][ T9350]  ? ksys_write+0x23e/0x490
[   70.229458][ T9350]  ? __x64_sys_write+0x97/0xf0
[   70.229939][ T9350]  ? x64_sys_call+0x3015/0x3cf0
[   70.230432][ T9350]  ? do_syscall_64+0xd9/0x1d0
[   70.230941][ T9350]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   70.231926][ T9350]  ? kmsan_get_metadata+0x13e/0x1c0
[   70.232738][ T9350]  ? kmsan_internal_set_shadow_origin+0x77/0x110
[   70.233711][ T9350]  ? kmsan_get_metadata+0x13e/0x1c0
[   70.234516][ T9350]  ? kmsan_get_shadow_origin_ptr+0x4a/0xb0
[   70.235398][ T9350]  ? __msan_metadata_ptr_for_load_4+0x24/0x40
[   70.236323][ T9350]  ? hfsplus_brec_find+0x218/0x9f0
[   70.237090][ T9350]  ? __pfx_hfs_find_rec_by_key+0x10/0x10
[   70.237938][ T9350]  ? __msan_instrument_asm_store+0xbf/0xf0
[   70.238827][ T9350]  ? __msan_metadata_ptr_for_store_4+0x27/0x40
[   70.239772][ T9350]  ? __hfsplus_ext_write_extent+0x536/0x620
[   70.240666][ T9350]  ? kmsan_get_metadata+0x13e/0x1c0
[   70.241175][ T9350]  __msan_warning+0x96/0x120
[   70.241645][ T9350]  __hfsplus_ext_cache_extent+0x7d0/0x990
[   70.242223][ T9350]  hfsplus_file_extend+0x74f/0x1cf0
[   70.242748][ T9350]  hfsplus_get_block+0xe16/0x17b0
[   70.243255][ T9350]  ? kmsan_internal_set_shadow_origin+0x77/0x110
[   70.243878][ T9350]  ? kmsan_get_metadata+0x13e/0x1c0
[   70.244400][ T9350]  ? kmsan_get_shadow_origin_ptr+0x4a/0xb0
[   70.244967][ T9350]  __block_write_begin_int+0x962/0x2ce0
[   70.245531][ T9350]  ? __pfx_hfsplus_get_block+0x10/0x10
[   70.246079][ T9350]  cont_write_begin+0x1000/0x1950
[   70.246598][ T9350]  hfsplus_write_begin+0x85/0x130
[   70.247105][ T9350]  ? __pfx_hfsplus_get_block+0x10/0x10
[   70.247650][ T9350]  ? __pfx_hfsplus_write_begin+0x10/0x10
[   70.248211][ T9350]  generic_perform_write+0x3e8/0x1060
[   70.248752][ T9350]  __generic_file_write_iter+0x215/0x460
[   70.249314][ T9350]  generic_file_write_iter+0x109/0x5e0
[   70.249856][ T9350]  ? kmsan_internal_set_shadow_origin+0x77/0x110
[   70.250487][ T9350]  vfs_write+0xb0f/0x14e0
[   70.250930][ T9350]  ? __pfx_generic_file_write_iter+0x10/0x10
[   70.251530][ T9350]  ksys_write+0x23e/0x490
[   70.251974][ T9350]  __x64_sys_write+0x97/0xf0
[   70.252450][ T9350]  x64_sys_call+0x3015/0x3cf0
[   70.252924][ T9350]  do_syscall_64+0xd9/0x1d0
[   70.253384][ T9350]  ? irqentry_exit+0x16/0x60
[   70.253844][ T9350]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   70.254430][ T9350] RIP: 0033:0x7f7a92adffc9
[   70.254873][ T9350] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 48
[   70.256674][ T9350] RSP: 002b:00007fff0bca3188 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[   70.257485][ T9350] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7a92adffc9
[   70.258246][ T9350] RDX: 000000000208e24b RSI: 0000000020000100 RDI: 0000000000000004
[   70.258998][ T9350] RBP: 00007fff0bca31a0 R08: 00007fff0bca31a0 R09: 00007fff0bca31a0
[   70.259769][ T9350] R10: 0000000000000000 R11: 0000000000000202 R12: 000055e0d75f8250
[   70.260520][ T9350] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   70.261286][ T9350]  </TASK>
[   70.262026][ T9350] Kernel Offset: disabled

(gdb) l *__hfsplus_ext_cache_extent+0x7d0
0xffffffff8318aef0 is in __hfsplus_ext_cache_extent (fs/hfsplus/extents.c:168).
163		fd->key->ext.cnid = 0;
164		res = hfs_brec_find(fd, hfs_find_rec_by_key);
165		if (res && res != -ENOENT)
166			return res;
167		if (fd->key->ext.cnid != fd->search_key->ext.cnid ||
168		    fd->key->ext.fork_type != fd->search_key->ext.fork_type)
169			return -ENOENT;
170		if (fd->entrylength != sizeof(hfsplus_extent_rec))
171			return -EIO;
172		hfs_bnode_read(fd->bnode, extent, fd->entryoffset,

The __hfsplus_ext_cache_extent() calls __hfsplus_ext_read_extent():

res = __hfsplus_ext_read_extent(fd, hip->cached_extents, inode->i_ino,
				block, HFSPLUS_IS_RSRC(inode) ?
					HFSPLUS_TYPE_RSRC :
					HFSPLUS_TYPE_DATA);

And if inode->i_ino could be equal to zero or any non-available CNID,
then hfs_brec_find() could not find the record in the tree. As a result,
fd->key could be compared with fd->search_key. But hfsplus_find_init()
uses kmalloc() for fd->key and fd->search_key allocation:

int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
{
<skipped>
        ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
        if (!ptr)
                return -ENOMEM;
        fd->search_key = ptr;
        fd->key = ptr + tree->max_key_len + 2;
<skipped>
}

Finally, fd->key is still not initialized if hfs_brec_find()
has found nothing.

This patch changes kmalloc() on kzalloc() in hfs_find_init()
and intializes fd->record, fd->keyoffset, fd->keylength,
fd->entryoffset, fd->entrylength for the case if hfs_brec_find()
has been found nothing in the b-tree node.

Reported-by: syzbot <syzbot+55ad87f38795d6787521@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=55ad87f38795d6787521
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/bfind.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index 901e83d65d20..26ebac4c6042 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -18,7 +18,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 
 	fd->tree = tree;
 	fd->bnode = NULL;
-	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
+	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 	fd->search_key = ptr;
@@ -158,6 +158,12 @@ int hfs_brec_find(struct hfs_find_data *fd, search_strategy_t do_key_compare)
 	__be32 data;
 	int height, res;
 
+	fd->record = -1;
+	fd->keyoffset = -1;
+	fd->keylength = -1;
+	fd->entryoffset = -1;
+	fd->entrylength = -1;
+
 	tree = fd->tree;
 	if (fd->bnode)
 		hfs_bnode_put(fd->bnode);
-- 
2.43.0


