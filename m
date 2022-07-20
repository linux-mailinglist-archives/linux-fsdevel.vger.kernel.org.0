Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC61D57B6BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 14:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240708AbiGTMsP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 08:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiGTMsO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:48:14 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41E02AE14
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jul 2022 05:48:11 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o18so3512801pjs.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jul 2022 05:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gGzhbksNlmAjolVQXQdc9eTCDYUNBeJ75ClnIeGoBhQ=;
        b=p4DVtuHsUlq3ow05vMOkgjy2v8TGkBw9yNnqN0k3Aez87VPlF/SrkPj5HMP+WMIMpa
         1+LFW6tYsXVIOkCzmONzXA0EAFKIUfZBghG1PRzbdUdJgZdSfZM0lrAnItaIv60JDGgj
         xJEQcJzCh/SPy5GP65S0ddQkj8BvR1BXbgNJCb0dW7q2UKWomROZPbtuHxe3H7k2Z4/L
         XuGRDG4muhkTbtCGccalZ+DbKsgLVdEcN42mdmMOEJhkUVp+aEBPcGM/qXl2D9gOm0jq
         ZHvp+oeLZ/yvVXWXqo2yIZyWXYZJ2yoJR5AKPD5C8fev28ydJjva7QdpjqDzOKSXCAAY
         AjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gGzhbksNlmAjolVQXQdc9eTCDYUNBeJ75ClnIeGoBhQ=;
        b=4O9sF31VKF9OBQF3p84Pip6Nc4H+12iLlNeoCO6+gGrGKR7+oq0vVdzSKzXbrkc6AX
         kv3HfEh1F5mgPQcHxDMN0jcRkm2gybvybwQ1rBSI7DaFXHL356KYlUJjKM4f2KqCLERe
         YHuGueavCEvwAyqohQPim5yqzNSjDUGagCdmJrRA0klkxs4uQTMzHpk7kLzUlWz1MrTU
         Hu49a/buFWg1CpE4BQq95CjJfKPH/gZkzKd+xJkkYgNd/R28rNdwNfIzXFDLRRGkKMNL
         SToznIbiyYibrG8xa4MCWeUHOa9tojBB+66HpjcOVkkL6AV9NsgHEQMLyrcm+hf0WEGD
         vZvQ==
X-Gm-Message-State: AJIora8kpbT2TZhklsfT+aAiK/kTngnIkyvOporaONA3wC/zizbcsEhV
        ipYZjmESSeUTHqGuXYHtaLuvMQ==
X-Google-Smtp-Source: AGRyM1sWwt7u1rTQL3JPhU9/TDBVwmyvsCTLPJg5D9wKXKP4XmGv+Ftymq6kH5fEnfwVfjO7Yh9vkw==
X-Received: by 2002:a17:902:eb8e:b0:16c:29dc:f1f3 with SMTP id q14-20020a170902eb8e00b0016c29dcf1f3mr38949744plg.22.1658321291126;
        Wed, 20 Jul 2022 05:48:11 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u14-20020a654c0e000000b0040d0a57be02sm11875401pgq.31.2022.07.20.05.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 05:48:10 -0700 (PDT)
Message-ID: <17dba691-2a2b-4b20-40c3-ec77282179b0@kernel.dk>
Date:   Wed, 20 Jul 2022 06:48:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5.10 1/1] io_uring: Use original task for req identity in
 io_identity_cow()
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
Cc:     stable@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220719115251.441526-1-lee@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220719115251.441526-1-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/19/22 5:52 AM, Lee Jones wrote:
> This issue is conceptually identical to the one fixed in 29f077d07051
> ("io_uring: always use original task when preparing req identity"), so
> rather than reinvent the wheel, I'm shamelessly quoting the commit
> message from that patch - thanks Jens:
> 
>  "If the ring is setup with IORING_SETUP_IOPOLL and we have more than
>   one task doing submissions on a ring, we can up in a situation where
>   we assign the context from the current task rather than the request
>   originator.
> 
>   Always use req->task rather than assume it's the same as current.
> 
>   No upstream patch exists for this issue, as only older kernels with
>   the non-native workers have this problem."

Greg, can you pick this one up for 5.10-stable? Thanks!

-- 
Jens Axboe

