Return-Path: <linux-fsdevel+bounces-31824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B89D99BA6D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2024 18:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D9281C20A45
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2024 16:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A1D140E4D;
	Sun, 13 Oct 2024 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsF2VTZe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AE484A31
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Oct 2024 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728837272; cv=none; b=uPeit3GpHUksrDkq9aNK+fjFFuIcmGNxA/Qu5x3KpSohs5QUjYTgrjvHzHVU+0dRSDQJWjbYaJXpt6utfg2OdlhqvLbEZ4Q0BzFQbFrLrprwUXv0vviOEVavPFD4o2Nd9IrW/Jv9Aj4VcehUdLtXdapAych4jv/YgDkpqMaUeaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728837272; c=relaxed/simple;
	bh=vbvfZf9xgh5VVwnBmnQOnf8MO7H3FRkw8+gL6FF6+9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jCmyOi/8CoXSJpLfinOMvO3yx13ZA+DjIj6TJRe+7mN1RMsNSVsrvedjDRLpkOWuZ64g92IM7ya+QFLzkHMltwrRzLYTE/vtGjGWJSiF+V9TpRBa5fVOXdK4kmotY9nKpD75xNCsUSNhUlLupQx83wmDedcCVO1clUSlk4qwWOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsF2VTZe; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b115d0d7f8so251676585a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Oct 2024 09:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728837270; x=1729442070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDxK2Ea8zAsHXGUMGPJRnDEQKb2vLC8XXm9F8phQfXk=;
        b=UsF2VTZe16CkRcJxCzmR4iCMCyZhD7a3nWTGc2ugsLdShKwKs/Afmih5p6rEtSAhc3
         6R2avlpB+74OjP67nS6b+N8d5ZnjfU7xs9MvZtOXN5w6+G2m9Bp72M4gzoH81WyV+i+E
         /Q6cfchmqbf0M5k4krfrrWiGe4348hNKW2RvOGtsVau+Vp5ZHQVS1CXHgFuTLN6wVfU/
         /EoxAvlQcXPdReWkkDbicQNOVgzwkdEcR3VZPfi7ReSsevihcdNL/hbN9pBY7zlX9VOL
         36BbcQ2AE/wjM4VuWFDJQWh2Dasm2EfntM6SZ0O+lIueC+7hyCyRjUvVYGyC2/9D8YY8
         B0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728837270; x=1729442070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDxK2Ea8zAsHXGUMGPJRnDEQKb2vLC8XXm9F8phQfXk=;
        b=qCxRGq5PvvEKQR8wdBPJ7EmQfU0x2h7D7PeolymQOaD34ZZ2Evk1ARP0L6vpBZpLRn
         rCzzJ7rt54vHQqJPOY5FPCr6apW1cYzqI2L0Uf6kvJvhdKKuht5lu2UL0XpMhUh2gjFz
         Gv8OO3iX32cTJVMMztcSY+qcuvGIYk1VUpYc8IDPjkzgZ2Ke+PosdNu5+ALMnwbu6ri9
         WZq7kx2Z9Iss7V7tdmvXYBJst2xAcJqTwJ1WXIuc0Onho3tmyVlD1/yWTwFylChtB0er
         F4d7T97mZeTuK0q2TqjB6039ISc9QCB/dGrXpngp1wXSskImefvfDXrE6mfvqr9uPnIg
         teeA==
X-Forwarded-Encrypted: i=1; AJvYcCVwOm9olmlzhs8z3j5fGDvk9SgHsR2ChdKdNstSt0707gc0NK++FeHlDuoz727nXXK/kDS/E3kyy9dLX95w@vger.kernel.org
X-Gm-Message-State: AOJu0Yzno7k0wHJyNo8h+PVmrIiq/0dnjS7N7pZPIzCNhFtySyER1prg
	le29dOfjqPDJu12tIKCptM/exFlrvyp3RaIP04JiLvaBiwov61sEkLRrnFxBIVoWldVUUHuiiMX
	6lLY+vZsd+fex6wGHlWd1KKGXhGs=
X-Google-Smtp-Source: AGHT+IFmRR+6I9HClK2v/CuERUKV75WCobKghT+ZFunUTss8W7dXDlEQ/iyifsW07JKDKbo7ahbcS16AuSFR6koYso4=
X-Received: by 2002:a05:620a:3f85:b0:7a9:b80b:81e with SMTP id
 af79cd13be357-7b11a37976amr1785450885a.10.1728837269819; Sun, 13 Oct 2024
 09:34:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524-vfs-open_by_handle_at-v1-1-3d4b7d22736b@kernel.org> <CAOQ4uxhjQwvJZEcuPyOg02rcDgcLfHQL-zhUGUmTf1VD8cCg4w@mail.gmail.com>
