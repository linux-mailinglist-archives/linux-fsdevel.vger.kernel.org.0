Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0B22A0F8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 21:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgJ3Ued (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 16:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbgJ3UdP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 16:33:15 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B505EC0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2020 13:33:15 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r10so6167694pgb.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2020 13:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZUMZnZrv3DNPK13JwZfcoujpzkEHK3LguFa4dVLLup0=;
        b=r3PeCdqiSugEFLqlJoHQqglokJqiYiHlgE5831zwqovtVsQs4oJ+iYam9uaNrkG+/o
         dVTYF8JRTxdJeEyuZt4UCYDdWbNvdp8ymNFg/JFMd3/fNDXscSkNz7E1EtLRtOJ1+B9m
         6E3UuSTuj8DkzgZDtodWILJedvlrZ1gDccwW7gxgEgwMIkffv+BpMqs0fdrzbB3Dv2Wd
         TtLA5z9xX3Eu9a02tO2bPWvSYJGq/69FONdyzvF2G5R5Qg3YGZ9m6qpI8waCvmYBKWP/
         v/m8ohBMEmwa+Z0jEc5tYuPTIM/WM0eZA2XTP8az8uWSt7N88yqvTk4ulgfRkdYeE3ii
         ucWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZUMZnZrv3DNPK13JwZfcoujpzkEHK3LguFa4dVLLup0=;
        b=XxVW3Tsa6ZdfEsM+WwAugIhJ2g0AiQaa2pGSfY03Ce399td0FSkbk4RSj5/MlC+30h
         EsGBYE7XBQh6i9OAK4hJUR2wCJ3Z/cU8cFVK0OIFFlh+u1x7CXDDPvtAmE9D8jf+ctFR
         2h2be8OPDSgD9hjzAtVIKxMxcQ4O6YOiNudlCMZ1AXej6ttt622nnMwnezxoqOBzpseh
         UqXZZyc2gGZHxAOr1sBFKbkwIsNrL4VmkNxJrIT3MO6lrT5UnpLvRzELyxQDY/JJPGqH
         pyyaPYDh0r2Sx/qHol0G5KconPY13O9YNNAEV9UmAdYGvk3mn5Xtm/nqfjAlPliAY802
         nVyw==
X-Gm-Message-State: AOAM533dBhy7U1jiNf6ymI++FkSEIR1YLS9JoPIpDm4FW+kUwaQpwIva
        icGc0LXJdZ87L1bq0dQCHNXVNWTGA06etQ==
X-Google-Smtp-Source: ABdhPJyY1X/JJm1IsePYvXdKYbS1l5wR/8Wne0KBg8tx8JtXi8nI4oC6hmMAkkBJ4kUD1vZ8yHxpTA==
X-Received: by 2002:a17:90b:1204:: with SMTP id gl4mr4146839pjb.157.1604089995058;
        Fri, 30 Oct 2020 13:33:15 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id w31sm4233793pjj.32.2020.10.30.13.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 13:33:14 -0700 (PDT)
Subject: Re: [PATCH -next] fs: Fix memory leaks in do_renameat2() error paths
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Qian Cai <cai@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201030152407.43598-1-cai@redhat.com>
 <20201030184255.GP3576660@ZenIV.linux.org.uk>
 <ad9357e9-8364-a316-392d-7504af614cac@kernel.dk>
 <20201030184918.GQ3576660@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d858ba48-624f-43be-93cf-07d94f0ebefd@kernel.dk>
Date:   Fri, 30 Oct 2020 14:33:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201030184918.GQ3576660@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 12:49 PM, Al Viro wrote:
> On Fri, Oct 30, 2020 at 12:46:26PM -0600, Jens Axboe wrote:
> 
>> See other reply, it's being posted soon, just haven't gotten there yet
>> and it wasn't ready.
>>
>> It's a prep patch so we can call do_renameat2 and pass in a filename
>> instead. The intent is not to have any functional changes in that prep
>> patch. But once we can pass in filenames instead of user pointers, it's
>> usable from io_uring.
> 
> You do realize that pathname resolution is *NOT* offloadable to helper
> threads, I hope...

How so? If we have all the necessary context assigned, what's preventing
it from working?

-- 
Jens Axboe

