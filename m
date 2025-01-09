Return-Path: <linux-fsdevel+bounces-38700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7D8A06D3F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 05:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102E0167106
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 04:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81387214215;
	Thu,  9 Jan 2025 04:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvyV4Gzl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665C1213E9C;
	Thu,  9 Jan 2025 04:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736397920; cv=none; b=SdEVVe6v53ddSVy/2JC6prv+8PCGGPFbJtAJzWORHX/k/CGXS7TqZ2CnRTdsOlfX7swAkwo2Fgh5WrqzARiJfgrZS7ZAoQWSYGXpovjCv5nnaBkCqHPDvWzl2iqawAJWkQSMbfxNSqL4/M19yLSK5XVclATZq3VWTUJpwVM9cw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736397920; c=relaxed/simple;
	bh=nSHAqpaeL55t+KQuv4YP1Jx/OOQoCyeSozuPvJO0UGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WX5W6zO/8wEow8bIKTSGQ+lTc3CAodk417xKubW6oQ3B0Dd7bOv8e8qSDdzDnthryAvhqNJKhPPBO0OdABuOiYPEvBpArfFk9MZuTb7QnWkDJ6mUs6oOv11bf0UQ2XcCuU9W/N3dZoWktviGGzzXo46Bv7+awpvC68u4/2JKwgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvyV4Gzl; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86112ab1ad4so172879241.1;
        Wed, 08 Jan 2025 20:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736397918; x=1737002718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+pLbRNab+X25dZcesxCcSAu01oT+vC6rOwgG0kM9oo=;
        b=EvyV4GzlapibKczS1j3soTVENROn7g272vkMVg1IyDvq8l/9NsTHLTu5tvERoKtiaG
         b9B59WMj5QzYhVH/AAW91oW2ESGjwh6neKfjAOo34N76BsAWOAI9TFo8mdDhE3pdOhRe
         tGOgkhSJvzwc2tPv/6u0mhtpQW/+UKnUzAhSOV1W6RIJPI+6e1fH6bcyFob1C/CMYIjq
         MP1IiPwj8rOHjSSZq78zZ9xGPzWvNig/UczpdUIZx5SArfEj10Wrgno6fJ9zdFKaHTqg
         sOmiiPkm0KT8bS+uBscaowpmW2L0C7TelO5nGAZ0latn0SoIPaDLd49HpHjZou56CFcw
         +4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736397918; x=1737002718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+pLbRNab+X25dZcesxCcSAu01oT+vC6rOwgG0kM9oo=;
        b=jlxQkQS9wW6rz7Yo2lTktyrS1RT1FObSnXw44Leer4J8eAMWEZxqjhnVZRHRTiFGTB
         wY/lfMmZVCzIIBgzXSh62lyh5KXHtYIGnBaBEKpAGk1TwLIo7Z5LmqbIN++Jb03/Iv6k
         i00Y5dcnlyT1EDswg5rK1dCoIRw2Zzr1ehL5Xs+YM2J/gQFoOk+JJulw01vWk8YxKDBa
         j+l8ENXAAH/XC97pbB7P8QhqihA1DjSQlipOnoWrv1ersCyVyJpjHo2aKq/bsQEdzlQW
         IFUtO5HLZ2AKN5dMAMcI6DIcLpvLErW7ObKz9peQpy5qa+54PykPqXHONgDR6mQ/A3IY
         cVCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoj1vkEugH7eDvyOpOLwHkpX0Iwe0PZb5K7xzeYeQChArljVQdkCh0uG8Vi+WrsK5QgBNCFIBVJre6Sxkd@vger.kernel.org, AJvYcCWGyFlpT5KUSjSJVcbq8pEQ9i2ewRPtg/ZOXjggH7Gz9/DXs1cMaShPWrMVPqZiihNrbkkpH4BNYGIM@vger.kernel.org, AJvYcCXuFO3ZS1jZDda9TnRQ6B3Jretp1JvwZlzi5QhEkvLtIDAN37m6yiC2J3TJcjDdW8nHrHT++kVJ0Ba5C3MC@vger.kernel.org
X-Gm-Message-State: AOJu0YzZVmyHOrBGfjwUyqYit84W6fBfje57+MGb2CxcNvTJ15uYzume
	fBPQq6ti8LTapMw47siRG2xeQ4OxWyS/rAyEzN6I6vvM8gISxkatx5AVRR3ApllrPWgj7/WDrfL
	PLfDzHL10DwwNeEtH7KFcPDjXgvHWg8+urWg=
X-Gm-Gg: ASbGnct6K355ICePu0XcSZduSGxnBdrrrKfOj5VzwrCDiq2bagnqSjzmfxj6SOFXhs8
	RxalLIz8ft6iuxm1kEMhVMgn+GK+x6zZCfOxP
X-Google-Smtp-Source: AGHT+IEyEqP4iK66UHY0RU+4+VMD2kVQl+mi2JB4ubMNyyMT0kI8U5smX3qSQ6Lk9hbysjwVE5nzL7E7FnxWeoho7ak=
X-Received: by 2002:a05:6102:3a14:b0:4b2:bdf1:c1ba with SMTP id
 ada2fe7eead31-4b3d0dd87b1mr4842816137.13.1736397918266; Wed, 08 Jan 2025
 20:45:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109041253.2494374-1-marco.nelissen@gmail.com> <20250109043846.GJ1387004@frogsfrogsfrogs>
In-Reply-To: <20250109043846.GJ1387004@frogsfrogsfrogs>
From: Marco Nelissen <marco.nelissen@gmail.com>
Date: Wed, 8 Jan 2025 20:45:07 -0800
X-Gm-Features: AbW1kvZ6AjJLpCsYh-QNbVPAw_CnuBu6O3akgQuVSDTLCCWCvaBSuYTvQLQRXRA
Message-ID: <CAH2+hP6Rb6zXWcZ01epXOhD49os8F43=snE3pzCHX8+=Dzt1xg@mail.gmail.com>
Subject: Re: [PATCH] iomap: avoid avoid truncating 64-bit offset to 32 bits
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 8:38=E2=80=AFPM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Wed, Jan 08, 2025 at 08:11:50PM -0800, Marco Nelissen wrote:
> > on 32-bit kernels, iomap_write_delalloc_scan() was inadvertently using =
a
> > 32-bit position due to folio_next_index() returning an unsigned long.
> > This could lead to an infinite loop when writing to an xfs filesystem.
> >
> > Signed-off-by: Marco Nelissen <marco.nelissen@gmail.com>
> > ---
> >  fs/iomap/buffered-io.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 54dc27d92781..d303e6c8900c 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -1138,7 +1138,7 @@ static void iomap_write_delalloc_scan(struct inod=
e *inode,
> >                               start_byte, end_byte, iomap, punch);
> >
> >               /* move offset to start of next folio in range */
> > -             start_byte =3D folio_next_index(folio) << PAGE_SHIFT;
> > +             start_byte =3D folio_pos(folio) + folio_size(folio);
>
> eeek.  Yeah, I guess that would happen towards the upper end of the 16T
> range on 32-bit.

By "16T" do you mean 16 TeraByte? I'm able to reproduce the infinite loop
with files around 4 GB.

> I wonder if perhaps pagemap.h should have:
>
> static inline loff_t folio_next_pos(struct folio *folio)
> {
>         return folio_pos(folio) + folio_size(folio);
> }
>
> But I think this is the only place in the kernel that uses this
> construction?  So maybe not worth the fuss.
>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
>
> --D
>
> >               folio_unlock(folio);
> >               folio_put(folio);
> >       }
> > --
> > 2.39.5
> >

