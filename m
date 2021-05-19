Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA7938848D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 03:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbhESBt1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 21:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbhESBt1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 21:49:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B5CC06175F;
        Tue, 18 May 2021 18:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=2NwcBNostJy1Ke+4ILrE7WCRyqgaMhj8wvJw1tgBdXo=; b=laSVCrf7d+Qxh5EkMKjosGES0G
        pwteEKfSfPf+boXbf11edzGJsdOfTgLX975fIPlODt3QbaMum89GsXNakjQ/jIspflPU+xnqoCcJj
        u9FU/dZDAkBzcxDYcVqAapXTLoR1yeCyFavP287XE7qxcCVKQGEFTuzaQFG1BA2oJTfnBE2l+ke/+
        fp8q0zMCYDSQfoCpqQY4RNSMWx7iBRM54kXgSjithDpNHEKTqAL2QAO0V+wu6TvlNwkDSM8rQSpFx
        yC/gv0FqcOn4aap92aUSrZbmQg1k4z9saOprvsBxhdj4mzPkHpyRXy9qze/5k1ZoxgcY81Ab7zO/p
        8CR1x5wQ==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ljBJf-00F4IC-92; Wed, 19 May 2021 01:48:07 +0000
Subject: Re: Fwd: [EXTERNAL] Re: ioctl.c:undefined reference to
 `__get_user_bad'
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>
References: <202105110829.MHq04tJz-lkp@intel.com>
 <a022694d-426a-0415-83de-4cc5cd9d1d38@infradead.org>
 <MN2PR21MB15184963469FEC9B13433964E42D9@MN2PR21MB1518.namprd21.prod.outlook.com>
 <CAH2r5mswqB9DT21YnSXMSAiU0YwFUNu0ni6f=cW+aLz4ssA8rw@mail.gmail.com>
 <d3e24342-4f30-6a2f-3617-a917539eac94@infradead.org>
 <5b29fe73-7c95-0b9f-3154-c053fa94cb67@infradead.org>
 <20210518100306.GS12395@shell.armlinux.org.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a4d4033e-aa90-a90a-73e0-bca673dd3071@infradead.org>
Date:   Tue, 18 May 2021 18:48:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210518100306.GS12395@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/18/21 3:03 AM, Russell King (Oracle) wrote:
> On Mon, May 17, 2021 at 02:06:33PM -0700, Randy Dunlap wrote:
>> [adding back linux-arm-kernel; what happened to it? ]

That was about what I thought was Steve F. dropping LAK on his response email.

> Nothing. I'm not interested in trying to do major disgusting
> contortions to make get_user() work for 8-byte values. If someone
> else wants to put the effort in and come up with an elegant solution
> that doesn't add warnings over the rest of the kernel, that's fine.
> 
> As far as I remember, everything in __get_user_err() relies on
> __gu_val _not_ being 64-bit. If we use the same trick that we do
> in __get_user_check():
> 
> 	__inttype(x) __gu_val = (x);
> 
> then if get_user() is called with a 64-bit integer value and a
> pointer-to-32-bit location to fetch from, we'd end up passing a
> 64-bit integer into the __get_user_asm() which could access the
> wrong 32-bit half of the value in BE mode. Similar issue with
> 64-bit vs pointer-to-16-bit.

Yes, trying to handle get_user() of size 8 bytes is quite messy.
I have a few versions and they are all ugly and cause build warnings.

So we are down to what bugzilla calls WONTFIX. I'm OK with that.

Thanks.

-- 
~Randy

