Return-Path: <linux-fsdevel+bounces-30100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C0E9861C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 17:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B6E1F2C27F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 15:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710A019FA68;
	Wed, 25 Sep 2024 14:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="CO+ijkY7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D0D43158
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727274857; cv=none; b=B9PG7+v9O11x9vz/v82EC7snkkBT6Bs4zVTnXWlMGf/EQvpKhOAkNRAwiwsfCuPfZZL7+oefKTajLWCYlvhEFxnVVfuReD48nTisTOm4XI4XAjbsG8LVi4m/mq5NLgIz0biO+43jxcznks/Gtxlqwp6YEIhzgppm1Dqs7q0jn0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727274857; c=relaxed/simple;
	bh=AtqtjEkK+AUk6ACyf9LCOO3NLZRZooSD2Sf1HPC6BGo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qouktitoXoAw+5eR/3xc6+1g/VUHfmh/HB9XKKb00Fix+l+f96crUt2bxikQGCA7tzyjOnZG5Rh34Y8uBYMXmSOMEs6VuxYSQ1h/Nc4jxhj+wjOfER7nhyLxzm3/kcjxUSVVpGbDnfVwuO5uirJXlNSl9Up8u9h1UP21bMomS+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=CO+ijkY7; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 130B940645
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 14:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727274853;
	bh=GxKPrnIU1I3GU0CvN/XzCRoFswb4aJWlE53TgvU92Rk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=CO+ijkY7fa3uGd4SHJvGO85Z5BTneW1t0p05Rn4608iW5FrXKiCzLy721++s8HQ+n
	 3qFpvRQUbir0zD5BsxTn2NZxBeQ3/oyyzFQK4B1v4RZzf5RGK/FTYvS/eLaYGfysZS
	 54oC6dc69vkzO6KOijQVCei07ZCIAIMDoMurbsNAteANetKN3trem9yHq0rOKJQj02
	 E5Z09Rh6AKUe971O5eOrcAxxFWs4dIIZDyBbGyiMU0+CmmmRm7ZAEkoi+FrEFvtBdd
	 94DI5Vzx/KQxKRWmaexvsgY+DyPwRD58JJ2NaKxMOt34sE8g5fstFs3l5xEVXWWz34
	 qLAQTwDaBgAfQ==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a8d13a9cc7aso454680766b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 07:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727274852; x=1727879652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxKPrnIU1I3GU0CvN/XzCRoFswb4aJWlE53TgvU92Rk=;
        b=fhTI3F3aMPD2Xxpj/oplmiPtZwB0EGRJBTbuXaw0rSZucwcmIW2bLttzOMUe5dyRlK
         8teB/3accYNOCYsw2A1hMa3YiQl38SQVRa/ErngxHLpfoUhGWmMNhADuwmsJ2CZy9d2N
         nfVGvJRi2TdZ7AqOHCOCMH7lt6juvza/ZvqqCm/a9r9zzCudSvMX9Tch1P+SZFtXnK4Y
         m5g0VdHQ/kHWbY7a8WLDdXujKwgs94+1oQdKj4WIrCh38ZyE06/LF+s1Qs2obYsio5j/
         TnkXfBYRaO2ZmPgy3FNmA70XvycCzsA1qZkQKdpLxYW5Zk7vIk1OGugyvWLBHCWLq+4h
         PHBg==
X-Forwarded-Encrypted: i=1; AJvYcCUPrHGxpS9zIexCB89GCypkHjertmxEfLZyurJaHuY380TAsmqFuLu8lAY1iQZYxo8tdwaTZy4Y9SLguRzi@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4hQUMKf/PuKybhpIRnW3UnCXg3Wj3b53Q4T0DpIK7wyDWPE+8
	BkD3Yz/EODGRFQNKGsXfcIj/LFLzoMByAlIkXfjQj6hq3Gb6yfqouWrDaootXpQNDAyCYfZ79vd
	9uVGrhpmY+kRtym1dpDY/vruMN5BDzLWCtbqRafQ7UtdAdlrJXo2S1LcyUAOIxY+yQhPa93/+7j
	o9p5g=
X-Received: by 2002:a17:907:7f03:b0:a8d:caa:7ffb with SMTP id a640c23a62f3a-a93a03c3145mr233906166b.29.1727274852368;
        Wed, 25 Sep 2024 07:34:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkMud1tdev4JvCJ8nbs1UnCYmFH6la1yKrhtQLh+31n3CMfO83TaOsVrSzbVkkFuTuqpO8SA==
X-Received: by 2002:a17:907:7f03:b0:a8d:caa:7ffb with SMTP id a640c23a62f3a-a93a03c3145mr233903666b.29.1727274851863;
        Wed, 25 Sep 2024 07:34:11 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930cad0asm213137366b.118.2024.09.25.07.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 07:34:11 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: tytso@mit.edu
