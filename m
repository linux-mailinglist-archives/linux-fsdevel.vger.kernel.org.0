Return-Path: <linux-fsdevel+bounces-22026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4428B91116C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 20:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B211F2300E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 18:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC551BB682;
	Thu, 20 Jun 2024 18:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0n5sz2w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9896F1AAE17;
	Thu, 20 Jun 2024 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718909462; cv=none; b=fzKU6UhvB2Qexs3eoOWHBQ2XWIwlp4+gIDGS1GTKxFXfDNuof5DvuJ+Te5TCHAXhh5als8p5MjzJ7+iXAsSLH/LPwF3gxK+eunBtzbzZjuLbSXH3r2+VjNsKjmRdOSZJ0UJcOCUE8n0evc4NzPcBg5LSWa9WhGmGyKclLYuNKdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718909462; c=relaxed/simple;
	bh=JCsw9Z71zYyh4aSb/EWUf/SrmLTo32aaxOCeejC25lQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vFC5eX+vDPFX1y3afvH2ZPXmTK9+xhl0nq7zb2YRGjeIhbLH3J/S9E+9RMPIdjRFHiyl8PCJUDXPvhw/VDaj5/Dh+EirpK0eru4yBg++X3XknxMP3pK+p6wcOVQNIk8DDQvheRDhO/nVN/iZtATptU6u1RJvK7cFpxXc6imgi2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0n5sz2w; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c306e87b1fso1052183a91.3;
        Thu, 20 Jun 2024 11:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718909460; x=1719514260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89o8ujkIHq6PMM4aoMW4/XgYMSFc2QsW0KmDVaz6Gcw=;
        b=c0n5sz2w0c2vPbB/ZqJe7st3Rbl+uCbSCCW7btOsoyJtzkVLKMz2859km5qHVsOOWT
         N6fKTmGcCstQ+ejsB5EZHCr40yskpJtVj/C5t4VoAqNlsXMh+31nwVIu+d7gnsLaLa7o
         PQqycY/gebhR2V7+yAyhXjemIntt/5W6eFwWws4vY+DLFWPRRDilqmnabcKsX50OkvMi
         rgM2ajnvMNmX20c3muxbcmQgBa6HvaZHfWd78bxoux+XsXw8PnDntuCCbJygBYHhTCpj
         1cv8dqxUoXplwrU6+eSok+P91OGqiPtoT+AX2Ap0WQrCjbTaCAWk6mkALa4pVg10TgVe
         KG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718909460; x=1719514260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89o8ujkIHq6PMM4aoMW4/XgYMSFc2QsW0KmDVaz6Gcw=;
        b=Be0PQwbKjPfUZgobiQvcQgthAAmhIXkc2b1A0L7/H/aVd+C+NOAKc22+sC52eRg0OH
         WBjRD5xTxdZxy0bd5Oh4vfMlPywy1hGm2eStU1CDNdY9HkRha2m8tv3KMNVVmPLwZSEW
         /yWs0B17cGzvwGtLs2w5KG4LI7aa0FxBO3Yj28Y9hI8DpsIkpF8Gj9+HYGRdu468aGUB
         hWHL0lhvuBIWXWmt7ZG6G35kd30fCoENg8CCf5u7qNyNC0QZ9zVBOUBJtJXMpswh4JKB
         5j1iT+FqvEHaOEpjPFTBi0TNkMMIIbnh55EiLTmoyKcLOk0GqUCpl2b8hx0LxoHUI10c
         vzIg==
X-Forwarded-Encrypted: i=1; AJvYcCVXriNkjmIFKNtK3XK5ZRZS9bNoimagDnUZR5Rpz/rwqp/3dKPUksFRhGs1snhxt95Hi9XOQAcdbOkw5kLGgM8wpSmQCEC1aDvJUgYugZ7iiHjyVuTFCYWXt+EFFwssAJcNgjBrFvBtH3lTx5pZtn34cQjFdFVHelSBWV6jEL4v9Q==
X-Gm-Message-State: AOJu0YwMOwy8RjoKZ5fZZBXQvwystrhf7Xft2lUNMCH9I4l0wbo1G7HJ
	7i5KT5LCaORdPBLsvsO1fuXoRgHfYyX7zcby1he8UlxcgmPNpRVD2JX/Z9sM3TbfC7ZonsTl+jO
	wyyLeYcpjZvvoXBhA/JtAgWo5U3aGlA==
