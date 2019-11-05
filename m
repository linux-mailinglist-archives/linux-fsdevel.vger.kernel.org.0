Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59D86EF1CC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 01:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387620AbfKEARb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 19:17:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38718 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387415AbfKEARa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 19:17:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rmotbuiJ0EOix30Si2XGpOoKC4o3ZoK8589mQ5Hds5I=; b=Z+Zg46Edx1IcEww0YGj1D014Y
        FAP0eWgSKwkaX082En4iPK1lkJ+QJtwwfyIMKmG9lPkKZOY+OclgDKegBaxvhmpLyhQ23jjLmFugA
        oLeq/gTRdbv1iobQhOgF6CK5YOZfYCteiEk1svh+/8LNHIrJgADgMOjXWcPB7q6wq4L8H+EFqPqCE
        HAevx5CCOKSk4Z1PTMBZs82iMD5dGMA5OSvNy2zEU+EQHavbOD9WQrwQ56n7a8fJrg1sJPeAB7hH4
        ivlzDonGWMNApnCNtnkVouVVtvyh7SRwdWiS4fuapBmULFF/eaM3uZ8yV0Ypqz+N7VsYNP7cYPO3C
        Ui4wppx3w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iRmXH-0007vi-Ay; Tue, 05 Nov 2019 00:17:27 +0000
Date:   Mon, 4 Nov 2019 16:17:27 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <20191105001727.GA29826@infradead.org>
References: <cover.1572002144.git.msuchanek@suse.de>
 <31f640791d9cc20cdbbb3000dfcf8370cf3c6223.1572002144.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31f640791d9cc20cdbbb3000dfcf8370cf3c6223.1572002144.git.msuchanek@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Please make sure you CC linux-block if you add block device ops.

On Fri, Oct 25, 2019 at 01:21:42PM +0200, Michal Suchanek wrote:
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

Still a complete nack for splitting a fundamental operation over two
ops, especially just for working around a piece of buggy software.
