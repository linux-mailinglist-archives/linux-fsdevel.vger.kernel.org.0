Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C86077BA99
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 15:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjHNNvZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 09:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjHNNvO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:51:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21B2E6D;
        Mon, 14 Aug 2023 06:51:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7D01921995;
        Mon, 14 Aug 2023 13:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692021071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=06W9yPtseWrBVJu6tJOT712booSXOWesEEmQlc9XjzQ=;
        b=ZSA6mGIrhyyNMB4rCY++YxOMTVjF0WSwN6BtyiOgSHCJYHK4r6p3iOpKjKVg9D19SFFodP
        pH/GwqCk1FeyAjzyoaZChwZf9FKtrT/3sMxmNcyCcNBcSokltBDDw22ZQmyksGplOpHWo9
        0goCwvOFlhVHlm7eUUadVHXBAYjWxWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692021071;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=06W9yPtseWrBVJu6tJOT712booSXOWesEEmQlc9XjzQ=;
        b=VL7Pnp0JrEFlukf9Fk8SEjwRmy4uFlktPsGx6wTPcYk9UHi5p6FfCcXs5EW7im7u3hw1tY
        uftBnwzd0v5/0mDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7007A138E2;
        Mon, 14 Aug 2023 13:51:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FENWG08x2mTRZwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 14 Aug 2023 13:51:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D89E8A0769; Mon, 14 Aug 2023 15:51:10 +0200 (CEST)
Date:   Mon, 14 Aug 2023 15:51:10 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 02/29] block: Use bdev_open_by_dev() in blkdev_open()
Message-ID: <20230814135110.w5ayjzds3ikw3c4d@quack3>
References: <20230810171429.31759-1-jack@suse.cz>
 <20230811110504.27514-2-jack@suse.cz>
 <ZNYoxVjZu8dy6B2U@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNYoxVjZu8dy6B2U@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 11-08-23 05:25:41, Christoph Hellwig wrote:
> On Fri, Aug 11, 2023 at 01:04:33PM +0200, Jan Kara wrote:
> > +	blk_mode_t open_mode = ((struct bdev_handle *)file->private_data)->mode;
> 
> Nit: but I find it much more readable to just have a local bdev_handle
> variable vs these deep references including casts.  This also appears
> in a few others places.

OK, I've added the local variable to reduce typecasting and the depth of
dereferences.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
