Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE6D965A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 17:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbfHTPzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 11:55:03 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42641 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730510AbfHTPzD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:55:03 -0400
Received: by mail-pl1-f193.google.com with SMTP id y1so2952113plp.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2019 08:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=//QQ1ht+tfIE4padC2Q4HKNAwrbhTDJJQX8waDwKAjk=;
        b=VQmitB5v4y5q/rJdoXEU3q0jb4QaW0EmJBEezy3BWQDoDxCU4sXzkvbo5rguMaOy9B
         R0S0gnMJXQzkOHRlX9ySUTvkaUgyz6TkSBKI/CBL4ThTCpjpgB1EZXA4pBTOI6vwsn5C
         ZrPrPydAcm6vyYibW/o6W47x08xvkfeF1cXEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=//QQ1ht+tfIE4padC2Q4HKNAwrbhTDJJQX8waDwKAjk=;
        b=BYzJv+V19LptipcxZjFIbn90mSr69lPQK9WLmGCVtMDZUf+XPeTuMbk/n1WIsfUOjA
         TeotRRROYVCvuiUg03cx1uyOTlPFaaBwQ0+AbVyLTUVOapTlLgtXEnF9FjnTYWdQIebV
         QxypF7WDLVJ5LFATTtUZ1xomPGt3KENVyJTpSCblwerO10PR/ghoYK0CppDmanVBbf5g
         mswLPIxtU2lTxvNoPJfBNfLgqXnD1XLAKonhhaf9RispVwhIaGMcsp9Ocv+DQZhCDJvf
         JTgkXV6qrXvSW9pzaTbgCLnrIg/bkIU2Q1r+NfV9GZgd5xUdf3vVlx9sCcqL7dSOr22q
         aFUQ==
X-Gm-Message-State: APjAAAUjf36hU1zBaCiifUJ1H7ZwjEQphhAt1YFAKo6pDvTE6Hx+XJeZ
        r15D44lI65X6+Aso59it00eDHw==
X-Google-Smtp-Source: APXvYqwv29npnp3S1cUOa4oSbGNTjYfsnr9tFYIb6WC009cJCEBGo+6fpxgThTkzC9broAD99z/Clw==
X-Received: by 2002:a17:902:848c:: with SMTP id c12mr26869867plo.47.1566316501842;
        Tue, 20 Aug 2019 08:55:01 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id g8sm16705907pgk.1.2019.08.20.08.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 08:55:00 -0700 (PDT)
Subject: Re: [PATCH 3/3] firmware: add mutex fw_lock_fallback for race
 condition
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org
References: <20190816000945.29810-1-scott.branden@broadcom.com>
 <20190816000945.29810-4-scott.branden@broadcom.com>
 <20190819053937.GR16384@42.do-not-panic.com>
 <16823ee6-c52a-b3b5-caed-79c00772fa68@broadcom.com>
 <20190820012655.GU16384@42.do-not-panic.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <76fac608-427e-b039-61d4-4ef35ac95715@broadcom.com>
Date:   Tue, 20 Aug 2019 08:54:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820012655.GU16384@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Luis,

I'm glad you are a subject expert in this area.

Some more comments inline.


On 2019-08-19 6:26 p.m., Luis Chamberlain wrote:
> On Mon, Aug 19, 2019 at 09:19:51AM -0700, Scott Branden wrote:
>> To be honest, I find the entire firmware code sloppy.
> And that is after years of cleanup on my part. Try going back to v4.1
> for instance, check the code out then for an incredible horrific sight :)
>
>> I don't think the cache/no-cache feature is
>> implemented or tested properly nor fallback to begin with.
> I'm in total agreement! I *know* there must be holes in that code, and I
> acknowledge a few possible gotchas on the commit logs. For instance, I
> acknowledged that the firmware cache had a secondary purpose which was
> not well documented or understood through commit e44565f62a720
> ("firmware: fix batched requests - wake all waiters"). The firmware
> cache allows for batching requests and sharing the same original request
> for multiple consecutive requests which *race against each other*.
> That's when I started having my doubts about the architecture of the
> firmware cache mechanism, it seemed too complex and perhaps overkill
> and considered killing it.

Great (kill it!).  I have no need for cached or batched requests.

The would remove a lot of problems.

