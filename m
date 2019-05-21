Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC5B9255AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 18:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfEUQcB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 May 2019 12:32:01 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41432 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728055AbfEUQcB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 May 2019 12:32:01 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4LGV973024567
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 May 2019 12:31:10 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id DF045420481; Tue, 21 May 2019 12:31:08 -0400 (EDT)
Date:   Tue, 21 May 2019 12:31:08 -0400
To:     Jan Kara <jack@suse.cz>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        linux-fsdevel@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-ext4@vger.kernel.org, cgroups@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, jmoyer@redhat.com,
        amakhalov@vmware.com, anishs@vmware.com, srivatsab@vmware.com
Subject: Re: CFQ idling kills I/O performance on ext4 with blkio cgroup
 controller
Message-ID: <20190521163108.GB2591@mit.edu>
Mail-Followup-To: tytso@mit.edu, Jan Kara <jack@suse.cz>,
        Paolo Valente <paolo.valente@linaro.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        linux-fsdevel@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-ext4@vger.kernel.org, cgroups@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, jmoyer@redhat.com,
        amakhalov@vmware.com, anishs@vmware.com, srivatsab@vmware.com
References: <8d72fcf7-bbb4-2965-1a06-e9fc177a8938@csail.mit.edu>
 <1812E450-14EF-4D5A-8F31-668499E13652@linaro.org>
 <46c6a4be-f567-3621-2e16-0e341762b828@csail.mit.edu>
 <07D11833-8285-49C2-943D-E4C1D23E8859@linaro.org>
 <238e14ff-68d1-3b21-a291-28de4f2d77af@csail.mit.edu>
 <6EB6C9D2-E774-48FA-AC95-BC98D97645D0@linaro.org>
 <20190521091026.GA17019@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521091026.GA17019@quack2.suse.cz>
>From:  Theodore Ts'o <tytso@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
From:   "Theodore Ts'o" <tytso@mit.edu>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 21, 2019 at 11:10:26AM +0200, Jan Kara wrote:
> > [root@localhost tmp]# dd if=/dev/zero of=/root/test.img bs=512 count=10000 oflag=dsync
> 
> Yes and that's expected. It just shows how inefficient small synchronous IO
> is. Look, dd(1) writes 512-bytes. From FS point of view we have to write:
> full fs block with data (+4KB), inode to journal (+4KB), journal descriptor
> block (+4KB), journal superblock (+4KB), transaction commit block (+4KB) -
> so that's 20KB just from top of my head to write 512 bytes...

Well, it's not *that* bad.  With fdatasync(), we're only having to do
this worse case thing every 8 writes.  The other writes, we don't
actually need to do any file-system level block allocation, so it's
only a 512 byte write to the disk[1] seven out of eight writes.

That's also true for the slice_idle hit, of course, We only need to do
a jbd2 transaction when there is a block allocation, and that's only
going to happen one in eight writes.

       	   	      	     	     	   - Ted

[1] Of course, small synchronous writes to a HDD are *also* terrible
for performance, just from the HDD's perspective.  For a random write
workload, if you are using disks with a 4k physical sector size, it's
having to do a read/modify/write for each 512 byte write.  And HDD
vendors are talking about wanting to go to a 32k or 64k physical
sector size...  In this sequential write workload, you'll mostly be
shielded from this by the HDD's cache, but the fact that you have to
wait for the bits to hit the platter is always going to be painful.
