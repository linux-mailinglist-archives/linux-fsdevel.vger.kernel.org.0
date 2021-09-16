Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D30940E11D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 18:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbhIPQ1g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 12:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239759AbhIPQZf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 12:25:35 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9349C061147
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Sep 2021 09:10:02 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id a15so8544963iot.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Sep 2021 09:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LNfszvXiWgDI6EDtDbmsSQhzeS38fRUrMmntryou2XE=;
        b=zhaMPc55gDXQzGvk0PYF61B2JgkYfZBdC/jCgVzBDGO1/NT5TG1DSOAxtFiojv59TS
         4xy/fZVdwJqKC9xzQUHZjLytim3uZKgAFbKNK4UE/AHi9gWtHJAdDfbfv5/KPWAvmVBP
         OvRYFvTTmfJw3DlCoMslS9aX5rPMbTflZB7HYlRtM/z2+T5gAFsEHfhQsKn5wjGomKUL
         16WuwuX6YwNXiWc9tBozeln5UEh7mEdEtcfLcRE4JzfzlBy1q4J/uouNHaZ1H+aqL/Lf
         jd6/50yDRu5TjkwFjXfmz+1Qqwq74FglJ6nUfYnlC57++B6vV4Q/Pm3pCRspWT7pIRHd
         6EvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LNfszvXiWgDI6EDtDbmsSQhzeS38fRUrMmntryou2XE=;
        b=4Surv87/BAqT1ORHqdb3cd3Es1QNl81gMprEylwbQlgnlaeROh2cDvXgZKM49l9lej
         w3/znNlvbAGFdzhgSaGvCt6ZJsrLgcmCTMgqTFYOdHiEMeO7Jxo7ORuAOnURZFskHezP
         SbRZATVZzOG6eUU8IkixXP92e0Fqv8yjYL/IdUyqCKhR43izHhD5RiHNlpDRlLIyWs1f
         YTmOJTg1iVAlQSLNf5j5D2S702d6HBiXb5cwZ0NoN/3JX3Hf2+0XP4uoPilJkrcZNMdc
         OdF5T3LaWBBcB9YBpP9CI2zv1l35WZjcHXPsv7au5uZfJrzjcnVOMBnO0L0Fdb5IMNGc
         bA/w==
X-Gm-Message-State: AOAM533EBszTvlH1u8ukq8PqTzAI9Dr4hYRQbYeM4ytEOpBNU2yp3B93
        FC6bWlXD4JTuDkeO13K727bn2A==
X-Google-Smtp-Source: ABdhPJwm3CCY3RzpdL9GLroEGIeWrGOhaKGzuyd4II6DMbREXBd3v+zzUiUPq08KT9a0zF2u9VOZHA==
X-Received: by 2002:a5e:df47:: with SMTP id g7mr1938941ioq.92.1631808602154;
        Thu, 16 Sep 2021 09:10:02 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i14sm1994687iol.27.2021.09.16.09.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 09:10:01 -0700 (PDT)
Subject: Re: [PATCHSET v3 0/3] Add ability to save/restore iov_iter state
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        torvalds@linux-foundation.org
References: <20210915162937.777002-1-axboe@kernel.dk>
 <YULMf13OXvU70zV+@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e7588d27-8dc8-a5bb-c024-05b6e7c336db@kernel.dk>
Date:   Thu, 16 Sep 2021 10:10:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YULMf13OXvU70zV+@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/15/21 10:47 PM, Al Viro wrote:
> 	Jens, may I politely inquire why is struct io_rw playing
> these games with overloading ->rw.addr, instead of simply having
> struct io_buffer *kbuf in it?

Very simply to avoid growing the union command part of io_kiocb beyond a
cacheline. We're pretty sensitive to io_kiocb size in general, and io_rw
is already the biggest member in there.
 
> 	Another question: what the hell are the rules for
> REQ_F_BUFFER_SELECT?  The first time around io_iov_buffer_select()
> will
> 	* read iovec from ->rw.addr
> 	* replace iovec.iov_base with value derived from
> ->buf_index
> 	* cap iovec.iov_len with value derived from ->buf_index
> Next time around it will use the same base *AND* replace the
> length with the value used to cap the original.
> 	Is that deliberate?

Probably not strictly needed, but doesn't harm anything. The buffer is
being consumed (and hence removed) at completion anyway, it's not a
persistent change. Selected buffers must be re-provided by the
application as the kernel has no way of knowing when the application
would otherwise be ready for it to get reused, and that's done by
issuing a new provide buffers request for the buffers that can get
recycled.

-- 
Jens Axboe

