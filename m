Return-Path: <linux-fsdevel+bounces-29740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A628D97D2E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 10:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 339681F258DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 08:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39E8811F7;
	Fri, 20 Sep 2024 08:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAUSxmJp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915F17DA73;
	Fri, 20 Sep 2024 08:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726821615; cv=none; b=nChBRatQz3/zmaRL3euXSUoqe2s2+HE2T7NLOhhU4/JcLrVzZO0BUN+U34rgcexVbtI8FjlOgLQj7BtdabenNpV+TR3K0Xuja6GJR+LaLbhLH/MbHkMMp2avtqpnU6qPJyl7vp4qJYeiKqIVzI0TRVBNgHYmSjS+qTwRELsEmSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726821615; c=relaxed/simple;
	bh=AxUg6QefsabFNqLGqyUOTnYsid3/1r9Y7B2steSm9jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZwseQZs9GamTsCkkdVHqHGUniHC9KYzf3gzNE7taNGVeSxJeG4WmnyZi6A+ULg9KA/PuGWtPKppge84lErNgyV1+srK+7Gpv50pil6rqxdHLQy5Al5DFaHDgP7z7nvsakwWgf65cN7OY0DMpyey/r7rxrfk7+DWKi3UEXYLku5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAUSxmJp; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4582760b79cso9599001cf.2;
        Fri, 20 Sep 2024 01:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726821612; x=1727426412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9E6JgcYFVVNW1/1pRJtZzP4w4R7pr9GW6NjH0nmdKeo=;
        b=GAUSxmJpgIYhQJPlONK/T9wRKYL7/dnrpUC504EJxt0a6ld28BFn8ZCwTWwoFV0kBD
         O8/gzwOGH2gePI2NFaCByCRnJYnndnwiXo4uxaF7e+BymbKH82Hyal87KDoZwmUL4lLc
         NB5O+Js5lN6fvIV/MaylfZpOgiy6B4zhQqqJ2DNdmZeaMVsOA7fPRCtgZ7ZFUjRMpa6r
         mhHIse5HyrER2M7UI6QCsj/h+9nmrekMyC4VAb9v5FblIZwhcioAH4oAh4t9wRFjQMI2
         TLx/aI2/lzywUEh1VvIdvDuvIFZQY/uyDpI36xZANCHLRcU6T6rTZOnmJUH3Nt0rYbMN
         DUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726821612; x=1727426412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9E6JgcYFVVNW1/1pRJtZzP4w4R7pr9GW6NjH0nmdKeo=;
        b=tZjK3e9VTTJGUrkcKhlMVXuW6JdGkp56FKSb9knm8YgqS1Ehm4HIzvyIQWyDOjJio1
         5wrVeBFf4eDTF+GvebT/5WswHGoxdj7nq/vCV3gTZwEqRDIjMSGzP1fTurh+1f02p3Bj
         oB24LfDZX7y1fIDQ0nhG7meZavqonEtXYMXqGRVRWTNYcXGuGUxqx6RdlnzrJIwE8GbY
         Qq+9BtYnjGbmWVLtNH/dmH72Ciuix2PvuXTS/rPsgHMd8VAbtCdYXAXUHaumhImhnRjI
         PKNNNWuKvS8UPmosxCJK+EyvKqFN41N4oBkiqOTqoUJHErm3wko08LVpYnMjlclogYLl
         JHpg==
X-Forwarded-Encrypted: i=1; AJvYcCXH2vOzyclXoMSca3ul/GNZQfhA2mNCr0/A/On9318XpTtk/m597ApRzpvOkcvL0dRUHRqIUVxgQgeM@vger.kernel.org, AJvYcCXv1KITd++geh97nAAcMDy/okhO+NCY6p1ch7mRPfy55N4Fh+Xczj58+PNXX0UktP7ON9p79NlSFrOI8su1@vger.kernel.org
X-Gm-Message-State: AOJu0YzHyvI6bZHg9YkyCmSCuQ5q70HsVs09ECgtsyBHR6cK9iXT9vJs
	+qI71YIPgYD7kC2O2ls08XwgviQr2kVwimiIpp+9RNOl0aN4pzt/IxOQEjNR7fLH/VhZ+6KuYXL
	Y+c96/TXc987YpyysQ1DtMeykoB0=
