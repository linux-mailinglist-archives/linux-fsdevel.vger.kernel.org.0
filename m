Return-Path: <linux-fsdevel+bounces-31857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 854F899C2F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 10:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 132A61F24D8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 08:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3FB14D430;
	Mon, 14 Oct 2024 08:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiS7dE4x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C36F1552FD
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 08:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894091; cv=none; b=XUjem6Djj9maU7e1ahy3cb3RW+6MWSX3d4smovWGJPGMWPopdV+zd5CmZcSRsClVU0BoTsxd7n+9Hax/4LDhuZBaVgn2hrsgDYY8/MyJVCqP18NrXxoiV6nL+d09yWW6/en0G7fIXesUQbQL9Pub5ESy7hKg7T+lM5cg/n3H8AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894091; c=relaxed/simple;
	bh=kgtViD3Xi6O+/FsBCySztZWHTGaXGCAjcIkWDWD1W9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JVjxlfpJoz+6sq5aVAk50Gkf3+EesFdX7rJQiZjbGOtDJKsTgV8CJHco8xVjLXWpacaoaf9jdsmCqVYQwcyaphi2hxFbQc3wbFQeQ3I88goQVZ61boYpcMqM8xLfVW8Flu9SkX5PNzFxPfUj3oU+UyNG8t2K/e5Luk3Qofyi7+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XiS7dE4x; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b10e0fadbcso327103085a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 01:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728894089; x=1729498889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVhndX36vABmKwhMrXnCjShTB0yg55WbssYg0hBrFrQ=;
        b=XiS7dE4xluPFdf3QF5F8bd9/4nHz2GFFzZKdvvWs7zMsBEgK/2+89yCXeazc3zuM0C
         AL1XVru/bhxPcXCFMHhHBFbbFkj3nUr4BgFZxHIkIAUxV2VslW3NjX3O2uPU0D1AQd+m
         iF5lvd5rsR4iAMLmctol11XmatsHqyUQ/m6mPGxlV5AslGQoFrtBEsQKcfSXQzz4iTBQ
         +/q1R5NMHu4TPgW34TB7xuGFvwSaHt2xBQFZPVI8E57u+SoP4xTli1uM9zU7F0ag5KN6
         bPmhsLuHKrRdfmK3OqLPJ/4scdjJ+cwMawXDjINkEXDDliwiNIHrimSw0WaeoLNgslZi
         c36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728894089; x=1729498889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVhndX36vABmKwhMrXnCjShTB0yg55WbssYg0hBrFrQ=;
        b=naOhAKOl9K/NBu9A5GCyQa9gU7FG5Z57JlhF45aHXt1qQ3ze32w+KTBxLRcayrCieq
         ChWBdgB9nfjYp9ZtcasbVic0Oliwt34eQEd3h3Yy8l2NyqUPUv5cvuSEcHyoJRFp3O7Y
         zYRBtHJvC2RpOjVDwDw9XGbTmhllcMII4RIG8xkI7rRqZ8DFi+1NE6t0nR9zGvZcJxYM
         kkDHSXC9wBKR6zL6nNxlGU0GoKwi42UWjxDWGL8O6wfh/o9Jlh2msIzZWi/A8uIzTa6r
         Htczs6+c2OtS2DE54j34jyLjK3OuKnka46zjdgviucjvCrSMqFjNOrel/vOKaTcwyVAW
         YBOw==
X-Forwarded-Encrypted: i=1; AJvYcCWUm/se7FVWAF6vZaoVrAZZQK+C00XHRuR9IN50axFy0em6fn13BCgUW/9Euxo4P5ozOIoJly77kWhYg/0L@vger.kernel.org
X-Gm-Message-State: AOJu0YyldsiGyuqFhLMZYcyKggmVwF/2cm9rx1A+D0Q4/1La/ofBfAEL
	LL+icqmexwrX3xEWoNqlyZ24MdE5ibw4o2TxE0r/At/DwXlrJwjivG6OFdzdt6jIVNbu2OL8g3V
	+SPyL+6IlemfIRiPHih5Epm5Fjdw=
