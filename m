Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B7F4837EC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jan 2022 21:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiACUKi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jan 2022 15:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiACUKi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jan 2022 15:10:38 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E9CC061761
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jan 2022 12:10:37 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id kk22so32100621qvb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jan 2022 12:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=B6cJU8nUUHYKdvDmldo02pUWTeqS+YG5TTvHjwEsWPU=;
        b=lVvKTKyvI3NLQtkFTAhATKtPuyBuuPR4NWtBrpBm7gxtLNm1yIYrxvFMQSXZFa/I90
         MGMYHPYSROO2Hh2246WjncaSVMdPxxxYJNIoVohoe67x/uA+RPtxoeXCp6gX2+seizsc
         4PJUWD4M1n7i5y22BmhN7Rm4NqLuktyQWG5UIZLp2gdKoznRn7i1uzyyzBQPMND/Ri3S
         X2oEy/jmx4O3MzBPgB7TWX1tFVTz4Rne3vQRMJbuql8UdJg94nOh4tacduLI+5sZSXh1
         iRHjc/4033hTpD3x/iLxzyC/UWs4aOr+9oFPwoD6VcdJpKehPWOuII/4VejFzlAVMLoC
         5vtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=B6cJU8nUUHYKdvDmldo02pUWTeqS+YG5TTvHjwEsWPU=;
        b=OfEOsHQZqk9F+fYKGI+vYG+mSPoY5qPlqqsT5FolL52BVyb8rYXxDArpDHURJaYRd3
         ckB3ol4InfzNw1PWc8UXn3Ji5Ps6romxhzhixvrnvQhhzj0IEru1vUr8LVyTnMFPhOci
         Q5EyyX1Zj2y7rToYDHrGCjPMW6xQs7vWOJD/0mpDpSIhKnXGtlfV/6bsGNe95A3Qsp+w
         Zi+he1zD9Zh5FBPmq1FN4UAahpKFAPI1Rd6MtRPSW2nDH2QB9eDVj5+TCmHivfnyXHSu
         XoIh7bA7naAhtFLi1+gosbyhSsdDyNQAfnRr7fGhEfQfY0ADNd0MI1mhFKNvpWPONpX/
         5s3A==
X-Gm-Message-State: AOAM533e4bdPAJjabLbL1wM7tJ5j0SNIl8v8qn/gnHU8I001J/TAtUM1
        M8cdrirgOm3T0r8eM0hXbDEooQ==
X-Google-Smtp-Source: ABdhPJy6M0drJX0wQ6xu4CXGfaUHQKjFKlsG9NcckbXNpYiM8S9gl9icl65iX/SDx6NqPlYG+x4VkQ==
X-Received: by 2002:ad4:5bc1:: with SMTP id t1mr43989461qvt.72.1641240636522;
        Mon, 03 Jan 2022 12:10:36 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id u9sm30948968qta.17.2022.01.03.12.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 12:10:35 -0800 (PST)
Date:   Mon, 3 Jan 2022 12:10:21 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH next 3/3] shmem: Fix "Unused swap" messages
In-Reply-To: <YdMYCFIHA/wtcDVV@casper.infradead.org>
Message-ID: <2da9d057-8111-5759-a0dc-d9dca9fb8c9f@google.com>
References: <49ae72d6-f5f-5cd-e480-e2212cb7af97@google.com> <YdMYCFIHA/wtcDVV@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 3 Jan 2022, Matthew Wilcox wrote:
> On Sun, Jan 02, 2022 at 05:35:50PM -0800, Hugh Dickins wrote:
> > shmem_swapin_page()'s swap_free() has occasionally been generating
> > "_swap_info_get: Unused swap offset entry" messages.  Usually that's
> > no worse than noise; but perhaps it indicates a worse case, when we
> > might there be freeing swap already reused by others.
> > 
> > The multi-index xas_find_conflict() loop in shmem_add_to_page_cache()
> > did not allow for entry found NULL when expected to be non-NULL, so did
> > not catch that race when the swap has already been freed.
> > 
> > The loop would not actually catch a realistic conflict which the single
> > check does not catch, so revert it back to the single check.
> 
> I think what led to the loop was concern for the xa_state if trying
> to find a swap entry that's smaller than the size of the folio.
> So yes, the loop was expected to execute twice, but I didn't consider
> the case where we were looking for something non-NULL and actually found
> NULL.
> 
> So should we actually call xas_find_conflict() twice (if we're looking
> for something non-NULL), and check that we get @expected, followed by
> NULL?

Sorry, I've no idea.

You say "twice", and that does not fit the imaginary model I had when I
said "The loop would not actually catch a realistic conflict which the
single check does not catch".

I was imagining it either looking at a single entry, or looking at an
array of (perhaps sometimes in shmem's case 512) entries, looking for
conflict with the supplied pointer/value expected there.

The loop technique was already unable to report on unexpected NULLs,
and the single test would catch a non-NULL entry different from an
expected non-NULL entry.  Its only relative weakness appeared to be
if that array contained (perhaps some NULLs then) a "narrow" instance
of the same pointer/value that was expected to fill the array; and I
didn't see any possibility for shmem to be inserting small and large
folios sharing the same address at the same time.

That "explanation" may make no sense to you, don't worry about it;
just as "twice" makes no immediate sense to me - I'd have to go off
and study multi-index XArray to make sense of it, which I'm not
about to do.

I've seen no problems with the proposed patch, but if you see a real
case that it's failing to cover, yes, please do improve it of course.

Though now I'm wondering if the "loop" totally misled me; and your
"twice" just means that we need to test first this and then that and
we're done - yeah, maybe.

Hugh
