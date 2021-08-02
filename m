Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEA73DDFB5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 20:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhHBS7Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 14:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbhHBS7P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 14:59:15 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F244CC061764
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Aug 2021 11:59:04 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id z3so19421475plg.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Aug 2021 11:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ohR8MWK5z6tQgaHzKRw4z/9ZmwZHAJlnfek7VuSAWHE=;
        b=L2XLjUI8HeOqDyYuw9UZPUofbh1myp7tASYZwPPGk1eYrihjC7WlcdMVrBDbf5o8yt
         TblwUbG7lhiV1NGwUK4evO3ikpN8AHycGh6Wff5qujpld8ERJrhT8+HYFxsUw2WCDuyG
         FcamSDP7RkvedijB0Eva2Q8J6DHoorwAZdpAk+QN2Vv3iBmpzelHklnasHrdDcTWeX5h
         dCCZ//wqNcJ5NFdMhXRj/F8h4p/bEqpI2bKFc9yAW8XdriJZMrrIRrHNfKe9bE38XZyv
         GNjcTLQyN0QBTIuKPjzv0Wg4a8XhWKdK0mKVfhCxY0A5GEQYwRe+WwoHJ6L7NN6BiRAs
         lDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ohR8MWK5z6tQgaHzKRw4z/9ZmwZHAJlnfek7VuSAWHE=;
        b=Ou5ii8VqDmqIMAAULZefkSdxqUBZDlYf6Bv0ofzoatua0FLccUhcM7hxuzO0u85bkb
         0q4vuRqItJtIXLGtO3cJ6rMz6M3VLpi7/IclTI5joGxN4r0umaW/rpUo65S/NBXHnUx3
         T5lZ7j83EMuDcQ6d3gmfwCumBoIlj4GZTSjQIE0styIcTBR2pFz/GQQCZrUPf1Qr++e1
         D7O8y74kzJ3Zde5nwvRCWnJhG29berjqOsyJUumcQZ42/W/jXgqrsoZKeclBDAdGsNlU
         C4FMUpXs/f/wGQ6S54NCkfYzVBn14g/C4xkKPXSPFsIQ++pEjoyunbAmW+Y1xiWeYIh9
         baag==
X-Gm-Message-State: AOAM530myLTxxKe3CZ/tCppZGmmjqWw7fPFAHLz99gTk6XajQlca/zEi
        dtBW6N9aWCnIRKQmZhLpDxP5jg==
X-Google-Smtp-Source: ABdhPJw0PZIQU+a+lKpgEKgrBypeszyyvsh48xyNukQdoijIoZro31ZDTgCwHQ9cjrxbem1kEDfS7g==
X-Received: by 2002:a63:f145:: with SMTP id o5mr234562pgk.273.1627930744547;
        Mon, 02 Aug 2021 11:59:04 -0700 (PDT)
Received: from sspatil2.c.googlers.com (190.40.105.34.bc.googleusercontent.com. [34.105.40.190])
        by smtp.gmail.com with ESMTPSA id c14sm615337pjr.3.2021.08.02.11.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 11:59:04 -0700 (PDT)
Subject: Re: [PATCH 1/1] fs: pipe: wakeup readers everytime new data written
 is to pipe
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
References: <20210729222635.2937453-1-sspatil@android.com>
 <20210729222635.2937453-2-sspatil@android.com>
 <CAHk-=wh-DWvsFykwAy6uwyv24nasJ39d7SHT+15x+xEXBtSm_Q@mail.gmail.com>
 <cee514d6-8551-8838-6d61-098d04e226ca@android.com>
 <CAHk-=wjStQurUzSAPVajL6Rj=CaPuSSgwaMO=0FJzFvSD66ACw@mail.gmail.com>
 <CAHk-=wjrfasYJUaZ-rJmYt9xa=DqmJ5-sVRG7cJ2X8nNcSXp9g@mail.gmail.com>
From:   Sandeep Patil <sspatil@android.com>
Message-ID: <fc0e2c8a-96cc-7787-6866-3802a1d5c50e@android.com>
Date:   Mon, 2 Aug 2021 18:59:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjrfasYJUaZ-rJmYt9xa=DqmJ5-sVRG7cJ2X8nNcSXp9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/30/21 10:53 PM, Linus Torvalds wrote:
> On Fri, Jul 30, 2021 at 12:23 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> I'll mull it over a bit more, but whatever I'll do I'll do before rc4
>> and mark it for stable.
> 
> Ok, I ended up committing the minimal possible change (and fixing up
> the comment above it).
> 
> It's very much *not* the original behavior either, but that original
> behavior was truly insane ("wake up for each hunk written"), and I'm
> trying to at least keep the kernel code from doing actively stupid
> things.
> 
> Since that old patch of mine worked for your test-case, then clearly
> that realm-core library didn't rely on _that_ kind of insane internal
> kernel implementation details exposed as semantics. So The minimal
> patch basically says "each write() system call wil do at least one
> wake-up, whether really necessary or not".
> 
> I also intentionally kept the read side untouched, in that there
> apparently still isn't a case that would need the confused semantics
> for read events.
> 
> End result: the commit message is a lot bigger than the patch, with
> most of it being trying to explain the background.
> 
> I've pushed it out as commit 3a34b13a88ca ("pipe: make pipe writes
> always wake up readers"). Holler if you notice anything odd remaining.

Since what you merged isn't different than what I tested, I don't
expect any surprises but I will test it regardless. I will come back
if I see anything unexpected.

Thanks for the explanation about the default behavior earlier
in the thread.

- ssp
