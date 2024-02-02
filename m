Return-Path: <linux-fsdevel+bounces-10008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47AA846FC8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 13:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95B01C252D8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 12:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE8413E230;
	Fri,  2 Feb 2024 12:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0qx+U6e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DAE5FEEC
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 12:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875700; cv=none; b=adu8M3iy3G/a0JuNjgUWAiT0kLQ2sfg5VF4av8rO2h7v9KvjbeRNL8YZhRJ6cvUCNYS8SlKFvXSZ7a5kH0yE5RlHbeu91YrHp7hQ0gsSvak15W5MglyNT3JBNi/JdEsV+KkDWjUYOL15YQ7b1xNpfiE5K1CxFGlUgWj2I9rdpe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875700; c=relaxed/simple;
	bh=y9TN05I8terI1lzPzMxvjaM9c6g8SzN8ozwprcqHNZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=totX2uWqlqB2rjMPnyY1gs0wWCmbW9EhtIaBjra6J6o3efJBxLTyDzchmnNjWJZ22AZZXXFQhlTl39Vgj8JI2iF9dW0BIk/XhKCJ9Wlw9M89RTujN3exqnqA27GDcuHIhtoPryG1Br8I1zJ5CjZp40uFjsyu+XOEGNBylNce77o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0qx+U6e; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-686a92a8661so10713236d6.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 04:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706875698; x=1707480498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYfwWI3cITkjoUfXDX+1SUiNrUTJJprO9xwyuNsPXKo=;
        b=S0qx+U6ex2pGiTVPYAr+y4yUw0cG+hl3HuX21AkXMcinOoU1REIBe1p00vebiQpDOg
         ToTDGVwX/9HigOfncT88X5Nm3A7Dn3Uqxwo+MkMhxDJpVHkUP0qAcH4MK0LtnCrJqwIM
         BxQzAFyMqRzYxxQbR/r5CdcTDhuzI24L5/rd7rsRtH3EWdgo67CfaVoQqHDg21Tfiu+F
         yWc4YWufposQzr6ApIcqrfRpZoO0WLFQ1zI1Vbty4FR9U0OiPhIfItfzJqW5QLH2LYsi
         q5sIC0ZgMu1aOY0iyBI290Ops++9rDMGy0FaSalQnVvkt7VpUFSu8YNaFwrN3TuhX7p0
         bqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706875698; x=1707480498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYfwWI3cITkjoUfXDX+1SUiNrUTJJprO9xwyuNsPXKo=;
        b=e4u8BUAGOU818OZIPdilZYaDHXllJVxK5lU4fH+6g8ayyyt2sNATutFV8y7XXf/1j/
         l/Bjq5RLOp6xRgmtZEk/8PJ8/BUjoBn4Prj4EVt5cItX4/K30AoxMP8TPZjhOLykW74t
         ySjr3oojsULk7PqiPhcelOa8Qu28XBZJV5HL7nkX23yDhiJZs+ygHOqr0ESebnfIxEbk
         nbhxY6tskPBjuT7+cmUCK8gRmfdcx65PszDZz32E5y3Fgt1YFVA2n46Dy/TMmKyXTEzt
         nonILRa0qZSnA3u2uCanYwYubpeeN+bh2RBYZOVMnMKTQQltT+GTbbPAq4OSXG0gwr4W
         aNYw==
X-Gm-Message-State: AOJu0Yys4YKDaB7adXvL6qGNNnSlCnvhsd5Mfh6Mo4mf7hK0THBZlrsQ
	Qgoai0naYZSkeNpgm0yG0PXIRPeGbftz8IP1cH9CvdcPs/EAhl9D3gMCkDLy7FpxiBYsGBcL+bu
	mgeK+qpdi8d+A6oRBtAACWiS4Z7I=
