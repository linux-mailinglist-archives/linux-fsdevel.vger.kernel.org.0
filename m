Return-Path: <linux-fsdevel+bounces-31052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6EB9914E4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 08:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0C40B2103D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 06:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096DF487A5;
	Sat,  5 Oct 2024 06:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIpN79aF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E4F2F2A;
	Sat,  5 Oct 2024 06:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728109837; cv=none; b=AOp6bWPV3GclOA5MY+2Q3Mr46qCvOld4MiOIb2kWpGQVFRtVxabv3K5BXGnFLg2P6EjvjHkMAsgJtZFcNFyV96pq6uVZEH9Hb6p56WdEUq2Ocb7NNdXBdAbdgKD0rZNgcNyUrDzyzFlh/yW+jG2HUEEKf/6PGQjYyFZfzgAIcic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728109837; c=relaxed/simple;
	bh=FMbKnl2kr9X9cITACii8Oc1oNYwReY/rvET9aX5mHvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbnfaX/ifkfyi3FRYJ1yZ3w55reBkY7RX8lnwfWAY7a4+49FxSSwar6pvAp7QCaCWZeoYDrUwL8j1CawDghbJiLAEQVotQlB291gp7Q0bsdcBEefc++0uKrfhAVLoEuCCyf8ezKcEwM/lrmpPiI2N4pF1ZAZK1ftsCibaEo0wkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIpN79aF; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a99e4417c3so231052085a.1;
        Fri, 04 Oct 2024 23:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728109835; x=1728714635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+fR6xuL4U1Qi/6NqDs4tODnhzqj9PCbnMbFBbj7vBU=;
        b=fIpN79aFVXhVwQwvgNDpD7J8XlIbsdjrB5L400IRmY5/m/Z/68C8m1/ZmhZDkW8VrY
         1JVx2mOD3rVpUZN1F01gSnnajZJ52w+CGpKyruqDXHILPEHjeweD05q8mrFRQml0Ng6t
         3CNMh0Um+GuK6lsly++xeKGh127hTfQ+b9ZmVy7DeK3Vih7crwwnCq2jDSgAYF17CyyF
         MtHVxH+AL36u2aFr0n89Co+dhEHQRqtywXAoaUFpXxHM1sFgD6AH+oyesZNhNGC9+iOX
         ZqPItUfqh6yfCU67bIsBplA35R5yRzb4IyaQ7tRmRlBmTdn2zqeIjgr1gR4tLH+0AqCx
         5EJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728109835; x=1728714635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+fR6xuL4U1Qi/6NqDs4tODnhzqj9PCbnMbFBbj7vBU=;
        b=CdfPIzw2QE5/ylOmY0cpY8nDgXfaEDHen2+oLFuYMv67BuV1k9q2pcFq1bemlbt8nM
         f3KJgpDBxFS8lWe8iihotVA3G9THE90bAGIF6+FtYe9igZqk/y/ijM2JL6U6/jKlIxHz
         Qf1YnrYSqCTiCqn1BXvEK+3xJYkUeEcHxUn7Q0Vk2rrKYnHsaHaHGcVBUjjxdDCf6x0Q
         QE4WIlLvUVBaQ2YkhfwMtM8rW2OMKw1SgLh3P+U76vuZNey2yk3xHRKhdmOXWBHc5GfB
         ekGHzBNNIDhvRtrvVY3P7Mm5Q0Qh5ofXCHUy1og1F8QlgeN2bYh8+S1cO7OT49FDSj5g
         ngyA==
X-Forwarded-Encrypted: i=1; AJvYcCUx3Pp8cLszjcCD82o48VT6/FDXwE/GYEh8ROP7ZoM0cuioPDlP6xlh2nulFX2VWciqY3lqdNep4HGYLvK8@vger.kernel.org, AJvYcCWLtvg1N5HdhDfRuK0HZGJQ1GORVuSFOkDKxwnOBhwHc3XaXi+wxDWYsTmhxb4VHCZtBjwmjTh87PRILsEoug==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKYM7WbkYi6KoO7sdF/cjmkcM9EmkZn7Ka6tzURjpdj0UuXocn
	Um9JsLsZ/9pwP0QWAvEJWtoXClpm+5VCnAmKO5J2bB1mGPknGbT+XHzu4BiympsNb2e0q6UOQyq
	Oc5VUqmV93UW3Z27KVCZs9ky2G21ZYzuhmJI=
