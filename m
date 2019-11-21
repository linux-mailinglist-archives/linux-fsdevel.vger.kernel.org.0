Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9BE105006
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 11:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfKUKGS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 05:06:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:49890 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726014AbfKUKGS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:06:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 38FAEADC8;
        Thu, 21 Nov 2019 10:06:16 +0000 (UTC)
Date:   Thu, 21 Nov 2019 11:06:14 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-scsi@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Tejun Heo <tj@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] bdev: add open_finish.
Message-ID: <20191121100614.GH11661@kitsune.suse.cz>
References: <cover.1572002144.git.msuchanek@suse.de>
 <31f640791d9cc20cdbbb3000dfcf8370cf3c6223.1572002144.git.msuchanek@suse.de>
 <20191105001727.GA29826@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105001727.GA29826@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 04, 2019 at 04:17:27PM -0800, Christoph Hellwig wrote:
> Please make sure you CC linux-block if you add block device ops.
> 
> On Fri, Oct 25, 2019 at 01:21:42PM +0200, Michal Suchanek wrote:
> > Opening a block device may require a long operation such as waiting for
> > the cdrom tray to close. Performing this operation with locks held locks
> > out other attempts to open the device. These processes waiting to open
> > the device are not killable.
> > 
> > To avoid this issue and still be able to perform time-consuming checks
> > at open() time the block device driver can provide open_finish(). If it
> > does opening the device proceeds even when an error is returned from
> > open(), bd_mutex is released and open_finish() is called. If
> > open_finish() succeeds the device is now open, if it fails release() is
> > called.
> > 
> > When -ERESTARTSYS is returned from open() blkdev_get may loop without
> > calling open_finish(). On -ERESTARTSYS open_finish() is not called.
> > 
> > Move a ret = 0 assignment up in the if/else branching to avoid returning
> > -ENXIO. Previously the return value was ignored on the unhandled branch.
> 
> Still a complete nack for splitting a fundamental operation over two
> ops, especially just for working around a piece of buggy software.

Still did not provide an awesome alternative that does not sneed
splitting the operation.

What is it, specifically?

Thanks

Michal