Cc: stable@vger.kernel.org,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Baokun Li <libaokun1@huawei.com>,
	=?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	Wesley Hershberger <wesley.hershberger@canonical.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: [PATCH 1/1] ext4: fix crash on BUG_ON in ext4_alloc_group_tables
Date: Wed, 25 Sep 2024 16:33:24 +0200
Message-Id: <20240925143325.518508-2-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240925143325.518508-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240925143325.518508-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[   33.882936] EXT4-fs (dm-5): mounted filesystem 8aaf41b2-6ac0-4fa8-b92b-77d10e1d16ca r/w with ordered data mode. Quota mode: none.
[   33.888365] EXT4-fs (dm-5): resizing filesystem from 7168 to 786432 blocks
[   33.888740] ------------[ cut here ]------------
[   33.888742] kernel BUG at fs/ext4/resize.c:324!
[   33.889075] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[   33.889503] CPU: 9 UID: 0 PID: 3576 Comm: resize2fs Not tainted 6.11.0+ #27
[   33.890039] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   33.890705] RIP: 0010:ext4_resize_fs+0x1212/0x12d0
[   33.891063] Code: b8 45 31 c0 4c 89 ff 45 31 c9 31 c9 ba 0e 08 00 00 48 c7 c6 68 75 65 b8 e8 2b 79 01 00 41 b8 ea ff ff ff 41 5f e9 8d f1 ff ff <0f> 0b 48 83 bd 70 ff ff ff 00 75 32 45 31 c0 e9 53 f1 ff ff 41 b8
[   33.892701] RSP: 0018:ffffa97f413f3cc8 EFLAGS: 00010202
[   33.893081] RAX: 0000000000000018 RBX: 0000000000000001 RCX: 00000000fffffff0
[   33.893639] RDX: 0000000000000017 RSI: 0000000000000016 RDI: 00000000e8c2c810
[   33.894197] RBP: ffffa97f413f3d90 R08: 0000000000000000 R09: 0000000000008000
[   33.894755] R10: ffffa97f413f3cc8 R11: ffffa2c1845bfc80 R12: 0000000000000000
[   33.895317] R13: ffffa2c1843d6000 R14: 0000000000008000 R15: ffffa2c199963000
[   33.895877] FS:  00007f46efd17000(0000) GS:ffffa2c89fc40000(0000) knlGS:0000000000000000
[   33.896524] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.896954] CR2: 00005630a4a1cc88 CR3: 000000010532c000 CR4: 0000000000350eb0
[   33.897516] Call Trace:
[   33.897638]  <TASK>
[   33.897728]  ? show_regs+0x6d/0x80
[   33.897942]  ? die+0x3c/0xa0
[   33.898106]  ? do_trap+0xe5/0x110
[   33.898311]  ? do_error_trap+0x6e/0x90
[   33.898555]  ? ext4_resize_fs+0x1212/0x12d0
[   33.898844]  ? exc_invalid_op+0x57/0x80
[   33.899101]  ? ext4_resize_fs+0x1212/0x12d0
[   33.899387]  ? asm_exc_invalid_op+0x1f/0x30
[   33.899675]  ? ext4_resize_fs+0x1212/0x12d0
[   33.899961]  ? ext4_resize_fs+0x745/0x12d0
[   33.900239]  __ext4_ioctl+0x4e0/0x1800
[   33.900489]  ? srso_alias_return_thunk+0x5/0xfbef5
[   33.900832]  ? putname+0x5b/0x70
[   33.901028]  ? srso_alias_return_thunk+0x5/0xfbef5
[   33.901374]  ? do_sys_openat2+0x87/0xd0
[   33.901632]  ? srso_alias_return_thunk+0x5/0xfbef5
[   33.901981]  ? srso_alias_return_thunk+0x5/0xfbef5
[   33.902324]  ? __x64_sys_openat+0x59/0xa0
[   33.902595]  ext4_ioctl+0x12/0x20
[   33.902802]  ? ext4_ioctl+0x12/0x20
[   33.903031]  __x64_sys_ioctl+0x99/0xd0
[   33.903277]  x64_sys_call+0x1206/0x20d0
[   33.903534]  do_syscall_64+0x72/0x110
[   33.903771]  ? srso_alias_return_thunk+0x5/0xfbef5
[   33.904115]  ? irqentry_exit+0x3f/0x50
[   33.904362]  ? srso_alias_return_thunk+0x5/0xfbef5
[   33.904707]  ? exc_page_fault+0x1aa/0x7b0
[   33.904979]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   33.905349] RIP: 0033:0x7f46efe3294f
[   33.905579] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 77 1f 48 8b 44 24 18 64 48 2b 04 25 28 00
[   33.907321] RSP: 002b:00007ffe9b8833a0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   33.907926] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f46efe3294f
[   33.908487] RDX: 00007ffe9b8834a0 RSI: 0000000040086610 RDI: 0000000000000004
[   33.909046] RBP: 00005630a4a0b0e0 R08: 0000000000000000 R09: 00007ffe9b8832d7
[   33.909605] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
[   33.910165] R13: 00005630a4a0c580 R14: 00005630a4a10400 R15: 0000000000000000
[   33.910740]  </TASK>
[   33.910837] Modules linked in:
[   33.911049] ---[ end trace 0000000000000000 ]---
[   33.911428] RIP: 0010:ext4_resize_fs+0x1212/0x12d0
[   33.911810] Code: b8 45 31 c0 4c 89 ff 45 31 c9 31 c9 ba 0e 08 00 00 48 c7 c6 68 75 65 b8 e8 2b 79 01 00 41 b8 ea ff ff ff 41 5f e9 8d f1 ff ff <0f> 0b 48 83 bd 70 ff ff ff 00 75 32 45 31 c0 e9 53 f1 ff ff 41 b8
[   33.913928] RSP: 0018:ffffa97f413f3cc8 EFLAGS: 00010202
[   33.914313] RAX: 0000000000000018 RBX: 0000000000000001 RCX: 00000000fffffff0
[   33.914909] RDX: 0000000000000017 RSI: 0000000000000016 RDI: 00000000e8c2c810
[   33.915482] RBP: ffffa97f413f3d90 R08: 0000000000000000 R09: 0000000000008000
[   33.916258] R10: ffffa97f413f3cc8 R11: ffffa2c1845bfc80 R12: 0000000000000000
[   33.917027] R13: ffffa2c1843d6000 R14: 0000000000008000 R15: ffffa2c199963000
[   33.917884] FS:  00007f46efd17000(0000) GS:ffffa2c89fc40000(0000) knlGS:0000000000000000
[   33.918818] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.919322] CR2: 00005630a4a1cc88 CR3: 000000010532c000 CR4: 0000000000350eb0
[   44.072293] ------------[ cut here ]------------

