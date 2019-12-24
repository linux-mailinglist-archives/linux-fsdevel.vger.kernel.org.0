Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDA98129C68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2019 02:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfLXB1m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Dec 2019 20:27:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30866 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726997AbfLXB1k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Dec 2019 20:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577150858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VtuJDTK8A0+oPEcdARBW6M8N5bDF9QRZRZAmHYybdxk=;
        b=cphZH9rV2o6QWa/aRabQ1nI8tgYQ3yeDxghLNGvLlQuewbYWXaufrDM0Namp3rjsyPzvTI
        iYk/0NqdWowesEsmNsUof70RvCRgoicvUapQC7l25NNyxhnUAI24RtvmAcuMTL1i9OkHg0
        HF4hC3ZIDt8fNtVSveA09HROY4QkCGs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-l9zVJDJeNcCIE8UkJAbTHw-1; Mon, 23 Dec 2019 20:27:34 -0500
X-MC-Unique: l9zVJDJeNcCIE8UkJAbTHw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B68463CD9;
        Tue, 24 Dec 2019 01:27:32 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 927BC80B38;
        Tue, 24 Dec 2019 01:27:13 +0000 (UTC)
Date:   Tue, 24 Dec 2019 09:27:07 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Andrea Vai <andrea.vai@unipv.it>,
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
Message-ID: <20191224012707.GA13083@ming.t460p>
References: <20191211213316.GA14983@ming.t460p>
 <f38db337cf26390f7c7488a0bc2076633737775b.camel@unipv.it>
 <20191218094830.GB30602@ming.t460p>
 <b1b6a0e9d690ecd9432025acd2db4ac09f834040.camel@unipv.it>
 <20191223130828.GA25948@ming.t460p>
 <20191223162619.GA3282@mit.edu>
 <4c85fd3f2ec58694cc1ff7ab5c88d6e11ab6efec.camel@unipv.it>
 <20191223172257.GB3282@mit.edu>
 <bb5d395fe47f033be0b8ed96cbebf8867d2416c4.camel@unipv.it>
 <20191223195301.GC3282@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223195301.GC3282@mit.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ted,

On Mon, Dec 23, 2019 at 02:53:01PM -0500, Theodore Y. Ts'o wrote:
> On Mon, Dec 23, 2019 at 07:45:57PM +0100, Andrea Vai wrote:
> > basically, it's:
> > 
> >   mount UUID=$uuid /mnt/pendrive
> >   SECONDS=0
> >   cp $testfile /mnt/pendrive
> >   umount /mnt/pendrive
> >   tempo=$SECONDS
> > 
> > and it copies one file only. Anyway, you can find the whole script
> > attached.
> 
> OK, so whether we are doing the writeback at the end of cp, or when
> you do the umount, it's probably not going to make any difference.  We
> can get rid of the stack trace in question by changing the script to
> be basically:
> 
> mount UUID=$uuid /mnt/pendrive
> SECONDS=0
> rm -f /mnt/pendrive/$testfile
> cp $testfile /mnt/pendrive
> umount /mnt/pendrive
> tempo=$SECONDS
> 
> I predict if you do that, you'll see that all of the time is spent in
> the umount, when we are trying to write back the file.
> 
> I really don't think then this is a file system problem at all.  It's
> just that USB I/O is slow, for whatever reason.  We'll see a stack
> trace in the writeback code waiting for the I/O to be completed, but
> that doesn't mean that the root cause is in the writeback code or in
> the file system which is triggering the writeback.

Wrt. the slow write on this usb storage, it is caused by two writeback
path, one is the writeback wq, another is from ext4_release_file() which
is triggered from exit_to_usermode_loop().

When the two write path is run concurrently, the sequential write order
is broken, then write performance drops much on this particular usb
storage.

The ext4_release_file() should be run from read() or write() syscall if
Fedora 30's 'cp' is implemented correctly. IMO, it isn't expected behavior
for ext4_release_file() to be run thousands of times when just
running 'cp' once, see comment of ext4_release_file():

	/*
	 * Called when an inode is released. Note that this is different
	 * from ext4_file_open: open gets called at every open, but release
	 * gets called only when /all/ the files are closed.
	 */
	static int ext4_release_file(struct inode *inode, struct file *filp)

> 
> I suspect the next step is use a blktrace, to see what kind of I/O is
> being sent to the USB drive, and how long it takes for the I/O to
> complete.  You might also try to capture the output of "iostat -x 1"
> while the script is running, and see what the difference might be
> between a kernel version that has the problem and one that doesn't,
> and see if that gives us a clue.

That isn't necessary, given we have concluded that the bad write
performance is caused by broken write order.

> 
> > > And then send me
> > btw, please tell me if "me" means only you or I cc: all the
> > recipients, as usual
> 
> Well, I don't think we know what the root cause is.  Ming is focusing
> on that stack trace, but I think it's a red herring.....  And if it's
> not a file system problem, then other people will be best suited to
> debug the issue.

So far, the reason points to the extra writeback path from exit_to_usermode_loop().
If it is not from close() syscall, the issue should be related with file reference
count. If it is from close() syscall, the issue might be in 'cp''s
implementation.

Andrea, please collect the following log or the strace log requested by Ted, then
we can confirm if the extra writeback is from close() or read/write() syscall:

# pass PID of 'cp' to this script
#!/bin/sh
PID=$1
/usr/share/bcc/tools/trace -P $PID  -t -C \
    't:block:block_rq_insert "%s %d %d", args->rwbs, args->sector, args->nr_sector' \
    't:syscalls:sys_exit_close ' \
    't:syscalls:sys_exit_read ' \
    't:syscalls:sys_exit_write '


Thanks,
Ming

