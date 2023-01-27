Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A28867E6C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 14:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbjA0NcT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 08:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbjA0NcQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:32:16 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD2A8305F
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jan 2023 05:32:14 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8627C1FEB7;
        Fri, 27 Jan 2023 13:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674826333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=czPuixSFOwLBeDzR3wOUFPPAFO7MjdWWIUdTke8fdQo=;
        b=Parn6rlmeBcvBf4fE4wcUaf5Uu/5g+PPRjEdsyRXUS2xz5OyXFKRfCi4wvgA7EJn4+ExX6
        Jfh9fhOQMkWegNalW1BYyUnwdDzbEyCD9Ij/AOE2LT5YHFg2i09pC/YmO3TPIo/rp7N5kn
        NcYVsn4uX+7qoooIUACR16yyM7A/W94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674826333;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=czPuixSFOwLBeDzR3wOUFPPAFO7MjdWWIUdTke8fdQo=;
        b=/FtvP4HqYPS77VQYvwaHl68gpVtydomi1ODxgvcmSJlQ2KclTV+Aee6cM1tEDj9Dui0ZCt
        ZZubID980aUSpwBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 78D3C138E3;
        Fri, 27 Jan 2023 13:32:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jpx3HV3S02NGJQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 27 Jan 2023 13:32:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0C6BCA06B4; Fri, 27 Jan 2023 14:32:13 +0100 (CET)
Date:   Fri, 27 Jan 2023 14:32:13 +0100
From:   Jan Kara <jack@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] fs: gracefully handle ->get_block not mapping bh in
 __mpage_writepage
Message-ID: <20230127133213.su4cl6zuiuuv2p35@quack3>
References: <20230126085155.26395-1-jack@suse.cz>
 <20230126115455.296681b67273410e729309b0@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126115455.296681b67273410e729309b0@linux-foundation.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 26-01-23 11:54:55, Andrew Morton wrote:
> On Thu, 26 Jan 2023 09:51:55 +0100 Jan Kara <jack@suse.cz> wrote:
> 
> > When filesystem's ->get_block function does not map the buffer head when
> > called from __mpage_writepage(), the function will happily go and pass
> 
> "the function" being __mpage_writepage(), not ->get_block()...

Ah, right :)

> > bogus bdev and block number to bio allocation routines which leads to
> > crashes sooner or later.
> 
> Crashes are unwelcome.  How is this bug triggered?  Should we backport
> the fix?  I assume this is a longstanding thing and that any Fixes:
> target would be ancient?  If ancient, why did it take so long to
> discover?

fsstress was able to trigger the problem for UDF. The problem is there likely
since the time __mpage_writepage() was created (definitely pre-git). But
usually filesystems using mpage_writepages() just allocate blocks in their
->get_block() method so the problem was not visible until I've changed UDF
to not allocate blocks from page writeback (to fix some other bug).

For that reason, I'm actually carrying this change in my tree so that I
don't get swamped with 0-day and syzbot reports on that offending UDF fix.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
