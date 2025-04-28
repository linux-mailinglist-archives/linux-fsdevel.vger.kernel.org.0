Return-Path: <linux-fsdevel+bounces-47497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B17CFA9EB32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 10:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3213BDC9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 08:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C1C25F78E;
	Mon, 28 Apr 2025 08:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="od326bi9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044461FF603;
	Mon, 28 Apr 2025 08:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745830429; cv=none; b=XXMfIcrQxAmKEy59v2e3TiXk740W3RT9ZQ2eOsj/diEXbgWZShYTA6Y45+Y9mRo+X9VrHoyvY7zt+k+B9yO1ONcMpDM1XrHSgwxuKZC2s0Sm7U4m7aDHJuMRfqYGYKYwruMEMmElLAMUbnLYrcBByA/uONb7FDbQ1huXb54YR3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745830429; c=relaxed/simple;
	bh=VwnIIijUV68aeumwgNi36UYJxd3Jbe9wHbDZiudw2/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mykv/ldgfsFAqwN2Ynn8mpRa2bwoqW8+2ajKrWOCM0//1RcQ1IBrDSYM8hKVgIq5ZruXNjIjO0lEPmXj/CHGfBe6MHH39AoTRUdLqTRQ2aFhtt2YrmkfsX41VAxxZF5uetAAiOndEig6ixeibAh0v35yVAtUVWaYqtMuTFSl0Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=od326bi9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66357C4CEE4;
	Mon, 28 Apr 2025 08:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745830428;
	bh=VwnIIijUV68aeumwgNi36UYJxd3Jbe9wHbDZiudw2/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=od326bi9qTazXNbqlB/m4mnS2rjfdptnoxCg/AUb/HJCu9qrmvin7M2inarikSXtB
	 DKe+PWsEp9/cjPlKOXvQwlzIOMKFemMS2UK+C7gnZC7b2a7AGOh5wOZlkXHwvRr44s
	 g/5fRaDDqSYl3o7UjpX4odGzKpgxwf2ySw3Cp5Qs2FDJWKZE/R5JeOspjCfm2a7DcP
	 ciEZh+NsC5k7xpgh84eYalPC9FeGXEda5fa52iurKEWWynJbSviAcVuLiMjUSRx/Sz
	 4RBuLx3CJWMkNa614MYfpt2pGHbTSMkAhN79CfzdkPtOuDKtEA9D3eefQsqE0owvVZ
	 D4U1L4nCj9Giw==
Date: Mon, 28 Apr 2025 10:53:43 +0200
From: Christian Brauner <brauner@kernel.org>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: paul@paul-moore.com, omosnace@redhat.com, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/xattr.c: fix simple_xattr_list to always include
 security.* xattrs
Message-ID: <20250428-zielgebiet-zinspolitik-5a500ebb76c7@brauner>
References: <20250424152822.2719-1-stephen.smalley.work@gmail.com>
 <20250425-einspannen-wertarbeit-3f0c939525dc@brauner>
 <CAEjxPJ4vntQ5cCo_=KN0d+5FDPRwStjXUimE4iHXJkz9oeuVCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEjxPJ4vntQ5cCo_=KN0d+5FDPRwStjXUimE4iHXJkz9oeuVCw@mail.gmail.com>

On Fri, Apr 25, 2025 at 11:14:46AM -0400, Stephen Smalley wrote:
> On Fri, Apr 25, 2025 at 5:20 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Thu, Apr 24, 2025 at 11:28:20AM -0400, Stephen Smalley wrote:
> > > The vfs has long had a fallback to obtain the security.* xattrs from the
> > > LSM when the filesystem does not implement its own listxattr, but
> > > shmem/tmpfs and kernfs later gained their own xattr handlers to support
> > > other xattrs. Unfortunately, as a side effect, tmpfs and kernfs-based
> >
> > This change is from 2011. So no living soul has ever cared at all for
> > at least 14 years. Surprising that this is an issue now.
> 
> Prior to the coreutils change noted in [1], no one would have had
> reason to notice. I might also be wrong about the point where it was
> first introduced - I didn't verify via testing the old commit, just
> looked for when tmpfs gained its own xattr handlers that didn't call
> security_inode_listsecurity().
> 
> [1] https://lore.kernel.org/selinux/CAEjxPJ6ocwsAAdT8cHGLQ77Z=+HOXg2KkaKNP8w9CruFj2ChoA@mail.gmail.com/T/#t
> 
> >
> > > filesystems like sysfs no longer return the synthetic security.* xattr
> > > names via listxattr unless they are explicitly set by userspace or
> > > initially set upon inode creation after policy load. coreutils has
> > > recently switched from unconditionally invoking getxattr for security.*
> > > for ls -Z via libselinux to only doing so if listxattr returns the xattr
> > > name, breaking ls -Z of such inodes.
> >
> > So no xattrs have been set on a given inode and we lie to userspace by
> > listing them anyway. Well ok then.
> 
> SELinux has always returned a result for getxattr(...,
> "security.selinux", ...) regardless of whether one has been set by
> userspace or fetched from backing store because it assigns a label to
> all inodes for use in permission checks, regardless.
> And likewise returned "security.selinux" in listxattr() for all inodes
> using either the vfs fallback or in the per-filesystem handlers prior
> to the introduction of xattr handlers for tmpfs and later
> sysfs/kernfs. SELinux labels were always a bit different than regular
> xattrs; the original implementation didn't use xattrs but we were
> directed to use them instead of our own MAC labeling scheme.

