Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E53031587B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 22:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbhBIVS2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 16:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbhBIUq7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:46:59 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF979C061225
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Feb 2021 12:11:55 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id u20so20135034iot.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Feb 2021 12:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l6WEwLkb2xy2/U0iy3Xy7JNwk+HVvUNszayLkKhjccg=;
        b=Z5YpwGg4VqyRP4sS3NjVEYzyqvsMqoVzKJFdJRvgySsfLXuj+4g51FQv7laeuDjbK/
         WkjVW3P7YRJm5dan4lwtyid+A3NtH26DAW5gQAyF91b3n5U7G543cmlPFfhm87HH78qf
         eXfYxkSfc7/7UCHC5xB+MPOLyEiijUfJTWxmmhTzSh6RdH+kuefG1Egkm6z6a3+AsEfk
         mB+56F7MwSeTs5xWDqX+pm5nbvPWLasnto16x8rJmZ5ArdC3mnt3czSVZUFRpmEAyNjl
         YBDri2oTR1TCRJ4X+eoZnpQfFKzEGY01/Do2JFg4Qfz3/Bs9B3qn/lFG034GQ6b3sUx2
         tnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l6WEwLkb2xy2/U0iy3Xy7JNwk+HVvUNszayLkKhjccg=;
        b=itGQ+eSafxzpj3XtcOsc54fy58aLrS9pA8EZwuwE+DdDJ6rkZ0mZnuJRNUB6EBvUsg
         v42EUrUJqnI8JdzemYhTsCQy4V3jjfs7iYMqiF393kLx6hgoc7mQl9zl15hAsayQXJV7
         jhi9raqNf55kp/yynLTVz5s53dI0L8AxiuWDW12/bUD+k56N35/ulMwwdSDHuoW3zhjL
         2VdXF+DR4ypmw2CRR55mqgMLG99YdSEk2yD8tCwIeWaOLNrBvUK3oSU9aQP4oMqonVNB
         7ACY3/Jm/+J/mMB/nHJJR7MVLe0DA+3vTQ+pemaM03oecrUrKO1xChEVOXZudd5WVMoD
         qtWg==
X-Gm-Message-State: AOAM530VNMyxBO/m87REQK9tSNFlRg9wsWQDe98bCJEn16sy/9DAKPZ1
        h6Yg1XOhh4TEm1Ze+BXjSaOg1A==
X-Google-Smtp-Source: ABdhPJxBV4JmG8c9o+4rIIGWzH552WvaEd8txOY2QEoNd9EsHL9oGHmfTXY3FSoFra7b774RnO+qjg==
X-Received: by 2002:a6b:680e:: with SMTP id d14mr20634422ioc.74.1612901515134;
        Tue, 09 Feb 2021 12:11:55 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b1sm4393212iob.42.2021.02.09.12.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 12:11:54 -0800 (PST)
Subject: Re: [PATCHSET v2 0/3] Improve IOCB_NOWAIT O_DIRECT reads
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        hch@infradead.org
References: <20210209023008.76263-1-axboe@kernel.dk>
 <20210209115542.3e407e306a4f1af29257c8f6@linux-foundation.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <32dba5cc-7878-3b7b-45e4-84690a45a998@kernel.dk>
Date:   Tue, 9 Feb 2021 13:11:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210209115542.3e407e306a4f1af29257c8f6@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/9/21 12:55 PM, Andrew Morton wrote:
> On Mon,  8 Feb 2021 19:30:05 -0700 Jens Axboe <axboe@kernel.dk> wrote:
> 
>> Hi,
>>
>> For v1, see:
>>
>> https://lore.kernel.org/linux-fsdevel/20210208221829.17247-1-axboe@kernel.dk/
>>
>> tldr; don't -EAGAIN IOCB_NOWAIT dio reads just because we have page cache
>> entries for the given range. This causes unnecessary work from the callers
>> side, when the IO could have been issued totally fine without blocking on
>> writeback when there is none.
>>
> 
> Seems a good idea.  Obviously we'll do more work in the case where some
> writeback needs doing, but we'll be doing synchronous writeout in that
> case anyway so who cares.

Right, I think that'll be a round two on top of this, so we can make the
write side happier too. That's a bit more involved...

> Please remind me what prevents pages from becoming dirty during or
> immediately after the filemap_range_needs_writeback() check?  Perhaps
> filemap_range_needs_writeback() could have a comment explaining what it
> is that keeps its return value true after it has returned it!

It's inherently racy, just like it is now. There's really no difference
there, and I don't think there's a way to close that. Even if you
modified filemap_write_and_wait_range() to be non-block friendly,
there's nothing stopping anyone from adding dirty page cache right after
that call.

-- 
Jens Axboe

