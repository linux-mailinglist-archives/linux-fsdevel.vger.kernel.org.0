Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67B4218646
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 13:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgGHLhs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 07:37:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45004 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728410AbgGHLhr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594208265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rxAR+Kw/axdKF/TCqNjdsfSjlHFkHPAsJVvK3OHUYjI=;
        b=CNzWfH6hlWFFlQORH/IawAFOw+iVycD/WdY5rz0IO6iTpJkcD3qQ+SaIPzkcvxfC+TGiy2
        D0Hq/UlPwPIzv9Tjiyb+bOkUa3VdnFmCOIAFgZRv61ZbG01SPawbBxNe3Mlz+bhvAoGnaU
        Fn5PbEADInggfOloBTVEwsmTHOoKhAw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-_dyNEgCGPKyFlyyuYbiViw-1; Wed, 08 Jul 2020 07:37:44 -0400
X-MC-Unique: _dyNEgCGPKyFlyyuYbiViw-1
Received: by mail-ed1-f70.google.com with SMTP id v7so58735810ede.15
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 04:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rxAR+Kw/axdKF/TCqNjdsfSjlHFkHPAsJVvK3OHUYjI=;
        b=N1I6kr14XNDrUHon/LUBQdlQUAJpbJcSxFqFCTifTIlFzXjhCuBvlvrJFZARAxSyxb
         RkoLYR4gSvnXCrcaDqIIBWW7m1SNyN8gvK7HNUEkYFI+tbXeMuuX54jsmVfG772kISSP
         /RvG7KP1BV/a8cDJlZ/7bPCe6Ih0jW7FOtZH54z3SnfUhghh2W50Kk81IuwSlaOUs0zh
         3pFz5udLLg97nOAOM9xc8HXSanUiUwSdWpBMplj3ncV3DEwWCnkIORK3mXGFoo8iYvyB
         aSOrZz0lZ8czo1T0P/zOJGxCKs4DFLhDmZo8bJNx1ATW2BizHCCc+JoRDGaJViyXRZIX
         SrjA==
X-Gm-Message-State: AOAM530DpfN7zupl5yit0K4zhA2Uh8TtBLmvX2xjVIH8+pfGaBCCNIgo
        iVCuqMntliK9ZZNAy3+a70XKekZSBR40gx1VsR9FnueBXwFK7HFjs9dNfXlIEAjB00wQWbY6Bp6
        tE0vbzwMjnXUvHFbAx0WyXNG70Q==
X-Received: by 2002:a05:6402:2212:: with SMTP id cq18mr69893312edb.173.1594208263056;
        Wed, 08 Jul 2020 04:37:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFQtyOEY2W5LUe5OTc7kdacGkjqoMvojBBviDdKbmaUN+MOmxhCG02SRaFc3o68AfY0fdJ/w==
X-Received: by 2002:a05:6402:2212:: with SMTP id cq18mr69893277edb.173.1594208262871;
        Wed, 08 Jul 2020 04:37:42 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id u13sm1813113ejc.72.2020.07.08.04.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 04:37:42 -0700 (PDT)
Subject: Re: [PATCH 0/4] Fix misused kernel_read_file() enums
From:   Hans de Goede <hdegoede@redhat.com>
To:     Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200707081926.3688096-1-keescook@chromium.org>
 <3c01073b-c422-dd97-0677-c16fe1158907@redhat.com>
Message-ID: <f5e65f73-2c94-3614-2479-69b2bfda9775@redhat.com>
Date:   Wed, 8 Jul 2020 13:37:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <3c01073b-c422-dd97-0677-c16fe1158907@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 7/8/20 1:01 PM, Hans de Goede wrote:
> Hi,
> 
> On 7/7/20 10:19 AM, Kees Cook wrote:
>> Hi,
>>
>> In looking for closely at the additions that got made to the
>> kernel_read_file() enums, I noticed that FIRMWARE_PREALLOC_BUFFER
>> and FIRMWARE_EFI_EMBEDDED were added, but they are not appropriate
>> *kinds* of files for the LSM to reason about. They are a "how" and
>> "where", respectively. Remove these improper aliases and refactor the
>> code to adapt to the changes.
>>
>> Additionally adds in missing calls to security_kernel_post_read_file()
>> in the platform firmware fallback path (to match the sysfs firmware
>> fallback path) and in module loading. I considered entirely removing
>> security_kernel_post_read_file() hook since it is technically unused,
>> but IMA probably wants to be able to measure EFI-stored firmware images,
>> so I wired it up and matched it for modules, in case anyone wants to
>> move the module signature checks out of the module core and into an LSM
>> to avoid the current layering violations.
>>
>> This touches several trees, and I suspect it would be best to go through
>> James's LSM tree.
>>
>> Thanks!
> 
> 
> I've done some quick tests on this series to make sure that
> the efi embedded-firmware support did not regress.
> That still works fine, so this series is;
> 
> Tested-by: Hans de Goede <hdegoede@redhat.com>

I made a mistake during testing I was not actually running the
kernel with the patches added.

After fixing that I did find a problem, patch 4/4:
"module: Add hook for security_kernel_post_read_file()"

Breaks module-loading for me. This is with the 4 patches
on top of 5.8.0-rc4, so this might just be because I'm
not using the right base.

With patch 4/4 reverted things work fine for me.

So, please only add my Tested-by to patches 1-3.

Regards,

Hans



>> Kees Cook (4):
>>    firmware_loader: EFI firmware loader must handle pre-allocated buffer
>>    fs: Remove FIRMWARE_PREALLOC_BUFFER from kernel_read_file() enums
>>    fs: Remove FIRMWARE_EFI_EMBEDDED from kernel_read_file() enums
>>    module: Add hook for security_kernel_post_read_file()
>>
>>   drivers/base/firmware_loader/fallback_platform.c | 12 ++++++++++--
>>   drivers/base/firmware_loader/main.c              |  5 ++---
>>   fs/exec.c                                        |  7 ++++---
>>   include/linux/fs.h                               |  3 +--
>>   include/linux/lsm_hooks.h                        |  6 +++++-
>>   kernel/module.c                                  |  7 ++++++-
>>   security/integrity/ima/ima_main.c                |  6 ++----
>>   7 files changed, 30 insertions(+), 16 deletions(-)
>>

