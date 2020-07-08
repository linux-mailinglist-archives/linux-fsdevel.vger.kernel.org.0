Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1357217DA1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 05:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgGHDf4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 23:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbgGHDf4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 23:35:56 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1460C08C5E3
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2020 20:35:55 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id j18so1405293wmi.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2020 20:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7jAj+pJ3tBDBcfbHLX32/EnmgDaBUbI1tUtfYzZ6t8E=;
        b=Ued0oxV9EkmgNkOCW2l3pGN7RUv10IfdSZVvWnaWrITjQCirHaTMHOg+8ajwEgEsFA
         hGWTGaynCrd88/lb8wqJ1EGZ3KFKcufqidb68JuQAWTWivb201MxUrVOA8hYWFxJQo+r
         IjHBij2t/7n3rCqky8D0CvoH7rkBYfd/9HD08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7jAj+pJ3tBDBcfbHLX32/EnmgDaBUbI1tUtfYzZ6t8E=;
        b=p8/sMiB///UXL47a3TPbMXcNcBiNDfdqVf/RkBD0navxbXWcdsvISxlp3SqOTvETy0
         nVD8bhAb820ELLi0GAzjh/ynEMPt+AzBAnoNQ5fGQCW7lOUkca1sO5YM9t514tye80qJ
         GoMkHV4zOQFvSHwkVc2k+S1HOc91U0Xjn3pxNvg+jiQfvF7CUyA1B4xxcRNyUYNQ9vno
         WmhTs2PL1xVWczEo4u5+x4tkiSYG0iJvub3dfnWU/5YrLOy5Oev2DStXT6gRyAzfkQJA
         Ic7CK7tskbReGqKkS2poapjeqf3mHaHps/3kXB65oIpwWniamYYtWIfQWeLBKczFn08U
         IQnQ==
X-Gm-Message-State: AOAM533BCE9s+sUbb53K2tuY/VPvK5pcsyBpvr4Au1zA2IhA9+Y9FlRY
        Nb5WjL0+vMytdh9LI6a/GXycig==
X-Google-Smtp-Source: ABdhPJxBldRqydbdiwKH8RjzV3e1lhQa311aR7D7rI0uGP9u1X8V1fgNVWgNCWVRZ7fS4MiLiEASAQ==
X-Received: by 2002:a1c:7d56:: with SMTP id y83mr7502295wmc.154.1594179353899;
        Tue, 07 Jul 2020 20:35:53 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id v9sm4167676wri.3.2020.07.07.20.35.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 20:35:53 -0700 (PDT)
Subject: Re: [PATCH v10 9/9] ima: add FIRMWARE_PARTIAL_READ support
To:     Kees Cook <keescook@chromium.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200706232309.12010-1-scott.branden@broadcom.com>
 <20200706232309.12010-10-scott.branden@broadcom.com>
 <202007061950.F6B3D9E6A@keescook>
 <df45cc5b-62d7-21c7-a852-1433a45b68ef@broadcom.com>
 <202007071456.50FD0054E@keescook>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <434afda8-2ebf-4b45-effd-19a9b6dbbdbb@broadcom.com>
Date:   Tue, 7 Jul 2020 20:35:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <202007071456.50FD0054E@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020-07-07 4:36 p.m., Kees Cook wrote:
> On Tue, Jul 07, 2020 at 10:13:42AM -0700, Scott Branden wrote:
>> You and others are certainly more experts in the filesystem and security
>> infrastructure of the kernel.
>> What I am trying to accomplish is a simple operation:
>> request part of a file into a buffer rather than the whole file.
>> If someone could add such support I would be more than happy to use it.
> Sure, and I totally understand that, but as it happens, no one has stepped
> up with spare time to do that work. Since you're the person with the need
> for the API, it falls to you to do it. And I understand what feature creep
> feels like (I needed to fix one design problem[1] with timers, and I spent
> months sending hundreds of patches). Some times you get lucky and it's
> easy, and sometimes you end up touching something that needs a LOT of work
> to refactor before you can make your desired change work well with the
> rest of the kernel and be maintainable by other people into the future.
>
> Quick tangent: I can't find in the many many threads where you explain
> how large these firmware images are and why existing kernel memory
> allocations are insufficient to load them. How large are these[2] files?
>
> /lib/firmware/vk-boot1-bcm958401m2.ecdsa.bin
This is on the order of a few MB at most.
> /lib/firmware/vk-boot2-bcm958401m2_a72.ecdsa.bin
Some of these images are current 250MB.  At we anticipate them growing 
to 512MB.
And, we do have systems with the driver loading 16 cards in parallel 
with no requirement that they are the same images
(although loading 16 different images to 16 different cards would be 
strange but possible).
>
> For me, the requirements for partial read support are these things,
> which are the characteristics of the existing API:
>
> - the LSM must be able to validate the entire file contents before
>    any data is available to any reader. (Which was pointed out back in
>    August 2019[3].)
I thought this was addressed in patch v6 "ima: aad FIRMWARE_PARTIAL_READ 
support"
https://lkml.org/lkml/2020/6/5/1126
(although implementation not to your liking in current review)?

