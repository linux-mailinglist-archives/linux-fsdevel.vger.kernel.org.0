Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57E65E2CB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 10:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731900AbfJXIzS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 04:55:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:54374 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730100AbfJXIzS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 04:55:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 69814B75B;
        Thu, 24 Oct 2019 08:55:16 +0000 (UTC)
Date:   Thu, 24 Oct 2019 10:55:14 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-scsi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Tejun Heo <tj@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] bdev: add open_finish.
Message-ID: <20191024085514.GI938@kitsune.suse.cz>
References: <cover.1571834862.git.msuchanek@suse.de>
 <ea2652294651cbc8549736728c650d16d2fe1808.1571834862.git.msuchanek@suse.de>
 <20191024022232.GB11485@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024022232.GB11485@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 23, 2019 at 07:22:32PM -0700, Christoph Hellwig wrote:
> On Wed, Oct 23, 2019 at 02:52:45PM +0200, Michal Suchanek wrote:
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
> This just doesn't make much sense.  There is no point in messing up
> the block API for ugly workarounds like that.

If you have ideas how to do this better then share them.

Thanks

Michal
