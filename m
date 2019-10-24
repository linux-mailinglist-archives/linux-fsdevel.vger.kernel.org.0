Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A45AE280E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 04:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408191AbfJXCWd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 22:22:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42834 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406401AbfJXCWd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 22:22:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VdqxphUBsAx8A35g/nQEXQbEGAO7hR3jrSxRZ6H7Ekw=; b=Ao3aMKIz2ZC1ggbnQleeDHCrt
        cxahZc8hg8+ROHlAVa4TQhidj2Q3gxt0LlMbNjeGDZJT7jqYzR1Jgtnkbd9OWMdzgfoMuHPxcjHYN
        Wdl6Ko8Jsq04A6/VBvArxPLEwH1VigY/42xB0ADLEOxQktBGFcE7V0LIZ7Ofk1icwULvy90CQKYo4
        TTNyY7h4wwPbhHkbtPiHhVAVb7VNpGrkz7q0Bhs0ZHJelBdtBuMf86+yYfFfgOwORVWx/kr6WVXZR
        jDwKxeAny62exBQODJdhZdh2b6AUW6UfTduB02V15Cu0n17naKKVLY/T8VHERi39NPulhjKI/q+7m
        eymCUMxtQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNSlk-0004Xk-IY; Thu, 24 Oct 2019 02:22:32 +0000
Date:   Wed, 23 Oct 2019 19:22:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Michal Suchanek <msuchanek@suse.de>
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
Message-ID: <20191024022232.GB11485@infradead.org>
References: <cover.1571834862.git.msuchanek@suse.de>
 <ea2652294651cbc8549736728c650d16d2fe1808.1571834862.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea2652294651cbc8549736728c650d16d2fe1808.1571834862.git.msuchanek@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 23, 2019 at 02:52:45PM +0200, Michal Suchanek wrote:
> Opening a block device may require a long operation such as waiting for
> the cdrom tray to close. Performing this operation with locks held locks
> out other attempts to open the device. These processes waiting to open
> the device are not killable.
> 
> To avoid this issue and still be able to perform time-consuming checks
> at open() time the block device driver can provide open_finish(). If it
> does opening the device proceeds even when an error is returned from
> open(), bd_mutex is released and open_finish() is called. If
> open_finish() succeeds the device is now open, if it fails release() is
> called.
> 
> When -ERESTARTSYS is returned from open() blkdev_get may loop without
> calling open_finish(). On -ERESTARTSYS open_finish() is not called.
> 
> Move a ret = 0 assignment up in the if/else branching to avoid returning
> -ENXIO. Previously the return value was ignored on the unhandled branch.

This just doesn't make much sense.  There is no point in messing up
the block API for ugly workarounds like that.