> And "any" reader includes having a DMA window open
>    on the memory range used for reading the contents (which was pointed
>    out at by Mimi[4] but went unanswered and remains broken still in this
>    v10, but I will comment separately on that.)
>
> - the integrity of the file contents must be maintained between
>    validation and delivery (currently this is handled internally via
>    disallow_writes()).
I don't understand what you are staying here: I am request a partial 
firmware read into a buf.
At the time the partial firmware is read into a buf it is validated by 
the security module if such integrity checks are enabled.
If, at another time I wish to request another partial firmware into a 
buffer (could be the same part of the file or a different part of a file 
or from another file), the integrity check is performed again and the 
portion of the file I request should be put into the buffer.
If a lock on a file is needed by somebody between these partial reads 
that is a different API and out of the scope of my patch series.
>> This has now bubbled into many other designs issues in the existing
>> codebase.
> Correct -- this is one of the many difficulties of contributing to a
> large and complex code base with many maintainers. There can be a lot
> of requirements for the code that have nothing to do with seemingly more
> narrow areas of endeavour.
Thanks at least for helping with guidance, I see your review is thought 
out and
hopefully we can come to a conclusion as I feel we are fairly close with 
your changes.
>
>> I will need more details on your comments - see below.
>>
>> On 2020-07-06 8:08 p.m., Kees Cook wrote:
>>> On Mon, Jul 06, 2020 at 04:23:09PM -0700, Scott Branden wrote:
>>>> Add FIRMWARE_PARTIAL_READ support for integrity
>>>> measurement on partial reads of firmware files.
>>> Hi,
>>>
>>> Several versions ago I'd suggested that the LSM infrastructure handle
>>> the "full read" semantics so that individual LSMs don't need to each
>>> duplicate the same efforts. As it happens, only IMA is impacted (SELinux
>>> ignores everything except modules, and LoadPin only cares about origin
>>> not contents).
>> Does your patch series "Fix misused kernel_read_file() enums" handle this
>> because this suggestion is outside the scope of my change?
> My proposed patch series cleans up a number of mistakes that were made
> to the kernel_read_file() API, and helps clarify my point about the
> enums being used for *what*, and not *how* or *where*, which needs to
> be fixed in this series and shouldn't be a big deal (I will reply to
> individual patches).
>
>>> Next is the problem that enum kernel_read_file_id is an object
>>> TYPE enum, not a HOW enum. (And it seems I missed the addition of
>>> READING_FIRMWARE_PREALLOC_BUFFER, which may share a similar problem.)
>>> That it's a partial read doesn't change _what_ you're reading: that's an
>>> internal API detail. What happens when I attempt to do a partial read of
>>> a kexec image?
>> It does not appear there is any user of partial reads of kexec images?
>> I have been informed by Greg K-H to not add apis that are not used so such
>> support doesn't make sense to add at this time.
> But you are proposing a generic API enhancement that any other user in
> the kernel may end up using. Just because the bcm-vk driver is the only
> user now, and IMA is the only LSM performing content analysis, it
> doesn't mean that there won't be another driver added later, nor another
> LSM. In fact, the new BPF LSM means that anything exposed by LSM hooks
> is now available for analysis.
>
>>>    I'll use kernel_pread_file() and pass READING_KEXEC_IMAGE,
>>> but the LSMs will have no idea it's a partial read.
>> The addition I am adding is for request_partial_firmware_into_buf.
>> In order to do so it adds internal support for partial reads of firmware
>> files,
>> not kexec image.
> Yes, but you're changing kernel_read_file() APIs to do it. There are
> plenty of users of that API. Maybe they would like to also use partial
> reads?
>
> $ git grep kernel_read_file | wc -l
> 77
>
>> The above seems outside the scope of my patch?
> Unfortunately, it is not. Part of your responsibility as a kernel
> developer making API changes/additions is that those changes need to
> interact correctly with the rest of the kernel (and be maintainable).
>
>>> Finally, what keeps the contents of the file from changing between the
>>> first call (which IMA will read the entire file for) and the next reads
>>> which will bypass IMA?
>> The request is for a partial read.  IMA ensures the whole file integrity
>> even though I only do a partial read.
>> The next partial read will re-read and check integrity of file.
> So, while terribly inefficient, I guess this approach is tenable. It
> means that each partial read will trigger a full read for LSMs that care
> about the hook.

