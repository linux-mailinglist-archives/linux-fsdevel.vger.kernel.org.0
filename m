Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B885C5A3A0F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 23:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiH0VOY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 17:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiH0VOX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 17:14:23 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F4C357C5;
        Sat, 27 Aug 2022 14:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MgTyF9gCctinASTA0Asu4gJ2nSzi2Z6PkJg3q98wFmg=; b=tiNcymmmW/z5PAO42XUOJeFps3
        d83pw/ecS0BhGZiEEtHyFY2bWOZ8pI92IFnghM5+SoKVeQZNuAIUrg34MEEhcTUf4kXnEOK/WImrN
        K2OZjXsNMQEHAx0XucipKAkIdmZMmYg3bFeWgzGAor+vjCiN/hT91u1XW6LbGd1+6TvQ9w2hSMF2L
        7PdKIZ82lqFAi8mSn0bkrv8DiZNnWg6+uLPA+a+RcOhVPkoZc24q+zmSCWQN7LYNoJN2oChJCpTzL
        ZDjZZFKp1ctz/Kr+YakSzutP+kigYwUOIzuFp9vI6baV+bVewhvlsmmL7CjBh4SGI40ZontNt5P2M
        o3FTB6hw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oS382-0096hM-Lv;
        Sat, 27 Aug 2022 21:14:06 +0000
Date:   Sat, 27 Aug 2022 22:14:06 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     NeilBrown <neilb@suse.de>, Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] VFS: support parallel updates in the one directory.
Message-ID: <YwqJHnomJ+4xCy1n@ZenIV>
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>
 <166147984370.25420.13019217727422217511.stgit@noble.brown>
 <CAHk-=wi_wwTxPTnFXsG8zdaem5YDnSd4OsCeP78yJgueQCb-1g@mail.gmail.com>
 <166155521174.27490.456427475820966571@noble.neil.brown.name>
 <CAHk-=whz69y=98udgGB5ujH6bapYuapwfHS2esWaFrKEoi9-Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whz69y=98udgGB5ujH6bapYuapwfHS2esWaFrKEoi9-Ow@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 26, 2022 at 05:13:38PM -0700, Linus Torvalds wrote:
> On Fri, Aug 26, 2022 at 4:07 PM NeilBrown <neilb@suse.de> wrote:
> >
> > As you note, by the end of the series "create" is not more different
> > from "rename" than it already is.  I only broke up the patches to make
> > review more manageable.
> 
> Yes, I understand. But I'm saying that maybe a filesystem actually
> might want to treat them differently.
> 
> That said, the really nasty part was that 'wq' thing that meant that
> different paths had different directory locking not because of
> low-level filesystem issues, but because of caller issues.
> 
> So that's the one I _really_ disliked, and that I don't think should
> exist even as a partial first step.
> 
> The "tie every operation together with one flag" I can live with, in
> case it turns out that yes, that one flag is all anybody ever really
> wants.

FWIW, what's really missing is the set of rules describing what the
methods can expect from their arguments.

Things like "oh, we can safely use ->d_parent here - we know that
foo_rmdir(dir, child) is called only with dir held exclusive and
child that had been observed to be a child of dentry alias of
dir after dir had been locked, while all places that might change
child->d_parent will be doing that only with child->d_parent->d_inode
held at least shared" rely upon the current locking scheme.

Change that 'held exclusive' to 'held shared' and we need something
different, presumably 'this new bitlock on the child is held by the caller'.
That's nice, but...  What's to guarantee that we won't be hit by
__d_unalias()?  It won't care about the bitlock on existing alias,
would it?  And it only holds the old parent shared, so...

My comments had been along the lines of "doing that would make the
series easier to reason about"; I don't hate the approach, but
	* in the current form it's hard to read; there might be
problems I hadn't even noticed yet
	* it's much easier to verify that stated assertions are
guaranteed by the callers and sufficient for safety of callees
if they *ARE* stated.  Spelling them out is on the patch series
authors, and IME doing that helps a lot when writing a series
like that.  At least on the level of internal notes...  Especially
since NFS is... special (or, as they say in New York, "sophisticated" -
sorry).  There's a plenty of things that are true for it, but do
not hold for filesystems in general.  And without an explicitly
spelled out warranties it's very easy to end up with a mess that
would be hell to apply to other filesystems.  I really don't want
to see an explosion of cargo-culted logics that might or might
not remain valid for NFS by the time it gets copied around...


