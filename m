Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F33389200
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 16:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354863AbhESOxk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 May 2021 10:53:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29218 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348668AbhESOxk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 May 2021 10:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621435940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9K4dmBQW5mNDLAKvbaAcsseV90GgNQIe7ZrAMNCE0S8=;
        b=SZcBL8tKsbplD3s4ZC5SjXp8bM55FRl4hq2ggWPRLSYDRxP8Ls1vnuuSjOmy8SfadCygjU
        d/8Y0ItZs1vgV2nbhUSOdhwauVawswhUNid9bMrsW783v9yqwwM+yfHVSwRqwggPY9mGrr
        TNlZb9Mopf2b+GjlfPlgcQmpdtL3Tqk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-fPCiCK14MVe1gmOh5i4zAg-1; Wed, 19 May 2021 10:52:18 -0400
X-MC-Unique: fPCiCK14MVe1gmOh5i4zAg-1
Received: by mail-qv1-f70.google.com with SMTP id f17-20020a0cf3d10000b02901eda24e6b92so10547404qvm.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 May 2021 07:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9K4dmBQW5mNDLAKvbaAcsseV90GgNQIe7ZrAMNCE0S8=;
        b=AEKO3lRmp048clkaMaxW6OaPTFCk1siViSAs6bPjEJkdDyIFGJTVU8xuX9iXPsFxG5
         s1xpdMR8C4v7S3hNgzqYirmGC6Sxkk8kmqgV9rmr4KnQmIy/6wcGY76gkPmQkIihj6nd
         wAAGeJmODju6USn3mKSu8XDq2RvMwN/1aasRU9WIPvBrZB3CCk+gVG1ToKYSkW5qoz+S
         hu7SBs0LX7ZwimXnAmGy0FwAQMfaMLLOd5MYrMOCz1AgfZu/s0VeQWydfyfhOBITUoAF
         LzAACgHrBhO2oiaEu3tVvl3q3THromIJoj3e/BkI1aarLuu3Zt0ytCnXcRg9T485P/iu
         QoMA==
X-Gm-Message-State: AOAM530FcWNeakzEva0p9hz6c66ZoclcFbQXiM4pP7hnQ+WHRjP2zXv/
        QlcKabSVtNqKMhXjZ6EN9/fSqRQxRpWhLMPNFGSNIpDxqqd+x1mMF5vuYKnnrfDtVuY/JlxQoM5
        QlROosqjv8O9dB6ColGbYNLEKyg==
X-Received: by 2002:ac8:5553:: with SMTP id o19mr11743485qtr.308.1621435937728;
        Wed, 19 May 2021 07:52:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOsigTUtmhANU4r4qDK1p3Br78jsKHKdzZdzxlM1WEqxA+fxQJwLJhQMkImuRMd+zRZXqoXg==
X-Received: by 2002:ac8:5553:: with SMTP id o19mr11743467qtr.308.1621435937546;
        Wed, 19 May 2021 07:52:17 -0700 (PDT)
Received: from bfoster ([98.216.211.229])
        by smtp.gmail.com with ESMTPSA id y8sm15814488qtn.61.2021.05.19.07.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:52:17 -0700 (PDT)
Date:   Wed, 19 May 2021 10:52:15 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v3 3/3] iomap: bound ioend size to 4096 pages
Message-ID: <YKUmH+JubDFH1jAH@bfoster>
References: <20210517171722.1266878-1-bfoster@redhat.com>
 <20210517171722.1266878-4-bfoster@redhat.com>
 <YKUSh4DVMCTzlSOE@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKUSh4DVMCTzlSOE@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 19, 2021 at 02:28:39PM +0100, Christoph Hellwig wrote:
> On Mon, May 17, 2021 at 01:17:22PM -0400, Brian Foster wrote:
> > The iomap writeback infrastructure is currently able to construct
> > extremely large bio chains (tens of GBs) associated with a single
> > ioend. This consolidation provides no significant value as bio
> > chains increase beyond a reasonable minimum size. On the other hand,
> > this does hold significant numbers of pages in the writeback
> > state across an unnecessarily large number of bios because the ioend
> > is not processed for completion until the final bio in the chain
> > completes. Cap an individual ioend to a reasonable size of 4096
> > pages (16MB with 4k pages) to avoid this condition.
> 
> Note that once we get huge page/folio support in the page cache this
> sucks as we can trivially handle much larger sizes with very little
> iteration.
> 
> I wonder if both this limit and the previous one should be based on the
> number of pages added instead.  And in fact maybe if we only want the
> limit at add to ioend time and skip the defer to workqueue part entirely.
> 

Both limits are already based on pages. I imagine they could change to
folios when appropriate.

The defer to workqueue part was based on your suggestion[1]. The primary
purpose of this series is to address the completion processing soft
lockup warning, so I don't have a strong preference on whether we do
that by capping ioend size, processing (and yielding) from non-atomic
context, or both.

Brian

[1] https://lore.kernel.org/linux-fsdevel/20200917080455.GY26262@infradead.org/

