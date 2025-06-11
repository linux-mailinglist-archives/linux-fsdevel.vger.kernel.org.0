Return-Path: <linux-fsdevel+bounces-51340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B56AAD5AE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 17:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D71B3A6222
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 15:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF30F1E376C;
	Wed, 11 Jun 2025 15:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="A++2K2G0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75AC1DE3C3
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656718; cv=none; b=TAl91tq4mmsj3hfDujf07AeVy8lc40M23SoZ+hfgo4yfOosuSrS3s1w+u7Op1o1qLfqmhbEdy/m8lLjqhtEyGY/Bxsad3pX2kBp+ZxvdmgJug4kQGUkVVAjRNHMP88L+OXbkqo9fJKrOW68zp7QMzhud0od7j57V4AByDg8m6mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656718; c=relaxed/simple;
	bh=nn3Frlo9C3N7jmQAsLP5JRdKgVr952KuKSlZfqPB0mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SGhs9mNWbvtKlgo0ubQUm3OUXMJxy3oM99o5XNMDaOEoBMwFs0HmcGccO34uyfu/Sr8MS6fheKvMjMWbzWphnqsAveyMYV+ww2YgLkNgbXBS2Y4jG9o/Wk0ngGv0+CtMNEBJgMaeVGa9alhRPqvAjhQYrmlhqEgE8HhDp9U6Yq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=A++2K2G0; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e81ec95d944so985729276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 08:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749656715; x=1750261515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rr8HzynHF02QsFY9FAMsE2al9WZZ1v5BFhMIQ9+R0eA=;
        b=A++2K2G0e0qQd4AaYnQewF9mODgcF0M4y8fV30qLNBqa2evO8czeOX63yGvlJ7/r9w
         7vaEVVSAx2U6QFUThhuV+v6u47XNDwnghEnZQ2hDp6GBEUiIsIQSBdFhy36BcPOricBa
         57hkxhHZayQ6mZTIhICNjNl3BvMOeUI7XRXT0c8lJS/7QwM5KKUj8e9EU5T9/msjzhpB
         tiS1ZQmx9GhauC0RZiqFAcaN33VD2vedAWiSQWZhVCQebBTbxOztRGnkJ0w6ieyhIxJe
         769w1CyeDW3r3dOj1lEcSe0kvnhFtPf43w/DAl6inVePhP1U/gf4W+aIK2cIcxN8yZOj
         AC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749656715; x=1750261515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rr8HzynHF02QsFY9FAMsE2al9WZZ1v5BFhMIQ9+R0eA=;
        b=GmrRhs7Y6lvTRJ+ryljUrmMlmqfJYMMuuY5b4L2kJ9DYsuk2ELM3gSdZNsXnq2tCpu
         mZ4Zuf7HNu7EsQZQc7rV1FvCmoDxYrgRYnKBpk+Vq36A4QvF2zMOKUic3baUUCjg5jRA
         57qnaKvBSIItDjhkI454zURj9mEonggkdB8Iuw+KHoOYeyEcdHJUZNc8fk1jrIGZPMNg
         ZKpBERVW2cH+KSte0lPKwPG5LbGS5XashKA0vrvbLhXLIiaT90j+/9lrZoRrFUZ6RwjA
         xJe7+c8vJzXaSMQYF01pqoSgJaChfLIgIjTfQbkFOZoGerkb0JI3rceM8cZmYVHDsDof
         dSAw==
X-Gm-Message-State: AOJu0Yx0kWb/d6GB+dOqCLJ0GJsu/GwC8SJEJt2SZ4XyQJkVTndGRh+o
	PuSEWkcWnBzbrfHBsyWuYqnKpoO8nS0D52OLANVyu6hUl2ETvWN3AHXEQ3Mp92hRUMzspGeWGOj
	CmMeXLv8jKGBhemCkIM2vK4osocscJ9ZjJHE+vx7g
X-Gm-Gg: ASbGnctb+1uaH2X7dtPEjtLDUTzPJI0UuipnRlVcA3i0/aHTOD4f5J3EyD+CCxg8l5T
	EfgTE2C0kBoy+wewiATBVMZxZ0syZkA9JhAGT4N2PCokHeOi8BDS9EhtHfOmmb2bW6DltxnUM96
	7k9pZQg/qiAP5S0esCCdW6JUQxZurP9ArsbssMvGTmDABqGpVklduzOQ==
