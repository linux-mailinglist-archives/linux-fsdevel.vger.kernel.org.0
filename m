Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE0D6DD4F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 10:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjDKIPb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 04:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjDKIPA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:15:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BC640C6
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 01:14:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5CB6C21A5B;
        Tue, 11 Apr 2023 08:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681200886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CyaFXKHJ+rjatLN2TgQGVrKjalOTkI8NwMdke0huGfc=;
        b=y09pkOX35O8sc5hYX7U233hue/kuQJ/Sfh7Xabpc4ZMfJDdrCBabDpdERoTGBdaB04gsG/
        nzVxNnFW+qFJrAaMZrlhUmjDO9x75o+ry7gouqG36zA+U/laF8vksGBXBdOpULfniQc3Et
        AFd0+BUmC1A62Qc09SeYczY+/rZuhps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681200886;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CyaFXKHJ+rjatLN2TgQGVrKjalOTkI8NwMdke0huGfc=;
        b=UQFPyRXPCCKGIUXpU8kTrvXx86VMDsYypO/epK9bxuGpcxM11WaZBIL3QQDdWHm8UTnOAg
        js+nif1ASSTS5vBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E1B913638;
        Tue, 11 Apr 2023 08:14:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wlEKE/YWNWQxfgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 11 Apr 2023 08:14:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CBD17A0732; Tue, 11 Apr 2023 10:14:45 +0200 (CEST)
Date:   Tue, 11 Apr 2023 10:14:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Carlos Maiolino <cem@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, hughd@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 2/6] shmem: make shmem_get_inode() return ERR_PTR instead
 of NULL
Message-ID: <20230411081445.i57nloespetckatg@quack3>
References: <20230403084759.884681-1-cem@kernel.org>
 <20230403084759.884681-3-cem@kernel.org>
 <tLzd9z0prOKXpbWA3SHcS9KsIWPXVcwdgdxn4HuqDRoy9o8BgCNaKDNsNvW6C_m3Wo1pCXScjS6j14EaxszP6g==@protonmail.internalid>
 <20230403102354.jnwrqdbhpysttkxm@quack3>
 <20230411074708.gb7hkp6knxag3qjs@andromeda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411074708.gb7hkp6knxag3qjs@andromeda>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi!

On Tue 11-04-23 09:47:08, Carlos Maiolino wrote:
> My apologies it took a while to get back to you on this one, I was
> accumulating reviews before running through all of them.

Sure, that is fine.

> > >  	inode = shmem_get_inode(idmap, dir->i_sb, dir, mode, 0, VM_NORESERVE);
> > > -	if (inode) {
> > > -		error = security_inode_init_security(inode, dir,
> > > -						     NULL,
> > > -						     shmem_initxattrs, NULL);
> > > -		if (error && error != -EOPNOTSUPP)
> > > -			goto out_iput;
> > > -		error = simple_acl_create(dir, inode);
> > > -		if (error)
> > > -			goto out_iput;
> > > -		d_tmpfile(file, inode);
> > > -	}
> > > +
> > > +	if (IS_ERR(inode))
> > > +		return PTR_ERR(inode);
> > 
> > This doesn't look correct. Previously, we've called
> > finish_open_simple(file, error), now you just return error... Otherwise the
> > patch looks good to me.
> 
> I see what you mean. But, finish_open_simple() simply does:
> 
> 	if (error)
> 		return error;
> 
> So, calling it with a non-zero value for error at most will just add another
> function call into the stack.

I see, I didn't look inside finish_open_simple() :). Well, it is at least
inline function so actually no function call.

> I'm not opposed to still call finish_open_simple() but I don't think it adds
> anything.

Yeah, the value of the call is questionable but given it takes 'error'
argument only so that it could do that if (error) return error; dance, it
seems to be very much expected it is called in error cases as well.

> If you prefer it being called. I thought about adding a new label, something
> like:
> 
> 	if (IS_ERR(inode))
> 		goto err_out;
> 	.
> 	.
> 	.
> 	d_tmpfile(file, inode)
> err_out:
> 	return finish_open_simple(file, error)
> .
> .
> .
> 
> Would it work for you?

Yeah, I'd prefer we keep calling finish_open_simple(). Adding a label for
it is fine by me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
