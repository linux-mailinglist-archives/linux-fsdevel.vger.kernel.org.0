Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7951F36882D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 22:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239273AbhDVUrW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 16:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236877AbhDVUrV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:47:21 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC07C061756
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Apr 2021 13:46:46 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id v7so19668676qkj.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Apr 2021 13:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=q4jCK/oxeOAevJ+QQnM3lBiBwG2OGtnOoyI45WiPj/0=;
        b=bm4tK+1+ztG0fhpXNYfdvm16338ubpObJL9yXAF6z5QbYek+XJkIPN5icxfAhQHZa9
         5vHU3s4lI+K4LhMXS4o7k/nfFp4h1T2D/2idlxRt2E+KH+8MEGjnqj6WbRW/Occrn1ub
         GMWABtxA3Qa0pH+5bHwmHxHV0ytVM5PRa+hCytRC60NI1y2hUOh7ieNd8+12D82HvYI5
         pTvN2mA66wfz1vd/dws+vtpU3kad6SV58lBRADz1VW6ZlvOvb8n4NfQv/NWfbrGmF8zN
         oD/0RCCjhIsKhandoRbU8KeYRvL+FzxbFIC6PK27w2Mg/ng/a/zrM37IDErgPKI7m1v0
         /uOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=q4jCK/oxeOAevJ+QQnM3lBiBwG2OGtnOoyI45WiPj/0=;
        b=B+12IrvH6DUEV0jELUcur+t8b4NplooquvoJEJQznd5YTyg74xjKsBA1TS2bgzmwl5
         e4z3v4zY3x4PyVpwMYvWgpdCZfbL5Xv+NPkdl0+2S+DDDsE1FpQrKrX0CBTMz8ce2MEO
         oQg9JLaxrmRtIm1Z8+6GFCUaovVHDcA/frSzLL2z9Qw6PrjetYRIjfy610vfndOLiZWX
         DZ8qpFGamfB3u0wQH58E83U5RQxV+9lcpYogXklvMJxsyPEdKYT9GRy/Sbv2zdWTblxR
         k+z3AIwI+EAnHdqO5VCnI65Jbagfun3w8PIZc6R/Ei2zbo2sSo66GELVv1BHUpE3FaUN
         GTpA==
X-Gm-Message-State: AOAM530w6xDOCurtba1uyeN2Jw9Mafr6Lx2plfBeP3fUE8DbtRzqQmdh
        2Mi10mb5w1fjJz7e8Ck3ew/ntQ==
X-Google-Smtp-Source: ABdhPJy6B2uOuY8nlYlMlbZzimxyQS3rpI5s21XxaofwWAhrWMOPI3vCjUBaibuvfPrpBMjoQH4Omg==
X-Received: by 2002:a37:b103:: with SMTP id a3mr652299qkf.261.1619124405346;
        Thu, 22 Apr 2021 13:46:45 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m124sm2975451qkc.70.2021.04.22.13.46.43
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 22 Apr 2021 13:46:45 -0700 (PDT)
Date:   Thu, 22 Apr 2021 13:46:34 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Dave Chinner <dchinner@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm/filemap: fix mapping_seek_hole_data on THP &
 32-bit
In-Reply-To: <alpine.LSU.2.11.2104212253000.4412@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2104221338410.1170@eggly.anvils>
References: <alpine.LSU.2.11.2104211723580.3299@eggly.anvils> <alpine.LSU.2.11.2104211737410.3299@eggly.anvils> <20210422011631.GL3596236@casper.infradead.org> <alpine.LSU.2.11.2104212253000.4412@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 21 Apr 2021, Hugh Dickins wrote:
> On Thu, 22 Apr 2021, Matthew Wilcox wrote:
> > On Wed, Apr 21, 2021 at 05:39:14PM -0700, Hugh Dickins wrote:
> > > No problem on 64-bit without huge pages, but xfstests generic/285
> > > and other SEEK_HOLE/SEEK_DATA tests have regressed on huge tmpfs,
> > > and on 32-bit architectures, with the new mapping_seek_hole_data().
> > > Several different bugs turned out to need fixing.
> > > 
> > > u64 casts added to stop unfortunate sign-extension when shifting
> > > (and let's use shifts throughout, rather than mixed with * and /).
> > 
> > That confuses me.  loff_t is a signed long long, but it can't be negative
> > (... right?)  So how does casting it to an u64 before dividing by
> > PAGE_SIZE help?
> 
> That is a good question. Sprinkling u64s was the first thing I tried,
> and I'd swear that it made a good difference at the time; but perhaps
> that was all down to just the one on xas.xa_index << PAGE_SHIFT. Or
> is it possible that one of the other bugs led to a negative loff_t,
> and the casts got better behaviour out of that? Doubtful.
> 
> What I certainly recall from yesterday was leaving out one (which?)
> of the casts as unnecessary, and wasting quite a bit of time until I
> put it back in. Did I really choose precisely the only one necessary?
> 
> Taking most of them out did give me good quick runs just now: I'll
> go over them again and try full runs on all machines. You'll think me
> crazy, but yesterday's experience leaves me reluctant to change without
> full testing - but agree it's not good to leave ignorant magic in.

And you'll be unsurprised to hear that the test runs went fine,
with all but one of those u64 casts removed. And I did locate the
version of filemap.c where I'd left out one "unnecessary" cast:
I had indeed chosen to remove the only one that's necessary.

v2 coming up now, thanks,

Hugh

