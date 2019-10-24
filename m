Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D741CE33B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 15:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502445AbfJXNOd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 09:14:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45002 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502438AbfJXNOd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5OQ8vAisIbi6t1AXhKrSUhlAbShVLTGo3AmrlvGo4g8=; b=bttpX+0dBXHANg2mLC9oB4tpyx
        ywkxut3xv8ozM+p6k5jyo9RdB1sdB+EIShDvXsI2sI1+/CI+YA9mWOc13DQqy7cQjT+tcoVDwdNLk
        KQgoCbH+V1z8tl5gbX7CePfEaNeMOdHSz5DPYQch04H8rT0peQWfrYldDOl+CmfnomN+QpF8ZXqMx
        5Y/16WXEigN/ArdT1iIvbmna3+CFyicCDazBIV2ITlx3qfWA1NwBH0TELBH+ldPcgJfMRMC4Y9OUJ
        lZC71LVNSAVjO1tQv+2/8Tj2H3DiNpqh/PXxPMp9Cs6YlbFevPsoUB4jAliaCsy2HirXVTSAffSy3
        faL8XUdw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNcwi-0005Jb-L3; Thu, 24 Oct 2019 13:14:32 +0000
Date:   Thu, 24 Oct 2019 06:14:32 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-scsi@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
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
Subject: Re: [PATCH v2 8/8] scsi: sr: wait for the medium to become ready
Message-ID: <20191024131432.GF2963@bombadil.infradead.org>
References: <cover.1571834862.git.msuchanek@suse.de>
 <94dc98dc67b1d183d04c338c7978efa0556db6ac.1571834862.git.msuchanek@suse.de>
 <20191024022406.GD11485@infradead.org>
 <20191024085136.GG938@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191024085136.GG938@kitsune.suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 24, 2019 at 10:51:36AM +0200, Michal Suchánek wrote:
> On Wed, Oct 23, 2019 at 07:24:06PM -0700, Christoph Hellwig wrote:
> > On Wed, Oct 23, 2019 at 02:52:47PM +0200, Michal Suchanek wrote:
> > > +static int sr_block_open_finish(struct block_device *bdev, fmode_t mode,
> > > +				int ret)
> > > +{
> > > +	struct scsi_cd *cd = scsi_cd(bdev->bd_disk);
> > > +
> > > +	/* wait for drive to get ready */
> > > +	if ((ret == -ENOMEDIUM) && !(mode & FMODE_NDELAY)) {
> > > +		struct scsi_device *sdev = cd->device;
> > > +		/*
> > > +		 * Cannot use sr_block_ioctl because it locks sr_mutex blocking
> > > +		 * out any processes trying to access the drive
> > > +		 */
> > > +		scsi_autopm_get_device(sdev);
> > > +		cdrom_ioctl(&cd->cdi, bdev, mode, CDROM_AUTOCLOSE, 0);
> > > +		ret = __sr_block_open(bdev, mode);
> > > +		scsi_autopm_put_device(sdev);
> > 
> > Ioctls should never be used from kernel space.  We have a few leftovers,
> > but we need to get rid of that and not add more.
> 
> What is the alternative?

Call the function that would be called by the ioctl instead.
