Return-Path: <linux-fsdevel+bounces-71462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06337CC2074
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 11:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74F7B3044B82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 10:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FFC33A011;
	Tue, 16 Dec 2025 10:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cu91aUv+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD87315786
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765882331; cv=none; b=TAqhR5J4xAnnKFPvGDLX+iwoCXOMd5KVLspETTJ72RSe3Z4aFQMizBnYl+2W1OzHeHlIN0Z5gMTbkizI+vpz8tZHwgBtf8K9A/pdGsCaLZds/p3yYsWu+UGQR4gasGxMjrWQLcgHvPj7OvmQ9jzQmPy2NT+dcPsNMQwyTJaI3gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765882331; c=relaxed/simple;
	bh=Ndi93n4syUR8ABgTek5Wu4BnlNN0D+7+l54cx5rtOgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jl0mG8qxutQ1TyPR85q7TiwbV4+g7bPmy6bjJuzka9GBL2UZ2847ecFChL5z6tyFLi+bq5fTU7DEYvY20/vZwLfvE7JUfuz3SRS7iG6SKjaYSYw0PLlQy2MzAlIGQUmIqVUj4XjcWOUp1PaaDYP/OfbOzmvl55tfJcaaULrdonA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cu91aUv+; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b735487129fso748868766b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 02:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765882328; x=1766487128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxQMFLY0Qc+ivRTRc4VDX0hb5SaSWGr9s+tY1E+H+gw=;
        b=Cu91aUv+dCwLyMkjKoVNhfiClZjELc6d3x3ZLXpvHdxv5vyiPCczWxYPKqEVoVxhzc
         udsh9wQoUFy7O7DVmQzVWofHJSdZEQpf/Vl42edEULls9/+DXj/NltlYmGzdbpKHumFP
         A/mmaHx6kmF34fRi6BhxFrED15zlBmOFXcPAjXhB/U3jj9wkFR3RV9r6KwnnlEgYHl3+
         NgANEeHwAT5fgOFrlkYJgypxixNXEN3cucjSXwpLPKB65eaU6K6jj2McFN2KNUug6apG
         T0CNnkMASDb/3mqWLFmJmELCtU6lM4vA5uARza5TE5VbwLxDNJGKRuH0VrQO9+g2RFz7
         a2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765882328; x=1766487128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pxQMFLY0Qc+ivRTRc4VDX0hb5SaSWGr9s+tY1E+H+gw=;
        b=Z2fuapRdcvVRVSRJBNQkvmIOHA+9fYqfSiWkDJIgHLmVmIZyDGOWprvhxojKKMZ+qy
         EnRjo+ANMC0PpIX+MlsseEf/fVNqXQeVJdbzBB0BDYAecInRIcHWEvyzXGLhgSBaFclU
         /LLWYdLQjxxpUNKs3atQpO6z4ZYKjjwry0JD5cBIFTks/DL/7tUMjjxJEUKVGQufYIXK
         twr+n7clEHlP1wo8tBOFnwEAheyFzNZSO0pkK+OLx988Zdmm9tXtOFK1EpaWaoRjw4B4
         VzHU2mjRwXHOfcHTUvHTrzbggm1DYQvOJE9ujoE7XQY+hR9IXC8rFJL22KLiImOvwvHa
         GXpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQjDmoLTAlbeF0PD+1WecTbWU27piFXY25IK+8lrJF5xrE7gvujlcvHNIc373A7y8Z5+LL2HXKwh+tzmrW@vger.kernel.org
X-Gm-Message-State: AOJu0YyMmpQi325sqOiX8aeYXkaSGd2J62kYFbzoFjLcfB3mU0XTqO4D
	bZEi6rck2L8MhA6LSVTK+Y9syMH396md+WAEqchMR9KNV0FykyQL5G40+KE2jfbhlMdtLcwFqXO
	7RmgSRrNrllL6/PxsS7S1AP8FDrWaUI9UU528Stk=
