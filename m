Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D2D2DB016
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 16:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgLOPa0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 10:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbgLOPa0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:30:26 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F34C06179C
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 07:29:40 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id 2so19572577ilg.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 07:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B+sJF9O+7miYMb+r/bO8h5xNuaUMdk+wtJSpSyfMQlE=;
        b=PAgFE3wl/FOWGnIuzTAh+EnYYXwgGINS1WPnzi3ESXg46NMl+gQQk7RY12RAA97usQ
         t5SFEOkqsIq4daXXA4RLiJJENGsul/p5cBAph5QTbD5bKnVKdtlr1jPLVwHV3SK00ZMR
         K4yfm00ulCy1g31aRCJKU8JnLvzEdzkigg1fvpnfVfJ+m8yQZsnZay6DM6SYtyyY4dMu
         i4d7yUftk8ZdQx6BZ/EqZeyB/dDAoCHOw6P3vTliNagmUw+2DiTeNctjBjxIjjGyUC7t
         ZfZ0bsn/0TBlQPeb8zY0fDMEMN+515+o3nZE2baSLrHWKNazATk8ejwoAW2aS/i1gACc
         t5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B+sJF9O+7miYMb+r/bO8h5xNuaUMdk+wtJSpSyfMQlE=;
        b=G2gh99yEbSoweHxY6VlwTrN4DCSMG8lQ/Namf8fC9kiJj7m+3fkbK/vaqEogm4HQXn
         7l7aBLONbP2UWoF/nKW8gBJWB8g9HrR3n7IVhbghnyCyWe3MGS7Om6ZYF1t2ObUmXePu
         mYpdYf+96eUtyKO3zRZHTqFuK1TMj4GQhIHlQIJ/OuY7erKm615PkdErD7DCrm7N7dX7
         42DDBlr0ptqdzbfWEdUun51y8CuDuVRHCwsm6HSvL/RYzFQtqZ6sEhrg3tXiuD3FMYWl
         5aILy4RGHErthpjvLjn4AUbPSUscOEScvcqaFTmO+x1PLDs+VmDtJKSeT2oB7R8X9aZu
         s4zg==
X-Gm-Message-State: AOAM533/bWLY6pMI+C7dd6/tjwXiAa+2huwMeQD6aNLhBJ0GIlBo+b02
        sVogDUgHXXz2wQROkYsHh+vZ8pEUjkEaHg==
X-Google-Smtp-Source: ABdhPJxCWGjQHZlinwsUT1WgINGMUW90ggpPp42fA2tQS0fiLmI+VDcLv1YB2OaASPpKuEvO2todnw==
X-Received: by 2002:a05:6e02:68f:: with SMTP id o15mr42595676ils.93.1608046179633;
        Tue, 15 Dec 2020 07:29:39 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q5sm13368841ilg.62.2020.12.15.07.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 07:29:39 -0800 (PST)
Subject: Re: [PATCH 2/4] fs: add support for LOOKUP_NONBLOCK
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
References: <20201214191323.173773-1-axboe@kernel.dk>
 <20201214191323.173773-3-axboe@kernel.dk>
 <20201215122447.GQ2443@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <75e7d845-2bd0-5916-ad45-fb84d9649546@kernel.dk>
Date:   Tue, 15 Dec 2020 08:29:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201215122447.GQ2443@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/15/20 5:24 AM, Matthew Wilcox wrote:
> On Mon, Dec 14, 2020 at 12:13:22PM -0700, Jens Axboe wrote:
>> +++ b/fs/namei.c
>> @@ -686,6 +686,8 @@ static bool try_to_unlazy(struct nameidata *nd)
>>  	BUG_ON(!(nd->flags & LOOKUP_RCU));
>>  
>>  	nd->flags &= ~LOOKUP_RCU;
>> +	if (nd->flags & LOOKUP_NONBLOCK)
>> +		goto out1;
> 
> If we try a walk in a non-blocking context, it fails, then we punt to
> a thread, do we want to prohibit that thread trying an RCU walk first?
> I can see arguments both ways -- this may only be a temporary RCU walk
> failure, or we may never be able to RCU walk this path.

In my opinion, it's not worth it trying to over complicate matters by
handling the retry side differently. Better to just keep them the
same. We'd need a lookup anyway to avoid aliasing.

-- 
Jens Axboe

