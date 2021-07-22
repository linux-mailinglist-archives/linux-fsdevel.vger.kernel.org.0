Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97E93D1FD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 10:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhGVHsX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 03:48:23 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57386 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhGVHsX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 03:48:23 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A126420394;
        Thu, 22 Jul 2021 08:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626942537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJEk1owH52y6Qtju7I5k2CaWgV6Tg6KlHTHLAnNPcqk=;
        b=P+21jWwHuJeX3oA7YjaxJga00O7zvBY5ysftiiH2+8rybxc8//yr4cf16a8EXLUpQTzUgQ
        bzJaN+NLzzACURhUqwAFSXCK3p8MP8At1CNhNxGKm64R0QEqzNQ0UbOJIFuAtXdM3z7l69
        kb1QgfFQKjomIDnwkC1AyG9/v9T6WG8=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5A0DF13889;
        Thu, 22 Jul 2021 08:28:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id K8gmEkks+WBcFwAAGKfGzw
        (envelope-from <nborisov@suse.com>); Thu, 22 Jul 2021 08:28:57 +0000
Subject: Re: [PATCH] lib/string: Bring optimized memcmp from glibc
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
References: <20210721135926.602840-1-nborisov@suse.com>
 <CAHk-=whqJKKc9wUacLEkvTzXYfYOUDt=kHKX6Fa8Kb4kQftbbQ@mail.gmail.com>
 <b24b5a9d-69a0-43b9-2ceb-8e4ee3bf2f17@suse.com>
 <CAHk-=wgMyXh3gGuSzj_Dgw=Gn_XPxGSTPq6Pz7dEyx6JNuAh9g@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <80b4bbe8-2394-cfbb-ace1-9402169f5131@suse.com>
Date:   Thu, 22 Jul 2021 11:28:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgMyXh3gGuSzj_Dgw=Gn_XPxGSTPq6Pz7dEyx6JNuAh9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 21.07.21 г. 21:45, Linus Torvalds wrote:
> On Wed, Jul 21, 2021 at 11:17 AM Nikolay Borisov <nborisov@suse.com> wrote:
>>
>> I find it somewhat arbitrary that we choose to align the 2nd pointer and
>> not the first.
> 
> Yeah, that's a bit odd, but I don't think it matters.
> 
> The hope is obviously that they are mutually aligned, and in that case
> it doesn't matter which one you aim to align.
> 
>> So you are saying that the current memcmp could indeed use improvement
>> but you don't want it to be based on the glibc's code due to the ugly
>> misalignment handling?
> 
> Yeah. I suspect that this (very simple) patch gives you the same
> performance improvement that the glibc code does.

You suspect correctly, perf profile:

30.44%    -29.38%  [kernel.vmlinux]         [k] memcmp

This is only on x86-64 as I don't have other arch handy. But this one is
definitely good.


