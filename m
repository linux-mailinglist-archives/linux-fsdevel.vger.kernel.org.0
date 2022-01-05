Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C750484E7E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 07:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237804AbiAEGyY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 01:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiAEGyX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:54:23 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3C5C061761;
        Tue,  4 Jan 2022 22:54:23 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d9so80975349wrb.0;
        Tue, 04 Jan 2022 22:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MzoxFJLsVsPS3TEQ3UlB0+RB8cYwCNykLSE+xL3iWb4=;
        b=n4AAAvzEOZVbAb6o6ce8f1XYdbdDmfNE5exo3LN0X/Udj1Xp/dRzsZlrJJQ+CGSs7y
         wr31h9u8A8VgA332OVai0Ae8hAS9sF7sVkVAEqY2HM0RWm2ZwMFw8oldQnlvpIkKPFRn
         q3DanVmUfk8VwwFvIFfYhrAEe8cEHlO7EZXGsImDEJayD+rvOFICp/zMIEtPhA6KDjUT
         02kFPa9iBdt67MWg3+CAuXbcj1JH17FBTxhUHvkjla3bw8mK3Y+7D8QuSC2eUbbdlC+l
         rQd850diE044ICU8QHtPwGpExBVseekm+ooTZYLBf1l7Yl8MD5iGLkX11bAQpeFFE0Pp
         FKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MzoxFJLsVsPS3TEQ3UlB0+RB8cYwCNykLSE+xL3iWb4=;
        b=ow4SadGjLLIJEaf7db0wU+RuX2CvlkTENt+miVDsdV53//sU2U3IhoRjpHvp0wgWTa
         B0RjbXpWzAWG2B5A441SZfEfnXLX86YHf0veyigc09zINDntse3s04ImZXt0YV7U03UI
         +IyPvawjEyitjcRlNliO2vyTGDbLcyNIpk6RWs3DWROGJlSAcCETHDYLt4KBnH4h+G7J
         bxeLjZSZWqiAR4943JPTCYmIDdCATl12ZQe/2q4rb3O2THb/LMot2RIRvqF1zrkMYQRW
         Q6s7Dsn5wIdkq5mCRuxVXJSCDtoBFiq6veo8K9XjbVAEMiiQ/O7qlEY9Pya0yoyEpFEh
         gIOg==
X-Gm-Message-State: AOAM532CcYhZL0k+wSMZhpYudji4UMrkX2PJQkV45JK0gnws/zkwXTUN
        7iKOqE4pytWurT2hcEk9S9aidPTTEyc=
X-Google-Smtp-Source: ABdhPJxEW5U1C7i9T8Y+Dhxbo29fKK6x7MD++ORqjcnDdkDDxfYWyIkLOtAGvWbUgUDfOE3GgEA1EQ==
X-Received: by 2002:a05:6000:2a9:: with SMTP id l9mr45579723wry.185.1641365661823;
        Tue, 04 Jan 2022 22:54:21 -0800 (PST)
Received: from ?IPV6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id u3sm51773518wrs.0.2022.01.04.22.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 22:54:21 -0800 (PST)
Message-ID: <77862a7a-3fd2-ff2b-8136-93482f98ed3c@gmail.com>
Date:   Wed, 5 Jan 2022 06:54:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] fs/pipe: use kvcalloc to allocate a pipe_buffer array
Content-Language: en-US
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20220104171058.22580-1-avagin@gmail.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
In-Reply-To: <20220104171058.22580-1-avagin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/4/22 17:10, Andrei Vagin wrote:
> Right now, kcalloc is used to allocate a pipe_buffer array.  The size of
> the pipe_buffer struct is 40 bytes. kcalloc allows allocating reliably
> chunks with sizes less or equal to PAGE_ALLOC_COSTLY_ORDER (3). It means
> that the maximum pipe size is 3.2MB in this case.
> 
> In CRIU, we use pipes to dump processes memory. CRIU freezes a target
> process, injects a parasite code into it and then this code splices
> memory into pipes. If a maximum pipe size is small, we need to
> do many iterations or create many pipes.
> 
> kvcalloc attempt to allocate physically contiguous memory, but upon
> failure, fall back to non-contiguous (vmalloc) allocation and so it
> isn't limited by PAGE_ALLOC_COSTLY_ORDER.
> 
> The maximum pipe size for non-root users is limited by
> the /proc/sys/fs/pipe-max-size sysctl that is 1MB by default, so only
> the root user will be able to trigger vmalloc allocations.
> 
> Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> Signed-off-by: Andrei Vagin <avagin@gmail.com>

Good idea!

I wonder if you need to apply this on the top:

diff --git a/fs/pipe.c b/fs/pipe.c
index 45565773ec33..b4ccafffa350 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -605,7 +605,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 static long pipe_ioctl(struct file *filp, unsigned int cmd, unsigned
long arg)
 {
        struct pipe_inode_info *pipe = filp->private_data;
-       int count, head, tail, mask;
+       unsigned int count, head, tail, mask;

        switch (cmd) {
        case FIONREAD:
@@ -827,7 +827,7 @@ struct pipe_inode_info *alloc_pipe_info(void)

 void free_pipe_info(struct pipe_inode_info *pipe)
 {
-       int i;
+       unsigned int i;

 #ifdef CONFIG_WATCH_QUEUE
        if (pipe->watch_queue) {
--->8---

Otherwise this loop in free_pipe_info() may become lockup on some ugly
platforms with INTMAX allocation reachable, I think. I may be wrong :-)

Thanks,
          Dmitry
