Return-Path: <linux-fsdevel+bounces-21685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF1F9081B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 04:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB561C21A03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 02:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C414A18309D;
	Fri, 14 Jun 2024 02:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enLipgnm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C154B137C20;
	Fri, 14 Jun 2024 02:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718332469; cv=none; b=MAhbaV6NpwcWYZ60ei0MGlUqOMyFyw1daSVByoA2vb8h0CLguqCwe/SbXQpacPe/q8Wt3vViPiFw0vrYA4vyCUp0JWJ7sGQrMq7zs/sz4lA+vreEa/33/ruTSK+/W3jztXA5ozVtXKMyAv2n86/KE1Qk3N5OKTcaH0hjwErVj4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718332469; c=relaxed/simple;
	bh=SP+cvvpu7TcEopHXQ/jiyaiSFZ+pQGPBR1le2tOnH2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kpM5rYj0J4UTcsoHQ+CCkualEWwKe6kBSBHw/uTEgjDqM0AFPjdvhSHE/piII2PE2XUgUa/+ePCg3dlBQhw7hZW01jCWEJLnu+oi/w8XnmeyA77mX6zWTaz4Zzg1eybnhcOkBLCzmXp/fiB7njlpCSG/e/UvCnhu0Wge+6rfZgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enLipgnm; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dff0c685371so1160313276.2;
        Thu, 13 Jun 2024 19:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718332467; x=1718937267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGt7k6r3FpcN6H9iB54r2UkgCkDa1oqmP1AFpUTryM4=;
        b=enLipgnmEfiU9AyJBzVI7s4O3hCmgXQuhaSAu5XybHmoU7GcM7oeNHA7kc44pRGPbM
         imhZY3edmJhB6XiHU9ACxcZhfarLIX/QwiBv0G0SLTLdoJd/47dP784Rp2rWwL95QXJQ
         kjOTHkxnqq++Px51NgMbcRAVRrdIE35Z/XE7QsNfYgHN2hnqQr99jkhmTetlyyp1onMR
         g3yP2Nb7Wyz6Sq0+w2O9GCH5BJneJWxDOTiOZoVD7BgRoMKpW44tiw0DwJDP7vhERxFS
         FSSQ87CkEnH3EyLFmZS5/pyr5PondJ8r/UKfGSpM+WNaWHGiDeEELfKswAUGyyaY8yQy
         GdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718332467; x=1718937267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGt7k6r3FpcN6H9iB54r2UkgCkDa1oqmP1AFpUTryM4=;
        b=FDYRvUfDLTeVAGwtByhFXk0lvGwiLmoCRVYFIZXoChFiJF2Cz3AmRaf65QI7F2/XHf
         CUF0u66X9czMlQsP1d9jvQDh4ePBSJa26LF/O1ny0XgoNkeXNmZsBjQDy3aD/mx1zSXi
         us0lfUZCaHR4FTu0Ekr4C+kabLdPcClJQscHkblGn9J6u0MmAZvuHYqWh9jiE5xRrinU
         fXZgUx7kpkezhVgL1jepDB59OKdD3yYGO8xRmh/o4sc5W00J4IYDvtJwjnJKPEFkdlSD
         PCnvpMVa6e+Jt2w09Rg9hQwsM7VSIHZuVFoBOUUYrLIbdJLmc1o/DBrrWC5uJttH32Lc
         OO9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbqZm0qxxVCXR3ArtMHd2yJ9lasBba4ZbOm9n6zkAvdvt1PyeslxoXcsHr7eux5BIVKERjQlzLVefXZE2OJpf1GcrtAU1KQMVoXoib8lA3RteKL/9dI0jIIKEKFGi9S7px07ZTn7sgj6okDwdEkPvlTW5hYnPzOKNjszjgb3ODUTx9pRzDWyOblkCzqSbMGtRQFhQK2bYlpsXlognq1oO7jGh+6jmhBAoqKQ+FArGw+hRmuiYuVC/cT3XVYRUGxRHLuwKGD28wFN0OL/ECn2p3YzxNZS1DfzlBVhHNKHv9eH1B3Kvl885b+npaiaJfEOuWF4iPDw==