X-Google-Smtp-Source: AGHT+IFXqO77wcm1mRrNbHk7ccHiEsMXwdBQBgumTYZiMbH5Z3zUEpp11eMcOyuil6Ae+BI1Aadub6Z+7GE33IOUXs4=
X-Received: by 2002:a05:6214:dc6:b0:68c:50cf:9e1a with SMTP id
 6-20020a0562140dc600b0068c50cf9e1amr2661473qvt.33.1706875698039; Fri, 02 Feb
 2024 04:08:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202102258.1582671-1-amir73il@gmail.com> <20240202114405.xvgo5zbrhhlskwqk@quack3>
In-Reply-To: <20240202114405.xvgo5zbrhhlskwqk@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 2 Feb 2024 14:08:07 +0200
Message-ID: <CAOQ4uxgQqL_5fTSVpTB=HScyJOkx8Gz6YOr7ZeiV9Wm0Rt3hVw@mail.gmail.com>
Subject: Re: [PATCH] remap_range: merge do_clone_file_range() into vfs_clone_file_range()
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Christoph Hellwig <hch@lst.de>, Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 1:44=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 02-02-24 12:22:58, Amir Goldstein wrote:
> > commit dfad37051ade ("remap_range: move permission hooks out of
> > do_clone_file_range()") moved the permission hooks from
> > do_clone_file_range() out to its caller vfs_clone_file_range(),
> > but left all the fast sanity checks in do_clone_file_range().
> >
> > This makes the expensive security hooks be called in situations
> > that they would not have been called before (e.g. fs does not support
> > clone).
> >
> > The only reason for the do_clone_file_range() helper was that overlayfs
> > did not use to be able to call vfs_clone_file_range() from copy up
> > context with sb_writers lock held.  However, since commit c63e56a4a652
> > ("ovl: do not open/llseek lower file with upper sb_writers held"),
> > overlayfs just uses an open coded version of vfs_clone_file_range().
> >
> > Merge_clone_file_range() into vfs_clone_file_range(), restoring the
> > original order of checks as it was before the regressing commit and ada=
pt
> > the overlayfs code to call vfs_clone_file_range() before the permission
> > hooks that were added by commit ca7ab482401c ("ovl: add permission hook=
s
> > outside of do_splice_direct()").
> >
> > Note that in the merge of do_clone_file_range(), the file_start_write()
> > context was reduced to cover ->remap_file_range() without holding it
> > over the permission hooks, which was the reason for doing the regressin=
g
> > commit in the first place.
> >
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202401312229.eddeb9a6-oliver.san=
g@intel.com
> > Fixes: dfad37051ade ("remap_range: move permission hooks out of do_clon=
e_file_range()")
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Nice and looks good to me. One curious question below but feel free to ad=
d:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> > diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> > index b8e25ca51016..8586e2f5d243 100644
> > --- a/fs/overlayfs/copy_up.c
> > +++ b/fs/overlayfs/copy_up.c
> > @@ -265,20 +265,18 @@ static int ovl_copy_up_file(struct ovl_fs *ofs, s=
truct dentry *dentry,
> >       if (IS_ERR(old_file))
> >               return PTR_ERR(old_file);
> >
> > +     /* Try to use clone_file_range to clone up within the same fs */
> > +     cloned =3D vfs_clone_file_range(old_file, 0, new_file, 0, len, 0)=
;
> > +     if (cloned =3D=3D len)
> > +             goto out_fput;
> > +
> > +     /* Couldn't clone, so now we try to copy the data */
> >       error =3D rw_verify_area(READ, old_file, &old_pos, len);
> >       if (!error)
> >               error =3D rw_verify_area(WRITE, new_file, &new_pos, len);
> >       if (error)
> >               goto out_fput;
>
> Do we need to keep these rw_verify_area() checks here when
> vfs_clone_file_range() already did remap_verify_area()?

Yes, because in the common case of no clone support (e.g. ext4),
the permission hooks in vfs_clone_file_range() will not be called.

There is a corner case where fs supports clone, but for some reason
rejects this specific clone request, although there is no apparent
reason to reject a clone request for the entire file range.

In that case, permission hooks will be called twice - no big deal -
that is exactly like a fallback in userspace cp --reflink=3Dauto that
will end up calling permission hooks twice in this corner case.

Thanks,
Amir.

