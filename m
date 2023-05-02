Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518666F4795
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 17:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbjEBPtu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 11:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbjEBPtt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 11:49:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3BF10D
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 08:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683042541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Br0MpFInBQrIw0DpV8B2e9x3mnRHV0K37BmIG0WD7TQ=;
        b=UfnPWUy8yW5UI7jhAI6g78V9ppQ0nP8HIT7O04eZNmF7bzxcrElUhF1OEZErW0CwwAk7uy
        Zyrh8iA7ssinPlAsSpSRD7QzcXACjuTGY7e8NMajzxfaOgVNeEGbup4kukItSIn11hGTXJ
        wcngV5Lx7uneW/G75PgrmrOTfY2iGrQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-xpLcUJo0Nm2cooH8_eLfpw-1; Tue, 02 May 2023 11:48:59 -0400
X-MC-Unique: xpLcUJo0Nm2cooH8_eLfpw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3ecd50d9db9so3189701cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 May 2023 08:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683042539; x=1685634539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Br0MpFInBQrIw0DpV8B2e9x3mnRHV0K37BmIG0WD7TQ=;
        b=U7HKmWOD+ryOHps58GEv6EgKi6O8JoMcPF1zHKR1XNII8mbeKPbq1/C8aOAsq5iI6k
         XF8QGMlVmXjpgfJwHxiol4y5PizMMCzj6K/AIf7OKH0Knmgq/H/w2+G7QNj5UH9aKqHm
         BXb5m1OrISRi27ABPaJO3Dr4KxTnJoXO6cspxhmoo6EzSlmcesJ1wuw7Ze2UibSc56X6
         XfaG7rir/sGO1gGv0iPLsX5hcfhs9zOezS0bhzC4SnX4AM+oG0s0RkgJPqyER/xEu6Qm
         +aHPCAB14KgGk4bHYSRRnTJ+QOEZhCPjINJegXaNdnwpHj/T6W73DTUVhYlTsosIceqD
         b5Vw==
X-Gm-Message-State: AC+VfDzDpiroU/AyIqGVoCObPQWwpZxy9qubj+//zawR/mgFZL7W34Wp
        RbRLpBkHob9+Ii03vW4Nx4DKlArjj6a+CBE2Ut/wJYv45egyuXJ8os+zIT7JcECCKNMh4SRwS4v
        0DHNlsWabkCfKSwRJ0ptDb7y/T8PK+jMy/Q==
X-Received: by 2002:ac8:58cc:0:b0:3ef:5395:a161 with SMTP id u12-20020ac858cc000000b003ef5395a161mr4620254qta.4.1683042538737;
        Tue, 02 May 2023 08:48:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6lsEBCDMgHg06jVLbZ4MJcPg10vJkI9VEzcjlDZEIx+F5bCvb3a8wNGloJehkR3kc4/LBCPA==
X-Received: by 2002:ac8:58cc:0:b0:3ef:5395:a161 with SMTP id u12-20020ac858cc000000b003ef5395a161mr4620211qta.4.1683042538401;
        Tue, 02 May 2023 08:48:58 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id j4-20020ac86644000000b003dffd3d3df5sm10435398qtp.2.2023.05.02.08.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 08:48:57 -0700 (PDT)
Date:   Tue, 2 May 2023 11:48:56 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] mm: Do not reclaim private data from pinned page
Message-ID: <ZFEw6DzzZX54z3B/@x1n>
References: <20230428124140.30166-1-jack@suse.cz>
 <ZFErn2Hl3mWiIudD@x1n>
 <8dba1912-4120-cb3d-6e10-5fc18459e2ac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8dba1912-4120-cb3d-6e10-5fc18459e2ac@redhat.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 02, 2023 at 05:33:22PM +0200, David Hildenbrand wrote:
> On 02.05.23 17:26, Peter Xu wrote:
> > On Fri, Apr 28, 2023 at 02:41:40PM +0200, Jan Kara wrote:
> > > If the page is pinned, there's no point in trying to reclaim it.
> > > Furthermore if the page is from the page cache we don't want to reclaim
> > > fs-private data from the page because the pinning process may be writing
> > > to the page at any time and reclaiming fs private info on a dirty page
> > > can upset the filesystem (see link below).
> > > 
> > > Link: https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > ---
> > >   mm/vmscan.c | 10 ++++++++++
> > >   1 file changed, 10 insertions(+)
> > > 
> > > This was the non-controversial part of my series [1] dealing with pinned pages
> > > in filesystems. It is already a win as it avoids crashes in the filesystem and
> > > we can drop workarounds for this in ext4. Can we merge it please?
> > > 
> > > [1] https://lore.kernel.org/all/20230209121046.25360-1-jack@suse.cz/
> > > 
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index bf3eedf0209c..401a379ea99a 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -1901,6 +1901,16 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
> > >   			}
> > >   		}
> > > +		/*
> > > +		 * Folio is unmapped now so it cannot be newly pinned anymore.
> > > +		 * No point in trying to reclaim folio if it is pinned.
> > > +		 * Furthermore we don't want to reclaim underlying fs metadata
> > > +		 * if the folio is pinned and thus potentially modified by the
> > > +		 * pinning process as that may upset the filesystem.
> > > +		 */
> > > +		if (folio_maybe_dma_pinned(folio))
> > > +			goto activate_locked;
> > > +
> > >   		mapping = folio_mapping(folio);
> > >   		if (folio_test_dirty(folio)) {
> > >   			/*
> > > -- 
> > > 2.35.3
> > > 
> > > 
> > 
> > IIUC we have similar handling for anon (feb889fb40fafc).  Should we merge
> > the two sites and just move the check earlier?  Thanks,
> > 
> 
> feb889fb40fafc introduced a best-effort check that is racy, as the page is
> still mapped (can still get pinned). Further, we get false positives most
> only if a page is shared very often (1024 times), which happens rarely with
> anon pages. Now that we handle COW+pinning correctly using
> PageAnonExclusive, that check only optimizes for the "already pinned" case.
> But it's not required for correctness anymore (so it can be racy).
> 
> Here, however, we want more precision, and not false positives simply
> because a page is mapped many times (which can happen easily) or can still
> get pinned while mapped.

Ah makes sense, thanks.

Acked-by: Peter Xu <peterx@redhat.com>

This seems not obvious, though, if we simply read the two commits. It'll be
great if we mention it somewhere in either comment or commit message on the
relationship of the two checks.

-- 
Peter Xu