X-Google-Smtp-Source: AGHT+IHejfXXhcSCG+8k7941Dm3EbX0ewHLJ/3VEPrjpG3OW0flhMpyIcVTUB8X7jTk9vLYpIJrEnWTTU3wycg008lE=
X-Received: by 2002:a17:90a:1346:b0:2c3:2da1:c8bc with SMTP id
 98e67ed59e1d1-2c7b5af9211mr5980842a91.15.1718909459936; Thu, 20 Jun 2024
 11:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618224527.3685213-1-andrii@kernel.org> <20240618224527.3685213-4-andrii@kernel.org>
 <984d7898-d86a-4cea-9cdf-262b9ec4bc84@p183>
In-Reply-To: <984d7898-d86a-4cea-9cdf-262b9ec4bc84@p183>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 20 Jun 2024 11:50:48 -0700
Message-ID: <CAEf4BzaCARqfovaOL55qyjncLSo9APNUvt=hH4Quh0Y0yeq53Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] fs/procfs: add build ID fetching to PROCMAP_QUERY API
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-mm@kvack.org, liam.howlett@oracle.com, surenb@google.com, 
	rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 3:14=E2=80=AFAM Alexey Dobriyan <adobriyan@gmail.co=
m> wrote:
>
> On Tue, Jun 18, 2024 at 03:45:22PM -0700, Andrii Nakryiko wrote:
> > The need to get ELF build ID reliably is an important aspect when
> > dealing with profiling and stack trace symbolization, and
> > /proc/<pid>/maps textual representation doesn't help with this.
>
> > @@ -539,6 +543,21 @@ static int do_procmap_query(struct proc_maps_priva=
te *priv, void __user *uarg)
> >               }
> >       }
> >
> > +     if (karg.build_id_size) {
> > +             __u32 build_id_sz;
> > +
> > +             err =3D build_id_parse(vma, build_id_buf, &build_id_sz);
>
> This is not your bug but build_id_parse() assumes program headers
> immediately follow ELF header which is not guaranteed.

Yes, I'm aware, and I think I stated somewhere that I want to
fix/improve that. The thing is, current build_id_parse() was built for
BPF under NMI context assumption, which is why it can't page in memory
and so on (and this "build ID has to be in the first page" was a
surprise to me, but probably just a technical shortcut to make it a
bit easier to implement). Regardless, my plan, once this API is
merged, is to follow up with make build_id_parse() variant that would
work reliably under sleepable context assumptions. Hopefully that's ok
not to bundle all that with these patches?

>
> > +      * If this field is set to non-zero value, build_id_addr should p=
oint
> > +      * to valid user space memory buffer of at least build_id_size by=
tes.
> > +      * If set to zero, build_id_addr should be set to zero as well
> > +      */
> > +     __u32 build_id_size;            /* in/out */
> >       /*
> >        * User-supplied address of a buffer of at least vma_name_size by=
tes
> >        * for kernel to fill with matched VMA's name (see vma_name_size =
field
> > @@ -519,6 +539,14 @@ struct procmap_query {
> >        * Should be set to zero if VMA name should not be returned.
> >        */
> >       __u64 vma_name_addr;            /* in */
> > +     /*
> > +      * User-supplied address of a buffer of at least build_id_size by=
tes
> > +      * for kernel to fill with matched VMA's ELF build ID, if availab=
le
> > +      * (see build_id_size field description above for details).
> > +      *
> > +      * Should be set to zero if build ID should not be returned.
> > +      */
> > +     __u64 build_id_addr;            /* in */
>
> Can this be simplified to 512-bit buffer in ioctl structure?
> BUILD_ID_SIZE_MAX is 20 which is sha1.

I'd prefer not to because vma_name can't use the same trick, so we'll
have to have this size+buffer address approach anyway. And because of
that I'd like to have all these optional variable-length/string output
arguments handled in a uniform way. In practice, it's really simple to
use this from user-space, the only mildly annoying part is casting
pointer to __u64. But as I said, for vma_name users will do this
anyways, so not much benefit simplifying the build_id part only.

