Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 636AC12AA01
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2019 04:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfLZDbs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Dec 2019 22:31:48 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39769 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726885AbfLZDbs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Dec 2019 22:31:48 -0500
Received: from callcc.thunk.org (96-72-84-49-static.hfc.comcastbusiness.net [96.72.84.49] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBQ3UwCB011594
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Dec 2019 22:30:59 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id BD883420485; Wed, 25 Dec 2019 22:30:57 -0500 (EST)
Date:   Wed, 25 Dec 2019 22:30:57 -0500
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
Message-ID: <20191226033057.GA10794@mit.edu>
References: <b1b6a0e9d690ecd9432025acd2db4ac09f834040.camel@unipv.it>
 <20191223130828.GA25948@ming.t460p>
 <20191223162619.GA3282@mit.edu>
 <4c85fd3f2ec58694cc1ff7ab5c88d6e11ab6efec.camel@unipv.it>
 <20191223172257.GB3282@mit.edu>
 <bb5d395fe47f033be0b8ed96cbebf8867d2416c4.camel@unipv.it>
 <20191223195301.GC3282@mit.edu>
 <20191224012707.GA13083@ming.t460p>
 <20191225051722.GA119634@mit.edu>
 <20191226022702.GA2901@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191226022702.GA2901@ming.t460p>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 26, 2019 at 10:27:02AM +0800, Ming Lei wrote:
> Maybe we need to be careful for HDD., since the request count in scheduler
> queue is double of in-flight request count, and in theory NCQ should only
> cover all in-flight 32 requests. I will find a sata HDD., and see if
> performance drop can be observed in the similar 'cp' test.

Please try to measure it, but I'd be really surprised if it's
significant with with modern HDD's.  That because they typically have
a queue depth of 16, and a max_sectors_kb of 32767 (e.g., just under
32 MiB).  Sort seeks are typically 1-2 ms, with full stroke seeks
8-10ms.  Typical sequential write speeds on a 7200 RPM drive is
125-150 MiB/s.  So suppose every other request sent to the HDD is from
the other request stream.  The disk will chose the 8 requests from its
queue that are contiguous, and so it will be writing around 256 MiB,
which will take 2-3 seconds.  If it then needs to spend between 1 and
10 ms seeking to another location of the disk, before it writes the
next 256 MiB, the worst case overhead of that seek is 10ms / 2s, or
0.5%.  That may very well be within your measurements' error bars.

And of course, note that in real life, we are very *often* writing to
multiple files in parallel, for example, during a "make -j16" while
building the kernel.  Writing a single large file is certainly
something people do (but even there people who are burning a 4G DVD
rip are often browsing the web while they are waiting for it to
complete, and the browser will be writing cache files, etc.).  So
whether or not this is something where we should be stressing over
this specific workload is going to be quite debateable.

						- Ted
