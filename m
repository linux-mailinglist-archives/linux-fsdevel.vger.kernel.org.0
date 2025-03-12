Return-Path: <linux-fsdevel+bounces-43797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C0EA5DC8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 13:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EFB13A8476
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 12:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C646D242904;
	Wed, 12 Mar 2025 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlMQQ/CP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4565F236A8B;
	Wed, 12 Mar 2025 12:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741782384; cv=none; b=g5kEnZuv0wfoefNHeeJgtSXaSVA4V7Yu+HcgpqFsOd3/Wzslgnofv1dWdImK2wkIzNJgYjXEtlpwk5J/TpYEWHzWFs8WwwmM/0NZ1ysgf5qVoEUPCWJ22MsKClNAnOFOg47XxRcVPGY7NsJ1CCqejVbe565S1m1e8WoGv1TFuZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741782384; c=relaxed/simple;
	bh=+S5IFxoaulHkrOYysVTZsSuDESUj9x2lAoqd9xgjh9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ffldQGRADNvrf2e54XFTvBnw891zgODeYaRAA4LA32dL//6KUX6QUONX8M7YKXr3Wkh6sqd4jozGVXk+AYwOMgTRunN3mnf42D7VK59hW9PKbPzRk4qHehMQFt23CGSOEMMm+sikb8G80ondk7v8lxfcKb0KqjQe5T26Gm0STMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlMQQ/CP; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so12839078a12.1;
        Wed, 12 Mar 2025 05:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741782380; x=1742387180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFe2sOveZKBWE9gAu2WL/9uvR3gMDz4Pu1TP5mW2XBA=;
        b=BlMQQ/CPB3Gzs0x+hRMBZHrj9MHIBsqL6wMSMVJR8KwbUirFx4OEslLIQajnvKKLHh
         xqmbOFttgFxiyEL0yBwcxuiOpTvjlaNwS+sILLO2pcgIIESx+fG5nAtziVYchrhoCA83
         d/jMXZZ0ZhJkhhhh2Sd4J+6P3pTVmgB5rWP8xnAKvgSVMTCWiwWoEoLpzDRcf/KLITky
         hrAzyT51tRnV9p1kGQA6tNU8s0//sUTtlYIvYxRL7MgvkOdbr4ZzHKcqGxlC2bkH2mjx
         bLg6yCWXS2nPGF6GF+JjhFxQtSAVK3oF9CYvMhGc9Y8SMEQA7GB3io9Ozi5OzBOXbUJi
         uROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741782380; x=1742387180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFe2sOveZKBWE9gAu2WL/9uvR3gMDz4Pu1TP5mW2XBA=;
        b=tVFWqAh6xp9moVuGhve9+X2klt5WJO50VfOb6IhvaOsSOESxLugW9pEza3yctW32k8
         DpvNqQ5mbjNdSJsVbtFVLPyIkwU/JNnU9DBgE1NrR0s3hk0OhkEbFphxhoAXYnJqWAKP
         uF5cY8xSmvPS/QO9LAgVnqloO/dgfKNp24H6Ywx4EBIwteZ0283uk2mQwsY2nkj0fJPh
         QamXm+dNK+XaGlem3l6zKlEOwG7WRoHSMmZqVTXW2NmLCQZK+4dvWsn3dC6vXBwDa1Ux
         I4d/gYK/jqu7TSCeNNGbY+4qk20QnHElqnbXnwpdn6OJY67i1NPHxUS2dv90jMB3JRrH
         8gQg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ86gh6rWrR32YhYpgKI667q5UHQtrfBVdJWSKMgV6/3iXozd/rnYW0DNtHiJbW7cd/2IxprzGjXaC0BcP@vger.kernel.org, AJvYcCWpo5V0msYpe4K1/2BsH2Rwn9SS4/8M7nKDcq14PsdudGmIrVdAizSXGT/IFoHpvHBJ3VGvVX0oVMKiO7hTe3HPw4YFOW9y@vger.kernel.org
X-Gm-Message-State: AOJu0YzPtZXXpixJ8Z0WpwpCzzhglPhTS2AWPFynBTeqrXziTjBnjbgN
	M3Df1UxzCML1enYHDTzlLB/tLBddiO+giKv3C79LgPJDAU3Suq/NxYVPW6Mj3PiMlkxdwz4NjDa
	PwccZi7WEK0uik407mqUV6j9G/Jg=
X-Gm-Gg: ASbGncuoEvWICQDlFRuWhvOb5GFclo+DTGWLhko9XtFSIwHG2uTV+k52ey+9fFFSU37
	16bOaTTO45MX/LdjoB1w8HIuqzdrFyRsjShFAkiTjsZDU+BJT6Pdu/TYA7LOK0ptshBoViV3R/v
	Dxbvm8xfD1HBFhf/6YyXc+UtWnpA==
