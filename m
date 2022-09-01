Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA1A5A8BFB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 05:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiIADoy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 23:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiIADow (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 23:44:52 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC19DE6;
        Wed, 31 Aug 2022 20:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0VksQaHKdS6SzPuFX+0v16y3jeL3gHA/j4NUzfzCUmk=; b=J2RjzPauJNV4IAQ2+ZSqQLrKLT
        9dHf76Waf0U38NmL8YfXc+FtDGEUD6J34IJQETySw8gs/qKDte9PMD4rsPPZNrSw3mmxcrpRiEECJ
        nULr+sPA5uxvETo809jKLj6DhZwRj0AfJw1E/sH0gz3NJlsEomQ9L9E/XyPdScbcplIXIH/0srxiw
        V1NLw+D72qLn6W1cxBUdxhRsqP1mLMgAyTI7qqcK06JvbZS1BF3BR/oxzgVJeu+YjeArDFDzfMq9k
        8sqEEEnUREs+Bh3XlcsMzxx/zE3BeLOWN0Y+IJF7CxGqAejoq6NS6xu3MUmmZMn7Y4GG5A/4t5mps
        jLP2q6KQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oTb88-00ApuF-5q;
        Thu, 01 Sep 2022 03:44:36 +0000
Date:   Thu, 1 Sep 2022 04:44:36 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     NeilBrown <neilb@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] VFS: support parallel updates in the one directory.
Message-ID: <YxAqpGgNi4JTxkbT@ZenIV>
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>
 <166147984370.25420.13019217727422217511.stgit@noble.brown>
 <CAHk-=wi_wwTxPTnFXsG8zdaem5YDnSd4OsCeP78yJgueQCb-1g@mail.gmail.com>
 <YwlifYSJYzovBKGB@ZenIV>
 <166199227016.17668.15373771428363682061@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166199227016.17668.15373771428363682061@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:31:10AM +1000, NeilBrown wrote:

> Thanks for this list.

Keep in mind that this list is just off the top of my head - it's
nowhere near complete.

> d_splice_alias() happens at ->lookup time so it is already under a
> shared lock.  I don't see that it depends on i_rwsem - it uses i_lock
> for the important locking.

Nope.

Process 1:
rmdir foo/bar
	foo found and locked exclusive [*]
	dentry of bar found
	->rmdir() instance called
Process 2:
stat foo/splat
	foo found and locked shared [*]
	dentry of splat does not exist anywhere
	dentry allocated, marked in-lookup
	->lookup() instance called
	inode found and passed to d_splice_alias() ...
	... which finds that it's a directory inode ...
	... and foo/bar refers to it.  E.g. it's on NFS and another
client has just done mv bar splat
	__d_unalias() is called, to try and move existing alias (foo/bar)
into the right place.  It sees that no change of parent is involved,
	so it can just proceed to __d_move().
Process 1:
	forms an rmdir request to server, using ->d_name (and possibly
->d_parent) of dentry of foo/bar.  It knows that ->d_name is stable,
since the caller holds foo locked exclusive and all callers of __d_move()
hold the old parent at least shared.

In mainline process 2 will block (or, in case if it deals with different
parent, try to grab the old parent of the existing alias shared and fail
and with -ESTALE).  With your changes process 1 will be holding
foo/ locked shared, so process 2 will succeed and proceed to __d_move(),
right under the nose of process 1 accessing ->d_name.  If the names involved
had been longer than 32 characters, it would risk accessing kfreed memory.
Or fetching the length from old name and pointer from new one, walking
past the end of kmalloc'ed object, etc.

Sure, assuming that we are talking about NFS, server would have probably
failed the RMDIR request - if you managed to form that request without
oopsing, that is.
