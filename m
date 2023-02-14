Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B0069641A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 14:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjBNNAI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 08:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbjBNNAG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:00:06 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C269F273A;
        Tue, 14 Feb 2023 05:00:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 65BD81F37F;
        Tue, 14 Feb 2023 13:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676379601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gz+b6Xt8mJ3ak48xss4fFkdb+QBvNTstPHhtjW5QbEw=;
        b=AZmiSRVQDfTJgkiUJSdU0mEi40Pv39uPOe93WKQbinXAnR11U4sFoMSpVveB2j5ui8LioA
        TJKFRMhop3IfGy7gjALJ7MOKmk5A7MK5vJQwZGISDT2b41WFfo1BrTFI6nl6BzobuQH1iq
        ps1fL1TLqalfcPs30O5TTVnGXX/SLZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676379601;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gz+b6Xt8mJ3ak48xss4fFkdb+QBvNTstPHhtjW5QbEw=;
        b=YpBWRY9ZWWcMyQOKgAtNfVetBte+Wt4r+HM2bZe9L88SY5sib75nPRyO3s2u8o89tIZ94H
        tnarVEyxu2ImUODg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 570B6138E3;
        Tue, 14 Feb 2023 13:00:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HVgcFdGF62NBKQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 14 Feb 2023 13:00:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 14F89A06D8; Tue, 14 Feb 2023 14:00:00 +0100 (CET)
Date:   Tue, 14 Feb 2023 14:00:00 +0100
From:   Jan Kara <jack@suse.cz>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        John Hubbard <jhubbard@nvidia.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/5] mm: Do not reclaim private data from pinned page
Message-ID: <20230214130000.s5kynjhjiyrpvzxx@quack3>
References: <20230209121046.25360-1-jack@suse.cz>
 <20230209123206.3548-1-jack@suse.cz>
 <df6e150f-9d5c-6f68-f234-3e1ef419f464@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df6e150f-9d5c-6f68-f234-3e1ef419f464@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 13-02-23 10:01:35, David Hildenbrand wrote:
> On 09.02.23 13:31, Jan Kara wrote:
> > If the page is pinned, there's no point in trying to reclaim it.
> > Furthermore if the page is from the page cache we don't want to reclaim
> > fs-private data from the page because the pinning process may be writing
> > to the page at any time and reclaiming fs private info on a dirty page
> > can upset the filesystem (see link below).
> > 
> > Link: https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >   mm/vmscan.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> > 
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index bf3eedf0209c..ab3911a8b116 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1901,6 +1901,16 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
> >   			}
> >   		}
> > +		/*
> > +		 * Folio is unmapped now so it cannot be newly pinned anymore.
> > +		 * No point in trying to reclaim folio if it is pinned.
> > +		 * Furthermore we don't want to reclaim underlying fs metadata
> > +		 * if the folio is pinned and thus potentially modified by the
> > +		 * pinning process is that may upset the filesystem.
> > +		 */
> > +		if (folio_maybe_dma_pinned(folio))
> > +			goto activate_locked;
> > +
> >   		mapping = folio_mapping(folio);
> >   		if (folio_test_dirty(folio)) {
> >   			/*
> 
> At this point, we made sure that the folio is completely unmapped. However,
> we specify "TTU_BATCH_FLUSH", so rmap code might defer a TLB flush and
> consequently defer an IPI sync.
> 
> I remember that this check here is fine regarding GUP-fast: even if
> concurrent GUP-fast pins the page after our check here, it should observe
> the changed PTE and unpin it again.
>  
> Checking after unmapping makes sense: we reduce the likelyhood of false
> positives when a file-backed page is mapped many times (>= 1024). OTOH, we
> might unmap pinned pages because we cannot really detect it early.
> 
> For anon pages, we have an early (racy) check, which turned out "ok" in
> practice, because we don't frequently have that many anon pages that are
> shared by that many processes. I assume we don't want something similar for
> pagecache pages, because having a single page mapped by many processes can
> happen easily and would prevent reclaim.

Yeah, I think pagecache pages shared by many processes are more likely.
Furthermore I think pinned pagecache pages are rather rare so unmapping
them before checking seems fine to me. Obviously we can reconsider if
reality would prove me wrong ;).

> I once had a patch lying around that documented for the existing
> folio_maybe_dma_pinned() for anon pages exactly that (racy+false positives
> with many mappings).
> 
> Long story short, I assume this change is fine.

Thanks for the throughout verification :)

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