In-Reply-To: <CAOQ4uxhjQwvJZEcuPyOg02rcDgcLfHQL-zhUGUmTf1VD8cCg4w@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 13 Oct 2024 18:34:18 +0200
Message-ID: <CAOQ4uxgjY=upKo7Ry9NxahJHhU8jV193EjsRbK80=yXd5yikYg@mail.gmail.com>
Subject: Re: [PATCH RFC] : fhandle: relax open_by_handle_at() permission checks
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 2:35=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Fri, May 24, 2024 at 1:19=E2=80=AFPM Christian Brauner <brauner@kernel=
.org> wrote:
> >
> > A current limitation of open_by_handle_at() is that it's currently not =
possible
> > to use it from within containers at all because we require CAP_DAC_READ=
_SEARCH
> > in the initial namespace. That's unfortunate because there are scenario=
s where
> > using open_by_handle_at() from within containers.
> >
> > Two examples:
> >
> > (1) cgroupfs allows to encode cgroups to file handles and reopen them w=
ith
> >     open_by_handle_at().
> > (2) Fanotify allows placing filesystem watches they currently aren't us=
able in
> >     containers because the returned file handles cannot be used.
> >

Christian,

Follow up question:
Now that open_by_handle_at(2) is supported from non-root userns,
What about this old patch to allow sb/mount watches from non-root userns?
https://lore.kernel.org/linux-fsdevel/20230416060722.1912831-1-amir73il@gma=
il.com/

Is it useful for any of your use cases?
Should I push it forward?

I have rebased and sanity tested it:
https://github.com/amir73il/linux/commits/fanotify_userns/

But I have not written any userns fanotify test yet.
If you are interested, please let me know.
If you can test the patch for your use case even better.

BTW, the prep patch that I refactored per Jan's review request
is almost identical to your patch from 2019:
https://lore.kernel.org/linux-fsdevel/20190522163150.16849-1-christian@brau=
ner.io/

But with additional BUILD_BUG_ON and a commit message to explain it.

> > Here's a proposal for relaxing the permission check for open_by_handle_=
at().
> >
> > (1) Opening file handles when the caller has privileges over the filesy=
stem
> >     (1.1) The caller has an unobstructed view of the filesystem.
> >     (1.2) The caller has permissions to follow a path to the file handl=
e.
> >
> > This doesn't address the problem of opening a file handle when only a p=
ortion
> > of a filesystem is exposed as is common in containers by e.g., bind-mou=
nting a
> > subtree. The proposal to solve this use-case is:
> >
> > (2) Opening file handles when the caller has privileges over a subtree
> >     (2.1) The caller is able to reach the file from the provided mount =
fd.
> >     (2.2) The caller has permissions to construct an unobstructed path =
to the
> >           file handle.
> >     (2.3) The caller has permissions to follow a path to the file handl=
e.
> >
> > The relaxed permission checks are currently restricted to directory fil=
e
> > handles which are what both cgroupfs and fanotify need. Handling discon=
nected
> > non-directory file handles would lead to a potentially non-deterministi=
c api.
> > If a disconnected non-directory file handle is provided we may fail to =
decode
> > a valid path that we could use for permission checking. That in itself =
isn't a
> > problem as we would just return EACCES in that case. However, confusion=
 may
> > arise if a non-disconnected dentry ends up in the cache later and those=
 opening
> > the file handle would suddenly succeed.
> >
> > * It's potentially possible to use timing information (side-channel) to=
 infer
> >   whether a given inode exists. I don't think that's particularly
> >   problematic. Thanks to Jann for bringing this to my attention.
> >
> > * An unrelated note (IOW, these are thoughts that apply to
> >   open_by_handle_at() generically and are unrelated to the changes here=
):
> >   Jann pointed out that we should verify whether deleted files could
> >   potentially be reopened through open_by_handle_at(). I don't think th=
at's
> >   possible though.
>
> AFAICT, the only thing that currently makes this impossible in this patch
> is the O_DIRECTORY limitation.
> Because there could be non-directory non-hashed aliases of deleted
> files in dcache.
>

This limitation, that you added to my request, has implications on
fanotify (TLDR):

file handles reported in fanotify events extra info of type
FAN_EVENT_INFO_TYPE_DFID{,_NAME} due to fanotify_inide()
flag FAN_REPORT_DIR_FID are eligible for open_by_handle_at(2)
inside non-root userns and FAN_REPORT_DFID_NAME is indeed
the most expected use case - namely
directory file handle can always be used to find the parent's path
and the name of the child entry is provided in the event.

HOWEVER,
with fanotify_init() flags FAN_REPORT_{TARGET_,}FID
the child file handle is reported additionally, using extra info type
FAN_EVENT_INFO_TYPE_FID and this file handle may not be
eligible for open_by_handle_at(2) inside non-root userns,
because it could be resolved to a disconnected dentry, for which
permission cannot be checked.

I don't think this is a problem - the child fid is supposed to
be used as an extra check to verify with name_to_handle_at()
that the parent dir and child name refer to the same object as
the one reported with the child fid.
But it can be a bit confusing to users that some file handles
(FAN_EVENT_INFO_TYPE_DFID) can be decoded and some
(FAN_EVENT_INFO_TYPE_FID) cannot, so this hairy detail
will need to be documented.

In retrospect, for unpriv fanotify, we should not have allowed
the basic mode FAN_REPORT_FID, which does not make a
distinction between directory and non-dir file handles.

Jan, do you think we should deny the FAN_REPORT_FID mode
with non-root userns sb/mount watches to reduce some unneeded
rows in the test matrix?

Any other thoughts regarding non-root userns sb/mount watches?

Thanks,
Amir.

