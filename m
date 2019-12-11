Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E692D11B784
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 17:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388883AbfLKQIO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 11:08:14 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54485 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731122AbfLKQIN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 11:08:13 -0500
Received: from callcc.thunk.org (guestnat-104-132-34-105.corp.google.com [104.132.34.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBBG7jbj026860
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 11:07:46 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A4C13421A48; Wed, 11 Dec 2019 11:07:45 -0500 (EST)
Date:   Wed, 11 Dec 2019 11:07:45 -0500
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
Message-ID: <20191211160745.GA129186@mit.edu>
References: <20191128091712.GD15549@ming.t460p>
 <f82fd5129e3dcacae703a689be60b20a7fedadf6.camel@unipv.it>
 <20191129005734.GB1829@ming.t460p>
 <20191129023555.GA8620@ming.t460p>
 <320b315b9c87543d4fb919ecbdf841596c8fbcea.camel@unipv.it>
 <20191203022337.GE25002@ming.t460p>
 <8196b014b1a4d91169bf3b0d68905109aeaf2191.camel@unipv.it>
 <20191210080550.GA5699@ming.t460p>
 <20191211024137.GB61323@mit.edu>
 <20191211040058.GC6864@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211040058.GC6864@ming.t460p>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 12:00:58PM +0800, Ming Lei wrote:
> I didn't reproduce the issue in my test environment, and follows
> Andrea's test commands[1]:
> 
>   mount UUID=$uuid /mnt/pendrive 2>&1 |tee -a $logfile
>   SECONDS=0
>   cp $testfile /mnt/pendrive 2>&1 |tee -a $logfile
>   umount /mnt/pendrive 2>&1 |tee -a $logfile
> 
> The 'cp' command supposes to open/close the file just once, however
> ext4_release_file() & write pages is observed to run for 4358 times
> when executing the above 'cp' test.

Why are we sure the ext4_release_file() / _fput() is coming from the
cp command, as opposed to something else that might be running on the
system under test?  _fput() is called by the kernel when the last
reference to a struct file is released.  (Specifically, if you have a
fd which is dup'ed, it's only when the last fd corresponding to the
struct file is closed, and the struct file is about to be released,
does the file system's f_ops->release function get called.)

So the first question I'd ask is whether there is anything else going
on the system, and whether the writes are happening to the USB thumb
drive, or to some other storage device.  And if there is something
else which is writing to the pendrive, maybe that's why no one else
has been able to reproduce the OP's complaint....

    	      	 	    	     - Ted
