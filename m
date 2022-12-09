Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3077664892A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Dec 2022 20:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiLITqM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Dec 2022 14:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiLITqL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Dec 2022 14:46:11 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EB0ACB20
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Dec 2022 11:46:09 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id r130so991381oih.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Dec 2022 11:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUtWcuSTInVjvHkT3JVwZI+2CUfch/TMT8ly1gjzHG0=;
        b=iBTgNM92w3Hc8C5xcZ2xfPlKyYm8pkZUifOUWHhOvo29jy4OeJTEkVGyzIObNrCJRK
         3qMR/jyrY4DUkjZ6sGk6zIcTdeU98CO4RAwqpF6c/1XBv1uf8N3JYmnJb9Wwuv7LEebl
         cI51SV8MIeJVI9P0Y9N2XCjHWn81o+UjlrCZqjL+dOAxOeyLN/LdIG2ueatCP+r0FJsT
         Kfcf8J3dt1+i5FwBn6KasMkidRDGopq9ucEzyAwrVUcX3tzkBypQWKz080Hz+e7zlhFW
         mJnrZ8JoEGOQSA3N1wUXATgai/GJ7xBnGNa8DdpSNUOFFur37OfEe3Y6gBbaCOMowZr9
         6/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUtWcuSTInVjvHkT3JVwZI+2CUfch/TMT8ly1gjzHG0=;
        b=Mba2LYASRqMHvDwvcCO3XT0Sw8G2Rzy0p3Z/WydlqxrZqWaQnJ6GYXx5dK6ys09HMc
         jagj64aWx1gUGFyUG+4nANzWqbfPQyrBM2O5jywbK+jxUEH2FABKvPsg25OY0NQLaYn6
         toXtAydPgsiHpqPRfXwx4ZtUELDXzXtKjkxXjuR9SHcm1yacjEFMI/XIUjj/a18HNzLY
         zoMUf7ZOOM2mMKZ/p1REmThU5H45k0UJoqS/I9XqDb9aHzBMbAjAhUs45n6OLPKTg8u5
         YFKbdNkdHIYv/cEIYt7DoB3fAgXmsAwPScLylH72VEtEaHdnzV2E/nQceWhn28qr6Q+h
         OD+w==
X-Gm-Message-State: ANoB5pnZOXt0bwMSATi+QgjR0FMtU/YI5tnq4vZz2Af4LryJ+VwJhIyS
        ShxKKs0jfJNhzhrKDGLbodiHxw==
X-Google-Smtp-Source: AA0mqf4i13BGNrw6VQ15TRVLskLaNFlxe4FXICAJbE0UEnsW9D3C2WaIqYRYOB5GP7PIhrOaQnPq/w==
X-Received: by 2002:a05:6808:1119:b0:35b:f934:2f8d with SMTP id e25-20020a056808111900b0035bf9342f8dmr2698124oih.16.1670615169016;
        Fri, 09 Dec 2022 11:46:09 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id 37-20020a9d0128000000b00661ad8741b4sm942615otu.24.2022.12.09.11.46.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Dec 2022 11:46:08 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] hfs: fix missing hfs_bnode_get() in __hfs_bnode_create
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20221209091035.2062184-1-liushixin2@huawei.com>
Date:   Fri, 9 Dec 2022 11:46:05 -0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <500343C9-FA5B-4A7B-8E68-F45AF5697CBC@dubeyko.com>
References: <20221209091035.2062184-1-liushixin2@huawei.com>
To:     Liu Shixin <liushixin2@huawei.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Dec 9, 2022, at 1:10 AM, Liu Shixin <liushixin2@huawei.com> wrote:
>=20
> Syzbot found a kernel BUG in hfs_bnode_put():
>=20
> kernel BUG at fs/hfs/bnode.c:466!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 3634 Comm: kworker/u4:5 Not tainted =
6.1.0-rc7-syzkaller-00190-g97ee9d1c1696 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS Google 10/26/2022
> Workqueue: writeback wb_workfn (flush-7:0)
> RIP: 0010:hfs_bnode_put+0x46f/0x480 fs/hfs/bnode.c:466
> Code: 8a 80 ff e9 73 fe ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c a0 =
fe ff ff 48 89 df e8 db 8a 80 ff e9 93 fe ff ff e8 a1 68 2c ff <0f> 0b =
e8 9a 68 2c ff 0f 0b 0f 1f 84 00 00 00 00 00 55 41 57 41 56
> RSP: 0018:ffffc90003b4f258 EFLAGS: 00010293
> RAX: ffffffff825e318f RBX: 0000000000000000 RCX: ffff8880739dd7c0
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc90003b4f430 R08: ffffffff825e2d9b R09: ffffed10045157d1
> R10: ffffed10045157d1 R11: 1ffff110045157d0 R12: ffff8880228abe80
> R13: ffff88807016c000 R14: dffffc0000000000 R15: ffff8880228abe00
> FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) =
knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa6ebe88718 CR3: 000000001e93d000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  hfs_write_inode+0x1bc/0xb40
>  write_inode fs/fs-writeback.c:1440 [inline]
>  __writeback_single_inode+0x4d6/0x670 fs/fs-writeback.c:1652
>  writeback_sb_inodes+0xb3b/0x18f0 fs/fs-writeback.c:1878
>  __writeback_inodes_wb+0x125/0x420 fs/fs-writeback.c:1949
>  wb_writeback+0x440/0x7b0 fs/fs-writeback.c:2054
>  wb_check_start_all fs/fs-writeback.c:2176 [inline]
>  wb_do_writeback fs/fs-writeback.c:2202 [inline]
>  wb_workfn+0x827/0xef0 fs/fs-writeback.c:2235
>  process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
>  worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
>  kthread+0x266/0x300 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
>  </TASK>
>=20
> By tracing the refcnt, I found the node is find by =
hfs_bnode_findhash() in
> __hfs_bnode_create(). There is a missing of hfs_bnode_get() after find =
the
> node.
>=20

The patch looks good. But could you add more detailed explanation
of the place of issue? I mean of adding source code of issue place
into comment section. Because, this place fs/hfs/bnode.c:466 is already
not consistent for the latest kernel version. And it will be not easy to =
find
in the future. But its is important to see the code that trigger the =
issue
to understand the fix.

/* Dispose of resources used by a node */
void hfs_bnode_put(struct hfs_bnode *node)
{=09
  if (node) {
       <skipped>=09
       BUG_ON(!atomic_read(&node->refcnt)); <=E2=80=94 we  have issue =
here!!!!
       <skipped>
  }
}

Am I correct?

I believe it will be great to have more detail explanation how the
issue is working. I mean the explanation how the issue happens
and for what use-case. Could you please add it?

Thanks,
Slava.

> Reported-by: syzbot+5b04b49a7ec7226c7426@syzkaller.appspotmail.com
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
> fs/hfs/bnode.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> index 2015e42e752a..6add6ebfef89 100644
> --- a/fs/hfs/bnode.c
> +++ b/fs/hfs/bnode.c
> @@ -274,6 +274,7 @@ static struct hfs_bnode *__hfs_bnode_create(struct =
hfs_btree *tree, u32 cnid)
> 		tree->node_hash[hash] =3D node;
> 		tree->node_hash_cnt++;
> 	} else {
> +		hfs_bnode_get(node2);
> 		spin_unlock(&tree->hash_lock);
> 		kfree(node);
> 		wait_event(node2->lock_wq, !test_bit(HFS_BNODE_NEW, =
&node2->flags));
> --=20
> 2.25.1
>=20

