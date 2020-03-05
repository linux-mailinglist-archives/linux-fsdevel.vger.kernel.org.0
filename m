Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD720179D41
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2020 02:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgCEBWO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 20:22:14 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33352 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgCEBWO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 20:22:14 -0500
Received: by mail-qk1-f195.google.com with SMTP id p62so3758445qkb.0;
        Wed, 04 Mar 2020 17:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mkRpzA3P6Y6jkl5RHlE/gdhWCOjS5JJwXY+64DkVtvk=;
        b=IVvswKI5FcePlVqii0KjisuzTyaE4hqtQPii6g5g7nzs8TSHRPj5cGrUJFRbJaWHe3
         lCP5b4rix2ph1ZnASZSCehCkGWQMHL+OnwA5poKq5sxMo2NSNEEThKlZUXwx5iOcGHzR
         Y6xrSiJs35ipRGZPDQTWtckK+xMgUH7Wd1HED1w8m0rx+f9q6vs3q24LH9WSNB2wkkwT
         /OnoOOnNSM1JqGRz48WsogumYeQSqCRpczkkstha1ztw413GHh741CFeP08pwRl5tARJ
         2TKLZBCMzTKl0DDbXTlIEQ1r2Gd3VmrBkvxn/ljkl4gdpgCUZoN2kX9vkpdhbOzQw3NN
         hYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mkRpzA3P6Y6jkl5RHlE/gdhWCOjS5JJwXY+64DkVtvk=;
        b=GVIxknnOB6XuE1i0SpH7UaVjpvu3r6jv2LYqciUE0IkSISrqTZsSJsFHRLhnzr7ysY
         HGBRKNKHgpDYBSvc0nPymF8AnVxQjvr3VAsxG0P0OrZMyyYCWP1dRMTSvqBAWdKWnkxG
         BU5y08JYMcQLfKcP7YG9dcuxpGjDkuxVUixYlRDFm8EaXxbi97YnboJeIr5Qi8YxAJdY
         JreuMdXq+qLjqJs1ZkbU7j5Rlgi8Oam7U6QFZhVGwr7t+RNlsQIO/4mGvvSShdB1U7i0
         WlNe8s/n7LklqhtAL7bvSWm30Bn/JDBIQu8xjAl7/TkHZ3Q+2iEkRAXiH5tPE25+5dfZ
         Yt6Q==
X-Gm-Message-State: ANhLgQ2QltdHMZs4+COcas2kxndFxqAdFHekwI7suMnXu9F6xuVEsuyp
        W2+hlhT31cYm8jX3V64dIEM=
X-Google-Smtp-Source: ADFU+vv/q/xU9Iic5X8zYiNPGWfhthYWWHcfoAeZJTBukjahlC8x9E825Q5m3MW7qjNgyUSLYWwOgQ==
X-Received: by 2002:a05:620a:16d0:: with SMTP id a16mr5895817qkn.296.1583371333145;
        Wed, 04 Mar 2020 17:22:13 -0800 (PST)
Received: from localhost ([71.172.127.161])
        by smtp.gmail.com with ESMTPSA id c204sm15065044qke.2.2020.03.04.17.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 17:22:12 -0800 (PST)
Date:   Wed, 4 Mar 2020 20:22:11 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yufen Yu <yuyufen@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, bvanassche@acm.org, tytso@mit.edu
Subject: Re: [PATCH v2 3/7] bdi: protect device lifetime with RCU
Message-ID: <20200305012211.GA33199@mtj.duckdns.org>
References: <20200226111851.55348-1-yuyufen@huawei.com>
 <20200226111851.55348-4-yuyufen@huawei.com>
 <20200304170543.GJ189690@mtj.thefacebook.com>
 <20200304172221.GA1864270@kroah.com>
 <20200304185056.GM189690@mtj.thefacebook.com>
 <20200304200559.GA1906005@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304200559.GA1906005@kroah.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Wed, Mar 04, 2020 at 09:05:59PM +0100, Greg Kroah-Hartman wrote:
> > Lifetime rules in block layer are kinda nebulous. Some of it comes
> > from the fact that some objects are reused. Instead of the usual,
> > create-use-release, they get repurposed to be associated with
> > something else. When looking at such an object from some paths, we
> > don't necessarily have ownership of all of the members.
> 
> That's horrid, it's not like block devices are on some "fast path" for
> tear-down, we should do it correctly.

Yeah, it got retrofitted umpteenth times from the really early days. I
don't think much of it is intentionally designed to be this way.

> > > backing_device_info?  Are these being destroyed/used so often that rcu
> > > really is the best solution and the existing reference counting doesn't
> > > work properly?
> > 
> > It's more that there are entry points which can only ensure that just
> > the top level object is valid and the member objects might be going or
> > coming as we're looking at it.
> 
> That's not ok, a "member object" can only be valid if you have a
> reference to it.  If you remove the object, you then drop the reference,
> shouldn't that be the correct thing to do?

I mean, it depends. There are two layers of objects and the top level
object has two stacked lifetime rules. The "active" usage pins
everything as usual. The "shallower" usage only has full access to the
top level and when it reaches down into members it needs a different
mechanism to ensure its validity. Given a clean slate, I don't think
we'd go for this design for these objects but the usage isn't
fundamentally broken.

Idk, for the problem at hand, the choice is between patching it up by
copying the name and RCU protecting ->dev access at least for now.
Both are nasty in their own ways but copying does have a smaller blast
radius. So, copy for now?

Thanks.

-- 
tejun
