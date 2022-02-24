Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522AB4C23C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 06:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiBXF5d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 00:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiBXF5c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 00:57:32 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E0649923;
        Wed, 23 Feb 2022 21:57:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 90CC221111;
        Thu, 24 Feb 2022 05:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645682221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rQTyriSdku10JiEVn6acHxJLlJX45uOq556RuFZO3T4=;
        b=h2wDI5mbDkMaIPMEy3+Z5XWXrwVi0pt67DxbRIcxp0uLqTgZ80Nzx5SZx5TM7ypk6LD96u
        XF+ti9STaN6W6IFRgR3zMhUPXGa1CNGYOGnPUGRlnuoRIpedCjJC9iUg1jlnvAxR7imkdS
        YAr91kMcxPLWVRImItp4OuJum1gAS3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645682221;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rQTyriSdku10JiEVn6acHxJLlJX45uOq556RuFZO3T4=;
        b=TJQ/L/0fOg/XtjJgkPkOfZQMrY55H5wtXBsS4LVrl1khwwR4DRi6NrRjFIRUODmS4EI4lB
        +vbVS0NUdgvnr+BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 10CF613480;
        Thu, 24 Feb 2022 05:56:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rawsLyoeF2JJFAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 24 Feb 2022 05:56:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Dave Chinner" <david@fromorbit.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Daire Byrne" <daire@dneg.com>,
        "Andreas Dilger" <adilger.kernel@dilger.ca>
Subject: Re: [PATCH/RFC] VFS: support parallel updates in the one directory.
In-reply-to: <20220224044328.GB8269@magnolia>
References: <164549669043.5153.2021348013072574365@noble.neil.brown.name>,
 <20220222224546.GE3061737@dread.disaster.area>,
 <20220224044328.GB8269@magnolia>
Date:   Thu, 24 Feb 2022 16:56:55 +1100
Message-id: <164568221518.25116.18139840533197037520@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 24 Feb 2022, Darrick J. Wong wrote:
> On Wed, Feb 23, 2022 at 09:45:46AM +1100, Dave Chinner wrote:
> > On Tue, Feb 22, 2022 at 01:24:50PM +1100, NeilBrown wrote:
> > >=20
> > > Hi Al,
> > >  I wonder if you might find time to have a look at this patch.  It
> > >  allows concurrent updates to a single directory.  This can result in
> > >  substantial throughput improvements when the application uses multiple
> > >  threads to create lots of files in the one directory, and there is
> > >  noticeable per-create latency, as there can be with NFS to a remote
> > >  server.
> > > Thanks,
> > > NeilBrown
> > >=20
> > > Some filesystems can support parallel modifications to a directory,
> > > either because the modification happen on a remote server which does its
> > > own locking (e.g.  NFS) or because they can internally lock just a part
> > > of a directory (e.g.  many local filesystems, with a bit of work - the
> > > lustre project has patches for ext4 to support concurrent updates).
> > >=20
> > > To allow this, we introduce VFS support for parallel modification:
> > > unlink (including rmdir) and create.  Parallel rename is not (yet)
> > > supported.
> >=20
> > Yay!
> >=20
> > > If a filesystem supports parallel modification in a given directory, it
> > > sets S_PAR_UNLINK on the inode for that directory.  lookup_open() and
> > > the new lookup_hash_modify() (similar to __lookup_hash()) notice the
> > > flag and take a shared lock on the directory, and rely on a lock-bit in
> > > d_flags, much like parallel lookup relies on DCACHE_PAR_LOOKUP.
> >=20
> > I suspect that you could enable this for XFS right now. XFS has internal
> > directory inode locking that should serialise all reads and writes
> > correctly regardless of what the VFS does. So while the VFS might
> > use concurrent updates (e.g. inode_lock_shared() instead of
> > inode_lock() on the dir inode), XFS has an internal metadata lock
> > that will then serialise the concurrent VFS directory modifications
> > correctly....
>=20
> I don't think that will work because xfs_readdir doesn't hold the
> directory ILOCK while it runs, which means that readdir will see garbage
> if other threads now only hold inode_lock_shared while they update the
> directory.

I added this:
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -87,6 +87,7 @@ xfs_inode_alloc(
 	/* VFS doesn't initialise i_mode or i_state! */
 	VFS_I(ip)->i_mode =3D 0;
 	VFS_I(ip)->i_state =3D 0;
+	VFS_I(ip)->i_flags |=3D S_PAR_UPDATE;
 	mapping_set_large_folios(VFS_I(ip)->i_mapping);
=20
 	XFS_STATS_INC(mp, vn_active);

and ran my highly sophisticated test in an XFS directory:

 for i in {1..70}; do ( for j in {1000..8000}; do touch $j; rm -f $j ; done )=
 & done

This doesn't crash - which is a good sign.
While that was going I tried
 while : ; do ls -l ; done

it sometimes reports garbage for the stat info:

total 0
-????????? ? ?    ?    ?            ? 1749
-????????? ? ?    ?    ?            ? 1764
-????????? ? ?    ?    ?            ? 1765
-rw-r--r-- 1 root root 0 Feb 24 16:47 1768
-rw-r--r-- 1 root root 0 Feb 24 16:47 1770
-rw-r--r-- 1 root root 0 Feb 24 16:47 1772
....

I *think* that is bad - probably the "garbage" that you referred to?

Obviously I gets lots of=20
ls: cannot access '1764': No such file or directory
ls: cannot access '1749': No such file or directory
ls: cannot access '1780': No such file or directory
ls: cannot access '1765': No such file or directory

but that is normal and expected when you are creating and deleting
files during the ls.

NeilBrown




>=20
> --D
>=20
> > Yeah, I know, this isn't true concurrent dir updates, but it should
> > allow multiple implementations of the concurrent dir update VFS APIs
> > across multiple filesystems and shake out any assumptions that might
> > arise from a single implementation target (e.g. silly rename
> > quirks).
> >=20
> > Cheers,
> >=20
> > Dave.
> > --=20
> > Dave Chinner
> > david@fromorbit.com
>=20
>=20
