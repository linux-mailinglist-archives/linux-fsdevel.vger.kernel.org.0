Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17B9D129A98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2019 20:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfLWTx2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Dec 2019 14:53:28 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59299 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726766AbfLWTx2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Dec 2019 14:53:28 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBNJr19e001916
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Dec 2019 14:53:02 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1C82A420822; Mon, 23 Dec 2019 14:53:01 -0500 (EST)
Date:   Mon, 23 Dec 2019 14:53:01 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andrea Vai <andrea.vai@unipv.it>
Cc:     Ming Lei <ming.lei@redhat.com>,
        "Schmid, Carsten" <Carsten_Schmid@mentor.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        USB list <linux-usb@vger.kernel.org>,
        SCSI development list <linux-scsi@vger.kernel.org>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: AW: Slow I/O on USB media after commit
 f664a3cc17b7d0a2bc3b3ab96181e1029b0ec0e6
Message-ID: <20191223195301.GC3282@mit.edu>
References: <20191211160745.GA129186@mit.edu>
 <20191211213316.GA14983@ming.t460p>
 <f38db337cf26390f7c7488a0bc2076633737775b.camel@unipv.it>
 <20191218094830.GB30602@ming.t460p>
 <b1b6a0e9d690ecd9432025acd2db4ac09f834040.camel@unipv.it>
 <20191223130828.GA25948@ming.t460p>
 <20191223162619.GA3282@mit.edu>
 <4c85fd3f2ec58694cc1ff7ab5c88d6e11ab6efec.camel@unipv.it>
 <20191223172257.GB3282@mit.edu>
 <bb5d395fe47f033be0b8ed96cbebf8867d2416c4.camel@unipv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb5d395fe47f033be0b8ed96cbebf8867d2416c4.camel@unipv.it>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 23, 2019 at 07:45:57PM +0100, Andrea Vai wrote:
> basically, it's:
> 
>   mount UUID=$uuid /mnt/pendrive
>   SECONDS=0
>   cp $testfile /mnt/pendrive
>   umount /mnt/pendrive
>   tempo=$SECONDS
> 
> and it copies one file only. Anyway, you can find the whole script
> attached.

OK, so whether we are doing the writeback at the end of cp, or when
you do the umount, it's probably not going to make any difference.  We
can get rid of the stack trace in question by changing the script to
be basically:

mount UUID=$uuid /mnt/pendrive
SECONDS=0
rm -f /mnt/pendrive/$testfile
cp $testfile /mnt/pendrive
umount /mnt/pendrive
tempo=$SECONDS

I predict if you do that, you'll see that all of the time is spent in
the umount, when we are trying to write back the file.

I really don't think then this is a file system problem at all.  It's
just that USB I/O is slow, for whatever reason.  We'll see a stack
trace in the writeback code waiting for the I/O to be completed, but
that doesn't mean that the root cause is in the writeback code or in
the file system which is triggering the writeback.

I suspect the next step is use a blktrace, to see what kind of I/O is
being sent to the USB drive, and how long it takes for the I/O to
complete.  You might also try to capture the output of "iostat -x 1"
while the script is running, and see what the difference might be
between a kernel version that has the problem and one that doesn't,
and see if that gives us a clue.

> > And then send me
> btw, please tell me if "me" means only you or I cc: all the
> recipients, as usual

Well, I don't think we know what the root cause is.  Ming is focusing
on that stack trace, but I think it's a red herring.....  And if it's
not a file system problem, then other people will be best suited to
debug the issue.

   	      	     	   	      	    - Ted
