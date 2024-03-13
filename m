Return-Path: <linux-fsdevel+bounces-14357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F19487B2F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 21:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4C78B22EE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 20:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8FA54756;
	Wed, 13 Mar 2024 20:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mforney.org header.i=@mforney.org header.b="oGg3g8eW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06675339D
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 20:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710362383; cv=none; b=Hd1jffpYOVYi2nrWk9HTzh1RGUj4w4xDJK+6QS09YppAY1tPmXf5ACUA2FXDhk6DBRQ8q4Fb6YfTV6YRUkxz1muJoK0yxfdqZwvLMlMGa+gOJnrSgWuswTBbIIHPlT8ZzQwLCaPukoxEICc38K2KugV0aD9vgVLKqkD7XwxiQKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710362383; c=relaxed/simple;
	bh=5NYy5F9GaegC1adFOjJmjFtFKrgOGt8L8XjVO8/x/uA=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:Message-Id:
	 MIME-Version:Content-Type; b=Mqhqj0vuw/DMNdysySqlm2Eo1TUwJjHuggkulyhZfVTuC7zO8QWMs/y40cEUsxU0Qkp8ClVWFddKLxfgZa0kAkzdgEzdOA/IA4XIs0q+7eL5M4TUKwbKCivCWG97R12wfXTtUemZjQamMFCS+xpRzqfRuSF6JbVp36ne0kT24+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mforney.org; spf=pass smtp.mailfrom=mforney.org; dkim=pass (2048-bit key) header.d=mforney.org header.i=@mforney.org header.b=oGg3g8eW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mforney.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mforney.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dd8f7d50c6so10560675ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 13:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney.org; s=google; t=1710362381; x=1710967181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:references:from:subject:cc:to:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JrhTyp84sWHbOiBAqJX2C5jIkkkaEpg/S6Nrn3IynAs=;
        b=oGg3g8eW7Ecp6k8wTelqVv/haRgZlmM6e3mOz4fH3MX5P7S1NTqPknDMwduj0Pg/FZ
         HobP8nODlrlprSh3M7un8SCqPHk7+oXlnQ1CFsofWx01Wg8Ng2kxzU1uZGWOe6WwOEFd
         7i2wUNhZ7VM/pNrl6AgYhTjHRJ32pPr/5KpgfJk+uM8+xqTD6X+TfFwt2YHqa3S1oQ5h
         Sy/cPOLRColvjjkGi6mUB6npaUbh3BkcVFFPBxQqvCjAeEaIT9IuEjjErb9j3zfo2cbx
         7j3m18w5/KIZUz6Sh1I+HbVQAXODZmHU1BmUQI2RLnlW0kR15vHARi1uE11lZYmYjYlb
         GJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710362381; x=1710967181;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:references:from:subject:cc:to:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JrhTyp84sWHbOiBAqJX2C5jIkkkaEpg/S6Nrn3IynAs=;
        b=jgMyxJJeDt4axWxpschaH4ku7bdjjabJJ54/2RQNnG+EA8/q2eqihEzSiexQSBYxIr
         lGHjbKYVSjcpIubJ9nCmbWB/Y2YawPEo5k108Ji25tuZU6R0SMt7nZ8xfHnTME5KlDIO
         K2HOZm26dURd7svZjZSyTCuQ9uvAzPMXkPkHRwAQStsNawnAp3GszqwMdVJ46tkPCBhN
         hnrNWw1+LFfeeI4ZF5lB4KuvIDm473SYYZYKFAhPohW2tAnvyupM1w9Dgbe0dGUvWr/7
         WG8EDqfO7gr6/kkm2m5kWFtCrqIXLOsNXbZbxagrFhht3ARwTpuYATsRk+IWbgQi7rxG
         lWVg==
X-Forwarded-Encrypted: i=1; AJvYcCXjIPw8AVNsnH1ejQH+k4uXjKuhb+TLLmOoIgiHgQW/PtwBSOQ5VuOCxCIeFzwAFMFcTuDdbSU5TCap0MFt4xSJRN16ajTwPm0CpFxoig==
X-Gm-Message-State: AOJu0YxUFoxs+WiPMof6WpI3uQNEnsWS3cbHLjKnQZUxZTB+Qs5AcwNE
	wQFwwnqQjQQ5embrwx852D+WgURq6IgbVUH300FPmVAQ0nswzMvojelg6Q20rtI=
