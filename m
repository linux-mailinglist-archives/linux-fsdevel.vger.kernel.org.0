Return-Path: <linux-fsdevel+bounces-66917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D2DC3059B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 10:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6195E3AA205
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 09:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5E0313270;
	Tue,  4 Nov 2025 09:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rf3pNu0C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAB52C15BC
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 09:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762249551; cv=none; b=hFasBgX+hVB1x5GaHPAVcdz6MCNtOA7a6olXo2wsBvtaRWxAn+iXsvZdZlwiOTN5gj9qO5ac2plyz7tlr9EPHTu1hQOmZ7l5ydjlZf5H/uzzul966aqEkkDMnmIaxjB1QRX8qpyXeQT2jhKL7jaVtkCKgnLaDdrd8HD/r0UwBaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762249551; c=relaxed/simple;
	bh=Y/8kkJtUlvT/f8ywlYeX1B4ZoD/ySaLtnH0dGnqnmAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/tNgKhvFfUmRON/Ex31es2xqncIHBQkieHZRhaWV7hPnQNHSBKfLBBxvMNc8isRgFLzUIusZ/cDSmOn2qaI+UQyCEdGRxY3f1k91T45NdP5MJAs/tykcZ/feSyoW4f7Ilfu59XBW0MjGr3AtJSi/GiMRO46kRVUkZDR4ijqRMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rf3pNu0C; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63bea08a326so7583657a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 01:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762249547; x=1762854347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKJdWvkPbuojvyFkWrgOJDggLZVTca+r/oAisy+M4uA=;
        b=Rf3pNu0Cg1d48tOeaZtZaLUkE/PEszLIZCf1p0J0eQREPNueGK+mEQ6TOQwKX0fevP
         DG7Bf49VqBKXjMXfX+cxHFvoOdj0HEyx787WuG/kGgy0ZKASykSskdCNsJbQakDLDfmB
         t87jC0FfJaGK2EkHbJ2skXAhafGEtVnaWmFwNihX/9k+M/WkZkLc1S7n6MArxGDLViHA
         mxPiF89Dk7LQiqHnGfCi3TdkBqKIDuUcIWubluYRrUL9svX3Pgcse/je3swjxwnN1W1E
         gUlOLs/2RRZquqbAd/Rto2820kkWJatdFt7IFS0sjW6lP07/tMpw3G0PdkY6g5ulk8uB
         zzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762249547; x=1762854347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xKJdWvkPbuojvyFkWrgOJDggLZVTca+r/oAisy+M4uA=;
        b=QTnWtSRo1tXr8ghSMkMeohT9+07hc04cr6lvCt1VX7OJNqVGTMTdESrnvZTUs24Qwr
         O7nfE9SOfsPyhDfgcV2wKLdKS+dCiSmV0YisVDtGHsqDqq1YqhmMrcaHW/uvN9Y8r6LB
         she1c7nYTOeyNoFxXTSjHfTgX8nUj1U0NJBe0rQvvw+jWa7qTrjGAg2QXAiVYvndQWBH
         nSLxg4yc9VoVuwl7fuYZGGzTyZoo1fEwfNZbYejzEjaAtzzWFzD8i0kT/Ve5jBUdj+fq
         uicJmlAScH/kuMyoC8QWvxq7Id+ecosGUXwc3iubNQxXL4y0Bgd/hFYGr595pO1NOapH
         3yOg==
X-Forwarded-Encrypted: i=1; AJvYcCWBwMeDUsg/KZmH7lAn2qTSFcw8GIAGgiho8PFK0yELjigLY9o40HcmqpGBrl4Cv+zKfN3kwmkKOwf2EWfd@vger.kernel.org
X-Gm-Message-State: AOJu0YzbsxH0opOqWOq0t1vJHZm8JtcU0gz/QgWsbDWPekhM94Rbm4G0
	gI7G9S3t8wSj0otrxxkqZbPktG4QVXp6xuTdZadJ2UM6sPMNkGFtN+4Yx3hN8Geb8GZcxd1b9Vx
	wV9fHwUuYXgqH5jL13SgSjaJbaevXXF0=
X-Gm-Gg: ASbGncsbROPum6xrVhLyJ9tJSAKMUUhbvb6CgE3KBH7PWVUfU7XPZ5wJelR1nkzHZJz
	pDpYg0JWxzAQHeubHqLXRBY3ftJKty37lYCsp1SKv5IPojJZE7bphjfTNgcwj25b491TTIaDcE3
	4fUtZUywr/ynZ+/I7fdqKpicph+kd/SMXQHXIcZvcge0jBjqO4PTeEcgcWhcLsxsKCnR+YLcogn
	aQGbvsXg/BTO/W+KDlcpS5FmtqyMvyFDmYj3i1IL/tEu0N05KdVogj0kC/f0jMssv2b0Abc8Pif
	E9Tz2z2p+Y8UAF84N0s=
X-Google-Smtp-Source: AGHT+IHXA2qJBi6f10DqUtNaDt/G9hT+Ey8B/WnoFdz3Hmrh6KCUpLdIDtROPfgXbvSfxz+h0BRwI+TkCKOqKrtbbyk=
X-Received: by 2002:a05:6402:1462:b0:640:ea21:8bfd with SMTP id
 4fb4d7f45d1cf-640ea219598mr1427481a12.31.1762249547237; Tue, 04 Nov 2025
 01:45:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
 <20251103-work-creds-guards-simple-v1-14-a3e156839e7f@kernel.org> <CAHk-=wiSmez2LFEpM05VUX=_GKJC8Ag68TJDByVPO=x4QwjyuA@mail.gmail.com>
In-Reply-To: <CAHk-=wiSmez2LFEpM05VUX=_GKJC8Ag68TJDByVPO=x4QwjyuA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 4 Nov 2025 10:45:36 +0100
X-Gm-Features: AWmQ_bn9rw0ha0qFFSykU1xP6jfkkEMSMAVkMSHJG30ZX97XNHwd3yxbJVnihQI
Message-ID: <CAOQ4uxhw2Tc4YXwhkS=5EVC3Tg4F+QyrA7LE3V29pNhQ4WJeyA@mail.gmail.com>
Subject: Re: [PATCH 14/16] act: use credential guards in acct_write_process()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-aio@kvack.org, 
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 12:04=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 3 Nov 2025 at 20:27, Christian Brauner <brauner@kernel.org> wrote=
:
> >
> >         /* Perform file operations on behalf of whoever enabled account=
ing */
> > -       cred =3D override_creds(file->f_cred);
> > -
> > +       with_creds(file->f_cred);
>
> I'd almost prefer if we *only* did "scoped_with_creds()" and didn't
> have this version at all.
>
> Most of the cases want that anyway, and the couple of plain
> "with_creds()" cases look like they would only be cleaned up by making
> the cred scoping more explicit.
>
> What do you think?

I had a similar reaction but for another reason.

The 'with' lingo reminds me of python with statement (e.g.
with open_file('example.txt', 'w') as file:), which implies a scope.
So in my head I am reading "with_creds" as with_creds_do.

Add to that the dubious practice (IMO) of scoped statements
without an explicit {} scope and this can become a source of
human brainos, but maybe the only problematic brain is mine..

Thanks,
Amir.

