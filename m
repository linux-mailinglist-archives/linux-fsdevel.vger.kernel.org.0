Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CAA77EAAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 22:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346127AbjHPU1y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 16:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346122AbjHPU13 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:27:29 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774CB2690
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 13:27:27 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-58cd9d9dbf5so3784387b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 13:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692217646; x=1692822446;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o6nAd4B+hY09XKdSdHx5sCH4iOSgPQT2h6trGlM+vNA=;
        b=dveIXLQA89ZUWYHabJVtI3oEEzpIr9fV/lirVBfekKiFOXn1lGgA2uPGEcOlkOZjBD
         a1aBpoGF8QaJMHqlLM0UKvL9kaKpzS6zyOvmB6Zbc1eS7EEJ6VlfQkXyzLpNQhfG3OEw
         eCGtvZNYLyrmkoj5+tJuw3HMFHCP3sqPuk8fbd3spP0mYw93n9H7+8N80JmbfIs4qiXv
         pYw7bvDGtSSGmN6GSey1TNwmTvBJC5JMT671NM0B4mgv/BXoWeH/4YzxKbh3yB570fS0
         aJREuoDn9t0m4s+z3u9TOwbz2TQ5vLr7L5z9o4q0UsNVHdnnboFQwrHaMLNNgfIPCdb7
         au3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692217646; x=1692822446;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o6nAd4B+hY09XKdSdHx5sCH4iOSgPQT2h6trGlM+vNA=;
        b=goBMyDH0Tk2AwdqcH+1GsjZWXbvGhzfUIFLAarMuJ+PYX9og93zl5FfT/YCJs3o5MH
         NCRLLOzgc6W2SD8V0Mvv6BxuTqGTshlv5/rqyyWRA4dsjb0qoWr7Fbb0xM8J+ItCUZSZ
         68nWa0tFAU19tizIEV7DAbpGl5BVfCU1vdrpzIxCKyLd+tSHjtPl9tGu2qdBPAIHKNF6
         hS2DzwLttU4lMC7HsAcA/GBnDS4liloUq91SyoUZXcvEAEHXvQmYMfMn1BlcumZfqZgv
         F+kjTrcXtdllTpVVwPXbTyhomAdKtm/P7RWU7e10vgxZ6zuubJPiLiOyopGAK5CCsf9j
         vGNw==
X-Gm-Message-State: AOJu0YwNr1ouCI+dy9FVN67lm1ju7r28VusTodeuut90aagNuQJT92Pu
        xY6wvjkgffmvtdV4Osr/olXzyQ==
X-Google-Smtp-Source: AGHT+IEO5uc8CKDzvfrW8shdjb35Kp27HpuCfrFDLQV5dylLk8ofwbkbKcaFpgjeKtRhrvd/mx2svA==
X-Received: by 2002:a0d:d641:0:b0:56c:e5a3:3e09 with SMTP id y62-20020a0dd641000000b0056ce5a33e09mr850661ywd.15.1692217646555;
        Wed, 16 Aug 2023 13:27:26 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id z16-20020a81c210000000b005463e45458bsm4189762ywc.123.2023.08.16.13.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 13:27:25 -0700 (PDT)
Date:   Wed, 16 Aug 2023 13:27:17 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
cc:     Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>, Hannes Reineke <hare@suse.de>,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] block: Remove special-casing of compound pages
In-Reply-To: <20230814144100.596749-1-willy@infradead.org>
Message-ID: <94635da5-ce28-a8fb-84e3-7a9f5240fe6a@google.com>
References: <20230814144100.596749-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

a.k.a "Fix rare user data corruption when using THP" :)

On Mon, 14 Aug 2023, Matthew Wilcox (Oracle) wrote:

> The special casing was originally added in pre-git history; reproducing
> the commit log here:
> 
> > commit a318a92567d77
> > Author: Andrew Morton <akpm@osdl.org>
> > Date:   Sun Sep 21 01:42:22 2003 -0700
> >
> >     [PATCH] Speed up direct-io hugetlbpage handling
> >
> >     This patch short-circuits all the direct-io page dirtying logic for
> >     higher-order pages.  Without this, we pointlessly bounce BIOs up to
> >     keventd all the time.
> 
> In the last twenty years, compound pages have become used for more than
> just hugetlb.  Rewrite these functions to operate on folios instead
> of pages and remove the special case for hugetlbfs; I don't think
> it's needed any more (and if it is, we can put it back in as a call
> to folio_test_hugetlb()).
> 
> This was found by inspection; as far as I can tell, this bug can lead
> to pages used as the destination of a direct I/O read not being marked
> as dirty.  If those pages are then reclaimed by the MM without being
> dirtied for some other reason, they won't be written out.  Then when
> they're faulted back in, they will not contain the data they should.
> It'll take a pretty unusual setup to produce this problem with several
> races all going the wrong way.
> 
> This problem predates the folio work; it could for example have been
> triggered by mmaping a THP in tmpfs and using that as the target of an
> O_DIRECT read.
> 
> Fixes: 800d8c63b2e98 ("shmem: add huge pages support")

No. It's a good catch, but bug looks specific to the folio work to me.

Almost all shmem pages are dirty from birth, even as soon as they are
brought back from swap; so it is not necessary to re-mark them dirty.

The exceptions are pages allocated to holes when faulted: so you did
get me worried as to whether khugepaged could collapse a pmd-ful of
those into a THP without marking the result as dirty.

But no, in v6.5-rc6 the collapse_file() success path has
	if (is_shmem)
		folio_mark_dirty(folio);
and in v5.10 the same appears as
		if (is_shmem)
			set_page_dirty(new_page);

(IIRC, that or marking pmd dirty was missed from early shmem THP
support, but fairly soon corrected, and backported to stable then.
I have a faint memory of versions which assembled pmd_dirty from
collected pte_dirtys.)

And the !is_shmem case is for CONFIG_READ_ONLY_THP_FOR_FS: writing
into those pages, by direct IO or whatever, is already prohibited.

It's dem dirty (or not dirty) folios dat's the trouble!

Hugh

> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  block/bio.c | 46 ++++++++++++++++++++++++----------------------
>  1 file changed, 24 insertions(+), 22 deletions(-)
