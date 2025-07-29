Return-Path: <linux-fsdevel+bounces-56245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26102B14D6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 14:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9923A0828
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 12:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E77528FA89;
	Tue, 29 Jul 2025 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnDi6ozh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2874728B417;
	Tue, 29 Jul 2025 12:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753790801; cv=none; b=A+BvAuTbHsX7x7zGyCMPQCug3BmveZ3uNdvAfS7mpmGI4byz8pH0c50iKJBtvm6h2KpDA/N0NXhxc0Fqraz2HElzAXEG2vfZ9XToBI02A1nXEkhcXfJiCG5U+7RO0tMxRJJCS9snCGWBeskpzG3qzyu9VqyWXZWZCGjoX4mKaik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753790801; c=relaxed/simple;
	bh=DXWM/ypqIDZ58I2QbqRtV7LraPXmMsDAr8ESaTpEyVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UvHndhEetqYUNKzuLAz6plmY2cSECp2vLP+jWrbk8+EVg1QcRxooE5YFN/XDpnx8+T6cn0NW9r75MjatRWNtO+cFqWRdAG5EnjN97O5Dgsp42xEMkZp0DPufrSe2bL3+ysmJTNdrJ0BAbOvWIY5JfTWkpQa0PLi9qoDJjvtodO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnDi6ozh; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6155e75a9acso2079401a12.0;
        Tue, 29 Jul 2025 05:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753790798; x=1754395598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXWM/ypqIDZ58I2QbqRtV7LraPXmMsDAr8ESaTpEyVE=;
        b=ZnDi6ozh3bqzuBC4SS8y3Dvqcwxj/8Z1ithLUJy69afD/WWQ31ocKg3BkvoHmFXmkD
         yDcbmQmHYeyYmI/RGSpvOcGhwiLLZMizJzcJS/mDHqGtFa6n9m1RFUFcqWZyOUQ7OMd9
         gq7jbKA47gAU+6fc+jqHKPiD+IkjxMr/Dj7GHCOKdpBZxnF7LVaV4G61S+8adoHRO3SL
         kBTm64FauU6AELrf74Jm+LZdiaEUf0kLj4pMuFDcncusygYoXxMOHqw583wYjoaIfxPd
         i2KELFGJinhCjmxOy1hJDtZfn+6beXinpaDciyo1WELIKzL5b4C1MCVg8igwW80h32mA
         xEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753790798; x=1754395598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXWM/ypqIDZ58I2QbqRtV7LraPXmMsDAr8ESaTpEyVE=;
        b=xM4peJZBGf/MVSz9+chZ3EFTHtB2uCnsHg3xxlwgbRqv0uYUxSB8DG5s8rIuMxU5eH
         wR8jQCds1/ZpD4OOsGYDKWSqPrmpM1+iL0UTXGDyo5uOIvDYrUN6alv8dnbocKb8FxVZ
         zZ3XcNAXTBeaFMh+m8JEZcSNj+BwTlEx4hs2DonYnZcNlulQcjeyojTOB9ghpAF2C/UQ
         Umjm52o2OT+99Ja7BJziWhaeNmYCUJeB5nguFvU10hc2NAqH5ibMKllFdNYDUnkHDeTZ
         KDtb0uJhpkSEtJKlZuYLo5jWE54yEperwBoS+ljdFLhaxnp6EpF6eVcE31Fw8lxYekzh
         tXmA==
X-Forwarded-Encrypted: i=1; AJvYcCU7eE5RssItTAExl1dQnXrRSWn7CDYEJyz/LOFhlZHVlqvXh+Mg5NJn0v6EbFGZujIKaHHZ6++V/KkR@vger.kernel.org, AJvYcCUmgpVGx8mgNBL4q8p4LxywZkbR2qvK1bhx8Fjjuyl7h5IaiKYXWWe/2sXNW0tUkYV0WUKneUcvYdgYiIUk@vger.kernel.org
X-Gm-Message-State: AOJu0YybwyOlXDBm41XkXQtigbUgcqIsxeItzX/D4WtmWPqJB8fwTWTQ
	mjatnU6315ldMupObPzzNAEB/FJjx+ERIUPaDbuxYrxKD2Tz13xi5mHZ+orPJ+LUJcuWoVl5s0a
	IOscdGQiClwG7uCNjmnrjITa7lvDD4Qk=
