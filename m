Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A162370DAFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 12:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbjEWK4S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 06:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjEWK4R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 06:56:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6BE119;
        Tue, 23 May 2023 03:56:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 758D96117C;
        Tue, 23 May 2023 10:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654B3C433EF;
        Tue, 23 May 2023 10:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684839374;
        bh=gxdNW1/f/9PAgN6QIwpZFg/Q6GBpd45ovH2YHV9pO24=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bVruV3sfe1VK8SZ8P5llKLoXL2vEi7/YPZpm3eD3FCnwY7TaqZlutR0O5J1XfTFO8
         V4FriMdQrV8yIlcYenD73/ZMeKxuvRpTziaPFRSZTlvWV5jHVdurKve62yfwG6Zl+b
         OBxSQCLK5har0jXlIP5KUo1cr4Ueqf+Ahj2hO9YIC0/3JR7CRwA/vwieKKjvBaPx9U
         yOlljBAVMuwFvB5OpGcOpKlKmv2bQXmiEJ7DASCKa2t4Q5aB3kwXFyBsINxX2ovN9r
         TtP3dth+zi3QttpVp2hkLYDXGaW9pIxAj0gJO63C2R56YrNK3EYFmwl/nyP2a4RqKi
         U3phrhKjQbShQ==
Message-ID: <ef75ac7c96f309b8f080a717f260247f69988d4a.camel@kernel.org>
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
Date:   Tue, 23 May 2023 06:56:11 -0400
In-Reply-To: <20230523101723.xmy7mylbczhki6aa@quack3>
References: <20230518114742.128950-1-jlayton@kernel.org>
         <20230518114742.128950-3-jlayton@kernel.org>
         <20230523100240.mgeu4y46friv7hau@quack3>
         <20230523101723.xmy7mylbczhki6aa@quack3>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
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

When we store the new time in the i_ctime field, the flag gets cleared
because at that point we're storing a new (unseen) time.

However, you're correct: if the i_ctime in your above example starts at
the same value that is currently being returned by
ktime_get_coarse_real_ts64, then we'll lose the flag set in statx.

I think the right fix there would be to not update the ctime at all if
it's a coarse grained time, and the value wouldn't have an apparent
change to an observer. That would leave the flag intact.

That does mean we'd need to move to a function that does clock fetch and
assigns it to i_ctime in one go (like you suggest). Something like:

    inode_update_ctime(inode);

How we do that with atomic operations over two values (the tv_sec and
tv_nsec) is a bit tricky. I'll have to think about it.

Christian, given Jan's concerns do you want to drop this series for now
and let me respin it?

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>