> So, to that end, I wonder why IMA doesn't do this for all file types?
>
> It also means that we won't have a strict pairing of
> security_kernel_read_file() to security_kernel_post_read_file() in the
> LSMs, but it seems that only IMA currently explicitly cares about this
> (or maybe not at all).
>
> I'm not entirely happy about using this design, but it does appear
> sufficient.
Yes, terribly inefficient, but if somebody wants to do some optimization 
they are welcome to it.
In fact, I want to call a partial read of a file with NO security. Can I 
add such a call instead?
If we did that now then the inefficient read of the file multiple times 
to authenticate it each time wouldn't be introduced.
In my use case the linux kernel security on the file is quite 
meaningless and a waste of time to even perform.
Whether the file has been compromised, corrupt or otherwise the image is 
validated by the hardware after
the image is loaded to the card to ensure it passes authentication.
>
>>>    I'd suggested that the open file must have writes
>>> disabled on it (as execve() does).
>> The file will be reopened and integrity checked on the next partial read (if
>> there is one).
>> So I don't think there is any change to be made here.
>> If writes aren't already disabled for a whole file read then that is
>> something that needs to be fixed in the existing code.
> My suggestion quoted here was operating on the idea that whole-file
> verification wasn't happening on every partial read, so this isn't a
> problem in that case.
>
>>> So, please redesign this:
>>> - do not add an enum
>> I used existing infrastructure provided by Mimi but now looks like it will
>> have to fit with your patches from yesterday.
> Right, this won't be hard. I will send a v2 of my patches to clarify the
> purpose of the 3 file content hooks (load_data, read_file,
> post_read_file), which might need renaming...
I see your cleanup and merged with it.  Will need to test everything again.
>
>>> - make the file unwritable for the life of having the handle open
>> It's no different than a full file read so no change to be made here.
> Correct.
>
>>> - make the "full read" happen as part of the first partial read so the
>>>     LSMs don't have to reimplement everything
>> Each partial read is an individual operation so I think a "full read" is
>> performed every time
>> if your security IMA is enabled.  If someone wants to add a file lock and
>> then partial reads in the kernel
>> then that would be different than what is needed by the kernel driver.
> So, given that Mimi is (I think?) satisfied with your approach here, I
> can't realistically complain. I still don't like the idea of each LSM
> needing to perform it's full read loop for the contents, but so be it:
> IMA will have the code, SELinux doesn't care (yet), and LoadPin doesn't
> care about contents.
I obviously am not aware of all of the security hooks and architecture
in place but I do see your cleanups as a simplification over what was there.
>
> -Kees
>
> [1] https://lore.kernel.org/lkml/20170808003345.GA107289@beast/
>      git log --oneline --grep 'Convert timer' --author "Kees Cook" | wc -l
>      271
> [2] https://lore.kernel.org/lkml/824407ae-8ab8-0fe3-bd72-270fce960ac5@broadcom.com/
> [3] https://lore.kernel.org/lkml/s5hsgpsqd49.wl-tiwai@suse.de/
> [4] https://lore.kernel.org/lkml/1591622862.4638.74.camel@linux.ibm.com/
>

