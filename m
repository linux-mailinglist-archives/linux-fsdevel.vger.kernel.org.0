Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2EED1C071D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 21:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgD3T47 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 15:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgD3T46 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 15:56:58 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16ABEC035494
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 12:56:58 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x77so402491pfc.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 12:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kPzmBEkauB3ZxlWoeL0oahZoxKT2pd5/ATvEYXXQ2xc=;
        b=cDz9M1OIiYUZDQy3cKKmDRnnZGONTni4S2ZJmbWsXQswsF3MB7iZ+K3PywbHI2cWbR
         Mf+XxDVUPKnyap5PXRKDqhPWc+/EwhWy6fZ8gUzzuRfmafcNZHlfXmJMNJPwQxVI6Bfg
         FCIoaX7FhQ+08qxE1xXh3e3gsMJ/niq0fcsb71m4Zqes5WHpzuG5w2aBQqkzMZXH7UBa
         KL30k1EahReJwjOt4M95T/dXETNQsy4A91l5/w+UKSYVkEgWNlSd0qxCviBLmgso/VVN
         aOyLbNNAbCghJ4VXC1lPu7rjzDYGWNO30XQuVsOWwxQESN5qpOewu37dyuqtrr1oPDRH
         X2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kPzmBEkauB3ZxlWoeL0oahZoxKT2pd5/ATvEYXXQ2xc=;
        b=YONge0gQaOROMEyyrrUBN2AFLa6RCTJH9ZtjNfj73cxhky55ROIPJ2E2A5eEFYykOg
         wno5Ro1X+EuwqMbj+dKCArlEm9FTzqo3mKwQhqQ0wtmcJ8/tzIJYS0KBQZcyBrOMtHEq
         zP7CBgeALTjz3LCFifotpMuM72v5OG6OM+hCxa7vSJiI7/VoNXqtKNbNcmW26+xO248s
         CtCCk8d4pY8CFBio1jysZt8w2yDVXRzjPWs7uHr22Gypljq0TsfAN9AW+8Uy+35FBvcx
         6IQMeeCu6bdSYYdtxst4D/8vdatI2Df3i6gpuB7CflbkxmyXZfzKTB7qq4Lgvd5pmozm
         dTkw==
X-Gm-Message-State: AGi0PuatEJDpnngih8zLMcYWbyOTN3cYVCohctrPOw0m136wla07ZzZo
        Y98Tx4D7e138QFFzXFnmwAbXdw==
X-Google-Smtp-Source: APiQypKdj0QpDYDUfAC9z2RZ/9tolDELVk/9HhdYUHTHTaYPn+2ATTJzAJWy/9EnPJ3YrN00rHSs8A==
X-Received: by 2002:a62:3006:: with SMTP id w6mr391270pfw.29.1588276617468;
        Thu, 30 Apr 2020 12:56:57 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id z1sm502198pjn.43.2020.04.30.12.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 12:56:56 -0700 (PDT)
Subject: Re: [PATCH] pipe: read/write_iter() handler should check for
 IOCB_NOWAIT
From:   Jens Axboe <axboe@kernel.dk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <273d8294-2508-a4c2-f96e-a6a394f94166@kernel.dk>
 <20200430175856.GX29705@bombadil.infradead.org>
 <d00f0ead-2782-06b3-6e21-559d8c86c461@kernel.dk>
 <bb78a400-8af5-aae8-8049-fd37e1a4db07@kernel.dk>
Message-ID: <82433793-07ed-ea65-5962-86c8e4c59afb@kernel.dk>
Date:   Thu, 30 Apr 2020 13:56:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <bb78a400-8af5-aae8-8049-fd37e1a4db07@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/30/20 1:51 PM, Jens Axboe wrote:
> On 4/30/20 12:47 PM, Jens Axboe wrote:
>> On 4/30/20 11:58 AM, Matthew Wilcox wrote:
>>> On Thu, Apr 30, 2020 at 10:24:46AM -0600, Jens Axboe wrote:
>>>> Pipe read/write only checks for the file O_NONBLOCK flag, but we should
>>>> also check for IOCB_NOWAIT for whether or not we should handle this read
>>>> or write in a non-blocking fashion. If we don't, then we will block on
>>>> data or space for iocbs that explicitly asked for non-blocking
>>>> operation. This messes up callers that explicitly ask for non-blocking
>>>> operations.
>>>>
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>
>>> Wouldn't this be better?
>>
>> Yeah, that's probably a better idea. Care to send a "proper" patch?
> 
> I take that back, running into issues going with a whole-sale conversion
> like that:
> 
> mkdir("/run/dhcpcd", 0755)              = -1 EEXIST (File exists)
> openat(AT_FDCWD, "/run/dhcpcd/ens7.pid", O_WRONLY|O_CREAT|O_NONBLOCK|O_CLOEXEC, 0644) = 4
> flock(4, LOCK_EX|LOCK_NB)               = 0
> getpid()                                = 214
> ftruncate(4, 0)                         = 0
> lseek(4, 0, SEEK_SET)                   = 0
> fstat(4, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
> lseek(4, 0, SEEK_CUR)                   = 0
> write(4, "214\n", 4)                    = -1 EINVAL (Invalid argument)
> 
> which I don't know where is coming from yet, but it's definitely
> breakage by auto setting IOCB_NOWAIT if O_NONBLOCK is set.
> 
> I'd prefer to go your route, but I also would like this fixed for pipes
> for 5.7. So I'd suggest we go with mine, and then investigate why this
> is breaking stuff and go with the all-in approach for 5.8 if feasible.

OK, it's the old classic in generic_write_checks(), is my guess:

        if ((iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIRECT))  
                return -EINVAL;

so we definitely can't just flip the switch on O_NONBLOCK -> IOCB_NOWAIT
in general, at least not for writes.

-- 
Jens Axboe

