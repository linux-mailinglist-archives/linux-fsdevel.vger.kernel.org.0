Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606F3483B4E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 05:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbiADEn3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jan 2022 23:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbiADEn2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jan 2022 23:43:28 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296EEC061761
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jan 2022 20:43:28 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id 8so33004511qtx.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jan 2022 20:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=CW2kPaIY0icWUcxbVsTFLeQfZch9KHCZurdTKrLZPqw=;
        b=tlw+CvjUE0mYOzSj55uc3c34dYEJMLzY2/DNOXKxkufmtiwqbBO/atLlLeB2xo+KMx
         h28cfrFIFcrtuNvlpyjfGzBXhPyMY/lpQV139btmvFVkPsZrq+s0tjZ24Xwi7eNZPyIx
         8M9K67SpvGlsL5zgF0Ku0YbVnUHe0qQxupenZKHdnuluNqmSi9NYyzwBv4duAUIYC9L5
         QdakPHFzws9fN2i6RnSrJ6kqKYy0EcDgXT0jGGC4WJwMuqqZOFhDRGXslcd6G/j/Gtv/
         u6TruD3WYJzM5WCR5gJvShdYEHjaQB85w4lwsCJewzRHxzcB9MX2Zl/jcVG5QcebPu7a
         YUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=CW2kPaIY0icWUcxbVsTFLeQfZch9KHCZurdTKrLZPqw=;
        b=6A/CYrVHnDXCgGcSAtfc4CqB9QrmL36pmPqLb1hDk+s/eHn79R62Yqg2sLWjUoJdEr
         TnmJ9uXH8m53CAJzZcPpi77Bc6VqFl58fbY3xW2iYDcr5DNrGMPKFpbWdLmRMUBJWsiD
         4AlmuvFyFeH2rM6QmE1L+QvtHoCZmaa8fTorxfKtdPkNbZAes2ib+PAqkUmqefwj/RFC
         VEUqn1RSmMFgI5LikyfKbLRHM1M9gdvOPjmfWv35oWVdBoAfCiMyAwveR1aqxTLFIQMB
         j1aHR8Zntns2iJpFkNwXK+bn2XQQk+4PDFO3bxJoo6PtqvZKTizteoeGrTzXJnyi5rsK
         JuFw==
X-Gm-Message-State: AOAM532eylMY0lcQENxyt9XcWkG+DnmKlF9w56+MlaMBD67B0JHXLNRy
        hu3TD0HlwMokp+XwxPro2eX9tg==
X-Google-Smtp-Source: ABdhPJxwDeAfheaunYE6z4c/HeunT4dIxQMVHT6ew99a8LKQp7o/1XEM1/jddaELDnZ2b0K/57zTAg==
X-Received: by 2002:a05:622a:e:: with SMTP id x14mr42830980qtw.280.1641271406936;
        Mon, 03 Jan 2022 20:43:26 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k8sm31798021qtx.35.2022.01.03.20.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 20:43:26 -0800 (PST)
