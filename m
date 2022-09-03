Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDBD5AC06E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Sep 2022 19:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbiICRw3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Sep 2022 13:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiICRw1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Sep 2022 13:52:27 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FE7580A7;
        Sat,  3 Sep 2022 10:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4dwZEjTHso5b/E8ambbqsH4pHZvxi/mrOhOv3FzbXQI=; b=SKuBBVq3qR/tefEtR0X/Himz+P
        H9EvUpqaCLaUDOYrM98uxMiIfF128W33ZcslR7Qt2HlCTkRbo9UcwAwPvqlzZ3iOsGG26wDsdVHkO
        OnUDpHh6p6YG/yZlteu3mnGS1b5h+Mr1Oxy/GqpDmU+CSvMxKfKXY3DrmIMZ9h3BB90JUl0hVlQ/9
        TYu7mu3yvpfOfcfQCGryedNL4xgGFPbITCCKftzNJeTEee81HyCyMuXpGbLCXIgDjXR4+G3+lVRWB
        57lIL2LpFi3l+71yvcOLlt6TvwVvqdcmNC1owqASAn9SYbhQdRTBnBJKXkdFWocJaZ591WJ1n8cjJ
        4kFiTuGw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oUXJY-00Bq1X-KZ;
        Sat, 03 Sep 2022 17:52:16 +0000
Date:   Sat, 3 Sep 2022 18:52:16 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     NeilBrown <neilb@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] VFS: support parallel updates in the one directory.
Message-ID: <YxOUUEXAbUdFLVKk@ZenIV>
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>
 <166147984370.25420.13019217727422217511.stgit@noble.brown>
 <YwmS63X3Sm4bhlcT@ZenIV>
 <166173834258.27490.151597372187103012@noble.neil.brown.name>
 <YxKaaN9cHD5yzlTr@ZenIV>
 <166216924401.28768.5809376269835339554@noble.neil.brown.name>
 <YxK4CiVNaQ6egobJ@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxK4CiVNaQ6egobJ@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 03, 2022 at 03:12:26AM +0100, Al Viro wrote:

> Very much so.  You are starting to invent new rules for ->lookup() that
> just never had been there, basing on nothing better than a couple of
> examples.  They are nowhere near everything there is.

A few examples besides NFS and autofs:

ext4, f2fs and xfs might bloody well return NULL without hashing - happens
on negative lookups with 'casefolding' crap.

kernfs - treatment of inactive nodes.

afs_dynroot_lookup() treatment of @cell... names.

afs_lookup() treatment of @sys... names.

There might very well be more - both merged into mainline and in
development trees of various filesystems (including devel branches
of in-tree ones - I'm not talking about out-of-tree projects).

Note, BTW, that with the current rules it's perfectly possible to
have this kind of fun:
	a name that resolves to different files for different processes
	unlink(2) is allowed and results depend upon the calling process

All it takes is ->lookup() deliberately *NOT* hashing the sucker and
->unlink() acting according to dentry it has gotten from the caller.
unlink(2) from different callers are serialized and none of that
stuff is ever going to be hashed.  d_alloc_parallel() might pick an
in-lookup dentry from another caller of e.g. stat(2), but it will
wait for in-lookup state ending, notice that the sucker is not hashed,
drop it and retry.  Suboptimal, but it works.

Nothing in the mainline currently does that.  Nothing that I know of,
that is.  Sure, it could be made work with the changes you seem to
imply (if I'm not misreading you) - all it takes is lookup
calling d_lookup_done() on its argument before returning NULL.
But that's subtle, non-obvious and not documented anywhere...

Another interesting question is the rules for unhashing dentries.
What is needed for somebody to do temporary unhash, followed by
rehashing?
