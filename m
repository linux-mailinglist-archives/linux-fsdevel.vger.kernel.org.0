Return-Path: <linux-fsdevel+bounces-51524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CF4AD7DA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 23:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C5116EE13
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 21:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1CC22F177;
	Thu, 12 Jun 2025 21:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DL7O3x6g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693FA222593;
	Thu, 12 Jun 2025 21:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749764125; cv=none; b=CN6SHC1fWl0xweeeT03YzT3q/vJJtn9aPtMpqr510XDjJmQ7G/2d/04MsELxBAJeFFYdTMMCXptCf86b8fdrNq+a786lI8SokxeaaHI0tvkuundf6kTogZpn8e5ppnTg2HCkXpq7lQX5OVza8XUrkme6kJ5dJ195uShE//AujqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749764125; c=relaxed/simple;
	bh=DaVgg2Lko9pJWN/Pq4ZYoPZXaoSkQRqFYF0sn4s+0GQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yq48MtkbEZmeilxR+96OB+ZrUK+kcsrxEvB/F8mhVrZsVOlH3HNPw4zT/Swu5PXYebAgi307V6RLpPUvQOI6JcyhxJJkSIoLMSjmNYYXVd2sQ8s1ofiJxAQU9kBuGqDY6KcL31nLMWGTuhKIh4b97o2HdjzWE8a6KQ5Y45AVGoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DL7O3x6g; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ade5a0442dfso256921466b.1;
        Thu, 12 Jun 2025 14:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749764122; x=1750368922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U64NIYxZAHoKvybyVDEGdhPIhQljA4Nf7uiGkJOAi7o=;
        b=DL7O3x6gOXE10rwRPARDlrdnlQ+0e5hn/G3Dg9Usbd3KQM9jelvppwxK1RhSp+3ofi
         iUCHghjavY31psZ+SBTLJ4twS1QFetvVipiXPVInegd54IoZdkE01D5PAeTEUMh2xbyc
         8/ZFJW4I5go3wzRUXY9u2HRFa59W5bZvxuI9QH78r0eRWpuME2WmFxhZ5ojtpi1owUCZ
         C9RVQe4y5EQn0lWrt15DFh0xXUVi15XlZ5Jk6eifl2+rnkiDcPKkPFy2UvE9n+QsAsZw
         BMJpYjdD3n6fhC6K8wN0xPrvsN5m/riCkATLcFgMMfjJUQgJiBHqdLHne+9Am41fXb9M
         p0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749764122; x=1750368922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U64NIYxZAHoKvybyVDEGdhPIhQljA4Nf7uiGkJOAi7o=;
        b=ZQxo9owJR/d4RIUIRhO2KRMsruxjTArYN5HVQn6KO2eBq9wUn4uFx9/gwj4OYxBZk5
         rduwUApFiyaxRRrnMZ3iK4OLOEdZ/ad1IBpjquWfSQ0LA8jTlfBLQQQGVrn+T7O+E5wP
         EAZQjJIATWRXSKNah2E8uSfMY54LuXwHcUSAfOxJgclfStraVHnWRqEcR9jnW8Tix7C9
         R7e32XKL0ac/N6TVUCPJtRJCKtcJEoFR9D+aDC8Vr3QG7DsqamvL0j1LtXXmJuAMjX2w
         3v98JWR8xMEOjXj6VkyPU14JvWYT8Co55ZrJx6P6hZ2jCRijFpu7l/Cc7fNYzhvKY1FS
         svoA==
X-Forwarded-Encrypted: i=1; AJvYcCW7NXfguWQ7M76gKlov+85UmXnDs34xdw+CL/6TcfXH+DpM2iaW0YsYl5ZYKVg2RrKogIOcQyVyi2eTe31I@vger.kernel.org, AJvYcCXUzRjrDuQ7enhj47skTAzNgIqhe85QY935Hnl4N4eZMaFtsTYfH4BmDbexZKVmxaavsq3AtsLuJfIhlotQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwNll6UF9gHYSmo1G7Lv/90mYr3Q7NFTzuo76Lyvp/iYe2iqjHm
	1+QeFHwd91JR+ZztjKAa8z9gIwhwUUcVEW+GAgIrhChgXm0lpZ1NU8T0yyh+A5ZWoYOgIHZW+66
	p4GdCVNM8WP+7gte54s6P9gQuWBPo3os=
X-Gm-Gg: ASbGnct7fbaa3G7+NiIJ+uP6CRlOhtSKZz+KJj7eVXE+brKvYXuuX6D+21FIvXpwN5/
	cA8M2zAOnyl+iGhgPhOgzXEl2Reln438pStUSIyqD/+5c47KFJwmV9JKcrgUJV0TLTVFwFWVdh2
	5njXkHzIg/UplbfzuWLd2WSz8w2Ajx3MRSNcYWOG0DSk5apJTpGQEAtA==
X-Google-Smtp-Source: AGHT+IGAh5CXGLnB0+4nshGnpjYSCoAxvi4IqYvAk+gL1DuSLwbBz121eoMWGcXT4V68Oyl6b8AN/PmiumL3WBt+6Uo=
X-Received: by 2002:a17:907:3d89:b0:ad4:8ec1:8fcf with SMTP id
 a640c23a62f3a-adec5d6e539mr64500466b.46.1749764121567; Thu, 12 Jun 2025
 14:35:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87tt4u4p4h.fsf@igalia.com> <20250612094101.6003-1-luis@igalia.com>
 <ybfhcrgmiwlsa4elkag6fuibfnniep76n43xzopxpe645vy4zr@fth26jirachp>
 <3gvuqzzyhiz5is42h4rbvqx43q4axmo7ehubomijvbr5k25xgb@pwjvfuttjegk> <87v7p06dgv.fsf@igalia.com>
In-Reply-To: <87v7p06dgv.fsf@igalia.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 12 Jun 2025 23:35:09 +0200
X-Gm-Features: AX0GCFszNtcqxTBZPog6tjA6GGCRtIySoRGpQGKlku8OcwQC1PnTLTiH8OmDtzc
Message-ID: <CAGudoHGfa28YwprFpTOd6JnuQ7KAP=j36et=u5VrEhTek0HFtQ@mail.gmail.com>
Subject: Re: [PATCH] fs: drop assert in file_seek_cur_needs_f_lock
To: Luis Henriques <luis@igalia.com>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 8:07=E2=80=AFPM Luis Henriques <luis@igalia.com> wr=
ote:
> > I guess the commit message could be improved. Something like:
> >
> > The assert in function file_seek_cur_needs_f_lock() can be triggered ve=
ry
> > easily because there are many users of vfs_llseek() (such as overlayfs)
> > that do their custom locking around llseek instead of relying on
> > fdget_pos(). Just drop the overzealous assertion.
>
> Thanks, makes more sense.
>
> Christian, do you prefer me to resend the patch or is it easier for you t=
o
> just amend the commit?  (Though, to be fair, the authorship could also be
> changed as I mostly reported the issue and tested!)
>

How about leaving a trace in the code.

For example a comment of this sort in place of the assert:
Note that we are not guaranteed to be called after fdget_pos() on this
file obj, in which case the caller is expected to provide the
appropriate locking.

I find it fishy af that a rando fs is playing games with the file obj
*and* the fact that games are played is not assertable, but at least
people can be warned.
--=20
Mateusz Guzik <mjguzik gmail.com>

