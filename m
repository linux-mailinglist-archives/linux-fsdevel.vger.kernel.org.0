Return-Path: <linux-fsdevel+bounces-55588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B21AB0C306
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 13:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5516A17C153
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 11:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C89429C34E;
	Mon, 21 Jul 2025 11:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKVg60L/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57881F3FF4;
	Mon, 21 Jul 2025 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097553; cv=none; b=fauozgtAo4CP/PpU9J7KJJMMHrMjtqfAShcswiuXftBZHCVwjShg2vWrN2p54mwjM8hf+vixWAmIigrs88GaMXwLmtNuTHu52tCTxmMkHWYom4ZwwG7JZl7i87xD3pXr/k8/eHpTUOzWjmA7diCEULNst7DsNLPOCVc1CeoHUco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097553; c=relaxed/simple;
	bh=aA/YqRt7CmmCWQ6vRvHCvWdziyzMFBmteaDcud523hY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8SpoKHjhtc5pEJ6ljKCB/55iXmlzLKUj1YtlRBXC6WFCkN6H0B1at73QGC+NQEU4MDXHh4qw5UeYWeXRT1Cp5yeDENfuDAxMmyy+4S/MZgE2oYbry9/nz7iMbxAQIFQyXsG2VvDaA9GVqJ72vLw7WiZX809AAGUSOXKu1wZP1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKVg60L/; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so7136670a12.2;
        Mon, 21 Jul 2025 04:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753097550; x=1753702350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwUDU4lmCOpK0+9XYbO31vbMhb7j4XJSWdchYqlYZmI=;
        b=eKVg60L/cjwCm5Kge08yW2MK5n/SMNvO2cRddlyJdngnmqhRBFsRkI+sRo1+uHXvAH
         G0gxI9sAjZSFmQS0BynZC3GrTseLGtx7GFl1SjFMoxnhQTnHS3SLk4YTIEV0GhVFLhPg
         bFh4Lul5hSjkwNbwkxkFWltfudJOMogrv6x5u69qafWU4zpTDf3IxK8RT6nrVG5ha/Kx
         vseDDoyeAl8vQKc3C8AQLNKWW/ToUlcDxSAb2d51sfshOR+dd974e9gaMVXQdWXnSz1t
         mPfmtCf2869DdVP/Mok05QCCsgC+AEa21fs3Zl/1H3nLsEJgBB2uOAfwtd81HLzYTGQG
         vTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753097550; x=1753702350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwUDU4lmCOpK0+9XYbO31vbMhb7j4XJSWdchYqlYZmI=;
        b=hp8+HjOn+hMj+QIwSvwHtSpF6QxNxG5l/z2/H6Uy4ombZHYpPkjITEvcYuXxq1ZLED
         wUQGQs/QGDqqecsXr0JaB3zxjaY+4BXDDJT5qCA7Rw/yTDzSWh63yqh6iTV7SjAgGD2M
         oJlZyExV42vSmP6OS2a9eJlSGexzK7IAOvZXdlV4mRjaHyF9EXui7mQKV9V1TB5UgNAJ
         utjRYZZZRPnB40h0WiLBe9uHQoglTyoaWHZVE0pYgXC2pUPCfYZQyu7OwyrDDxCi5llV
         z7Oj94LmgLrk4+fRU+McPq22qczB0h65etd8PxPk5ENpFQ4eFr+MquUK7k2xD5PRvgux
         1Zmg==
X-Forwarded-Encrypted: i=1; AJvYcCV/EgaYujm8qHEHsWeCAbRhnldzFWccKTatZVOC6o8FCxI4pxVMaekeaxm0QvT4eM/2JaAeWtF85rxfSHaI@vger.kernel.org, AJvYcCXgEPAmKNbfjS1aw/h5yC5DYOzp77POirCd+5KkFBqJGVTelL9sgQwEaW2HSy4LLO/Oe3rysBsAGMDXU56Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3kQ3jUXsHWizDiwI11vzEsgzEE2iTcrjF6rAWoUbprG985ier
	HQQDYtTVPHZthoVrjeuB/IpBjQZPRkTioLprm+i4sFtNe/mSHhd7HpKBE2b6f5qA6RUpjCSt36m
	6MjWtejtSzy+79hXopPR94euEwcdIXyc=
X-Gm-Gg: ASbGncs0FF/wG570IeG9YEjqcXJ/Ria7mzWvXzTdmeIcVtJZEsfyQaZWmzqvHZn2vh8
	FeDZrI7IAgXDMlW4+AMpnxMWoAzVPiFVFgorZI78LUybs7VEVSwC3lhlUXkfcugK5glihePVzcl
	Dg5Fe0EjPvlMIGS/S5I0eofF3dNL6h+58g5ne9zIVWOYGuT+BGdiGa4r4v2goTtFb90SdIzcDbn
	d2OHSA=
X-Google-Smtp-Source: AGHT+IE33274m6nFzexUcM2b37p1gkHuJonl9XTDjkeKSVwNqGGYOxWFdSaJCM6W2WvLdgTehLz3ma0DOg4fhg954Bg=
X-Received: by 2002:a17:907:720d:b0:ae3:c767:da11 with SMTP id
 a640c23a62f3a-ae9ce17e845mr1956850566b.50.1753097549429; Mon, 21 Jul 2025
 04:32:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721084412.370258-1-neil@brown.name>
