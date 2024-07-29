Return-Path: <linux-fsdevel+bounces-24441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B07C593F4C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 14:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649421F22F20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 12:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061BD146A8C;
	Mon, 29 Jul 2024 12:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTUFeiBz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B9D148FEE;
	Mon, 29 Jul 2024 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722254441; cv=none; b=hvrozbuqfPSySyMbJP2Bj03QxKozgwZztTo7Bvv44xH99Z4qbmvtXCiZ3sOuXT3kukW9YO42lJVuzfz9BmRdrbWsS77M3duaee1ZHQZ+RlGCz1NmLm26L1NWoWQDgNrwnxu7VPRvdqTXQJG3QgyEMNuuPX5rp8S7JoGxT4gQyJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722254441; c=relaxed/simple;
	bh=ibQXUDIffd3oax0fuZ/yWOPgVC0MfAU8xE5n0zefA04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+y1jGt1adunqpE5lnVgXtJEsWf9EO33C709e1rIna3hkw07B+cqJHrOt7Nm9HBJhUjS4U4OtSD3xViqIlm2U5ljQiBLmzBx6D7n10K4NZFhx3ExrNb9tOYNZVvtF709DXW+EyjZPI77UOYF4aumavGwp35zlvFUV107NzoPNfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTUFeiBz; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7d50edd130so171345366b.3;
        Mon, 29 Jul 2024 05:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722254438; x=1722859238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRlgb0pbBLQr/o0951YHvjNQKapVUDDOn8VLFV+A3D4=;
        b=cTUFeiBz39D8oSIDxvYGud1DlE/zxTnZzP8iUy+k7shDZst1zGteRu51Qn4UMgqxCR
         lxHIx1rtWycKrQUPv3s9OqXA3VET8a7LUL84agBQGez0GKTuFHAJ3uG58sV+b5ioZPKi
         9Q4JI3R3YtSsfT+TjI1VUtBgjw+P6yKgk3yJlG8DIDHQWxDzmbmJbfXxbQosN4SIIQOb
         xTW7+QS0gPGuNWitT/56Q3A8fEGJHNjqsLkqqYqHRTnknCcJZYeaUu1Vaios/WjLNCIh
         FztdyFBETzrSIUeJQMtWSrNusZ31L9M6D3mjjLtHzYxMX5Vwmv8koskiAHxbnBBaWdHc
         SGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722254438; x=1722859238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRlgb0pbBLQr/o0951YHvjNQKapVUDDOn8VLFV+A3D4=;
        b=PLaOwUAeDYA3VoyFcVu64o1rlhimYmkNGV5QvfzAKEs0jcMe4Tf180grCjiyfgzYE2
         s8Vk/UQE2HGNUvlweayk9SPp2f+Hye1ggJnKuhSQPmPvsVpU1qVZ02Tlx5DP2IQEEj6K
         eYmp0f4+NCVGCxsZheE+J8xby7obSqvzNMXBWELX3eE8EQzbXfYj6cmj85Nqv0Syr9YN
         RtbzdmgECBS+WgJZ1rvcj9komb/J7cEc6EVgnM4e4bwaecpvPJSVHsXIKl8irpOzg9EX
         Sm9mrjst1qL1CambXPBLq73V5b1ImxtTtmTjHZOflIaI6QLe2AIMz7l78fEqdWpxjR2l
         H2gg==
X-Forwarded-Encrypted: i=1; AJvYcCWmXnAE5ZYa/iBDv2ZETor2q+qZwbXJQZCHd1T4T4ANBsJA612AsJNUdC/osMgsSrIDWujtxm1svi3QDqNaKTDvldJ5dbs/2uiX1Bx+XTt6X0aO1w67J/U8GaczKgN6eP72g5j40xPv
X-Gm-Message-State: AOJu0YyvVAuABv25dJSkvvzE66MA4VxYDgnhh2gXx7gPpnGj2QQfPSXg
	jYpg1pEfNB+hVKhSIqPlZ3BCwaD+frTsQMB0yQHK73h9Ct3j+8ZwTwC+aa2mOCbGDSIbx22W0cC
	gZsPp77IrnrO/7ZzqpiuLPbxif+U=
