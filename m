Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15D08163789
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 00:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgBRXyc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 18:54:32 -0500
Received: from mga06.intel.com ([134.134.136.31]:37582 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbgBRXyb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 18:54:31 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 15:54:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,458,1574150400"; 
   d="scan'208";a="408252387"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga005.jf.intel.com with ESMTP; 18 Feb 2020 15:54:30 -0800
Date:   Tue, 18 Feb 2020 15:54:30 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 00/12] Enable per-file/directory DAX operations V3
Message-ID: <20200218235429.GB14509@iweiny-DESK2.sc.intel.com>
References: <20200213195839.GG6870@magnolia>
 <20200213232923.GC22854@iweiny-DESK2.sc.intel.com>
 <CAPcyv4hkWoC+xCqicH1DWzmU2DcpY0at_A6HaBsrdLbZ6qzWow@mail.gmail.com>
 <20200214200607.GA18593@iweiny-DESK2.sc.intel.com>
 <x4936bcdfso.fsf@segfault.boston.devel.redhat.com>
 <20200214215759.GA20548@iweiny-DESK2.sc.intel.com>
 <x49y2t4bz8t.fsf@segfault.boston.devel.redhat.com>
 <x49tv3sbwu5.fsf@segfault.boston.devel.redhat.com>
 <20200218023535.GA14509@iweiny-DESK2.sc.intel.com>
 <x49zhdgasal.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x49zhdgasal.fsf@segfault.boston.devel.redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 09:22:58AM -0500, Jeff Moyer wrote:
> Ira Weiny <ira.weiny@intel.com> writes:
> 
> > Yep...  and a long weekend if you are in the US...  I ran the test with V4 and
> > got the panic below.
> >
> > Is this similar to what you see?  If so I'll work on it in V4.  FWIW with '-o
> 
> Yes, precisely.

Ok...

> 
> > dax' specified I don't see how fsstress is causing an issue with my patch set.
> > Does fsstress attempt to change dax states?  I don't see that in the test but
> > I'm not real familiar with generic/013 and fsstress.
> 
> Not that I'm aware of, no.
> 
> > If my disassembly of read_pages is correct it looks like readpage is null which
> > makes sense because all files should be IS_DAX() == true due to the mount option...
> >
> > But tracing code indicates that the patch:
> >
> > 	fs: remove unneeded IS_DAX() check
> >
> > ... may be the culprit and the following fix may work...
> >
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 3a7863ba51b9..7eaf74a2a39b 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -2257,7 +2257,7 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
> >         if (!count)
> >                 goto out; /* skip atime */
> >  
> > -       if (iocb->ki_flags & IOCB_DIRECT) {
> > +       if (iocb->ki_flags & IOCB_DIRECT || IS_DAX(inode)) {
> >                 struct file *file = iocb->ki_filp;
> >                 struct address_space *mapping = file->f_mapping;
> >                 struct inode *inode = mapping->host;
> 
> Well, you'll have to up-level the inode variable instantiation,
> obviously.  That solves this particular issue.

Well...  This seems to be a random issue.  I've had BMC issues with
my server most of the day...  But even with this patch I still get the failure
in read_pages().  :-/

And I have gotten it to both succeed and fail with qemu...  :-/

> The next traceback
> you'll hit is in the writeback path:

> 
> [  116.044545] ------------[ cut here ]------------
> [  116.049163] WARNING: CPU: 48 PID: 4469 at fs/dax.c:862 dax_writeback_mapping_range+0x397/0x530
> ...
> [  116.134509] CPU: 48 PID: 4469 Comm: fsstress Not tainted 5.6.0-rc1+ #43
> [  116.141121] Hardware name: Intel Corporation S2600WFD/S2600WFD, BIOS SE5C620.86B.0D.01.0395.022720191340 02/27/2019
> [  116.151549] RIP: 0010:dax_writeback_mapping_range+0x397/0x530
> [  116.157294] Code: ff ff 31 db 48 8b 7c 24 28 c6 07 00 0f 1f 40 00 fb 48 8b 7c 24 10 e8 98 fc 29 00 0f 1f 44 00 00 e9 f1 fc ff ff 4c 8b 64 24 08 <0f> 0b be fb ff ff ff 4c 89 e7 e8 fa 87 ed ff f0 41 80 8c 24 80 00
> [  116.176036] RSP: 0018:ffffb9b162fa7c18 EFLAGS: 00010046
> [  116.181261] RAX: 0000000000000000 RBX: 00000000000001ac RCX: 0000000000000020
> [  116.188387] RDX: 0000000000000000 RSI: 00000000000001ac RDI: ffffb9b162fa7c40
> [  116.195519] RBP: 0000000000000020 R08: ffff9a73dc24d6b0 R09: 0000000000000020
> [  116.202648] R10: 0000000000000000 R11: 0000000000000238 R12: ffff9a73d92c66b8
> [  116.209774] R13: ffffe4a09f0cb200 R14: 0000000000000000 R15: ffffe4a09f0cb200
> [  116.216907] FS:  00007f2dbcd22b80(0000) GS:ffff9a7420c00000(0000) knlGS:0000000000000000
> [  116.224992] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  116.230735] CR2: 00007fa21808b648 CR3: 000000179e0a2003 CR4: 00000000007606e0
> [  116.237860] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  116.244990] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  116.252115] PKRU: 55555554
> [  116.254827] Call Trace:
> [  116.257286]  do_writepages+0x41/0xd0
> [  116.260862]  __filemap_fdatawrite_range+0xcb/0x100
> [  116.265653]  filemap_write_and_wait_range+0x38/0x90
> [  116.270579]  xfs_setattr_size+0x2c2/0x3e0 [xfs]
> [  116.275126]  xfs_file_fallocate+0x239/0x440 [xfs]
> [  116.279831]  ? selinux_file_permission+0x108/0x140
> [  116.284622]  vfs_fallocate+0x14d/0x2f0
> [  116.288374]  ksys_fallocate+0x3c/0x80
> [  116.292039]  __x64_sys_fallocate+0x1a/0x20
> [  116.296139]  do_syscall_64+0x55/0x1d0
> [  116.299806]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  116.304856] RIP: 0033:0x7f2dbc21983b
> [  116.308435] Code: ff ff eb ba 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 8d 05 25 0e 2d 00 49 89 ca 8b 00 85 c0 75 14 b8 1d 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 5d c3 0f 1f 40 00 41 55 49 89 cd 41 54 49 89
> 
> That's here:
> 
>         /*
>          * A page got tagged dirty in DAX mapping? Something is seriously
>          * wrong.
>          */
>         if (WARN_ON(!xa_is_value(entry)))
>                 return -EIO;

I have not gotten this.  Having to walk to the lab to power cycle the machine
has slowed my progress...

Ira

> 
> Cheers,
> Jeff
> 
