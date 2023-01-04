Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE7465CE7A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 09:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbjADImG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 03:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbjADIlv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:41:51 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4362318B08
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jan 2023 00:41:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EC1BD76FB2;
        Wed,  4 Jan 2023 08:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672821707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yD+0vNaOuWs9px3BtZpjrKvWhAkqtiLpnLB44Ovpv7c=;
        b=nz8NtTdWx70TeKpdJSHrl11dAdKw0Oq9CMu3SRu58csZaZq59+B82Xrj+EnB/sNFFEVcyy
        5WNELtP4oW5ICjb8xH41V73Tw1PMWpewdh4b5+B1cq35njSgKupfihc92sd6dnCsmOaKYO
        jYfT94LbVfcMZHbd+AF5UkpoFRi5rUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672821707;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yD+0vNaOuWs9px3BtZpjrKvWhAkqtiLpnLB44Ovpv7c=;
        b=e13czMzFi9Q29LJxcecJ1uxCGtZqo3rTJIek3x1dNL61vWXaFq/KUst57nQrm9UUXv6ivz
        7iWwXXgAiYNbNWCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD4FC1342C;
        Wed,  4 Jan 2023 08:41:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KyoFNss7tWP/IAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 04 Jan 2023 08:41:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0F309A0742; Wed,  4 Jan 2023 09:41:47 +0100 (CET)
Date:   Wed, 4 Jan 2023 09:41:47 +0100
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fs: don't allocate blocks beyond EOF from
 __mpage_writepage
Message-ID: <20230104084147.4z3b33j6ow3g5yas@quack3>
References: <20230103104430.27749-1-jack@suse.cz>
 <Y7TCFz++qFNbGKwU@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7TCFz++qFNbGKwU@ZenIV>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 04-01-23 00:02:31, Al Viro wrote:
> On Tue, Jan 03, 2023 at 11:44:30AM +0100, Jan Kara wrote:
> > When __mpage_writepage() is called for a page beyond EOF, it will go and
> > allocate all blocks underlying the page. This is not only unnecessary
> > but this way blocks can get leaked (e.g. if a page beyond EOF is marked
> > dirty but in the end write fails and i_size is not extended).
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/mpage.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/fs/mpage.c b/fs/mpage.c
> > index 0f8ae954a579..9f040c1d5912 100644
> > --- a/fs/mpage.c
> > +++ b/fs/mpage.c
> > @@ -524,6 +524,12 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
> >  	 */
> >  	BUG_ON(!PageUptodate(page));
> >  	block_in_file = (sector_t)page->index << (PAGE_SHIFT - blkbits);
> > +	/*
> > +	 * Whole page beyond EOF? Skip allocating blocks to avoid leaking
> > +	 * space.
> > +	 */
> > +	if (block_in_file >= (i_size + (1 << blkbits) - 1) >> blkbits)
> > +		goto page_is_mapped;
> >  	last_block = (i_size - 1) >> blkbits;
> 
> Why not simply
> 
> 	if (block_in_file > last_block)
> 		goto page_is_mapped;
> 
> after last_block has been calculated?

Because if i_size == 0, last_block is (~0 >> blkbits) (which was actually
the case the test hit).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
