Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819E91DF1B0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 00:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbgEVWPK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 18:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731051AbgEVWPJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 18:15:09 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE915C061A0E
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 15:15:09 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n15so5856391pfd.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 15:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=S/stJk0STsDchWWcNppinxUmms4bbqR7NgPSokrOceo=;
        b=PmzMc1A3bv0cdDO6gy5pV3cfYwofz+ExRxro+KvdU+1AO9aKDU4k2v3ZbsYFNpXYM3
         ujV76XGl4DZh1QfkTopVsN2B3S1yt3GaKfDHFhNpsz7M+qtRhMm0TGgMlYg4uhcoaT78
         5rcALuJn/0tGohe2U8KpbkBQAWyAqJssSuTIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=S/stJk0STsDchWWcNppinxUmms4bbqR7NgPSokrOceo=;
        b=SYc+YrocH3ZOFJW3fjPs554L7Y6YzThrQ403NrKF6L2HF1jEUJVSn20T97iv0sUtvv
         q50j/ccpWP54PBgrbZAgV6MTn6GyghIRaIRG07OiAZXV7rP2O9jRkFKiwWI3O6V/wnJ7
         NbJhpxmifR4Dtm5LLTHnee2yRpLO6M6UYyI1e5MUKYBYbU7gh/jOi9UTGW6scbrTlLqW
         m2mHtHf9W6iZjZjhXMp+ilEi+T7Kjmo8i6ooMAkjohN121uxOGJhvgK5pjHeWr9ygiR8
         WK6VNJpAuCupZjlNJvJipVxSIiEH7E4MB3oTEeU/zxSqAiFUT8k8uT3O8afD2camBs/M
         k4dw==
X-Gm-Message-State: AOAM531U+Q4843WqjhDB4o3UB9uKDThMRLfQLoPFZQMFsh61Or3DHvEe
        J28rhTXDg9XOphj1avhrptM5Iw==
X-Google-Smtp-Source: ABdhPJxhfMeRhg/dgwefdDNDDyQFvPL+rBpUHV3BJJZDZIKfp4q5lWc32CFIo+rbWpfkiSYU/ulskQ==
X-Received: by 2002:a65:4107:: with SMTP id w7mr11958661pgp.226.1590185709221;
        Fri, 22 May 2020 15:15:09 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id v2sm7516686pje.52.2020.05.22.15.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 15:15:08 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] fs: avoid fdput() after failed fdget() in
 kernel_read_file_from_fd()
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1589311577.git.skhan@linuxfoundation.org>
 <1159d74f88d100521c568037327ebc8ec7ffc6ef.1589311577.git.skhan@linuxfoundation.org>
 <20200513054950.GT23230@ZenIV.linux.org.uk>
 <20200513131335.GN11244@42.do-not-panic.com>
 <CAB=NE6WdYcURTxNLngMk3+JQfNHG2MX1oE_Mv08G5zcw=mPOyw@mail.gmail.com>
 <2d298b41-ab6f-5834-19d2-7d3739470b5f@broadcom.com>
Message-ID: <075ae77b-000b-c00f-b425-59105dc2584a@broadcom.com>
Date:   Fri, 22 May 2020 15:14:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2d298b41-ab6f-5834-19d2-7d3739470b5f@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020-05-22 2:59 p.m., Scott Branden wrote:
> Hi Luis,
>
> On 2020-05-13 7:19 a.m., Luis Chamberlain wrote:
>> On Wed, May 13, 2020 at 7:13 AM Luis Chamberlain <mcgrof@kernel.org> 
>> wrote:
>>> On Wed, May 13, 2020 at 06:49:50AM +0100, Al Viro wrote:
>>>> On Tue, May 12, 2020 at 01:43:05PM -0600, Shuah Khan wrote:
>>>>> diff --git a/fs/exec.c b/fs/exec.c
>>>>> index 06b4c550af5d..ea24bdce939d 100644
>>>>> --- a/fs/exec.c
>>>>> +++ b/fs/exec.c
>>>>> @@ -1021,8 +1021,8 @@ int kernel_read_file_from_fd(int fd, void 
>>>>> **buf, loff_t *size, loff_t max_size,
>>>>>              goto out;
>>>>>
>>>>>      ret = kernel_read_file(f.file, buf, size, max_size, id);
>>>>> -out:
>>>>>      fdput(f);
>>>>> +out:
>>>>>      return ret;
>>>> Incidentally, why is that thing exported?
>>> Both kernel_read_file_from_fd() and kernel_read_file() are exported
>>> because they have users, however kernel_read_file() only has security
>>> stuff as a user. Do we want to get rid of the lsm hook for it?
>> Alright, yeah just the export needs to be removed. I have a patch
>> series dealing with these callers so will add it to my queue.
> When will these changes make it into linux-next?
> It is difficult for me to complete my patch series without these other 
> misc. changes in place.
Sorry, I see the patch series is still being worked on (missing 
changelog, comments, etc).
Hopefully the patches stabilize so I can apply my changes on top fairly 
soon.
>>
>>    Luis
> Regards,
>  Scott

