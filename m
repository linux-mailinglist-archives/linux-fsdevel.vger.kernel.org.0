Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC7911A18A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 03:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfLKCmJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 21:42:09 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54503 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726619AbfLKCmJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 21:42:09 -0500
Received: from callcc.thunk.org (guestnat-104-132-34-105.corp.google.com [104.132.34.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBB2fb0M007024
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Dec 2019 21:41:38 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9BA5D421A48; Tue, 10 Dec 2019 21:41:37 -0500 (EST)
Date:   Tue, 10 Dec 2019 21:41:37 -0500
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
Message-ID: <20191211024137.GB61323@mit.edu>
References: <cb6e84781c4542229a3f31572cef19ab@SVR-IES-MBX-03.mgc.mentorg.com>
 <c1358b840b3a4971aa35a25d8495c2c8953403ea.camel@unipv.it>
 <20191128091712.GD15549@ming.t460p>
 <f82fd5129e3dcacae703a689be60b20a7fedadf6.camel@unipv.it>
 <20191129005734.GB1829@ming.t460p>
 <20191129023555.GA8620@ming.t460p>
 <320b315b9c87543d4fb919ecbdf841596c8fbcea.camel@unipv.it>
 <20191203022337.GE25002@ming.t460p>
 <8196b014b1a4d91169bf3b0d68905109aeaf2191.camel@unipv.it>
 <20191210080550.GA5699@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210080550.GA5699@ming.t460p>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 10, 2019 at 04:05:50PM +0800, Ming Lei wrote:
> > > The path[2] is expected behaviour. Not sure path [1] is correct,
> > > given
> > > ext4_release_file() is supposed to be called when this inode is
> > > released. That means the file is closed 4358 times during 1GB file
> > > copying to usb storage.
> > > 
> > > [1] insert requests when returning to user mode from syscall
> > > 
> > >   b'blk_mq_sched_request_inserted'
> > >   b'blk_mq_sched_request_inserted'
> > >   b'dd_insert_requests'
> > >   b'blk_mq_sched_insert_requests'
> > >   b'blk_mq_flush_plug_list'
> > >   b'blk_flush_plug_list'
> > >   b'io_schedule_prepare'
> > >   b'io_schedule'
> > >   b'rq_qos_wait'
> > >   b'wbt_wait'
> > >   b'__rq_qos_throttle'
> > >   b'blk_mq_make_request'
> > >   b'generic_make_request'
> > >   b'submit_bio'
> > >   b'ext4_io_submit'
> > >   b'ext4_writepages'
> > >   b'do_writepages'
> > >   b'__filemap_fdatawrite_range'
> > >   b'ext4_release_file'
> > >   b'__fput'
> > >   b'task_work_run'
> > >   b'exit_to_usermode_loop'
> > >   b'do_syscall_64'
> > >   b'entry_SYSCALL_64_after_hwframe'
> > >     4358

I'm guessing that your workload is repeatedly truncating a file (or
calling open with O_TRUNC) and then writing data to it.  When you do
this, then when the file is closed, we assume that since you were
replacing the previous contents of a file with new contents, that you
would be unhappy if the file contents was replaced by a zero length
file after a crash.  That's because ten years, ago there were a *huge*
number of crappy applications that would replace a file by reading it
into memory, truncating it, and then write out the new contents of the
file.  This could be a high score file for a game, or a KDE or GNOME
state file, etc.

So if someone does open, truncate, write, close, we still immediately
writing out the data on the close, assuming that the programmer really
wanted open, truncate, write, fsync, close, but was too careless to
actually do the right thing.

Some workaround[1] like this is done by all of the major file systems,
and was fallout the agreement from the "O_PONIES"[2] controversy.
This was discussed and agreed to at the 2009 LSF/MM workshop.  (See
the "rename, fsync, and ponies" section.)

[1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/317781/comments/45
[2] https://blahg.josefsipek.net/?p=364
[3] https://lwn.net/Articles/327601/

So if you're seeing a call to filemap_fdatawrite_range as the result
of a fput, that's why.

In any case, this behavior has been around for a decade, and it
appears to be incidental to your performance difficulties with your
USB thumbdrive and block-mq.

						- Ted