In-Reply-To: <20250721084412.370258-1-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 21 Jul 2025 13:32:18 +0200
X-Gm-Features: Ac12FXz3otnB5gz_Kv72kjBR8yLh9f6disHvREkVRonsRjabvkdlSDxFuIziJCw
Message-ID: <CAOQ4uxgd=POQATEhPdwqyX-hCQAHCTcxJsvyOS6=2yojMh399Q@mail.gmail.com>
Subject: Re: [PATCH 0/7 RFC] New APIs for name lookup and lock for directory operations
To: NeilBrown <neil@brown.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 10:46=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> Hi,
>
>  these patches (against vfs.all) primarily introduce new APIs for
>  preparing dentries for create, remove, rename.  The goal is to
>  centralise knowledge of how we do locking (currently by locking the
>  directory) so that we can eventually change the mechanism (e.g.  to
>  locking just the dentry).
>
>  Naming is difficult and I've changed my mind several times. :-)

Indeed it is.
I generally like the done_ approach that you took.
Few minor naming comments follow.

>
>  The basic approach is to return a dentry which can be passed to
>  vfs_create(), vfs_unlink() etc, and subsequently to release that
>  dentry.  The closest analogue to this in the VFS is kern_path_create()
>  which is paired with done_path_create(), though there is also
>  kern_path_locked() which is paired with explicit inode_unlock() and
>  dput().  So my current approach uses "done_" for finishing up.
>
>  I have:
>    dentry_lookup() dentry_lookup_noperm() dentry_lookup_hashed()

As I wrote on the patch that introduces them I find dentry_lookup_hashed()
confusing because the dentry is not hashed (only the hash is calculated).

Looking at another precedent of _noperm() vfs API we have:

vfs_setxattr()
  __vfs_setxattr_locked()
    __vfs_setxattr_noperm()
      __vfs_setxattr()

Do I'd say for lack of better naming __dentry_lookup() could makes sense
for the bare lock&dget and it could also be introduced earlier along with
introducing done_dentry_lookup()

>    dentry_lookup_killable()
>  paired with
>    done_dentry_lookup()
>
>  and also
>    rename_lookup() rename_lookup_noperm() rename_lookup_hashed()
>  paired with
>    done_rename_lookup()
>  (these take a "struct renamedata *" to which some qstrs are added.
>
>  There is also "dentry_lock_in()" which is used instead of
>  dentry_lookup() when you already have the dentry and want to lock it.
>  So you "lock" it "in" a given parent.  I'm not very proud of this name,
>  but I don't want to use "dentry_lock" as I want to save that for
>  low-level locking primitives.

Very strange name :)

What's wrong with dentry_lock_parent()?

Although I think that using the verb _lock_ for locking and dget is
actively confusing, so something along the lines of
resume_dentry_lookup()/dentry_lookup_reacquire() might serve the
readers of the code better.

>
>  There is also done_dentry_lookup_return() which doesn't dput() the
>  dentry but returns it instread.  In about 1/6 of places where I need
>  done_dentry_lookup() the code makes use of the dentry afterwards.  Only
>  in half the places where done_dentry_lookup_return() is used is the
>  returned value immediately returned by the calling function.  I could
>  do a dget() before done_dentry_lookup(), but that looks awkward and I
>  think having the _return version is justified.  I'm happy to hear other
>  opinions.

The name is not very descriptive IMO, but I do not have a better suggestion=
.
Unless you can describe it for the purpose that it is used for, e.g.
yeild_dentry_lookup() that can be followed with resume_dentry_lookup(),
but I do not know if those are your intentions for the return API.

Thanks,
Amir.

>
>  In order for this dentry-focussed API to work we need to have the
>  dentry to unlock.  vfs_rmdir() currently consumes the dentry on
>  failure, so we don't have it unless we clumsily keep a copy.  So an
>  early patch changes vfs_rmdir() to both consume the dentry and drop the
>  lock on failure.
>
>  After these new APIs are refined, agreed, and applied I will have a
>  collection of patches to roll them out throughout the kernel.  Then we
>  can start/continue discussing a new approach to locking which allows
>  directory operations to proceed in parallel.
>
>  If you want a sneak peek at some of this future work - for context
>  mostly - my current devel code is at https://github.com/neilbrown/linux.=
git
>  in a branch "pdirops".  Be warned that a lot of the later code is under
>  development, is known to be wrong, and doesn't even compile.  Not today
>  anyway.  The rolling out of the new APIs is fairly mature though.
>
>  Please review and suggest better names, or tell me that my choices are a=
dequate.
>  And find the bugs in the code too :-)
>
>  I haven't cc:ed the maintains of the non-VFS code that the patches
>  touch.  I can do that once the approach and names have been approved.
>
> Thanks,
> NeilBrown
>
>
>  [PATCH 1/7] VFS: unify old_mnt_idmap and new_mnt_idmap in renamedata
>  [PATCH 2/7] VFS: introduce done_dentry_lookup()
>  [PATCH 3/7] VFS: Change vfs_mkdir() to unlock on failure.
>  [PATCH 4/7] VFS: introduce dentry_lookup() and friends
>  [PATCH 5/7] VFS: add dentry_lookup_killable()
>  [PATCH 6/7] VFS: add rename_lookup()
>  [PATCH 7/7] VFS: introduce dentry_lock_in()
>

