Return-Path: <linux-fsdevel+bounces-50405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB250ACBEAA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 05:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4DF3170F90
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 03:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9044F17A2E8;
	Tue,  3 Jun 2025 03:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQALsrLF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712D5145B3F;
	Tue,  3 Jun 2025 03:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748919860; cv=none; b=RjELgkEw38vZ7QGFCzjcO9gVohSdXJZfXfB2JCMk/FsGxS/h6zqjoAenRZ7VNUH4Bp/AMip+rJ3Lm8fcFh8KK/CbSZ7Pk8nOhm29y/s7SO9Fpgdg7ZZwlmsjM7E918EhovL1rf2VNRnqTXHS+IO1aTVEF1qAwi8rpRvBQU09rYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748919860; c=relaxed/simple;
	bh=rJC9ZpcSornVLCggFCzM082UaM5dPxxCspqU7a+anWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIq1ifMefEQ52cDTQnLvSXcz/JpR9d1H0daTUsFMvDCElL2jVOGo2OxetpK8OyZY4g+jHymLGDkWqPXsUpsZBMFomMqtKrvP2tFueny0lvNmeSIiLBumJZgnL/ne9zEp+ClR8EEbeTonyMtJ2fR7hvtiIxN0d1XHB1GwoPcIyPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQALsrLF; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6fad3400ea3so34067706d6.0;
        Mon, 02 Jun 2025 20:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748919856; x=1749524656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpRZNQFZym4S4gg1B2+EBb2IMaw0D9ntMnCImoepOMk=;
        b=VQALsrLFiwE5AMU09kW7g+i14tIozcM3N2a+U3KT2ySwwkBVDBRI8+kiITNDeyZQP4
         EVyti0YhEudh9H9q2QkNjUUldGgX6/l/Lk0eMSJ7Wj+3bUsJ8ATBCLo2yTBUEip641h4
         yA5T+hE15PPduJJSQ082I9neU3643s3wlEsrVblWoZGmjJeNiAfXPe9hPYRZxasDK2Ho
         sMRcTdUoCm4/cr9OlZbcPPhXiOgFExE3TyQFSuQ+YLOBaefn38LT0OsrS0w3NQIsOdji
         HbZPUlcnEDTNFr9Kd/bP1p7cbaDAJ2WRhOm1LCu5nGBr2auYeZ3U+44NlAZyEper00+2
         GqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748919856; x=1749524656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QpRZNQFZym4S4gg1B2+EBb2IMaw0D9ntMnCImoepOMk=;
        b=hThugQ0vc21YlVlqbrdsDctAySN0Yv+rk42JaJfVM8u39ZsHFKoeHIJTk0M75EXw8X
         7pgQVF0+LWvcbHGoaqwATzodpYKSPFDKOwHfBNjbnnrS7LHShe4NSt5a/sUUxfLCPTX2
         hqZajzc6XX7nuOjceb33/2AMhodOdK+1GvFdj9TMH8gn82DqnWm7Jg7H6D04Vxey4QEl
         050GfMuVf6wQnzKbupw6f/8MksJmnkkZa+xVmCat/GXhBWk7Cpx/itW3pjeXJAHMutkT
         GhJZa6ij6102fUdygupFfslV3b9pNW1ecMcqfwo9csvmuoJ5RrSclNW/HxObHbLse83G
         G4EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgT6uTR8PpKdnkuUJFXFDwXuYlNpPGGtBHwjGWhjqPIXsIy8rd0DgW/qbvmw4LFAwkDZWS4SoJJHQ0h7gq@vger.kernel.org, AJvYcCWCQuAYWf1snyatlg/5VhcG2ocFErgToHfeSOssA1HHw4rAvwsEfD9Q7mHgbXaErmzIgu5Vp1tgRUvh@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhc5uDPjmS8wNsPBt3T7OyTAWel6rrDqLE+q978OFmu8H6pXef
	qRO3lyEhm0dcOHv+ekvMreYjABy/VhSQzdXYFoAanA9u4EiOtHEmWnDdlAC7U0Zw0IiG5wBDqjh
	BAPKROgR90W6n5lGIk1c7xH8imPD0fq0=
X-Gm-Gg: ASbGnctaY+UmV0HBqvV/EcGUvdiGkdkHFvZFaev7s/U+lY1CnkvcvVtOu3bt/UbWJss
	9KlhGgU1bRZ3k1vKe4GlXNFMywdl8hx+0EKV90eMY/udmi+QdQB5cujvi8m0yQjinNUDsqE5MNf
	FVN3kDCL789UBJOLrWth7/7HXXQSSS+QheHA==
X-Google-Smtp-Source: AGHT+IFT4VMT6vYGWvT9b5VIsvF4CJIld8vst9G+vmcGcbiqRlTXxMgZoiyswyfgCuWyJykx7WoP4ZvWmlrLSJ9t+h8=
X-Received: by 2002:a05:6214:3003:b0:6fa:c99a:cdba with SMTP id
 6a1803df08f44-6facebb25fdmr252539566d6.14.1748919856185; Mon, 02 Jun 2025
 20:04:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALOAHbDm7-byF8DCg1JH5rb4Yi8FBtrsicojrPvYq8AND=e6hQ@mail.gmail.com>
 <aD03HeZWLJihqikU@infradead.org>
In-Reply-To: <aD03HeZWLJihqikU@infradead.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 3 Jun 2025 11:03:40 +0800
X-Gm-Features: AX0GCFvRdse-7lwB_QEw2zKg5POM6p_a4OtRY81QPPDNLfInGJtXqbxfsLf36So
Message-ID: <CALOAHbDxgvY7Aozf8H9H2OBedcU1efYBQiEvxMg6pj1+arPETQ@mail.gmail.com>
Subject: Re: [QUESTION] xfs, iomap: Handle writeback errors to prevent silent
 data corruption
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, djwong@kernel.org, cem@kernel.org, 
	linux-xfs@vger.kernel.org, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 1:31=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Thu, May 29, 2025 at 10:50:01AM +0800, Yafang Shao wrote:
> > Instead, we propose introducing configurable options to notify users
> > of writeback errors immediately and prevent further operations on
> > affected files or disks. Possible solutions include:
> >
> > - Option A: Immediately shut down the filesystem upon writeback errors.
> > - Option B: Mark the affected file as inaccessible if a writeback error=
 occurs.
> >
> > These options could be controlled via mount options or sysfs
> > configurations. Both solutions would be preferable to silently
> > returning corrupted data, as they ensure users are aware of disk
> > issues and can take corrective action.
>
> I think option A is the only sane one as there is no way to
> actually get this data to disk.  Do you have a use case for option B?

We want to preserve disk functionality despite a few bad sectors. The
option A  fails by declaring the entire disk unusable upon
encountering bad blocks=E2=80=94an overly restrictive policy that wastes
healthy storage capacity.

--=20
Regards
Yafang