X-Google-Smtp-Source: AGHT+IF0x91wO7ieY1VBV4TKEAQMxfl7pCnbajI3YzlN5rzvSMdIo54/z2z0PcKudWn5ds5l8R7jWbi2/H1BT15q+gI=
X-Received: by 2002:a05:6902:2313:b0:e81:eb1c:1a1e with SMTP id
 3f1490d57ef6-e81fe899e1emr5351273276.3.1749656715190; Wed, 11 Jun 2025
 08:45:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605164852.2016-1-stephen.smalley.work@gmail.com>
 <CAHC9VhQ-f-n+0g29MpBB3_om-e=vDqSC3h+Vn_XzpK2zpqamdQ@mail.gmail.com>
 <CAHC9VhRUqpubkuFFVCfiMN4jDiEhXQvJ91vHjrM5d9e4bEopaw@mail.gmail.com>
 <87plfhsa2r.fsf@gmail.com> <CAHC9VhRSAaENMnEYXrPTY4Z4sPO_s4fSXF=rEUFuEEUg6Lz21Q@mail.gmail.com>
 <20250611-gepunktet-umkurven-5482b6f39958@brauner>
In-Reply-To: <20250611-gepunktet-umkurven-5482b6f39958@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 11 Jun 2025 11:45:03 -0400
X-Gm-Features: AX0GCFtYjHydo7psPZIcgWJNd2HocnI9KUxU0OYaer59jF3FYBEgwxmKF0Cei-Y
Message-ID: <CAHC9VhQYi2k3eamrn+kPkooZQpQ4cdsjs=nvntRVbz4=wz1rzA@mail.gmail.com>
Subject: Re: [PATCH] fs/xattr.c: fix simple_xattr_list()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Collin Funk <collin.funk1@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, eggert@cs.ucla.edu, 
	bug-gnulib@gnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 6:05=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Jun 10, 2025 at 07:50:10PM -0400, Paul Moore wrote:
> > On Fri, Jun 6, 2025 at 1:39=E2=80=AFAM Collin Funk <collin.funk1@gmail.=
com> wrote:
> > > Paul Moore <paul@paul-moore.com> writes:
> > > >> <stephen.smalley.work@gmail.com> wrote:
> > > >> >
> > > >> > commit 8b0ba61df5a1 ("fs/xattr.c: fix simple_xattr_list to alway=
s
> > > >> > include security.* xattrs") failed to reset err after the call t=
o
> > > >> > security_inode_listsecurity(), which returns the length of the
> > > >> > returned xattr name. This results in simple_xattr_list() incorre=
ctly
> > > >> > returning this length even if a POSIX acl is also set on the ino=
de.
> > > >> >
> > > >> > Reported-by: Collin Funk <collin.funk1@gmail.com>
> > > >> > Closes: https://lore.kernel.org/selinux/8734ceal7q.fsf@gmail.com=
/
> > > >> > Reported-by: Paul Eggert <eggert@cs.ucla.edu>
> > > >> > Closes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2369561
> > > >> > Fixes: 8b0ba61df5a1 ("fs/xattr.c: fix simple_xattr_list to alway=
s include security.* xattrs")
> > > >> >
> > > >> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > >> > ---
> > > >> >  fs/xattr.c | 1 +
> > > >> >  1 file changed, 1 insertion(+)
> > > >>
> > > >> Reviewed-by: Paul Moore <paul@paul-moore.com>
> > > >
> > > > Resending this as it appears that Stephen's original posting had a
> > > > typo in the VFS mailing list.  The original post can be found in th=
e
> > > > SELinux archives:
> > > >
> > > > https://lore.kernel.org/selinux/20250605164852.2016-1-stephen.small=
ey.work@gmail.com/
> > >
> > > Hi, responding to this message since it has the correct lists.
> > >
> > > I just booted into a kernel with this patch applied and confirm that =
it
> > > fixes the Gnulib tests that were failing.
> > >
> > > Reviewed-by: Collin Funk <collin.funk1@gmail.com>
> > > Tested-by: Collin Funk <collin.funk1@gmail.com>
> > >
> > > Thanks for the fix.
> >
> > Al, Christian, are either of you going to pick up this fix to send to
> > Linus?  If not, any objection if I send this up?
>
> It's been in vfs.fixes for some time already and it'll go out with the
> first round of post -rc1 fixes this week.

Great, thanks.  I didn't see any replies on-list indicating that the
patch had been picked up, so I just wanted to make sure someone was
sending this up to Linus.

--=20
paul-moore.com

