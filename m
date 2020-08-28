Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBF925532E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Aug 2020 05:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgH1DBS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 23:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgH1DBQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 23:01:16 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5433AC061232
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 20:01:16 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d19so4762159pgl.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 20:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IiuhGhzNgL/DLui8gzTK8ao7Oz/TOVe+cUKUpQqg/f0=;
        b=A21YlOTJEsZNmnka2SfNcYfgw1+lPMwJqhBVCkpEPv7LqDIBnDQ1HyazAFYe3K5uz2
         P9BSVvy4PZtAGr2MZ3SLhzIdEgEEDcCVNXLIHl0XN5Suu0YyGuHwSJfASthuIGbDq3IQ
         vb5ym4nNJOEbsawe5V/XdyIOduT+k+Bd5H2LWHDaJWDfIhRafUXcWvZYFFuV3PUwNYps
         k20xTAnBGa9QEmhjnP0csDgUrCHWALxg/bbUVlV1EJmuQQMn2axcjNTl7+5TB7+HJd9P
         /X1wZdjRci0LnAeuD+O5cXn22bEFiQ2dk5WQ8V1bV2NqM4SlAQ33C+QNdmaOGpA7Eikx
         YclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IiuhGhzNgL/DLui8gzTK8ao7Oz/TOVe+cUKUpQqg/f0=;
        b=aAFQKnwiBivaiva3eZywIfZ7vl3ldn8XoTfggfJopwPiSvG6wvn1in/29GODsma7+7
         oDjb+EaaUUc1Cow9tHscNxmTuln4lBsD2oBh2xm1K7qc0W45UXKyQu9JrR9qRIblqiMx
         4kKUD7eNS8MjorEpAEXATLj2yUgE/QrgVQwcUCA2ue4SKf5Z7H8vd/gOvGkXaspnOzpH
         Da2fwfBTVNe7EP94hEqi5auqkTvctr7etpuLd6QsdHX2g0WkRf/o7kC5vp5UTca4fvp9
         6mqVhJmAJCC8ZqHbacK+RYw4+MrkwF6Zb6cRQIncYInEo1NWJrWcGc34dFGF6POMlqpx
         rP7g==
X-Gm-Message-State: AOAM530Nc0URwjsPTzZoRgrr+2D0mCfzdAgEI3Q22XAS6erufR+XzLIG
        jB5X4BubCvHICrypmUjarkxSEQyXCpftPxBP
X-Google-Smtp-Source: ABdhPJwOvqqC+wLSGyfhpDIPXvlFwqQ3jCC/e/zr3AGe57QwIOArUNETxLAixcYF7uYEXMzihbQNmw==
X-Received: by 2002:a05:6a00:15cb:: with SMTP id o11mr19227116pfu.263.1598583675314;
        Thu, 27 Aug 2020 20:01:15 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id t10sm3575280pgp.15.2020.08.27.20.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 20:01:14 -0700 (PDT)
Subject: Re: [PATCH v6 0/3] io_uring: add restrictions to support untrusted
 applications and guests
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Moyer <jmoyer@redhat.com>,
        Aleksa Sarai <asarai@suse.de>,
        Sargun Dhillon <sargun@sargun.me>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
References: <20200827145831.95189-1-sgarzare@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8a86fc8a-56f6-351e-aaee-d80c4798d152@kernel.dk>
Date:   Thu, 27 Aug 2020 21:01:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827145831.95189-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/27/20 8:58 AM, Stefano Garzarella wrote:
> v6:
>  - moved restriction checks in a function [Jens]
>  - changed ret value handling in io_register_restrictions() [Jens]
> 
> v5: https://lore.kernel.org/io-uring/20200827134044.82821-1-sgarzare@redhat.com/
> v4: https://lore.kernel.org/io-uring/20200813153254.93731-1-sgarzare@redhat.com/
> v3: https://lore.kernel.org/io-uring/20200728160101.48554-1-sgarzare@redhat.com/
> RFC v2: https://lore.kernel.org/io-uring/20200716124833.93667-1-sgarzare@redhat.com
> RFC v1: https://lore.kernel.org/io-uring/20200710141945.129329-1-sgarzare@redhat.com
> 
> Following the proposal that I send about restrictions [1], I wrote this series
> to add restrictions in io_uring.
> 
> I also wrote helpers in liburing and a test case (test/register-restrictions.c)
> available in this repository:
> https://github.com/stefano-garzarella/liburing (branch: io_uring_restrictions)
> 
> Just to recap the proposal, the idea is to add some restrictions to the
> operations (sqe opcode and flags, register opcode) to safely allow untrusted
> applications or guests to use io_uring queues.
> 
> The first patch changes io_uring_register(2) opcodes into an enumeration to
> keep track of the last opcode available.
> 
> The second patch adds IOURING_REGISTER_RESTRICTIONS opcode and the code to
> handle restrictions.
> 
> The third patch adds IORING_SETUP_R_DISABLED flag to start the rings disabled,
> allowing the user to register restrictions, buffers, files, before to start
> processing SQEs.

Applied, thanks.

-- 
Jens Axboe

