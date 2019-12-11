Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F31A011BF4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 22:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfLKVdo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 16:33:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25258 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726368AbfLKVdm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 16:33:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576100021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i5d46fUGGAKBhC38Qbq/dcwLvKrKUIyOiABQ6Phgrc0=;
        b=SAPu84hSjR+N48caBUeKb6IxNvBAtp10otjfPxY5JsdnvX4XXAg7u5HzajIaLidbhgFiY6
        kmCh7mxHxcipkXnz398PEwg/Bz4zGJd/fyoaWIvqfpCM1vSsyjCac2VyVhKlj9E7urE4+P
        Loi9B4rrUFVcEunxhsbTL5I3u0xVAYs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-zLR0Bm1pOh6ncTz7hQoSpg-1; Wed, 11 Dec 2019 16:33:37 -0500
X-MC-Unique: zLR0Bm1pOh6ncTz7hQoSpg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EF7F85EE72;
        Wed, 11 Dec 2019 21:33:34 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C249088E6;
        Wed, 11 Dec 2019 21:33:21 +0000 (UTC)
Date:   Thu, 12 Dec 2019 05:33:16 +0800
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
Message-ID: <20191211213316.GA14983@ming.t460p>
References: <f82fd5129e3dcacae703a689be60b20a7fedadf6.camel@unipv.it>
 <20191129005734.GB1829@ming.t460p>
 <20191129023555.GA8620@ming.t460p>
 <320b315b9c87543d4fb919ecbdf841596c8fbcea.camel@unipv.it>
 <20191203022337.GE25002@ming.t460p>
 <8196b014b1a4d91169bf3b0d68905109aeaf2191.camel@unipv.it>
 <20191210080550.GA5699@ming.t460p>
 <20191211024137.GB61323@mit.edu>
 <20191211040058.GC6864@ming.t460p>
 <20191211160745.GA129186@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211160745.GA129186@mit.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 11:07:45AM -0500, Theodore Y. Ts'o wrote:
> On Wed, Dec 11, 2019 at 12:00:58PM +0800, Ming Lei wrote:
> > I didn't reproduce the issue in my test environment, and follows
> > Andrea's test commands[1]:
> > 
> >   mount UUID=$uuid /mnt/pendrive 2>&1 |tee -a $logfile
> >   SECONDS=0
> >   cp $testfile /mnt/pendrive 2>&1 |tee -a $logfile
> >   umount /mnt/pendrive 2>&1 |tee -a $logfile
> > 
> > The 'cp' command supposes to open/close the file just once, however
> > ext4_release_file() & write pages is observed to run for 4358 times
> > when executing the above 'cp' test.
> 
> Why are we sure the ext4_release_file() / _fput() is coming from the
> cp command, as opposed to something else that might be running on the
> system under test?  _fput() is called by the kernel when the last

Please see the log:

https://lore.kernel.org/linux-scsi/3af3666920e7d46f8f0c6d88612f143ffabc743c.camel@unipv.it/2-log_ming.zip

Which is collected by:

#!/bin/sh
MAJ=$1
MIN=$2
MAJ=$(( $MAJ << 20 ))
DEV=$(( $MAJ | $MIN ))

/usr/share/bcc/tools/trace -t -C \
    't:block:block_rq_issue (args->dev == '$DEV') "%s %d %d", args->rwbs, args->sector, args->nr_sector' \
    't:block:block_rq_insert (args->dev == '$DEV') "%s %d %d", args->rwbs, args->sector, args->nr_sector'

$MAJ:$MIN points to the USB storage disk.

From the above IO trace, there are two write paths, one is from cp,
another is from writeback wq.

The stackcount trace[1] is consistent with the IO trace log since it
only shows two IO paths, that is why I concluded that the write done via
ext4_release_file() is from 'cp'.

[1] https://lore.kernel.org/linux-scsi/320b315b9c87543d4fb919ecbdf841596c8fbcea.camel@unipv.it/2-log_ming_20191129_150609.zip

> reference to a struct file is released.  (Specifically, if you have a
> fd which is dup'ed, it's only when the last fd corresponding to the
> struct file is closed, and the struct file is about to be released,
> does the file system's f_ops->release function get called.)
> 
> So the first question I'd ask is whether there is anything else going
> on the system, and whether the writes are happening to the USB thumb
> drive, or to some other storage device.  And if there is something
> else which is writing to the pendrive, maybe that's why no one else
> has been able to reproduce the OP's complaint....

OK, we can ask Andrea to confirm that via the following trace, which
will add pid/comm info in the stack trace:

/usr/share/bcc/tools/stackcount  blk_mq_sched_request_inserted

Andrew, could you collect the above log again when running new/bad
kernel for confirming if the write done by ext4_release_file() is from
the 'cp' process?

Thanks,
Ming