X-Gm-Message-State: AOJu0YyfLZs02ZsDfZGQALqY8CjjUeY6R5ZoKed+LeN0JPV5LAt222Lv
	cOk1nwl8IFd1FUo9B0Vms30tWreNGfMtNNAfGwVShiqmKtbQxcQGBaeyELFCzhQzKs8kejFu7Q+
	gLsGg4BGkK2ZZXIElqYoJ5FMfksk=
X-Google-Smtp-Source: AGHT+IF7Sz7NY6o3j4C4IPnMtJt7woKj9cH4kVPcujOZcn7xP0eRFnMx3IdWG7c4BrBfrjM411w0aCOam3Y1x/7rGQg=
X-Received: by 2002:a25:acdc:0:b0:df4:45c1:f465 with SMTP id
 3f1490d57ef6-dff154e5be2mr1023094276.62.1718332466522; Thu, 13 Jun 2024
 19:34:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613023044.45873-1-laoar.shao@gmail.com> <20240613023044.45873-6-laoar.shao@gmail.com>
 <20240613141435.fad09579c934dbb79a3086cc@linux-foundation.org>
In-Reply-To: <20240613141435.fad09579c934dbb79a3086cc@linux-foundation.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 14 Jun 2024 10:33:48 +0800
Message-ID: <CALOAHbBEtViUN3L=741jNF4oFSqvxej-p0vcd-0awShMtmCQvg@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] mm/util: Fix possible race condition in kstrdup()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: torvalds@linux-foundation.org, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 5:14=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 13 Jun 2024 10:30:39 +0800 Yafang Shao <laoar.shao@gmail.com> wro=
te:
>
> > In kstrdup(), it is critical to ensure that the dest string is always
> > NUL-terminated. However, potential race condidtion can occur between a
> > writer and a reader.
> >
> > Consider the following scenario involving task->comm:
> >
> >     reader                    writer
> >
> >   len =3D strlen(s) + 1;
> >                              strlcpy(tsk->comm, buf, sizeof(tsk->comm))=
;
> >   memcpy(buf, s, len);
> >
> > In this case, there is a race condition between the reader and the
> > writer. The reader calculate the length of the string `s` based on the
> > old value of task->comm. However, during the memcpy(), the string `s`
> > might be updated by the writer to a new value of task->comm.
> >
> > If the new task->comm is larger than the old one, the `buf` might not b=
e
> > NUL-terminated. This can lead to undefined behavior and potential
> > security vulnerabilities.
> >
> > Let's fix it by explicitly adding a NUL-terminator.
>
> The concept sounds a little strange.  If some code takes a copy of a
> string while some other code is altering it, yes, the result will be a
> mess.  This is why get_task_comm() exists, and why it uses locking.
>
> I get that "your copy is a mess" is less serious than "your string
> isn't null-terminated" but still.  Whichever outcome we get, the
> calling code is buggy and should be fixed.
>
> Are there any other problematic scenarios we're defending against here?
>
> >
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -60,8 +60,10 @@ char *kstrdup(const char *s, gfp_t gfp)
> >
> >       len =3D strlen(s) + 1;
> >       buf =3D kmalloc_track_caller(len, gfp);
> > -     if (buf)
> > +     if (buf) {
> >               memcpy(buf, s, len);
> > +             buf[len - 1] =3D '\0';
> > +     }
> >       return buf;
> >  }
>
> Now I'll start receiving patches to remove this again.  Let's have a
> code comment please.

I will add a comment for it.

>
> And kstrdup() is now looking awfully similar to kstrndup().  Perhaps
> there's a way to reduce duplication?

Yes, I believe we can add a common helper for them :

  static char *__kstrndup(const char *s, size_t max, gfp_t gfp)

--=20
Regards
Yafang

