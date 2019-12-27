Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8F4812B121
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2019 06:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbfL0FFE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Dec 2019 00:05:04 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43469 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfL0FFE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Dec 2019 00:05:04 -0500
Received: by mail-pf1-f195.google.com with SMTP id x6so13108756pfo.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2019 21:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ixH5wLpvspwAlmlrItQGB8OewSOlIrNFbX3ewy9ibIA=;
        b=PToCvCD9t5UPFFYuqgUMxPK5etjop/oUvcCtxuAKhu/aN1gtW1sBsHZBJyQnbiDfDp
         ck8h1kfJ87s3MPOchCSrqTBOGUZnO7YTzEokAkKqVIDBHPm7xqc+MQBA98Z17TypJq/K
         93LjB5GdvX5FvI94pxd3IzJMT+KXMfm5eSHNrN+JbGo6ezLhKkHtSGUcaz7Mm2c9duez
         3FnY6himTXIu/UDVxiaRt76FNVhdCNc+FNnV/6yk++3oDX08zWKjoQPxkiGqqiPdHkFV
         dlZu8ITV0MZ0hZaWSWGOo+y6sucixGVhFNf/MGfaLLUCtxeG48woyrd4n3IbxfjHA+pq
         j7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ixH5wLpvspwAlmlrItQGB8OewSOlIrNFbX3ewy9ibIA=;
        b=pBWwl4brID+LIPybVjMBEEZ697OOFbRUAeIiaB2PLgXXhLm9CWkzHDbpd3FijTEJyM
         xY3npMmZ8Mb0WSfj6EH5FUYnWebeT4pUSst+ApeRHs5Qve8m4V5PlRkxWjrjNsPPUb6Q
         DxX3nhI8Fprhq0QA4zJ2kNErFxtKVIVGXOPi5wZXRb9Cniy1IVNcXs3dYia7eBky7DWV
         V6QT16PFvpty2HhctwxkfTj4lIxjGuxtU2WI0KTCJYIXGFad5Uwx7LcNWd3vk3UgGQ1A
         kdIKHw2O2zthgNbXFVtDF9U3GRvlrobw3C+ketRuD5DdxnWUlIFvVaVUDyhc2MuMt2D/
         P2Ow==
X-Gm-Message-State: APjAAAURHqYxns1G5/GUGquT+ZLklOYjCtwCsjnsxeo3C/BipK+y9eCT
        zLtEVqUVesuh0HAOmvTQMPor6cc3AcNCAA==
X-Google-Smtp-Source: APXvYqzBzbGzHwfGRJ2qNbG/NF8sjn6lJI0JPsNvXwN30mB5e1RW6yT4WW+XFYOEmY+RiA2qDfYQFA==
X-Received: by 2002:a65:4d46:: with SMTP id j6mr53715874pgt.63.1577423102001;
        Thu, 26 Dec 2019 21:05:02 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id b2sm12493519pjq.3.2019.12.26.21.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2019 21:05:01 -0800 (PST)
Subject: Re: [PATCH 03/10] fs: add namei support for doing a non-blocking path
 lookup
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20191213183632.19441-1-axboe@kernel.dk>
 <20191213183632.19441-4-axboe@kernel.dk>
 <20191227004206.GT4203@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <480c6bfb-a951-0f51-53ca-5ac63a38b1fc@kernel.dk>
Date:   Thu, 26 Dec 2019 22:05:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191227004206.GT4203@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/26/19 5:42 PM, Al Viro wrote:
> On Fri, Dec 13, 2019 at 11:36:25AM -0700, Jens Axboe wrote:
>> If the fast lookup fails, then return -EAGAIN to have the caller retry
>> the path lookup. This is in preparation for supporting non-blocking
>> open.
> 
> NAK.  We are not littering fs/namei.c with incremental broken bits
> and pieces with uncertain eventual use.

To be fair, the "eventual use" is just the next patch or two...

> And it's broken - lookup_slow() is *NOT* the only place that can and
> does block.  For starters, ->d_revalidate() can very well block and
> it is called outside of lookup_slow().  So does ->d_automount().
> So does ->d_manage().

Fair enough, so it's not complete. I'd love to get it there, though!

> I'm rather sceptical about the usefulness of non-blocking open, to be
> honest, but in any case, one thing that is absolutely not going to
> happen is piecewise introduction of such stuff without a discussion
> of the entire design.

It's a necessity for io_uring, otherwise _any_ open needs to happen
out-of-line. But I get your objection, I'd like to get this moving in a
productive way though.

What do you want it to look like? I'd be totally fine with knowing if
the fs has ->d_revalidate(), and always doing those out-of-line.  If I
know the open will be slow, that's preferable. Ditto for ->d_automount()
and ->d_manage(), all of that looks like cases that would be fine to
punt. I honestly care mostly about the cached local case _not_ needing
out-of-line handling, that needs to happen inline.

Still seems to me like the LOOKUP_NONBLOCK is the way to go, and just
have lookup_fast() -EAGAIN if we need to call any of the potentially
problematic dentry ops. Yes, they _may_ not block, but they could. I
don't think we need to propagate this information further.

-- 
Jens Axboe

