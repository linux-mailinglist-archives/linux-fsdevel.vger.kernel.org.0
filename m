Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1068811CAB3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 11:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfLLK1s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 05:27:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55217 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728589AbfLLK1p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:27:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576146464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qU9B6VyDpHjtTgIgGRVPpWJk/W+j6466GBB3hhlYf7g=;
        b=RlV25XoGBhgTBON0WMFGqHKNzsUzYMBJ4QH0aR7wyOBWGd+uj/CrDTEuW/B6wsMqxyUGo7
        WT6/aIDvSjr89c8aMNRqudTX+QPQL1y6NRE2UHjD6V23nSKd38TcV9cQkh4VsIftM68Dc0
        yh5AkSKXV8KdTlvKIpk7bPjMQqBWxUM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-3R1jcC6AMTq75Q4D4W4_Vg-1; Thu, 12 Dec 2019 05:27:42 -0500
X-MC-Unique: 3R1jcC6AMTq75Q4D4W4_Vg-1
Received: by mail-qt1-f198.google.com with SMTP id m30so1090776qtb.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 02:27:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qU9B6VyDpHjtTgIgGRVPpWJk/W+j6466GBB3hhlYf7g=;
        b=Rear6XaWdHWTfcTtWL4AmGv/T6MPM638IVZVtfexIzHnkJEGm0TUVGO7DqrEShS0rn
         6jLZ0PoTNEQBUYJz6M9bFFILE03mPOF2zU7U81hlUOPdyhCKyGknPySIWfpDEowQ6bu3
         OvzP3H+w+Shb11cyYByyxE0AhJM9jT8MOq70HjokNnZfkpnLWlv4wrO6uDSiQnuEVrpJ
         JfN6P+ZCPbNLw7FByiI/fFZ6sqvVAAEu8NWEwaC9N9e904SLrHNL4+jbl9x9+JKEbkyi
         jPxjFX0mq5WZAmp7H5TMW1+JW2u52Ny5Un10mMIRAZPl1egjcjkozRO8ADsrHSzk7hXk
         2qKw==
X-Gm-Message-State: APjAAAX5YB2yfwmP1JT+l5bUYtpGD/XscYmSkDKMLwIuo+71yQabrSqz
        qOUx2cIip8jkPUf0bLiNKwoqvJWcACcBX7MIEvKYJrwdyu88lhnb8Q0pU6H3Yksy0F/BiCZfMyT
        ppXAYNYY0bB2LSH4yTvMlS9udzA==
X-Received: by 2002:a0c:fa4b:: with SMTP id k11mr7283763qvo.55.1576146461808;
        Thu, 12 Dec 2019 02:27:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqxtYqnSCAa6qS7eoPNNg8Gjl2R1rf+c6pT8ccpGnyGaK+GWirzetuKwnPIwjkwnOvZt6S9U2w==
X-Received: by 2002:a0c:fa4b:: with SMTP id k11mr7283726qvo.55.1576146461280;
        Thu, 12 Dec 2019 02:27:41 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id 2sm1599671qkv.98.2019.12.12.02.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 02:27:40 -0800 (PST)
Date:   Thu, 12 Dec 2019 05:27:33 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jason Wang <jasowang@redhat.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
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
Message-ID: <20191212052649-mutt-send-email-mst@kernel.org>
References: <20191211204306.1207817-1-arnd@arndb.de>
 <20191211204306.1207817-16-arnd@arndb.de>
 <20191211180155-mutt-send-email-mst@kernel.org>
 <858768fb-5f79-8259-eb6a-a26f18fb0e04@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <858768fb-5f79-8259-eb6a-a26f18fb0e04@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 12, 2019 at 01:28:08AM +0100, Paolo Bonzini wrote:
> On 12/12/19 00:05, Michael S. Tsirkin wrote:
> >> @@ -405,6 +405,9 @@ static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
> >>  
> >>  static const struct block_device_operations virtblk_fops = {
> >>  	.ioctl  = virtblk_ioctl,
> >> +#ifdef CONFIG_COMPAT
> >> +	.compat_ioctl = blkdev_compat_ptr_ioctl,
> >> +#endif
> >>  	.owner  = THIS_MODULE,
> >>  	.getgeo = virtblk_getgeo,
> >>  };
> > Hmm - is virtio blk lumped in with scsi things intentionally?
> 
> I think it's because the only ioctl for virtio-blk is SG_IO.

Oh right, I forgot about that one ...

>  It makes
> sense to lump it in with scsi, but I wouldn't mind getting rid of
> CONFIG_VIRTIO_BLK_SCSI altogether.
> 
> Paolo

