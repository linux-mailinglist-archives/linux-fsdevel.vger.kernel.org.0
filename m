Return-Path: <linux-fsdevel+bounces-61805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726A4B59F88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 19:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F24A16BF70
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 17:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3953031E894;
	Tue, 16 Sep 2025 17:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfH0Cx3B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCC42F5A2F
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758044328; cv=none; b=cRobExAUe8e49sjMF+J6y7ZM1bCJC0WlpE9/lHgbekNcKi0ZbRDWSNUGP1gncpS5NHmjj6eDrkp5Pt/td424YVH2+i+CyIJjQIV9ckzaAu07zLNajTVYZwBFT3tcKuwSJtJpfQlUrFwIM9B7Mr21AHOBBYTgdxzzLMOvh+9rbfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758044328; c=relaxed/simple;
	bh=zKUgt0gUNcL0CAw+ftmR3WEbBxbg+hYQUd2BC5lpGxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rzzaURiFGCgYPpE8Kbrwhc8bHr22/v152ltFikyiH88Nk7LV5rHHK+sIjVPhDKH1mJnF2CHgxfNbmgIppW5jcXifj7nUOlfcUqYAGH66WhAdtP89dr//iSBSB82e3OYwM8xSg7TmLBP7yYAnLWFcti55Yy2cjYezqFMrAChW3DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfH0Cx3B; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62f1987d49fso2592448a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 10:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758044324; x=1758649124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3TcgADr/097b4uZyQGdMCl4rLNQ0NPXzmfPchyLdPQ=;
        b=GfH0Cx3ByMZLLxuxss1hw9y6ViWjc6GFXUTwh8wxiFuQyv1UNTF3+pkG1NAcvjRS54
         cAqDndDj82iHj5Dj9+66Ku5azYCOnuzXOZa8RPNrUPX6BXwBggfcPSOzDDN0usx73RnO
         kQlsYc+f10/0RLCOTYmKSAvOtFPwrlhNpM8vpEh0u3Pf3+kRtbfM5Udwf2CtpX5axh6I
         Ur0Osf4gvnN39m61oQpRMIa5G7es8Y84Gaq2QZvbkoj3aLr55nKqwHnLF59H1+wHRD4E
         fIBjOc/qiILJj1W02mnrxmslq4kG2lFtO1RGBGaXj9Uof0wRO3cabDN7waUHM0Vrkco5
         SdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758044324; x=1758649124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3TcgADr/097b4uZyQGdMCl4rLNQ0NPXzmfPchyLdPQ=;
        b=cC+AouL7N8q/j7y8aeX5USTCXedm9q4cJbtOT4fAdqN6UflBfO9pUgViqy9Yia0QY4
         VyHYRUR/JgIdBDfpnqeDNnyBzrxxo3vsDkeW7/6ocTn14YkX4lebr67Y0gvOha6Eq8LA
         Ipnl4Gqlkf82G/xO/kjdUwUb2sXx+GkOdAOthyi69tmXR49FgTMTZkdi6SYZerPG7RPD
         NM8lwQtRimbNyTuIF1CZlUgz560UQ0vFimm+7neUxClMHjMzHR6aDfMZQjC7e4kgeVll
         VmwVjMHTEAIx1Xh256epvdZB+lEd44UVidiTga10nkRa0aDpHkry/5T+sfGM38spSEfU
         qNsA==
X-Forwarded-Encrypted: i=1; AJvYcCWurfXwTFKCWPaFbqNQpC4/QtaiODMNiI5wYy+udYCGxuJ4jqpuYBVOrRsTixnDcbDJ8dPOsqCQilDXjsno@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa8HFffSO+GzWkdvwuwUGN4ke3o4QaqzxKWQLzu1Pj6hJn03ZL
	f0YkDQnS+TlOseVV8EhHmb9OgHa6NHPo6K0HdQPm3mbUz3YcTRYtHeAQeCPMQbvDg8+lxwuo0LB
	4PQyvFW+lH50BW1xOOiIUy8yk5QUOc+Q=
