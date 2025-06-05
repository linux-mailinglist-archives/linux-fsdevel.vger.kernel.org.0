Return-Path: <linux-fsdevel+bounces-50789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2280ACF946
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 23:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D753AFBC1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 21:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D9927F16A;
	Thu,  5 Jun 2025 21:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Sr3oS6Gd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAAB4AEE0
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 21:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749160277; cv=none; b=U8JiqSx6QOUPOtljRdsT63IgGMgYNZNHyT8M3JLywF2fuvcYXnKwmVEzmIG5upJnyCyQ47MXLWWOfywUkc5tW7N39KVa16pe9K95J3qTK0T5OMaaNGLZRpHyDkw0Xsuf8pcuVAkCc1ziCR7aSUMXpgK82qffY+BMhHoerQfh030=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749160277; c=relaxed/simple;
	bh=755S9h4e3lhJ7G6Amq1GHJNIb3T3WttwHIsYDZsZMa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7Q2zTyFu4472IWM682uGHUooL4CXTzSGUvhl3S6PxVyOnnTWwjmB5KGkOobBtoKIxjZEqItbU1ms9j/aHqS5aw42JHZA709SU989BbXzn6lj6L4D5ckCLEsjv6PWvZrZcG5hvwAgkhFlcgp9Xn7dF1xpaDmcvjODLWh4p/D+mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Sr3oS6Gd; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e8187601f85so1482580276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jun 2025 14:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749160275; x=1749765075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q73clLkN9MkZDXUIYnVM17RaAmlbhc3zBqb9kmZ99dU=;
        b=Sr3oS6GdEGYwsE2mi0S60CgNYia4G4b0ul2nB281p+/nMSQfB3n8EZ4dgxfPR/f7LB
         Jx2O/CGEgNAPGxokX1CdblB3WRb0q+Yi7MDicT2g5CCr3aFRo+dBiwooSe19L9NtJkTk
         DYibl+RIxvrZ4Cow9NjwH4s8HF6NnfUg6kTBFZW2krQdLtg71Oe+sOFVy0QZt3E4Ijo2
         Rvpw2oIe2I1nyzwm4EIpJ/+IKJuAkMj8FL90mJ3YFA61G7dNsswSa89nJrTmT927KMR8
         oHsGaFefU7/KEHEA5HUCvXbjqO4Lxno7Iv3fo8WAndI73ASstq+fRBt0O5e7xms8wIFL
         17SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749160275; x=1749765075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q73clLkN9MkZDXUIYnVM17RaAmlbhc3zBqb9kmZ99dU=;
        b=ncxb9Dsrvbr6Hb/+NOxKbxrB05HHSbHiEe+SAN7IT75QyiYRNU0kSan0x1mwrz7MQC
         DIuPVjSvqgOWyfVb5HfapKpb9z05+UZ7vkYheybUa9TXQUJNSGmwFk6g0rcSqvPRSkr9
         SDypv17PsSibVcNjTpvSpV8NMlVEpGuOto9dYaKvJJlxr9usiOHxPukPg9aRkQPpMffM
         +2Ji6Uvk16N3lAmyqpy9WNWGMuicmDCXbHSGDvWoYdrJlUJdVNpe2++6jBYnsZoPqb44
         vosADRbyz/S6Bq7rKL+EFL5ITE2ivrzcWlzMp7BcwmPt0o0JE5QJrqmQUUFYixL8nuMm
         66vg==
X-Forwarded-Encrypted: i=1; AJvYcCV3saXsFHjXzQmvBBExYygxMmEgHa341tb1Itd0aYAmFm9AH4/8AoHJVEog6+c0bILGNt9fYdcCV6lLRpu1@vger.kernel.org
X-Gm-Message-State: AOJu0YyM3UcTGEjyHDpVKxzc0HzTmKpghqjDlSbZwa4+J7gchjZR+aOf
	5sF+eowq6/H1AA53wk0LeKgswGF8FsQ72/3Gaigq4WKrWvO1wwNuDLEsqdObwZTNQWCA2/8IOZE
	jEQPA5JsBfW7mOQk5cbZk04CEApa/CnRF233IzyzQ
