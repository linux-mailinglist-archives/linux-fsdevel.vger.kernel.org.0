Return-Path: <linux-fsdevel+bounces-60447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E80B46AD0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 12:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5460518902DD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 10:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D762E92D2;
	Sat,  6 Sep 2025 10:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7/z+PFE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A32279354
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 10:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757154938; cv=none; b=OxDMU2sYuk1R+0u+7SebK7nAyCkn1FFRHXjlR6t72+jAvAdl8lPJQHaa+no/v5xiBJV3u63N33iyumxzFMbsQFQjg8WmVPUXDobdDjKSmxxmfvfQqud1Z1EMMgiwywi7+kKaY2GmjZP08bS47i0T7YnNjkrWCxy5B+kMP6tTuGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757154938; c=relaxed/simple;
	bh=CgiO6DLQAY8bfR//WOKrd9qgXRcNY5/suSvGbikggkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luuvqNa60NZvtVQdDYzEKDJnQWSGxJYqkVKTlc5SPI9TNN/eApK7DgZOgDsmLeT82Z9JUmTLmgoRQZH5i6E4i7ckfvab+LFPf0LueoqI5GKZCkypA8FR+rd3nsRn6+J7GegpglW1jrMrOR1gw0yazxhV8qzZO2aOwnexJWzj6U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7/z+PFE; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-622b4b14a75so1850000a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Sep 2025 03:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757154935; x=1757759735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3gmyLWzI4hwQq3BDtqyfFdQP/rWfZ/BOhAK9IOLjIs=;
        b=c7/z+PFEiOc4oMMlSolpS9cooXybyyXGX4YFeaCrJCPLhTglKBwpg9gtM9dInUM62U
         5V0jP/xq3LKS1NKnUe8PdJ4CsR36UZrsTLaJ/Y5QgV/Md5rq5qBzs9omO5iwAJCEBDua
         0xanl6CIZAtw+5Amf+ATpZoPc0v3n32ditoqtfX63h8BzytkEn12/21T+iLg8+eOly2o
         Eq9NM5wSXHaT5ZNRmH0OdMJEjLblwSiRBMCDbar7WAWgHfrF0yiLUeMx7epKkk/JEgyQ
         FFO/tSL2AL8DQcN/ZmkDAK8jMattoRZQg7jNh+gcmg4H2JZjrM+QrRjFb5sOoFdWqS82
         i5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757154935; x=1757759735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3gmyLWzI4hwQq3BDtqyfFdQP/rWfZ/BOhAK9IOLjIs=;
        b=HEWwD4gwTPPNdIJXuYzHuqd43Ly1EMxbyscin2jbNamnV/a1R3SMpll6OBLPkHa5ZO
         /AQYKbIWQarm1hOFl5KzgVaNAqNDD1JRYl4IMHqIcgIiKW9xrBeP9T61g9A2mrR0dgJf
         8rmAwO++lQaIFHIPv2194J3rYrqwLYd7Iocn29ibh+9EU3wOimRGK5ztS5XkeTzIDDWL
         yx87jwGdzwQWODU+dgzFUgamv3M85XlNau6ok/4Yzeo/PiY2Wl4uUXC3o8g8DY0NydTi
         h+c4adncwe5QAUURlvrJaxIuY0+CwVoGfl3nqA/8g+BALxTFPe/WHHOvLk4D9VXO7A3G
         mqoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwPsbvZz3rUDqPlUflWkWUD0ypV2rL3X/ezkUIlO+oomHp1hNFiba/7v+EMYf4sCfczLIix6l72Des+1Yq@vger.kernel.org
X-Gm-Message-State: AOJu0YwoLtcVGmrQhl5JV3Y3UIWgb9jV53zVcS2kxJQYuvb2VmUGl5jD
	fMFLACB1VqAt+3TQ0K9RvIs1+QL6BxBYez/kEBPZKEIsOCme0a23hg9SVg2KYOmqucGOGLR5H9J
	xEWTfJlXipx3IbYLXNgCXOvE2YEIXyxe0XbAHVJM=
X-Gm-Gg: ASbGnct/jWWWoHHsL4YLm0mPPCTW/7ojKGTXd9ttQ2nwvf3O4xHxCr2lJC3k1AZBS4m
	siHJzw/LJ7OIUC1QbPzhn5BIoJ5f1Ps1ufkW9Z22TWVfGLJ+ggFTzDcVXsIPvG7aB7XjfiFvQVN
	6U3kgGLXK46jNcgEXQ6PmjWglAAwXPx/gvdGblwp6XYyqdKsslP/cPw6NgieL/iD9ohfIbdAqTg
	k0/B5c=
