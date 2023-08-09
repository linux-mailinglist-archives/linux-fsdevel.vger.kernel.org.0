Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB89776250
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 16:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjHIOXG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 10:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjHIOXE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:23:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A5210F5;
        Wed,  9 Aug 2023 07:23:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EAEF62D6B;
        Wed,  9 Aug 2023 14:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2D2C433C7;
        Wed,  9 Aug 2023 14:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691590982;
        bh=LgXOvH2tCTHIjBx4H7FiUs60LQPWskUEsq2zDenCRXk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=d3tvC2K0q9zmSKovb3MCz70OZ0zDUfwQjvtmqpayy/+0zTCRnvBnhoitfla9mzpYS
         6/IQTcAliZ/qw+jQL6ikoz6PNYzqJ5V/AqPdhloBtpJ7o+04K1HJBA1CLTORrD2v+D
         7LM1T9XMRPVFf25JkonEGd6tPIqFqFkNRPbUkBuWrkC1zyTV3QcmWREwMXrZwRBWOf
         qlZSX+5xrbt2rURYBov8h1oSuPFEc5pUfvutsD/+H96L3ykp7YO0AtG9js4MbdLlC5
         xVqrAhV0e5CphxqERFiIWxatm9vmAPUWZveD51138XqFFJM1+SpLi461h67PgiJAZz
         6pxgp2dPf4+Bg==
Message-ID: <7edc9239f73022b9c2a1d3f4f946153f85f94739.camel@kernel.org>
Subject: Re: [PATCH v7 05/13] fat: make fat_update_time get its own timestamp
From:   Jeff Layton <jlayton@kernel.org>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Tyler Hicks <code@tyhicks.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@gl0jj8bn.sched.sma.tdnsstic1.cn>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Hans de Goede <hdegoede@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@telemann.coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-mtd@lists.infradead.org, linux-mm@kvack.org,
        linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org
Date:   Wed, 09 Aug 2023 10:22:54 -0400
In-Reply-To: <878rak8hia.fsf@mail.parknet.co.jp>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
         <20230807-mgctime-v7-5-d1dec143a704@kernel.org>
         <87msz08vc7.fsf@mail.parknet.co.jp>
         <52bead1d6a33fec89944b96e2ec20d1ea8747a9a.camel@kernel.org>
         <878rak8hia.fsf@mail.parknet.co.jp>
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

On Wed, 2023-08-09 at 22:36 +0900, OGAWA Hirofumi wrote:
> Jeff Layton <jlayton@kernel.org> writes:
>=20
> > On Wed, 2023-08-09 at 17:37 +0900, OGAWA Hirofumi wrote:
> > > Jeff Layton <jlayton@kernel.org> writes:
> > >=20
> > > > Also, it may be that things have changed by the time we get to call=
ing
> > > > fat_update_time after checking inode_needs_update_time. Ensure that=
 we
> > > > attempt the i_version bump if any of the S_* flags besides S_ATIME =
are
> > > > set.
> > >=20
> > > I'm not sure what it meaning though, this is from
> > > generic_update_time(). Are you going to change generic_update_time()
> > > too? If so, it doesn't break lazytime feature?
> > >=20
> >=20
> > Yes. generic_update_time is also being changed in a similar fashion.
> > This shouldn't break the lazytime feature: lazytime is all about how an=
d
> > when timestamps get written to disk. This work is all about which
> > clocksource the timestamps originally come from.
>=20
> I can only find the following update in this series, another series
> updates generic_update_time()? The patch updates only if S_VERSION is
> set.
>=20
> Your fat patch sets I_DIRTY_SYNC always instead of I_DIRTY_TIME. When I
> last time checked lazytime, and it was depending on I_DIRTY_TIME.
>=20
> Are you sure it doesn't break lazytime? I'm totally confusing, and
> really similar with generic_update_time()?
>=20

I'm a little confused too. Why do you believe this will break
-o relatime handling? This patch changes two things:

1/ it has fat_update_time fetch its own timestamp (and ignore the "now"
parameter). This is in line with the changes in patch #3 of this series,
which explains the rationale for this in more detail.

2/ it changes fat_update_time to also update the i_version if any of
S_CTIME|S_MTIME|S_VERSION are set. relatime is all about the S_ATIME,
and it is specifically excluded from that set.

The rationale for the second change is is also in patch #3, but
basically, we can't guarantee that current_time hasn't changed since we
last checked for inode_needs_update_time, so if any of
S_CTIME/S_MTIME/S_VERSION have changed, then we need to assume that any
of them may need to be changed and attempt to update all 3.

That said, I think the logic in fat_update_time isn't quite right. I
think want something like this on top of this patch to ensure that the
S_CTIME and S_MTIME get updated, even if the flags only have S_VERSION
set.

Thoughts?

---------------------8<-----------------------

diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index 080a5035483f..313eef02f45c 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -346,15 +346,21 @@ int fat_update_time(struct inode *inode, int flags)
        if (inode->i_ino =3D=3D MSDOS_ROOT_INO)
                return 0;
=20
-       if (flags & (S_ATIME | S_CTIME | S_MTIME)) {
-               fat_truncate_time(inode, NULL, flags);
-               if (inode->i_sb->s_flags & SB_LAZYTIME)
-                       dirty_flags |=3D I_DIRTY_TIME;
-               else
-                       dirty_flags |=3D I_DIRTY_SYNC;
-       }
+       /*
+        * If any of the flags indicate an expicit change to the file, then=
 we
+        * need to ensure that we attempt to update all of 3. We do not do
+        * this in the case of an S_ATIME-only update.
+        */
+       if (flags & (S_CTIME | S_MTIME | S_VERSION))
+               flags |=3D S_CTIME | S_MTIME | S_VERSION;
+
+       fat_truncate_time(inode, NULL, flags);
+       if (inode->i_sb->s_flags & SB_LAZYTIME)
+               dirty_flags |=3D I_DIRTY_TIME;
+       else
+               dirty_flags |=3D I_DIRTY_SYNC;
=20
-       if ((flags & (S_VERSION|S_CTIME|S_MTIME)) && inode_maybe_inc_iversi=
on(inode, false))
+       if ((flags & S_VERSION) && inode_maybe_inc_iversion(inode, false))
                dirty_flags |=3D I_DIRTY_SYNC;

