Return-Path: <linux-fsdevel+bounces-46566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637BEA90614
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 16:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769E216C873
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 14:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA3C206F19;
	Wed, 16 Apr 2025 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5I1KsIK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F67207662
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744812861; cv=none; b=TTswNE3fe3a1AcYQj7TEyFFr2BbLWCRvI42m3LCCgAUe3RVXTfRdEkuORbfB/avn6r1GBJEHGUSLKy4THQv28K8pgOwfe4CgTQpaNK4AvToXvwOh2HdLYaWWxH+mDpqsGjx1MmtQPT0KJDLCbhdh0jfOFolMoWN9+Q2/hRgDpeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744812861; c=relaxed/simple;
	bh=fYGQtiENHLaaraeldqAnfbSgrfpUba89VWuva2ABuWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5u+NWnKjiGH8++v0rBicTaAUK9sd1i01eDWVnHA5RhzrVcVFtg5QX2qZ7Qh5l0qWy1CJ3A8awElsBOmVUjVKWyzyk2BM5va/3iKirCQxksuI29SqR72nmbdWSd0vqPemhjsGVMKzWpsOW0Rdb+hSiU5LPcksoJDY8Fzw/Xfwz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5I1KsIK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CECBC4CEE2;
	Wed, 16 Apr 2025 14:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744812859;
	bh=fYGQtiENHLaaraeldqAnfbSgrfpUba89VWuva2ABuWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R5I1KsIKhCrgfa01WyI6al7gyzZshe4AK87urOmyPdVII4Tu0Te7Iwyuz+9arjRPk
	 fXZKwdSjns89cPybjBWM6ImYhZ3QCpoHsctKjawha8B2D3uEXiP9Cs19GHPY7cwVlK
	 PxWrjmem8okDzCWGnH82qTUNgnqayUNVzuUSZBQO2jFUvHcnomRoEyyjA6hpibABXA
	 ciCOdeF5pe0OYE9MoLxg7lMH2nNUcffojZs6kC7iXFJ61/f45PxInTjDFn2t1AasBK
	 K4K8mFHvMvxJnxeV8xQH5feX2xU9jLbVl7tcUegq5ksQKTQXwIpbMnqhkqTeM2YHL5
	 tu4DGnMV+BKsA==
Date: Wed, 16 Apr 2025 16:14:15 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH RFC 1/3] inode: add fastpath for filesystem user
 namespace retrieval
Message-ID: <20250416-administration-unkritisch-39f9e573fa17@brauner>
References: <20250416-work-mnt_idmap-s_user_ns-v1-0-273bef3a61ec@kernel.org>
 <20250416-work-mnt_idmap-s_user_ns-v1-1-273bef3a61ec@kernel.org>
 <CAGudoHGQ=2B8F84YOzR1Xse3XjheYbWZnCfpLjfxYKabvceTtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHGQ=2B8F84YOzR1Xse3XjheYbWZnCfpLjfxYKabvceTtQ@mail.gmail.com>

