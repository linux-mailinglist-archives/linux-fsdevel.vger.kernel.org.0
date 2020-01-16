Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C62913E007
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 17:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgAPQ0h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 11:26:37 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60788 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726887AbgAPQ0h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:26:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579191996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G6RNGzjUW843+AgIaDtl8qCHGuApw8Cu8ZmlHAq9RaQ=;
        b=SVxAUh98rP5ybdTpel0kaXdzL/gJDg0alW01oJAdh5ESptSMDT0CmRPG+9qpRyE3WzQFUz
        /9C3I9KUl+4HlDpl2j8cFZKtaAGa7cyRbPaxA7XTtDp+IWcqqLFB2SdBuKcFvcDa/tXx7U
        99Z+eBpma+cnca64lXGOse2bD5mEazU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-rT6YYmwoPgiLnMrhvJLi-A-1; Thu, 16 Jan 2020 11:26:35 -0500
X-MC-Unique: rT6YYmwoPgiLnMrhvJLi-A-1
Received: by mail-wr1-f71.google.com with SMTP id y7so9474353wrm.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2020 08:26:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G6RNGzjUW843+AgIaDtl8qCHGuApw8Cu8ZmlHAq9RaQ=;
        b=BsMTJKxmst7Iv/Y+ciEm6vqB2WxAqI+wRwcjWUOlUg0p+3P9n321OcmvXWxnWst5bE
         W9apZVqcMFS+lTATwaRkjFL/y5v5OfF7UXQfMD/MqoCCpWHZFAA+fmytmZjdrPkpBQfQ
         S3iD5mFsJ7kpmRtXKEGrCrlHG75uwRTvN8zvI3jSASWd9sRrFCf/wfRkihJ1tB0lQjC8
         NoUYkxnbZgJCRsZUJH2rPFPsQiHkTzkU2auklcwLrzIHRzFbcHRF7HRv9HlhzAHy8Nns
         o+LP6rrr73IcPWyJHpqK7WC2CO6jtDouBhL3mxb0MFIm8Ejd+7InwT3HBamsTQ+bpioQ
         /pSw==
X-Gm-Message-State: APjAAAVren6Bb7PWNtgNMIwmYGeRJpDD3Qw0KL7FipJMopLhOWivX5G5
        je5L+/O7t77/aMJsli6HTPWMgcqLF9qqyvFlRqxCRney6cZ1+AxymG8uOrXW9U5V9NVyghnIyAe
        UCXfWJdWc3XLMAe4jxptculL5Ow==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr179127wmj.96.1579191993843;
        Thu, 16 Jan 2020 08:26:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqyVNkRUOY54Y/ZYMQW77kBEaygl5YC6rGuaZPyaPFrmI7SCRCZD7H/YaLgWR5CAcTzkjJR9eg==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr179105wmj.96.1579191993610;
        Thu, 16 Jan 2020 08:26:33 -0800 (PST)
Received: from steredhat (host84-49-dynamic.31-79-r.retail.telecomitalia.it. [79.31.49.84])
        by smtp.gmail.com with ESMTPSA id p18sm5370071wmb.8.2020.01.16.08.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 08:26:32 -0800 (PST)
Date:   Thu, 16 Jan 2020 17:26:30 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] io_uring: wakeup threads waiting for EPOLLOUT events
Message-ID: <20200116162630.6r3xc55kdyyq5tvz@steredhat>
References: <20200116134946.184711-1-sgarzare@redhat.com>
 <2d2dda92-3c50-ee62-5ffe-0589d4c8fc0d@kernel.dk>
 <20200116155557.mwjc7vu33xespiag@steredhat>
 <5723453a-9326-e954-978e-910b8b495b38@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5723453a-9326-e954-978e-910b8b495b38@kernel.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 16, 2020 at 09:00:24AM -0700, Jens Axboe wrote:
> On 1/16/20 8:55 AM, Stefano Garzarella wrote:
> > On Thu, Jan 16, 2020 at 08:29:07AM -0700, Jens Axboe wrote:
> >> On 1/16/20 6:49 AM, Stefano Garzarella wrote:
> >>> io_uring_poll() sets EPOLLOUT flag if there is space in the
> >>> SQ ring, then we should wakeup threads waiting for EPOLLOUT
> >>> events when we expose the new SQ head to the userspace.
> >>>
> >>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >>> ---
> >>>
> >>> Do you think is better to change the name of 'cq_wait' and 'cq_fasync'?
> >>
> >> I honestly think it'd be better to have separate waits for in/out poll,
> >> the below patch will introduce some unfortunate cacheline traffic
> >> between the submitter and completer side.
> > 
> > Agree, make sense. I'll send a v2 with a new 'sq_wait'.
> > 
> > About fasync, do you think could be useful the POLL_OUT support?
> > In this case, maybe is not simple to have two separate fasync_struct,
> > do you have any advice?
> 
> The fasync should not matter, it's all in the checking of whether the sq
> side has any sleepers. This is rarely going to be the case, so as long
> as we can keep the check cheap, then I think we're fine.

Right.

> 
> Since the use case is mostly single submitter, unless you're doing
> something funky or unusual, you're not going to be needing POLLOUT ever.

The case that I had in mind was with kernel side polling enabled and
a single submitter that can use epoll() to wait free slots in the SQ
ring. (I don't have a test, maybe I can write one...)

> Hence I don't want to add any cost for it, I'd even advocate just doing
> waitqueue_active() perhaps, if we can safely pull it off.

I'll try!

Thanks,
Stefano

