Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9AC38C16B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 10:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbhEUIMM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 04:12:12 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:48095 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236428AbhEUIK1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 04:10:27 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-ZvW3bxJ4O5CppUscs7yADQ-1; Fri, 21 May 2021 04:08:46 -0400
X-MC-Unique: ZvW3bxJ4O5CppUscs7yADQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 621E3BD124;
        Fri, 21 May 2021 08:08:45 +0000 (UTC)
Received: from bahia.lan (ovpn-112-49.ams2.redhat.com [10.36.112.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 743A15C1C4;
        Fri, 21 May 2021 08:08:36 +0000 (UTC)
Date:   Fri, 21 May 2021 10:08:35 +0200
From:   Greg Kurz <groug@kaod.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        <virtualization@lists.linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <virtio-fs@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
        Max Reitz <mreitz@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v4 1/5] fuse: Fix leak in fuse_dentry_automount() error
 path
Message-ID: <20210521100835.52506623@bahia.lan>
In-Reply-To: <YKa8SZ8s6QeKZ4XP@zeniv-ca.linux.org.uk>
References: <20210520154654.1791183-1-groug@kaod.org>
        <20210520154654.1791183-2-groug@kaod.org>
        <YKa8SZ8s6QeKZ4XP@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 20 May 2021 19:45:13 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Thu, May 20, 2021 at 05:46:50PM +0200, Greg Kurz wrote:
> > Some rollback was forgotten during the addition of crossmounts.
> 
> Have you actually tested that?  Because I strongly suspect that
> by that point the ownership of fc and fm is with sb and those
> should be taken care of by deactivate_locked_super().

My bad, I didn't test but now I did and the issue is actually
worse than just a memory leak. This error path crashes upstream
without this patch:

[   26.206673] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   26.209560] #PF: supervisor read access in kernel mode
[   26.211699] #PF: error_code(0x0000) - not-present page
[   26.214574] PGD 0 P4D 0 
[   26.216016] Oops: 0000 [#1] SMP PTI
[   26.217451] CPU: 0 PID: 3380 Comm: ls Kdump: loaded Not tainted 5.13.0-virtio-fs-sync+ #30
[   26.220839] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   26.226362] RIP: 0010:__list_del_entry_valid+0x25/0x90
[   26.228449] Code: c3 0f 1f 40 00 48 8b 17 4c 8b 47 08 48 b8 00 01 00 00 00 00 ad de 48 39 c2 74 26 48 b8 22 01 00 00 00 00 ad de 49 39 c0 74 2b <49> 8b 30 48 39 fe 75 3a 48 8b 52 08 48 39 f2 75 48 b8 01 00 00 00
[   26.234256] RSP: 0018:ffffaa37006cbb18 EFLAGS: 00010217
[   26.235473] RAX: dead000000000122 RBX: ffff8f6844098200 RCX: 0000000000000000
[   26.236922] RDX: 0000000000000000 RSI: ffffffff99264e92 RDI: ffff8f6844098210
[   26.238401] RBP: ffff8f68420b3c00 R08: 0000000000000000 R09: 000000000000002a
[   26.239852] R10: 0000000000000000 R11: ffff8f6840402480 R12: ffff8f6844098210
[   26.241160] R13: ffff8f68420b3da8 R14: ffff8f6844098200 R15: 0000000000000000
[   26.242398] FS:  00007f547b93f200(0000) GS:ffff8f687bc00000(0000) knlGS:0000000000000000
[   26.243698] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   26.244693] CR2: 0000000000000000 CR3: 0000000104e50000 CR4: 00000000000006f0
[   26.245936] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   26.246961] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   26.247938] Call Trace:
[   26.248300]  fuse_mount_remove+0x2c/0x70 [fuse]
[   26.248892]  virtio_kill_sb+0x22/0x160 [virtiofs]
[   26.249487]  deactivate_locked_super+0x36/0xa0
[   26.250077]  fuse_dentry_automount+0x178/0x1a0 [fuse]


The crash happens because we're assuming fm was already added to
fc->mounts...

bool fuse_mount_remove(struct fuse_mount *fm)
{
	struct fuse_conn *fc = fm->fc;
	bool last = false;

	down_write(&fc->killsb);
	list_del_init(&fm->fc_entry); <=== HERE
	if (list_empty(&fc->mounts))
		last = true;
	up_write(&fc->killsb);

	return last;
}

but fm is added to fc->mounts much later after the superblock is fully
configured. Looking again at what is done for the root mount in
virtio_fs_get_tree(), I now realize sb->s_fs_info is used as a flag
to decide whether fuse_mount_remove() should be called:

static int virtio_fs_get_tree(struct fs_context *fsc)
{
...
	if (!sb->s_root) {
		err = virtio_fs_fill_super(sb, fsc);
		if (err) {
			fuse_conn_put(fc);
			kfree(fm);
CLEARED HERE =>		sb->s_fs_info = NULL;
			deactivate_locked_super(sb);
			return err;
		}

		sb->s_flags |= SB_ACTIVE;
	}
...
}

static void virtio_kill_sb(struct super_block *sb)
{
	struct fuse_mount *fm = get_fuse_mount_super(sb);

I.E. sb->s_fs_info

	bool last;

	/* If mount failed, we can still be called without any fc */
	if (fm) {

TESTED HERE ^^

		last = fuse_mount_remove(fm);
		if (last)
			virtio_fs_conn_destroy(fm);
	}
	kill_anon_super(sb);
}

The natural fix is to do the same in the automount case : take
back the ownership on fm by clearing sb->s_fs_info, which thus
implies to do the freeing.

