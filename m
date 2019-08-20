Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDCB29535B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 03:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbfHTB07 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 21:26:59 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33627 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbfHTB06 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 21:26:58 -0400
Received: by mail-pl1-f195.google.com with SMTP id go14so1844806plb.0;
        Mon, 19 Aug 2019 18:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1f+qnxuSTkrKhQhWKPw8r3KGzNHzDoVDPUhIrlUlE4U=;
        b=ZBtQCObjsYU8plmwtDPelF7jsZrSpaLaLe6lBEeeieODGofikgi93DLlwvPMAJTUfT
         xxSipbrf4cAH+w6Gt/v2apc4UeDO+AV3auZctNowiflnI1SV2jnwmTNu117p7R3PT69i
         41bAews7H4PTuBjBFAvPCSXfto3JbFTtwxGImlR1LqyTiN6U83WE8P3h7mJ5HBusyWxW
         RFNTht19ngrU9/b50Z1YRiSL7gbnqBRcklE057Y2HjlVZxJSFhA7HpdZUWHUQBd5T3ET
         /xqAXJDrQf8k1x3B7X5+7V4DcCZAZENn3PLUjK/SinHsQfA3qEKkFupgAqIzQpHyMpP+
         beyA==
X-Gm-Message-State: APjAAAWZFyG4vVU8fpNp/PXqI6F7s7KQcHFHQeSuKOuGuUMW1xDyr9iO
        MAmhqZFQj6wJAhRDdHiBmIGuaWbf
X-Google-Smtp-Source: APXvYqwqmd8RfIeVgvfWwDKTWUaFR0bqyFGd+0cynJ08MQsmabbIYy4tspHV9X9PTCioiALEkqHmag==
X-Received: by 2002:a17:902:2f43:: with SMTP id s61mr9505645plb.22.1566264417657;
        Mon, 19 Aug 2019 18:26:57 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id j9sm18162084pfe.103.2019.08.19.18.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 18:26:56 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 87CAF4035F; Tue, 20 Aug 2019 01:26:55 +0000 (UTC)
Date:   Tue, 20 Aug 2019 01:26:55 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Scott Branden <scott.branden@broadcom.com>
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
Subject: Re: [PATCH 3/3] firmware: add mutex fw_lock_fallback for race
 condition
Message-ID: <20190820012655.GU16384@42.do-not-panic.com>
References: <20190816000945.29810-1-scott.branden@broadcom.com>
 <20190816000945.29810-4-scott.branden@broadcom.com>
 <20190819053937.GR16384@42.do-not-panic.com>
 <16823ee6-c52a-b3b5-caed-79c00772fa68@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16823ee6-c52a-b3b5-caed-79c00772fa68@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 19, 2019 at 09:19:51AM -0700, Scott Branden wrote:
> To be honest, I find the entire firmware code sloppy.

And that is after years of cleanup on my part. Try going back to v4.1
for instance, check the code out then for an incredible horrific sight :)

> I don't think the cache/no-cache feature is
> implemented or tested properly nor fallback to begin with.

I'm in total agreement! I *know* there must be holes in that code, and I
acknowledge a few possible gotchas on the commit logs. For instance, I
acknowledged that the firmware cache had a secondary purpose which was
not well documented or understood through commit e44565f62a720
("firmware: fix batched requests - wake all waiters"). The firmware
cache allows for batching requests and sharing the same original request
for multiple consecutive requests which *race against each other*.
That's when I started having my doubts about the architecture of the
firmware cache mechanism, it seemed too complex and perhaps overkill
and considered killing it.

As I noted in that commit, the firmware cache is used for:
    
1) Addressing races with file lookups during the suspend/resume cycle by
keeping firmware in memory during the suspend/resume cycle
	           
2) Batched requests for the same file rely only on work from the first
file lookup, which keeps the firmware in memory until the last
release_firmware() is called

Also worth quoting from that commit as well:

"Batched requests *only* take effect if secondary requests come in
prior to the first user calling release_firmware(). The devres name used
for the internal firmware cache is used as a hint other pending requests
are ongoing, the firmware buffer data is kept in memory until the last
user of the buffer calls release_firmware(), therefore serializing
requests and delaying the release until all requests are done."

Later we discovered that the firmware cache had a serious security issue
since its inception through commit 422b3db2a503 ("firmware: Fix security
issue with request_firmware_into_buf()"). Granted, exploiting this would
require the ability to load kernel code, so the vector of exploitation
is rather small.

The cache stuff cannot be removed as it *at least* resolves the fw
suspend stuff, but still, this can likely use a revisit in rachitecture
long term. The second implicit use case for batched requests however
seems complex and not sure if its worth to maintain. I'll note that
at least some drivers *do* their own firmware caching, iwlwifi, is one,
so there is an example there to allow drivers to say "I actually don't
need caching" for the future.

If you're volunteering to cleaning / testing the cache stuff I highly
welcome that. That and the fallback stuff has been needing testing for
years. Someoone was working on patches on the test case for cache stuff
a while ago, from Intel, but they disappeared.

> I'm not claiming this patch is the final
> solution and indicated such in the cover letter and the comment above.

I missed that sorry.

> I hope there is someone more familiar with this code to comment further and
> come up with a proper solution.

Alright, I'll dig in and take a look, and propose an alternative.

> I have found numerous issues and race conditions with the firmware code (I
> simply added a test).

That is nothing compared to the amount of fixes I have found and
actually fixed too, the code was a nightmare before I took on
maintenance.

> 1) Try loading the same valid firmware using no-cache once it has already
> been loaded with cache.

:) 

> It won't work, which is why I had to use a different filename in the test
> for request_firmware_into_buf.

Alright, I'll go try to fix this. Thanks for the report.

> 2) Try removing the "if (opt_flags & FW_OPT_NOCACHE)" in my patch and always
> call the mutex.
> 
> The firmware test will lock up during a "no uevent" test.  I am not familiar
> with the code to
> 
> know why such is true and what issue this exposes in the code.

I hinted in my review of the oops what the issue was.

> 3) I have a driver that uses request_firmware_into_buf and have multiple
> instances of the driver

Cool, is the driver upstream?

> loading the same firmware in parallel.  Some of the data is not read
> correctly in each instance.

Makes perfect sense considering the lack of testing I noted.

> I haven't yet to reproduce this issue with the firmware test 

That's because of batched firmware request mechanism.

> but currently
> have a mutex around the entire
> call to request_firmware_into_buf in our driver.

I will take a look at this now.

> Perhaps it is better at this point to add a mutex in
> request_firmware_into_buf to make is entirely safe?

No, that is not sufficient, although it would also solve the
issue.

> (Perhaps even with every request_firmware functions as none seems to be
> tested properly.)

No, you are incorrect. The other firmware API calls *have* been
elaborately tested. The firmware cache stuff *is a mess* however,
since we *use and support it*, I've done my best to salvage it and
document it.

I'll take a look at this and propose an alternative solution.

  Luis
