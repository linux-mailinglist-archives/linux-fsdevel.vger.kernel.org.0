Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F4872EC44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 21:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjFMTr5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 15:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjFMTr4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:47:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC85C171A;
        Tue, 13 Jun 2023 12:47:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F46F6350E;
        Tue, 13 Jun 2023 19:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689F9C433F0;
        Tue, 13 Jun 2023 19:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686685673;
        bh=Ih8TncHvHQnGjOpDZNZ3sjjTRueGP2vqBfz8GI8tuzM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Bzvqr3AB+cs7Dxe6cGNRzCtojYdBO9sWkNdcznkUfX9+ZDY25rOi+2u4X6VhgwrOx
         ohzqtKu5z6NzVdBIiq9UuiKh5r3YxLFfD13lPgSWk+X/9CT1KOQlStbaUZ+aMTqeQm
         Zv59qXw1fB68ELcdkT0vyiQlSiO88yVoQ6M8wAJ+VRka2OZ2ll9k/t/ptev5PqlA81
         533DHLNEBBYgJL+ST2ZTHLORnjRBy6TL3jfL+P/Qpvg2wJc4/edGpmxXqJu805iPtw
         VImFMLd7MrTXUg8CeNHTp5sXPunoh5QsHtCVWD0aPCws9jG5dOyHohBjwDOMrI69JF
         8sSWsZEKHd6CQ==
Message-ID: <3b7a224853e2e0557d55e98f171f8b24999c040b.camel@kernel.org>
Subject: Re: [PATCH v4 2/9] fs: add infrastructure for multigrain inode
 i_m/ctime
From:   Jeff Layton <jlayton@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
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
Date:   Tue, 13 Jun 2023 15:47:50 -0400
In-Reply-To: <20230523101723.xmy7mylbczhki6aa@quack3>
References: <20230518114742.128950-1-jlayton@kernel.org>
         <20230518114742.128950-3-jlayton@kernel.org>
         <20230523100240.mgeu4y46friv7hau@quack3>
         <20230523101723.xmy7mylbczhki6aa@quack3>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-05-23 at 12:17 +0200, Jan Kara wrote:
> On Tue 23-05-23 12:02:40, Jan Kara wrote:
> > On Thu 18-05-23 07:47:35, Jeff Layton wrote:
> > > The VFS always uses coarse-grained timestamp updates for filling out =
the
> > > ctime and mtime after a change. This has the benefit of allowing
> > > filesystems to optimize away a lot metadata updates, down to around 1
> > > per jiffy, even when a file is under heavy writes.
> > >=20
> > > Unfortunately, this has always been an issue when we're exporting via
> > > NFSv3, which relies on timestamps to validate caches. Even with NFSv4=
, a
> > > lot of exported filesystems don't properly support a change attribute
> > > and are subject to the same problems with timestamp granularity. Othe=
r
> > > applications have similar issues (e.g backup applications).
> > >=20
> > > Switching to always using fine-grained timestamps would improve the
> > > situation, but that becomes rather expensive, as the underlying
> > > filesystem will have to log a lot more metadata updates.
> > >=20
> > > What we need is a way to only use fine-grained timestamps when they a=
re
> > > being actively queried.
> > >=20
> > > The kernel always stores normalized ctime values, so only the first 3=
0
> > > bits of the tv_nsec field are ever used. Whenever the mtime changes, =
the
> > > ctime must also change.
> > >=20
> > > Use the 31st bit of the ctime tv_nsec field to indicate that somethin=
g
> > > has queried the inode for the i_mtime or i_ctime. When this flag is s=
et,
> > > on the next timestamp update, the kernel can fetch a fine-grained
> > > timestamp instead of the usual coarse-grained one.
> > >=20
> > > This patch adds the infrastructure this scheme. Filesytems can opt
> > > into it by setting the FS_MULTIGRAIN_TS flag in the fstype.
> > >=20
> > > Later patches will convert individual filesystems over to use it.
> > >=20
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> >=20
> > So there are two things I dislike about this series because I think the=
y
> > are fragile:
> >=20
> > 1) If we have a filesystem supporting multigrain ts and someone
> > accidentally directly uses the value of inode->i_ctime, he can get bogu=
s
> > value (with QUERIED flag). This mistake is very easy to do. So I think =
we
> > should rename i_ctime to something like __i_ctime and always use access=
or
> > function for it.
> >=20
> > 2) As I already commented in a previous version of the series, the sche=
me
> > with just one flag for both ctime and mtime and flag getting cleared in
> > current_time() relies on the fact that filesystems always do an equival=
ent
> > of:
> >=20
> > 	inode->i_mtime =3D inode->i_ctime =3D current_time();
> >=20
> > Otherwise we can do coarse grained update where we should have done a f=
ine
> > grained one. Filesystems often update timestamps like this but not
> > universally. Grepping shows some instances where only inode->i_mtime is=
 set
> > from current_time() e.g. in autofs or bfs. Again a mistake that is rath=
er
> > easy to make and results in subtle issues. I think this would be also
> > nicely solved by renaming i_ctime to __i_ctime and using a function to =
set
> > ctime. Mtime could then be updated with inode->i_mtime =3D ctime_peek()=
.
> >=20
> > I understand this is quite some churn but a very mechanical one that co=
uld
> > be just done with Coccinelle and a few manual fixups. So IMHO it is wor=
th
> > the more robust result.
>=20
> Also as I'm thinking about it your current scheme is slightly racy. Suppo=
se
> the filesystem does:
>=20
> CPU1					CPU2
>=20
> 					statx()
> inode->i_ctime =3D current_time()
>   current_mg_time()
>     nsec =3D atomic_long_fetch_andnot(QUERIED, &inode->i_ctime.tv_nsec)
> 					  nsec =3D atomic_long_fetch_or(QUERIED, &inode->i_ctime.tv_nsec)
>     if (nsec & QUERIED) - not set
>       ktime_get_coarse_real_ts64(&now)
>     return timestamp_truncate(now, inode);
> - QUERIED flag in the inode->i_ctime gets overwritten by the assignment
>   =3D> we need not update ctime due to granularity although it was querie=
d
>=20
> One more reason to use explicit function to update inode->i_ctime ;)

Thinking about this some more, I think we can fix the race you pointed
out by just not clearing the queried flag when we fetch the
i_ctime.tv_nsec field when we're updating.

So, instead of atomic_long_fetch_andnot, we'd just want to use an
atomic_long_fetch there, and just let the eventual assignment of
inode->__i_ctime.tv_nsec be what clears the flag.

Any task that goes to update the time during the interim window will
fetch a fine-grained time, but that's what we want anyway.

Since you bring up races though, there are a couple of other things we
should be aware of. Note that both problems exist today too:

1) it's possible for two tasks to race in such a way that the ctime goes
backward. There's no synchronization between tasks doing the updating,
so an older time can overwrite a newer one. I think you'd need a pretty
tight race to observe this though.

2) it's possible to fetch a "torn" timestamp out of the inode.
timespec64 is two words, and we don't order its loads or stores. We
could consider adding a seqcount_t and some barriers and fixing it that
way. I'm not sure it's worth it though, given that we haven't worried
about this in the past.

For now, I propose that we ignore both problems, unless and until we can
prove that they are more than theoretical.
--=20
Jeff Layton <jlayton@kernel.org>
