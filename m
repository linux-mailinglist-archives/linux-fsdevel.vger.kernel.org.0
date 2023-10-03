Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714707B66C6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 12:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjJCKwa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 06:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjJCKw3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:52:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D082DAF;
        Tue,  3 Oct 2023 03:52:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 87B2521889;
        Tue,  3 Oct 2023 10:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696330345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FvRPHEd3+RwLBxpUpbPjM9nB8yg4wsbQfmswgFYItTQ=;
        b=0Oqf63isizj991VeQ+EPJaINoJIWd2do03XUb0nKDdBXYxIGUENHHJ56fsU7vTaF5lYi29
        sd3HFUCuSXZI4hdBc0cLuyTwAiRwDLB0IitUZ0VQx8flav21P/0+ImQf/kmO2iaf2k/HuP
        L2tTc6gCyBpz9nwatgOm1GNZpMrDrss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696330345;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FvRPHEd3+RwLBxpUpbPjM9nB8yg4wsbQfmswgFYItTQ=;
        b=oxSU8zroBYS9gYEUBk2fHh4HH1NGS0mesqZ66WTK56I8r4aU4iLlHoDcdyAOsruVaBJIOn
        f0fqjLxNTLS4z6Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 787A2132D4;
        Tue,  3 Oct 2023 10:52:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qX5rHWnyG2XJbwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 03 Oct 2023 10:52:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 020FAA07CB; Tue,  3 Oct 2023 12:52:24 +0200 (CEST)
Date:   Tue, 3 Oct 2023 12:52:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH 02/10] ext2: Convert ext2_check_page to ext2_check_folio
Message-ID: <20231003105224.3j47fjxpiudwvupn@quack3>
References: <20230921200746.3303942-1-willy@infradead.org>
 <20230921200746.3303942-2-willy@infradead.org>
 <20231003104017.ohuyl3fv2mobif5u@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003104017.ohuyl3fv2mobif5u@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 03-10-23 12:40:17, Jan Kara wrote:
> On Thu 21-09-23 21:07:39, Matthew Wilcox (Oracle) wrote:
> > Support in this function for large folios is limited to supporting
> > filesystems with block size > PAGE_SIZE.  This new functionality will only
> > be supported on machines without HIGHMEM, so the problem of kmap_local
> > only being able to map a single page in the folio can be ignored.
> > We will not use large folios for ext2 directories on HIGHMEM machines.
> 
> OK, but can we perhaps enforce this with some checks & error messages
> instead of a silent failure? Like:
> 
> #ifdef CONFIG_HIGHMEM
> 	if (sb->s_blocksize > PAGE_SIZE)
> 		bail with error
> #endif
> 
> somewhere in ext2_fill_super()? Or maybe force allocation of lowmem pages
> when blocksize > PAGE_SIZE?
> 
> > @@ -195,9 +195,9 @@ static void *ext2_get_page(struct inode *dir, unsigned long n,
> >  
> >  	if (IS_ERR(folio))
> >  		return ERR_CAST(folio);
> > -	page_addr = kmap_local_folio(folio, n & (folio_nr_pages(folio) - 1));
> > +	page_addr = kmap_local_folio(folio, 0);

Oh, and I think this change breaks the code whenever we get back higher
order folio because the page_addr we get back is not for the page index
'n'.
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