>
> As I noted in that commit, the firmware cache is used for:
>      
> 1) Addressing races with file lookups during the suspend/resume cycle by
> keeping firmware in memory during the suspend/resume cycle
> 	
> 2) Batched requests for the same file rely only on work from the first
> file lookup, which keeps the firmware in memory until the last
> release_firmware() is called
>
> Also worth quoting from that commit as well:
>
> "Batched requests *only* take effect if secondary requests come in
> prior to the first user calling release_firmware(). The devres name used
> for the internal firmware cache is used as a hint other pending requests
> are ongoing, the firmware buffer data is kept in memory until the last
> user of the buffer calls release_firmware(), therefore serializing
> requests and delaying the release until all requests are done."
>
> Later we discovered that the firmware cache had a serious security issue
> since its inception through commit 422b3db2a503 ("firmware: Fix security
> issue with request_firmware_into_buf()"). Granted, exploiting this would
> require the ability to load kernel code, so the vector of exploitation
> is rather small.
>
> The cache stuff cannot be removed as it *at least* resolves the fw
> suspend stuff, but still, this can likely use a revisit in rachitecture
> long term. The second implicit use case for batched requests however
> seems complex and not sure if its worth to maintain. I'll note that
> at least some drivers *do* their own firmware caching, iwlwifi, is one,
> so there is an example there to allow drivers to say "I actually don't
> need caching" for the future.
>
> If you're volunteering to cleaning / testing the cache stuff I highly
> welcome that.

I would only volunteer to remove it, not test or support it.

>   That and the fallback stuff has been needing testing for
> years. Someoone was working on patches on the test case for cache stuff
> a while ago, from Intel, but they disappeared.
Again, I would only volunteer to remove the fallback mechanism to remove 
added race conditions.
>> I'm not claiming this patch is the final
>> solution and indicated such in the cover letter and the comment above.
> I missed that sorry.
>
>> I hope there is someone more familiar with this code to comment further and
>> come up with a proper solution.
> Alright, I'll dig in and take a look, and propose an alternative.
>
>> I have found numerous issues and race conditions with the firmware code (I
>> simply added a test).
> That is nothing compared to the amount of fixes I have found and
> actually fixed too, the code was a nightmare before I took on
> maintenance.
>
>> 1) Try loading the same valid firmware using no-cache once it has already
>> been loaded with cache.
> :)
>
>> It won't work, which is why I had to use a different filename in the test
>> for request_firmware_into_buf.
> Alright, I'll go try to fix this. Thanks for the report.

I think it's a minor issue compared to the race conditions present.

In reality I don't think anyone will load the same firmware using cache vs.

no-cache.

It's just something I stumbled upon when adding the test case and then 
had to avoid.

>
>> 2) Try removing the "if (opt_flags & FW_OPT_NOCACHE)" in my patch and always
>> call the mutex.
>>
>> The firmware test will lock up during a "no uevent" test.  I am not familiar
>> with the code to
>>
>> know why such is true and what issue this exposes in the code.
> I hinted in my review of the oops what the issue was.

I don't know if it's the same bug for the "no uevent" test case though?  
The test

just hangs and the kernel oops is not present.  It might be exposing another

underlying issue with the request_firmware code.

>
>> 3) I have a driver that uses request_firmware_into_buf and have multiple
>> instances of the driver
> Cool, is the driver upstream?

I'm working on cleaning up the driver right now to upstream.

First thing is I need the request_firmware_into_buf tests accepted upstream.

Then I can add my enhancement to request_firmware_into_buf to partial 
read the file (previous sent out but needed test case).

In order to do so Greg K-H required a test case for this but even the 
current API had no test.

In that patch series I can then add the new driver which requires my 
enhanced request_firmware_into_buf.

>
>> loading the same firmware in parallel.  Some of the data is not read
>> correctly in each instance.
> Makes perfect sense considering the lack of testing I noted.
>
>> I haven't yet to reproduce this issue with the firmware test
> That's because of batched firmware request mechanism.

Is there a way to not use the batch firmware request mechanism when 
calling request_firmware_into_buf

to see if the problem doesn't happen?

>
>> but currently
>> have a mutex around the entire
>> call to request_firmware_into_buf in our driver.
> I will take a look at this now.
>
>> Perhaps it is better at this point to add a mutex in
>> request_firmware_into_buf to make is entirely safe?
> No, that is not sufficient, although it would also solve the
> issue.

I don't have another solution with all the other mechanisms in

play in the current firmware code.  For now I'll leave the mutex

in the driver I'm upstreaming so it works reliably.

>
>> (Perhaps even with every request_firmware functions as none seems to be
>> tested properly.)
> No, you are incorrect. The other firmware API calls *have* been
> elaborately tested. The firmware cache stuff *is a mess* however,
> since we *use and support it*, I've done my best to salvage it and
> document it.

OK, I don't use any of the other mechanisms right now.

All I require is request_firmware_into_buf.

>
> I'll take a look at this and propose an alternative solution.
>
>    Luis
