Return-Path: <linux-fsdevel+bounces-52261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6732AE0E9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 22:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1480C1BC4AE2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 20:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7A025EFB9;
	Thu, 19 Jun 2025 20:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZyrqyqC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96D41D5AB7;
	Thu, 19 Jun 2025 20:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750364986; cv=none; b=fhrfR6Jw5MHUO7TiSjJw9zs6RMKy0I7TNYeoihu0X7B2+eSnvkuTpVIOfLBbooS9mWDfXtPAG1hcJjIDzmVRJsWP7Opt/89vqpZsmLjH6H/f+AH4iLSW6nWxcNjsdki1a89t8emjXQtRCc/9BdpmX75pH0mExRlUi85zCp21GgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750364986; c=relaxed/simple;
	bh=cOFxCJU2ttlgdIifO+yjrisbXRzkYrVjmCo4RB7MJ8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XA91hU+IO936GztOvSnqPvN2rStZ7BChSAtHWr746Jl/ntu9KxuXy+BP+PgCkxYXp1M5Xko+ykCmsv7RT32Ivd9+q6ESbnSs+pQuRpDngBtLtuI0houdD91S94ePPW2/VIDM58qmWjhbNjRw022WZZJn0LLwAkIoAVTch48qjbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZyrqyqC; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so1685870a12.3;
        Thu, 19 Jun 2025 13:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750364983; x=1750969783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOFxCJU2ttlgdIifO+yjrisbXRzkYrVjmCo4RB7MJ8g=;
        b=lZyrqyqCWWzAZqmF6KOxS+MKF/nAVcgX/Zq7cc9B4NQ7K3m+lEDX2dg8244ux40WJR
         msAPkxvmhv0bRLgPBCxawwDyM1VnCDObSoVmGJk5LM0m8gaZuLTRLbStUPaULTQdMwHK
         YaP88oFGSttO5ZUefGvR18mVHiM4nCCX0WJPLFvz6Y/eJGV7Ob5YIL1ebTS3z1W8k8vN
         N9Hj2Xz03bQy+E85eilfsuICmOhmBtFBVKWa8n+6bgqBm/HTOuNXFXF6BOrQ33uko36n
         ExfgpNTXCbC3VpOn5eWZkchUbOjTcVfhH13Hk8kPmr//jkNx2Ke6JMMk7Fi0MNeZYTuY
         QJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750364983; x=1750969783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOFxCJU2ttlgdIifO+yjrisbXRzkYrVjmCo4RB7MJ8g=;
        b=pM3ctqwZhs9FNB83yGZALJYlLwLpQWkgIMg5tRpfD0jGli3ZF7nJH7PUzYPUAVslu2
         tktI+LNYnJwO6nfpsBuWlYmOQdDbQ31RBbjUapiJ0Ht/8ZVJIf3b+ZeHdMUr+96Wt6Rr
         DzEQ5ZURUIG28aC6ERhZXWV0r+hGSuPmdnAFySFzSHTto5zSbR8/rgrXR133+aj5ezAp
         7x3BJmm21jLFB9flvE6DUSoVDbREs7UrRj7NMfj+onA7ajQJJ5+fmyzk7GCOD4k/F0Bn
         K0w6mFWIkkVj1WEnzUEBblN5WxCDEqAxQQTYZN4IKU6yrk+gKomkQ82WChw+N1uihONZ
         56kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV9I2hCaeI27dcD8QeiyDxr+3jS1hq8mlx7zW1bJWg2QZ/iY76QhLBgDLpftsjBO92QuLiKPvroIlKNmou@vger.kernel.org, AJvYcCXhjHMlGB+oZXRVIGs1Ijmht/SaljYQDVXHPZyEWMu+IDQmRxgzG9qXjPubOJTttpynVW0e4mnkjD8qrXg9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ae3xqzE9Ihi4oAXnZUW4JBxmQGngBaYrvZfUPf6hhNhgeWu+
	u/KudzE8R+j0PCFD1CSWjMtHtTrgYkj1NfHLs0Xb9/ROrsZ6poVeeah5+c8sDklaUjamgVnWAZV
	iWUrMKkZWEaSe42bR6iAFO0p1FVFy7e7ppwNR5/g=
X-Gm-Gg: ASbGncsUMkwYOAGd6E6Ty7Xq5ZdQUPDBU0lZ6K3aX6XUSrldXGdCVzwn/D7fFwIxFUn
	hlFS0L46W0WEX6HIkBARtVkATLbf7BFlO7iF3jVrdMlP4aVUoAfc4tMml7HldIELTCKb8bUx7GB
	3a+524raVt1H8KkLk/yqPULxooNpO6HkAlNNoznPzL6LE=
X-Google-Smtp-Source: AGHT+IEG9Ax7l2KlVrj7JQkoxBDjfBihdSaXlDVUB/f8N/RmOmazTQoN4c00tATkhGMB3XYD8Atecy2EVljNryYN8Bs=
X-Received: by 2002:a17:907:97ca:b0:add:ed0d:a581 with SMTP id
 a640c23a62f3a-ae057cbc0damr23568666b.17.1750364982682; Thu, 19 Jun 2025
 13:29:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617221456.888231-1-paullawrence@google.com>
 <CAOQ4uxgaxkJexvUFOFDEAbm+vW4A1qkmvqZJEYkZGR5Mp=gtrg@mail.gmail.com> <CAL=UVf707OokQUuhzbvrweFziLVmiDD3TFs_WG2hRY0-snw7Wg@mail.gmail.com>
