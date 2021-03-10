Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCB83332A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 02:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhCJBML (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 20:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbhCJBLz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 20:11:55 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE7AC06174A;
        Tue,  9 Mar 2021 17:11:55 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d23so4422370plq.2;
        Tue, 09 Mar 2021 17:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FGISyVhw3ySIweJMtXxSOZtXnd+xKsePHBEX5Ypjhtg=;
        b=pVJ4osi3mGeryeQFhpdkIj0PuunPA50aH6IsziowPUzUJUh8bzJCJfKsM1SLc6752/
         qAPNrqaIn58Fv8BrEnrmas/pnFX7tEtzoy38itp39px+/Olpcu6TOtaLuO41voI5FZpH
         vdDzXzPP41woedr3QHwiA7GVV9Cjw8ha4cZe6QTZxDe1335weNMyMsKwHCd0eu++sWvU
         DH1ZbgrdgsTg4h8FPPhgYTGfcH784Rzfr/9Wy3h0La8eosKbPd0Eu9+5NCZUUCQErVek
         Ur2MEE29R80YviR3EKi+Lx5K9W1NTr+5tzAEg2jwgwD6XeNqpyxt4GeXUSDhnaJYjVf9
         GDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FGISyVhw3ySIweJMtXxSOZtXnd+xKsePHBEX5Ypjhtg=;
        b=fIfXTR8n+kdVfjntnwNBk81Z+0tDtBVCuwFC8JhAZZEQ6sOQhIlieVmXwiaoy1XdyE
         of7DjL1vhZk13ym2MByKYFSlueIxkuBBhWSTBfmb2na1JicOlK8KsNKvTSaeJ194i/uo
         DfW0LWhqJ5+rTaz+tgCEMHAjpIAUR4ieHUlwXzvXXhslVojFZVD1d0LuISfp6hoYAIbo
         f/dnLWX5w4yOQaRMuXbToiGM+51rZenFXbe2FpCVeSAENJHv2ublBqtTdrNURLd7BAvz
         t9CtQvsPP2eVyRM0WF5yyuRazB1dCZgiMT7T9RYYr4B/3LjwZg4RPDql2EzGvBQMmTga
         fxoA==
X-Gm-Message-State: AOAM533j8gaKFE9m5itaD3kWAB1MpP6MjFrndD5/LaxRM+F/40QkVKUo
        x6q7YUqKMk+wupGs+y4XrgXXc40LMajReI/I
X-Google-Smtp-Source: ABdhPJzsJ0ZbHxlWXGRKXgJ/YFWd5raaHXnbHeehvx2+VexZ+mR8kdnEKYMvccQtp633uGJee7aVLw==
X-Received: by 2002:a17:90a:d90a:: with SMTP id c10mr729901pjv.13.1615338714133;
        Tue, 09 Mar 2021 17:11:54 -0800 (PST)
Received: from [10.38.0.14] ([45.135.186.59])
        by smtp.gmail.com with ESMTPSA id l4sm11038491pgi.19.2021.03.09.17.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 17:11:53 -0800 (PST)
Subject: Re: [PATCH] fs: proc: fix error return code of
 proc_map_files_readdir()
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     christian@brauner.io, ebiederm@xmission.com,
        akpm@linux-foundation.org, keescook@chromium.org,
        gladkov.alexey@gmail.com, walken@google.com,
        bernd.edlinger@hotmail.de, avagin@gmail.com, deller@gmx.de,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20210309095527.27969-1-baijiaju1990@gmail.com>
 <YEe+v+ywMrxgmj05@gmail.com> <YEfG54xMM7OtPEE5@localhost.localdomain>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <86f9dae2-7bb1-4555-44a4-24045260916b@gmail.com>
Date:   Wed, 10 Mar 2021 09:11:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <YEfG54xMM7OtPEE5@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/3/10 3:05, Alexey Dobriyan wrote:
> On Tue, Mar 09, 2021 at 10:30:23AM -0800, Eric Biggers wrote:
>
>>> --- a/fs/proc/base.c
>>> +++ b/fs/proc/base.c
>>> @@ -2332,8 +2332,10 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
>>>   		goto out_put_task;
>>>   
>>>   	mm = get_task_mm(task);
>>> -	if (!mm)
>>> +	if (!mm) {
>>> +		ret = -ENOENT;
>>>   		goto out_put_task;
>>> +	}
>>>   
>>>   	ret = mmap_read_lock_killable(mm);
>> Is there something in particular that makes you think that returning ENOENT is
>> the correct behavior in this case?  Try 'ls /proc/$pid/map_files' where pid is a
>> kernel thread; it's an empty directory, which is probably intentional.  Your
>> patch would change reading the directory to fail with ENOENT.
> Yes. 0 from readdir means "no more stuff", not an error.

Thanks for your reply and explanation.
I am sorry for the false report...


Best wishes,
Jia-Ju Bai
