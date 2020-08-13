Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51811243E66
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 19:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHMRgQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 13:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgHMRgQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 13:36:16 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9450CC061383
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 10:36:15 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id h21so4949079qtp.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 10:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9jlgVFW8cz8UnSK84wDsTo/KXIXNWwrMl6cC3LnDPv4=;
        b=sh9bDuKNQMwxUwVp6W0+Ns5Wb6IFR/6zaqA7W8oYXVDOzc057MiRpQRRowgHDaiTcB
         9Ya1PtztpYgdTWwe0T5BJj1i51Hhtk0jvbtA5BKV74/xlz4I9cQyMnn4o6QzfCRbrpNG
         QDr/OjEW6cURvv2WL7nwGhwuF9yXQTvCSA4zVOnhtS2e/t9IK/Vx7TftKDprRdCQ6syW
         6CGAOl+bKUHCHZorXS+ITQ5uEj3Ti482H7qSNPceuvvgtrKbIEJpjtbbWw0GwCqhL2Ag
         vDXyRamOoNmA41Zw66ARN1ICqsdSyYiQxfy6odqZ7QA0eqjl1352w9f47ZmRS8Ci/uIg
         XFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9jlgVFW8cz8UnSK84wDsTo/KXIXNWwrMl6cC3LnDPv4=;
        b=j5Q0E//48kuV6l1Hs1q7pA2yx4ue0Tn+N7uDZekpPJ9r3AaaSfyaY0dQmuCK48xm8r
         fhCOim0LJegFasos0ASr+CgieDN/NMXOPoRD59mlDfoK7xEZOtY+t2Ql+dWiyaEV+VHc
         9lRcDwMJX8QAalsDfVOn4bT5006deN3MO77HeY3UfgBWGsmwc3gGg7WTNA3RcAC4+1cZ
         XqkMOVto/VJYRf2p0yYazjcI3IyZ+UZ0hstg8yxQIZp2b782kJdjxW1N4jvjgtKWywxX
         va5AkwPiB472VjLZvNZ/78zgcEtuVQkWZdwDh7Xu8j+SNBRAHiKzBO+lV3NNo17EFeRO
         Y8jQ==
X-Gm-Message-State: AOAM530o/m6q0AV95Hp3NusFPvFAavLQ/2q7zDpyos+18gjq4n/ji15N
        G/HiBvsTTZWVdkZEy8vWdHz8mki9uAgLGQ==
X-Google-Smtp-Source: ABdhPJwcBT77VtkJvOLSXrChnmBFxnV8JMfwBEiMNmK4kd7czs7VLFEY5kTfvotc/2tTVE70a5XNIg==
X-Received: by 2002:ac8:349a:: with SMTP id w26mr6584026qtb.263.1597340171930;
        Thu, 13 Aug 2020 10:36:11 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::10a7? ([2620:10d:c091:480::1:fe9c])
        by smtp.gmail.com with ESMTPSA id i68sm6007004qkb.58.2020.08.13.10.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 10:36:10 -0700 (PDT)
Subject: Re: [PATCH][v2] proc: use vmalloc for our kernel buffer
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@fb.com,
        willy@infradead.org
References: <20200813145305.805730-1-josef@toxicpanda.com>
 <20200813153356.857625-1-josef@toxicpanda.com>
 <20200813153722.GA13844@lst.de>
 <974e469e-e73d-6c3e-9167-fad003f1dfb9@toxicpanda.com>
 <20200813154117.GA14149@lst.de> <20200813162002.GX1236603@ZenIV.linux.org.uk>
 <9e4d3860-5829-df6f-aad4-44d07c62535b@toxicpanda.com>
 <20200813173155.GZ1236603@ZenIV.linux.org.uk>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <34b2d8f2-d10a-a9fd-3b5e-470cb8c4251d@toxicpanda.com>
Date:   Thu, 13 Aug 2020 13:36:09 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200813173155.GZ1236603@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/13/20 1:31 PM, Al Viro wrote:
> On Thu, Aug 13, 2020 at 01:19:18PM -0400, Josef Bacik wrote:
> 
>>> in sunrpc proc_dodebug() turns into
>>> 		left -= snprintf(buffer, left, "0x%04x\n",
> 					 ^^^^
> 					 left + 1, that is.
> 
>>> 				 *(unsigned int *) table->data);
>>> and that's not the only example.
>>>
>>
>> We wouldn't even need the extra +1 part, since we're only copying in how
>> much the user wants anyway, we could just go ahead and convert this to
>>
>> left -= snprintf(buffer, left, "0x%04x\n", *(unsigned int *) table->data);
>>
>> and be fine, right?  Or am I misunderstanding what you're looking for?  Thanks,
> 
> snprintf() always produces a NUL-terminated string.  And if you are passing 7 as
> len, you want 0xf0ad\n to be copied to user.  For that you need 8 passed to
> snprintf, and 8-byte buffer given to it.
> 

Right, gotcha.  I'll rig that up and see how it looks.  I'd recommend looking 
through what I do with a fine tooth comb, I'm obviously not batting 1000 today. 
Thanks,

Josef
