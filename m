Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5A3147351
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 22:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgAWVpl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 16:45:41 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28103 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728057AbgAWVpl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 16:45:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579815939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u61jrRml7uBsTChqQkvEyIjmfc5MgOu8Mlxfsu5OMjo=;
        b=IHNgFR67rxe/Y3v6/qX/+7rF4x4fCsJkB3TvgXM4HzcIFTPlAzVctwotVVGNz3rGjuOQZk
        7bBLjdV0kMkdPbzcFLiEN6z9jVjclTUXsm5seJPeCdlM6HmmrfK88P80WPYPCvC67xIDT6
        8yng0hfqOVbp3iScDPSyIMng3L6eCck=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-4S5rYNjdPKSSqRzB9M4nug-1; Thu, 23 Jan 2020 16:45:38 -0500
X-MC-Unique: 4S5rYNjdPKSSqRzB9M4nug-1
Received: by mail-wm1-f72.google.com with SMTP id o24so1145104wmh.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2020 13:45:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u61jrRml7uBsTChqQkvEyIjmfc5MgOu8Mlxfsu5OMjo=;
        b=Go576ZdZAVG+RH5yJT959H5+6UnNHUjTMB4RmwVmJPBIvlTE4hIFuO4oI9v05h4cBJ
         0UTAhr5uda/gDo3JPhBWwRfWNwzm9/EBFDB8C7CwXVLfuA4kTaXldA2zl6EOr+LzA/V/
         DGJfbQxEhHaJEzmCdsdc9/Qr5N4nCU7+cQAfjqlkZqnNaJLaputduybJ/CVZESBQC1yp
         DDoE+DwRxkWqrk6vc2G31CagGW2SHY5H1/UYNqp9ulHN2fla37YgmX8GQyzJMevahVfp
         xU19onEx++/z6EUyca8bhc6T2dU7wxvpSEH0s/Vho4BVof/bOFLainfs+E2OlOuHEINe
         qa1g==
X-Gm-Message-State: APjAAAU1gMkIpRfcMxPJlN6XSDoalQbd95/3x9qfs9OOKaik5IOOc+Yv
        rv6Y3PsHNulNzLK2959I+jGsDqadsaOLlkg2WA9xJeulluhZP3UqgeWap+Ht7r+VgOh5IQr7dw+
        nDg+7uj43lxzBXvv9VXBE6H90SA==
X-Received: by 2002:a5d:4085:: with SMTP id o5mr91676wrp.321.1579815937024;
        Thu, 23 Jan 2020 13:45:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqypvLRV506GGxMfAQP/vrSzj5p5HHA+EMluQu+yI3TOmaSFK8iaFL33miPix2yjG9Oq+XvZzw==
X-Received: by 2002:a5d:4085:: with SMTP id o5mr91651wrp.321.1579815936765;
        Thu, 23 Jan 2020 13:45:36 -0800 (PST)
Received: from steredhat ([80.188.125.198])
        by smtp.gmail.com with ESMTPSA id y139sm4299842wmd.24.2020.01.23.13.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 13:45:35 -0800 (PST)
Date:   Thu, 23 Jan 2020 22:45:33 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] io_uring: wakeup threads waiting for EPOLLOUT events
Message-ID: <20200123214533.ikn4olf7k5dfbaq6@steredhat>
References: <20200116134946.184711-1-sgarzare@redhat.com>
 <2d2dda92-3c50-ee62-5ffe-0589d4c8fc0d@kernel.dk>
 <20200116155557.mwjc7vu33xespiag@steredhat>
 <5723453a-9326-e954-978e-910b8b495b38@kernel.dk>
 <20200116162630.6r3xc55kdyyq5tvz@steredhat>
 <a02a58dc-bf23-ed74-aec6-52c85360fe00@kernel.dk>
 <20200116170342.4jvkhbbw4x6z3txn@steredhat>
 <2d3d4932-8894-6969-4006-25141ca1286e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d3d4932-8894-6969-4006-25141ca1286e@kernel.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 23, 2020 at 12:13:57PM -0700, Jens Axboe wrote:
> On 1/16/20 10:03 AM, Stefano Garzarella wrote:
> > On Thu, Jan 16, 2020 at 09:30:12AM -0700, Jens Axboe wrote:
> >> On 1/16/20 9:26 AM, Stefano Garzarella wrote:
> >>>> Since the use case is mostly single submitter, unless you're doing
> >>>> something funky or unusual, you're not going to be needing POLLOUT ever.
> >>>
> >>> The case that I had in mind was with kernel side polling enabled and
> >>> a single submitter that can use epoll() to wait free slots in the SQ
> >>> ring. (I don't have a test, maybe I can write one...)
> >>
> >> Right, I think that's the only use case where it makes sense, because
> >> you have someone else draining the sq side for you. A test case would
> >> indeed be nice, liburing has a good arsenal of test cases and this would
> >> be a good addition!
> > 
> > Sure, I'll send a test to liburing for this case!
> 
> Gentle ping on the test case :-)
> 

Yes, you are right :-)

I was a little busy this week to finish some works before DevConf.
I hope to work on the test case these days, so by Monday I hope I have it ;-)

Cheers,
Stefano

