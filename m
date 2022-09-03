Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816505ABC3E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Sep 2022 04:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiICCMj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Sep 2022 22:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiICCMi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Sep 2022 22:12:38 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B5EE42CD;
        Fri,  2 Sep 2022 19:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+9hT3j8PY8NaJfAXBqOIgtHebUuVNz5evAMl6MQrDZM=; b=ImpVKficYcJZfn/PGfcZIeWwIT
        i3sOwcqfBBOo9/04H4EvdYmeTXQyqAtQcUUjkDsZnYpJRYNaO4U6dnVOH1iSpI/nGtl1OCacl8I87
        MdYdlxVyh2qd7jXqWuVtIq6HlPyyG14dBQavaEZpsCkdXQH160E55IuBfXZjOUHzzfmSWEVd0+4KR
        KhJveS9tkCVcIwA/vUIGGiqf+FPIprO8pMMJR+IQZ/FLihVVJRKbKYr/4VZOw7QdYmk+zSTKUDXrG
        gPUIP+3F0OZc6xNqaqid6OzICV0qSgi1hHR44HbzoYMA65n9TNsySthic+fDVLrJRs6/H5DqeOTBa
        kY67tQEQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oUIe2-00BW85-2R;
        Sat, 03 Sep 2022 02:12:26 +0000
Date:   Sat, 3 Sep 2022 03:12:26 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     NeilBrown <neilb@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] VFS: support parallel updates in the one directory.
Message-ID: <YxK4CiVNaQ6egobJ@ZenIV>
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>
 <166147984370.25420.13019217727422217511.stgit@noble.brown>
 <YwmS63X3Sm4bhlcT@ZenIV>
 <166173834258.27490.151597372187103012@noble.neil.brown.name>
 <YxKaaN9cHD5yzlTr@ZenIV>
 <166216924401.28768.5809376269835339554@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166216924401.28768.5809376269835339554@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 03, 2022 at 11:40:44AM +1000, NeilBrown wrote:

> I don't think that is a good idea.  Once you call d_lookup_done()
> (without having first called d_add() or similar) the dentry becomes
> invisible to normal path lookup, so another might be created.  But the
> dentry will still be used for the 'create' or 'rename' and may then be
> added to the dcache - at which point you could have two dentries with the
> same name.
> 
> When ->lookup() returns success without d_add()ing the dentry, that
> means that something else will complete the d_add() if/when necessary.
> For NFS, it specifically means that the lookup is effectively being
> combined with the following CREATE or RENAME.  In this case there is no
> d_lookup_done() until the full operation is complete.
>
> For autofs (thanks for pointing me to that) the operation is completed
> when d_automount() signals the daemon to create the directory or
> symlink.  In that case there IS a d_lookup_done() call and autofs needs
> some extra magic (the internal 'active' list) to make sure subsequent
> ->lookup requests can see that dentry which is still in the process of
> being set up.
> 
> It might be nice if the dentry passed to autofs_lookup() could remain
> "d_inlookup()" until after d_automount has completed.  Then autofs
> wouldn't need that active list.  However I haven't yet looked at how
> disruptive such a change might be.

Very much so.  You are starting to invent new rules for ->lookup() that
just never had been there, basing on nothing better than a couple of
examples.  They are nowhere near everything there is.

And you can't rely upon d_add() done by a method, for very obvious
reasons.  They are out of your control, they might very well decide
that object creation has failed and drop the damn thing.  Which is
not allowed for in-lookup dentries without d_lookup_done().

Neil, *IF* you are introducing new rules like that, the absolutely minimal
requirement is having them in Documentation/filesystems/porting.rst.
And that includes "such-and-such method might be called with parent
locked only shared; in that case it's guaranteed such-and-such things
about its arguments (bitlocks held, etc.)".

One thing we really need to avoid is that thing coming undocumented, with
"NFS copes, nobody else has it enabled, whoever does it for other
filesystems will just have to RTFS".  I hope it's obvious that this
is not an option.  Because I can bloody guarantee that it will be
cargo-culted over to other filesystems, with nobody (you and me included)
understanding the resulting code.