In-Reply-To: <CAL=UVf707OokQUuhzbvrweFziLVmiDD3TFs_WG2hRY0-snw7Wg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 19 Jun 2025 22:29:31 +0200
X-Gm-Features: AX0GCFtQ9eb7NBPl_a9iYEVjOeAo5V5FWn8oqPQM0QLKQ5Li4g7fNTreHcvJYG4
Message-ID: <CAOQ4uxhUK6EeCUZ36+LhT7hVt7pH9BKYLpxF4bhU4MM0kT=mKg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] RFC: Extend fuse-passthrough to directories
To: Paul Lawrence <paullawrence@google.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 9:50=E2=80=AFPM Paul Lawrence <paullawrence@google.=
com> wrote:
>
> Hi Amir,
>
> Thank you for your detailed reply. My intent with this patch was to see i=
f there
> was interest (a definite yes) and to see what path would best get us
> to our common
> goal.
>
> I'm thinking the best approach is to start with your ops_mask API. In
> fact, that solves
> the biggest single problem with my future patch set, which was that it
> was going to be
> huge and not realistically divisible, since you need everything for
> directory passthrough
> to work without the mask. Your way allows us to proceed in nice
> logical steps, which is
> much, much better. Thank you for that suggestion.
>
> So my follow-up question is: What can I do to help get the
> foundational patches you
> wrote upstreamed?

Well you can always take them and re-shape them and post them
to see what the maintainers think and address the feedback.
But I can try to beat them to shape myself to at least post v1.

>
> In the meantime, a few thoughts on your comments. (Note that one of
> the beauties of
> your suggestion is that we don't need to agree on any of this to get
> started - we can
> discuss them in detail when we get to the specific ops that require them.=
)
>
> 1) Yes, let's use backing_id. I won't mention that again.
>
> 2) The backing path per dentry comes from the way dentry_open works.
> If we are going to
> attach a file to a lookup, we have to put something into the
> fuse_dentry or the fuse_inode.

There is already fuse_backing *fb in fuse_inode.
I don't understand why anything else is needed for implementing
passthrough dir ops.

> This makes more sense once you see points 3 & 4 below - without them,
> we have an open
> file, so why not just use it?

We need to make the code simple enough.
Not add things that are not needed.

>
> 3) A cute idea that we had that seems to work is to allow negative
> dentries as backing
> dentries. It appears to work well - for instance, a create first looks
> up the (negative) dentry
> then creates the file into that dentry. If the lookup puts a negative
> dentry as the backing
> file, we can now just use vfs_create to create the backing file.
>

That sounds like trouble.
Overalyfs effectively implements passthrough dir ops.
It doesn't keep negative backing dentries, so I doubt that this is needed.

> This means that only FUSE_LOOKUP and (I think) FUSE_READDIRPLUS need to h=
ave
> the ability to accept backing_ids. I think is is both more elegant
> conceptually, simpler to
> code in the kernel *and* simpler to use in the daemon.
>
> 4) Having to open a file for it to be passed into a lookup is
> problematic. Imagine
> readdirplus on a large folder. We would need to open every single
> backing file, and it
> would stay open until the dentry was removed from the cache.

We are talking about opening a O_PATH fd at lookup.
The daemon does not need to keep this O_PATH fd open,
although production daemons today (e.g. virtiofsd) anyway
keep an open O_PATH fd per fuse inode in cache.

Maybe it is a problem, but I am not convinced that it is, so
maybe I need more details about what problems this is causing.
If you are going to pin the backing inode/dentry to cache, then most
of the memory resources are already taken, the extra file does not add
much memory and it is currently not accounted for in any process.

>
> Both of these suggest that rather than just passing a backing_id to FUSE_=
LOOKUP
> and FUSE_READDIRPLUS we should be able to pass a backing_id and a relativ=
e path.
> This is where the idea of putting the backing path into the fuse
> dentry comes from.
>

Sorry this is too much hand waving.
I still don't understand what problem attaching a backing path to every den=
try
solves. You will have to walk me through exactly what the problem is with
having the backing file/path attached to the inode.

> I don't *think* this creates any security issues, so long as the
> relative path is traversed
> in the context of the daemon. (We might want to ban '..' and traverses
> over file systems.)

Sorry you lost me.
I do not understand the idea of backing_id and a relative path.
passthrough of READDIRPLUS is complicated.
If you have an idea I need to see a very detailed plan.

> Again, these are details we can debate when the patches are ready for
> discussion.
>
> But again, let's start with your patch set. What are the next steps in
> taking it upstream?
> And which are the next ops you would like to see implemented? I would
> be happy to take
> a stab at one or two.
>

I can post patches for passthrough getxattr/listxattr, those are pretty
simple, but I am not sure if they have merit on their own without
passthrough of getattr, which is more complicated.

Also I am not sure that implementing passthrough of some inode ops
has merit without being able to setup passthrough at lookup time.

I will see if I can find time to post a POC of basic passthrough of inode
ops and setup of backing id at lookup time.

Thanks,
Amir.

