Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268F33092FF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Jan 2021 10:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhA3JMw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Jan 2021 04:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbhA3EQf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jan 2021 23:16:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69CFC061354;
        Fri, 29 Jan 2021 19:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=DenP85I1Njjb0sm/Pv5awH6u78JiwmjeMN74Dl7XDmA=; b=H8SDl3brId4iyEQMOwW4BfEUQ2
        Xy9mZcqFmFvcWvR6dxLgQ3QUwF+RwC9GNnBM28jr+2J7JQ5Bm8pWtzkJy9Bu5683unOHOgLMv+gFM
        jYIfOM6Ao2NNEjEzqoWU83ro0i2k1QtT++2jpOr8mpPL1+MxGJTvy2GRgyUg+z6xssmGMSAnWY2zd
        lqlVaZEtkQfNNrYTdAkx5Dh4tKL60XSKbWMPsTXg7ShS8Q1MALyQ1L4XvADIPpEa3DQT7A35auYCK
        RYKeUzMDMR7ROqaOWCMHMSpzECR3dkUR8mtXMmO0lgMzXZcgza2tXYiFwaZvQ9UvVr3UoISIOLjsY
        syMo01WQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l5hNO-00Afhm-T1; Sat, 30 Jan 2021 03:56:47 +0000
Date:   Sat, 30 Jan 2021 03:56:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org, dm-devel@redhat.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 04/17] block: split bio_kmalloc from bio_alloc_bioset
Message-ID: <20210130035646.GH308988@casper.infradead.org>
References: <20210126145247.1964410-1-hch@lst.de>
 <20210126145247.1964410-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210126145247.1964410-5-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 26, 2021 at 03:52:34PM +0100, Christoph Hellwig wrote:
> bio_kmalloc shares almost no logic with the bio_set based fast path
> in bio_alloc_bioset.  Split it into an entirely separate implementation.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bio.c         | 167 ++++++++++++++++++++++----------------------
>  include/linux/bio.h |   6 +-
>  2 files changed, 86 insertions(+), 87 deletions(-)

This patch causes current linux-next to OOM for me when running xfstests
after about ten minutes.  Haven't looked into why yet, this is just the
results of a git bisect.

The qemu command line is:

qemu-system-x86_64 -nodefaults -nographic -cpu host -machine accel=3Dkvm,nv=
dimm -m 2G,slots=3D8,maxmem=3D1T -smp 6 -kernel /home/willy/kernel/folio/.b=
uild_test_kernel-x86_64/kpgk/vmlinuz -append console=3Dhvc0 root=3D/dev/sda=
 rw log_buf_len=3D8M ktest.dir=3D/home/willy/kernel/ktest ktest.env=3D/tmp/=
build-test-kernel-nJO6QgxOmo/env quiet systemd.show_status=3D0 systemd.log-=
target=3Djournal crashkernel=3D128M no_console_suspend -device virtio-seria=
l -chardev stdio,id=3Dconsole -device virtconsole,chardev=3Dconsole -serial=
 unix:/tmp/build-test-kernel-nJO6QgxOmo/vm-kgdb,server,nowait -monitor unix=
:/tmp/build-test-kernel-nJO6QgxOmo/vm-mon,server,nowait -gdb unix:/tmp/buil=
d-test-kernel-nJO6QgxOmo/vm-gdb,server,nowait -device virtio-rng-pci -virtf=
s local,path=3D/,mount_tag=3Dhost,security_model=3Dnone -device virtio-scsi=
-pci,id=3Dhba -nic user,model=3Dvirtio,hostfwd=3Dtcp:127.0.0.1:24674-:22 -d=
rive if=3Dnone,format=3Draw,id=3Ddisk0,file=3D/var/lib/ktest/root.amd64,sna=
pshot=3Don -device scsi-hd,bus=3Dhba.0,drive=3Ddisk0 -drive if=3Dnone,forma=
t=3Draw,id=3Ddisk1,file=3D/tmp/build-test-kernel-nJO6QgxOmo/dev-1,cache=3Du=
nsafe -device scsi-hd,bus=3Dhba.0,drive=3Ddisk1 -drive if=3Dnone,format=3Dr=
aw,id=3Ddisk2,file=3D/tmp/build-test-kernel-nJO6QgxOmo/dev-2,cache=3Dunsafe=
 -device scsi-hd,bus=3Dhba.0,drive=3Ddisk2 -drive if=3Dnone,format=3Draw,id=
=3Ddisk3,file=3D/tmp/build-test-kernel-nJO6QgxOmo/dev-3,cache=3Dunsafe -dev=
ice scsi-hd,bus=3Dhba.0,drive=3Ddisk3

