Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD415757C47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 14:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjGRMyb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 08:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjGRMya (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:54:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDACD2;
        Tue, 18 Jul 2023 05:54:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27F586155A;
        Tue, 18 Jul 2023 12:54:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD82EC433C7;
        Tue, 18 Jul 2023 12:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689684868;
        bh=V2g39nCpYOscNbJKZ9rJmpSsa451hj9EPNRN51OdGRk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hqhb6g5vJo+6+8W0RT9xDtqbOW4AnzhS1/KyN/dceFbd7YKpJbQPWq4/Cb6dq7CYf
         yAjXM+mz0/w854eRtpX5wlAeE95iG/IjxMxlxrF8PmBKq+fUtbQibuknEfBBkvv/jA
         A/iaq062saIeZ5/pg2QxPjXRMA5o+uYg7EyJLWRN8io5npshv7pVIjquFFNlQXDQ2i
         5z7JfZZ16JSPS6SLwX3ZzneOuic2kNiDc0hYFpUuCbg+eHl7hbFHwpNebskPML4TS3
         fZMHLLLRrsJNqVimjN1ZTBf057T2DRLf2nNm2rSq8TmEEHmHgaBomzWaDK0vlKWM26
         11NGJGYZvLUxQ==
Message-ID: <368e567a3a0a1a21ce37f5fba335068c50ab6f29.camel@kernel.org>
Subject: Re: linux-next ext4 inode size 128 corrupted
From:   Jeff Layton <jlayton@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 18 Jul 2023 08:54:26 -0400
In-Reply-To: <26cd770-469-c174-f741-063279cdf7e@google.com>
References: <26cd770-469-c174-f741-063279cdf7e@google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-07-17 at 20:43 -0700, Hugh Dickins wrote:
> Hi Jeff,
>=20
> I've been unable to run my kernel builds on ext4 on loop0 on tmpfs
> swapping load on linux-next recently, on one machine: various kinds
> of havoc, most common symptoms being ext4_find_dest_de:2107 errors,
> systemd-journald errors, segfaults.  But no problem observed running
> on a more recent installation.
>=20
> Bisected yesterday to 979492850abd ("ext4: convert to ctime accessor
> functions").
>=20
> I've mostly averted my eyes from the EXT4_INODE macro changes there,
> but I think that's where the problem lies.  Reading the comment in
> fs/ext4/ext4.h above EXT4_FITS_IN_INODE() led me to try "tune2fs -l"
> and look at /etc/mke2fs.conf.  It's an old installation, its own
> inodes are 256, but that old mke2fs.conf does default to 128 for small
> FSes, and what I use for the load test is small.  Passing -I 256 to the
> mkfs makes the problems go away.
>=20
> (What's most alarming about the corruption is that it appears to extend
> beyond just the throwaway test filesystem: segfaults on bash and libc.so
> from the root filesystem.  But no permanent damage done there.)
>=20
> One oddity I noticed in scrutinizing that commit, didn't help with
> the issues above, but there's a hunk in ext4_rename() which changes
> -	old.dir->i_ctime =3D old.dir->i_mtime =3D current_time(old.dir);
> +	old.dir->i_mtime =3D inode_set_ctime_current(old.inode);
>=20
>=20

I suspect the problem here is the i_crtime, which lives wholly in the
extended part of the inode. The old macros would just not store anything
if the i_crtime didn't fit, but the new ones would still store the
tv_sec field in that case, which could be a memory corruptor. This patch
should fix it, and I'm testing it now.

Hugh, if you're able to give this a spin on your setup, then that would
be most helpful. This is also in the "ctime" branch in my kernel.org
tree if that helps. If this looks good, I'll ask Christian to fold this
into the ext4 conversion patch.

Thanks for the bug report!

---------------------------8<--------------------------

[PATCH] ext4: fix the time handling macros when ext4 is using small inodes

If ext4 is using small on-disk inodes, then it may not be able to store
fine grained timestamps. It also can't store the i_crtime at all in that
case since that fully lives in the extended part of the inode.

979492850abd got the EXT4_EINODE_{GET,SET}_XTIME macros wrong, and would
still store the tv_sec field of the i_crtime into the raw_inode, even
when they were small, corrupting adjacent memory.

This fixes those macros to skip setting anything in the raw_inode if the
tv_sec field doesn't fit.=20

Cc: Jan Kara <jack@suse.cz>
Fixes: 979492850abd ("ext4: convert to ctime accessor functions")
Reported-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ext4/ext4.h | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 2af347669db7..1e2259d9967d 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -900,8 +900,10 @@ do {										\
 #define EXT4_INODE_SET_CTIME(inode, raw_inode)					\
 	EXT4_INODE_SET_XTIME_VAL(i_ctime, inode, raw_inode, inode_get_ctime(inode=
))
=20
-#define EXT4_EINODE_SET_XTIME(xtime, einode, raw_inode)			       \
-	EXT4_INODE_SET_XTIME_VAL(xtime, &((einode)->vfs_inode), raw_inode, (einod=
e)->xtime)
+#define EXT4_EINODE_SET_XTIME(xtime, einode, raw_inode)				\
+	if (EXT4_FITS_IN_INODE(raw_inode, einode, xtime))			\
+		EXT4_INODE_SET_XTIME_VAL(xtime, &((einode)->vfs_inode),		\
+					 raw_inode, (einode)->xtime)
=20
 #define EXT4_INODE_GET_XTIME_VAL(xtime, inode, raw_inode)			\
 	(EXT4_FITS_IN_INODE(raw_inode, EXT4_I(inode), xtime ## _extra) ?	\
@@ -922,9 +924,14 @@ do {										\
 		EXT4_INODE_GET_XTIME_VAL(i_ctime, inode, raw_inode));		\
 } while (0)
=20
-#define EXT4_EINODE_GET_XTIME(xtime, einode, raw_inode)			       \
-do {									       \
-	(einode)->xtime =3D EXT4_INODE_GET_XTIME_VAL(xtime, &(einode->vfs_inode),=
 raw_inode);	\
+#define EXT4_EINODE_GET_XTIME(xtime, einode, raw_inode)				\
+do {										\
+	if (EXT4_FITS_IN_INODE(raw_inode, einode, xtime)) 			\
+		(einode)->xtime =3D						\
+			EXT4_INODE_GET_XTIME_VAL(xtime, &(einode->vfs_inode),	\
+						 raw_inode);			\
+	else									\
+		(einode)->xtime =3D (struct timespec64){0, 0};			\
 } while (0)
=20
 #define i_disk_version osd1.linux1.l_i_version
--=20
2.41.0