X-Gm-Gg: ASbGncv+Xm/VkooAuOSMlXh2dUKltSxj68s5fs8A8HCPcC1tQ4jOrBF7H1ftX00iFMw
	7+12miu8/lWUPxvY6eTxPqzegU7NPC+rtQmE4kRR8lJ55gZzLrVw5RoZT3xKu68QNpfeJgiecXQ
	olmq/WOQ7iA2wm2PhIH28vEspyKFMEG9y2UK8umG08mV9jHP7JLQZfjNZGBimLGeo0z1vDEBGCj
	9puEy+tcghXgQ1SDetbgse5KwnB8tK3Wn6i5gM=
X-Google-Smtp-Source: AGHT+IEQAizvJyfl6mOXg4hBBS+TalumNbe7qc/OZyNcho/cVYkSxvxPEoWzONM4gKvQT/mtpDeTEZzuaP3ja1SqEuc=
X-Received: by 2002:a05:6402:21ce:b0:61c:7b6e:b242 with SMTP id
 4fb4d7f45d1cf-62ed69e016amr15383132a12.0.1758044323803; Tue, 16 Sep 2025
 10:38:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916135900.2170346-1-mjguzik@gmail.com> <20250916135900.2170346-11-mjguzik@gmail.com>
 <81eada571cb7892a5df26e50884ed0cbeed6220e.camel@ibm.com>
In-Reply-To: <81eada571cb7892a5df26e50884ed0cbeed6220e.camel@ibm.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 16 Sep 2025 19:38:30 +0200
X-Gm-Features: AS18NWAmVDlsNyi6dtnYK_j30gOV-5wVdqXuIOB6nJEDQ-VrcixkXRBh_VFTN3g
Message-ID: <CAGudoHGxxf_vXB-J8SWwaq6MFdK-+H=-q1+tx4pDNT8mTgHYug@mail.gmail.com>
Subject: Re: [PATCH v4 10/12] ceph: use the new ->i_state accessors
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "brauner@kernel.org" <brauner@kernel.org>, "jack@suse.cz" <jack@suse.cz>, 
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "kernel-team@fb.com" <kernel-team@fb.com>, 
	"josef@toxicpanda.com" <josef@toxicpanda.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, 
	"amir73il@gmail.com" <amir73il@gmail.com>, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 7:36=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Tue, 2025-09-16 at 15:58 +0200, Mateusz Guzik wrote:
> > Change generated with coccinelle and fixed up by hand as appropriate.
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
> >  fs/ceph/cache.c  |  2 +-
> >  fs/ceph/crypto.c |  4 ++--
> >  fs/ceph/file.c   |  4 ++--
> >  fs/ceph/inode.c  | 28 ++++++++++++++--------------
> >  4 files changed, 19 insertions(+), 19 deletions(-)
> >
>
> Looks good. I simply started to guess. Do we need a method something like=
 this?
>
> bool inode_is_new(struct inode *inode)
> {
>     return inode_state_read_once(inode) & I_NEW;
> }
>

Helpers of the sort might show up later after the flag situation gets
sorted out, for now it's baby steps.

> Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> Thanks,
> Slava.
>
> > diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
> > index 930fbd54d2c8..f678bab189d8 100644
> > --- a/fs/ceph/cache.c
> > +++ b/fs/ceph/cache.c
> > @@ -26,7 +26,7 @@ void ceph_fscache_register_inode_cookie(struct inode =
*inode)
> >               return;
> >
> >       /* Only new inodes! */
> > -     if (!(inode->i_state & I_NEW))
> > +     if (!(inode_state_read_once(inode) & I_NEW))
> >               return;
> >
> >       WARN_ON_ONCE(ci->netfs.cache);
> > diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> > index 7026e794813c..928746b92512 100644
> > --- a/fs/ceph/crypto.c
> > +++ b/fs/ceph/crypto.c
> > @@ -329,7 +329,7 @@ int ceph_encode_encrypted_dname(struct inode *paren=
t, char *buf, int elen)
> >  out:
> >       kfree(cryptbuf);
> >       if (dir !=3D parent) {
> > -             if ((dir->i_state & I_NEW))
> > +             if ((inode_state_read_once(dir) & I_NEW))
> >                       discard_new_inode(dir);
> >               else
> >                       iput(dir);
> > @@ -438,7 +438,7 @@ int ceph_fname_to_usr(const struct ceph_fname *fnam=
e, struct fscrypt_str *tname,
> >       fscrypt_fname_free_buffer(&_tname);
> >  out_inode:
> >       if (dir !=3D fname->dir) {
> > -             if ((dir->i_state & I_NEW))
> > +             if ((inode_state_read_once(dir) & I_NEW))
> >                       discard_new_inode(dir);
> >               else
> >                       iput(dir);
> > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > index c02f100f8552..59f2be41c9aa 100644
> > --- a/fs/ceph/file.c
> > +++ b/fs/ceph/file.c
> > @@ -744,7 +744,7 @@ static int ceph_finish_async_create(struct inode *d=
ir, struct inode *inode,
> >                     vino.ino, ceph_ino(dir), dentry->d_name.name);
> >               ceph_dir_clear_ordered(dir);
> >               ceph_init_inode_acls(inode, as_ctx);
> > -             if (inode->i_state & I_NEW) {
> > +             if (inode_state_read_once(inode) & I_NEW) {
> >                       /*
> >                        * If it's not I_NEW, then someone created this b=
efore
> >                        * we got here. Assume the server is aware of it =
at
> > @@ -907,7 +907,7 @@ int ceph_atomic_open(struct inode *dir, struct dent=
ry *dentry,
> >                               new_inode =3D NULL;
> >                               goto out_req;
> >                       }
> > -                     WARN_ON_ONCE(!(new_inode->i_state & I_NEW));
> > +                     WARN_ON_ONCE(!(inode_state_read_once(new_inode) &=
 I_NEW));
> >
> >                       spin_lock(&dentry->d_lock);
> >                       di->flags |=3D CEPH_DENTRY_ASYNC_CREATE;
> > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > index 480cb3a1d639..6786ec955a87 100644
> > --- a/fs/ceph/inode.c
> > +++ b/fs/ceph/inode.c
> > @@ -86,7 +86,7 @@ struct inode *ceph_new_inode(struct inode *dir, struc=
t dentry *dentry,
> >                       goto out_err;
> >       }
> >
> > -     inode->i_state =3D 0;
> > +     inode_state_set_raw(inode, 0);
> >       inode->i_mode =3D *mode;
> >
> >       err =3D ceph_security_init_secctx(dentry, *mode, as_ctx);
> > @@ -155,7 +155,7 @@ struct inode *ceph_get_inode(struct super_block *sb=
, struct ceph_vino vino,
> >
> >       doutc(cl, "on %llx=3D%llx.%llx got %p new %d\n",
> >             ceph_present_inode(inode), ceph_vinop(inode), inode,
> > -           !!(inode->i_state & I_NEW));
> > +           !!(inode_state_read_once(inode) & I_NEW));
> >       return inode;
> >  }
> >
> > @@ -182,7 +182,7 @@ struct inode *ceph_get_snapdir(struct inode *parent=
)
> >               goto err;
> >       }
> >
> > -     if (!(inode->i_state & I_NEW) && !S_ISDIR(inode->i_mode)) {
> > +     if (!(inode_state_read_once(inode) & I_NEW) && !S_ISDIR(inode->i_=
mode)) {
> >               pr_warn_once_client(cl, "bad snapdir inode type (mode=3D0=
%o)\n",
> >                                   inode->i_mode);
> >               goto err;
> > @@ -215,7 +215,7 @@ struct inode *ceph_get_snapdir(struct inode *parent=
)
> >               }
> >       }
> >  #endif
> > -     if (inode->i_state & I_NEW) {
> > +     if (inode_state_read_once(inode) & I_NEW) {
> >               inode->i_op =3D &ceph_snapdir_iops;
> >               inode->i_fop =3D &ceph_snapdir_fops;
> >               ci->i_snap_caps =3D CEPH_CAP_PIN; /* so we can open */
> > @@ -224,7 +224,7 @@ struct inode *ceph_get_snapdir(struct inode *parent=
)
> >
> >       return inode;
> >  err:
> > -     if ((inode->i_state & I_NEW))
> > +     if ((inode_state_read_once(inode) & I_NEW))
> >               discard_new_inode(inode);
> >       else
> >               iput(inode);
> > @@ -698,7 +698,7 @@ void ceph_evict_inode(struct inode *inode)
> >
> >       netfs_wait_for_outstanding_io(inode);
> >       truncate_inode_pages_final(&inode->i_data);
> > -     if (inode->i_state & I_PINNING_NETFS_WB)
> > +     if (inode_state_read_once(inode) & I_PINNING_NETFS_WB)
> >               ceph_fscache_unuse_cookie(inode, true);
> >       clear_inode(inode);
> >
> > @@ -967,7 +967,7 @@ int ceph_fill_inode(struct inode *inode, struct pag=
e *locked_page,
> >             le64_to_cpu(info->version), ci->i_version);
> >
> >       /* Once I_NEW is cleared, we can't change type or dev numbers */
> > -     if (inode->i_state & I_NEW) {
> > +     if (inode_state_read_once(inode) & I_NEW) {
> >               inode->i_mode =3D mode;
> >       } else {
> >               if (inode_wrong_type(inode, mode)) {
> > @@ -1044,7 +1044,7 @@ int ceph_fill_inode(struct inode *inode, struct p=
age *locked_page,
> >
> >  #ifdef CONFIG_FS_ENCRYPTION
> >       if (iinfo->fscrypt_auth_len &&
> > -         ((inode->i_state & I_NEW) || (ci->fscrypt_auth_len =3D=3D 0))=
) {
> > +         ((inode_state_read_once(inode) & I_NEW) || (ci->fscrypt_auth_=
len =3D=3D 0))) {
> >               kfree(ci->fscrypt_auth);
> >               ci->fscrypt_auth_len =3D iinfo->fscrypt_auth_len;
> >               ci->fscrypt_auth =3D iinfo->fscrypt_auth;
> > @@ -1638,13 +1638,13 @@ int ceph_fill_trace(struct super_block *sb, str=
uct ceph_mds_request *req)
> >                       pr_err_client(cl, "badness %p %llx.%llx\n", in,
> >                                     ceph_vinop(in));
> >                       req->r_target_inode =3D NULL;
> > -                     if (in->i_state & I_NEW)
> > +                     if (inode_state_read_once(in) & I_NEW)
> >                               discard_new_inode(in);
> >                       else
> >                               iput(in);
> >                       goto done;
> >               }
> > -             if (in->i_state & I_NEW)
> > +             if (inode_state_read_once(in) & I_NEW)
> >                       unlock_new_inode(in);
> >       }
> >
> > @@ -1830,11 +1830,11 @@ static int readdir_prepopulate_inodes_only(stru=
ct ceph_mds_request *req,
> >                       pr_err_client(cl, "inode badness on %p got %d\n",=
 in,
> >                                     rc);
> >                       err =3D rc;
> > -                     if (in->i_state & I_NEW) {
> > +                     if (inode_state_read_once(in) & I_NEW) {
> >                               ihold(in);
> >                               discard_new_inode(in);
> >                       }
> > -             } else if (in->i_state & I_NEW) {
> > +             } else if (inode_state_read_once(in) & I_NEW) {
> >                       unlock_new_inode(in);
> >               }
> >
> > @@ -2046,7 +2046,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_requ=
est *req,
> >                       pr_err_client(cl, "badness on %p %llx.%llx\n", in=
,
> >                                     ceph_vinop(in));
> >                       if (d_really_is_negative(dn)) {
> > -                             if (in->i_state & I_NEW) {
> > +                             if (inode_state_read_once(in) & I_NEW) {
> >                                       ihold(in);
> >                                       discard_new_inode(in);
> >                               }
> > @@ -2056,7 +2056,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_requ=
est *req,
> >                       err =3D ret;
> >                       goto next_item;
> >               }
> > -             if (in->i_state & I_NEW)
> > +             if (inode_state_read_once(in) & I_NEW)
> >                       unlock_new_inode(in);
> >
> >               if (d_really_is_negative(dn)) {