X-Google-Smtp-Source: AGHT+IGz6WljhO0FY//SkK/6uCInDqHyKjR+Ac2u9tqcTPIInkMm5tol8ItxWs4BA32CK83EyrBX18QvUwVaPAu2ABY=
X-Received: by 2002:a17:907:1b05:b0:ac2:8a4:b9db with SMTP id
 a640c23a62f3a-ac2525f4065mr2385386466b.16.1741782379985; Wed, 12 Mar 2025
 05:26:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741047969.git.m@maowtm.org> <20250304.Choo7foe2eoj@digikod.net>
 <f6ef02c3-ad22-4dc6-b584-93276509dbeb@maowtm.org> <CAOQ4uxjz4tGmW3DH3ecBvXEnacQexgM86giXKqoHFGzwzT33bA@mail.gmail.com>
 <1e009b28-1e6b-4b8c-9934-b768cde63c2b@maowtm.org>
In-Reply-To: <1e009b28-1e6b-4b8c-9934-b768cde63c2b@maowtm.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 12 Mar 2025 13:26:08 +0100
X-Gm-Features: AQ5f1JqI0toqoIEZPMBdO5gcT6EIqdR9pQE4ZELMDP38nUAVA6eda8UjLjB_fRI
Message-ID: <CAOQ4uxhgQ8h2m9fPHe8nFO8+WSqFGSKB9TdSKWz5dE6ax4tb5Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] Landlock supervise: a mechanism for interactive
 permission requests
To: Tingmao Wang <m@maowtm.org>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, Jan Kara <jack@suse.cz>, 
	linux-security-module@vger.kernel.org, Matthew Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>, Jeff Xu <jeffxu@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Francis Laniel <flaniel@linux.microsoft.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 1:42=E2=80=AFAM Tingmao Wang <m@maowtm.org> wrote:
>
> On 3/6/25 17:07, Amir Goldstein wrote:
> [...]
> >
> > w.r.t sharing infrastructure with fanotify, I only looked briefly at
> > your patches
> > and I have only a vague familiarity with landlock, so I cannot yet form=
 an
> > opinion whether this is a good idea, but I wanted to give you a few mor=
e
> > data points about fanotify that seem relevant.
> >
> > 1. There is already some intersection of fanotify and audit lsm via the
> > fanotify_response_info_audit_rule extension for permission
> > events, so it's kind of a precedent of using fanotify to aid an lsm
> >
> > 2. See this fan_pre_modify-wip branch [1] and specifically commit
> >    "fanotify: introduce directory entry pre-modify permission events"
> > I do have an intention to add create/delete/rename permission events.
> > Note that the new fsnotify hooks are added in to do_ vfs helpers, not v=
ery
> > far from the security_path_ lsm hooks, but not exactly in the same plac=
e
> > because we want to fsnotify hooks to be before taking vfs locks, to all=
ow
> > listener to write to filesystem from event context.
> > There are different semantics than just ALLOW/DENY that you need,
> > therefore, only if we move the security_path_ hooks outside the
> > vfs locks, our use cases could use the same hooks
>
> Hi Amir,
>
> (this is a slightly long message - feel free to respond at your
> convenience, thank you in advance!)
>
> Thanks a lot for mentioning this branch, and for the explanation! I've
> had a look and realized that the changes you have there will be very
> useful for this patch, and in fact, I've already tried a worse attempt
> of this (not included in this patch series yet) to create some
> security_pathname_ hooks that takes the parent struct path + last name
> as char*, that will be called before locking the parent.  (We can't have
> an unprivileged supervisor cause a directory to be locked indefinitely,
> which will also block users outside of the landlock domain)
>
> I'm not sure if we can move security_path tho, because it takes the
> dentry of the child as an argument, and (I think at least for create /
> mknod / link) that dentry is only created after locking.  Hence the
> proposal for separate security_pathname_ hooks.  A search shows that
> currently AppArmor and TOMOYO (plus Landlock) uses the security_path_
> hooks that would need changing, if we move it (and we will have to
> understand if the move is ok to do for the other two LSMs...)
>
> However, I think it would still make a lot of sense to align with
> fsnotify here, as you have already made the changes that I would need to
> do anyway should I implement the proposed new hooks.  I think a sensible
> thing might be to have the extra LSM hooks be called alongside
> fsnotify_(re)name_perm - following the pattern of what currently happens
> with fsnotify_open_perm (i.e. security_file_open called first, then
> fsnotify_open_perm right after).
>
> What's your thought on this? Do you think it would be a good idea to
> have LSM hook equivalents of the fsnotify (re)name perm hooks / fanotify
> pre-modify events?
>

