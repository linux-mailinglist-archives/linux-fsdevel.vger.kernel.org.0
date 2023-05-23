Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEA270DB50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 13:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbjEWLPI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 07:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEWLPG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 07:15:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164D3119;
        Tue, 23 May 2023 04:15:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DA5063144;
        Tue, 23 May 2023 11:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86034C433EF;
        Tue, 23 May 2023 11:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684840503;
        bh=t7q3eN4BhkELHpTr8DtxIodckxoWL2ElEdGhZ8MHRXA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kkOoNXpsxbLfCboBMvGQ0TZ495A4EkCqbOAhscv082uZWwcELAtlQYSschubrdr7e
         s41Z0KfV1nRirJQ+AXcuUlwXITW7dG+QbnBqsROCo7fnGawbuOSiV1H/jac4LP62Px
         DgTNYFrlEMVh15PHU0jwip1npMemwKtmdPYAnnIQUUIw09adZ4/j4VXr9V1mp039FO
         8zxW1TPfGEf3AnApU6fmuw7BVmsLam15SH3gzqm4qmy+oakOHWJck/MpVclOMnuvBR
         A+fjefks4366G9TneC0ktxH2ISCrf7eEdYApxB2Uw2EdkseBJW/MvR3OvEYUKuZ2ix
         9aYZU2cyS5TdA==
Message-ID: <c350ae1b689ef325561ba3443ff841c4d22e5791.camel@kernel.org>
Subject: Re: [PATCH v4 2/9] fs: add infrastructure for multigrain inode
 i_m/ctime
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Neil Brown <neilb@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Theodore T'so <tytso@mit.edu>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org
Date:   Tue, 23 May 2023 07:15:00 -0400
In-Reply-To: <20230523-undicht-antihelden-b1a98aa769be@brauner>
References: <20230518114742.128950-1-jlayton@kernel.org>
         <20230518114742.128950-3-jlayton@kernel.org>
         <20230523100240.mgeu4y46friv7hau@quack3>
         <20230523101723.xmy7mylbczhki6aa@quack3>
         <ef75ac7c96f309b8f080a717f260247f69988d4a.camel@kernel.org>
         <20230523-undicht-antihelden-b1a98aa769be@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-05-23 at 13:01 +0200, Christian Brauner wrote:
> On Tue, May 23, 2023 at 06:56:11AM -0400, Jeff Layton wrote:
> > On Tue, 2023-05-23 at 12:17 +0200, Jan Kara wrote:
> > > On Tue 23-05-23 12:02:40, Jan Kara wrote:
> > > > On Thu 18-05-23 07:47:35, Jeff Layton wrote:
> > > > > The VFS always uses coarse-grained timestamp updates for filling =
out the
> > > > > ctime and mtime after a change. This has the benefit of allowing
> > > > > filesystems to optimize away a lot metadata updates, down to arou=
nd 1
> > > > > per jiffy, even when a file is under heavy writes.
> > > > >=20
> > > > > Unfortunately, this has always been an issue when we're exporting=
 via
> > > > > NFSv3, which relies on timestamps to validate caches. Even with N=
FSv4, a
> > > > > lot of exported filesystems don't properly support a change attri=
bute
> > > > > and are subject to the same problems with timestamp granularity. =
Other
> > > > > applications have similar issues (e.g backup applications).
> > > > >=20
> > > > > Switching to always using fine-grained timestamps would improve t=
he
> > > > > situation, but that becomes rather expensive, as the underlying
> > > > > filesystem will have to log a lot more metadata updates.
> > > > >=20
> > > > > What we need is a way to only use fine-grained timestamps when th=
ey are
> > > > > being actively queried.
> > > > >=20
> > > > > The kernel always stores normalized ctime values, so only the fir=
st 30
> > > > > bits of the tv_nsec field are ever used. Whenever the mtime chang=
es, the
> > > > > ctime must also change.
> > > > >=20
> > > > > Use the 31st bit of the ctime tv_nsec field to indicate that some=
thing
> > > > > has queried the inode for the i_mtime or i_ctime. When this flag =
is set,
> > > > > on the next timestamp update, the kernel can fetch a fine-grained
> > > > > timestamp instead of the usual coarse-grained one.
> > > > >=20
> > > > > This patch adds the infrastructure this scheme. Filesytems can op=
t
> > > > > into it by setting the FS_MULTIGRAIN_TS flag in the fstype.
> > > > >=20
> > > > > Later patches will convert individual filesystems over to use it.
> > > > >=20
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > >=20
> > > > So there are two things I dislike about this series because I think=
 they
