Return-Path: <linux-fsdevel+bounces-63272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7AEBB3A0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 12:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB832189B0F0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 10:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BADC3090EC;
	Thu,  2 Oct 2025 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6sAqdB2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC75C272E7B
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 10:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759400770; cv=none; b=VZJ8Cp/uHuEuIpYYZ6TxBrb6CKr9Jpp3CJc14Bzyq6YHX879nzigOyYuKoIGj3vQOzV+gYy5y85bPwv5HkbA7TJu6V/n6pIcqXRkbkeRUmR654Kw4dwBQs6z7YxTCfwyfsunxAW4ZJ6gLSRLDuLDM1yjCSWvSC/uHuCjFc/XLXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759400770; c=relaxed/simple;
	bh=hyVEKFx2QwM47Z7Pw6oFuJzKwOF4VUka+urG6eNB0NY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dow2TK4/6eeg5TeNSE+doPZpG2N5cDhSFL3t9mh7YmH0V6HWQGFR+ip3/qdedovlhVN7eE0Mxo3jpLLcYouV2oiFP32+KUzzTpATb8ud+5IXuksdAcFqnl7jAv9tnbZQ1hgggWXB1ns4Jt2QD2JzYWAnMUeQ/SIFXUFY0/4sOUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6sAqdB2; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62fc89cd68bso1490972a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Oct 2025 03:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759400767; x=1760005567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38VSt3IfWS01J8fNqZai26TFABdGS1Mxx3nUm7CbvyY=;
        b=S6sAqdB2NXs7itD82Cfl+13oMwWQ7L42lgFdhn8v9mb2xEDdH/RKffPdJZfempqhd1
         8eeTFTVAXo6HvWQrbXoPDRFKm0NYNwX/LBhXlnDPIY/zBpPOVDRNWIvbdllJoyO4BEEU
         Ktj3q8gjRCROtBIy5xWiEtES3JqhbiMnGx73JxBy8BygknrhMB8LdrKgyszny0jyaTr0
         ddVzOpusCCDqKbw8UqI+Jj7aSBsBV+2xunq1LJeRLgb0usCy89ALgZ5O2/T0LoEVVdxJ
         q1S3MsWPVQ5wgA3QF5NCedMfLiLbhicqQ1jAA/Wl9FB8QVBYpt2qsezGOxNpgU86j0L4
         QoRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759400767; x=1760005567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38VSt3IfWS01J8fNqZai26TFABdGS1Mxx3nUm7CbvyY=;
        b=ArSbAtcZVpyllXRzSvhKHswOgRQ17erhTSo01fi3k0YKj6lqf5mV6sLt/dbalHblPI
         1dsWM5J1d39C29RXpiurvkQ46oIDnh3YvC8NtCxN3P7yxwAk/yWvk0fyE2P9Fn0U1Jc7
         PLi8IT+5fumnQlZX47Cfi0lFhvaS9V5/ZG9m0G+TNI8NeMc1Y5SYHKOMob6etTF6KE1y
         MRfTSeSYexwzBncmUEPox6kdeWrnwCJIH6dsOd8wMjsYI7HXj1gomap9yLoGbSYXXlGO
         B4eeyxSgqkfJ2510bRL63pHHuFOkg/FI2Ik4muEVx6Is6z7SQF7fh736KzdkL8O04B8J
         IEaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF7IXlHWNnwDZFVUU8WVCwUSDCD4T8iJd6IGU3KlbpHHeaFFMpjBKBP2mul7Wi9y+CYFsoNFHkBXElshSA@vger.kernel.org
X-Gm-Message-State: AOJu0YxEeb1MI/GvXL65RWE4hhsAMmYMeg+GBElEBgLrgr+r7uHYLh07
	nVbUxMzh6DHAMo7F/WXGAa0iyiHt/uk/nvUEWl/DJPx81s1uDAxKSaBaoxu/o2rPth/bMXm6knp
	Vz75CXGMo4EyNKyioHEJedxITmcxGiYk=
X-Gm-Gg: ASbGncvRWvuOu4Sgm4QB/66M/CXH9aZ7XysArS1vw55x0GdjhkwmkeH9ysBSXpUpuPx
	hlxkyx3Y20Vx8ZUa0//F9Sh7UpMnpKQExwQEfUZ7udFJkcHb2iyjZVSfWdui2aTnChVvLJFM2a3
	ooC2xlqf5Y7Vggd3LL5YRroSg/ZTrZc+A8NPbnNVtziMZpBS8C9syZTlAda04qmISYrZLQuAhNw
	a747rl5ArsCYo6Y5e0TT4yHs5ftDTqmU/7XZBwzf4sGlePh50NoXRs9YtKQXOmjew==
