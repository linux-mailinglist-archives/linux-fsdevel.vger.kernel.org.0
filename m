Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 850AC12A9BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2019 03:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfLZC1b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Dec 2019 21:27:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56587 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726893AbfLZC13 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Dec 2019 21:27:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577327246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YJqjUH7vi87pEZSLD7MKF1pZgOM8LZyAmnT+DqqPgdM=;
        b=LYe4tCSbyfMH6FvgCtwrpDBPk457uI8/LplSW8hY8f0SRTCjAxzOmJXyLWyRc4Ilxqoxp3
        ZJQlhUltXbdS7owKiIaCHTnBqu8fzLuDZBFBlqJJyfrCceHVEwBaM98HyRP9OiP6AeAlca
        eyWO6mjXFnZa+/+ps1ZfWW4JbSklppI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-brln3UgNNE2eo715QK7NNA-1; Wed, 25 Dec 2019 21:27:22 -0500
X-MC-Unique: brln3UgNNE2eo715QK7NNA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73A65107ACC7;
        Thu, 26 Dec 2019 02:27:19 +0000 (UTC)
Received: from ming.t460p (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BFBED5C578;
        Thu, 26 Dec 2019 02:27:07 +0000 (UTC)
Date:   Thu, 26 Dec 2019 10:27:02 +0800
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
Message-ID: <20191226022702.GA2901@ming.t460p>
References: <20191218094830.GB30602@ming.t460p>
 <b1b6a0e9d690ecd9432025acd2db4ac09f834040.camel@unipv.it>
 <20191223130828.GA25948@ming.t460p>
 <20191223162619.GA3282@mit.edu>
 <4c85fd3f2ec58694cc1ff7ab5c88d6e11ab6efec.camel@unipv.it>
 <20191223172257.GB3282@mit.edu>
 <bb5d395fe47f033be0b8ed96cbebf8867d2416c4.camel@unipv.it>
 <20191223195301.GC3282@mit.edu>
 <20191224012707.GA13083@ming.t460p>
 <20191225051722.GA119634@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191225051722.GA119634@mit.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 25, 2019 at 12:17:22AM -0500, Theodore Y. Ts'o wrote:
> On Tue, Dec 24, 2019 at 09:27:07AM +0800, Ming Lei wrote:
> > The ext4_release_file() should be run from read() or write() syscall if
> > Fedora 30's 'cp' is implemented correctly. IMO, it isn't expected behavior
> > for ext4_release_file() to be run thousands of times when just
> > running 'cp' once, see comment of ext4_release_file():
> 
> What's your evidence of that?  As opposed to the writeback taking a
> long time, leading to the *one* call of ext4_release_file taking a
> long time?  If it's a big file, we might very well be calliing
> ext4_writepages multiple times, from a single call to
> __filemap_fdatawrite_range().
> 
> You confused mightily from that assertion, and that caused me to make
> assumptions that cp was doing something crazy.  But I'm quite conviced
> now that this is almost certainly not what is happening.
> 
> > > I suspect the next step is use a blktrace, to see what kind of I/O is
> > > being sent to the USB drive, and how long it takes for the I/O to
> > > complete.  You might also try to capture the output of "iostat -x 1"
> > > while the script is running, and see what the difference might be
> > > between a kernel version that has the problem and one that doesn't,
> > > and see if that gives us a clue.
> > 
> > That isn't necessary, given we have concluded that the bad write
> > performance is caused by broken write order.
> 
> I didn't see any evidence of that from what I had in my inbox, so I
> went back to the mailing list archives to figure out what you were
> talking about.  Part of the problem is this has been a very
> long-spanning thread, and I had deleted from my inbox all of the parts
> relating to the MQ scheduler since that was clearly Not My Problem.  :-)
> 
> So, summarizing the most of the thread.  The problem started when we
> removed the legacy I/O scheduler, since we are now only using the MQ
> scheduler.  What the kernel is sending is long writes (240 sectors),
> but it is being sent as an interleaved stream of two sequential
> writes.  This particular pendrive can't handle this workload, because
> it has a very simplistic Flash Translation Layer.  Now, this is not
> *broken*, from a storage perspective; it's just that it's more than
> the simple little brain of this particular pen drive can handle.
> 
> Previously, with a single queue, and specially since the queue depth
> supported by this pen drive is 1, the elevator algorithm would sort
> the I/O requests so that it would be mostly sequential, and this
> wouldn't be much of a problem.  However, once the legacy I/O stack was
> removed, the MQ stack is designed so that we don't have to take a
> global lock in order to submit an I/O request.  That also means that
> we can't do a full elevator sort since that would require locking all
> of the queues.
> 
> This is not a problem, since HDD's generally have a 16 deep queue, and
> SSD's have a super-deep queue depth since they get their speed via
> parallel writes to different flash chips.  Unfortunately, it *is* a
> problem for super primitive USB sticks.
> 
> > So far, the reason points to the extra writeback path from exit_to_usermode_loop().
> > If it is not from close() syscall, the issue should be related with file reference
> > count. If it is from close() syscall, the issue might be in 'cp''s
> > implementation.
> 
> Oh, it's probably from the close system call; and it's *only* from a
> single close system call.  Because there is the auto delayed

