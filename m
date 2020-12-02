Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7EC2CC2DE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 17:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbgLBQ5l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 11:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730542AbgLBQ5k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:57:40 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863C3C061A4F
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Dec 2020 08:56:53 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id p5so2156782iln.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Dec 2020 08:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QPknBxtQoCpT/zvKKXpkK/ZoNkojGaFc65IMqcOjeCo=;
        b=znT+GrC5ntQsghSmwd5WkHL3YyU0u2hS19p2l25n+qsOlECRun1wQOJ1DtAoqGdodf
         PF5JAPnJCuBUwxdNrk6p4h+FIJg2BqSsMNaewCVgWso+ViL/rtZ+rgVDHcOkgS2BE9eW
         APSE5ahzEyaYTydVbHwbo3esRnf7gdOYytcFoHbX+1dcSZKmx4rz9RhEpJsFDBFSUX7E
         8AEWLMykbOFYAAya4uUWrV+jPXSOvrwlNTfJ0lEIWsYXpx8Anmxoyb9/AYHbj30JFTdW
         AYqgFXSJhi5gMOIPnQVXDTYpROxYpOv5zke96hODa5KIF9AqgvUKDqw65sOKwbrzH1bS
         +6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QPknBxtQoCpT/zvKKXpkK/ZoNkojGaFc65IMqcOjeCo=;
        b=hVHsNTOGWfZcPFPUFOvQYdxjHborlbPS8gTHfFdwbTe9pPYwVFFt6WcHDagmHGzKxS
         rXxJuqoA4r7Lkbg1Dk3UNkS1w3ctW57BQByUFUgbHMIT1v0ilvi2JcBOXsF/sHrhc3r+
         Ukco9S2ra4LruvEcF+kbIiAhDqCWm/IHr9zlPPA05VQYZ4qIgxByez7IiYg491LLTpQl
         1KVkl9OXIRuM1U/Rk4ugHrHdj7Nu4zcKxqeDLALEos1iplopQ85ROy/0U6V+DpWrYj8a
         xIw8k7xzJhRjTzyGk6T4KU1SihLkznrur8hTKgtu5EiBKcMfOdAJ1DatWmxPbGAZl2EP
         xbng==
X-Gm-Message-State: AOAM53140RBkRtj4QeVlSVrcXnkIkNIlR3KNeHJ0hNx6DlOvEXG/gnbw
        cPbwd9d7qFg0jdyb6ymOC1u7mIZqMHCS/A==
X-Google-Smtp-Source: ABdhPJyxz4IgRtE5sxlFOWEwmI1ekbF5NyPTv+/LiPUVGAiUYzljzebwvQt0VpHBPvn/n7GDuyx3RA==
X-Received: by 2002:a92:c88d:: with SMTP id w13mr3003916ilo.37.1606928212666;
        Wed, 02 Dec 2020 08:56:52 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p18sm1376199ile.27.2020.12.02.08.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 08:56:52 -0800 (PST)
Subject: Re: [PATCH] block: add bio_iov_iter_nvecs for figuring out nr_vecs
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
References: <20201201120652.487077-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <335f3f7a-8b24-8ef2-8481-0139687d0dbb@kernel.dk>
Date:   Wed, 2 Dec 2020 09:56:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201201120652.487077-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/1/20 5:06 AM, Ming Lei wrote:
> Pavel reported that iov_iter_npages is a bit heavy in case of bvec
> iter.
> 
> Turns out it isn't necessary to iterate every page in the bvec iter,
> and we call iov_iter_npages() just for figuring out how many bio
> vecs need to be allocated. And we can simply map each vector in bvec iter
> to bio's vec, so just return iter->nr_segs from bio_iov_iter_nvecs() for
> bvec iter.
> 
> Also rename local variable 'nr_pages' as 'nr_vecs' which exactly matches its
> real usage.

I'd really prefer to keep the renaming separate from the actual change.

-- 
Jens Axboe

