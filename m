Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397991E31E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 00:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391537AbgEZWBN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 18:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391369AbgEZWBL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 18:01:11 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E41C03E96D
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 15:01:10 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q9so432051pjm.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 15:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zZVgy2vaY7jEFsggwCG3LBMwvCBMjEaLZHkHxTnDDvk=;
        b=K9gsZ8zT3cxt3GfgIQHanpf/B7CYXSinl0fcm7TRKezmf7jNWFWuXK+2GFdvo43dDr
         of6KBrANKEoFtQEfW+djWPeH0LH0Zm5gZVqc5NlYGuR8lsDDUg7oBlRqifrDnq48XVov
         upxTuDkTmsiG1WqlkzqjLLUjlrUNGDYqVlHzuP6bFTEV2/moAaELS2MB1SlvtcOat8mW
         0JI/GSptTLODrg0ShTKIf4XF/8jQEDrlqDGYM9Gp71cATmHJkoAYvxo9V1kYEFn3wmFb
         8cxmiU5tvOI7O2/Z7M3F2d7B4v1eVkWH/NXTE+aCVDQHPP7DS3JXcwP0CA8UziWFDWE8
         pISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zZVgy2vaY7jEFsggwCG3LBMwvCBMjEaLZHkHxTnDDvk=;
        b=U1wcYzQaYl8jYUxBPTfBgzihKcRl204ussx1CRKxsrV1OmlTJgErBgseEErrZVB2Sp
         DwFxRwK3qY1AhDHnPjfjLQVsgVTzr0haUh4e8RYrkurEW8oLmYFR6SjcxZoftzycDPGI
         pMKclR3cYm40qoZQ/45jo2X7PL4NxFxnZBy9MPobkOUVEoIJNjk+Jc5lWaVdJXCoOMlk
         94tu3bBB0blA+81aS0L800bfMNgYuLHtmBlBfs71vetTEYbf5msJWJ1pPckDSCHKk1ql
         VLoqYBkfr4rdSgH6O3AwJibtT0O4GnAyx44RGNFo8G8sEPzv8soNTiqLEAGREUGBy/jB
         PoGQ==
X-Gm-Message-State: AOAM530J1KhbCfQ/e+1ANGk+bj+QJjEPkKhYz1rMuaA9kCJTmL+XTuef
        XXiH2rejIwimKNey8m5WnbWgpw==
X-Google-Smtp-Source: ABdhPJxLoWUFI2rzzX/tNrCylqa6XrMiWoTpJfv3EtVvMY4+UBWsKa7NQ24TWARybP1JK1WaB1gM2A==
X-Received: by 2002:a17:90a:8404:: with SMTP id j4mr1339430pjn.12.1590530469655;
        Tue, 26 May 2020 15:01:09 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:4922:2226:8cd7:a61e? ([2605:e000:100e:8c61:4922:2226:8cd7:a61e])
        by smtp.gmail.com with ESMTPSA id d195sm442643pfd.52.2020.05.26.15.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 15:01:09 -0700 (PDT)
Subject: Re: [PATCH 04/12] mm: add support for async page locking
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
References: <20200526195123.29053-1-axboe@kernel.dk>
 <20200526195123.29053-5-axboe@kernel.dk> <20200526215925.GC6781@cmpxchg.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <152529a5-adb4-fd7b-52ac-967500c011c9@kernel.dk>
Date:   Tue, 26 May 2020 16:01:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200526215925.GC6781@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/26/20 3:59 PM, Johannes Weiner wrote:
> On Tue, May 26, 2020 at 01:51:15PM -0600, Jens Axboe wrote:
>> Normally waiting for a page to become unlocked, or locking the page,
>> requires waiting for IO to complete. Add support for lock_page_async()
>> and wait_on_page_locked_async(), which are callback based instead. This
> 
> wait_on_page_locked_async() is actually in the next patch, requiring
> some back and forth to review. I wonder if this and the next patch
> could be merged to have the new API and callers introduced together?

I'm fine with that, if that is preferable. Don't feel strongly about
that at all, just tried to do it as piecemeal as possible to make
it easier to review.

-- 
Jens Axboe

