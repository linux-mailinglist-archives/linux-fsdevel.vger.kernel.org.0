Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E190597469
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 18:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240611AbiHQQo1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 12:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240600AbiHQQoY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:44:24 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A0D5140A
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 09:44:22 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id i77so7514197ioa.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 09:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=BBPOTlvzySXjn/em5t4brvWTEibIOSecbBA05J6WvbU=;
        b=DlfEC0Y9wGKBCJWX/pdytAVPeMNxNsIPEwycvjVjk0QbNAF2Z9bpkhz6ekAeQCf3h7
         eb/oRpgk1uF6r788ujdM5ZBqTxGooSxwDdFH2QVGxsRmbwjUtR66BN3sNuY862m1io+/
         ZA6eIVgNtxuW6Fm7Gy157WgyJqdepS2fTTC1FBx47Y6p/L81Ho5pRb6emXHeJ/1d6fiy
         QuwPuD5UIBOK2WkNY4Igfa4DABfq+HKDihCIqd80j+OM0HgueitDOwJZ3sIpEqalpWlZ
         643bRwapGjWaqPgpKOeFToZawM8dUwrYHUzRVY944e9hbenHcpFs/fAdCPgoaAqV1VRq
         B2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=BBPOTlvzySXjn/em5t4brvWTEibIOSecbBA05J6WvbU=;
        b=W1MJMYny0PglqsxSFDCQvUBP1piabzJQQbLnOy/jUAL89Wl7IbP2xEyB53Bmu4aFCh
         qpW5wo5wqIE5mSZ7+vIIHFzFiWC6NyV0JcE+Vq34B6Mz8jBJDR46bue3cU1nH4eVYi4e
         UYDg2Xx8dW8TqVq5RFrJz0moenYO8Q11t5IVMHVhPhXvcc/1+7maj2bkwIBmTXDh4PK4
         /+8/z3FhQ5WeprPw+soiwygMnEGNkdESBc+ynaZxHVLdi0+pd3MJOQbhDpkSURxQXiDF
         ufWvhNvtUCGDU6VpTsBuahozziy2m0sLq4+vdzcKQxfLhLbRrZG/v3hyduey/htma7fn
         JUTw==
X-Gm-Message-State: ACgBeo2fYrapcfL0xs7/PoTXaXtEoqHYnw7LSpVXKda/Ivt03EevTvlc
        x3FtTsP1gB7d6BcK4TDom4r14A==
X-Google-Smtp-Source: AA6agR4LlYiDbThwD0mvJgsbHNQNo+BN3kuuZ2sl+8WTJzfDgRPUo1PBWKDZY58MSPCbCuwDMPJBbA==
X-Received: by 2002:a6b:3ec2:0:b0:67c:6baf:a51f with SMTP id l185-20020a6b3ec2000000b0067c6bafa51fmr11690579ioa.160.1660754661680;
        Wed, 17 Aug 2022 09:44:21 -0700 (PDT)
Received: from [192.168.1.170] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id l10-20020a02cd8a000000b0033ebbb649fasm5718109jap.101.2022.08.17.09.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 09:44:20 -0700 (PDT)
Message-ID: <6d6df27f-a5c3-d6dd-ac1c-1d1c0fe53aaa@kernel.dk>
Date:   Wed, 17 Aug 2022 10:44:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] eventfd: guard wake_up in eventfd fs calls as well
Content-Language: en-US
To:     Dylan Yudaken <dylany@fb.com>, viro@zeniv.linux.org.uk,
        bcrl@kvack.org
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org, Kernel-team@fb.com
References: <20220816135959.1490641-1-dylany@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220816135959.1490641-1-dylany@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/16/22 07:59, Dylan Yudaken wrote:
> Guard wakeups that the user can trigger, and that may end up triggering a
> call back into eventfd_signal. This is in addition to the current approach
> that only guards in eventfd_signal.
> 
> Rename in_eventfd_signal -> in_eventfd at the same time to reflect this.
> 
> Without this there would be a deadlock in the following code using libaio:
> 
> int main()
> {
> 	struct io_context *ctx = NULL;
> 	struct iocb iocb;
> 	struct iocb *iocbs[] = { &iocb };
> 	int evfd;
>         uint64_t val = 1;
> 
> 	evfd = eventfd(0, EFD_CLOEXEC);
> 	assert(!io_setup(2, &ctx));
> 	io_prep_poll(&iocb, evfd, POLLIN);
> 	io_set_eventfd(&iocb, evfd);
> 	assert(1 == io_submit(ctx, 1, iocbs));
>         write(evfd, &val, 8);
> }

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

