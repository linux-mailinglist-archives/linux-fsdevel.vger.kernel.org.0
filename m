Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518EC566CC1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jul 2022 14:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbiGEMUW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 08:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237341AbiGEMTD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:19:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AA31CFE4;
        Tue,  5 Jul 2022 05:14:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B431B817AC;
        Tue,  5 Jul 2022 12:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EC9C341C7;
        Tue,  5 Jul 2022 12:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657023260;
        bh=eBWd0tCkw8jxlUV3NSOCIj8B6jofKqA950ZsVt66SzE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=N67ZaWn9tVq7Gt7/fkdkN7ek7TjT5uzBWxkpI77WGBYzeedQbmQ6H9DeiNSxa0E4c
         8iaMaSTFIGELURYmBmq91SdfVHaNkrpn+tTtFvFRh2qlS+fv32he9cUYiiL5E2rHDy
         tsw5xXgriJI+i+bFtgZMmDmUXVXmayr8oSHVFRTZauqr9Fh/tCQJCKXuX8Wzu/z3zp
         nu0JQoUT+akB1cldzf1cSoTXBNbP0SWbmZ3T2mC4Tv3OYK0QlV84QamHDa+idiXCZI
         x+yYIOjkl/Xw8Y6LRGzfR4JzmFT9bDlOLqr4yJz7gHr99nkOvHAO6ta3kGL2iOBSc7
         c0iL8JFlbifnA==
Message-ID: <3d031d76040d76f0cebde50fca28ba038216890c.camel@kernel.org>
Subject: Re: [PATCH v2 0/2] netfs: fix the crash when unlocking the folio
From:   Jeff Layton <jlayton@kernel.org>
To:     xiubli@redhat.com, dhowells@redhat.com
Cc:     linux-kernel@vger.kernel.org, willy@infradead.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, ceph-devel@vger.kernel.org,
        marc.dionne@auristor.com, linux-afs@lists.infradead.org
Date:   Tue, 05 Jul 2022 08:14:18 -0400
In-Reply-To: <20220705025255.331695-1-xiubli@redhat.com>
References: <20220705025255.331695-1-xiubli@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-07-05 at 10:52 +0800, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
>=20
> V2:
> - Add error_unlocked lable and rename error lable to error_locked.
>=20
>=20
> kernel: page:00000000c9746ff1 refcount:2 mapcount:0 mapping:00000000dc278=
5bb index:0x1 pfn:0x141afc
> kernel: memcg:ffff88810f766000
> kernel: aops:ceph_aops [ceph] ino:100000005e7 dentry name:"postgresql-Fri=
.log"=20
> kernel: flags: 0x5ffc000000201c(uptodate|dirty|lru|private|node=3D0|zone=
=3D2|lastcpupid=3D0x7ff)
> kernel: raw: 005ffc000000201c ffffea000a9eeb48 ffffea00060ade48 ffff88819=
3ed8228
> kernel: raw: 0000000000000001 ffff88810cc96500 00000002ffffffff ffff88810=
f766000
> kernel: page dumped because: VM_BUG_ON_FOLIO(!folio_test_locked(folio))
> kernel: ------------[ cut here ]------------
> kernel: kernel BUG at mm/filemap.c:1559!
> kernel: invalid opcode: 0000 [#1] PREEMPT SMP PTI
> kernel: CPU: 4 PID: 131697 Comm: postmaster Tainted: G S                5=
.19.0-rc2-ceph-g822a4c74e05d #1
> kernel: Hardware name: Supermicro SYS-5018R-WR/X10SRW-F, BIOS 2.0 12/17/2=
015
> kernel: RIP: 0010:folio_unlock+0x26/0x30
> kernel: Code: 00 0f 1f 00 0f 1f 44 00 00 48 8b 07 a8 01 74 0e f0 80 27 fe=
 78 01 c3 31 f6 e9 d6 fe ff ff 48 c7 c6 c0 81 37 82 e8 aa 64 04 00 <0f> 0b =
0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 87 b8 01 00 00
> kernel: RSP: 0018:ffffc90004377bc8 EFLAGS: 00010246
> kernel: RAX: 000000000000003f RBX: ffff888193ed8228 RCX: 0000000000000001
> kernel: RDX: 0000000000000000 RSI: ffffffff823a3569 RDI: 00000000ffffffff
> kernel: RBP: ffffffff828a0058 R08: 0000000000000001 R09: 0000000000000001
> kernel: R10: 000000007c6b0fd2 R11: 0000000000000034 R12: 0000000000000001
> kernel: R13: 00000000fffffe00 R14: ffffea000506bf00 R15: ffff888193ed8000
> kernel: FS:  00007f4993626340(0000) GS:ffff88885fd00000(0000) knlGS:00000=
00000000000
> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kernel: CR2: 0000555789ee8000 CR3: 000000017a52a006 CR4: 00000000001706e0
> kernel: Call Trace:
> kernel: <TASK>
> kernel: netfs_write_begin+0x130/0x950 [netfs]
> kernel: ceph_write_begin+0x46/0xd0 [ceph]
> kernel: generic_perform_write+0xef/0x200
> kernel: ? file_update_time+0xd4/0x110
> kernel: ceph_write_iter+0xb01/0xcd0 [ceph]
> kernel: ? lock_is_held_type+0xe3/0x140
> kernel: ? new_sync_write+0x106/0x180
> kernel: new_sync_write+0x106/0x180
> kernel: vfs_write+0x29a/0x3a0
> kernel: ksys_write+0x5c/0xd0
> kernel: do_syscall_64+0x34/0x80
> kernel: entry_SYSCALL_64_after_hwframe+0x46/0xb0
> kernel: RIP: 0033:0x7f49903205c8
> kernel: Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 00 f3 0f=
 1e fa 48 8d 05 d5 3f 2a 00 8b 00 85 c0 75 17 b8 01 00 00 00 0f 05 <48> 3d =
00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89 d4 55
> kernel: RSP: 002b:00007fff104bd178 EFLAGS: 00000246 ORIG_RAX: 00000000000=
00001
> kernel: RAX: ffffffffffffffda RBX: 0000000000000048 RCX: 00007f49903205c8
> kernel: RDX: 0000000000000048 RSI: 000055944d3c1ea0 RDI: 000000000000000b
> kernel: RBP: 000055944d3c1ea0 R08: 000055944d3963d0 R09: 00007fff1055b080
> kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 000055944d3962f0
> kernel: R13: 0000000000000048 R14: 00007f49905bb880 R15: 0000000000000048
> kernel: </TASK>
>=20
>=20
>=20
> Xiubo Li (2):
>   netfs: do not unlock and put the folio twice
>   afs: unlock the folio when vnode is marked deleted
>=20
>  fs/afs/file.c            |  8 +++++++-
>  fs/netfs/buffered_read.c | 13 +++++++------
>  2 files changed, 14 insertions(+), 7 deletions(-)
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