X-Google-Smtp-Source: AGHT+IHdrcg9IdEgZbAljO4hQjEGI8Xy6xQB2/1DJpsiyeXLfoRgGXgC5IfC8SWAUnem8R/q+ZrccoGu2Zd7+hGCJlk=
X-Received: by 2002:a05:6402:2746:b0:620:bf3a:f6d7 with SMTP id
 4fb4d7f45d1cf-6237b0ac3a4mr1749587a12.2.1757154935055; Sat, 06 Sep 2025
 03:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxj_JAT6ctwGkw-jVm0_9GDmzcAhL4yVFpxm=1mZ0oWceQ@mail.gmail.com>
 <175715099454.2850467.15900619784045413971@noble.neil.brown.name>
In-Reply-To: <175715099454.2850467.15900619784045413971@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 6 Sep 2025 12:35:24 +0200
X-Gm-Features: Ac12FXyhlGz_boMC6uC2gQoCE1kyjHCdZAqxfyqT1lSdpKWv8WrmWzwWETN8_aw
Message-ID: <CAOQ4uxh87yzcWkXVCEA0tW7xMhhgfWzno6FCtgvLOEZMqov43A@mail.gmail.com>
Subject: Re: [PATCH 6/6] VFS: rename kern_path_locked() to kern_path_removing()
To: NeilBrown <neilb@ownmail.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 6, 2025 at 11:30=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> On Sat, 06 Sep 2025, Amir Goldstein wrote:
> > On Sat, Sep 6, 2025 at 7:01=E2=80=AFAM NeilBrown <neilb@ownmail.net> wr=
ote:
> > >
> > > From: NeilBrown <neil@brown.name>
> > >
> > > Also rename user_path_locked_at() to user_path_removing_at()
> > >
> > > Add done_path_removing() to clean up after these calls.
> > >
> > > The only credible need for a locked positive dentry is to remove it, =
so
> > > make that explicit in the name.
> >
> > That's a pretty bold statement...
>
> True - but it appears to be the case.
>
> >
> > I generally like the done_ abstraction that could be also used as a gua=
rd
> > cleanup helper.
> >
> > The problem I have with this is that {kern,done}_path_removing rhymes w=
ith
> > {kern,done}_path_create, while in fact they are very different.
>
> As far as I can see the only difference is that one prepares to remove
> an object and the other prepares to create an object - as reflected in
> the names.
>
> What other difference do you see?
>

void done_path_create(struct path *path, struct dentry *dentry)
{
        if (!IS_ERR(dentry))
                dput(dentry);
        inode_unlock(path->dentry->d_inode);
        mnt_drop_write(path->mnt);
        path_put(path);
}

void done_path_removing(struct dentry *dentry, struct path *path)
{
       if (!IS_ERR(dentry)) {
               inode_unlock(path->dentry->d_inode);
               dput(dentry);
               path_put(path);
       }
}

They look pretty different and the difference does not look like
it is related to differences between creation and removal.

For example, I do not see mnt_want_write() in handle_remove()
so I wonder why that is.

IOW, maybe xxx_path_removing() is like xxx_path_create()
but it does not act this way.

If you could use xxx_path_removing() in do_unlink() do_rmdir()
it would certainly prove your point, but as it is, I don't think you can.

> >
> > What is the motivation for the function rename (you did not specify it)=
?
> > Is it just because done_path_locked() sounds weird or something else?
>
> Making the name more specific discourages misuse.  It also highlights
> the similarity to kern_path_create (which obviously works because you
> noticed it).
>
> This also prepares readers for when they see my next series which adds
> start_creating and start_removing (with _noperm and _killable options
> and end_foo()) so that they will think "oh, this fits an established
> pattern - good".
>
> Note that I chose "end_" for symmetry with end_creating() in debugfs and
> tracefs_end_creating() which already exist.
> Maybe they should be changed to "done_" but I'm not so keen on done_ as
> if there was an error then it wasn't "done".  And end_ matches start_
> better than done_.  They mark the start and end of a code fragment which
> tries to create or remove (or rename - I have a selection of
> start_renaming options too).
> (simple_start_creating() was introduced a few months ago and I'm basing
>  some of my naming choices on that).
>
> Maybe kern_path_create() should be renamed to start_path_creating().
> We don't really need the "kern" - that is the default.
>
>

That makes sense.

> >
> > I wonder if using guard semantics could be the better choice if
> > looking to clarify the code.
>
> Al suggested in reply to a previous patch that RAII (aka guard etc)
> should be added separately so it can be reviewed separately.
>

Makes sense.

Thanks,
Amir.

