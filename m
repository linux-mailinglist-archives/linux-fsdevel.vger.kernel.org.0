Return-Path: <linux-fsdevel+bounces-62992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88150BA853D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 09:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3F5189C7EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 07:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7399261B67;
	Mon, 29 Sep 2025 07:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKT9fsD9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B50225397
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 07:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759132452; cv=none; b=TPys8hi8zA0f6vI0f8r2ul1KwwVLdsbTac/VmbgCGo/2C+VTU321w8yPobVEzG28sSgoqctptlJeuDkVNwObBzmhQG5SEaJtT8I1kL2Ky0FUKI8H+bOGt8v0fZ8RPLkLrw7B2UlFhVObvZquk/wZL4R9N/x2fUVnmUUlRAUKumA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759132452; c=relaxed/simple;
	bh=ebsM9JHsHQur1Bw6rKad8sA25ASLxYLTU+36bdAO5jE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OAZFS2FFTCm4tbLxBsk+gKydheWmogWWz904q9AwbvGQIY8+tgYvoK8kkN7RKpPkw9OLMkBmxC73aNEenaJ/VyrHovtIjE9E6WZVhfMtL3EZR8lUxQsi/LZ6Mi/HPyK/SF88XyJXpjL4OkhJPVb689vd/IHYl5CFNPPWUAHWNKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKT9fsD9; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62fa0653cd1so6259986a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 00:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759132448; x=1759737248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzPJujqCxIkq3dXzUrFUKzNc7v1QEPOC8O+wS8r4tbY=;
        b=cKT9fsD9+zJ8brzpoqL+8ZRJgtf2bnctc5EpWLzyuvvJOJ7s3kU6dkMmo0iBwHl+UT
         ZeNzi9s5ShnZ/CynKrRxijSBeV+BnQYY8flC0MMy7SEVEk0aE0RM5TWs0oDabUbjGbN6
         oj7hNymzynHcSCvF5G86sxADq+9qD0YiFlItOK2xz/ECjLCyYZFcicwi5EykgK7IZcWJ
         qb6kl8979liqKoeozwfLxtGlIIaxli9/NcMCNLjF6qaOT2G4OkT6JCdQokFboFTacCS5
         1y9P72h56n23PyeroBqwuS8anGJqckC/S4uVeUZAnl1kzOfJq/vojYzuPnsmFlLan1VB
         c5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759132448; x=1759737248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzPJujqCxIkq3dXzUrFUKzNc7v1QEPOC8O+wS8r4tbY=;
        b=pk0NKFdUInQMyqC3ZpnHR5ibaHrec/nfuYtdBpm0j7YC0HkZjiEgLXzdHyjF1HwC/c
         O8+UwlmjIsjhyvQvJXOzbDm1ZvIBfeoPxY+pRLDlUWVak7OzAaR5gLy14rLE9CEV6VJS
         AvJLeuMyWqJBjx6ATK5xxAfRdYBft/jyChOAnknlVTqKXGH+sDLWmWiV4PIEUV5oE8au
         udbCJq3VfCL912b5pLZ1wykspN/ec69WFenNI8CNODzlBNJmDre//o5OvkC5v+wbdjQK
         IdZ4zOzg8RQznAs+IjkhJNYVOGq4klPdjsLBXLRKrtFo0jVefi1ps5+J5PNwXYylBbNQ
         zCEg==
X-Forwarded-Encrypted: i=1; AJvYcCW75XPdlVpKmsO8pTAyqZTu+sXeNa6MbN9dk8sY2gpOqlgOT5Q4NUsAyXKmc4EVK9VnBiJrnxUpxjcJSGDr@vger.kernel.org
X-Gm-Message-State: AOJu0YyPrlIyeev5r9OldafJO3JApxlz1yVxgtTsRWhl5OLc9uQ9nNZl
	cghkmaqtBjwJr0cUa0Awzi0gmesBb/DwbXkaeHXqrtm+73KkDimhDhE8d80ZGguovsNKTQtsaAe
	/5kkuTbOOpnOVYWA8k2r5GIwkws8jpphc0WmAJVU=
X-Gm-Gg: ASbGncvYe4alHbvYRAJgIC4G5NDeKvnzlDHRSD8J6nCbTlLSdBS0pOg1lizyk15kB2W
	8cVpsPDXD1nE62b0EkeEpqRJFuc218fddCHUDaGxSM3LeiGyb05Yn8V1/F3tSSocPxMvmN0xmpq
	5b2XvyCSKQZoF6VnBz1/qvqr0bcJwwnMFb87scltylModTKs12e/94ncy7V6b6obypetfsvItUY
	6cG1dPBY5x5xE/xagND/gBjzPDJGdo3HiB8k7RWIqip7g4wwLh4
X-Google-Smtp-Source: AGHT+IEz/B7eHDFs+XEy5s12wwZ31bVE580nMpoN+RzzLlLXOu4TBNTRNYp5QySBIDKv0FwZvTJZGjv6xwL/yJfTGGs=
X-Received: by 2002:a05:6402:354f:b0:634:ce70:7c5 with SMTP id
 4fb4d7f45d1cf-634ce700abcmr7993255a12.17.1759132448316; Mon, 29 Sep 2025
 00:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926025015.1747294-1-neilb@ownmail.net> <20250926025015.1747294-12-neilb@ownmail.net>
 <CAOQ4uxjkJ4dvOkHHgSJV61ZGdCYOxc8JJ+C0EOZAG49XWKN3Pw@mail.gmail.com> <175912358745.1696783.16384196748395150231@noble.neil.brown.name>
