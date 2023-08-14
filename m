Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF4377BE46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 18:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjHNQld (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 12:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjHNQlF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:41:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41954110;
        Mon, 14 Aug 2023 09:41:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0438D1F38C;
        Mon, 14 Aug 2023 16:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692031264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T6J6KaB2yVmMSZQOrNBSXzIuupcEoGafm+CEDUbKpWY=;
        b=Tts21h8SAyJF9cpEwcMBv+NLgnvyudnMvRIzaiKf/BcKAUjsg6Ja1rKv6v4IT9rTQjifEj
        Br55D4X8glNfcoZ9IwCJah9vXaj5KgLTuBowy99TXv4o9n8I2yUZb0moShPPQ9zLu3DrW2
        OAqdP1JcO0vSuyQ26EH1ctE6r+pDnJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692031264;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T6J6KaB2yVmMSZQOrNBSXzIuupcEoGafm+CEDUbKpWY=;
        b=IhQDuOQF3vgJ8BqexqjIOOWFOod8ptpMUfW6AUgR4TbhRCJlhtJwCc1WzCcbBKAByc8qKs
        nWMjnL17X4mlsEBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6BA1138EE;
        Mon, 14 Aug 2023 16:41:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fUtROB9Z2mT+OQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 14 Aug 2023 16:41:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 544B5A0769; Mon, 14 Aug 2023 18:41:03 +0200 (CEST)
Date:   Mon, 14 Aug 2023 18:41:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Colin Walters <walters@verbum.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>,
        Theodore Ts'o <tytso@mit.edu>,
        syzkaller <syzkaller@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        xfs <linux-xfs@vger.kernel.org>, linux-btrfs@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 1/6] block: Add config option to not allow writing to
 mounted devices
Message-ID: <20230814164103.l2upioopus2pp7p3@quack3>
References: <20230704122727.17096-1-jack@suse.cz>
 <20230704125702.23180-1-jack@suse.cz>
 <0c5384c2-307b-43fc-9ea6-2a194f859e9b@app.fastmail.com>
 <20230704165240.GA1851@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704165240.GA1851@sol.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 04-07-23 09:52:40, Eric Biggers wrote:
> On Tue, Jul 04, 2023 at 11:56:44AM -0400, Colin Walters wrote:
> > > +/* open is exclusive wrt all other BLK_OPEN_WRITE opens to the device */
> > > +#define BLK_OPEN_BLOCK_WRITES	((__force blk_mode_t)(1 << 5))
> > 
> > Bikeshed but: I think BLK and BLOCK "stutter" here.  The doc comment already
> > uses the term "exclusive" so how about BLK_OPEN_EXCLUSIVE ?  
> 
> Yeah, using "block" in two different ways at the same time is confusing.
> BLK_OPEN_EXCLUSIVE would probably be good, as would something like
> BLK_OPEN_RESTRICT_WRITES.

BLK_OPEN_RESTRICT_WRITES sounds good to me. I'll rename the flag.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