X-Google-Smtp-Source: AGHT+IH5d4jmLlXQ/0NAkUKfgjrMIvTe1uTRVX20M4bbYX1s8cyhGRLHvCYeLx6j674oEAu43POQ3CvdGifG+YgxU80=
X-Received: by 2002:a05:622a:1a1c:b0:458:2b7b:c453 with SMTP id
 d75a77b69052e-45b226afd9emr19153471cf.4.1726821612176; Fri, 20 Sep 2024
 01:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919140611.1771651-1-amir73il@gmail.com> <20240919140611.1771651-2-amir73il@gmail.com>
 <9ab958370d5210394e5e6beaad0e788d71c42834.camel@kernel.org> <1f8eb177bf7aa09db96c32451a14a8cdb7e31649.camel@kernel.org>
In-Reply-To: <1f8eb177bf7aa09db96c32451a14a8cdb7e31649.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 20 Sep 2024 10:40:00 +0200
Message-ID: <CAOQ4uxj5c13VzDOPyZV0nkd7cqCPfXVqv_sRB5Qvi1da+qGv8Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] fs: name_to_handle_at() support for connectable
 file handles
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 9:36=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Fri, 2024-09-20 at 09:13 +0200, Jeff Layton wrote:
> > On Thu, 2024-09-19 at 16:06 +0200, Amir Goldstein wrote:
> > > nfsd encodes "connectable" file handles for the subtree_check feature=
.
> > > So far, userspace nfs server could not make use of this functionality=
.
> > >
> > > Introduce a new flag AT_HANDLE_CONNECTABLE to name_to_handle_at(2).
> > > When used, the encoded file handle is "connectable".
> > >
> > > Note that decoding a "connectable" file handle with open_by_handle_at=
(2)
> > > is not guarandteed to return a "connected" fd (i.e. fd with known pat=
h).
> > > A new opt-in API would be needed to guarantee a "connected" fd.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  fs/fhandle.c               | 24 ++++++++++++++++++++----
> > >  include/uapi/linux/fcntl.h |  1 +
> > >  2 files changed, 21 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/fs/fhandle.c b/fs/fhandle.c
> > > index 8cb665629f4a..956d9b25d4f7 100644
> > > --- a/fs/fhandle.c
> > > +++ b/fs/fhandle.c
> > > @@ -31,6 +31,11 @@ static long do_sys_name_to_handle(const struct pat=
h *path,
> > >     if (!exportfs_can_encode_fh(path->dentry->d_sb->s_export_op, fh_f=
lags))
> > >             return -EOPNOTSUPP;
> > >
> > > +   /* Do not encode a connectable handle for a disconnected dentry *=
/
> > > +   if (fh_flags & EXPORT_FH_CONNECTABLE &&
> > > +       path->dentry->d_flags & DCACHE_DISCONNECTED)
> > > +           return -EACCES;
> > > +
> >
> > I'm not sure about EACCES here. That implies that if you had the right
> > creds then this would work. DCACHE_DISCONNECTED has nothing to do with
> > permissions though. Maybe -EINVAL instead since getting a disconnected
> > dentry here would imply that @path is somehow bogus?
> >
> > Given how this function is used, will we ever see a disconnected dentry
> > here? The path comes from userland in this case, so I don't think it
> > can ever be disconnected. Maybe a WARN_ON_ONCE or pr_warn would be
> > appropriate in this case too?
> >

Yes, I agree (with some additions below...)

>
> Oh, I guess you can get a disconnected dentry here.
>
> You could call open_by_handle_at() for a directory fh, and then pass
> that into name_to_handle_at().

Aha, but a disconnected directory dentry is fine, because it is
still "connectable", so we should not fail on it.

>
> Either way, this API scares me since it seems like it can just randomly
> fail, depending on the state of the dcache. That's the worst-case
> scenario for an API.
>
> If you want to go through with this, you'll need to carefully document
> what's required to make this work properly, as this has some
> significant footguns.
>

Agreed.

The correct statement is that we should not get a disconnected
non-dir dentry, as long as we do not allow AT_EMPTY_PATH,
so if we return EINVAL for the flag combination
AT_EMPTY_PATH | AT_HANDLE_CONNECTABLE
we should be back to a deterministic API.

As you wrote in the first email, we should never expect to
resolve a path to a dentry that is not "connectable". Right?

Thanks,
Amir.

