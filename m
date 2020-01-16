Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A44513DF50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 16:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgAPP4E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 10:56:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54710 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726406AbgAPP4E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 10:56:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579190162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=59rSP/4nG5ysgfDP2nwJUgUTFNS/i6M0+YH8HiBE7YE=;
        b=YgRc+Xj7Rt/JUG6I4BYZmVq980H5Bncrw7tj5qhDmB4gjNEUvoLyjGJ80I8ihk9UWuNjJ7
        cXSM0oHYjNgs3+B/nzWLImD2GhH3KzGz6oUxkEmizGhdccsr+FK36eTTww/wIcBNk3xwEN
        pl8BdgOQzcX19LX7rIIUMGnSpWcrkvM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-bz-fVULFPj6uDY0aTFgfhA-1; Thu, 16 Jan 2020 10:56:01 -0500
X-MC-Unique: bz-fVULFPj6uDY0aTFgfhA-1
Received: by mail-wm1-f72.google.com with SMTP id l11so2450225wmi.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2020 07:56:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=59rSP/4nG5ysgfDP2nwJUgUTFNS/i6M0+YH8HiBE7YE=;
        b=lpxhzWvtrGR06+i4rhGOh0VdMy0d+nBJ7o8i/nWBWbDHUqjh6tqxITdbxB13/A399D
         Hw1+6BaJHYB3GFGsytg3qIyVgBQ3rRPEyyJxmIETsqhw8XqNVHGnhoRd6GpzhUdr3c9B
         rSLRyynuTV1bp5NBXO/8ImWG1k6j3Sk8eN8zGSUQEubOwuSBUy9DOVXEG251FyJANRgt
         /tGClLoKkqcMEpyD36HgwNkdoKMFDzux+VIcZV+dIXqCPAA8Suc9ku0es5nfc8cNR4jc
         VMqLewW/S8XxxeMrczuOMMkWVPghxEISlUukomkQCTNp5Yofcf971amJR06kad4cn+2V
         I5Dw==
X-Gm-Message-State: APjAAAUIztNUeNms6RSzzGbqJ+IfFEWJ83NEbHaNmf5iZ0RpHaICSWHz
        aZuo0ULXbM8aENTbsdIQspEO+lIg+2PQHmscGnVnO496NgRjuHlLg6q3OstX7dJ8qb6pkxbaxcF
        jYqA+7S5nzXifb96h+64dMzWtBA==
X-Received: by 2002:a1c:488a:: with SMTP id v132mr4004wma.153.1579190160200;
        Thu, 16 Jan 2020 07:56:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqyARJugJk6ZQ7MpUK2INr7v0S3I+70oMKj69iGSMkRzx4xa29/fG8xCm60wqugTUISWTMXsWQ==
X-Received: by 2002:a1c:488a:: with SMTP id v132mr3985wma.153.1579190159959;
        Thu, 16 Jan 2020 07:55:59 -0800 (PST)
Received: from steredhat (host84-49-dynamic.31-79-r.retail.telecomitalia.it. [79.31.49.84])
        by smtp.gmail.com with ESMTPSA id n67sm5422048wmf.46.2020.01.16.07.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 07:55:59 -0800 (PST)
Date:   Thu, 16 Jan 2020 16:55:57 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] io_uring: wakeup threads waiting for EPOLLOUT events
Message-ID: <20200116155557.mwjc7vu33xespiag@steredhat>
References: <20200116134946.184711-1-sgarzare@redhat.com>
 <2d2dda92-3c50-ee62-5ffe-0589d4c8fc0d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d2dda92-3c50-ee62-5ffe-0589d4c8fc0d@kernel.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 16, 2020 at 08:29:07AM -0700, Jens Axboe wrote:
> On 1/16/20 6:49 AM, Stefano Garzarella wrote:
> > io_uring_poll() sets EPOLLOUT flag if there is space in the
> > SQ ring, then we should wakeup threads waiting for EPOLLOUT
> > events when we expose the new SQ head to the userspace.
> > 
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > 
> > Do you think is better to change the name of 'cq_wait' and 'cq_fasync'?
> 
> I honestly think it'd be better to have separate waits for in/out poll,
> the below patch will introduce some unfortunate cacheline traffic
> between the submitter and completer side.

Agree, make sense. I'll send a v2 with a new 'sq_wait'.

About fasync, do you think could be useful the POLL_OUT support?
In this case, maybe is not simple to have two separate fasync_struct,
do you have any advice?

Thanks,
Stefano