X-Gm-Gg: AY/fxX7uIo6mQcHmQK+A0wohoJAQxSHViBhlKSRl8PZYeHHeYZ7OWm9L5U7J4hjzH99
	YfvqHnqaXJG88f/mtEAF1x+jI/vh9nSQTfOsn6rFFpouvKakLgF6RuTKKQcBLZZnUwVoo3mHU+F
	A6J7HD+0trEE2+F+yFoTBDFgLIB6zMUahfxn30qp26lgK22bgrK0RsCmQB9/PiS1afm8B4sXjft
	J4S1omitgFUNtBt5xk9DxA869DK/8hcw339SeIRT21L6qgMfDeQp92473nCXnpkcD5duucetZy9
	UzGfKnmhto+yW1wRkS1nOJqSrsK4Fw==
X-Google-Smtp-Source: AGHT+IEh/pS+lj5hsC/ZDcfM+sNUz9qbwlTM4MnH/v9WPkxlZE5AvFZndg5x9jrtDu0RgKkvVzU3f/dNgYUVghCdMzM=
X-Received: by 2002:a17:907:9615:b0:b73:301c:b158 with SMTP id
 a640c23a62f3a-b7d235c83d2mr1209651966b.6.1765882327807; Tue, 16 Dec 2025
 02:52:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212181254.59365-1-luis@igalia.com> <20251212181254.59365-5-luis@igalia.com>
 <CAJfpegszP+2XA=vADK4r09KU30BQd-r9sNu2Dog88yLG8iV7WQ@mail.gmail.com>
In-Reply-To: <CAJfpegszP+2XA=vADK4r09KU30BQd-r9sNu2Dog88yLG8iV7WQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 16 Dec 2025 11:51:56 +0100
X-Gm-Features: AQt7F2pyaxgbE8jV199JBqknsjtFPrHzHEjgN2Cs_CKnGpF6Sjo38KwYA0bFMj4
Message-ID: <CAOQ4uxgY=gYYyc62k-Xo7vgrSHgQczC_2d4d-s445GK=eWpKAQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the FUSE_LOOKUP_HANDLE operation
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Luis Henriques <luis@igalia.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matt Harvey <mharvey@jumptrading.com>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 11:40=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Fri, 12 Dec 2025 at 19:12, Luis Henriques <luis@igalia.com> wrote:
> >
> > The implementation of LOOKUP_HANDLE modifies the LOOKUP operation to in=
clude
> > an extra inarg: the file handle for the parent directory (if it is
> > available).  Also, because fuse_entry_out now has a extra variable size
> > struct (the actual handle), it also sets the out_argvar flag to true.
>
> How about adding this as an extension header (FUSE_EXT_HANDLE)?  That
> would allow any operation to take a handle instead of a nodeid.
>
> Yeah, the infrastructure for adding extensions is inadequate, but I
> think the API is ready for this.
>
> > @@ -181,8 +182,24 @@ static void fuse_lookup_init(struct fuse_conn *fc,=
 struct fuse_args *args,
> >         args->in_args[2].size =3D 1;
> >         args->in_args[2].value =3D "";
> >         args->out_numargs =3D 1;
> > -       args->out_args[0].size =3D sizeof(struct fuse_entry_out);
> > +       args->out_args[0].size =3D sizeof(*outarg) + outarg->fh.size;
> > +
> > +       if (fc->lookup_handle) {
> > +               struct fuse_inode *fi =3D NULL;
> > +
> > +               args->opcode =3D FUSE_LOOKUP_HANDLE;
> > +               args->out_argvar =3D true;
>
> How about allocating variable length arguments on demand?  That would
> allow getting rid of max_handle_size negotiation.
>
>         args->out_var_alloc  =3D true;
>         args->out_args[1].size =3D MAX_HANDLE_SZ;
>         args->out_args[1].value =3D NULL; /* Will be allocated to the
> actual size of the handle */
>

Keep in mind that we will need to store the file handle in the fuse_inode.
Don't you think that it is better to negotiate the max_handle_size even
if only as an upper limit?

Note that MAX_HANDLE_SZ is not even UAPI.
It is the upper limit of the moment for the open_by_handle_at() syscall.
FUSE protocol is by no means obligated to it, but sure we can use that
as the default upper limit.

From man open_by_handle_at.2:
       It  is  the caller's responsibility to allocate the structure
with a size large enough to hold the handle returned in f_handle.
       ...(The constant MAX_HANDLE_SZ, defined in <fcntl.h>, specifies
the maximum expected size for a file handle.
       It is not a guaranteed upper limit as future filesystems may
require more space.)

Thanks,
Amir.