> > > > are fragile:
> > > >=20
> > > > 1) If we have a filesystem supporting multigrain ts and someone
> > > > accidentally directly uses the value of inode->i_ctime, he can get =
bogus
> > > > value (with QUERIED flag). This mistake is very easy to do. So I th=
ink we
> > > > should rename i_ctime to something like __i_ctime and always use ac=
cessor
> > > > function for it.
> > > >=20
> > > > 2) As I already commented in a previous version of the series, the =
scheme
> > > > with just one flag for both ctime and mtime and flag getting cleare=
d in
> > > > current_time() relies on the fact that filesystems always do an equ=
ivalent
> > > > of:
> > > >=20
> > > > 	inode->i_mtime =3D inode->i_ctime =3D current_time();
> > > >=20
> > > > Otherwise we can do coarse grained update where we should have done=
 a fine
> > > > grained one. Filesystems often update timestamps like this but not
> > > > universally. Grepping shows some instances where only inode->i_mtim=
e is set
> > > > from current_time() e.g. in autofs or bfs. Again a mistake that is =
rather
> > > > easy to make and results in subtle issues. I think this would be al=
so
> > > > nicely solved by renaming i_ctime to __i_ctime and using a function=
 to set
> > > > ctime. Mtime could then be updated with inode->i_mtime =3D ctime_pe=
ek().
> > > >=20
> > > > I understand this is quite some churn but a very mechanical one tha=
t could
> > > > be just done with Coccinelle and a few manual fixups. So IMHO it is=
 worth
> > > > the more robust result.
> > >=20
> > > Also as I'm thinking about it your current scheme is slightly racy. S=
uppose
> > > the filesystem does:
> > >=20
> > > CPU1					CPU2
> > >=20
> > > 					statx()
> > > inode->i_ctime =3D current_time()
> > >   current_mg_time()
> > >     nsec =3D atomic_long_fetch_andnot(QUERIED, &inode->i_ctime.tv_nse=
c)
> > > 					  nsec =3D atomic_long_fetch_or(QUERIED, &inode->i_ctime.tv_nsec=
)
> > >     if (nsec & QUERIED) - not set
> > >       ktime_get_coarse_real_ts64(&now)
> > >     return timestamp_truncate(now, inode);
> > > - QUERIED flag in the inode->i_ctime gets overwritten by the assignme=
nt
> > >   =3D> we need not update ctime due to granularity although it was qu=
eried
> > >=20
> > > One more reason to use explicit function to update inode->i_ctime ;)
> >=20
> > When we store the new time in the i_ctime field, the flag gets cleared
> > because at that point we're storing a new (unseen) time.
> >=20
> > However, you're correct: if the i_ctime in your above example starts at
> > the same value that is currently being returned by
> > ktime_get_coarse_real_ts64, then we'll lose the flag set in statx.
> >=20
> > I think the right fix there would be to not update the ctime at all if
> > it's a coarse grained time, and the value wouldn't have an apparent
> > change to an observer. That would leave the flag intact.
> >=20
> > That does mean we'd need to move to a function that does clock fetch an=
d
> > assigns it to i_ctime in one go (like you suggest). Something like:
> >=20
> >     inode_update_ctime(inode);
> >=20
> > How we do that with atomic operations over two values (the tv_sec and
> > tv_nsec) is a bit tricky. I'll have to think about it.
> >=20
> > Christian, given Jan's concerns do you want to drop this series for now
> > and let me respin it?
>=20
> I deliberately put it into a vfs.unstable.* branch. I would leave it
> there until you send a new one then drop it. If we get lucky the bots
> that run on -next will have time to report potential perf issues while
> it's not currently causing conflicts.

Sounds good to me. Thanks!
--=20
Jeff Layton <jlayton@kernel.org>
