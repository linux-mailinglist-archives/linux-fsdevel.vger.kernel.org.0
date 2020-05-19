Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388E21D9346
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 11:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgESJYv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 05:24:51 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17131 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726358AbgESJYv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 05:24:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589880226; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=rPLf6BZXNRwRygrVTWWcl6Kh4ruisNl/lO5H0X5Eiz2p+OWd/AFJblw8f5TMl6R1SJ0lK79wpR6ezeoNc3Ai60JJWVzlSetQiLGl3vZtGR6VMsjxxa3hbZ2l8nRwnmvSp26rPFWz9NwZZvvAhmWmii5yjCcNDtrTsW5g2IYN98g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1589880226; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=faHruH5bAhzKqF04LUNXHwbBbdcKtjl3CA/Wbrii4WM=; 
        b=Nffl1eSaHxy2f77jcpp7juf9s74aUFcEACidQnFVVwaOll6cqccE4fEWA/3NUyVVcZKnCDIO+N2goaTzK3Zb9T/Ns7JGiucqv4pIGRTzu1iOIY4LolyYfC0P4KicLHCbXBzb7/khSgJe/oy0tcc1wnw9pZ+u2krXp7v6aUQcnRw=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1589880226;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=faHruH5bAhzKqF04LUNXHwbBbdcKtjl3CA/Wbrii4WM=;
        b=PknJ7I0Zh8bKBxWKec2ABB9yN4qQ9bAeJDP6NRXDeK6u/ey0cPTeMqGeY6WhxZE2
        lCDVGFOI2DfkPtHNnAZxQ3c3uKxGanYhNTh1tApreN+YhjrQFOovX0TX+QL0bzmTiJj
        2wr49+bP+srs6IURuZND61M9TgjOioajRaxjbwsc=
Received: from [192.168.166.138] (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 158988022399284.96793522637824; Tue, 19 May 2020 17:23:43 +0800 (CST)
Subject: Re: [RFC PATCH v3 0/9] Suppress negative dentry
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>, Ian Kent <raven@themaw.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
References: <20200515072047.31454-1-cgxu519@mykernel.net>
 <e994d56ff1357013a85bde7be2e901476f743b83.camel@themaw.net>
 <CAOQ4uxjT8DouPmf1mk1x24X8FcN5peYAqwdr362P4gcW+x15dw@mail.gmail.com>
 <CAJfpegtpi1SVJRbQb8zM0t66WnrjKsPEGEN3qZKRzrZePP06dA@mail.gmail.com>
 <05e92557-055c-0dea-4fe4-0194606b6c77@mykernel.net>
 <CAJfpegtyZw=6zqWQWm-fN0KpGEp9stcfvnbA7eh6E-7XHxaG=Q@mail.gmail.com>
From:   cgxu <cgxu519@mykernel.net>
Message-ID: <7fcb778f-ba80-8095-4d48-20682f5242a9@mykernel.net>
Date:   Tue, 19 May 2020 17:23:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJfpegtyZw=6zqWQWm-fN0KpGEp9stcfvnbA7eh6E-7XHxaG=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ZohoCNMailClient: External
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/19/20 4:21 PM, Miklos Szeredi wrote:
> On Tue, May 19, 2020 at 7:02 AM cgxu <cgxu519@mykernel.net> wrote:
>
>> If we don't consider that only drop negative dentry of our lookup,
>> it is possible to do like below, isn't it?
> Yes, the code looks good, though I'd consider using d_lock on dentry
> instead if i_lock on parent, something like this:
>
> if (d_is_negative(dentry) && dentry->d_lockref.count == 1) {
>      spin_lock(&dentry->d_lock);
>      /* Recheck condition under lock */
>      if (d_is_negative(dentry) && dentry->d_lockref.count == 1)
>          __d_drop(dentry)
>      spin_unlock(&dentry->d_lock);

And after this we will still treat 'dentry' as negative dentry and dput it
regardless of the second check result of d_is_negative(dentry), right?


> }
>
> But as Amir noted, we do need to take into account the case where
> lower layers are shared by multiple overlays, in which case dropping
> the negative dentries could result in a performance regression.
> Have you looked at that case, and the effect of this patch on negative
> dentry lookup performance?

The container which is affected by this feature is just take advantage
of previous another container but we could not guarantee that always
happening. I think there no way for best of both worlds, consider that
some malicious containers continuously make negative dentries by
searching non-exist files, so that page cache of clean data, clean
inodes/dentries will be freed by memory reclaim. All of those
behaviors will impact the performance of other container instances.

On the other hand, if this feature significantly affects particular 
container,
doesn't that mean the container is noisy neighbor and should be restricted
in some way?

Thanks,
cgxu

