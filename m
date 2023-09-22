Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0457AB916
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 20:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjIVSXC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 14:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjIVSXB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:23:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA65A7;
        Fri, 22 Sep 2023 11:22:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13744C433C8;
        Fri, 22 Sep 2023 18:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695406975;
        bh=nQQW+wDRVnYMRuOb8M421KByNhjssOZzRLQ2//TK7Tc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=McHV0W81b/uba3XlQJOB+tiLW3eKS3NR+Gp6AbHLSok/P7Ero7ckGOeWW0F8xhJCV
         g19g+Up2isP79XAe2YgwxrxnsaD4yqXBOgl8TN6XNbmwJ91k+lvlwE7afs+aN8TrkK
         xXDgr9WluDIFpsfCM4TWWFNfMKRpqaP+rN4WQnBlu73tUub4mWeVa8XKc+o2lYbjWu
         sTWbaKTIC/nb6GJCbHdFoQcQofsNiKsMEwIXJwXvLOPkVS5n4V8WT1iuzoUUbiSGEZ
         xsp2Howcs3bt+Tev/8gbLPJrusoMM/g1EaBUOddBmL+9hRKmOdL26FdGtTXuKDkqgU
         xz7dc/8/6/KQA==
Message-ID: <f4c7e8e58db56741ae38bef6909852b52cd3df5b.camel@kernel.org>
Subject: Re: [PATCH v8 1/5] fs: add infrastructure for multigrain timestamps
From:   Jeff Layton <jlayton@kernel.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
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
Date:   Fri, 22 Sep 2023 14:22:52 -0400
In-Reply-To: <20230922173136.qpodogsb26wq3ujj@moria.home.lan>
References: <20230922-ctime-v8-0-45f0c236ede1@kernel.org>
         <20230922-ctime-v8-1-45f0c236ede1@kernel.org>
         <20230922173136.qpodogsb26wq3ujj@moria.home.lan>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2023-09-22 at 13:31 -0400, Kent Overstreet wrote:
> On Fri, Sep 22, 2023 at 01:14:40PM -0400, Jeff Layton wrote:
> > The VFS always uses coarse-grained timestamps when updating the ctime
> > and mtime after a change. This has the benefit of allowing filesystems
> > to optimize away a lot metadata updates, down to around 1 per jiffy,
> > even when a file is under heavy writes.
> >=20
> > Unfortunately, this has always been an issue when we're exporting via
> > NFS, which traditionally relied on timestamps to validate caches. A lot
> > of changes can happen in a jiffy, and that can lead to cache-coherency
> > issues between hosts.
> >=20
> > NFSv4 added a dedicated change attribute that must change value after
> > any change to an inode. Some filesystems (btrfs, ext4 and tmpfs) utiliz=
e
> > the i_version field for this, but the NFSv4 spec allows a server to
> > generate this value from the inode's ctime.
> >=20
> > What we need is a way to only use fine-grained timestamps when they are
> > being actively queried.
> >=20
> > POSIX generally mandates that when the the mtime changes, the ctime mus=
t
> > also change. The kernel always stores normalized ctime values, so only
> > the first 30 bits of the tv_nsec field are ever used.
> >=20
> > Use the 31st bit of the ctime tv_nsec field to indicate that something
> > has queried the inode for the mtime or ctime. When this flag is set,
> > on the next mtime or ctime update, the kernel will fetch a fine-grained
> > timestamp instead of the usual coarse-grained one.
> >=20
> > Filesytems can opt into this behavior by setting the FS_MGTIME flag in
> > the fstype. Filesystems that don't set this flag will continue to use
> > coarse-grained timestamps.
>=20
> Interesting...
>=20
> So in bcachefs, for most inode fields the btree inode is the "master
> copy"; we do inode updates via btree transactions, and then on
> successful transaction commit we update the VFS inode to match.
>=20
> (exceptions: i_size, i_blocks)
>=20
> I'd been contemplating switching to that model for timestamp updates as
> well, since that would allow us to get rid of our
> super_operations.write_inode method - except we probably wouldn't want
> to do that since it would likely make timestamp updates too expensive.
>=20
> And now with your scheme of stashing extra state in timespec, I'm glad
> we didn't.
>=20
> Still, timestamp updates are a bit messier than I'd like, would be
> lovely to figure out a way to clean that up - right now we have an
> awkward mix of "sometimes timestamp updates happen in a btree
> transaction first, other times just the VFS inode is updated and marked
> dirty".
>=20
> xfs doesn't have .write_inode, so it's probably time to study what it
> does...

A few months ago, we talked briefly and I asked about an i_version
counter for bcachefs. You were going to look into it, and I wasn't sure
if you had implemented one. If you haven't, then this may be a simpler
alternative.

For now, these aren't much good for anything other than faking up a
change attribute for NFSv4, but=A0they should be fine for that and you
wouldn't need to grow your on-disk inode to accommodate them.

Cheers,
--=20
Jeff Layton <jlayton@kernel.org>