X-Google-Smtp-Source: AGHT+IE4X+E9pS3yBhIg44yhiX0fEbUxFduAm9eUrb+W5DV053afWSiONWSrLC5n2TOAj7siJ1P3PG4wZ7H86bbhM/0=
X-Received: by 2002:a17:907:94cb:b0:a77:cacf:58b5 with SMTP id
 a640c23a62f3a-a7d3ffc0597mr579287666b.1.1722254438054; Mon, 29 Jul 2024
 05:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <874j88sn4d.fsf@oldenburg.str.redhat.com> <ghqndyn4x7ujxvybbwet5vxiahus4zey6nkfsv6he3d4en6ehu@bq5s23lstzor>
 <875xsoqy58.fsf@oldenburg.str.redhat.com> <vmjtzzz7sxctmf7qrf6mw5hdd653elsi423joiiusahei22bft@quvxy4kajtxt>
 <87sevspit1.fsf@oldenburg.str.redhat.com> <CAGudoHEBNRE+78n=WEY=Z0ZCnLmDFadisR-K2ah4SUO6uSm4TA@mail.gmail.com>
 <87cymwpgys.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87cymwpgys.fsf@oldenburg.str.redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 29 Jul 2024 14:00:26 +0200
Message-ID: <CAGudoHHwaRuJH1dGQpwF4fhcAYHzbqr+oEKsEnwcY0_1p-CdSA@mail.gmail.com>
Subject: Re: Testing if two open descriptors refer to the same inode
To: Florian Weimer <fweimer@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, Dave Chinner <dchinner@redhat.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 1:37=E2=80=AFPM Florian Weimer <fweimer@redhat.com>=
 wrote:
>
> * Mateusz Guzik:
>
> > On Mon, Jul 29, 2024 at 12:57=E2=80=AFPM Florian Weimer <fweimer@redhat=
.com> wrote:
> >>
> >> * Mateusz Guzik:
> >>
> >> > On Mon, Jul 29, 2024 at 12:40:35PM +0200, Florian Weimer wrote:
> >> >> * Mateusz Guzik:
> >> >>
> >> >> > On Mon, Jul 29, 2024 at 08:55:46AM +0200, Florian Weimer wrote:
> >> >> >> It was pointed out to me that inode numbers on Linux are no long=
er
> >> >> >> expected to be unique per file system, even for local file syste=
ms.
> >> >> >
> >> >> > I don't know if I'm parsing this correctly.
> >> >> >
> >> >> > Are you claiming on-disk inode numbers are not guaranteed unique =
per
> >> >> > filesystem? It sounds like utter breakage, with capital 'f'.
> >> >>
> >> >> Yes, POSIX semantics and traditional Linux semantics for POSIX-like
> >> >> local file systems are different.
> >> >
> >> > Can you link me some threads about this?
> >>
> >> Sorry, it was an internal thread.  It's supposed to be common knowledg=
e
> >> among Linux file system developers.  Aleksa referenced LSF/MM
> >> discussions.
> >>
> >
> > So much for open development :-P
>
> I found this pretty quickly, so it does seem widely known:
>
>   [LSF TOPIC] statx extensions for subvol/snapshot filesystems & more
>   <https://lore.kernel.org/linux-fsdevel/2uvhm6gweyl7iyyp2xpfryvcu2g3pada=
gaeqcbiavjyiis6prl@yjm725bizncq/>
>

Huh, thanks.

> >> It's certainly much easier to use than name_to_handle_at, so it looks
> >> like a useful option to have.
> >>
> >> Could we return a three-way comparison result for sorting?  Or would
> >> that expose too much about kernel pointer values?
> >>
> >
> > As is this would sort by inode *address* which I don't believe is of
> > any use -- the order has to be assumed arbitrary.
>
> Doesn't the order remain valid while the files remain open?  Anything
> else doesn't seem reasonable to expect anyway.
>

They will indeed remain stable in that setting, I am saying ordering
may be different after a reboot or if there was some memory
reclamation going on between restarts of the program.

This is quite a difference from dev + ino combo not suffering these problem=
s.

That is to say I don't see what is the benefit of having the kernel
provide a way to sort inodes in a way which can give different
results.


--
Mateusz Guzik <mjguzik gmail.com>

