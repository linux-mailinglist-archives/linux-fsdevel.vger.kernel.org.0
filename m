Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF5677BA6D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 15:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjHNNnv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 09:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjHNNnb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:43:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60481106;
        Mon, 14 Aug 2023 06:43:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1EAB01F7AB;
        Mon, 14 Aug 2023 13:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692020609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j5vw+gomPldsDXttNygJ42hXltBkXGcfKwGJEUtjfdM=;
        b=cAEl3QCGzc4McHHCgShAb4E4vu3a+OXcHLXP7/odm/VFO95d3mizeI2EmvQ7HeKV8IK6oS
        F4ZUpWtEBocnO4bv9FJdohXwd80P70J7MBmY+33t1BivVsC+OVOvkegCCTKtR0YhN0MUY6
        sc5Mgim3iqUs/BjGWKMpD2GSnUr3ihU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692020609;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j5vw+gomPldsDXttNygJ42hXltBkXGcfKwGJEUtjfdM=;
        b=Imb7MkiR1pyxgWAedNHLI2BViKDLZ/InJ6B8SAy5R90xraYDnR4lF40uHZDWQbULgGJTaB
        4Vwdj1LahNz8zcDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 040D3138E2;
        Mon, 14 Aug 2023 13:43:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wwf3AIEv2mThYwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 14 Aug 2023 13:43:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 86DC8A0769; Mon, 14 Aug 2023 15:43:28 +0200 (CEST)
Date:   Mon, 14 Aug 2023 15:43:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Daniel Gomez <da.gomez@samsung.com>
Cc:     Jan Kara <jack@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH 28/29] xfs: Convert to bdev_open_by_path()
Message-ID: <20230814134328.haymglxno6oaxac2@quack3>
References: <20230810171429.31759-1-jack@suse.cz>
 <20230811110504.27514-28-jack@suse.cz>
 <CGME20230814102748eucas1p269b8a53ed09fae1eb57dce3d2a7de752@eucas1p2.samsung.com>
 <3wo4aepjfabkpoqovt3d5j2fysgjahvd2dfli42nzjzfdklxp5@zsgzkmifxsbm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3wo4aepjfabkpoqovt3d5j2fysgjahvd2dfli42nzjzfdklxp5@zsgzkmifxsbm>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 14-08-23 10:27:46, Daniel Gomez wrote:
> 
> Hi Jan,
> 
> On Fri, Aug 11, 2023 at 01:04:59PM +0200, Jan Kara wrote:
> > Convert xfs to use bdev_open_by_path() and pass the handle around.
> >
> > CC: "Darrick J. Wong" <djwong@kernel.org>
> > CC: linux-xfs@vger.kernel.org
> > Signed-off-by: Jan Kara <jack@suse.cz>
...
> > @@ -2012,7 +2013,7 @@ xfs_alloc_buftarg(
> >  	ratelimit_state_init(&btp->bt_ioerror_rl, 30 * HZ,
> >  			     DEFAULT_RATELIMIT_BURST);
> >
> > -	if (xfs_setsize_buftarg_early(btp, bdev))
> > +	if (xfs_setsize_buftarg_early(btp, btp->bt_bdev))
> 
> This can now be simplified to one parameter. And use the btp->bt_bdev
> directly when invoking bdev_logical_block_size.

Fair point. Done.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
