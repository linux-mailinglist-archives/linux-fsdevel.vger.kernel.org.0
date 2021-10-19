Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101AA433733
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 15:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbhJSNjG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 09:39:06 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:35684 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbhJSNjF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:39:05 -0400
Received: by mail-ed1-f46.google.com with SMTP id w19so13045253edd.2;
        Tue, 19 Oct 2021 06:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l2fMMxDDiXx3vgfR9XbtY8zVEKvNNXiKJ69kmRp4vQM=;
        b=mCb8jqED0k1GQlElRY/RIaU6/LQcw05GMBYf6vFWLA9vc2DtSanoKswatoZlHXmZeR
         jxKfUU+m0/uml1+TeZGYzomvq95udLj57/03xWpDUy/P3CqOGD6bCnJBKzlJhShKAqml
         /NKIpkfkZR8E2C7pWzzyhCN5C7avmhImOUJcNWv522iNnmtPum3Z+C+OmlJmshhiBUyL
         SdLZ8QfUOh7MIizH83K0nYPshlDdQZHO7fd1jUfNRs1B4rxvOHJw7OsfEgz3GTvdSxC+
         5+Phg0IXOWQG1NpFvAhdllnkeefXi/zeTMN6v0r7AhGwLpcrlWXIv5TsgHvwW4w7BrEA
         RMaw==
X-Gm-Message-State: AOAM532VakqfLcy3QyLtmd9sevati6qN53VSuelDeibLn6VbcZs5ks0t
        Yi/RFhQVYplSzk6iuYQ5rktFFhBLOee3Zwv7
X-Google-Smtp-Source: ABdhPJxK5E41qyWGhA8m0/y1a2EmpcFIwcooZQ3yYlMpxn0gc32jmtmTmaGNK+k9ZR0AdgnAjoTadQ==
X-Received: by 2002:a05:6402:1e8c:: with SMTP id f12mr52173095edf.71.1634650576792;
        Tue, 19 Oct 2021 06:36:16 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id b2sm11215570edv.73.2021.10.19.06.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 06:36:16 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id g39so7785125wmp.3;
        Tue, 19 Oct 2021 06:36:16 -0700 (PDT)
X-Received: by 2002:a1c:a443:: with SMTP id n64mr6116840wme.32.1634650175559;
 Tue, 19 Oct 2021 06:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
From:   Marc Dionne <marc.dionne@auristor.com>
Date:   Tue, 19 Oct 2021 10:29:24 -0300
X-Gmail-Original-Message-ID: <CAB9dFdumxi0U_339S3PfC4TL83Srqn+qGz2AAbJ995NiLhbxnw@mail.gmail.com>
Message-ID: <CAB9dFdumxi0U_339S3PfC4TL83Srqn+qGz2AAbJ995NiLhbxnw@mail.gmail.com>
Subject: Re: [Linux-cachefs] [PATCH 00/67] fscache: Rewrite index API and
 management system
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-mm@kvack.org, linux-afs@lists.infradead.org,
        Shyam Prasad N <nspmangalore@gmail.com>,
        linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        v9fs-developer@lists.sourceforge.net,
        Ilya Dryomov <idryomov@gmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        ceph-devel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steve French <sfrench@samba.org>,
        linux-fsdevel@vger.kernel.org, Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anna Schumaker <anna.schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 18, 2021 at 11:50 AM David Howells <dhowells@redhat.com> wrote:
>
>
> Here's a set of patches that rewrites and simplifies the fscache index API
> to remove the complex operation scheduling and object state machine in
> favour of something much smaller and simpler.  It is built on top of the
> set of patches that removes the old API[1].

Testing this series in our afs test framework, saw the oops pasted below.

cachefiles_begin_operation+0x2d maps to cachefiles/io.c:565, where
object is probably NULL (object->file is at offset 0x28).

Marc
===
BUG: kernel NULL pointer dereference, address: 0000000000000028
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] SMP NOPTI
CPU: 5 PID: 16607 Comm: ar Tainted: G            E
5.15.0-rc5.kafs_testing+ #37
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.14.0-2.fc34 04/01/2014
RIP: 0010:cachefiles_begin_operation+0x2d/0x80 [cachefiles]
Code: 00 00 55 53 48 83 ec 08 48 8b 47 08 48 83 7f 10 00 48 8b 68 20
74 0c b8 01 00 00 00 48 83 c4 08 5b 5d c3 48 c7 07 a0 12 1b a0 <48> 8b
45 28 48 89 fb 48 85 c0 74 20 48 8d 7d 04 89 74 24 04 e8 3a
RSP: 0018:ffffc90000d33b48 EFLAGS: 00010246
RAX: ffff888014991420 RBX: ffff888100ae9cf0 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff888100ae9cf0
RBP: 0000000000000000 R08: 00000000000006b8 R09: ffff88810e98e000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888014991434
R13: 0000000000000002 R14: ffff888014991420 R15: 0000000000000002
FS:  00007f72d0486b80(0000) GS:ffff888139940000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000028 CR3: 000000007bac8004 CR4: 0000000000770ee0
PKRU: 55555554
Call Trace:
 fscache_begin_operation.part.0+0x1e3/0x210 [fscache]
 netfs_write_begin+0x3fb/0x800 [netfs]
 ? __fscache_use_cookie+0x120/0x200 [fscache]
 afs_write_begin+0x58/0x2c0 [kafs]
 ? __vfs_getxattr+0x2a/0x70
 generic_perform_write+0xb1/0x1b0
 ? file_update_time+0xcf/0x120
 __generic_file_write_iter+0x14c/0x1d0
 generic_file_write_iter+0x5d/0xb0
 afs_file_write+0x73/0xa0 [kafs]
 new_sync_write+0x105/0x180
 vfs_write+0x1cb/0x260
 ksys_write+0x4f/0xc0
 do_syscall_64+0x35/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f72d059a7a7
Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f
1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
RSP: 002b:00007fffc31942b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f72d059a7a7
RDX: 0000000000000008 RSI: 000055fe42367730 RDI: 0000000000000003
RBP: 000055fe42367730 R08: 0000000000000000 R09: 00007f72d066ca00
R10: 000000000000007c R11: 0000000000000246 R12: 0000000000000008
