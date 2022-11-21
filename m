Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6819A63298E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 17:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiKUQdG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 11:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiKUQcu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:32:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A9BD0DCA
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 08:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669048303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=AdoRsC2dtNKs1Qa8jpBYbsBqJbZoSu/Gw2tBgqjEFcQ=;
        b=grlB6BUjOPN23kZ2NFEM11Gdxn8URw0mPYcoHLrE4828m8pzPZHr9wRlnmiadd5tC2vdpF
        ryb75CYJh/CXSraL/mMAh/Mk03L0uVgxbcxWA2QYveibUY7iXoD3hB6QuhuAh362Zq+txs
        pl9M++foiBRf8ljMALYwcyzbY+1SKOQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-ERsPdNVHOZCRqS8BWISmQQ-1; Mon, 21 Nov 2022 11:31:39 -0500
X-MC-Unique: ERsPdNVHOZCRqS8BWISmQQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2E4788646E;
        Mon, 21 Nov 2022 16:31:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 456FE17582;
        Mon, 21 Nov 2022 16:31:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, zhangpeng362@huawei.com,
        asmadeus@codewreck.org,
        syzbot+a76f6a6e524cf2080aa3@syzkaller.appspotmail.com,
        Jeff Layton <jlayton@kernel.org>, ericvh@gmail.com,
        lucho@ionkov.net, jefflexu@linux.alibaba.com,
        linux-cachefs@redhat.com, linux_oss@crudebyte.com,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fscache: fix OOB Read in __fscache_acquire_volume
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <479289.1669048275.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
From:   David Howells <dhowells@redhat.com>
Date:   Mon, 21 Nov 2022 16:31:34 +0000
Message-ID: <479316.1669048294@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Could you apply this please?

David
---
The type of a->key[0] is char in fscache_volume_same().  If the length of
cache volume key is greater than 127, the value of a->key[0] is less than
0.  In this case, klen becomes much larger than 255 after type conversion,
because the type of klen is size_t.  As a result, memcmp() is read out of
bounds.

This causes a slab-out-of-bounds Read in __fscache_acquire_volume(), as
reported by Syzbot.

Fix this by changing the type of the stored key to "u8 *" rather than "cha=
r
*" (it isn't a simple string anyway).  Also put in a check that the volume
name doesn't exceed NAME_MAX.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-out-of-bounds in memcmp+0x16f/0x1c0 lib/string.c:757
Read of size 8 at addr ffff888016f3aa90 by task syz-executor344/3613

CPU: 0 PID: 3613 Comm: syz-executor344 Not tainted
6.0.0-rc2-syzkaller-00327-g8379c0b31fbc #0
Hardware name: Google Compute Engine/Google Compute Engine, BIOS
Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
 kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
 memcmp+0x16f/0x1c0 lib/string.c:757
 memcmp include/linux/fortify-string.h:420 [inline]
 fscache_volume_same fs/fscache/volume.c:133 [inline]
 fscache_hash_volume fs/fscache/volume.c:171 [inline]
 __fscache_acquire_volume+0x76c/0x1080 fs/fscache/volume.c:328
 fscache_acquire_volume include/linux/fscache.h:204 [inline]
 v9fs_cache_session_get_cookie+0x143/0x240 fs/9p/cache.c:34
 v9fs_session_init+0x1166/0x1810 fs/9p/v9fs.c:473
 v9fs_mount+0xba/0xc90 fs/9p/vfs_super.c:126
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7d5064b1d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 14 00 00 90 48 89 f8 48 89
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd1700c028 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd1700c060 RCX: 00007f7d5064b1d9
RDX: 0000000020000040 RSI: 0000000020000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000020000200 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000f4240
R13: 0000000000000000 R14: 00007ffd1700c04c R15: 00007ffd1700c050
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Fixes: 62ab63352350 ("fscache: Implement volume registration")
Reported-by: syzbot+a76f6a6e524cf2080aa3@syzkaller.appspotmail.com
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Zhang Peng <zhangpeng362@huawei.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: v9fs-developer@lists.sourceforge.net
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/Y3OH+Dmi0QIOK18n@codewreck.org/ # Zhang Pe=
ng's v1 fix
Link: https://lore.kernel.org/r/20221115140447.2971680-1-zhangpeng362@huaw=
ei.com/ # Zhang Peng's v2 fix
Link: https://lore.kernel.org/r/166869954095.3793579.8500020902371015443.s=
tgit@warthog.procyon.org.uk/ # v1
---
 fs/fscache/volume.c     |    7 +++++--
 include/linux/fscache.h |    2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/fscache/volume.c b/fs/fscache/volume.c
index a058e0136bfe..ab8ceddf9efa 100644
--- a/fs/fscache/volume.c
+++ b/fs/fscache/volume.c
@@ -203,7 +203,11 @@ static struct fscache_volume *fscache_alloc_volume(co=
nst char *volume_key,
 	struct fscache_volume *volume;
 	struct fscache_cache *cache;
 	size_t klen, hlen;
-	char *key;
+	u8 *key;
+
+	klen =3D strlen(volume_key);
+	if (klen > NAME_MAX)
+		return NULL;
 =

 	if (!coherency_data)
 		coherency_len =3D 0;
@@ -229,7 +233,6 @@ static struct fscache_volume *fscache_alloc_volume(con=
st char *volume_key,
 	/* Stick the length on the front of the key and pad it out to make
 	 * hashing easier.
 	 */
-	klen =3D strlen(volume_key);
 	hlen =3D round_up(1 + klen + 1, sizeof(__le32));
 	key =3D kzalloc(hlen, GFP_KERNEL);
 	if (!key)
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 36e5dd84cf59..8e312c8323a8 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -75,7 +75,7 @@ struct fscache_volume {
 	atomic_t			n_accesses;	/* Number of cache accesses in progress */
 	unsigned int			debug_id;
 	unsigned int			key_hash;	/* Hash of key string */
-	char				*key;		/* Volume ID, eg. "afs@example.com@1234" */
+	u8				*key;		/* Volume ID, eg. "afs@example.com@1234" */
 	struct list_head		proc_link;	/* Link in /proc/fs/fscache/volumes */
 	struct hlist_bl_node		hash_link;	/* Link in hash table */
 	struct work_struct		work;

