Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA78F2174DB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 19:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgGGROB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 13:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgGGRN7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:13:59 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957C2C08C5E3
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2020 10:13:59 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x72so9265210pfc.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2020 10:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=HtwXtpph2OoeeE3uD1Wi+DXJnoAVgPcW38Mw9B+yPaE=;
        b=dzipK/c+2ZtFsuqwsrTcL/d1Yv8zQfVpnmVDF5jdaKLo4l/L0jd2RP/hL4s3Yr7L39
         jwBA+QtRbToqLcum6mDVLTCl2kTLhyzMXa5bQLsbtwSfa8Ypv7iELew2HUxgzxRYGmGZ
         naco+TSnJERTyBinS1dUilsIYM1AfRFHFx/sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HtwXtpph2OoeeE3uD1Wi+DXJnoAVgPcW38Mw9B+yPaE=;
        b=sjatDLF6NhY/D6Jnh0xd8JZfchnx0btWTOLX+xr71Ap8YCZim1bbfH6pesEnolIMkY
         FQE+q2dT5v3EmROz6+W/bkdhGqqOgTkcoDQqEijOuv0V7oX60TePon17Jw3tDnLuapoH
         N18UJk3TWNdJwIMLq8/6LESGuTyQ2NmUDUHlmwpDkJ06WzRYQ1uoFRl9Uvc8bpwiOMKD
         ZPX7ZQftPQaFNj+dQVUS/Jel27H3nE5dk1xaqXtSIsOn49BhF95kiVjLH6gJ6WeAb4ao
         9H1UpBqs7DQCpe6jY41l/zI77RTIVimcOTDM3Lpu/6UGhobXflIkuEKdypr/ZUXoWxtP
         DBDw==
X-Gm-Message-State: AOAM532j7PEM3PcZNyKcwiBTtBHVPoXFv146R95x2OGcf4N40xE80F3d
        yIzcfKAy4g5jt44D4dD8PUqhBA==
X-Google-Smtp-Source: ABdhPJyeSq0J8hJSh8EyLFyNDGaXMs3fPXkpyq9VbmAPXqtEFkmdoQuH8aOIqAG0WttuGA3gnpzq7w==
X-Received: by 2002:a62:8782:: with SMTP id i124mr49547162pfe.267.1594142038788;
        Tue, 07 Jul 2020 10:13:58 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id j70sm23482082pfd.208.2020.07.07.10.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 10:13:58 -0700 (PDT)
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
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <df45cc5b-62d7-21c7-a852-1433a45b68ef@broadcom.com>
Date:   Tue, 7 Jul 2020 10:13:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <202007061950.F6B3D9E6A@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Kees,

You and others are certainly more experts in the filesystem and security
infrastructure of the kernel.
What I am trying to accomplish is a simple operation:
request part of a file into a buffer rather than the whole file.
If someone could add such support I would be more than happy to use it.

This has now bubbled into many other designs issues in the existing 
codebase.
I will need more details on your comments - see below.


On 2020-07-06 8:08 p.m., Kees Cook wrote:
> On Mon, Jul 06, 2020 at 04:23:09PM -0700, Scott Branden wrote:
>> Add FIRMWARE_PARTIAL_READ support for integrity
>> measurement on partial reads of firmware files.
> Hi,
>
> Several versions ago I'd suggested that the LSM infrastructure handle
> the "full read" semantics so that individual LSMs don't need to each
> duplicate the same efforts. As it happens, only IMA is impacted (SELinux
> ignores everything except modules, and LoadPin only cares about origin
> not contents).
Does your patch series "Fix misused kernel_read_file() enums" handle this
because this suggestion is outside the scope of my change?
>
> Next is the problem that enum kernel_read_file_id is an object
> TYPE enum, not a HOW enum. (And it seems I missed the addition of
> READING_FIRMWARE_PREALLOC_BUFFER, which may share a similar problem.)
> That it's a partial read doesn't change _what_ you're reading: that's an
> internal API detail. What happens when I attempt to do a partial read of
> a kexec image?
It does not appear there is any user of partial reads of kexec images?
I have been informed by Greg K-H to not add apis that are not used so 
such support
doesn't make sense to add at this time.
>   I'll use kernel_pread_file() and pass READING_KEXEC_IMAGE,
> but the LSMs will have no idea it's a partial read.
The addition I am adding is for request_partial_firmware_into_buf.
In order to do so it adds internal support for partial reads of firmware 
files,
not kexec image.

The above seems outside the scope of my patch?
>
> Finally, what keeps the contents of the file from changing between the
> first call (which IMA will read the entire file for) and the next reads
> which will bypass IMA?
The request is for a partial read.  IMA ensures the whole file integrity 
even though I only do a partial read.
The next partial read will re-read and check integrity of file.
>   I'd suggested that the open file must have writes
> disabled on it (as execve() does).
The file will be reopened and integrity checked on the next partial read 
(if there is one).
So I don't think there is any change to be made here.
If writes aren't already disabled for a whole file read then that is 
something that needs to be fixed in the existing code.
>
> So, please redesign this:
> - do not add an enum
I used existing infrastructure provided by Mimi but now looks like it 
will have to fit with your patches from yesterday.
> - make the file unwritable for the life of having the handle open
It's no different than a full file read so no change to be made here.
> - make the "full read" happen as part of the first partial read so the
>    LSMs don't have to reimplement everything
Each partial read is an individual operation so I think a "full read" is 
performed every time
if your security IMA is enabled.  If someone wants to add a file lock 
and then partial reads in the kernel
then that would be different than what is needed by the kernel driver.
>
> -Kees
>
Regards,
Scott