X-Gm-Gg: ASbGncs1H4bXgICzpPS/6a1Yu8gmQK6gte3JR4z+3UTF9/QBGGGDGzWe0zzzt19f8oW
	mcNaFVGgKvzPZojUjb+yDjqYAynmgSre79bvfndpU/oqXfYpkhHD72Iav009OlHQi0eitSgJz7y
	7Lb5COokihao/n8k2wigW+mKKYDrhGsxInlxQrRUXvQwsr9L55hN2WBoy6edgTX2EfIsH3mhTJd
	9ovh90=
X-Google-Smtp-Source: AGHT+IEf+MIS97B7TPFbqcda/Jx9eHeq1SlqXKCodea7X91A4GGrjGOuW5kxjPHpb2b7c6ZvuSJ1EY/0SG2I5iBGMqs=
X-Received: by 2002:a05:6402:2710:b0:615:3a7a:5108 with SMTP id
 4fb4d7f45d1cf-6153a7a5347mr5806402a12.21.1753790798120; Tue, 29 Jul 2025
 05:06:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
 <20250728-fsverity-v1-3-9e5443af0e34@kernel.org> <CAOQ4uxjXucbQderHmkd7Dw9---U4hA7PjdgA7M7r5BZ+kXbKiQ@mail.gmail.com>
 <ppcw73dlw4qdumbmel4spy2uvlaocnqfowquiop4mhauw3xxc4@kjad3vbucx7v>
In-Reply-To: <ppcw73dlw4qdumbmel4spy2uvlaocnqfowquiop4mhauw3xxc4@kjad3vbucx7v>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 29 Jul 2025 14:06:26 +0200
X-Gm-Features: Ac12FXxizHAQToV0suLhQNsm6KvYYdlbWlziqM1NTUuwTvmkgl5EEy7GOiXJo8E
Message-ID: <CAOQ4uxjZ9zOpo==20xw9dQnumCMY3Buk0vhGgSft0tOEf2+k=A@mail.gmail.com>
Subject: Re: [PATCH RFC 03/29] fs: add FS_XFLAG_VERITY for verity files
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, fsverity@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, david@fromorbit.com, 
	djwong@kernel.org, ebiggers@kernel.org, hch@lst.de, 
	Andrey Albershteyn <aalbersh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 12:35=E2=80=AFPM Andrey Albershteyn <aalbersh@redha=
t.com> wrote:
>
> On 2025-07-29 11:53:09, Amir Goldstein wrote:
> > On Mon, Jul 28, 2025 at 10:31=E2=80=AFPM Andrey Albershteyn <aalbersh@r=
edhat.com> wrote:
> > >
> > > From: Andrey Albershteyn <aalbersh@redhat.com>
> > >
> > > Add extended attribute FS_XFLAG_VERITY for inodes with fs-verity
> > > enabled.
> >
> > Oh man! Please don't refer to this as an "extended attribute".
> >
> > I was quite surprised to see actually how many times the term
> > "extended attribute" was used in commit messages in your series
> > that Linus just merged including 4 such references in the Kernel-doc
> > comments of security_inode_file_[sg]etattr(). :-/
>
> You can comment on this, I'm fine with fixing these, I definitely
> don't have all the context to know the best suitable terms.
>
> >
> > The terminology used in Documentation/filesystem/vfs.rst and fileattr.h
> > are some permutations of "miscellaneous file flags and attributes".
> > Not perfect, but less confusing than "extended attributes", which are
> > famously known as something else.
>
> Yeah sorry, it's very difficult to find out what is named how and
> what is outdated.

indeed.

>
> I will update commit messages to "file flags".
>

"file attributes" is better fit IMO considering the method name fileatte_*
and structs file_attr file_kattr and the comments in file_attr.c/fileatttr.=
h.

Thanks,
Amir.

