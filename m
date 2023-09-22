Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C537AB784
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 19:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbjIVRci (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 13:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbjIVRcP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:32:15 -0400
Received: from out-196.mta1.migadu.com (out-196.mta1.migadu.com [IPv6:2001:41d0:203:375::c4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1EDCF5
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 10:31:44 -0700 (PDT)
Date:   Fri, 22 Sep 2023 13:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695403901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KN1JQxormwjI3SS7UGp04taape15hhe6enoWPWGQ680=;
        b=w/BP4TjnJu50TWE84lFipw8dcwUC8/LZjrI4crTQk62fnPvWP25AMUGGnBQhXkCX//kUs3
        czezKsTXTm78YSUnUPJfRbBwqbHURPpAWt/MERdkGf6V7WuGzEAGuQRzHZ5QJLqB3zBSsH
        ogYA3jaA//TePd7rS7K7MFNNT7Yt/jQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v8 1/5] fs: add infrastructure for multigrain timestamps
Message-ID: <20230922173136.qpodogsb26wq3ujj@moria.home.lan>
References: <20230922-ctime-v8-0-45f0c236ede1@kernel.org>
 <20230922-ctime-v8-1-45f0c236ede1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922-ctime-v8-1-45f0c236ede1@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 22, 2023 at 01:14:40PM -0400, Jeff Layton wrote:
> The VFS always uses coarse-grained timestamps when updating the ctime
> and mtime after a change. This has the benefit of allowing filesystems
> to optimize away a lot metadata updates, down to around 1 per jiffy,
> even when a file is under heavy writes.
> 
> Unfortunately, this has always been an issue when we're exporting via
> NFS, which traditionally relied on timestamps to validate caches. A lot
> of changes can happen in a jiffy, and that can lead to cache-coherency
> issues between hosts.
> 
> NFSv4 added a dedicated change attribute that must change value after
> any change to an inode. Some filesystems (btrfs, ext4 and tmpfs) utilize
> the i_version field for this, but the NFSv4 spec allows a server to
> generate this value from the inode's ctime.
> 
> What we need is a way to only use fine-grained timestamps when they are
> being actively queried.
> 
> POSIX generally mandates that when the the mtime changes, the ctime must
> also change. The kernel always stores normalized ctime values, so only
> the first 30 bits of the tv_nsec field are ever used.
> 
> Use the 31st bit of the ctime tv_nsec field to indicate that something
> has queried the inode for the mtime or ctime. When this flag is set,
> on the next mtime or ctime update, the kernel will fetch a fine-grained
> timestamp instead of the usual coarse-grained one.
> 
> Filesytems can opt into this behavior by setting the FS_MGTIME flag in
> the fstype. Filesystems that don't set this flag will continue to use
> coarse-grained timestamps.

Interesting...

So in bcachefs, for most inode fields the btree inode is the "master
copy"; we do inode updates via btree transactions, and then on
successful transaction commit we update the VFS inode to match.

(exceptions: i_size, i_blocks)

I'd been contemplating switching to that model for timestamp updates as
well, since that would allow us to get rid of our
super_operations.write_inode method - except we probably wouldn't want
to do that since it would likely make timestamp updates too expensive.

And now with your scheme of stashing extra state in timespec, I'm glad
we didn't.

Still, timestamp updates are a bit messier than I'd like, would be
lovely to figure out a way to clean that up - right now we have an
awkward mix of "sometimes timestamp updates happen in a btree
transaction first, other times just the VFS inode is updated and marked
dirty".

xfs doesn't have .write_inode, so it's probably time to study what it
does...
