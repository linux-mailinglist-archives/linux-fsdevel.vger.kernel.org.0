Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E19A5E2818
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 04:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408217AbfJXCYG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 22:24:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43270 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406400AbfJXCYG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 22:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jqaSnMivMbTcu9ltBfVGub27KNjYSIvA9j9EeZ25Gtg=; b=HbQ4E4NyaoU4b4xncTnHvaoM7
        dD9y4Rv90jjsduTfR5TIPaHkB1q1bvoTtoI+JOhZX2sRvtxUlf6wo/r+yhOU2mcIpfG6YAbBRIgsw
        4SxXGr42k+1CZV0K8jNKrOEuOH4gfoSKrhXB+uQSTZwCOoON9nY8483Mj0w98gsJl9neXq2S/Xqpf
        2tg8f5H65x/ExvuTcZmniU+dD6t6rtUoH6W/PyXFt854zeDeei8tP3PHjQrkiW6AJORaSusgwHosq
        a2mPgpjRABGj5PriHE3PonP73iPD1cssVaSZZEIOJ4nAYd5T2cIDRuYJyx3FY80qNFnqw61Mr5ETl
        jZnmC9/OQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNSnG-0004h2-AQ; Thu, 24 Oct 2019 02:24:06 +0000
Date:   Wed, 23 Oct 2019 19:24:06 -0700
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
Subject: Re: [PATCH v2 8/8] scsi: sr: wait for the medium to become ready
Message-ID: <20191024022406.GD11485@infradead.org>
References: <cover.1571834862.git.msuchanek@suse.de>
 <94dc98dc67b1d183d04c338c7978efa0556db6ac.1571834862.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94dc98dc67b1d183d04c338c7978efa0556db6ac.1571834862.git.msuchanek@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 23, 2019 at 02:52:47PM +0200, Michal Suchanek wrote:
> +static int sr_block_open_finish(struct block_device *bdev, fmode_t mode,
> +				int ret)
> +{
> +	struct scsi_cd *cd = scsi_cd(bdev->bd_disk);
> +
> +	/* wait for drive to get ready */
> +	if ((ret == -ENOMEDIUM) && !(mode & FMODE_NDELAY)) {
> +		struct scsi_device *sdev = cd->device;
> +		/*
> +		 * Cannot use sr_block_ioctl because it locks sr_mutex blocking
> +		 * out any processes trying to access the drive
> +		 */
> +		scsi_autopm_get_device(sdev);
> +		cdrom_ioctl(&cd->cdi, bdev, mode, CDROM_AUTOCLOSE, 0);
> +		ret = __sr_block_open(bdev, mode);
> +		scsi_autopm_put_device(sdev);

Ioctls should never be used from kernel space.  We have a few leftovers,
but we need to get rid of that and not add more.
