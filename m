Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0117767E53B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 13:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjA0Mas (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 07:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjA0Mao (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:30:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105F84EEE;
        Fri, 27 Jan 2023 04:30:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B46311FF3C;
        Fri, 27 Jan 2023 12:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674822630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ko++EeK7T8bysS2hwsZBCuH6k1F9U9HYKOhMMBm7aVY=;
        b=FGtVF+ifDnNx6Ym7llm38UK0noTKXOhkytSeYRdluDJLLqQIsshL81BuksR1kFhKBdijor
        B21PwWeGt/tqSlcwQnqrseZzrUZ9lVGdBAj+l89IFPnGZNQCE7BPnIXzh1i1pnWRZr3+r7
        MlzsJfWufGeTwBGvEQ8mMt08sdoaPP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674822630;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ko++EeK7T8bysS2hwsZBCuH6k1F9U9HYKOhMMBm7aVY=;
        b=PJzXU1bKZhQ0pDU38zzQdBDzy4U7+UqpT+D3hZZSt5+0OSmJslprdKrGnA/pq6n8caqZ/l
        WJ8T1oIkdniJBKAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9CDE5138E3;
        Fri, 27 Jan 2023 12:30:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /AlHJubD02O9AgAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 27 Jan 2023 12:30:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 24CD6A06B4; Fri, 27 Jan 2023 13:30:30 +0100 (CET)
Date:   Fri, 27 Jan 2023 13:30:30 +0100
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Hildenbrand <david@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v11 2/8] iov_iter: Add a function to extract a page list
 from an iterator
Message-ID: <20230127123030.qfmgkthuzlxadpkk@quack3>
References: <20230126141626.2809643-1-dhowells@redhat.com>
 <20230126141626.2809643-3-dhowells@redhat.com>
 <Y9L3yA+B1rrnrGK8@ZenIV>
 <Y9MAbYt6DIRFm954@ZenIV>
 <ba3adce1-ddea-98e0-fc3a-1cb660edae4c@redhat.com>
 <Y9Mwt1EMm8InCHvA@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9Mwt1EMm8InCHvA@ZenIV>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 27-01-23 02:02:31, Al Viro wrote:
> On Fri, Jan 27, 2023 at 12:44:08AM +0100, David Hildenbrand wrote:
> > On 26.01.23 23:36, Al Viro wrote:
> > > On Thu, Jan 26, 2023 at 09:59:36PM +0000, Al Viro wrote:
> > > > On Thu, Jan 26, 2023 at 02:16:20PM +0000, David Howells wrote:
> > > > 
> > > > > +/**
> > > > > + * iov_iter_extract_will_pin - Indicate how pages from the iterator will be retained
> > > > > + * @iter: The iterator
> > > > > + *
> > > > > + * Examine the iterator and indicate by returning true or false as to how, if
> > > > > + * at all, pages extracted from the iterator will be retained by the extraction
> > > > > + * function.
> > > > > + *
> > > > > + * %true indicates that the pages will have a pin placed in them that the
> > > > > + * caller must unpin.  This is must be done for DMA/async DIO to force fork()
> > > > > + * to forcibly copy a page for the child (the parent must retain the original
> > > > > + * page).
> > > > > + *
> > > > > + * %false indicates that no measures are taken and that it's up to the caller
> > > > > + * to retain the pages.
> > > > > + */
> > > > > +static inline bool iov_iter_extract_will_pin(const struct iov_iter *iter)
> > > > > +{
> > > > > +	return user_backed_iter(iter);
> > > > > +}
> > > > > +
> > > > 
> > > > Wait a sec; why would we want a pin for pages we won't be modifying?
> > > > A reference - sure, but...
> > > 
> > > After having looked through the earlier iterations of the patchset -
> > > sorry, but that won't fly for (at least) vmsplice().  There we can't
> > > pin those suckers;
> > 
> > We'll need a way to pass FOLL_LONGTERM to pin_user_pages_fast() to handle
> > such long-term pinning as vmsplice() needs. But the release path (unpin)
> > will be the same.
> 
> Umm...  Are you saying that if the source area contains DAX mmaps, vmsplice()
> from it will fail?

Yes, that's the plan. Because as you wrote elsewhere, it is otherwise too easy
to lock up operations such as truncate(2) on DAX filesystems.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
