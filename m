Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F14F5B7E51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 03:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiINBbA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 21:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiINBa6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 21:30:58 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF6A6CD17
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Sep 2022 18:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w3M0DOvQh7T8eh17lTTn/Kj4/He0djixL8kaHazxlHw=; b=Z9NRfA1uuWLKurK4mvKjT2zDPx
        bwFC6TTqbDoCNSCO/nmqb2bHG4f32iNtNF9zfjS2b2DzlfoBY2wtVOd496zTZ8AKZOTWkV7+pKMrd
        IQNtnF7sJ7nhVGGyGNLXyOHFWw86hswdvNDr308cc8TD9WUw+Jb8Bmry6xhUcfkaH8uaQHRh1+CcE
        wBT0SXJdXjQkw3eVHJU2RytMFXhgJtbJA/zyfi8uHbHY0V6tpyBP8jDmXKLO0/Yfgv1tahjSgkVHh
        m2JJvg01Zyg0ozAJC9IK4o9c4iNKtHAn9aOH2YsqmA5aMJEWJVNvqkjYyOmLjA8fbCYkdMV8//tta
        lwSlNIfg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oYHEr-00G10Z-2b;
        Wed, 14 Sep 2022 01:30:53 +0000
Date:   Wed, 14 Sep 2022 02:30:53 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     NeilBrown <neilb@suse.de>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Xavier Roche <xavier.roche@algolia.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: fix link vs. rename race
Message-ID: <YyEuzf33chhNXZwD@ZenIV>
References: <20220221082002.508392-1-mszeredi@redhat.com>
 <166304411168.30452.12018495245762529070@noble.neil.brown.name>
 <YyATCgxi9Ovi8mYv@ZenIV>
 <YyAX2adCGec95qXn@ZenIV>
 <166311448437.20483.2299581036245030695@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166311448437.20483.2299581036245030695@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 14, 2022 at 10:14:44AM +1000, NeilBrown wrote:

> But they can race.  The open completes the lookup of /tmp/share-dir and
> holds the dentry, but the rename succeeds with inode_lock(target) in the
> code fragment you provided above before the open() can get the lock.
> By the time open() does get the lock, the dentry it holds will be marked
> S_DEAD and the __lookup_hash() will fail.
> So the open() returns -ENOENT - unexpected.
> 
> Test code below, based on the test code for the link race.
> 
> I wonder if S_DEAD should result in -ESTALE rather than -ENOENT.
> That would cause the various retry_estale() loops to retry the whole
> operation.  I suspect we'd actually need more subtlety than just that
> simple change, but it might be worth exploring.

	I don't think that wording in POSIX prohibits that ENOENT.
It does not (and no UNIX I've ever seen provides) atomicity of all
link traversals involved in pathname resolution.

root@sonny:/tmp# mkdir fubar
root@sonny:/tmp# cd fubar/
root@sonny:/tmp/fubar# rmdir ../fubar
root@sonny:/tmp/fubar# touch ./foo
touch: cannot touch './foo': No such file or directory

Do you agree that this is a reasonable behaviour?  That, BTW, is why
"retry on S_DEAD" is wrong - it can be a persistent state.

Now, replace rmdir ../fubar with rename("/tmp/barf", "/tmp/fubar") and
you'll get pretty much your testcase.  You are asking not just for
atomicity of rename vs. traversal of "fubar" in /tmp - that we already
have.  You are asking for the atomicity of the entire pathname resolution
of open() argument wrt rename().  And that is a much scarier can of worms.

Basically, pathname resolution happens on per-component basis and it's
*NOT* guaranteed that filesystem won't be changed between those or that
we won't observe such modifications.  If you check POSIX, you'll see
that it avoids any such promises - all it says (for directories; non-directory
case has similar verbiage) is this:

	If the directory named by the new argument exists, it shall be removed
	and old renamed to new. In this case, a link named new shall exist
	throughout the renaming operation and shall refer either to the directory
	referred to by new or old before the operation began.

It carefully stays the hell out of any pathname resolution atomicity promises -
all it's talking about is resolution of a single link.  It's enough to
guarantee that rename("old", "new") won't race with mkdir("new") allowing the
latter to succeed, with similar for creat(2), etc. - "new" is promised to
refer to an existing object at all times.  And that's what rename() atomicity
is normally for.  Operation on the link in question will observe either old
or new state; operation that passed through that link on the way to whatever
it will act upon has *also* observed either of those states - and the next
pathname component had been looked up in either old or new directory, but
there is no promise that nothing has happened to that directory since we got
there.
