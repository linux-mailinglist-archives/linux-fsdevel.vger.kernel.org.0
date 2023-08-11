Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E250C7788C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 10:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjHKIKp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 04:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjHKIKo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 04:10:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EF4110;
        Fri, 11 Aug 2023 01:10:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 05F5E1F88C;
        Fri, 11 Aug 2023 08:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691741443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Iuljq2uypTD1q0UiNYQ7vF+zggL1+Aa9nPkzzXFwwdk=;
        b=Gi6D39ad64XsDydLlwdr30CG7YQzvB3xhOWHK+9UMSLoXXnGVdJoyWGctSn5AymbZ8UNf8
        9f5hFQ4r9tOWUM05rmxvJlArVKl5IvYKP1lX8HzXoROdLWaIy+GaDJLMSYnNWm4p8IfDq1
        B4ZyYRvTSZYUTnE/Q0ZuRJqGrY/557k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691741443;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Iuljq2uypTD1q0UiNYQ7vF+zggL1+Aa9nPkzzXFwwdk=;
        b=yL644Aq6Mx4s5JT4pLHYOc2wK5+xMMKInIO6pSxNMSmPc66I20yTJPXNiS+cXE7Kxk/K4i
        /T+Y1azkfwGc2GAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E7FE513592;
        Fri, 11 Aug 2023 08:10:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id T6WdOALt1WQGeAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 11 Aug 2023 08:10:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7101BA076F; Fri, 11 Aug 2023 10:10:42 +0200 (CEST)
Date:   Fri, 11 Aug 2023 10:10:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, djwong@kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, willy@infradead.org,
        josef@toxicpanda.com, tytso@mit.edu, bfoster@redhat.com,
        andreas.gruenbacher@gmail.com, brauner@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        dhowells@redhat.com, snitzer@kernel.org, axboe@kernel.dk
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230811081042.4zgtvemgtocfsthz@quack3>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
 <CAHk-=whaFz0uyBB79qcEh-7q=wUOAbGHaMPofJfxGqguiKzFyQ@mail.gmail.com>
 <20230810155453.6xz2k7f632jypqyz@moria.home.lan>
 <20230810175205.gtlkydeis37xdxuk@quack3>
 <20230811024703.7dhu5rz5ovph7uop@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811024703.7dhu5rz5ovph7uop@moria.home.lan>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 10-08-23 22:47:03, Kent Overstreet wrote:
> On Thu, Aug 10, 2023 at 07:52:05PM +0200, Jan Kara wrote:
> > On Thu 10-08-23 11:54:53, Kent Overstreet wrote:
> > > > And there clearly is something very strange going on with superblock
> > > > handling
> > > 
> > > This deserves an explanation because sget() is a bit nutty.
> > > 
> > > The way sget() is conventionally used for block device filesystems, the
> > > block device open _isn't actually exclusive_ - sure, FMODE_EXCL is used,
> > > but the holder is the fs type pointer, so it won't exclude with other
> > > opens of the same fs type.
> > > 
> > > That means the only protection from multiple opens scribbling over each
> > > other is sget() itself - but if the bdev handle ever outlives the
> > > superblock we're completely screwed; that's a silent data corruption bug
> > > that we can't easily catch, and if the filesystem teardown path has any
> > > asynchronous stuff going on (and of course it does) that's not a hard
> > > mistake to make. I've observed at least one bug that looked suspiciously
> > > like that, but I don't think I quite pinned it down at the time.
> > 
> > This is just being changed - check Christian's VFS tree. There are patches
> > that make sget() use superblock pointer as a bdev holder so the reuse
> > you're speaking about isn't a problem anymore.
> 
> So then the question is what do you use for identifying the superblock,
> and you're switching to the dev_t - interesting.
> 
> Are we 100% sure that will never break, that a dev_t will always
> identify a unique block_device? Namespacing has been changing things.

Yes, dev_t is a unique identifier of the device, we rely on that in
multiple places, block device open comes to mind as the first. You're
right namespacing changes things but we implement that as changing what
gets presented to userspace via some mapping layer while the kernel keeps
using globally unique identifiers.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
