Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D38B662C95
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 18:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237181AbjAIRZJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 12:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237138AbjAIRZF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:25:05 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD2240871;
        Mon,  9 Jan 2023 09:25:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 51D6920040;
        Mon,  9 Jan 2023 17:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673285101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C0CXunOTUL8UJMKw/JLqxROwKh3zUZZ2e0csICXto58=;
        b=xl+Dc/r0HXHDoLeEeSJZ+vjjJl1EMHyb6zwmrehhVvD0AwO/+pRikl7f2fCKShunYJelaD
        GxCcS0M2lHN/okQL57U4gfSMZtv1JRRTR+DHY01e00Nk61nWF2xKA+Hs3hwqL8/764Z6Lj
        2xgjuOwv6u+Fihc5zuDv4O/PwyZAp/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673285101;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C0CXunOTUL8UJMKw/JLqxROwKh3zUZZ2e0csICXto58=;
        b=ugMSHNKOkTuqkjXCjLGqfgcTtIvpkPJ87OSNpKlvjl3E6LCZjy1Fk4JRVpVuuWmErcUWDf
        Qu69zShVl0lfhFCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 40784134AD;
        Mon,  9 Jan 2023 17:25:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eS+4D+1NvGMiFAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 09 Jan 2023 17:25:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id ADDE1A0749; Mon,  9 Jan 2023 18:25:00 +0100 (CET)
Date:   Mon, 9 Jan 2023 18:25:00 +0100
From:   Jan Kara <jack@suse.cz>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/7] iov_iter, block: Make bio structs pin pages
 rather than ref'ing if appropriate
Message-ID: <20230109172500.bd4z2incticapm7x@quack3>
References: <d86e6340-534c-c34c-ab1d-6ebacb213bb9@kernel.dk>
 <167305160937.1521586.133299343565358971.stgit@warthog.procyon.org.uk>
 <167305166150.1521586.10220949115402059720.stgit@warthog.procyon.org.uk>
 <1880793.1673257404@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1880793.1673257404@warthog.procyon.org.uk>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 09-01-23 09:43:24, David Howells wrote:
> Jens Axboe <axboe@kernel.dk> wrote:
> 
> > > A field, bi_cleanup_mode, is added to the bio struct that gets set by
> > > iov_iter_extract_pages() with FOLL_* flags indicating what cleanup is
> > > necessary.  FOLL_GET -> put_page(), FOLL_PIN -> unpin_user_page().  Other
> > > flags could also be used in future.
> > > 
> > > Newly allocated bio structs have bi_cleanup_mode set to FOLL_GET to
> > > indicate that attached pages are ref'd by default.  Cloning sets it to 0.
> > > __bio_iov_iter_get_pages() overrides it to what iov_iter_extract_pages()
> > > indicates.
> > 
> > What's the motivation for this change?
> 
> DIO reads in most filesystems and, I think, the block layer are currently
> broken with respect to concurrent fork in the same process because they take
> refs (FOLL_GET) on the pages involved which causes the CoW mechanism to
> malfunction, leading (I think) the parent process to not see the result of the
> DIO.  IIRC, the pages undergoing DIO get forcibly copied by fork - and the
> copies given to the parent.  Instead, DIO reads should be pinning the pages
> (FOLL_PIN).  Maybe Willy can weigh in on this?
> 
> Further, getting refs on pages in, say, a KVEC iterator is the wrong
> thing to do as the kvec may point to things that shouldn't be ref'd
> (vmap'd or vmalloc'd regions, for example).  Instead, the in-kernel
> caller should do what it needs to do to keep hold of the memory and the
> DIO should not take a ref at all.

Yes, plus there is also a problem if user sets up a DIO read into a buffer
backed by memory mapped file, then these mapped pages can be cleaned by
writeback while the DIO read is running causing checksum failures or
DIF/DIX failures. Also once the writeback is done, the filesystem currently
thinks it controls all paths modifying page data and thus can happily go on
deduplicating file blocks or do similar stuff although pages are
concurrently modified by DIO read possibly causing data corruption. See [1]
for more details why filesystems have a problem with this. So filesystems
really need DIO reads to use FOLL_PIN instead of FOLL_GET and consequently
we need to pass information to bio completion function how page references
should be dropped.

								Honza

[1] https://lore.kernel.org/all/20180103100430.GE4911@quack2.suse.cz/ 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
