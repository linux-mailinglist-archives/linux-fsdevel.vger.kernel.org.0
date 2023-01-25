Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6070E67B447
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 15:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbjAYOZA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 09:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbjAYOYV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 09:24:21 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415B64A200
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 06:23:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7B3021F854;
        Wed, 25 Jan 2023 14:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674656632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BFGekgXR33CHgJIG6IfxGNMWpqZ22sfYs/9L+BZpUAI=;
        b=uI8U7lCydhs2l7WSkM59veuNFpyGFi77eE5xfus1MY58W7StgX0wyQ5uoNZ3a+mwa4pTvu
        jJjMevBs8BJDx0VnP4frM0i/DSH83A7dO1xo+1BKvGwq/yRS3HbQ5HyXSmGe2+zhchSH8E
        Tms51HPgVC/9vQ8jRKQQghhv9UT/Dmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674656632;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BFGekgXR33CHgJIG6IfxGNMWpqZ22sfYs/9L+BZpUAI=;
        b=j7H0JWoZOMjWdbOI9p/mBMgU3wgfuRra/u8ErlYAtEbZXxQfBBfNNKFKFG45JlBhJEF0Kj
        m7fg+ltCCD+xT7Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 631FB1358F;
        Wed, 25 Jan 2023 14:23:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mrkqGHg70WO8SgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 25 Jan 2023 14:23:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9D266A06B1; Wed, 25 Jan 2023 15:23:51 +0100 (CET)
Date:   Wed, 25 Jan 2023 15:23:51 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fs: don't allocate blocks beyond EOF from
 __mpage_writepage
Message-ID: <20230125142351.4hfehrbuuacx3thp@quack3>
References: <20230103104430.27749-1-jack@suse.cz>
 <Y7r8dsLV0dcs+jBw@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7r8dsLV0dcs+jBw@infradead.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 08-01-23 09:25:10, Christoph Hellwig wrote:
> On Tue, Jan 03, 2023 at 11:44:30AM +0100, Jan Kara wrote:
> > When __mpage_writepage() is called for a page beyond EOF, it will go and
> > allocate all blocks underlying the page. This is not only unnecessary
> > but this way blocks can get leaked (e.g. if a page beyond EOF is marked
> > dirty but in the end write fails and i_size is not extended).
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Matthew, Andrew, can one of you please pick up this fix? Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