X-Google-Smtp-Source: AGHT+IE/KQaRwJCmaxE7HGMWWWwC9HUvtwPSaTkkWMsQzRjSycKrqz980rtkW102JSTf6os/v9ns7A==
X-Received: by 2002:a17:902:ea05:b0:1dd:a12e:15c8 with SMTP id s5-20020a170902ea0500b001dda12e15c8mr5302773plg.33.1710362380873;
        Wed, 13 Mar 2024 13:39:40 -0700 (PDT)
Received: from localhost ([2601:647:6400:20b0:16dd:a9ff:fee7:6b79])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902d50600b001db693d89fdsm22392plg.179.2024.03.13.13.39.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2024 13:39:40 -0700 (PDT)
Date: Wed, 13 Mar 2024 13:40:46 -0700
To: Jan Kara <jack@suse.cz>
Cc: Theodore Ts'o <tytso@mit.edu>, Christian Brauner <brauner@kernel.org>,
 Max Kellermann <max.kellermann@ionos.com>, Xiubo Li <xiubli@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>, Jan
 Kara <jack@suse.com>, Dave Kleikamp <shaggy@kernel.org>,
 ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net, Yang Xu
 <xuyang2018.jy@fujitsu.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs/{posix_acl,ext2,jfs,ceph}: apply umask if ACL
 support is disabled
From: Michael Forney <mforney@mforney.org>
References: <20231011100541.sfn3prgtmp7hk2oj@quack3>
 <CAKPOu+_xdFALt9sgdd5w66Ab6KTqiy8+Z0Yd3Ss4+92jh8nCwg@mail.gmail.com>
 <20231011120655.ndb7bfasptjym3wl@quack3>
 <CAKPOu+-hLrrpZShHh0o6uc_KMW91suEd0_V_uzp5vMf4NM-8yw@mail.gmail.com>
 <CAKPOu+_0yjg=PrwAR8jKok8WskjdDEJOBtu3uKR_4Qtp8b7H1Q@mail.gmail.com>
 <20231011135922.4bij3ittlg4ujkd7@quack3>
 <20231011-braumeister-anrufen-62127dc64de0@brauner>
 <20231011170042.GA267994@mit.edu> <20231011172606.mztqyvclq6hq2qa2@quack3>
 <20231012142918.GB255452@mit.edu> <20231012144246.h3mklfe52gwacrr6@quack3>
In-Reply-To: <20231012144246.h3mklfe52gwacrr6@quack3>
Message-Id: <28DSITL9912E1.2LSZUVTGTO52Q@mforney.org>
User-Agent: mblaze/1.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Jan Kara <jack@suse.cz> wrote:
> On Thu 12-10-23 10:29:18, Theodore Ts'o wrote:
> > On Wed, Oct 11, 2023 at 07:26:06PM +0200, Jan Kara wrote:
> > > I don't think this is accurate. posix_acl_create() needs unmasked 'mo=
de'
> > > because instead of using current_umask() for masking it wants to use
> > > whatever is stored in the ACLs as an umask.
> > >=20
> > > So I still think we need to keep umask handling in both posix_acl_cre=
ate()
> > > and vfs_prepare_mode(). But filesystem's only obligation would be to =
call
> > > posix_acl_create() if the inode is IS_POSIXACL. No more caring about =
when
> > > to apply umask and when not based on config or mount options.
> >=20
> > Ah, right, thanks for the clarification.  I *think* the following
> > patch in the ext4 dev branch (not yet in Linus's tree, but it should
> > be in linux-next) should be harmless, though, right?  And once we get
> > the changes in vfs_prepare_mode() we can revert in ext4 --- or do
> > folks I think I should just drop it from the ext4 dev branch now?
>=20
> It definitely does no harm. As you say, you can revert it once the VFS
> changes land if you want.

I've been debugging why flatpak was always considering its database
corrupted, and found this commit to be the source of the issue.

