Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04CE911C14B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 01:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfLLA2Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 19:28:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26656 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727256AbfLLA2P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 19:28:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576110494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hb5JBtjwXvbmme4Dxt6Sh1XFoFaw8S8TIapNfxubP9w=;
        b=f0UhTuHg3YyF0rP76ePTxK11QPfidUHH05ifx+cfFnw2LoBmZRf/g4aKPhwXIdJH06JWq7
        +uVeK/SsgxMVZTRcMvvbVAwhh8G1A0jTAz3ZcNSLQiw/FPszgMmGhIOD7sT9aTVDS+Rj21
        5v6s0GF4+Yzzui0vfMphSoudOybYttY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-m6phy5BMMBiEV4NIs0Zh1A-1; Wed, 11 Dec 2019 19:28:12 -0500
X-MC-Unique: m6phy5BMMBiEV4NIs0Zh1A-1
Received: by mail-wr1-f71.google.com with SMTP id t3so295812wrm.23
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 16:28:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hb5JBtjwXvbmme4Dxt6Sh1XFoFaw8S8TIapNfxubP9w=;
        b=KJ84Orpf53cjjc6ze03GQ3KOJwcmL8fmUZumPDaYPNM1l4vDz3g4fIdihUSa/pJ+Vo
         mnrn06ON4WWoGr/19UB1ECDPtUojhENOi+eB0dHmQ5oGIarIv6veMJzFSwAAmovs+Acz
         oVDmEIJgukRcSaJiVqjQ7sMOJNSWe7fuRVQBOaGjA/r0KF+smiQVMsCmONiKlETf2eAr
         6AHav+HDq4u7cJrwv6FcYTtc/1Grp2q2qUxdRFErZ8CrbLCwy1bWijGO4hCnE8o5wPE3
         G8rk7kuN2HTTDKGrn+KNZDFy6RlXjOYfGEu4b41NLyNIW4B387Bq5yNuzMDSvTwcvlfu
         fcUg==
X-Gm-Message-State: APjAAAWIENf65brePe2NK9qr+WS2ZYuRHKPGVj8xLkIzhL2BqOAkgUGS
        EMIiVa5jU+00NA6Kp4L+kyjma0MYJqS/gs/iS3hFNLaKlaAOOcBGwTN7uMe9mX0iL/06QFZWPzA
        Kby3AB0CBqAlrgV3X1mM1V9Ff2g==
X-Received: by 2002:adf:8bde:: with SMTP id w30mr2790582wra.124.1576110490983;
        Wed, 11 Dec 2019 16:28:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqwPP/UQtQvR7H0tI553soFfAslbKh86aszplkbovgcOGgnxj1GpFCjYyjEJLCUeQDAEqXIk1A==
X-Received: by 2002:adf:8bde:: with SMTP id w30mr2790552wra.124.1576110490746;
        Wed, 11 Dec 2019 16:28:10 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9? ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
        by smtp.gmail.com with ESMTPSA id g9sm4134194wro.67.2019.12.11.16.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 16:28:10 -0800 (PST)
Subject: Re: [PATCH 15/24] compat_ioctl: scsi: move ioctl handling into
 drivers
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jason Wang <jasowang@redhat.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        =?UTF-8?Q?Kai_M=c3=a4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        John Garry <john.garry@huawei.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20191211204306.1207817-1-arnd@arndb.de>
 <20191211204306.1207817-16-arnd@arndb.de>
 <20191211180155-mutt-send-email-mst@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <858768fb-5f79-8259-eb6a-a26f18fb0e04@redhat.com>
Date:   Thu, 12 Dec 2019 01:28:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191211180155-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/12/19 00:05, Michael S. Tsirkin wrote:
>> @@ -405,6 +405,9 @@ static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
>>  
>>  static const struct block_device_operations virtblk_fops = {
>>  	.ioctl  = virtblk_ioctl,
>> +#ifdef CONFIG_COMPAT
>> +	.compat_ioctl = blkdev_compat_ptr_ioctl,
>> +#endif
>>  	.owner  = THIS_MODULE,
>>  	.getgeo = virtblk_getgeo,
>>  };
> Hmm - is virtio blk lumped in with scsi things intentionally?

I think it's because the only ioctl for virtio-blk is SG_IO.  It makes
sense to lump it in with scsi, but I wouldn't mind getting rid of
CONFIG_VIRTIO_BLK_SCSI altogether.

Paolo

