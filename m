Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05A365FFCA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jan 2023 12:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjAFLtm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 06:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjAFLtk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 06:49:40 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D4A72882
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jan 2023 03:49:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 38D6D248C5;
        Fri,  6 Jan 2023 11:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673005778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DA5uEZA/6RMChqOFGO0GlDp5YkAKP7yAADZsWYuorDo=;
        b=2uEfkrmt8YmCcjgEH535OSqVAv1+lY8FHf2aUEjegkNKT7JUldYMdG/mucVpKRVOvOIggy
        usVxhGZolEsEHt/F62EQ+98+F1set+/UoDH4jgE98k5dN38DSLsSaGJ6FeVSQa7eB4Umnu
        MZ8I+zhY9AgCHKzv8mxsi9fS/cGKlmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673005778;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DA5uEZA/6RMChqOFGO0GlDp5YkAKP7yAADZsWYuorDo=;
        b=YebzGhWCI7NmospGQ1bA1uGpDeTY+V1iOFOZ2y2+8PvdzWmV16oMS9MhLKJPKoDDY52N1I
        AM0nEJE2QTcmkdDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 29EBA13596;
        Fri,  6 Jan 2023 11:49:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ne0zCtIKuGNOLQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 06 Jan 2023 11:49:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A5CB5A0742; Fri,  6 Jan 2023 12:49:37 +0100 (CET)
Date:   Fri, 6 Jan 2023 12:49:37 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [GIT PULL] udf fixes for 6.2-rc3 and ext2 cleanup
Message-ID: <20230106114937.pdiizpqyrjolwult@quack3>
References: <20230105142644.ubqxsokgthyfi56h@quack3>
 <CAHk-=wg59MK62LSR-Xs8KsxvmJSnyg1d-aZQ4n5+JKdTOc3RxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg59MK62LSR-Xs8KsxvmJSnyg1d-aZQ4n5+JKdTOc3RxA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 05-01-23 11:23:20, Linus Torvalds wrote:
> On Thu, Jan 5, 2023 at 6:26 AM Jan Kara <jack@suse.cz> wrote:
> >
> > The pull request is somewhat large but given these are all fixes (except
> > for ext2 conversion) and we are only at rc3, I hope it is fine.
> 
> That
> 
> > Jan Kara (30):
> >       udf: New directory iteration code
> 
> really is entirely new code, I want to get these kinds of things
> during the merge window.
> 
> This is not some kind of urgent new regression that needs fixing so
> urgently that we take new development outside the merge window.
> 
> This needs to go in for 6.3, and _if_ the syzbot reports are
> considered super-urgent and important enough to be back-ported, then
> it would need to be marked for stable and backported, simply because
> then old kernels would need it too.
> 
> But clearly none of this was considered quite that important. So 6.3 it is.
> 
> If parts of this is more urgent, send just that part. Not this whole
> "rewrite directory handling from scratch" stuff.

Sure, fair enough. I also felt it was kind of borderline whether I should
wait for the merge window or push. I'll go through the pile and see if
there are bits which are important enough and can be easily carved out.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
