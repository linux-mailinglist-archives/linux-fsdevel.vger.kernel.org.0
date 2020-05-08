Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545181CB4FD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 18:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgEHQ3q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 12:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgEHQ3q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 12:29:46 -0400
X-Greylist: delayed 14776 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 May 2020 09:29:45 PDT
Received: from forwardcorp1p.mail.yandex.net (forwardcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5600C061A0C;
        Fri,  8 May 2020 09:29:45 -0700 (PDT)
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id A02312E1489;
        Fri,  8 May 2020 19:29:41 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id 79lEU9qBfi-TeWmumsJ;
        Fri, 08 May 2020 19:29:41 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1588955381; bh=jmR/DsNk+b5hvFTl8iWVW5V6hZXuHrGwKPYXyFBJJ6c=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=G22ceIVJgcTLXW32v7RDdWj71AvNDdzYWSFqTWcdPKxlh1t8KvA2HhLLWAxZKWWlR
         /nQgf10nznYePpe1EiEIsyWb+zqOd7hnbo6WECRHMRzZtZVmYJlLbe1AA+XFjcypRs
         Nab5knMpKr66+N1FZPVzCuKUjIm/jymF5v5XumXk=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:7008::1:4])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id Fvbdd2NnKu-TeW8lndv;
        Fri, 08 May 2020 19:29:40 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH RFC 8/8] dcache: prevent flooding with negative dentries
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Waiman Long <longman@redhat.com>
References: <158893941613.200862.4094521350329937435.stgit@buzz>
 <158894061332.200862.9812452563558764287.stgit@buzz>
 <20200508145659.GQ16070@bombadil.infradead.org>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <be7ae157-9c87-7ee7-e669-f1eb448b0cbf@yandex-team.ru>
Date:   Fri, 8 May 2020 19:29:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508145659.GQ16070@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08/05/2020 17.56, Matthew Wilcox wrote:
> On Fri, May 08, 2020 at 03:23:33PM +0300, Konstantin Khlebnikov wrote:
>> This patch implements heuristic which detects such scenarios and prevents
>> unbounded growth of completely unneeded negative dentries. It keeps up to
>> three latest negative dentry in each bucket unless they were referenced.
>>
>> At first dput of negative dentry when it swept to the tail of siblings
>> we'll also clear it's reference flag and look at next dentries in chain.
>> Then kill third in series of negative, unused and unreferenced denries.
>>
>> This way each hash bucket will preserve three negative dentry to let them
>> get reference and survive. Adding positive or used dentry into hash chain
>> also protects few recent negative dentries. In result total size of dcache
>> asymptotically limited by count of buckets and positive or used dentries.
>>
>> This heuristic isn't bulletproof and solves only most practical case.
>> It's easy to deceive: just touch same random name twice.
> 
> I'm not sure if that's "easy to deceive" ... My concern with limiting
> negative dentries is something like a kernel compilation where there
> are many (11 for mm/mmap.c, 9 in general) and there will be a lot of
> places where <linux/fs.h> does not exist
> 
> -isystem /usr/lib/gcc/x86_64-linux-gnu/9/include
> -I../arch/x86/include
> -I./arch/x86/include/generated
> -I../include
> -I./include
> -I../arch/x86/include/uapi
> -I./arch/x86/include/generated/uapi
> -I../include/uapi
> -I./include/generated/uapi
> -I ../mm
> -I ./mm
> 
> So it'd be good to know that kernel compilation times are unaffected by
> this patch.
> 

It's very unlikely that this patches changes anything for compilation.
Or any other scenario with sane amount and rate of appearing new names.

This trims only dentries which never been accessed twice.
Keeping 3 dentries per bucket gives high chances that all of them get
reference bit and stay in cache until shrinker bury them.

To get false positive in this heuristic - multiple newly created
negative dentries must hit one bucket in short period of time.
I.e. at least three hash collisions is required.
