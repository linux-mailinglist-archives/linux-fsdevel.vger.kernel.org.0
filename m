Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB795A3434
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 05:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbiH0Dsg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 23:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH0Dsf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 23:48:35 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B639A5994;
        Fri, 26 Aug 2022 20:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NYtf56mRPMxzipwSaPrwtpkE4cZWx2aqkuOobXv08A8=; b=k6BrKfkH9ROqbDLZXqqfQZQA+K
        DWTJy/IEp+/DTPX/yof8JnRJYISooHM9T1R0+LNxQjHyYZNwN/RIOLT5BEvpE6juotgBJ+0TJlK55
        HC4NiW3sWKKHDCI4cQG+wrXy2SSY9sLEkNdgZvCEiWNvoasLxNO3PicclqExYyhEdtXoj3+sDVGoB
        MH3uycrGoMhwAJN4zluTWL7j+yxi63oFjPfMBaKYHtWQEsvedtY8aNcCMkfxKFGPMFsBkfZVFe+xl
        NUf5Zm6GGV5FonFmrVMWql1XfhAiR4jZchRYXuYZQ0E+CIkpUoe4s3uQ628VYd0muSOR48rFU8sU/
        DsjWNSXQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oRmo7-008rgz-9h;
        Sat, 27 Aug 2022 03:48:27 +0000
Date:   Sat, 27 Aug 2022 04:48:27 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     NeilBrown <neilb@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/10] VFS: move want_write checks into
 lookup_hash_update()
Message-ID: <YwmUC7UNvNFdLTlc@ZenIV>
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>
 <166147984374.25420.3477094952897986387.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166147984374.25420.3477094952897986387.stgit@noble.brown>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 26, 2022 at 12:10:43PM +1000, NeilBrown wrote:
> mnt_want_write() is always called before lookup_hash_update(), so
> we can simplify the code by moving the call into that function.
> 
> If lookup_hash_update() succeeds, it now will have claimed the
> want_write lock.  If it fails, the want_write lock isn't held.
> 
> To allow this, lookup_hash_update() now receives a 'struct path *'
> instead of 'struct dentry *'
> 
> Note that when creating a name, any error from mnt_want_write() does not
> get reported unless there is no other error.  For unlink/rmdir though,
> an error from mnt_want_write() is immediately fatal - overriding ENOENT
> for example.  This behaviour seems strange, but this patch is careful to
> preserve it.

Would be a nice idea, if not for the mess with LOOKUP_SILLY_RENAME later
in the series...
