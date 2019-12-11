Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE0D811C043
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 00:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfLKXFU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 18:05:20 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38921 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726313AbfLKXFP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 18:05:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576105513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sx72Zu8R4y3Ns6A0Elwe6ONN3kNLN0tIVRBIzDH4IQA=;
        b=f33R7rTHeMiaCbaN9YlBB5UWejMrxj+dBl1/h/LVzEmy2u4zDoApnHvl4PvjtZYIt1GEjM
        VtlsIIxUpCdDVTnn3SswSw++bBGFc80RffHVgNWCpz0+MW+guQd2JOvoRp6skJ07wA6gb8
        MSdeCkutOBsA+dJ4hUDF4DiESqQcnUo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-kO1UI92uPDOJth-mGjb5NA-1; Wed, 11 Dec 2019 18:05:12 -0500
X-MC-Unique: kO1UI92uPDOJth-mGjb5NA-1
Received: by mail-wr1-f71.google.com with SMTP id c6so216051wrm.18
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 15:05:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sx72Zu8R4y3Ns6A0Elwe6ONN3kNLN0tIVRBIzDH4IQA=;
        b=WUmzvFlw+anr+mdpiiR7vh26U2sgKdkaaHcfhk0STZtPTsmc52Igr+/1jN1IQFBpCU
         UFe5MfwS4fnJaSPVcAqbgi0JAHtGPsPCONU7jQn+1BJNnOUh83vkdbs073tRTF4P3XJL
         0fe30CBQSoV7+rbAGZINAy9xH0xMGRfAGizfVoHWVmu4zJLU/CincxIBTeI4RUYcr2fk
         QJsTxstQQRObMqz28JN3fMOcjYyKPfOJPStro8QGX54CfWjyF3mWDM1BEpn+l6a/b+BN
         q8YNJ1PlNRSciOFJ+OYe6n2bqBTtQQmz2P9gikf4Q/fM4V4jDYKbThxGovqYSoF1LJMl
         bnmA==
X-Gm-Message-State: APjAAAUzodppOztVdi/g1BSNEWOK0prWSaV2t2O19z8sh6X7APAv+UBk
        NDdVzsJ5Yx8yQTTWHPZDtBnSOexAofoZqywjgiEJoMkQPggnu5euLHiaRbmnPi1Fi5l9XV+aFoz
        K1tO6wqI37KsXkfCw1njMtkrIGA==
X-Received: by 2002:a1c:4008:: with SMTP id n8mr2404655wma.121.1576105511592;
        Wed, 11 Dec 2019 15:05:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqxpe9p8ejWiVLiuArWlu3PcE1o950G4BmpoXFY8faxUGRQT/Ci+xtr4RXgpMlISlS8MvrxukA==
X-Received: by 2002:a1c:4008:: with SMTP id n8mr2404621wma.121.1576105511390;
        Wed, 11 Dec 2019 15:05:11 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id g18sm3736144wmh.48.2019.12.11.15.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 15:05:10 -0800 (PST)
Date:   Wed, 11 Dec 2019 18:05:07 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jason Wang <jasowang@redhat.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        John Garry <john.garry@huawei.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 15/24] compat_ioctl: scsi: move ioctl handling into
 drivers
Message-ID: <20191211180155-mutt-send-email-mst@kernel.org>
References: <20191211204306.1207817-1-arnd@arndb.de>
 <20191211204306.1207817-16-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211204306.1207817-16-arnd@arndb.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 09:42:49PM +0100, Arnd Bergmann wrote:
> Each driver calling scsi_ioctl() gets an equivalent compat_ioctl()
> handler that implements the same commands by calling scsi_compat_ioctl().
> 
> The scsi_cmd_ioctl() and scsi_cmd_blk_ioctl() functions are compatible
> at this point, so any driver that calls those can do so for both native
> and compat mode, with the argument passed through compat_ptr().
> 
> With this, we can remove the entries from fs/compat_ioctl.c.  The new
> code is larger, but should be easier to maintain and keep updated with
> newly added commands.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/block/virtio_blk.c |   3 +
>  drivers/scsi/ch.c          |   9 ++-
>  drivers/scsi/sd.c          |  50 ++++++--------
>  drivers/scsi/sg.c          |  44 ++++++++-----
>  drivers/scsi/sr.c          |  57 ++++++++++++++--
>  drivers/scsi/st.c          |  51 ++++++++------
>  fs/compat_ioctl.c          | 132 +------------------------------------
>  7 files changed, 142 insertions(+), 204 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 7ffd719d89de..fbbf18ac1d5d 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -405,6 +405,9 @@ static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
>  
>  static const struct block_device_operations virtblk_fops = {
>  	.ioctl  = virtblk_ioctl,
> +#ifdef CONFIG_COMPAT
> +	.compat_ioctl = blkdev_compat_ptr_ioctl,
> +#endif
>  	.owner  = THIS_MODULE,
>  	.getgeo = virtblk_getgeo,
>  };

Hmm - is virtio blk lumped in with scsi things intentionally?

-- 
MST

