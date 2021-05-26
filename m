Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097B5390DD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 03:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbhEZBMh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 21:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbhEZBMf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 21:12:35 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426F9C061760
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 May 2021 18:11:04 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso14182149pjb.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 May 2021 18:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n1vqEZBGLprA2KRsF5CbYK+jjEOh+Oi6OXwMO+wvSVI=;
        b=WuYZFf9pPBvFYy2KVJ+JeTztCg54+n2ulU+NAv5b3DeK97olpQ+DI0bkxtj4PEUS/r
         cJ5ieoM4B4W6rvdU8Jn6ugqpgujukUkcDf4uIlxiJpsYGwScXb9sCO7uQdmwMlkUR+gQ
         D9f21SnXgMXicqtWAihqgwM8R4JlW1GJM67Z9B99qnP4exZtkg0qPunTxBWSslQhoF52
         Gn37vsVBCOExHCikYoDlP2qCU4u+Gp9NA1OGTxKdqf2wZ+y+tv98ulwRY9n/B4MLCLho
         9OrmQva35tNquiDhuw4FNI0JAA3jFs2bFKQpP2vuEYxdeAAPrxD1SAB3QoCnBrECtruk
         vdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n1vqEZBGLprA2KRsF5CbYK+jjEOh+Oi6OXwMO+wvSVI=;
        b=IWRFhTlY7cGMUL2hQ+cXdBLfRkXsUPPxKJz6DDjWL+5BByuvyZZI4vPaS9Rf4WFqIg
         21Tlb1nghjaAzlk0Vun8eLem8lrigI/QefxcBTLpummAGnUFVzlWFZgjrWORHU07JKsd
         +sTWupQvuDA15hlHj0CjjRq5l4wZsQvfY4AtdG29xvspJyBQX/uneV4SaW7WFCTsCymd
         RAo0fw/RSg/QH+CqtzwohXA3hOKqWyx8+2Kg4eNbQxpCZhHo01gG7cRXEQtEe3gyWbdd
         hqmwLbTMhuUi7G+SZ447Hn4uFazwMkYkT0yJ24LRBbXL+4q+PIeffuhvnjJ8CpsHa2Wp
         aGXA==
X-Gm-Message-State: AOAM5318U2YxriX/RcNEJG5HuVq293sDT1kekRNDYaNqPPval6yb8Q8p
        JQmPNrQat3AG1rhaGP6OG2Hh5f3T3FLQWg==
X-Google-Smtp-Source: ABdhPJzTq1BXr13mX/eHChxkke6tkaDYa/yW1HITGoscwaWg16pQb3fNkCRib6Tb05YzZyjvZz4LUQ==
X-Received: by 2002:a17:90b:1b4f:: with SMTP id nv15mr1202085pjb.56.1621991463564;
        Tue, 25 May 2021 18:11:03 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id m1sm15068322pfb.14.2021.05.25.18.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 18:11:03 -0700 (PDT)
Subject: Re: [RFC PATCH 2/9] audit,io_uring,io-wq: add some basic audit
 support to io_uring
To:     Paul Moore <paul@paul-moore.com>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <162163367115.8379.8459012634106035341.stgit@sifl>
 <162163379461.8379.9691291608621179559.stgit@sifl>
 <f07bd213-6656-7516-9099-c6ecf4174519@gmail.com>
 <CAHC9VhRjzWxweB8d8fypUx11CX6tRBnxSWbXH+5qM1virE509A@mail.gmail.com>
 <162219f9-7844-0c78-388f-9b5c06557d06@gmail.com>
 <CAHC9VhSJuddB+6GPS1+mgcuKahrR3UZA=1iO8obFzfRE7_E0gA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8943629d-3c69-3529-ca79-d7f8e2c60c16@kernel.dk>
Date:   Tue, 25 May 2021 19:11:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSJuddB+6GPS1+mgcuKahrR3UZA=1iO8obFzfRE7_E0gA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/24/21 1:59 PM, Paul Moore wrote:
> That said, audit is not for everyone, and we have build time and
> runtime options to help make life easier.  Beyond simply disabling
> audit at compile time a number of Linux distributions effectively
> shortcut audit at runtime by adding a "never" rule to the audit
> filter, for example:
> 
>  % auditctl -a task,never

As has been brought up, the issue we're facing is that distros have
CONFIG_AUDIT=y and hence the above is the best real world case outside
of people doing custom kernels. My question would then be how much
overhead the above will add, considering it's an entry/exit call per op.
If auditctl is turned off, what is the expectation in turns of overhead?

My gut feeling tells me it's likely going to be too much. Keep in mind
that we're sometimes doing millions of operations per second, per core.

aio never had any audit logging as far as I can tell. I think it'd make
a lot more sense to selectively enable audit logging only for opcodes
that we care about. File open/create/unlink/mkdir etc, that kind of
thing. File level operations that people would care about logging. Would
they care about logging a buffer registration or a polled read from a
device/file? I highly doubt it, and we don't do that for alternative
methods either. Doesn't really make sense for a lot of the other
operations, imho.

-- 
Jens Axboe

