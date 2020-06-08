Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A091F1668
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 12:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgFHKIb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 06:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbgFHKI2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 06:08:28 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85836C08C5C3
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2020 03:08:28 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id o15so17580699ejm.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2020 03:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dxkh4Kxm2qSluY2udt9pCB1rYALSYeqASDMTt8TKeJI=;
        b=P2GKu52WItZEgtpoUj18LxtU7AgqM5FVRJdGi3TUv/5Lg5xZFomT3eHPBzOMyvALk/
         7GBsEJETXvfGLn1q9PletcojWdFGb/np1KH7hyORWeAS3kHqADvoXOqPq95AqxdRlUJA
         GaFPC0TkTjGiwkE6mp/dO9Rsmt7YCy68d6pG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dxkh4Kxm2qSluY2udt9pCB1rYALSYeqASDMTt8TKeJI=;
        b=pcazUOwzwKFoN6ZmKdx0bBdDpnvi5fPjXiZP/WtqpIQqeYan97HqOocODTHhVM7dg2
         nFNB1hqrMIdfTyJZomSqekJP8NDodw2IVz4GCf9fhc8c46ItMzY5eZx9t2m6rHa23gSC
         TpZtRHEPLriETaDTkH0PHa3JIYI18azk7k0v8C0LrToSN2HWbB5lprZe4lTHbMkUAOXH
         7rhDnmmILJGYqBFbxp59VDEO/vL6k4qzuTQEScZPDbseJn/SiwFw+rnhNG7EZA8tsUQB
         dhTR4Z82T7/+Ly4rtjrvONrxxo2Q2FS/kzV21gWWRE9g3oyRQjAFRLO9YJMADwRoFAzL
         DvOw==
X-Gm-Message-State: AOAM530fVU6k4buJhVS3KCAPD7dhrwqCwVpGRdJ2sVQC7Fxk/5DhBLuq
        LImI6/KjcyDnbnGdtwFkBahQgg==
X-Google-Smtp-Source: ABdhPJxAg8FdGBWitx0l/Pw7yBtDmw4KoAgFhWNXk8/GC/u/FjggasbaZA/r5dcLa09kW4fP8S4wiA==
X-Received: by 2002:a17:906:945:: with SMTP id j5mr10235625ejd.52.1591610907139;
        Mon, 08 Jun 2020 03:08:27 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-116-45.cgn.fibianet.dk. [5.186.116.45])
        by smtp.gmail.com with ESMTPSA id d6sm12581189edn.75.2020.06.08.03.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 03:08:26 -0700 (PDT)
Subject: Re: [PATCH resend] fs/namei.c: micro-optimize acl_permission_check
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200605142300.14591-1-linux@rasmusvillemoes.dk>
 <CAHk-=wgz68f2u7bFPZCWgbsbEJw+2HWTJFXSg_TguY+xJ8WrNw@mail.gmail.com>
 <dcd7516b-0a1f-320d-018d-f3990e771f37@rasmusvillemoes.dk>
 <CAHk-=wixdSUWFf6BoT7rJUVRmjUv+Lir_Rnh81xx7e2wnzgKbg@mail.gmail.com>
 <CAHk-=widT2tV+sVPzNQWijtUz4JA=CS=EaJRfC3_9ymuQXQS8Q@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <934d7665-3358-576e-8434-82b16e3a1bf1@rasmusvillemoes.dk>
Date:   Mon, 8 Jun 2020 12:08:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=widT2tV+sVPzNQWijtUz4JA=CS=EaJRfC3_9ymuQXQS8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/06/2020 21.48, Linus Torvalds wrote:
> On Sun, Jun 7, 2020 at 9:37 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>>> That will kinda work, except you do that mask &= MAY_RWX before
>>> check_acl(), which cares about MAY_NOT_BLOCK and who knows what other bits.
>>
>> Good catch.
> 
> With the change to not clear the non-rwx bits in general, the owner
> case now wants to do the masking, and then the "shift left by 6"
> modification makes no sense since it only makes for a bigger constant
> (the only reason to do the shift-right was so that the bitwise not of
> the i_mode could be done in parallel with the shift, but with the
> masking that instruction scheduling optimization becomes kind of
> immaterial too). So I modified that patch to not bother, and add a
> comment about MAY_NOT_BLOCK.
> 
> And since I was looking at the MAY_NOT_BLOCK logic, it was not only
> not mentioned in comments, it also had some really confusing code
> around it.
> 
> The posix_acl_permission() looked like it tried to conserve that bit,
> which is completely wrong. It wasn't a bug only for the simple reason
> that the only two call-sites had either explicitly cleared the bit
> when calling, or had tested that the bit wasn't set in the first
> place.
> 
> So as a result, I wrote a second patch to clear that confusion up.
> 
> Rasmus, say the word and I'll mark you for authorship on the first one.

It might be a bit confusing with me mentioned in the third person and
then also author, and it's really mostly your patch, so reported-by is
fine with me. But it's up to you.

> Comments? Can you find something else wrong here, or some other fixup to do?

No, I think it's ok. I took a look at the disassembly and it looks fine.
There's an extra push/pop of %r14 [that's where gcc computes mode>>3,
then CSE allows it to do cmovne %r14d,%ebx after in_group_p), so the
owner case gets slightly penalized. I think/hope the savings from
avoiding the in_group_p should compensate for that - any absolute path
open() by non-root saves at least two in_group_p. YMMV.

Rasmus
