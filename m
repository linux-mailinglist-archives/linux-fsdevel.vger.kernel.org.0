Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46CCE1243A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 10:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfLRJsz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 04:48:55 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44197 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726545AbfLRJsz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576662533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QNImMog0y8yTFfskUEXfbj8FpdiINrnYw3QgoUnPIZk=;
        b=OmeVjEkeZWtETRZX/zfC3EXlTa4rHfIOrZKy3zGW4nlweAcejIseuOR+kVG8ZIVn6n6Ixa
        cECG6ACOOUOtiXJxnh0D5mv9N2OcxkD/6VmoJ2/f5mclzvMVl0dyRyqEJx+gHn6sdTe9RI
        zYpw7aA9Ifl2dh2t6VPZK9Mr8osyMZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326--2Gz8NE5MiKdA6C-ycqdNA-1; Wed, 18 Dec 2019 04:48:49 -0500
X-MC-Unique: -2Gz8NE5MiKdA6C-ycqdNA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6B9E107ACC7;
        Wed, 18 Dec 2019 09:48:46 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 886BA675B8;
        Wed, 18 Dec 2019 09:48:34 +0000 (UTC)
Date:   Wed, 18 Dec 2019 17:48:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Andrea Vai <andrea.vai@unipv.it>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
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
Message-ID: <20191218094830.GB30602@ming.t460p>
References: <20191129023555.GA8620@ming.t460p>
 <320b315b9c87543d4fb919ecbdf841596c8fbcea.camel@unipv.it>
 <20191203022337.GE25002@ming.t460p>
 <8196b014b1a4d91169bf3b0d68905109aeaf2191.camel@unipv.it>
 <20191210080550.GA5699@ming.t460p>
 <20191211024137.GB61323@mit.edu>
 <20191211040058.GC6864@ming.t460p>
 <20191211160745.GA129186@mit.edu>
 <20191211213316.GA14983@ming.t460p>
 <f38db337cf26390f7c7488a0bc2076633737775b.camel@unipv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f38db337cf26390f7c7488a0bc2076633737775b.camel@unipv.it>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 09:25:02AM +0100, Andrea Vai wrote:
