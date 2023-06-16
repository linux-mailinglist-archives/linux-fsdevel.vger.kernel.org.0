Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D6E73363E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 18:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjFPQhF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 12:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbjFPQhE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:37:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83F81707
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 09:37:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 70EC01F749;
        Fri, 16 Jun 2023 16:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686933421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2x1lh06MHHB4LZFGCXDBiAk86EG3N1ST1XuWPlleb7o=;
        b=OpTMD5DtT9LCQYyHqnTawXmiTgnSlbTxYb83/smnIQd1mD6flIXDnKuJ1J7H0l8n4QfB2M
        RE66D7PUs8O3rMlggJWZyVKvIfKTz329IQMo+u9H7tqJZ2FUrYKtHHAQwctKibiw3oFgRL
        fVrTh1GbGGdPsQXBje3tm4YoLQGGcyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686933421;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2x1lh06MHHB4LZFGCXDBiAk86EG3N1ST1XuWPlleb7o=;
        b=nAcRA8MKBs3ZCuFwROHkeRZh/hB6q4gPUhaL5+r8HN5ygiVn8neV2v+XI6PCVUUlq4ZWdn
        oCgf4azo348R51Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 633C6138E8;
        Fri, 16 Jun 2023 16:37:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2dQvGK2PjGTYHQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Jun 2023 16:37:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CF6CDA0755; Fri, 16 Jun 2023 18:37:00 +0200 (CEST)
Date:   Fri, 16 Jun 2023 18:37:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Ted Tso <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] fs: Protect reconfiguration of sb read-write from racing
 writes
Message-ID: <20230616163700.b6yf4rlps7vacuje@quack3>
References: <20230615113848.8439-1-jack@suse.cz>
 <ZIuShQWnWEWscTWr@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIuShQWnWEWscTWr@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 16-06-23 08:36:53, Dave Chinner wrote:
> On Thu, Jun 15, 2023 at 01:38:48PM +0200, Jan Kara wrote:
> > The reconfigure / remount code takes a lot of effort to protect
> > filesystem's reconfiguration code from racing writes on remounting
> > read-only. However during remounting read-only filesystem to read-write
> > mode userspace writes can start immediately once we clear SB_RDONLY
> > flag. This is inconvenient for example for ext4 because we need to do
> > some writes to the filesystem (such as preparation of quota files)
> > before we can take userspace writes so we are clearing SB_RDONLY flag
> > before we are fully ready to accept userpace writes and syzbot has found
> > a way to exploit this [1]. Also as far as I'm reading the code
> > the filesystem remount code was protected from racing writes in the
> > legacy mount path by the mount's MNT_READONLY flag so this is relatively
> > new problem. It is actually fairly easy to protect remount read-write
> > from racing writes using sb->s_readonly_remount flag so let's just do
> > that instead of having to workaround these races in the filesystem code.
...
> > +	} else if (remount_rw) {
> > +		/*
> > +		 * We set s_readonly_remount here to protect filesystem's
> > +		 * reconfigure code from writes from userspace until
> > +		 * reconfigure finishes.
> > +		 */
> > +		sb->s_readonly_remount = 1;
> > +		smp_wmb();
> 
> What does the magic random memory barrier do? What is it ordering,
> and what is it paired with?
> 
> This sort of thing is much better done with small helpers that
> encapsulate the necessary memory barriers:
> 
> sb_set_readonly_remount()
> sb_clear_readonly_remount()
> 
> alongside the helper that provides the read-side check and memory
> barrier the write barrier is associated with.

Fair remark. The new code including barrier just copies what happens a few
lines above for remount read-only case (and what happens ib several other
places throughout VFS code). I agree having helpers for this and actually
documenting how the barriers are matching there is a good cleanup.

> I don't often ask for code to be cleaned up before a bug fix can be
> added, but I think this is one of the important cases where it does
> actually matter - we should never add undocumented memory barriers
> in the code like this...

I've talked to Christian and we'll queue this as a separate cleanup. I'll
post it shortly.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