Right. Looks I mis-interpreted the stackcount log, IOs are submitted
from single close syscall.

> allocation resolution to protect against buggy userspace, under
> certain circumstances, as I explained earlier, we force a full
> writeout on a close for a file decsriptor which was opened with an
> O_TRUNC.  This is by *design*, since we are trying to protect against
> buggy userspace (application programmers vastly outnumber file system
> programmers, and far too many of them want O_PONY).  This is Working
> As Intended.
> 
> You can disable it by deleting the test file before the cp:
> 
>     rm -f /mnt/pendrive/$testfile
> 
> Or you can disable the protection against stupid userspace by using
> the noauto_da_alloc mount option.  (But then if you have a buggy game
> program which writes the top-ten score file by using open(2) w/
> O_TRUNC, and then said program closes the OpenGL library, and the
> proprietary 3rd party binary-only video driver wedges the X server
> requiring a hard reset to recover, and the top-ten score file becomes
> a zero-length file, don't come crying to me...  Or if a graphical text
> editor forgets to use fsync(2) before saving a source file you spent
> hours working on, and then the system crashes at exactly the wrong
> moment and your source file becomes zero-length, against, don't come
> crying to me.  Blame the stupid application programmer which wrote
> your text editor who decided to skip the fsync(2), or who decided that
> copying the ACL's and xattrs was Too Hard(tm), and so opening the file
> with O_TRUNC and rewriting the file in place was easier for the
> application programmer.)
> 
> In any case, I think this is all working all as intended.  The MQ I/O
> stack is optimized for modern HDD and SSD's, and especially SSD's.
> And the file system assumes that parallel sequential writes,
> especially if they are large, is really not a big deal, since that's
> what NCQ or massive parallelism of pretty much all SSD's want.
> (Again, ignoring the legacy of crappy flash drives.
> 
> You can argue with storage stack folks about whether we need to have
> super-dumb mode for slow, crappy flash which uses a global lock and a
> global elevator scheduler for super-crappy flash if you want.  I'm
> going to stay out of that argument.

As I mentioned in the following link:

https://lore.kernel.org/linux-scsi/20191224084721.GA27248@ming.t460p/

The reason is that ioc_batching and BDI congestion is removed by blk-mq.

Then after queue is congested, multiple sequential writes can be done
concurrently at the same time. Before ioc_batching and BDI congestion is
removed, writes are done serialized from multiple processes actually, so
IOs are dispatched to drive in strict sequential order.

This way can't be an issue for SSD.

Maybe we need to be careful for HDD., since the request count in scheduler
queue is double of in-flight request count, and in theory NCQ should only
cover all in-flight 32 requests. I will find a sata HDD., and see if
performance drop can be observed in the similar 'cp' test.


Thanks,
Ming