Cc: stable@vger.kernel.org # v6.8+
Fixes: 665d3e0af4d3 ("ext4: reduce unnecessary memory allocation in alloc_flex_gd()")
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Jan Kara <jack@suse.cz>
Cc: Baokun Li <libaokun1@huawei.com>
Cc: Stéphane Graber <stgraber@stgraber.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>
Cc: <linux-ext4@vger.kernel.org>
Reported-by: Wesley Hershberger <wesley.hershberger@canonical.com>
Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2081231
Reported-by: Stéphane Graber <stgraber@stgraber.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ext4/resize.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index e04eb08b9060..c057a7867363 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -300,8 +300,7 @@ static void free_flex_gd(struct ext4_new_flex_group_data *flex_gd)
  * block group.
  */
 static int ext4_alloc_group_tables(struct super_block *sb,
-				struct ext4_new_flex_group_data *flex_gd,
-				unsigned int flexbg_size)
+				struct ext4_new_flex_group_data *flex_gd)
 {
 	struct ext4_new_group_data *group_data = flex_gd->groups;
 	ext4_fsblk_t start_blk;
@@ -313,7 +312,7 @@ static int ext4_alloc_group_tables(struct super_block *sb,
 	ext4_group_t group;
 	ext4_group_t last_group;
 	unsigned overhead;
-	__u16 uninit_mask = (flexbg_size > 1) ? ~EXT4_BG_BLOCK_UNINIT : ~0;
+	__u16 uninit_mask = (flex_gd->resize_bg > 1) ? ~EXT4_BG_BLOCK_UNINIT : ~0;
 	int i;
 
 	BUG_ON(flex_gd->count == 0 || group_data == NULL);
@@ -321,8 +320,8 @@ static int ext4_alloc_group_tables(struct super_block *sb,
 	src_group = group_data[0].group;
 	last_group  = src_group + flex_gd->count - 1;
 
-	BUG_ON((flexbg_size > 1) && ((src_group & ~(flexbg_size - 1)) !=
-	       (last_group & ~(flexbg_size - 1))));
+	BUG_ON((flex_gd->resize_bg > 1) && ((src_group & ~(flex_gd->resize_bg - 1)) !=
+	       (last_group & ~(flex_gd->resize_bg - 1))));
 next_group:
 	group = group_data[0].group;
 	if (src_group >= group_data[0].group + flex_gd->count)
@@ -403,7 +402,7 @@ static int ext4_alloc_group_tables(struct super_block *sb,
 
 		printk(KERN_DEBUG "EXT4-fs: adding a flex group with "
 		       "%u groups, flexbg size is %u:\n", flex_gd->count,
-		       flexbg_size);
+		       flex_gd->resize_bg);
 
 		for (i = 0; i < flex_gd->count; i++) {
 			ext4_debug(
@@ -2158,7 +2157,7 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
 					 ext4_blocks_count(es));
 			last_update_time = jiffies;
 		}
-		if (ext4_alloc_group_tables(sb, flex_gd, flexbg_size) != 0)
+		if (ext4_alloc_group_tables(sb, flex_gd) != 0)
 			break;
 		err = ext4_flex_group_add(sb, resize_inode, flex_gd);
 		if (unlikely(err))
-- 
2.34.1