X-Google-Smtp-Source: AGHT+IEZ7kgNtwIiB+9fs6sWPn3n1MPKFGJTTCyYQ+Fa9qC0GqoJ8X8Pma7L8DOD6MyWHT6LBTIM73/4nTE5kq3OcKI=
X-Received: by 2002:a05:620a:4153:b0:7ac:b1fb:27d3 with SMTP id
 af79cd13be357-7b11a3ad389mr1517445185a.40.1728894088889; Mon, 14 Oct 2024
 01:21:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011135326.667781-1-amir73il@gmail.com> <20241014153041.4142058-1-yangyun50@huawei.com>
In-Reply-To: <20241014153041.4142058-1-yangyun50@huawei.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 14 Oct 2024 10:21:18 +0200
Message-ID: <CAOQ4uxi9ARFuiXmMP6oqwvc4yBeDmVn9510vi8CBZtmPxEUS+g@mail.gmail.com>
Subject: Re: [PATCH] fuse: update inode size after extending passthrough write
To: yangyun <yangyun50@huawei.com>
Cc: bernd.schubert@fastmail.fm, linux-fsdevel@vger.kernel.org, 
	miklos@szeredi.hu, lixiaokeng@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 8:30=E2=80=AFAM yangyun <yangyun50@huawei.com> wrot=
e:
>
> On Fri, Oct 11, 2024 at 03:53:26PM +0200, Amir Goldstein wrote:
> > yangyun reported that libfuse test test_copy_file_range() copies zero
> > bytes from a newly written file when fuse passthrough is enabled.
> >
> > The reason is that extending passthrough write is not updating the fuse
> > inode size and when vfs_copy_file_range() observes a zero size inode,
> > it returns without calling the filesystem copy_file_range() method.
> >
> > Extend the fuse inode size to the size of the backing inode after every
> > passthrough write if the backing inode size is larger.
> >
> > This does not yet provide cache coherency of fuse inode attributes and
> > backing inode attributes, but it should prevent situations where fuse
> > inode size is too small, causing read/copy to be wrongly shortened.
> >
> > Reported-by: yangyun <yangyun50@huawei.com>
> > Closes: https://github.com/libfuse/libfuse/issues/1048
> > Fixes: 57e1176e6086 ("fuse: implement read/write passthrough")
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Doh! force of habbit - fixed subject s/ovl/fuse
> >
> > Thanks,
> > Amir.
> >
> >  fs/fuse/passthrough.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> > index ba3207f6c4ce..d3047a4bc40e 100644
> > --- a/fs/fuse/passthrough.c
> > +++ b/fs/fuse/passthrough.c
> > @@ -20,9 +20,18 @@ static void fuse_file_accessed(struct file *file)
> >
> >  static void fuse_file_modified(struct file *file)
> >  {
> > +     struct fuse_file *ff =3D file->private_data;
> > +     struct file *backing_file =3D fuse_file_passthrough(ff);
> >       struct inode *inode =3D file_inode(file);
> > -
> > -     fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
> > +     loff_t size =3D i_size_read(file_inode(backing_file));
> > +
> > +     /*
> > +      * Most of the time we will be holding inode_lock(), but even if =
we are
> > +      * called from async io completion without inode_lock(), the last=
 write
> > +      * will update fuse inode size to the size of the backing inode, =
even if
> > +      * the last write was not the extending write.
> > +      */
> > +     fuse_write_update_attr(inode, size, size);
> >  }
> >
> >  ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter=
 *iter)
> > --
> > 2.34.1
>
> Sorry for a late reply. Because I have spent some time on figuring out wh=
ether we
> need some FUSE_I_SIZE_UNSTABLE bit operations before and after the write =
which are
> provided in your v14 patch of fuse passthrough, just like in fuse_perform=
_write.
>
> The conclusion is not, IMO. The FUSE_I_SIZE_UNSTABLE bit is provided in
> commit 06a7c3c2781(fuse: hotfix truncate_pagecache() issue) for the
> races between i_size updates and truncate_pagecache() in
> fuse_change_attributes. Because the pagecache operations of fuse inode
> is not allowed in fuse passthrough mode, this FUSE_I_SIZE_UNSTABLE bit is=
 useless.
> And we just need the minimum fix for extending writes by now.
>

That was my conclusion as well.
In general, too large i_size is less of a problem IMO.
Shortening i_size on short read/truncate is an optimization.

> I have also tested this patch with xfstests (using ./check -fuse -b) and =
libfuse
> test. In xfstest, this patch does not import new failed tests compared wi=
th pre-this
> patch. And in libfuse test, this patch can solve the problem test_copy_fi=
le_range().

Thanks for testing!
Amir.

