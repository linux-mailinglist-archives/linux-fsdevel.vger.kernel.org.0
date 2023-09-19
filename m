Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6297A66A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 16:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjISO0r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 10:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbjISO0q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:26:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D9F83;
        Tue, 19 Sep 2023 07:26:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE7CC433C7;
        Tue, 19 Sep 2023 14:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695133600;
        bh=vg3ncpJ1FzlUxd5pdhZEuFzBDH4MjdcTHQqnQDMiayw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LR7t8m7XdliJXlsXKFQuYbHtNRKdwMi5eRtBifoujeW7INugVKy5Qp7VCnKlsmwwv
         8BbhaGgYPvHflia+qZfNEJW9duIFsIrQFDydhinQULW9HNCaHE/kf0o1WzWpo2p5to
         CXsZvXwcaXCMnVrPlAtWXfmbgB4o/CJNydBBYCVQl3brCDEEcMznIcy/DAERilgphe
         rkG396QM+dO+x5J9PjJn60OdVP9dbYrPxnqKQjrCVcxVHQyKSTmInGCF9Ii+1++y97
         CYM44WCWdYxi55/Nt+UB1QsmX9UGqMlFKX+z35AG4ozpIWyw5107vPYU6gNmLeKnJF
         ImAwUKVmely7w==
Message-ID: <a955495733e55f4fecad42b252c0360a210988ff.camel@kernel.org>
Subject: Re: [PATCH] linux/fs.h: fix umask on NFS with CONFIG_FS_POSIX_ACL=n
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Trond Myklebust <trondmy@gmail.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "J . Bruce Fields" <bfields@redhat.com>, Jan Kara <jack@suse.cz>,
        stable@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Max Kellermann <max.kellermann@ionos.com>
Date:   Tue, 19 Sep 2023 10:26:38 -0400
In-Reply-To: <20230919-altbekannt-musisch-35ac924166cf@brauner>
References: <20230919081837.1096695-1-max.kellermann@ionos.com>
         <20230919-altbekannt-musisch-35ac924166cf@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-09-19 at 15:02 +0200, Christian Brauner wrote:
> On Tue, Sep 19, 2023 at 10:18:36AM +0200, Max Kellermann wrote:
> > Make IS_POSIXACL() return false if POSIX ACL support is disabled and
> > ignore SB_POSIXACL/MS_POSIXACL.
> >=20
> > Never skip applying the umask in namei.c and never bother to do any
> > ACL specific checks if the filesystem falsely indicates it has ACLs
> > enabled when the feature is completely disabled in the kernel.
> >=20
> > This fixes a problem where the umask is always ignored in the NFS
> > client when compiled without CONFIG_FS_POSIX_ACL.  This is a 4 year
> > old regression caused by commit 013cdf1088d723 which itself was not
> > completely wrong, but failed to consider all the side effects by
> > misdesigned VFS code.
> >=20
> > Prior to that commit, there were two places where the umask could be
> > applied, for example when creating a directory:
> >=20
> >  1. in the VFS layer in SYSCALL_DEFINE3(mkdirat), but only if
> >     !IS_POSIXACL()
> >=20
> >  2. again (unconditionally) in nfs3_proc_mkdir()
> >=20
> > The first one does not apply, because even without
> > CONFIG_FS_POSIX_ACL, the NFS client sets MS_POSIXACL in
> > nfs_fill_super().
>=20
> Jeff, in light of the recent SB_NOUMASK work for nfs4 to always skip
> applying the umask how would this patch fit into the picture? Would be
> good to have your review here.
>=20
> >=20
> > After that commit, (2.) was replaced by:
> >=20
> >  2b. in posix_acl_create(), called by nfs3_proc_mkdir()
> >=20
> > There's one branch in posix_acl_create() which applies the umask;
> > however, without CONFIG_FS_POSIX_ACL, posix_acl_create() is an empty
> > dummy function which does not apply the umask.
> >=20
> > The approach chosen by this patch is to make IS_POSIXACL() always
> > return false when POSIX ACL support is disabled, so the umask always
> > gets applied by the VFS layer.  This is consistent with the (regular)
> > behavior of posix_acl_create(): that function returns early if
> > IS_POSIXACL() is false, before applying the umask.
> >=20
> > Therefore, posix_acl_create() is responsible for applying the umask if
> > there is ACL support enabled in the file system (SB_POSIXACL), and the
> > VFS layer is responsible for all other cases (no SB_POSIXACL or no
> > CONFIG_FS_POSIX_ACL).
> >=20
> > Reviewed-by: J. Bruce Fields <bfields@redhat.com>
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> > ---
> >  include/linux/fs.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 4aeb3fa11927..c1a4bc5c2e95 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2110,7 +2110,12 @@ static inline bool sb_rdonly(const struct super_=
block *sb) { return sb->s_flags
> >  #define IS_NOQUOTA(inode)	((inode)->i_flags & S_NOQUOTA)
> >  #define IS_APPEND(inode)	((inode)->i_flags & S_APPEND)
> >  #define IS_IMMUTABLE(inode)	((inode)->i_flags & S_IMMUTABLE)
> > +
> > +#ifdef CONFIG_FS_POSIX_ACL
> >  #define IS_POSIXACL(inode)	__IS_FLG(inode, SB_POSIXACL)
> > +#else
> > +#define IS_POSIXACL(inode)	0
> > +#endif
> > =20
> >  #define IS_DEADDIR(inode)	((inode)->i_flags & S_DEAD)
> >  #define IS_NOCMTIME(inode)	((inode)->i_flags & S_NOCMTIME)
> > --=20
> > 2.39.2
> >=20

(cc'ing Trond and Anna)

To be clear, Christian is talking about this patch that I sent last
week:

https://lore.kernel.org/linux-fsdevel/20230911-acl-fix-v3-1-b25315333f6c@ke=
rnel.org/

At first glance, I don't see a problem with Max's patch.

If anything the patch in the lore link above should keep NFSv4 working
as expected if we take Max's patch. You might also need to add
SB_I_NOUMASK for the NFSv3 case, but I'm not certain there.
--=20
Jeff Layton <jlayton@kernel.org>