Interesting, thanks for the background.

> 
> >
> > > Before:
> > > $ getfattr -m.* /run/initramfs
> > > <no output>
> > > $ getfattr -m.* /sys/kernel/fscaps
> > > <no output>
> > > $ setfattr -n user.foo /run/initramfs
> > > $ getfattr -m.* /run/initramfs
> > > user.foo
> > >
> > > After:
> > > $ getfattr -m.* /run/initramfs
> > > security.selinux
> > > $ getfattr -m.* /sys/kernel/fscaps
> > > security.selinux
> > > $ setfattr -n user.foo /run/initramfs
> > > $ getfattr -m.* /run/initramfs
> > > security.selinux
> > > user.foo
> > >
> > > Link: https://lore.kernel.org/selinux/CAFqZXNtF8wDyQajPCdGn=iOawX4y77ph0EcfcqcUUj+T87FKyA@mail.gmail.com/
> > > Link: https://lore.kernel.org/selinux/20250423175728.3185-2-stephen.smalley.work@gmail.com/
> > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > ---
> > >  fs/xattr.c | 24 ++++++++++++++++++++++++
> > >  1 file changed, 24 insertions(+)
> > >
> > > diff --git a/fs/xattr.c b/fs/xattr.c
> > > index 02bee149ad96..2fc314b27120 100644
> > > --- a/fs/xattr.c
> > > +++ b/fs/xattr.c
> > > @@ -1428,6 +1428,15 @@ static bool xattr_is_trusted(const char *name)
> > >       return !strncmp(name, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_LEN);
> > >  }
> > >
> > > +static bool xattr_is_maclabel(const char *name)
> > > +{
> > > +     const char *suffix = name + XATTR_SECURITY_PREFIX_LEN;
> > > +
> > > +     return !strncmp(name, XATTR_SECURITY_PREFIX,
> > > +                     XATTR_SECURITY_PREFIX_LEN) &&
> > > +             security_ismaclabel(suffix);
> > > +}
> > > +
> > >  /**
> > >   * simple_xattr_list - list all xattr objects
> > >   * @inode: inode from which to get the xattrs
> > > @@ -1460,6 +1469,17 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
> > >       if (err)
> > >               return err;
> > >
> > > +     err = security_inode_listsecurity(inode, buffer, remaining_size);
> >
> > Is that supposed to work with multiple LSMs?
> > Afaict, bpf is always active and has a hook for this.
> > So the LSMs trample over each other filling the buffer?
> 
> There are a number of residual challenges to supporting full stacking
> of arbitrary LSMs; this is just one instance. Why one would stack
> SELinux with Smack though I can't imagine, and that's the only
> combination that would break (and already doesn't work, so no change
> here).
> 
> >
> > > +     if (err < 0)
> > > +             return err;
> > > +
> > > +     if (buffer) {
> > > +             if (remaining_size < err)
> > > +                     return -ERANGE;
> > > +             buffer += err;
> > > +     }
> > > +     remaining_size -= err;
> >
> > Really unpleasant code duplication in here. We have xattr_list_one() for
> > that. security_inode_listxattr() should probably receive a pointer to
> > &remaining_size?
> 
> Not sure how to avoid the duplication, but willing to take it inside
> of security_inode_listsecurity() and change its hook interface if
> desired.

A follow-up cleanup would be very much appreciated.

> 
> >
> > > +
> > >       read_lock(&xattrs->lock);
> > >       for (rbp = rb_first(&xattrs->rb_root); rbp; rbp = rb_next(rbp)) {
> > >               xattr = rb_entry(rbp, struct simple_xattr, rb_node);
> > > @@ -1468,6 +1488,10 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
> > >               if (!trusted && xattr_is_trusted(xattr->name))
> > >                       continue;
> > >
> > > +             /* skip MAC labels; these are provided by LSM above */
> > > +             if (xattr_is_maclabel(xattr->name))
> > > +                     continue;
> > > +
> > >               err = xattr_list_one(&buffer, &remaining_size, xattr->name);
> > >               if (err)
> > >                       break;
> > > --
> > > 2.49.0
> > >

