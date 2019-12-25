Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A333A12A5F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2019 06:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbfLYFRz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Dec 2019 00:17:55 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35676 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725784AbfLYFRz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Dec 2019 00:17:55 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBP5HMP6016470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Dec 2019 00:17:23 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9471C420485; Wed, 25 Dec 2019 00:17:22 -0500 (EST)
Date:   Wed, 25 Dec 2019 00:17:22 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ming Lei <ming.lei@redhat.com>
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
Message-ID: <20191225051722.GA119634@mit.edu>
References: <f38db337cf26390f7c7488a0bc2076633737775b.camel@unipv.it>
 <20191218094830.GB30602@ming.t460p>
 <b1b6a0e9d690ecd9432025acd2db4ac09f834040.camel@unipv.it>
 <20191223130828.GA25948@ming.t460p>
 <20191223162619.GA3282@mit.edu>
 <4c85fd3f2ec58694cc1ff7ab5c88d6e11ab6efec.camel@unipv.it>
 <20191223172257.GB3282@mit.edu>
 <bb5d395fe47f033be0b8ed96cbebf8867d2416c4.camel@unipv.it>
 <20191223195301.GC3282@mit.edu>
 <20191224012707.GA13083@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224012707.GA13083@ming.t460p>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 24, 2019 at 09:27:07AM +0800, Ming Lei wrote:
> The ext4_release_file() should be run from read() or write() syscall if
> Fedora 30's 'cp' is implemented correctly. IMO, it isn't expected behavior
> for ext4_release_file() to be run thousands of times when just
> running 'cp' once, see comment of ext4_release_file():

What's your evidence of that?  As opposed to the writeback taking a
long time, leading to the *one* call of ext4_release_file taking a
long time?  If it's a big file, we might very well be calliing
ext4_writepages multiple times, from a single call to
__filemap_fdatawrite_range().

You confused mightily from that assertion, and that caused me to make
assumptions that cp was doing something crazy.  But I'm quite conviced
now that this is almost certainly not what is happening.

> > I suspect the next step is use a blktrace, to see what kind of I/O is
> > being sent to the USB drive, and how long it takes for the I/O to
> > complete.  You might also try to capture the output of "iostat -x 1"
> > while the script is running, and see what the difference might be
> > between a kernel version that has the problem and one that doesn't,
> > and see if that gives us a clue.
> 
> That isn't necessary, given we have concluded that the bad write
> performance is caused by broken write order.

I didn't see any evidence of that from what I had in my inbox, so I
went back to the mailing list archives to figure out what you were
talking about.  Part of the problem is this has been a very
long-spanning thread, and I had deleted from my inbox all of the parts
relating to the MQ scheduler since that was clearly Not My Problem.  :-)

So, summarizing the most of the thread.  The problem started when we
removed the legacy I/O scheduler, since we are now only using the MQ
scheduler.  What the kernel is sending is long writes (240 sectors),
but it is being sent as an interleaved stream of two sequential
writes.  This particular pendrive can't handle this workload, because
it has a very simplistic Flash Translation Layer.  Now, this is not
*broken*, from a storage perspective; it's just that it's more than
the simple little brain of this particular pen drive can handle.

Previously, with a single queue, and specially since the queue depth
supported by this pen drive is 1, the elevator algorithm would sort
the I/O requests so that it would be mostly sequential, and this
wouldn't be much of a problem.  However, once the legacy I/O stack was
removed, the MQ stack is designed so that we don't have to take a
global lock in order to submit an I/O request.  That also means that
we can't do a full elevator sort since that would require locking all
of the queues.

This is not a problem, since HDD's generally have a 16 deep queue, and
SSD's have a super-deep queue depth since they get their speed via
parallel writes to different flash chips.  Unfortunately, it *is* a
problem for super primitive USB sticks.

> So far, the reason points to the extra writeback path from exit_to_usermode_loop().
> If it is not from close() syscall, the issue should be related with file reference
> count. If it is from close() syscall, the issue might be in 'cp''s
> implementation.

Oh, it's probably from the close system call; and it's *only* from a
single close system call.  Because there is the auto delayed
allocation resolution to protect against buggy userspace, under
certain circumstances, as I explained earlier, we force a full
writeout on a close for a file decsriptor which was opened with an
O_TRUNC.  This is by *design*, since we are trying to protect against
buggy userspace (application programmers vastly outnumber file system
programmers, and far too many of them want O_PONY).  This is Working
As Intended.

You can disable it by deleting the test file before the cp:

    rm -f /mnt/pendrive/$testfile

Or you can disable the protection against stupid userspace by using
the noauto_da_alloc mount option.  (But then if you have a buggy game
program which writes the top-ten score file by using open(2) w/
O_TRUNC, and then said program closes the OpenGL library, and the
proprietary 3rd party binary-only video driver wedges the X server
requiring a hard reset to recover, and the top-ten score file becomes
a zero-length file, don't come crying to me...  Or if a graphical text
editor forgets to use fsync(2) before saving a source file you spent
hours working on, and then the system crashes at exactly the wrong
moment and your source file becomes zero-length, against, don't come
crying to me.  Blame the stupid application programmer which wrote
your text editor who decided to skip the fsync(2), or who decided that
copying the ACL's and xattrs was Too Hard(tm), and so opening the file
with O_TRUNC and rewriting the file in place was easier for the
application programmer.)

In any case, I think this is all working all as intended.  The MQ I/O
stack is optimized for modern HDD and SSD's, and especially SSD's.
And the file system assumes that parallel sequential writes,
especially if they are large, is really not a big deal, since that's
what NCQ or massive parallelism of pretty much all SSD's want.
(Again, ignoring the legacy of crappy flash drives.

You can argue with storage stack folks about whether we need to have
super-dumb mode for slow, crappy flash which uses a global lock and a
global elevator scheduler for super-crappy flash if you want.  I'm
going to stay out of that argument.

					- Ted