In-Reply-To: <175912358745.1696783.16384196748395150231@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 29 Sep 2025 09:53:57 +0200
X-Gm-Features: AS18NWBF7490Ty4aENvTLaLY98G72pD-_dHuQ-kUmUnroyoPI00RdkDux9yf7uE
Message-ID: <CAOQ4uxiovuo2S_22wkxoFjZr3MtgeiT4=9+e2MYs8xnTypsiWQ@mail.gmail.com>
Subject: Re: [PATCH 11/11] ecryptfs: use new start_creaing/start_removing APIs
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 7:26=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> On Sun, 28 Sep 2025, Amir Goldstein wrote:
> > On Fri, Sep 26, 2025 at 4:51=E2=80=AFAM NeilBrown <neilb@ownmail.net> w=
rote:
> > >
> > > From: NeilBrown <neil@brown.name>
> > >
> > > This requires the addition of start_creating_dentry().
> > >
> ...
> > > @@ -186,10 +190,12 @@ ecryptfs_do_create(struct inode *directory_inod=
e,
> > >         struct inode *lower_dir;
> > >         struct inode *inode;
> > >
> > > -       rc =3D lock_parent(ecryptfs_dentry, &lower_dentry, &lower_dir=
);
> > > -       if (!rc)
> > > -               rc =3D vfs_create(&nop_mnt_idmap, lower_dir,
> > > -                               lower_dentry, mode, true);
> > > +       lower_dentry =3D ecryptfs_start_creating_dentry(ecryptfs_dent=
ry);
> > > +       if (IS_ERR(lower_dentry))
> > > +               return ERR_CAST(lower_dentry);
> > > +       lower_dir =3D lower_dentry->d_parent->d_inode;
> > > +       rc =3D vfs_create(&nop_mnt_idmap, lower_dir,
> > > +                       lower_dentry, mode, true);
> > >         if (rc) {
> > >                 printk(KERN_ERR "%s: Failure to create dentry in lowe=
r fs; "
> > >                        "rc =3D [%d]\n", __func__, rc);
> > > @@ -205,7 +211,7 @@ ecryptfs_do_create(struct inode *directory_inode,
> > >         fsstack_copy_attr_times(directory_inode, lower_dir);
> > >         fsstack_copy_inode_size(directory_inode, lower_dir);
> > >  out_lock:
> > > -       inode_unlock(lower_dir);
> > > +       end_creating(lower_dentry, NULL);
> >
> > These calls were surprising to me.
> > I did not recall any documentation that @parent could be NULL
> > when calling end_creating(). In fact, the documentation specifically
> > says that it should be the parent used for start_creating().
>
> I've updated the documentation for end_creating() say that the parent is
> not needed when vfs_mkdir() wasn't used.
>

This was not what I was aiming for at all.
This is exactly the bad interface that end_dirop_mkdir() was.
A well designed scope interface like strart_XXX/end_XXX should not depend
on what happened between the
start_XXX to end_XXX.
If start_XXX succeeds you MUST call end_XXX
end of story, no ifs and buts and conditional arguments only
if mkdir was called. This is bad IMO.



> >
> > So either introduce end_creating_dentry(), which makes it clear
> > that it does not take an ERR_PTR child,
>
> it would be end_creating_not_mkdir() :-)
>

OK, but that is not the emphasis.
The emphasis is that dentry is not PTR_ERR,
because in all the callers where you pass NULL parent
the error case is checked beforehand.

static inline void end_creating_dentry(struct dentry *child)
{
        if (!(WARN_ON(IS_ERR(child))
                end_dirop(child);
}

If someone uses end_creating_dentry() after failed mkdir
the assertion would trigger.

> > Or add WARN_ON to end_creating() in case it is called with NULL
> > parent and an ERR_PTR child to avoid dereferencing parent->d_inode
> > in that case.
>
> I don't think a WARN_ON is particularly useful immediately before a
> NULL-pointer dereference.

Of course I did not mean WARN_ON and contoinue to dereference NULL
that's never the correct use of WARN_ON.

static inline void end_creating(struct dentry *child, struct dentry *parent=
)
{
        if (!IS_ERR(child)) {
                end_dirop(child);
        } else if (!WARN_ON(!parent)) {
                /* The parent is still locked despite the error from
                 * vfs_mkdir() - must unlock it.
                 */
               inode_unlock(parent->d_inode);
        }
}

static inline void end_creating_dentry(struct dentry *child)
{
        end_creating(child, NULL);
}

To me, this:

       end_creating_dentry(lower_dentry);

Is more clear than this:

       end_creating(lower_dentry, NULL);

But my main concern was about adding the assertion
and documenting that @parent may be NULL as long as
it can be deduced from @child->d_parent (right?).

Thanks,
Amir.