No clear answer but some data points:

The fanotify permission hooks (formerly fsnotify_perm) used to be inside
security_file_{open,permission} so when I started looking at dir modificati=
on
permission events I started to try using the security_path_ hooks, but as t=
he
work progressed I found that fsnotify hooks have different
requirements (no locks).

Later, we found out that the existing fsnotify permission hooks have differ=
ent
needs than the existing security hooks (for pre-content events), so after:

1cda52f1b4611 fsnotify, lsm: Decouple fsnotify from lsm

fanotify is not using any LSM hooks and not dependent on CONFIG_SECURITY.

Mentally, I do find it easy for fsnotify and security hook to be next
to each other,
unless there is a reason to do it otherwise, because from vfs POV they
are mostly
the same, but note that my branch implements the new fsnotify hooks actuall=
y as
scopes (for sb_write_srcu) and in some cases as other people have mentioned
on this thread, the security hooks need to be inside the vfs locks,
while the fsnotify
hooks need to be outside of the locks.

> Also, do you have a rough estimate of when you would upstream the
> fa/fsnotify changes? (asking just to get an idea of things, not trying
> to rush or anything :) I suspect this supervise patch would take a while
> anyway)
>

Besides my time to work on this, these patches are waiting for some
other things.

One is that I was waiting with promoting those patches until pre-content pa=
tches
got merged and that took longer than expected and even now there may
need to be follow ups in the next cycle.

Another thing is that these patches rely on the sb_write_srcu design concep=
t
which is pretty intrusive to vfs, so I still need to sell this to vfs peopl=
e.
I am going to make another shot of an elevator pitch at LSFMM in two weeks,
If we get past this design hurdle, the rest of the work will depend on
how much time I can spend on it.

I do *want* to  make the patches in time for the 2025 LTS kernel, but it ma=
y
not be a realistic goal.

One thing that helped a lot with pushing pre-content events is that Meta
already had a production use case for it.

I do not know of anyone else that requested the pre-directory-modify
hooks (besides myself), so that may make the sale a bit harder.
If there is someone out there that does need the pre-directory-modify
hooks now would be a good time to speak up.

> If you think the general idea is right, here are some further questions
> I have:
>
> I think going by this approach any error return from
> security_pathname_mknod (or in fact, fsnotify_name_perm) when called in
> the open O_CREAT code path would end up becoming a -EROFS.  Can we turn
> the bool got_write in open_last_lookups into an int to store any error
> from mnt_want_write_parent, and return it if lookup_open returns -EROFS?

IIUC you mean like this:

               err =3D mnt_want_write_parent(&nd->path, MAY_CREATE,
                                                  &res, &idx);
               if (err && err !=3D -EROFS)
                       return err;
               got_write =3D !err;
               /*
                * do _not_ fail yet - ....

Yes, I think that is better, because the logic in the comment only
applies to EROFS.

>   This is so that the user space still gets an -EACCESS on create
> denials by landlock (and in fact, if fanotify denies a create maybe we
> want it to return the correct errno also?). Maybe there is a better way,
> this is just my first though...
>
> I also noticed that you don't currently have fsnotify hook calls for
> link (although it does end up invoking the name_perm hook on the dest
> with MAY_CREATE).  I want to propose also changing do_linkat to (pass
> the right flags to filename_create_srcu -> mnt_want_write_parent to)
> call the security_pathname_link hook (instead of the LSM hook it would
> normally call for a creation event in this proposal) that is basically
> like security_path_link, except passing the destination as a dir/name
> pair, and without holding vfs lock (still passing in the dentry of the
> source itself), to enable landlock to handle link requests separately.
> Do you think this is alright?  (Maybe the code would be a bit convoluted
> if written verbatim from this logic, maybe there is a better way, but
> the general idea is hopefully right)

I am not sure I understand your question.
fsnotify does not need to know this is a LINK and not CREATE.
I do not know what the requirements of other LSMs for those hooks,
so hard to say if it is ok to move those hooks but my guess is not ok.

>
> btw, side question, I see that you added srcu read sections around the
> events - I'm not familiar with rcu/locking usage in vfs but is this for
> preventing e.g. changing the mount in some way (but still allowing
> access / changes to the directory)?
>

No. this is meant to accommodate fsnotify_wait_handle_events()
(see last patch) - wait for in-flight modifications to complete without blo=
cking
new modifications. That's the concept that I need to sell to vfs people.

Thanks,
Amir.

