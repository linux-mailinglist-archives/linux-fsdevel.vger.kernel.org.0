Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6B355E1CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241064AbiF0UHm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jun 2022 16:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241037AbiF0UHl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:07:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43D1B1E3FC
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jun 2022 13:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656360459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ecqp7u4gJaJ1mXBxwxi4FG5ZEdhI/0Q2gMOetVHGIac=;
        b=e8eA8gb5Fsqm4rn48W4YNCRpZcJ8bb7Vgto1CAhfLxWmYw7WPc6qSmkNGPHcTkqGcWIJjK
        c8ptlKVa14vvc/F4/EcQOf4ls01KbmNjGE7rc2pzgMzMAIeXROVbbvhKhbVmerOArtGpI+
        HPLfjV2vboONKRAdxVM9rhB/I1IhqU4=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-163-0FBtPoslPyakT1TCjwrohA-1; Mon, 27 Jun 2022 16:07:37 -0400
X-MC-Unique: 0FBtPoslPyakT1TCjwrohA-1
Received: by mail-il1-f200.google.com with SMTP id s15-20020a056e02216f00b002d3d5e41565so6199945ilv.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jun 2022 13:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Ecqp7u4gJaJ1mXBxwxi4FG5ZEdhI/0Q2gMOetVHGIac=;
        b=wjAPCpQM4fTa5D31avsqDL/HOOm7jk98fILtd7iMobBZxhVpQQxfjOiQqGaCXTVvmM
         m9jxkhMaPeKjI3rdsuqZus9MSNf//YPyM9GlR6grts/Wz0zncDkagkoWxUYiUHdD/dWO
         yP0RKz/HwgSBDqYix+g0T4vXePzZBWASaIijlgrdsSht+MTnGUbX+ZD8m2ijq1dKW6yO
         z4nDRdnZgDXCo1zb82AKN8PHTxvLXOq6fDRfirnwUnVCe905dbXoMC/+Ugqf/SCWucbu
         xsxJgQ1rWxhyWb2GAC+D0ID64TzPZvJMPctnynvQYr1E3JuIi80eN+4QFQETqIhi5VF0
         luqw==
X-Gm-Message-State: AJIora9OwJ6ybK53OZ8Tzr2MK7QYrgIL0nOJmpxrMPmuNFXvTO+tZTK1
        lBxrUnI1MjR3MR+PVk3xOH8VRi/Ek8JeNk8asfInLSTZVgjEIp/h3jOJbb9NSpdxQynBNmZqqgZ
        yZjhUh7b25O7SHDKLWMwhvg9WAw==
X-Received: by 2002:a05:6638:22c7:b0:333:f684:ccc4 with SMTP id j7-20020a05663822c700b00333f684ccc4mr8853610jat.57.1656360457269;
        Mon, 27 Jun 2022 13:07:37 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sNIPUYijEfnPKfQZWxOpm7YokpOplZ2wBAN4sSDoCyh8jOJGTEHm2vhuygZD7iG02GUVE7+w==
X-Received: by 2002:a05:6638:22c7:b0:333:f684:ccc4 with SMTP id j7-20020a05663822c700b00333f684ccc4mr8853601jat.57.1656360457084;
        Mon, 27 Jun 2022 13:07:37 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id x66-20020a0294c8000000b00339dd803fddsm5190825jah.174.2022.06.27.13.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 13:07:36 -0700 (PDT)
Date:   Mon, 27 Jun 2022 14:07:35 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v2 8/8] vfio: do not set FMODE_LSEEK flag
Message-ID: <20220627140735.32723d4a.alex.williamson@redhat.com>
In-Reply-To: <20220625110115.39956-9-Jason@zx2c4.com>
References: <20220625110115.39956-1-Jason@zx2c4.com>
        <20220625110115.39956-9-Jason@zx2c4.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 25 Jun 2022 13:01:15 +0200
"Jason A. Donenfeld" <Jason@zx2c4.com> wrote:

> This file does not support llseek, so don't set the flag advertising it.
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: kvm@vger.kernel.org
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/vfio/vfio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index 61e71c1154be..d194dda89542 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -1129,7 +1129,7 @@ static struct file *vfio_device_open(struct vfio_device *device)
>  	 * Appears to be missing by lack of need rather than
>  	 * explicitly prevented.  Now there's need.
>  	 */
> -	filep->f_mode |= (FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE);
> +	filep->f_mode |= (FMODE_PREAD | FMODE_PWRITE);
>  
>  	if (device->group->type == VFIO_NO_IOMMU)
>  		dev_warn(device->dev, "vfio-noiommu device opened by user "

Acked-by: Alex Williamson <alex.williamson@redhat.com>

