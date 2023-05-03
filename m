Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293906F5561
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 11:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjECJxg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 05:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjECJwv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 05:52:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB0261B8
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 02:51:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C36FF201C0;
        Wed,  3 May 2023 09:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683107514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=soq0aEXLMxDRlg7n5wnuI4EdxoEl76KWrCbeYIOeHsI=;
        b=cogHyw3HCR4znCiCaZFJUzlJcAtbsOQx0HyYgq4JVpLr9ki+xhTorjqF179FRy5xlgBMw9
        wptMHmGBjCUqS9XMiRouR8UMTiINkMZ4OfiWw+2Hg7nhYgUFrrWyKbFQFmVW7ix07cS3bc
        Bnf64voPa11LSOy4RVY/PtdQzbNXdEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683107514;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=soq0aEXLMxDRlg7n5wnuI4EdxoEl76KWrCbeYIOeHsI=;
        b=lfZG1EpTcipBXXGupOYLnqRyxBri7oj4VBsu7SkDD2s/jaEBSjbATHbBw4zmYbXfUxVNkq
        j+myvpmvL7u0UsDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B51621331F;
        Wed,  3 May 2023 09:51:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rfctLLouUmTYIQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 03 May 2023 09:51:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 45DDCA0744; Wed,  3 May 2023 11:51:54 +0200 (CEST)
Date:   Wed, 3 May 2023 11:51:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm: Do not reclaim private data from pinned page
Message-ID: <20230503095154.syth4jorsdu55ko4@quack3>
References: <20230428124140.30166-1-jack@suse.cz>
 <20230502132020.5a720158307c11d5b8efe1d9@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502132020.5a720158307c11d5b8efe1d9@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 02-05-23 13:20:20, Andrew Morton wrote:
> On Fri, 28 Apr 2023 14:41:40 +0200 Jan Kara <jack@suse.cz> wrote:
> 
> > If the page is pinned, there's no point in trying to reclaim it.
> > Furthermore if the page is from the page cache we don't want to reclaim
> > fs-private data from the page because the pinning process may be writing
> > to the page at any time and reclaiming fs private info on a dirty page
> > can upset the filesystem (see link below).
> 
> Obviously I'll add a cc:stable here.  I'm suspecting it's so old that
> there's no real Fixes: target that makes sense?

In principle the problem is there ever since MM started to track dirty
shared pages and filesystems started to use .page_mkwrite callbacks. So
for very long, yes. That being said the fix makes sense only since we've
added page pinning infrastructure and started using it in various places
which is not that long ago (in 2020, first patches in this direction have
been merged to 5.7). So we could mark it for stable with 5.7+.

> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1901,6 +1901,16 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
> >  			}
> >  		}
> >  
> > +		/*
> > +		 * Folio is unmapped now so it cannot be newly pinned anymore.
> > +		 * No point in trying to reclaim folio if it is pinned.
> > +		 * Furthermore we don't want to reclaim underlying fs metadata
> > +		 * if the folio is pinned and thus potentially modified by the
> > +		 * pinning process as that may upset the filesystem.
> > +		 */
> > +		if (folio_maybe_dma_pinned(folio))
> > +			goto activate_locked;
> > +
> 
> So I expect the -stable maintainers will be looking for a pre-folios
> version of this when the time comes.

Yeah, right. Luckily that's going to be pretty easy :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
