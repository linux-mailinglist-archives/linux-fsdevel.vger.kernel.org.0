Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7C7742297
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 10:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjF2Itk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 04:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjF2ItM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 04:49:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2012C49E2;
        Thu, 29 Jun 2023 01:45:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AA7321F892;
        Thu, 29 Jun 2023 08:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688028341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qpp+eteAanAusl2RdhSlDfGKBCbUSpm0x04ccu9yCqA=;
        b=ttrFoC+STj0/u0pdDzeKR0HdhBNNRb0R4PhZUK+KKZNBXKjGQmARJstn6OyrNNVsFNQuFn
        RXdRYCtXMVVJO0xjqvE+Z1v4eLNrvVbRhsZatBbYST1Xju+8lEs2/fJ2SBiO7UlM8vNUVK
        BK/O52g5Mxk0B3jnxLR/uZMeKaHRDgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688028341;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qpp+eteAanAusl2RdhSlDfGKBCbUSpm0x04ccu9yCqA=;
        b=B1I5LC/MLGhf18IWYapbh45QWue5BQBWp1qN/0ebxZqKvTI3+PgyokeqQdNKTYSIj2dGyw
        yj08aLiWjjSZUnCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99319139FF;
        Thu, 29 Jun 2023 08:45:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id l5deJbVEnWTAZwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 29 Jun 2023 08:45:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 25F1CA0722; Thu, 29 Jun 2023 10:45:41 +0200 (CEST)
Date:   Thu, 29 Jun 2023 10:45:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chung-Chiang Cheng <cccheng@synology.com>, ltp@lists.linux.it
Subject: Re: [PATCH v4 0/3] fanotify accounting for fs/splice.c
Message-ID: <20230629084541.5hjyskliqntcr5y4@quack3>
References: <t5az5bvpfqd3rrwla43437r5vplmkujdytixcxgm7sc4hojspg@jcc63stk66hz>
 <cover.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
 <20230628113853.2b67fic5nvlisx3r@quack3>
 <ns6dcoilztzcutuduujfnbz5eggy3fk7z4t2bajy545zbay5d7@4bodludrpxe6>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ns6dcoilztzcutuduujfnbz5eggy3fk7z4t2bajy545zbay5d7@4bodludrpxe6>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

On Wed 28-06-23 20:54:28, Ahelenia Ziemiańska wrote:
> On Wed, Jun 28, 2023 at 01:38:53PM +0200, Jan Kara wrote:
> > On Tue 27-06-23 22:50:46, Ahelenia Ziemiańska wrote:
> > > Always generate modify out, access in for splice;
> > > this gets automatically merged with no ugly special cases.
> > > 
> > > No changes to 2/3 or 3/3.
> > Thanks for the patches Ahelena! The code looks fine to me but to be honest
> > I still have one unresolved question so let me think about it loud here for
> > documentation purposes :). Do we want fsnotify (any filesystem
> > notification framework like inotify or fanotify) to actually generate
> > events on FIFOs? FIFOs are virtual objects and are not part of the
> > filesystem as such (well, the inode itself and the name is), hence
> > *filesystem* notification framework does not seem like a great fit to watch
> > for changes or accesses there. And if we say "yes" for FIFOs, then why not
> > AF_UNIX sockets? Where do we draw the line? And is it all worth the
> > trouble?
> As a relative outsider (I haven't used inotify before this, and have not
>  been subjected to it or its peripheries before),
> I interpreted inotify as being the Correct solution for:
>   1. stuff you can find in a normal
>      (non-/dev, you don't want to touch devices)
>      filesystem traversal
>   2. stuff you can open
> where, going down the list in inode(7):
>   S_IFSOCK   can't open
>   S_IFLNK    can't open
>   S_IFREG    yes!
>   S_IFBLK    it's a device
>   S_IFDIR    yes!
>   S_IFCHR    it's a device
>   S_IFIFO    yes!
> 
> It appears that I'm not the only one who's interpreted it that way,
> especially since neither regular files nor pipes are pollable.
> (Though, under that same categorisation, I wouldn't be surprised
>  if anonymous pipes had been refused, for example, since those are
>  conventionally unnameable.)
> 
> To this end, I'd say we're leaving the line precisely where it was drawn
> before, even if by accident.

I agree, although I'd note that there are S_IFREG inodes under /sys or
/proc where it would be too difficult to provide fsnotify events (exactly
because the file contents is not "data stored somewhere" but rather
something "generated on the fly") so the illusion is not perfect already.

> > I understand the convenience of inotify working on FIFOs for the "tail -f"
> > usecase but then wouldn't this better be fixed in tail(1) itself by using
> > epoll(7) for FIFOs which, as I've noted in my other reply, does not have
> > the problem that poll(2) has when there are no writers?
> Yes, epoll in ET mode returns POLLHUP only once, but you /also/ need the
> inotify anyway for regular files, which epoll refuses
> (and, with -F, you may want both epoll for a pipe and inotify for the
>  directory it's contained in).
> Is it possible to do? yes. Is it more annoying than just having pipes
> report when they were written to? very much so.
> 
> inotify actually working(*) is presumably why coreutils tail doesn't use
> epoll ‒ inotify already provides all required events(*), you can use the
> same code for regular files and fifos, and with one fewer level of
> indirection: there's just no need(*).
> 
> (*: except with a magic syscall only I use apparently)

Yeah, I've slept to this and I still think adding fsnotify events to splice
is a nicer option so feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

to all kernel patches in your series. Since the changes are in splice code,
Christian or Al Viro (who you already have on CC list) should be merging
this so please make sure to also include them in the v5 submission.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