Date:   Mon, 3 Jan 2022 20:43:13 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH next 3/3] shmem: Fix "Unused swap" messages
In-Reply-To: <YdOlt5FJn9L+3sjM@casper.infradead.org>
Message-ID: <2fb90c3-5285-56ca-65af-439c4527dbe4@google.com>
References: <49ae72d6-f5f-5cd-e480-e2212cb7af97@google.com> <YdMYCFIHA/wtcDVV@casper.infradead.org> <2da9d057-8111-5759-a0dc-d9dca9fb8c9f@google.com> <YdOlt5FJn9L+3sjM@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 4 Jan 2022, Matthew Wilcox wrote:
> On Mon, Jan 03, 2022 at 12:10:21PM -0800, Hugh Dickins wrote:
> > On Mon, 3 Jan 2022, Matthew Wilcox wrote:
> > > On Sun, Jan 02, 2022 at 05:35:50PM -0800, Hugh Dickins wrote:
> > > > shmem_swapin_page()'s swap_free() has occasionally been generating
> > > > "_swap_info_get: Unused swap offset entry" messages.  Usually that's
> > > > no worse than noise; but perhaps it indicates a worse case, when we
> > > > might there be freeing swap already reused by others.
> > > > 
> > > > The multi-index xas_find_conflict() loop in shmem_add_to_page_cache()
> > > > did not allow for entry found NULL when expected to be non-NULL, so did
> > > > not catch that race when the swap has already been freed.
> > > > 
> > > > The loop would not actually catch a realistic conflict which the single
> > > > check does not catch, so revert it back to the single check.
> > > 
> > > I think what led to the loop was concern for the xa_state if trying
> > > to find a swap entry that's smaller than the size of the folio.
> > > So yes, the loop was expected to execute twice, but I didn't consider
> > > the case where we were looking for something non-NULL and actually found
> > > NULL.
> > > 
> > > So should we actually call xas_find_conflict() twice (if we're looking
> > > for something non-NULL), and check that we get @expected, followed by
> > > NULL?
> > 
> > Sorry, I've no idea.
> > 
> > You say "twice", and that does not fit the imaginary model I had when I
> > said "The loop would not actually catch a realistic conflict which the
> > single check does not catch".
> > 
> > I was imagining it either looking at a single entry, or looking at an
> > array of (perhaps sometimes in shmem's case 512) entries, looking for
> > conflict with the supplied pointer/value expected there.
> > 
> > The loop technique was already unable to report on unexpected NULLs,
> > and the single test would catch a non-NULL entry different from an
> > expected non-NULL entry.  Its only relative weakness appeared to be
> > if that array contained (perhaps some NULLs then) a "narrow" instance
> > of the same pointer/value that was expected to fill the array; and I
> > didn't see any possibility for shmem to be inserting small and large
> > folios sharing the same address at the same time.
> > 
> > That "explanation" may make no sense to you, don't worry about it;
> > just as "twice" makes no immediate sense to me - I'd have to go off
> > and study multi-index XArray to make sense of it, which I'm not
> > about to do.
> > 
> > I've seen no problems with the proposed patch, but if you see a real
> > case that it's failing to cover, yes, please do improve it of course.
> > 
> > Though now I'm wondering if the "loop" totally misled me; and your
> > "twice" just means that we need to test first this and then that and
> > we're done - yeah, maybe.
> 
> Sorry; I wrote the above in a hurry and early in the morning, so probably
> even less coherent than usual.  Also, the multi-index xarray code is
> new to everyone (and adds new things to consider), so it's no surprise
> we're talking past each other.  It's a bit strange for me to read your
> explanations because you're only reading what I actually wrote instead
> of what I intended to write.
> 
> So let me try again.  My concern was that we might be trying to store
> a 2MB entry which had a non-NULL 'expected' entry which was found in a
> 4k (ie single-index) slot within the 512 entries (as the first non-NULL
> entry in that range), and we'd then store the 2MB entry into a
> single-entry slot.

Thanks, that sounds much more like how I was imagining it.  And the
two separate tests much more understandable than twice round a loop.

> 
> Now, maybe that can't happen for higher-level reasons, and I don't need
> to worry about it.  But I feel like we should check for that?  Anyway,
> I think the right fix is this:

I don't object to (cheaply) excluding a possibility at the low level,
even if there happen to be high level reasons why it cannot happen at
present.

But I don't think your second xas_find_conflict() gives quite as much
assurance as you're expecting of it.  Since xas_find_conflict() skips
NULLs, the conflict test would pass if there were 511 NULLs and one
4k entry matching the expected entry, but a 2MB entry to be inserted
(the "small and large folios" case in my earlier ramblings).

I think xas_find_conflict() is not really up to giving that assurance;
and maybe better than a second call to xas_find_conflict(), might be
a VM_BUG_ON earlier, to say that if 'expected' is non-NULL, then the
range is PAGE_SIZE - or something more folio-friendly like that?
That would give you the extra assurance you're looking for,
wouldn't it?

For now and the known future, shmem only swaps PAGE_SIZE, out and in;
maybe someone will want to change that one day, then xas_find_conflict()
could be enhanced to know more of what's expected.

> 
> +++ b/mm/shmem.c
> @@ -733,11 +733,12 @@ static int shmem_add_to_page_cache(struct page *page,
>         cgroup_throttle_swaprate(page, gfp);
> 
>         do {
> -               void *entry;
>                 xas_lock_irq(&xas);
> -               while ((entry = xas_find_conflict(&xas)) != NULL) {
> -                       if (entry == expected)
> -                               continue;
> +               if (expected != xas_find_conflict(&xas)) {
> +                       xas_set_err(&xas, -EEXIST);
> +                       goto unlock;
> +               }
> +               if (expected && xas_find_conflict(&xas)) {
>                         xas_set_err(&xas, -EEXIST);
>                         goto unlock;
>                 }

That also worried me because, if the second xas_find_conflict()
is to make any sense, the first must have had a side-effect on xas:
are those side-effects okay for the subsequent xas_store(&xas, page)?
You'll know that they are, but it's not obvious to the reader.

> 
> which says what I mean.  I certainly didn't intend to imply that I
> was expecting to see 512 consecutive entries which were all identical,
> which would be the idiomatic way to read the code that was there before.
> I shouldn't've tried to be so concise.
> 
> (If you'd rather I write any of this differently, I'm more than happy
> to change it)

No, I'm happy with the style of it, just discontented that the second
xas_find_conflict() pretends to more than it provides (I think).

Hugh