X-Gm-Gg: ASbGncuSScKOZPHgNJ8etMmyK4VyltUQmjH+MnWxymJsBvBIURUz8JC+1yvDDNewuie
	CHV2w3qsH+TWnaLVZjeEUS0hqckrL5Dj6SFh8bH5nxqxy1i1grO9XuV7e7d3jR3gEDgsYzXz/Fk
	gvsdL0KO3a+RRudxLAXM5R8YyOQZRxF7UBzuhItogWssQ=
X-Google-Smtp-Source: AGHT+IH8rWmL3NURj++utqdkH+5GRnHoJxWmeuuvsdqQh8WxSx0oAPFT99bO6nYMRzPjhD6n87qofS6a5Gelido0y7s=
X-Received: by 2002:a05:6902:2b06:b0:e81:9cbd:d184 with SMTP id
 3f1490d57ef6-e81a2562ab9mr2014351276.47.1749160274822; Thu, 05 Jun 2025
 14:51:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605164852.2016-1-stephen.smalley.work@gmail.com> <CAHC9VhQ-f-n+0g29MpBB3_om-e=vDqSC3h+Vn_XzpK2zpqamdQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQ-f-n+0g29MpBB3_om-e=vDqSC3h+Vn_XzpK2zpqamdQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Jun 2025 17:51:04 -0400
X-Gm-Features: AX0GCFtSaj5dP0qo5NwUElUF5HvPHPlbkWWjHsO-9fmw1SjRtP1N3S6_O6Cdmgs
Message-ID: <CAHC9VhRUqpubkuFFVCfiMN4jDiEhXQvJ91vHjrM5d9e4bEopaw@mail.gmail.com>
Subject: Re: [PATCH] fs/xattr.c: fix simple_xattr_list()
To: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	collin.funk1@gmail.com, eggert@cs.ucla.edu, bug-gnulib@gnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 5:40=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Thu, Jun 5, 2025 at 12:49=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > commit 8b0ba61df5a1 ("fs/xattr.c: fix simple_xattr_list to always
> > include security.* xattrs") failed to reset err after the call to
> > security_inode_listsecurity(), which returns the length of the
> > returned xattr name. This results in simple_xattr_list() incorrectly
> > returning this length even if a POSIX acl is also set on the inode.
> >
> > Reported-by: Collin Funk <collin.funk1@gmail.com>
> > Closes: https://lore.kernel.org/selinux/8734ceal7q.fsf@gmail.com/
> > Reported-by: Paul Eggert <eggert@cs.ucla.edu>
> > Closes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2369561
> > Fixes: 8b0ba61df5a1 ("fs/xattr.c: fix simple_xattr_list to always inclu=
de security.* xattrs")
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  fs/xattr.c | 1 +
> >  1 file changed, 1 insertion(+)
>
> Reviewed-by: Paul Moore <paul@paul-moore.com>

Resending this as it appears that Stephen's original posting had a
typo in the VFS mailing list.  The original post can be found in the
SELinux archives:

https://lore.kernel.org/selinux/20250605164852.2016-1-stephen.smalley.work@=
gmail.com/

> > diff --git a/fs/xattr.c b/fs/xattr.c
> > index 8ec5b0204bfd..600ae97969cf 100644
> > --- a/fs/xattr.c
> > +++ b/fs/xattr.c
> > @@ -1479,6 +1479,7 @@ ssize_t simple_xattr_list(struct inode *inode, st=
ruct simple_xattrs *xattrs,
> >                 buffer +=3D err;
> >         }
> >         remaining_size -=3D err;
> > +       err =3D 0;
> >
> >         read_lock(&xattrs->lock);
> >         for (rbp =3D rb_first(&xattrs->rb_root); rbp; rbp =3D rb_next(r=
bp)) {
> > --
> > 2.49.0

--=20
paul-moore.com

