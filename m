Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B1778B58A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 18:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjH1Qq1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 12:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbjH1QqR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:46:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E757132;
        Mon, 28 Aug 2023 09:46:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E58C31F8AB;
        Mon, 28 Aug 2023 16:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693241173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jof/LV1Czh4XCCAplxOp5YVeEMx2KrU5CK+snlPgWoQ=;
        b=Cx6gCB8nh4KqnoAXSzzoO3x0u40+OGC+NzGlJwdLVweSlOtj18EdFLHsp38Hfw9Kfib7o+
        g4pDFE68GX32lOuBkGToG7iU+p0qLKsND53TyMnL0xxG+ohvnvi8xNguVQnHmikHkEAGI0
        ipC8pHzF6/fGY2Xo2CGeymkFUfEHjtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693241173;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jof/LV1Czh4XCCAplxOp5YVeEMx2KrU5CK+snlPgWoQ=;
        b=DzOsraWKSyl+h0e7ASlz0L9kQvNPvMH6EhMov+rtIGA/9RFljIPgFTK0ZXoHOYnXWq/zV9
        l5g/8n2zTqCSZhAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7210139CC;
        Mon, 28 Aug 2023 16:46:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ivqBNFXP7GR4KgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 28 Aug 2023 16:46:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 64AB4A0774; Mon, 28 Aug 2023 18:46:13 +0200 (CEST)
Date:   Mon, 28 Aug 2023 18:46:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 02/29] block: Use bdev_open_by_dev() in blkdev_open()
Message-ID: <20230828164613.i6angwprxm57es6s@quack3>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-2-jack@suse.cz>
 <20230825022826.GC95084@ZenIV>
 <20230825094509.yarnl4jpayqqjk4c@quack3>
 <20230825-attribut-sympathisch-6dfddfe25f45@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825-attribut-sympathisch-6dfddfe25f45@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 25-08-23 15:29:11, Christian Brauner wrote:
> > file->f_flags. Attached is a version of the patch that I'm currently
> > testing.
> 
> Appended patch looks good to me,
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> 
> The patch also has another fix for O_EXCL. In earlier versions of this
> patch series it relied of f_flags. Thanks for that comment you added in
> there about this now. This really helps given that O_EXCL has special
> meaning for block devices. Ideally we'd have kernel doc for
> file_to_blk_mode().

Thanks for review! I've added the kerneldoc comment:

/**
 * file_to_blk_mode - get block open flags from file flags
 * @file: file whose open flags should be converted
 *
 * Look at file open flags and generate corresponding block open flags from
 * them. The function works both for file just being open (e.g. during ->open
 * callback) and for file that is already open. This is actually non-trivial
 * (see comment in the function).
 */

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
