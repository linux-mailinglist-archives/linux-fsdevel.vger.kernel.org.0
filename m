Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD41413E3BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 18:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388264AbgAPRDu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 12:03:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56567 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388618AbgAPRDt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579194228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dwuqMFEPkLVf1SB1Qby1DH0sArybWQvfhVUygmsr0E4=;
        b=TSFHdajr3i8d2RRlrZkNp2G7Kodwu8Oi00WJtyzD5DkC+PiyKtIzt0etf3nLLsi2M+JBO/
        K092JorT4BiBsxJjEi8ua9Km3HVoYGpEYeBzj0VHECLpi7KPzCQEZGevePycYV92dRPmNz
        JUD++pJvf20OFhkpqY+D37jV9osWLy4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-8Wzr5IoUMsCea6d2zcRGzQ-1; Thu, 16 Jan 2020 12:03:46 -0500
X-MC-Unique: 8Wzr5IoUMsCea6d2zcRGzQ-1
Received: by mail-wr1-f69.google.com with SMTP id z14so9568184wrs.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2020 09:03:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dwuqMFEPkLVf1SB1Qby1DH0sArybWQvfhVUygmsr0E4=;
        b=thTOgDYGL2LN2KjWzFdjjfiNq2s+5M2Dc5WUNqV9dpQIv3FkTif/cCFOucSMQq9w+O
         l+06ytZN2QhDxFNAChaSgzNRV0UHXLe47zoNXsS5ABaH55oLOnbpIh4pInQ8YQtRkxqj
         H4JhFH33YmsAx0HDpF9Pd4XBjLD/V69A4W4emJbUxq8rOKzxusgQLvs1quXcgtovVP2d
         HDK81GmZHlxy2v5ye9bszxzBpkkxiEtaBiFuthh9QGnvel9+1laxjqfA00K9c1M5E1Sq
         F266NUjJc1ce3fj1sjGkICIt73Y/rsQ61TciTXPrMl3MXDOI0LB9KlXvxbjBcGqU1oI4
         dF+g==
X-Gm-Message-State: APjAAAVYrq/hP0Am/nMiPTpVrV7xLC7YFtaUAk9RUXfrFhOH01CyJ7uQ
        YUdcEEpAnfEbFkFk7Ua9IZD2nu9urtHT4XF+CrV7HlDov43XkJNgxjzBViG0FcEKdARlaCd8pJy
        9TxCpcYbGqjGVf2tTuAq5xRYc9Q==
X-Received: by 2002:adf:ce87:: with SMTP id r7mr4222756wrn.245.1579194225147;
        Thu, 16 Jan 2020 09:03:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqwmahambFLYvDPNDfSiuwfj+RNjJ2awrp8kvOtBAw+JLe5Wbrx78e1fRaCj45Q555ccQHKFSw==
X-Received: by 2002:adf:ce87:: with SMTP id r7mr4222739wrn.245.1579194224894;
        Thu, 16 Jan 2020 09:03:44 -0800 (PST)
Received: from steredhat (host84-49-dynamic.31-79-r.retail.telecomitalia.it. [79.31.49.84])
        by smtp.gmail.com with ESMTPSA id q15sm29985051wrr.11.2020.01.16.09.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 09:03:44 -0800 (PST)
Date:   Thu, 16 Jan 2020 18:03:42 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] io_uring: wakeup threads waiting for EPOLLOUT events
Message-ID: <20200116170342.4jvkhbbw4x6z3txn@steredhat>
References: <20200116134946.184711-1-sgarzare@redhat.com>
 <2d2dda92-3c50-ee62-5ffe-0589d4c8fc0d@kernel.dk>
 <20200116155557.mwjc7vu33xespiag@steredhat>
 <5723453a-9326-e954-978e-910b8b495b38@kernel.dk>
 <20200116162630.6r3xc55kdyyq5tvz@steredhat>
 <a02a58dc-bf23-ed74-aec6-52c85360fe00@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a02a58dc-bf23-ed74-aec6-52c85360fe00@kernel.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 16, 2020 at 09:30:12AM -0700, Jens Axboe wrote:
> On 1/16/20 9:26 AM, Stefano Garzarella wrote:
> >> Since the use case is mostly single submitter, unless you're doing
> >> something funky or unusual, you're not going to be needing POLLOUT ever.
> > 
> > The case that I had in mind was with kernel side polling enabled and
> > a single submitter that can use epoll() to wait free slots in the SQ
> > ring. (I don't have a test, maybe I can write one...)
> 
> Right, I think that's the only use case where it makes sense, because
> you have someone else draining the sq side for you. A test case would
> indeed be nice, liburing has a good arsenal of test cases and this would
> be a good addition!

Sure, I'll send a test to liburing for this case!

Thanks,
Stefano

