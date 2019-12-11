Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 386F011A347
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 05:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfLKEBX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 23:01:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20489 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727526AbfLKEBX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 23:01:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576036882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cNipXhz3kcVRls/aNbq9+kWkGCjnAGD5cvo0k6au+L4=;
        b=P468xW71oOzzN23lLg5B0kHhhZWeNKoFRdP0mXlAmeKa+P7rgayqDKQBKt+iwnb9cpdaTy
        cHQcc5Ax9E0KIT2yBA+OAbMLDydER6x5SvvTFTj4b7idliqHIZMTQ391K5hLgpGOKiPk3z
        IOHaiEhBIa4ks69RnHmBGBDTnEpZkUo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-0AXY0FNmMHKQW0CvPtHA3w-1; Tue, 10 Dec 2019 23:01:18 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A420FDB60;
        Wed, 11 Dec 2019 04:01:15 +0000 (UTC)
Received: from ming.t460p (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA41E60BE1;
        Wed, 11 Dec 2019 04:01:02 +0000 (UTC)
Date:   Wed, 11 Dec 2019 12:00:58 +0800
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
Message-ID: <20191211040058.GC6864@ming.t460p>
References: <c1358b840b3a4971aa35a25d8495c2c8953403ea.camel@unipv.it>
 <20191128091712.GD15549@ming.t460p>
 <f82fd5129e3dcacae703a689be60b20a7fedadf6.camel@unipv.it>
 <20191129005734.GB1829@ming.t460p>
 <20191129023555.GA8620@ming.t460p>
 <320b315b9c87543d4fb919ecbdf841596c8fbcea.camel@unipv.it>
 <20191203022337.GE25002@ming.t460p>
 <8196b014b1a4d91169bf3b0d68905109aeaf2191.camel@unipv.it>
 <20191210080550.GA5699@ming.t460p>
 <20191211024137.GB61323@mit.edu>
MIME-Version: 1.0
In-Reply-To: <20191211024137.GB61323@mit.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 0AXY0FNmMHKQW0CvPtHA3w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 10, 2019 at 09:41:37PM -0500, Theodore Y. Ts'o wrote:
> On Tue, Dec 10, 2019 at 04:05:50PM +0800, Ming Lei wrote:
> > > > The path[2] is expected behaviour. Not sure path [1] is correct,
> > > > given
> > > > ext4_release_file() is supposed to be called when this inode is
> > > > released. That means the file is closed 4358 times during 1GB file
> > > > copying to usb storage.
> > > >=20
> > > > [1] insert requests when returning to user mode from syscall
> > > >=20
> > > >   b'blk_mq_sched_request_inserted'
> > > >   b'blk_mq_sched_request_inserted'
> > > >   b'dd_insert_requests'
> > > >   b'blk_mq_sched_insert_requests'
> > > >   b'blk_mq_flush_plug_list'
> > > >   b'blk_flush_plug_list'
> > > >   b'io_schedule_prepare'
> > > >   b'io_schedule'
> > > >   b'rq_qos_wait'
> > > >   b'wbt_wait'
> > > >   b'__rq_qos_throttle'
> > > >   b'blk_mq_make_request'
> > > >   b'generic_make_request'
> > > >   b'submit_bio'
> > > >   b'ext4_io_submit'
> > > >   b'ext4_writepages'
> > > >   b'do_writepages'
> > > >   b'__filemap_fdatawrite_range'
> > > >   b'ext4_release_file'
> > > >   b'__fput'
> > > >   b'task_work_run'
> > > >   b'exit_to_usermode_loop'
> > > >   b'do_syscall_64'
> > > >   b'entry_SYSCALL_64_after_hwframe'
> > > >     4358
>=20
> I'm guessing that your workload is repeatedly truncating a file (or
> calling open with O_TRUNC) and then writing data to it.  When you do
> this, then when the file is closed, we assume that since you were
> replacing the previous contents of a file with new contents, that you
> would be unhappy if the file contents was replaced by a zero length
> file after a crash.  That's because ten years, ago there were a *huge*
> number of crappy applications that would replace a file by reading it
> into memory, truncating it, and then write out the new contents of the
> file.  This could be a high score file for a game, or a KDE or GNOME
> state file, etc.
>=20
> So if someone does open, truncate, write, close, we still immediately
> writing out the data on the close, assuming that the programmer really
> wanted open, truncate, write, fsync, close, but was too careless to
> actually do the right thing.
>=20
> Some workaround[1] like this is done by all of the major file systems,
> and was fallout the agreement from the "O_PONIES"[2] controversy.
> This was discussed and agreed to at the 2009 LSF/MM workshop.  (See
> the "rename, fsync, and ponies" section.)
>=20
> [1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/317781/comments/=
45
> [2] https://blahg.josefsipek.net/?p=3D364
> [3] https://lwn.net/Articles/327601/
>=20
> So if you're seeing a call to filemap_fdatawrite_range as the result
> of a fput, that's why.
>=20
> In any case, this behavior has been around for a decade, and it
> appears to be incidental to your performance difficulties with your
> USB thumbdrive and block-mq.

I didn't reproduce the issue in my test environment, and follows
Andrea's test commands[1]:

  mount UUID=3D$uuid /mnt/pendrive 2>&1 |tee -a $logfile
  SECONDS=3D0
  cp $testfile /mnt/pendrive 2>&1 |tee -a $logfile
  umount /mnt/pendrive 2>&1 |tee -a $logfile

The 'cp' command supposes to open/close the file just once, however
ext4_release_file() & write pages is observed to run for 4358 times
when executing the above 'cp' test.


[1] https://marc.info/?l=3Dlinux-kernel&m=3D157486689806734&w=3D2


Thanks,
Ming

