Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC4B24B34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 11:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfEUJK3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 May 2019 05:10:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:46344 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726289AbfEUJK3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 May 2019 05:10:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D5BFBAC0C;
        Tue, 21 May 2019 09:10:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 33C381E3C72; Tue, 21 May 2019 11:10:26 +0200 (CEST)
Date:   Tue, 21 May 2019 11:10:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        linux-fsdevel@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-ext4@vger.kernel.org, cgroups@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        jmoyer@redhat.com, Theodore Ts'o <tytso@mit.edu>,
        amakhalov@vmware.com, anishs@vmware.com, srivatsab@vmware.com
Subject: Re: CFQ idling kills I/O performance on ext4 with blkio cgroup
 controller
Message-ID: <20190521091026.GA17019@quack2.suse.cz>
References: <8d72fcf7-bbb4-2965-1a06-e9fc177a8938@csail.mit.edu>
 <1812E450-14EF-4D5A-8F31-668499E13652@linaro.org>
 <46c6a4be-f567-3621-2e16-0e341762b828@csail.mit.edu>
 <07D11833-8285-49C2-943D-E4C1D23E8859@linaro.org>
 <238e14ff-68d1-3b21-a291-28de4f2d77af@csail.mit.edu>
 <6EB6C9D2-E774-48FA-AC95-BC98D97645D0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6EB6C9D2-E774-48FA-AC95-BC98D97645D0@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 21-05-19 08:23:05, Paolo Valente wrote:
> > Il giorno 21 mag 2019, alle ore 00:45, Srivatsa S. Bhat <srivatsa@csail.mit.edu> ha scritto:
> > 
> > On 5/20/19 3:19 AM, Paolo Valente wrote:
> >> 
> >> 
> >>> Il giorno 18 mag 2019, alle ore 22:50, Srivatsa S. Bhat <srivatsa@csail.mit.edu> ha scritto:
> >>> 
> >>> On 5/18/19 11:39 AM, Paolo Valente wrote:
> >>>> I've addressed these issues in my last batch of improvements for BFQ,
> >>>> which landed in the upcoming 5.2. If you give it a try, and still see
> >>>> the problem, then I'll be glad to reproduce it, and hopefully fix it
> >>>> for you.
> >>>> 
> >>> 
> >>> Hi Paolo,
> >>> 
> >>> Thank you for looking into this!
> >>> 
> >>> I just tried current mainline at commit 72cf0b07, but unfortunately
> >>> didn't see any improvement:
> >>> 
> >>> dd if=/dev/zero of=/root/test.img bs=512 count=10000 oflag=dsync
> >>> 
> >>> With mq-deadline, I get:
> >>> 
> >>> 5120000 bytes (5.1 MB, 4.9 MiB) copied, 3.90981 s, 1.3 MB/s
> >>> 
> >>> With bfq, I get:
> >>> 5120000 bytes (5.1 MB, 4.9 MiB) copied, 84.8216 s, 60.4 kB/s
> >>> 
> >> 
> >> Hi Srivatsa,
> >> thanks for reproducing this on mainline.  I seem to have reproduced a
> >> bonsai-tree version of this issue.  Before digging into the block
> >> trace, I'd like to ask you for some feedback.
> >> 
> >> First, in my test, the total throughput of the disk happens to be
> >> about 20 times as high as that enjoyed by dd, regardless of the I/O
> >> scheduler.  I guess this massive overhead is normal with dsync, but
> >> I'd like know whether it is about the same on your side.  This will
> >> help me understand whether I'll actually be analyzing about the same
> >> problem as yours.
> >> 
> > 
> > Do you mean to say the throughput obtained by dd'ing directly to the
> > block device (bypassing the filesystem)?
> 
> No no, I mean simply what follows.
> 
> 1) in one terminal:
> [root@localhost tmp]# dd if=/dev/zero of=/root/test.img bs=512 count=10000 oflag=dsync
> 10000+0 record dentro
> 10000+0 record fuori
> 5120000 bytes (5,1 MB, 4,9 MiB) copied, 14,6892 s, 349 kB/s
> 
> 2) In a second terminal, while the dd is in progress in the first
> terminal:
> $ iostat -tmd /dev/sda 3
> Linux 5.1.0+ (localhost.localdomain) 	20/05/2019 	_x86_64_	(2 CPU)
> 
> ...
> 20/05/2019 11:40:17
> Device             tps    MB_read/s    MB_wrtn/s    MB_read    MB_wrtn
> sda            2288,00         0,00         9,77          0         29
> 
> 20/05/2019 11:40:20
> Device             tps    MB_read/s    MB_wrtn/s    MB_read    MB_wrtn
> sda            2325,33         0,00         9,93          0         29
> 
> 20/05/2019 11:40:23
> Device             tps    MB_read/s    MB_wrtn/s    MB_read    MB_wrtn
> sda            2351,33         0,00        10,05          0         30
> ...
> 
> As you can see, the overall throughput (~10 MB/s) is more than 20
> times as high as the dd throughput (~350 KB/s).  But the dd is the
> only source of I/O.

Yes and that's expected. It just shows how inefficient small synchronous IO
is. Look, dd(1) writes 512-bytes. From FS point of view we have to write:
full fs block with data (+4KB), inode to journal (+4KB), journal descriptor
block (+4KB), journal superblock (+4KB), transaction commit block (+4KB) -
so that's 20KB just from top of my head to write 512 bytes...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