X-Google-Smtp-Source: AGHT+IGPSFWHi0QdD1vvpy/GH9bCFSQPL/YjYInLa9FsLQ1zrVEUC63AnEU8nTvONx+nfasOzaGo139y/IleyuZkjuU=
X-Received: by 2002:a05:6402:34cc:b0:62f:bd39:cd04 with SMTP id
 4fb4d7f45d1cf-63678ca64b0mr7107562a12.21.1759400766839; Thu, 02 Oct 2025
 03:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926025015.1747294-1-neilb@ownmail.net> <20250926025015.1747294-12-neilb@ownmail.net>
 <CAOQ4uxjkJ4dvOkHHgSJV61ZGdCYOxc8JJ+C0EOZAG49XWKN3Pw@mail.gmail.com>
 <175912358745.1696783.16384196748395150231@noble.neil.brown.name>
 <CAOQ4uxiovuo2S_22wkxoFjZr3MtgeiT4=9+e2MYs8xnTypsiWQ@mail.gmail.com> <175928227148.1696783.14650052455220025233@noble.neil.brown.name>
In-Reply-To: <175928227148.1696783.14650052455220025233@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 2 Oct 2025 12:25:55 +0200
X-Gm-Features: AS18NWDK-l47untVerR4Be_bohVk6_ZxJu7PRRSH8dtIAQu-NBhAN5O2caykVFc
Message-ID: <CAOQ4uxirL8ydn=LUwO1FR8a+9Uzpn3=JW_jUpj9APDgEg+0xDg@mail.gmail.com>
Subject: Re: [PATCH 11/11] ecryptfs: use new start_creaing/start_removing APIs
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 3:31=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
>
> On Mon, 29 Sep 2025, Amir Goldstein wrote:
> > On Mon, Sep 29, 2025 at 7:26=E2=80=AFAM NeilBrown <neilb@ownmail.net> w=
rote:
> > >
> > > On Sun, 28 Sep 2025, Amir Goldstein wrote:
> > > > On Fri, Sep 26, 2025 at 4:51=E2=80=AFAM NeilBrown <neilb@ownmail.ne=
t> wrote:
> > > > >
> > > > > From: NeilBrown <neil@brown.name>
> > > > >
> > > > > This requires the addition of start_creating_dentry().
> > > > >
> > > ...
> > > > > @@ -186,10 +190,12 @@ ecryptfs_do_create(struct inode *directory_=
inode,
> > > > >         struct inode *lower_dir;
> > > > >         struct inode *inode;
> > > > >
> > > > > -       rc =3D lock_parent(ecryptfs_dentry, &lower_dentry, &lower=
_dir);
> > > > > -       if (!rc)
> > > > > -               rc =3D vfs_create(&nop_mnt_idmap, lower_dir,
> > > > > -                               lower_dentry, mode, true);
> > > > > +       lower_dentry =3D ecryptfs_start_creating_dentry(ecryptfs_=
dentry);
> > > > > +       if (IS_ERR(lower_dentry))
> > > > > +               return ERR_CAST(lower_dentry);
> > > > > +       lower_dir =3D lower_dentry->d_parent->d_inode;
> > > > > +       rc =3D vfs_create(&nop_mnt_idmap, lower_dir,
> > > > > +                       lower_dentry, mode, true);
> > > > >         if (rc) {
> > > > >                 printk(KERN_ERR "%s: Failure to create dentry in =
lower fs; "
> > > > >                        "rc =3D [%d]\n", __func__, rc);
> > > > > @@ -205,7 +211,7 @@ ecryptfs_do_create(struct inode *directory_in=
ode,
> > > > >         fsstack_copy_attr_times(directory_inode, lower_dir);
> > > > >         fsstack_copy_inode_size(directory_inode, lower_dir);
> > > > >  out_lock:
> > > > > -       inode_unlock(lower_dir);
> > > > > +       end_creating(lower_dentry, NULL);
> > > >
> > > > These calls were surprising to me.
> > > > I did not recall any documentation that @parent could be NULL
> > > > when calling end_creating(). In fact, the documentation specificall=
y
> > > > says that it should be the parent used for start_creating().
> > >
> > > I've updated the documentation for end_creating() say that the parent=
 is
> > > not needed when vfs_mkdir() wasn't used.
> > >
> >
> > This was not what I was aiming for at all.
> > This is exactly the bad interface that end_dirop_mkdir() was.
>
> There is a reason for that.  vfs_mkdir() has a bad interface and somehow
> we need to accommodate it.  Once we fix vfs_mkdir() the second arg to
> end_creating() goes away.  Until then we need it, but don't always use
> it.
>

ok, as I don't have a suggestion for an easier way to form this series,
if others don't mind this scafolding that goes away at the end,
I won't stand in your way.

>
> > A well designed scope interface like strart_XXX/end_XXX should not depe=
nd
> > on what happened between the
> > start_XXX to end_XXX.
> > If start_XXX succeeds you MUST call end_XXX
>
> And that is what we do.
>
> > end of story, no ifs and buts and conditional arguments only
> > if mkdir was called. This is bad IMO.
>
> The practical reality is that the second argument is ignored if
> vfs_mkdir() wasn't used.  This isn't a function of the design of
> end_creating(), it is a function of the design of vfs_mkdir().
>

Yeh that's one hell of a weird interface, but I can live with that
if it goes away at the end of this series, not in some future time.

> >
> >
> >
> > > >
> > > > So either introduce end_creating_dentry(), which makes it clear
> > > > that it does not take an ERR_PTR child,
> > >
> > > it would be end_creating_not_mkdir() :-)
> > >
> >
> > OK, but that is not the emphasis.
> > The emphasis is that dentry is not PTR_ERR,
> > because in all the callers where you pass NULL parent
> > the error case is checked beforehand.
>
> No, it all other cases there is there cannot be an error.  Only
> vfs_mkdir() returns a dentry that might be IS_ERR(), and consume the
> dentry that was passed in.  All other vfs_foo() return an integer error
> and don't consume the dentry.
>
> "vfs_mkdir() was used" and "dentry migth be IS_ERR()" are logically
> equivalent statements.
>
> >
> > static inline void end_creating_dentry(struct dentry *child)
> > {
> >         if (!(WARN_ON(IS_ERR(child))
> >                 end_dirop(child);
> > }
> >
> > If someone uses end_creating_dentry() after failed mkdir
> > the assertion would trigger.
>
> But you NEED end_creating() after a failed vfs_mkdir().  You still need
> to unlock the parent.
>
> "end_creating_dentry()" look like it is a pair to
> "start_creating_dentry()" but the two are quite unrelated.
>
>
> >
> > > > Or add WARN_ON to end_creating() in case it is called with NULL
> > > > parent and an ERR_PTR child to avoid dereferencing parent->d_inode
> > > > in that case.
> > >
> > > I don't think a WARN_ON is particularly useful immediately before a
> > > NULL-pointer dereference.
> >
> > Of course I did not mean WARN_ON and contoinue to dereference NULL
> > that's never the correct use of WARN_ON.
> >
> > static inline void end_creating(struct dentry *child, struct dentry *pa=
rent)
> > {
> >         if (!IS_ERR(child)) {
> >                 end_dirop(child);
> >         } else if (!WARN_ON(!parent)) {
> >                 /* The parent is still locked despite the error from
> >                  * vfs_mkdir() - must unlock it.
> >                  */
> >                inode_unlock(parent->d_inode);
> >         }
> > }
> >
> > static inline void end_creating_dentry(struct dentry *child)
> > {
> >         end_creating(child, NULL);
> > }
> >
> > To me, this:
> >
> >        end_creating_dentry(lower_dentry);
> >
> > Is more clear than this:
> >
> >        end_creating(lower_dentry, NULL);
> >
> > But my main concern was about adding the assertion
> > and documenting that @parent may be NULL as long as
> > it can be deduced from @child->d_parent (right?).
>
> If it really bothers you to pass NULL I'll change it to pass the actual
> parent.
>    end_creating(lower_dentry, lower_dentry->d_parent);
>
> Would you find that less bothersome?

No, that's not needed.
If parent arg goes away at the end of the series, NULL is fine
and I don't need elaborate documentation for something that
does not exist at the end of the series.

Feel free to add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>


Thanks,
Amir.