X-Google-Smtp-Source: AGHT+IHAIRsjhMIyJ/JqJ7hqKxTCEuFfB63lAhi3Vy+XWDx2j5Th58LM+U/ArGetMTImtJvdM6neBhEfLN6GYmlPr+M=
X-Received: by 2002:a05:620a:4611:b0:7a9:bd5b:eb60 with SMTP id
 af79cd13be357-7ae6f44cc8fmr767322085a.35.1728109834746; Fri, 04 Oct 2024
 23:30:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004102342.179434-1-amir73il@gmail.com> <20241004102342.179434-2-amir73il@gmail.com>
 <20241004221625.GR4017910@ZenIV> <20241004222811.GU4017910@ZenIV> <20241005013521.GV4017910@ZenIV>
In-Reply-To: <20241005013521.GV4017910@ZenIV>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 5 Oct 2024 08:30:23 +0200
Message-ID: <CAOQ4uxiqrHeBbF49C0OkoyQm=BqQjvUYEd7k8oinCMwCSOuP3w@mail.gmail.com>
Subject: Re: [PATCH 1/4] ovl: do not open non-data lower file for fsync
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 3:35=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Fri, Oct 04, 2024 at 11:28:11PM +0100, Al Viro wrote:
> > >         /*
> > >          * Overlay file f_pos is the master copy that is preserved
> > >          * through copy up and modified on read/write, but only real
> > >          * fs knows how to SEEK_HOLE/SEEK_DATA and real fs may impose
> > >          * limitations that are more strict than ->s_maxbytes for spe=
cific
> > >          * files, so we use the real file to perform seeks.
> > >          */
> > >         ovl_inode_lock(inode);
> > >         fd_file(real)->f_pos =3D file->f_pos;
> > > in ovl_llseek()?  Get ovl_real_fdget_meta() called by ovl_real_fdget(=
) and
> > > have it return 0 with NULL in fd_file(real), and you've got an oops r=
ight
> > > there, don't you?
> >
> > I see... so you rely upon that thing never happening when the last argu=
ment of
> > ovl_real_fdget_meta() is false, including the call from ovl_real_fdget(=
).
> >

Correct. I had considered renaming the argument to allow_empty_upper_meta
but I don't think that will make the contract a lot better.
The thing is that ovl_fsync() caller is really different in two
different aspects:
1. It wants only upper and therefore fd_empty() is a possible outcome
2. It (may) want the metadata inode (when data is still in lower inode)

Overlayfs can have up to 3 different inodes in the stack for a regular file=
:
lower_data+lower_metadata+upper_metdata

There is currently no file operation that requires opening the lower_metada=
ta
inode and therefore, staching one backing file in ->private_data and anothe=
r
optional backing file chained from the first one is enough.

If there is ever a file operation that needs to open a realfile from
lower_metadata (only ioctl comes to mind), we may need to reevaluate.

> > I still don't like the calling conventions, TBH.  Let me think a bit...
>

I understand your concern, but honestly, I am not sure that returning
struct fderr is fundamentally different from checking IS_ERR_OR_NULL.

What I can do is refactor the helpers differently so that ovl_fsync() will
call ovl_file_upper() to clarify that it may return NULL, just like
ovl_{dentry,inode,path}_upper() and all the other callers will
call ovl_file_real() which cannot return NULL, because it returns
either lower or upper file, just like ovl_{inode,path}_real{,data}().

> Sorry, I'm afraid I'll have to leave that until tomorrow - over 38C after=
 the sodding
> shingles shot really screws the ability to dig through the code ;-/  My a=
pologies...

Ouch! feel well soon.

Thanks,
Amir.

