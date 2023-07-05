Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D03748230
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 12:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjGEKbK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 06:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjGEKbI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:31:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B556BE57;
        Wed,  5 Jul 2023 03:31:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7352D1F889;
        Wed,  5 Jul 2023 10:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688553066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aTEd3fBquffgK1oTUGHJyJlGnNCl+YqrY9h3E39k8Z0=;
        b=MdN1Mw1D0Gl+ejFEl5DSExcJnR+nOOsoIXSrgPodlt6pbm1efJ40TIIA4K7HLSfsYRzc8f
        Wh7O3OTY3DE8s3j4j7LZc2CjluTwqhfBsDigSM3hbeSVB7hig7rD+1A4YDKSGYw4VhcTtL
        RZguuy7IZHkg4LyVnx7kRSqzRcD4xSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688553066;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aTEd3fBquffgK1oTUGHJyJlGnNCl+YqrY9h3E39k8Z0=;
        b=A8PAjEkiDgH1kCNCAc2OfNvHhl1lu+MPB2qn3hF9DN3EpZlFS4ME/S1915Mjd3cz32OmC4
        mVH+96/Y6SXRQGDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6554A13460;
        Wed,  5 Jul 2023 10:31:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gy62GGpGpWRqEAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 05 Jul 2023 10:31:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 048CCA0707; Wed,  5 Jul 2023 12:31:06 +0200 (CEST)
Date:   Wed, 5 Jul 2023 12:31:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>,
        Ted Tso <tytso@mit.edu>,
        syzkaller <syzkaller@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        Eric Biggers <ebiggers@google.com>, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 3/6] xfs: Block writes to log device
Message-ID: <20230705103105.cl4avnr27q6enuxc@quack3>
References: <20230704122727.17096-1-jack@suse.cz>
 <20230704125702.23180-3-jack@suse.cz>
 <20230704155313.GO11441@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704155313.GO11441@frogsfrogsfrogs>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 04-07-23 08:53:13, Darrick J. Wong wrote:
> On Tue, Jul 04, 2023 at 02:56:51PM +0200, Jan Kara wrote:
> > Ask block layer to not allow other writers to open block device used
> > for xfs log.
> 
> "...for the xfs log and realtime devices."
> 
> With that fixed,
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Thanks for the fixup and the review!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