> Il giorno gio, 12/12/2019 alle 05.33 +0800, Ming Lei ha scritto:
> > On Wed, Dec 11, 2019 at 11:07:45AM -0500, Theodore Y. Ts'o wrote:
> > > On Wed, Dec 11, 2019 at 12:00:58PM +0800, Ming Lei wrote:
> > > > I didn't reproduce the issue in my test environment, and follows
> > > > Andrea's test commands[1]:
> > > > 
> > > >   mount UUID=$uuid /mnt/pendrive 2>&1 |tee -a $logfile
> > > >   SECONDS=0
> > > >   cp $testfile /mnt/pendrive 2>&1 |tee -a $logfile
> > > >   umount /mnt/pendrive 2>&1 |tee -a $logfile
> > > > 
> > > > The 'cp' command supposes to open/close the file just once,
> > however
> > > > ext4_release_file() & write pages is observed to run for 4358
> > times
> > > > when executing the above 'cp' test.
> > > 
> > > Why are we sure the ext4_release_file() / _fput() is coming from
> > the
> > > cp command, as opposed to something else that might be running on
> > the
> > > system under test?  _fput() is called by the kernel when the last
> > 
> > Please see the log:
> > 
> > https://lore.kernel.org/linux-scsi/3af3666920e7d46f8f0c6d88612f143ffabc743c.camel@unipv.it/2-log_ming.zip
> > 
> > Which is collected by:
> > 
> > #!/bin/sh
> > MAJ=$1
> > MIN=$2
> > MAJ=$(( $MAJ << 20 ))
> > DEV=$(( $MAJ | $MIN ))
> > 
> > /usr/share/bcc/tools/trace -t -C \
> >     't:block:block_rq_issue (args->dev == '$DEV') "%s %d %d", args-
> > >rwbs, args->sector, args->nr_sector' \
> >     't:block:block_rq_insert (args->dev == '$DEV') "%s %d %d", args-
> > >rwbs, args->sector, args->nr_sector'
> > 
> > $MAJ:$MIN points to the USB storage disk.
> > 
> > From the above IO trace, there are two write paths, one is from cp,
> > another is from writeback wq.
> > 
> > The stackcount trace[1] is consistent with the IO trace log since it
> > only shows two IO paths, that is why I concluded that the write done
> > via
> > ext4_release_file() is from 'cp'.
> > 
> > [1] 
> > https://lore.kernel.org/linux-scsi/320b315b9c87543d4fb919ecbdf841596c8fbcea.camel@unipv.it/2-log_ming_20191129_150609.zip
> > 
> > > reference to a struct file is released.  (Specifically, if you
> > have a
> > > fd which is dup'ed, it's only when the last fd corresponding to
> > the
> > > struct file is closed, and the struct file is about to be
> > released,
> > > does the file system's f_ops->release function get called.)
> > > 
> > > So the first question I'd ask is whether there is anything else
> > going
> > > on the system, and whether the writes are happening to the USB
> > thumb
> > > drive, or to some other storage device.  And if there is something
> > > else which is writing to the pendrive, maybe that's why no one
> > else
> > > has been able to reproduce the OP's complaint....
> > 
> > OK, we can ask Andrea to confirm that via the following trace, which
> > will add pid/comm info in the stack trace:
> > 
> > /usr/share/bcc/tools/stackcount blk_mq_sched_request_inserted
> > 
> > Andrew, could you collect the above log again when running new/bad
> > kernel for confirming if the write done by ext4_release_file() is
> > from
> > the 'cp' process?
> 
> You can find the stackcount log attached. It has been produced by:
> 
> - /usr/share/bcc/tools/stackcount blk_mq_sched_request_inserted > trace.log
> - wait some seconds
> - run the test (1 copy trial), wait for the test to finish, wait some seconds
> - stop the trace (ctrl+C)

Thanks for collecting the log, looks your 'stackcount' doesn't include
comm/pid info, seems there is difference between your bcc and
my bcc in fedora 30.

Could you collect above log again via the following command?

/usr/share/bcc/tools/stackcount -P -K t:block:block_rq_insert

which will show the comm/pid info.

Sorry for not seeing the bcc difference.

> 
> The test took 1994 seconds to complete.
> 
> I also tried the usual test with btrfs and xfs. Btrfs behavior looks
> "good". xfs seems sometimes better, sometimes worse, I would say. I
> don't know if it matters, anyway you can also find the results of the
> two tests (100 trials each). Basically, btrfs is always between 68 and
> 89 seconds, with a cyclicity (?) with "period=2 trials". xfs looks
> almost always very good (63-65s), but sometimes "bad" (>300s).

If you are interested in digging into this one, the following trace
should be helpful:

https://lore.kernel.org/linux-scsi/f38db337cf26390f7c7488a0bc2076633737775b.camel@unipv.it/T/#m5aa008626e07913172ad40e1eb8e5f2ffd560fc6


Thanks,
Ming

> 
> Thanks,
> Andrea

> *** test btrfs *** -> test_btrfs_20191217.txt
> 
> Starting 100 tries with:
> Linux angus.unipv.it 5.4.0+ #1 SMP Mon Nov 25 11:31:34 CET 2019 x86_64 x86_64 x86_64 GNU/Linux
> -rw-r--r--. 1 root root 1,0G 25 nov 13.29 /NoBackup/testfile
> /dev/sda1: LABEL="Fedora30" UUID="a7ca2491-c807-4b10-b33f-ef425699148d" TYPE="ext4" PARTUUID="8b16fbdd-01"
> /dev/sda2: LABEL="Swap_4GB" UUID="ba020b1e-4cdc-4f94-b92c-bdc11613388d" TYPE="swap" PARTUUID="8b16fbdd-02"
> /dev/sdf1: LABEL="BAK_ANDVAI" UUID="6ddfec28-3d9a-4676-a726-927fd3fb21e7" UUID_SUB="581c69ab-6758-4662-999a-b6dfe6ee5e69" TYPE="btrfs" PARTUUID="09066b88-01"
> /dev/sdg1: LABEL="BAK_ANDVAI" UUID="df777e33-8890-4cee-a718-42233f4cafae" TYPE="ext4" PARTUUID="75265898-01"
> cat /sys/block/sdf/queue/scheduler --> [mq-deadline] none
> Inizio: mar 17 dic 2019, 13:31:00, CET...fine: mar 17 dic 2019, 13:32:26, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 13:32:26, CET...fine: mar 17 dic 2019, 13:33:36, CET --> ci ho messo 70 secondi!
> Inizio: mar 17 dic 2019, 13:33:36, CET...fine: mar 17 dic 2019, 13:35:02, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 13:35:02, CET...fine: mar 17 dic 2019, 13:36:14, CET --> ci ho messo 72 secondi!
> Inizio: mar 17 dic 2019, 13:36:14, CET...fine: mar 17 dic 2019, 13:37:40, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 13:37:40, CET...fine: mar 17 dic 2019, 13:38:51, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 13:38:51, CET...fine: mar 17 dic 2019, 13:40:18, CET --> ci ho messo 87 secondi!
> Inizio: mar 17 dic 2019, 13:40:18, CET...fine: mar 17 dic 2019, 13:41:29, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 13:41:29, CET...fine: mar 17 dic 2019, 13:42:58, CET --> ci ho messo 89 secondi!
> Inizio: mar 17 dic 2019, 13:42:58, CET...fine: mar 17 dic 2019, 13:44:11, CET --> ci ho messo 73 secondi!
> Inizio: mar 17 dic 2019, 13:44:11, CET...fine: mar 17 dic 2019, 13:45:40, CET --> ci ho messo 89 secondi!
> Inizio: mar 17 dic 2019, 13:45:40, CET...fine: mar 17 dic 2019, 13:46:49, CET --> ci ho messo 69 secondi!
> Inizio: mar 17 dic 2019, 13:46:49, CET...fine: mar 17 dic 2019, 13:48:16, CET --> ci ho messo 87 secondi!
> Inizio: mar 17 dic 2019, 13:48:16, CET...fine: mar 17 dic 2019, 13:49:27, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 13:49:27, CET...fine: mar 17 dic 2019, 13:50:53, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 13:50:53, CET...fine: mar 17 dic 2019, 13:52:04, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 13:52:04, CET...fine: mar 17 dic 2019, 13:53:30, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 13:53:30, CET...fine: mar 17 dic 2019, 13:54:41, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 13:54:41, CET...fine: mar 17 dic 2019, 13:56:07, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 13:56:07, CET...fine: mar 17 dic 2019, 13:57:18, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 13:57:18, CET...fine: mar 17 dic 2019, 13:58:46, CET --> ci ho messo 88 secondi!
> Inizio: mar 17 dic 2019, 13:58:46, CET...fine: mar 17 dic 2019, 13:59:57, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 13:59:57, CET...fine: mar 17 dic 2019, 14:01:23, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 14:01:23, CET...fine: mar 17 dic 2019, 14:02:34, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 14:02:34, CET...fine: mar 17 dic 2019, 14:04:00, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 14:04:00, CET...fine: mar 17 dic 2019, 14:05:11, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 14:05:11, CET...fine: mar 17 dic 2019, 14:06:38, CET --> ci ho messo 87 secondi!
> Inizio: mar 17 dic 2019, 14:06:38, CET...fine: mar 17 dic 2019, 14:07:49, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 14:07:49, CET...fine: mar 17 dic 2019, 14:09:15, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 14:09:15, CET...fine: mar 17 dic 2019, 14:10:26, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 14:10:26, CET...fine: mar 17 dic 2019, 14:11:52, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 14:11:52, CET...fine: mar 17 dic 2019, 14:13:03, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 14:13:03, CET...fine: mar 17 dic 2019, 14:14:29, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 14:14:29, CET...fine: mar 17 dic 2019, 14:15:41, CET --> ci ho messo 72 secondi!
> Inizio: mar 17 dic 2019, 14:15:41, CET...fine: mar 17 dic 2019, 14:17:07, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 14:17:07, CET...fine: mar 17 dic 2019, 14:18:18, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 14:18:18, CET...fine: mar 17 dic 2019, 14:19:44, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 14:19:44, CET...fine: mar 17 dic 2019, 14:20:55, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 14:20:55, CET...fine: mar 17 dic 2019, 14:22:21, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 14:22:21, CET...fine: mar 17 dic 2019, 14:23:33, CET --> ci ho messo 72 secondi!
> Inizio: mar 17 dic 2019, 14:23:33, CET...fine: mar 17 dic 2019, 14:24:59, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 14:24:59, CET...fine: mar 17 dic 2019, 14:26:10, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 14:26:10, CET...fine: mar 17 dic 2019, 14:27:36, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 14:27:36, CET...fine: mar 17 dic 2019, 14:28:46, CET --> ci ho messo 70 secondi!
> Inizio: mar 17 dic 2019, 14:28:46, CET...fine: mar 17 dic 2019, 14:30:12, CET --> ci ho messo 85 secondi!
> Inizio: mar 17 dic 2019, 14:30:12, CET...fine: mar 17 dic 2019, 14:31:23, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 14:31:23, CET...fine: mar 17 dic 2019, 14:32:49, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 14:32:49, CET...fine: mar 17 dic 2019, 14:34:01, CET --> ci ho messo 72 secondi!
> Inizio: mar 17 dic 2019, 14:34:01, CET...fine: mar 17 dic 2019, 14:35:27, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 14:35:27, CET...fine: mar 17 dic 2019, 14:36:38, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 14:36:38, CET...fine: mar 17 dic 2019, 14:38:04, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 14:38:04, CET...fine: mar 17 dic 2019, 14:39:15, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 14:39:15, CET...fine: mar 17 dic 2019, 14:40:41, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 14:40:41, CET...fine: mar 17 dic 2019, 14:41:52, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 14:41:52, CET...fine: mar 17 dic 2019, 14:43:18, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 14:43:18, CET...fine: mar 17 dic 2019, 14:44:29, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 14:44:29, CET...fine: mar 17 dic 2019, 14:45:55, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 14:45:55, CET...fine: mar 17 dic 2019, 14:47:06, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 14:47:06, CET...fine: mar 17 dic 2019, 14:48:32, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 14:48:32, CET...fine: mar 17 dic 2019, 14:49:43, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 14:49:43, CET...fine: mar 17 dic 2019, 14:51:10, CET --> ci ho messo 87 secondi!
> Inizio: mar 17 dic 2019, 14:51:10, CET...fine: mar 17 dic 2019, 14:52:23, CET --> ci ho messo 73 secondi!
> Inizio: mar 17 dic 2019, 14:52:23, CET...fine: mar 17 dic 2019, 14:53:49, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 14:53:49, CET...fine: mar 17 dic 2019, 14:55:00, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 14:55:00, CET...fine: mar 17 dic 2019, 14:56:26, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 14:56:26, CET...fine: mar 17 dic 2019, 14:57:37, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 14:57:37, CET...fine: mar 17 dic 2019, 14:59:03, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 14:59:03, CET...fine: mar 17 dic 2019, 15:00:14, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 15:00:14, CET...fine: mar 17 dic 2019, 15:01:40, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 15:01:40, CET...fine: mar 17 dic 2019, 15:02:51, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 15:02:51, CET...fine: mar 17 dic 2019, 15:04:17, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 15:04:17, CET...fine: mar 17 dic 2019, 15:05:28, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 15:05:28, CET...fine: mar 17 dic 2019, 15:06:53, CET --> ci ho messo 85 secondi!
> Inizio: mar 17 dic 2019, 15:06:53, CET...fine: mar 17 dic 2019, 15:08:04, CET --> ci ho messo 70 secondi!
> Inizio: mar 17 dic 2019, 15:08:04, CET...fine: mar 17 dic 2019, 15:09:30, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 15:09:30, CET...fine: mar 17 dic 2019, 15:10:41, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 15:10:41, CET...fine: mar 17 dic 2019, 15:12:07, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 15:12:07, CET...fine: mar 17 dic 2019, 15:13:18, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 15:13:18, CET...fine: mar 17 dic 2019, 15:14:44, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 15:14:44, CET...fine: mar 17 dic 2019, 15:15:55, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 15:15:55, CET...fine: mar 17 dic 2019, 15:17:21, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 15:17:21, CET...fine: mar 17 dic 2019, 15:18:32, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 15:18:32, CET...fine: mar 17 dic 2019, 15:19:58, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 15:19:58, CET...fine: mar 17 dic 2019, 15:21:08, CET --> ci ho messo 70 secondi!
> Inizio: mar 17 dic 2019, 15:21:08, CET...fine: mar 17 dic 2019, 15:22:34, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 15:22:34, CET...fine: mar 17 dic 2019, 15:23:45, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 15:23:45, CET...fine: mar 17 dic 2019, 15:25:11, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 15:25:11, CET...fine: mar 17 dic 2019, 15:26:22, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 15:26:22, CET...fine: mar 17 dic 2019, 15:27:48, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 15:27:48, CET...fine: mar 17 dic 2019, 15:28:59, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 15:28:59, CET...fine: mar 17 dic 2019, 15:30:25, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 15:30:25, CET...fine: mar 17 dic 2019, 15:31:35, CET --> ci ho messo 70 secondi!
> Inizio: mar 17 dic 2019, 15:31:35, CET...fine: mar 17 dic 2019, 15:33:03, CET --> ci ho messo 87 secondi!
> Inizio: mar 17 dic 2019, 15:33:03, CET...fine: mar 17 dic 2019, 15:34:14, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 15:34:14, CET...fine: mar 17 dic 2019, 15:35:40, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 15:35:40, CET...fine: mar 17 dic 2019, 15:36:51, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 15:36:51, CET...fine: mar 17 dic 2019, 15:38:17, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 15:38:17, CET...fine: mar 17 dic 2019, 15:39:28, CET --> ci ho messo 71 secondi!
> Inizio: mar 17 dic 2019, 15:39:28, CET...fine: mar 17 dic 2019, 15:40:54, CET --> ci ho messo 86 secondi!
> Inizio: mar 17 dic 2019, 15:40:54, CET...fine: mar 17 dic 2019, 15:42:05, CET --> ci ho messo 71 secondi!

> *** TEST XFS: *** -> test_xfs_20191217.txt
> 
> Starting 100 tries with:
> Linux angus.unipv.it 5.4.0+ #1 SMP Mon Nov 25 11:31:34 CET 2019 x86_64 x86_64 x86_64 GNU/Linux
> -rw-r--r--. 1 root root 1,0G 25 nov 13.29 /NoBackup/testfile
> /dev/sda1: LABEL="Fedora30" UUID="a7ca2491-c807-4b10-b33f-ef425699148d" TYPE="ext4" PARTUUID="8b16fbdd-01"
> /dev/sda2: LABEL="Swap_4GB" UUID="ba020b1e-4cdc-4f94-b92c-bdc11613388d" TYPE="swap" PARTUUID="8b16fbdd-02"
> /dev/sdf1: UUID="eb5a4791-5b26-44b6-871e-efd464a3adc5" TYPE="xfs" PARTUUID="09066b88-01"
> cat /sys/block/sdf/queue/scheduler --> [mq-deadline] none
> Inizio: mar 17 dic 2019, 23:58:22, CET...fine: mar 17 dic 2019, 23:59:28, CET --> ci ho messo 64 secondi!
> Inizio: mar 17 dic 2019, 23:59:28, CET...fine: mer 18 dic 2019, 00:00:33, CET --> ci ho messo 63 secondi!
> Inizio: mer 18 dic 2019, 00:00:33, CET...fine: mer 18 dic 2019, 00:01:39, CET --> ci ho messo 64 secondi!
> Inizio: mer 18 dic 2019, 00:01:39, CET...fine: mer 18 dic 2019, 00:06:35, CET --> ci ho messo 294 secondi!
> Inizio: mer 18 dic 2019, 00:06:35, CET...fine: mer 18 dic 2019, 00:07:41, CET --> ci ho messo 64 secondi!
> Inizio: mer 18 dic 2019, 00:07:41, CET...fine: mer 18 dic 2019, 00:08:46, CET --> ci ho messo 63 secondi!
> Inizio: mer 18 dic 2019, 00:08:46, CET...fine: mer 18 dic 2019, 00:09:52, CET --> ci ho messo 64 secondi!
> Inizio: mer 18 dic 2019, 00:09:52, CET...fine: mer 18 dic 2019, 00:10:57, CET --> ci ho messo 63 secondi!
> Inizio: mer 18 dic 2019, 00:10:57, CET...fine: mer 18 dic 2019, 00:12:03, CET --> ci ho messo 65 secondi!
> Inizio: mer 18 dic 2019, 00:12:03, CET...fine: mer 18 dic 2019, 00:13:08, CET --> ci ho messo 63 secondi!
> Inizio: mer 18 dic 2019, 00:13:08, CET...fine: mer 18 dic 2019, 00:14:14, CET --> ci ho messo 65 secondi!
> Inizio: mer 18 dic 2019, 00:14:14, CET...fine: mer 18 dic 2019, 00:15:19, CET --> ci ho messo 64 secondi!
> Inizio: mer 18 dic 2019, 00:15:19, CET...fine: mer 18 dic 2019, 00:21:39, CET --> ci ho messo 379 secondi!
> Inizio: mer 18 dic 2019, 00:21:39, CET...fine: mer 18 dic 2019, 00:22:44, CET --> ci ho messo 64 secondi!
> Inizio: mer 18 dic 2019, 00:22:44, CET...fine: mer 18 dic 2019, 00:23:50, CET --> ci ho messo 65 secondi!
> Inizio: mer 18 dic 2019, 00:23:50, CET...fine: mer 18 dic 2019, 00:29:16, CET --> ci ho messo 325 secondi!
> Inizio: mer 18 dic 2019, 00:29:16, CET...fine: mer 18 dic 2019, 00:30:22, CET --> ci ho messo 64 secondi!
> Inizio: mer 18 dic 2019, 00:30:22, CET...fine: mer 18 dic 2019, 00:34:50, CET --> ci ho messo 266 secondi!
> Inizio: mer 18 dic 2019, 00:34:50, CET...fine: mer 18 dic 2019, 00:35:56, CET --> ci ho messo 65 secondi!
> Inizio: mer 18 dic 2019, 00:35:56, CET...fine: mer 18 dic 2019, 00:37:01, CET --> ci ho messo 64 secondi!
> Inizio: mer 18 dic 2019, 00:37:01, CET...fine: mer 18 dic 2019, 00:43:39, CET --> ci ho messo 397 secondi!
> Inizio: mer 18 dic 2019, 00:43:39, CET...fine: mer 18 dic 2019, 00:48:31, CET --> ci ho messo 291 secondi!
> Inizio: mer 18 dic 2019, 00:48:31, CET...fine: mer 18 dic 2019, 00:49:37, CET --> ci ho messo 65 secondi!
> Inizio: mer 18 dic 2019, 00:49:37, CET...fine: mer 18 dic 2019, 00:50:42, CET --> ci ho messo 64 secondi!
> Inizio: mer 18 dic 2019, 00:50:42, CET...fine: mer 18 dic 2019, 00:55:39, CET --> ci ho messo 296 secondi!
> Inizio: mer 18 dic 2019, 00:55:39, CET...fine: mer 18 dic 2019, 00:56:44, CET --> ci ho messo 64 secondi!
> Inizio: mer 18 dic 2019, 00:56:44, CET...fine: mer 18 dic 2019, 00:57:50, CET --> ci ho messo 65 secondi!
> Inizio: mer 18 dic 2019, 00:57:50, CET...fine: mer 18 dic 2019, 00:58:54, CET --> ci ho messo 63 secondi!
> Inizio: mer 18 dic 2019, 00:58:54, CET...fine: mer 18 dic 2019, 01:00:01, CET --> ci ho messo 65 secondi!
> Inizio: mer 18 dic 2019, 01:00:01, CET...fine: mer 18 dic 2019, 01:01:05, CET --> ci ho messo 63 secondi!
> Inizio: mer 18 dic 2019, 01:01:05, CET...fine: mer 18 dic 2019, 01:02:11, CET --> ci ho messo 64 secondi!
> Inizio: mer 18 dic 2019, 01:02:11, CET...fine: mer 18 dic 2019, 01:03:16, CET --> ci ho messo 63 secondi!
> Inizio: mer 18 dic 2019, 01:03:16, CET...fine: mer 18 dic 2019, 01:04:22, CET --> ci ho messo 64 secondi!
> Inizio: mer 18 dic 2019, 01:04:22, CET...fine: mer 18 dic 2019, 01:05:27, CET --> ci ho messo 63 secondi!
> Inizio: mer 18 dic 2019, 01:05:27, CET...fine: mer 18 dic 2019, 01:11:38, CET --> ci ho messo 369 secondi!
> Inizio: mer 18 dic 2019, 01:11:38, CET...fine: mer 18 dic 2019, 01:12:43, CET --> ci ho messo 63 secondi!
> Inizio: mer 18 dic 2019, 01:12:43, CET...fine: mer 18 dic 2019, 01:18:20, CET --> ci ho messo 336 secondi!
> Inizio: mer 18 dic 2019, 01:18:20, CET...fine: mer 18 dic 2019, 01:19:25, CET --> ci ho messo 64 secondi!
> Inizio: mer 18 dic 2019, 01:19:25, CET...fine: mer 18 dic 2019, 01:21:01, CET --> ci ho messo 95 secondi!
> Inizio: mer 18 dic 2019, 01:21:01, CET...fine: mer 18 dic 2019, 01:22:06, CET --> ci ho messo 64 secondi!
> Inizio: mer 18 dic 2019, 01:22:06, CET...fine: mer 18 dic 2019, 01:23:12, CET --> ci ho messo 65 secondi!
> Inizio: mer 18 dic 2019, 01:23:12, CET...fine: mer 18 dic 2019, 01:29:43, CET --> ci ho messo 390 secondi!
> Inizio: mer 18 dic 2019, 01:29:43, CET...fine: mer 18 dic 2019, 01:30:49, CET --> ci ho messo 64 secondi!
> Inizio: mer 18 dic 2019, 01:30:49, CET...fine: mer 18 dic 2019, 01:35:36, CET --> ci ho messo 285 secondi!
> Inizio: mer 18 dic 2019, 01:35:36, CET...fine: mer 18 dic 2019, 01:36:44, CET --> ci ho messo 66 secondi!
> Inizio: mer 18 dic 2019, 01:36:44, CET...fine: mer 18 dic 2019, 01:37:48, CET --> ci ho messo 63 secondi!
> Inizio: mer 18 dic 2019, 01:37:48, CET...fine: mer 18 dic 2019, 01:38:55, CET --> ci ho messo 65 secondi!
> Inizio: mer 18 dic 2019, 01:38:55, CET...fine: mer 18 dic 2019, 01:44:04, CET --> ci ho messo 308 secondi!
> Inizio: mer 18 dic 2019, 01:44:04, CET...fine: mer 18 dic 2019, 01:45:10, CET --> ci ho messo 65 secondi!
> Inizio: mer 18 dic 2019, 01:45:10, CET...fine: mer 18 dic 2019, 01:49:42, CET --> ci ho messo 270 secondi!
> Inizio: mer 18 dic 2019, 01:49:42, CET...fine: mer 18 dic 2019, 01:50:48, CET --> ci ho messo 64 secondi!
> Inizio: mer 18 dic 2019, 01:50:48, CET...fine: mer 18 dic 2019, 01:51:53, CET --> ci ho messo 63 secondi!
> Inizio: mer 18 dic 2019, 01:51:53, CET...fine: mer 18 dic 2019, 01:58:18, CET --> ci ho messo 383 secondi!
> Inizio: mer 18 dic 2019, 01:58:18, CET...fine: mer 18 dic 2019, 01:59:23, CET --> ci ho messo 63 secondi!
> Inizio: mer 18 dic 2019, 01:59:23, CET...fine: mer 18 dic 2019, 02:00:29, CET --> ci ho messo 65 secondi!
> Inizio: mer 18 dic 2019, 02:00:29, CET...fine: mer 18 dic 2019, 02:01:34, CET --> ci ho messo 63 secondi!
> Inizio: mer 18 dic 2019, 02:01:34, CET...fine: mer 18 dic 2019, 02:02:40, CET --> ci ho messo 64 secondi!
> Inizio: mer 18 dic 2019, 02:02:40, CET...fine: mer 18 dic 2019, 02:03:45, CET --> ci ho messo 63 secondi!
> Inizio: mer 18 dic 2019, 02:03:45, CET...fine: mer 18 dic 2019, 02:04:51, CET --> ci ho messo 64 secondi!
> Inizio: mer 18 dic 2019, 02:04:51, CET...fine: mer 18 dic 2019, 02:05:56, CET --> ci ho messo 63 secondi!
> Inizio: mer 18 dic 2019, 02:05:56, CET...fine: mer 18 dic 2019, 02:07:02, CET --> ci ho messo 64 secondi!
> Inizio: mer 18 dic 2019, 02:07:02, CET...fine: mer 18 dic 2019, 02:08:07, CET --> ci ho messo 63 secondi!
> Inizio: mer 18 dic 2019, 02:08:07, CET...fine: mer 18 dic 2019, 02:09:14, CET --> ci ho messo 65 secondi!
> Inizio: mer 18 dic 2019, 02:09:14, CET...fine: mer 18 dic 2019, 02:13:44, CET --> ci ho messo 269 secondi!
> Inizio: mer 18 dic 2019, 02:13:44, CET...fine: mer 18 dic 2019, 02:14:51, CET --> ci ho messo 65 secondi!
> Inizio: mer 18 dic 2019, 02:14:51, CET...fine: mer 18 dic 2019, 02:15:56, CET --> ci ho messo 64 secondi!
> Inizio: mer 18 dic 2019, 02:15:56, CET...fine: mer 18 dic 2019, 02:17:02, CET --> ci ho messo 65 secondi!
> Inizio: mer 18 dic 2019, 02:17:02, CET...fine: mer 18 dic 2019, 02:18:07, CET --> ci ho messo 64 secondi!
> Inizio: mer 18 dic 2019, 02:18:07, CET...fine: mer 18 dic 2019, 02:19:13, CET --> ci ho messo 65 secondi!
> Inizio: mer 18 dic 2019, 02:19:13, CET...fine: mer 18 dic 2019, 02:20:18, CET --> ci ho messo 64 secondi!
> Inizio: mer 18 dic 2019, 02:20:18, CET...fine: mer 18 dic 2019, 02:21:24, CET --> ci ho messo 65 secondi!
> Inizio: mer 18 dic 2019, 02:21:24, CET...fine: mer 18 dic 2019, 02:22:29, CET --> ci ho messo 64 secondi!
> Inizio: mer 18 dic 2019, 02:22:29, CET...fine: mer 18 dic 2019, 02:23:35, CET --> ci ho messo 65 secondi!
> Inizio: mer 18 dic 2019, 02:23:35, CET...fine: mer 18 dic 2019, 02:24:40, CET --> ci ho messo 64 secondi!
> Inizio: mer 18 dic 2019, 02:24:40, CET...fine: mer 18 dic 2019, 02:25:46, CET --> ci ho messo 65 secondi!
> Inizio: mer 18 dic 2019, 02:25:46, CET...fine: mer 18 dic 2019, 02:26:51, CET --> ci ho messo 64 secondi!
> Inizio: mer 18 dic 2019, 02:26:51, CET...fine: mer 18 dic 2019, 02:27:57, CET --> ci ho messo 65 secondi!
> Inizio: mer 18 dic 2019, 02:27:57, CET...fine: mer 18 dic 2019, 02:29:02, CET --> ci ho messo 64 secondi!
> Inizio: mer 18 dic 2019, 02:29:02, CET...fine: mer 18 dic 2019, 02:30:08, CET --> ci ho messo 65 secondi!
> Inizio: mer 18 dic 2019, 02:30:08, CET...fine: mer 18 dic 2019, 02:31:13, CET --> ci ho messo 63 secondi!
> Inizio: mer 18 dic 2019, 02:31:13, CET...fine: mer 18 dic 2019, 02:32:19, CET --> ci ho messo 64 secondi!
> Inizio: mer 18 dic 2019, 02:32:19, CET...fine: mer 18 dic 2019, 02:40:06, CET --> ci ho messo 465 secondi!
> Inizio: mer 18 dic 2019, 02:40:06, CET...fine: mer 18 dic 2019, 02:41:12, CET --> ci ho messo 64 secondi!
> Inizio: mer 18 dic 2019, 02:41:12, CET...fine: mer 18 dic 2019, 02:42:17, CET --> ci ho messo 63 secondi!
> Inizio: mer 18 dic 2019, 02:42:17, CET...fine: mer 18 dic 2019, 02:43:23, CET --> ci ho messo 64 secondi!
> Inizio: mer 18 dic 2019, 02:43:23, CET...fine: mer 18 dic 2019, 02:44:28, CET --> ci ho messo 63 secondi!
> Inizio: mer 18 dic 2019, 02:44:28, CET...fine: mer 18 dic 2019, 02:45:34, CET --> ci ho messo 64 secondi!
> Inizio: mer 18 dic 2019, 02:45:34, CET...fine: mer 18 dic 2019, 02:46:39, CET --> ci ho messo 63 secondi!
> Inizio: mer 18 dic 2019, 02:46:39, CET...fine: mer 18 dic 2019, 02:47:45, CET --> ci ho messo 64 secondi!
> Inizio: mer 18 dic 2019, 02:47:45, CET...fine: mer 18 dic 2019, 02:48:50, CET --> ci ho messo 63 secondi!
> Inizio: mer 18 dic 2019, 02:48:50, CET...fine: mer 18 dic 2019, 02:54:26, CET --> ci ho messo 334 secondi!
> Inizio: mer 18 dic 2019, 02:54:26, CET...fine: mer 18 dic 2019, 02:55:31, CET --> ci ho messo 63 secondi!
> Inizio: mer 18 dic 2019, 02:55:31, CET...fine: mer 18 dic 2019, 02:57:11, CET --> ci ho messo 98 secondi!
> Inizio: mer 18 dic 2019, 02:57:11, CET...fine: mer 18 dic 2019, 02:58:16, CET --> ci ho messo 63 secondi!
> Inizio: mer 18 dic 2019, 02:58:16, CET...fine: mer 18 dic 2019, 02:59:22, CET --> ci ho messo 64 secondi!
> Inizio: mer 18 dic 2019, 02:59:22, CET...fine: mer 18 dic 2019, 03:00:27, CET --> ci ho messo 63 secondi!
> Inizio: mer 18 dic 2019, 03:00:27, CET...fine: mer 18 dic 2019, 03:05:55, CET --> ci ho messo 326 secondi!
> Inizio: mer 18 dic 2019, 03:05:55, CET...fine: mer 18 dic 2019, 03:11:49, CET --> ci ho messo 352 secondi!
> Inizio: mer 18 dic 2019, 03:11:49, CET...fine: mer 18 dic 2019, 03:12:56, CET --> ci ho messo 66 secondi!
> Inizio: mer 18 dic 2019, 03:12:56, CET...fine: mer 18 dic 2019, 03:14:01, CET --> ci ho messo 63 secondi!
> 



-- 
Ming

