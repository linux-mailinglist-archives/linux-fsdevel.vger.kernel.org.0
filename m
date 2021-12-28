Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721654805BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Dec 2021 03:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbhL1Cbc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Dec 2021 21:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbhL1Cbb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Dec 2021 21:31:31 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47895C06173E;
        Mon, 27 Dec 2021 18:31:31 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id w20so26506585wra.9;
        Mon, 27 Dec 2021 18:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Wz8zeI20HalqtebnxY/VQRKKWH6al7/r6x+JqAjZOIQ=;
        b=ltGaoEU7RlUuoNcgFbFyC0ca+4UlT0ZzN1mgLyNTk5sFT654E5beEaP0rSeaHIXdA9
         5PXoeqSUENPjrbxIyDmIT7jwhCF56sOHLehaqCsbgAReCCpCUw0XkeHOs9sJ2MEMr6pR
         AiodT1flUpJxQpsIsSnv4TfOyq+wgkqrIYUgTx60OZFsAIvvofJ6tZAMqqZmUKM+wC7r
         Y4jtaEmj8KSq/OADSRE1ufT6nZ0AzBYTUAViHg+caKf8R53gOwPgk0w4Uv+JcuBllEpy
         cpmmvMYAvUqgBd7DAz9TrlF/tTGdcJDHk5ouAI1q0tYCAFCybNUP14JreL1zFEWD5BIJ
         8hBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Wz8zeI20HalqtebnxY/VQRKKWH6al7/r6x+JqAjZOIQ=;
        b=UPkNfHBfcoMKg+si1puJEpTrwX8Z+yhWOISEtCNIfaQ2LKcgni0W58fXEgXaVx8hDa
         XYY4DHN4uYLTSVX55wnXQegJc/Dph9h/egQwGoHmu4euP0KpZv5fMMZ9abDyxFqKgEVE
         CxnBr57JNsjWaypqqcvqEeKdOPznLlwALdULGdg/y+23qxRUM4qVokWWM3mGn84Gm2Up
         RQkG4yuo8Zhpj7mqDFa74iyIdlcgO0WEbYfN4LrUKURzQDvWcfrgmxG6b3U1dcsOeaXj
         m3B5Xup4es4A/LPvFXiKmec8Y3gHROcF7ihE+pHpGiC8oloHOb2Bn3QqcWJn8Xg5LczR
         32eg==
X-Gm-Message-State: AOAM530bUZGmyUekQlT3DBydmxJqkHT2+Vow6cmOUCLDVhm5DtevwSbF
        Qa4S2IXA8F1VvAY0KuySRMD11w9iCrw=
X-Google-Smtp-Source: ABdhPJxOEtL3danJ29EvFL9hT/KByy7zQsSmh3yq5taCtscXFQY0ZTEiEyrT7TiLrIAt8ZrUPe/g4w==
X-Received: by 2002:a5d:4486:: with SMTP id j6mr13857030wrq.160.1640658689674;
        Mon, 27 Dec 2021 18:31:29 -0800 (PST)
Received: from [10.101.0.6] ([85.203.46.195])
        by smtp.gmail.com with ESMTPSA id h14sm12912601wmq.16.2021.12.27.18.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Dec 2021 18:31:29 -0800 (PST)
Subject: Re: [BUG] fs: super: possible ABBA deadlocks in
 do_thaw_all_callback() and freeze_bdev()
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, hch@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <e3de0d83-1170-05c8-672c-4428e781b988@gmail.com>
 <YckgOocIWOrOoRvf@casper.infradead.org> <YclDafAwrN0TkhCi@mit.edu>
 <a9dde5cc-b919-9c82-a185-851c2eab5442@gmail.com> <YcnC85Vc95OTBJSV@mit.edu>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <c6d8e729-6537-1a6a-43ff-255e8fbcec7d@gmail.com>
Date:   Tue, 28 Dec 2021 10:31:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <YcnC85Vc95OTBJSV@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/12/27 21:43, Theodore Ts'o wrote:
> On Mon, Dec 27, 2021 at 05:32:09PM +0800, Jia-Ju Bai wrote:
>> Thanks for your reply and suggestions.
>> I will try to trigger this possible deadlock by enabling lockdep and using
>> the workloads that you suggested.
>> In my opinion, static analysis can conveniently cover some code that is hard
>> to be covered at runtime, and thus it is useful to detecting some
>> infrequently-triggered bugs.
>> However, it is true that static analysis sometimes has many false positives,
>> which is unsatisfactory :(
>> I am trying some works to relieve this problem in kernel-code analysis.
>> I can understand that the related code is not frequently executed, but I
>> think that finding and fixing bugs should be always useful in practice :)
> The thing about the sysrq commands is that they are almost always used
> in emergency situations when the system administrator with physical
> access to the console sends a sysrq command (e.g., by sending a BREAK
> to the serial console).  This is usually done when the system has
> *already* locked up for some reason, such as getting livelocked due to
> an out of memory condition, or maybe even a deadlock.  So if sysrq-j
> could potentially cause a deadlock, so what?  Sysrq-j would only be
> used when the system was in a really bad state due to a bug in any
> case.  In over 10 years of kernel development, I can't remember a
> single time when I've needed to use sysrq-j.
>
> So it might be that the better way to handle this would be to make
> sure all of the emergency sysrq code in fs/super.c is under the
> CONFIG_MAGIC_SYSRQ #ifdef --- and then do the static analysis without
> CONFIG_MAGIC_SYSRQ defined.

Thanks for the explanation.
In fact, I did not know the sysrq commands, before finding this bug and 
seeing your explanation.

>
> As I said, I agree it's a bug, and if I had infinite resources, I'd
> certainly ask an engineer to completely rework the emergency sysrq-j
> code path to address the potential ABBA deadlock.  The problem is I do
> *not* have infinite resources, which means I have to prioritize which
> bugs get attention, and how much time engineers on my team spend
> working on new features or performance enhacements that can justify
> their salaries and ensure that they get good performance ratings ---
> since leadership, technical difficulty and business impact is how
> engineers get judged at my company.

I can understand the priority of bug fixing, with the consideration of 
resources and time.
My static analysis tool just provides a small message that there is a 
possible bug :)

>
> Unfortunately, judging business impact is one of those things that is
> unfair to expect a static analyzer to do.

Thanks for your understanding :)
Before seeing your explanation, I have no idea of business impact.
But it is indeed practical to consider business impact and resource 
assignment in kernel development.

>   And after all, if we have
> infinite resources, why should an OS bother with a VM?  We can just
> pin all process text/data segments in memory, if money (and DRAM
> availability in the supply chain) is no object.  :-)

Haha, interesting idea :)


Thanks a lot,
Jia-Ju Bai
