Return-Path: <linux-fsdevel+bounces-48879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5EFAB52FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39219980961
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7027E269CE4;
	Tue, 13 May 2025 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="B08nJbjs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0AB242D6E
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 10:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747131699; cv=none; b=RxDFpYlJoL47rugFbbB3n3RJ6RnTld+IdtuldVm21cfAc0W78g6numA9KiP/MRLRm/ja5FNTnQo7mSohQf0yXG5Ioa+e5QWd9Cb9LIkZZbE4Y/6HmLoDPnOMsS3pBF8pv/OdMrDfuCMMkOjkcDqRmrT+LpuB6j1zEzCdAlfmEVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747131699; c=relaxed/simple;
	bh=uo6sikQ90JLjDt9LoE8CNq7gYR0r4sO/g5BwP0JQBLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ucnwJBh3P/SNa9AzSAwf+0YBdmewbAnzBp9zD9jzcl27iovXUR3RnnlALk5alIU+y0sJqD3UBEbyvBnAK7MRnGiXbd+KM2v8UdsBJgaPugc4UQpZSZymPH+denbc3ZDaj3a/6fvbIG8Uv9PotpWAQCYh4ZOxJrhL+mNcCY7qsYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=B08nJbjs; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-476a720e806so54351191cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 03:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1747131697; x=1747736497; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=akogY4u8fpMpFlnu0p9r6p93p9Oe7TvvKpAoxGX77gw=;
        b=B08nJbjsq8ztvqaUA9V0wlnU9uDbDP/Y3mZ0tBwvWwpqezOAkFhk3M5gV4IP4UsaHh
         iaHNGTiP8esVjJzy6zXfdd5NHHXUECU7r6goOY3JNa84q8Vp3FKAhOs1mHUmL4HsN1Sv
         1NZSBiUqpCYuOSfhdbdnzyCklZPk9ool+LYFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747131697; x=1747736497;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=akogY4u8fpMpFlnu0p9r6p93p9Oe7TvvKpAoxGX77gw=;
        b=h0mpFwd3cG9jL4/L5O5Nuh7KSETJxf15+iDoAoHwytHKJPyWO5AMBEju6TnnFHGxKr
         2CXlwgYDtJYuh7z3VRpdtEzAP3g2FAt/V3mn2dsZY0KL08NogD8T1Wo/QqJqxSCoV7D2
         vOiU+lgAIMtwLEhea2eWUuxGf0xhOxG8AeetAzgxyfKzPEOUlCfaDLJazfdTzNZwyobR
         VkipM41EmtprGZ35XPbLuu3FyHI5nLl8cqdQ20TdTqu2PJqP9QxPdnORnljOt5wJYH70
         bO9D35IgL2B/JLgAukdlJB6yNTym9euMYm3+ACj0VaST9jwgHwV1ALV1HEa6RomZQKSy
         1YAA==
X-Gm-Message-State: AOJu0Yx9q3xr5GHKwgt3cee6V29AyX917astYeRAHWvytVuj/S0gtOS9
	OjVgB93O5Npno7DAXigI5+zLIKAfQBFAzZrZnkLgA8Bp/XnC4svIJ2lDYuNW3sPDc2zXsETZJDq
	4G46PD1Orn+uYaumfmZLhP0IXRcYc7Pjiivo0BQ==
X-Gm-Gg: ASbGncuahx0xXls9eWymRaB7SloIxng4DMXvEEPtrmHntQiWjSE6yJE6KhcG18sNzbR
	Q7EudgOKu+l40y1/qOidnp3NV0+5enB9Zu6W2IlRNZwL4QuxVzZR48Uawid1RiikKKMlLuFuOeX
	ybNOFdXOvTforIIODNIfH8FLKqsDJ172A=
X-Google-Smtp-Source: AGHT+IFnx03yzoSoSCakDSaDT/SEK12wKpk6KQVl5SmdFBdKXZJZq0J3P6FL5eWVgT7Y5HRoXc/wleQYD6vcUSaf6MA=
X-Received: by 2002:a05:622a:111:b0:48c:5c4d:68e7 with SMTP id
 d75a77b69052e-49452714663mr255244981cf.6.1747131696957; Tue, 13 May 2025
 03:21:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOYeF9V_n93OEF_uf0Gwtd=+da0ReX8N2aaT6RfEJ9DPvs8O2w@mail.gmail.com>
In-Reply-To: <CAOYeF9V_n93OEF_uf0Gwtd=+da0ReX8N2aaT6RfEJ9DPvs8O2w@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 13 May 2025 12:21:26 +0200
X-Gm-Features: AX0GCFuobM9luQPkJkZUFix2k_vJSztggNR0iL9O6I4usKIOzsxea0VrWY0e5_o
Message-ID: <CAJfpegtdy7BYUpt795vGKFDHfRpyPVhqrL=gbQzauTvNawrZyw@mail.gmail.com>
Subject: Re: Request for clarification about FILESYSTEM_MAX_STACK_DEPTH
To: Allison Karlitskaya <lis@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 May 2025 at 23:02, Allison Karlitskaya <lis@redhat.com> wrote:
>
> hi,
>
> Here's another "would be nice to have this on the record" sort of
> thing that I haven't been able to find any other public statements
> about.
>
> FILESYSTEM_MAX_STACK_DEPTH is defined in a non-public header as 2.  As
> far as I can tell, there's no way to query the limit out of a running
> kernel, and there's no indication if this value might ever be
> increased.  Hopefully it won't be decreased.
>
> I'm trying to write a userspace binding layer for supporting
> passthrough fds in fuse and it's hard to validate user input for the
> stacking depth parameter.  libfuse hardcodes some constant values (0,
> 1) that the user might choose, but in an adjacent comment makes
> references to the "current" kernel, suggesting that it might change at
> some point.  It's also sort of difficult to determine if a value is
> valid by probing: choosing an invalid value simply disables
> passthrough fd support, which you won't find out about until you
> actually go and try to create a passthrough fd, at which point it
> fails with EPERM (but which can also happen for many other reasons).
>
> So, I guess:
>  - will 2 ever change?

It will never be smaller than 2, that's guaranteed.  I think there's a
good chance of increasing this in the future if there's use case for
it.

>  - if so, can we add some sort of API to get the current value?

Yes.

Thanks,
Miklos