$ ostree --repo=3Drepo --mode=3Dbare-user-only init
$ mkdir tree && umask 0 && ln -s target tree/symlink && umask 022
$ ostree --repo=3Drepo commit --branch=3Dfoo tree/
c508e0564267b376661889b9016f8438bd6d39412078838f78856383fdd8ac2f
$ ostree --repo=3Drepo fsck
Validating refs...
Validating refs in collections...
Enumerating commits...
Verifying content integrity of 1 commit objects...
fsck objects (1/4) [=3D=3D=3D          ]  25%
error: In commits c508e0564267b376661889b9016f8438bd6d39412078838f78856383f=
dd8ac2f: fsck content object a6b40a5400ed082fbe067d2c8397aab54046a089768651=
c392a36db46d24c1cd: Corrupted file object; checksum expected=3D'a6b40a5400e=
d082fbe067d2c8397aab54046a089768651c392a36db46d24c1cd'
actual=3D'6bdc88f9722f96dbd51735e381f8a1b0e01363e1d7ee2edbb474c091f83c3987'=

$

Turns out that symlinks are inheriting umask on my system (which
has CONFIG_EXT4_FS_POSIX_ACL=3Dn):

$ umask 022
$ ln -s target symlink
$ ls -l symlink
lrwxr-xr-x    1 michael  michael           6 Mar 13 13:28 symlink -> target=

$

Looking at the referenced functions, posix_acl_create() returns
early before applying umask for symlinks, but ext4_init_acl() now
applies the umask unconditionally.

After reverting this commit, it works correctly. I am also unable
to reproduce the mentioned issue with O_TMPFILE after reverting the
commit. It seems that the bug was fixed properly in ac6800e279a2
('fs: Add missing umask strip in vfs_tmpfile'), and all branches
that have this ext4_init_acl patch already had ac6800e279a2 backported.

So I think this patch should be reverted, since the bug was already
fixed and it breaks symlink modes. If not, it should at least be
changed to not to apply the umask to symlinks.

> > commit 484fd6c1de13b336806a967908a927cc0356e312
> > Author: Max Kellermann <max.kellermann@ionos.com>
> > Date:   Tue Sep 19 10:18:23 2023 +0200
> >=20
> >     ext4: apply umask if ACL support is disabled
> >    =20
> >     The function ext4_init_acl() calls posix_acl_create() which is
> >     responsible for applying the umask.  But without
> >     CONFIG_EXT4_FS_POSIX_ACL, ext4_init_acl() is an empty inline functi=
on,
> >     and nobody applies the umask.
> >    =20
> >     This fixes a bug which causes the umask to be ignored with O_TMPFIL=
E
> >     on ext4:
> >    =20
> >      https://github.com/MusicPlayerDaemon/MPD/issues/558
> >      https://bugs.gentoo.org/show_bug.cgi?id=3D686142#c3
> >      https://bugzilla.kernel.org/show_bug.cgi?id=3D203625
> >    =20
> >     Reviewed-by: "J. Bruce Fields" <bfields@redhat.com>
> >     Cc: stable@vger.kernel.org
> >     Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> >     Link: https://lore.kernel.org/r/20230919081824.1096619-1-max.keller=
mann@ionos.com
> >     Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> >=20
> > diff --git a/fs/ext4/acl.h b/fs/ext4/acl.h
> > index 0c5a79c3b5d4..ef4c19e5f570 100644
> > --- a/fs/ext4/acl.h
> > +++ b/fs/ext4/acl.h
> > @@ -68,6 +68,11 @@ extern int ext4_init_acl(handle_t *, struct inode *,=
 struct inode *);
> >  static inline int
> >  ext4_init_acl(handle_t *handle, struct inode *inode, struct inode *dir=
)
> >  {
> > +	/* usually, the umask is applied by posix_acl_create(), but if
> > +	   ext4 ACL support is disabled at compile time, we need to do
> > +	   it here, because posix_acl_create() will never be called */
> > +	inode->i_mode &=3D ~current_umask();
> > +
> >  	return 0;
> >  }
> >  #endif  /* CONFIG_EXT4_FS_POSIX_ACL */

