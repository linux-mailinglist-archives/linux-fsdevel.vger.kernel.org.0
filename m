Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61C21DF1C6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 00:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731207AbgEVWYr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 18:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731116AbgEVWYq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 18:24:46 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2AEC061A0E
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 15:24:46 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x13so5827853pfn.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 15:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ztKgl+m2bwsAuJakJyGkItSpIGs0CjL1QD7hydh2kOo=;
        b=Y/Hbo0rnxy6mClHRHFWRhUyxj1FRJT69aFwW3tY3fm3oVu6EODCaV6cZ/pbEy2J4Xp
         5SqSYpicqXhNkkxvb94CERQ10mQiHBfSX/Rac+QDLBTz0rt5MReojcoJ8+Ykua9ccq4e
         eIsrhNUpOJWulxVbDeRZjq1LzV2AlyBxgkCa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ztKgl+m2bwsAuJakJyGkItSpIGs0CjL1QD7hydh2kOo=;
        b=S4fv51UQ6XL1UbSZd8bWyd/l1zKrkqd48Z07U9im8pBCSfqGkloQ7dHDVoVjrAOye6
         VJZ3XFdPvvDZH3s8xWWKPdeJ+ZBaWVKK9mcmuzq44WqFcvnsSO2B6IKX7LuA/ThwFwdF
         A23jQwW5QTw+xPW/HRpWLHNjf6Gk30LuQ4dwyugvao4X/pcBatSIQfYX8O25zueYEqKz
         62HqHgDHOwZLykZun2G+uu4yYXCaO5MtoP69A+4FGCI5kS2LGWYK+MdS4RWP3Cp5KN7w
         3pN5QxYMlKxLFC/VYB3kRKL2OTZ/5i+SGLmf9VViT5nVjftjtSQyVck7wMddVrrUvFYW
         BBng==
X-Gm-Message-State: AOAM5334RKOIHcTOe3KUPpKG3Ur7Mn8OlpxnclgtqXqHb5G5ANiAjH3+
        wqrJbgVsmOuYNffW0W68TYv67g==
X-Google-Smtp-Source: ABdhPJzG9AGsDx8lk0R8+8Hml3s7+HeGqJxA11vopeTxMwHpwyVnW8wN1246sbOgiHcMg7eLFkw9kw==
X-Received: by 2002:a63:111e:: with SMTP id g30mr15317955pgl.446.1590186285979;
        Fri, 22 May 2020 15:24:45 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l3sm7861934pjb.39.2020.05.22.15.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 15:24:44 -0700 (PDT)
Subject: Re: [PATCH 0/3] fs: reduce export usage of kerne_read*() calls
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rafael@kernel.org, ebiederm@xmission.com, jeyu@kernel.org,
        jmorris@namei.org, keescook@chromium.org, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        nayna@linux.ibm.com, dan.carpenter@oracle.com,
        skhan@linuxfoundation.org, geert@linux-m68k.org,
        tglx@linutronix.de, bauerman@linux.ibm.com, dhowells@redhat.com,
        linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200513152108.25669-1-mcgrof@kernel.org>
 <20200513181736.GA24342@infradead.org>
 <20200515212933.GD11244@42.do-not-panic.com>
 <20200518062255.GB15641@infradead.org>
 <1589805462.5111.107.camel@linux.ibm.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <7525ca03-def7-dfe2-80a9-25270cb0ae05@broadcom.com>
Date:   Fri, 22 May 2020 15:24:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589805462.5111.107.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Mimi,

On 2020-05-18 5:37 a.m., Mimi Zohar wrote:
> Hi Christoph,
>
> On Sun, 2020-05-17 at 23:22 -0700, Christoph Hellwig wrote:
>> On Fri, May 15, 2020 at 09:29:33PM +0000, Luis Chamberlain wrote:
>>> On Wed, May 13, 2020 at 11:17:36AM -0700, Christoph Hellwig wrote:
>>>> Can you also move kernel_read_* out of fs.h?  That header gets pulled
>>>> in just about everywhere and doesn't really need function not related
>>>> to the general fs interface.
>>> Sure, where should I dump these?
>> Maybe a new linux/kernel_read_file.h?  Bonus points for a small top
>> of the file comment explaining the point of the interface, which I
>> still don't get :)
> Instead of rolling your own method of having the kernel read a file,
> which requires call specific security hooks, this interface provides a
> single generic set of pre and post security hooks.  The
> kernel_read_file_id enumeration permits the security hook to
> differentiate between callers.
>
> To comply with secure and trusted boot concepts, a file cannot be
> accessible to the caller until after it has been measured and/or the
> integrity (hash/signature) appraised.
>
> In some cases, the file was previously read twice, first to measure
> and/or appraise the file and then read again into a buffer for
> use.  This interface reads the file into a buffer once, calls the
> generic post security hook, before providing the buffer to the caller.
>   (Note using firmware pre-allocated memory might be an issue.)
>
> Partial reading firmware will result in needing to pre-read the entire
> file, most likely on the security pre hook.
The entire file may be very large and not fit into a buffer.
Hence one of the reasons for a partial read of the file.
For security purposes, you need to change your code to limit the amount
of data it reads into a buffer at one time to not consume or run out of 
much memory.
>
> Mimi
Scott