On Wed, Apr 16, 2025 at 03:49:43PM +0200, Mateusz Guzik wrote:
> On Wed, Apr 16, 2025 at 3:17 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > We currently always chase a pointer inode->i_sb->s_user_ns whenever we
> > need to map a uid/gid which is noticeable during path lookup as noticed
> > by Linus in [1]. In the majority of cases we don't need to bother with
> > that pointer chase because the inode won't be located on a filesystem
> > that's mounted in a user namespace. The user namespace of the superblock
> > cannot ever change once it's mounted. So introduce and raise IOP_USERNS
> > on all inodes and check for that flag in i_user_ns() when we retrieve
> > the user namespace.
> >
> > Link: https://lore.kernel.org/CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com [1]
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/inode.c                    |  6 ++++++
> >  fs/mnt_idmapping.c            | 14 --------------
> >  include/linux/fs.h            |  5 ++++-
> >  include/linux/mnt_idmapping.h | 14 ++++++++++++++
> >  4 files changed, 24 insertions(+), 15 deletions(-)
> >
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 99318b157a9a..7335d05dd7d5 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -245,6 +245,8 @@ int inode_init_always_gfp(struct super_block *sb, struct inode *inode, gfp_t gfp
> >                 inode->i_opflags |= IOP_XATTR;
> >         if (sb->s_type->fs_flags & FS_MGTIME)
> >                 inode->i_opflags |= IOP_MGTIME;
> > +       if (unlikely(!initial_idmapping(i_user_ns(inode))))
> > +               inode->i_opflags |= IOP_USERNS;
> >         i_uid_write(inode, 0);
> >         i_gid_write(inode, 0);
> >         atomic_set(&inode->i_writecount, 0);
> > @@ -1864,6 +1866,10 @@ static void iput_final(struct inode *inode)
> >
> >         WARN_ON(inode->i_state & I_NEW);
> >
> > +       /* This is security sensitive so catch missing IOP_USERNS. */
> > +       VFS_WARN_ON_ONCE(!initial_idmapping(i_user_ns(inode)) &&
> > +                        !(inode->i_opflags & IOP_USERNS));
> > +
> >         if (op->drop_inode)
> >                 drop = op->drop_inode(inode);
> >         else
> > diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
> > index a37991fdb194..8f7ae908ea16 100644
> > --- a/fs/mnt_idmapping.c
> > +++ b/fs/mnt_idmapping.c
> > @@ -42,20 +42,6 @@ struct mnt_idmap invalid_mnt_idmap = {
> >  };
> >  EXPORT_SYMBOL_GPL(invalid_mnt_idmap);
> >
> > -/**
> > - * initial_idmapping - check whether this is the initial mapping
> > - * @ns: idmapping to check
> > - *
> > - * Check whether this is the initial mapping, mapping 0 to 0, 1 to 1,
> > - * [...], 1000 to 1000 [...].
> > - *
> > - * Return: true if this is the initial mapping, false if not.
> > - */
> > -static inline bool initial_idmapping(const struct user_namespace *ns)
> > -{
> > -       return ns == &init_user_ns;
> > -}
> > -
> >  /**
> >   * make_vfsuid - map a filesystem kuid according to an idmapping
> >   * @idmap: the mount's idmapping
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 016b0fe1536e..d28384d5b752 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -663,6 +663,7 @@ is_uncached_acl(struct posix_acl *acl)
> >  #define IOP_DEFAULT_READLINK   0x0010
> >  #define IOP_MGTIME     0x0020
> >  #define IOP_CACHED_LINK        0x0040
> > +#define IOP_USERNS     0x0080
> >
> >  /*
> >   * Keep mostly read-only and often accessed (especially for
> > @@ -1454,7 +1455,9 @@ struct super_block {
> >
> >  static inline struct user_namespace *i_user_ns(const struct inode *inode)
> >  {
> > -       return inode->i_sb->s_user_ns;
> > +       if (unlikely(inode->i_opflags & IOP_USERNS))
> > +               return inode->i_sb->s_user_ns;
> > +       return &init_user_ns;
> >  }
> >
> >  /* Helper functions so that in most cases filesystems will
> > diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
> > index e71a6070a8f8..85553b3a7904 100644
> > --- a/include/linux/mnt_idmapping.h
> > +++ b/include/linux/mnt_idmapping.h
> > @@ -25,6 +25,20 @@ static_assert(sizeof(vfsgid_t) == sizeof(kgid_t));
> >  static_assert(offsetof(vfsuid_t, val) == offsetof(kuid_t, val));
> >  static_assert(offsetof(vfsgid_t, val) == offsetof(kgid_t, val));
> >
> > +/**
> > + * initial_idmapping - check whether this is the initial mapping
> > + * @ns: idmapping to check
> > + *
> > + * Check whether this is the initial mapping, mapping 0 to 0, 1 to 1,
> > + * [...], 1000 to 1000 [...].
> > + *
> > + * Return: true if this is the initial mapping, false if not.
> > + */
> > +static inline bool initial_idmapping(const struct user_namespace *ns)
> > +{
> > +       return ns == &init_user_ns;
> > +}
> > +
> >  static inline bool is_valid_mnt_idmap(const struct mnt_idmap *idmap)
> >  {
> >         return idmap != &nop_mnt_idmap && idmap != &invalid_mnt_idmap;
> >
> > --
> > 2.47.2
> >
> 
> I don't have an opinion.
> 
> But if going this way, i think you want the assert for correctly
> applied flag when fetching the ns, not just iput_final.

Sure.

