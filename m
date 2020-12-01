Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2614D2CA410
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 14:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391125AbgLANkU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 08:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387761AbgLANkT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:40:19 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104E5C0613D4;
        Tue,  1 Dec 2020 05:39:39 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id g185so5021025wmf.3;
        Tue, 01 Dec 2020 05:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o1QhcMYXXxyjWayCG7R2wxOtCICzorG4ZDjEh80xwn4=;
        b=poVGaGGRAzMrEQ0wo4e9XGB0Qdkj7BjB2pW9j4l9X3hZqdyQzhAfETG09GL2pgSTNA
         vNVemUy3AYhUklA5RdG3eq994rxnkjWDoKTGXBQD3rmTDQUeaqmtszm5K2JQTxAJSsSf
         n/1M2bNJ/sJY9UF/1lAU4QoC1rpHIo3D6TAG2ANWCEGjrC8UyJFja8D14grT89Y5eOIW
         WIbFEVASMr9pZ3qdumZPFiVUKLkQyJwDXaASDjc+79m6W5E4+RJzKT+R65p0b+u3YgXc
         lJpj9FXJegBUquJl/SUsIspyOI/WrjKnN8oNMjrtFKjkCpMI7A/udWcVJ6/8kEc9nw4a
         L6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=o1QhcMYXXxyjWayCG7R2wxOtCICzorG4ZDjEh80xwn4=;
        b=F+vAYVeD9P1rcEYv12LYhu0n3H73ydV8z8BZSAodgnj5fRLVYkGzK7joc0/2g78aRm
         d6AWYw8zzDhfeDTxdKppI4EDFJ/vVYuApeZn++KNuj6yxiV0HxQ4gKJDC7ZRCcbhae4J
         dFWRN+pVXb9uFKVC4HtlsudR/Rx+zYbtFO/eI73V/KyeQQgfeMjUtUkwz2trNdIY4NcP
         MqB3BTPq/Y9xxIHOBkaA3gxufW7gdvh0PlNx1gy5coaK6hEpjzrP4SLPUMa3tjHLglhC
         +4LfsUKO6loeJuVmQC5tBsgc+/S/IQCXLa60NTYOl1Lhz5/APTK0TUCUO2HK0so8UY6U
         F9XQ==
X-Gm-Message-State: AOAM5337lb+kqzsaMhEYg8ksg3RXPL98hhIPvCJZa8fdS8Tws0sAzhQ3
        Antm3XqfB2mUgCgD1B4FvbA=
X-Google-Smtp-Source: ABdhPJzXsmOya++LqIuG0sJHax/rTpeuVHoUgv+ouxoe11okDUYIbDPkO+oKIMcb5lDNORghRT+XjA==
X-Received: by 2002:a1c:790f:: with SMTP id l15mr2823032wme.188.1606829977000;
        Tue, 01 Dec 2020 05:39:37 -0800 (PST)
Received: from [192.168.1.144] (host109-152-100-135.range109-152.btcentralplus.com. [109.152.100.135])
        by smtp.gmail.com with ESMTPSA id k16sm3234726wrl.65.2020.12.01.05.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 05:39:36 -0800 (PST)
Subject: Re: [PATCH] block: add bio_iov_iter_nvecs for figuring out nr_vecs
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>
References: <20201201120652.487077-1-ming.lei@redhat.com>
 <20201201125251.GA11935@casper.infradead.org>
 <20201201125936.GA25111@infradead.org>
 <fdbfe981-0251-9641-6ed8-db034c0f0148@gmail.com>
 <20201201133226.GA26472@infradead.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <6cbce034-b8c9-35d5-e805-f5ed0c169e2a@gmail.com>
Date:   Tue, 1 Dec 2020 13:36:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20201201133226.GA26472@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/12/2020 13:32, Christoph Hellwig wrote:
> On Tue, Dec 01, 2020 at 01:17:49PM +0000, Pavel Begunkov wrote:
>> I was thinking about memcpy bvec instead of iterating as a first step,
>> and then try to reuse passed in bvec.
>>
>> A thing that doesn't play nice with that is setting BIO_WORKINGSET in
>> __bio_add_page(), which requires to iterate all pages anyway. I have no
>> clue what it is, so rather to ask if we can optimise it out somehow?
>> Apart from pre-computing for specific cases...
>>
>> E.g. can pages of a single bvec segment be both in and out of a working
>> set? (i.e. PageWorkingset(page)).
> 
> Adding Johannes for the PageWorkingset logic, which keeps confusing me
> everytime I look at it.  I think it is intended to deal with pages
> being swapped out and in, and doesn't make much sense to look at in
> any form for direct I/O, but as said I'm rather confused by this code.
> 
> If PageWorkingset is a non-issue we should be able to just point the
> bio at the biovec array.  I think that be done by allocating the bio
> with nr_iovecs == 0, and then just updating >bi_io_vec and ->bi_vcnt
> using a little helper like this:

Yeah, that's the idea, but also wanted to verify that callers don't
free it while in use, or if that's not the case to make it conditional
by adding a flag in iov_iter.

Can anybody vow right off the bat that all callers behave well?

> 
> static inline void bio_assign_bvec(struct bio *bio, struct bio_vec *bvecs,
> 		unsigned short nr_bvecs)
> {
> 	WARN_ON_ONCE(BVEC_POOL_IDX(bio) != 0);
> 	bio->bi_io_vec = bvecs;
> 	bio->bi_vcnt = nr_bvecs;
> }
> 

-- 
Pavel Begunkov
