Return-Path: <linux-fsdevel+bounces-50858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E580AD0722
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 19:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6130C3AAC36
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 17:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A750228A1CE;
	Fri,  6 Jun 2025 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtsMTZx1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F311C78F32;
	Fri,  6 Jun 2025 17:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749229299; cv=none; b=Kr1XhJguiQ0BH3CGGw/sNrZnz63uG9dlD4YV7UErj7CQMBaG1/4pZhUn0gJFCjCOLnvhLshA55wY1jL4Ilabhy17XyxSOAZwlpeXbLBS/mk8KVhwpDRnw2SB6u7nmQzYMpkYoMyNqwHji8duihZ5k/aoNz++jXVpnNq9LQbMXAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749229299; c=relaxed/simple;
	bh=zT4sKuFfw4xqA2QcApAwj6XA/t5bPgFmkMq4rQo7XSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5K1ow2rLtwKr4A7psDOO8i80ikNfGi+fdvUuE96FlQp4FMw1Rcc67qLwlRokELa6LY1noAlE/VZTTyU35yo+eXgaRCzm3bp4uPMyQcz2r+Uz7wlXVm3jZah3aLZUZFq6TOYy0efbA0804OV7aZ3et3GqJKtAPNvZ8Mxb4fW+xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtsMTZx1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73409C4CEF3;
	Fri,  6 Jun 2025 17:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749229298;
	bh=zT4sKuFfw4xqA2QcApAwj6XA/t5bPgFmkMq4rQo7XSs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gtsMTZx1yWC/tSkVqaOgwFKGuQ98lnIMb532AjF6hx/O739rjGGGwIw44DbqR8Std
	 AjacvuXrKDIQqXRtuK6/t1lR1i76dLmSgUYS4SLBFMHbUxGN5DKfG6WVw3ENVPt4Pn
	 PUNJb/Q5ytdz5Uizj2kw0aZVxDemf0NyUKxuH2potcyyHefSMwaQN7VD6QyeK80ubn
	 hNfIfA0/x9S+vzp5s/gysWImrg5i4mK9J6eApn6tAhvOJodIAv33StZLETCvJNBfez
	 vQReMHkym5yqbnS9zpRezAhcACxvY3saQhzj6Fn0KMUmcotgAIZQcPX0cFhUVpCD1J
	 KpdhohDVcALzg==
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c5f720c717so376558385a.0;
        Fri, 06 Jun 2025 10:01:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1Zr7RvGKtegjnFt3FOBQFdEZJlD8Vet4j1rQDSze7w+wY++nms/twdD3zTGGBDw+/ai1T8lZ95SPnmpCKvyLpWdY9uuT8@vger.kernel.org, AJvYcCWx1hJaOOZxAyUFo7SEJ6z1arP9iG/sd1vEg0f+36ZRvfWVCwA0GM9Ftr7G/de/SeAWXnFCik5vx1TrEnNc@vger.kernel.org, AJvYcCX38rwhCz0+rHH0EYqecoHQ92YL3GOM1i5DaeeQLpDat0PQku4Nlm0rwrM4RTcy6+3rS6PT3gzV6ECH1MIv@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr+SMWLuzZDtujfZlPGA0NUXHry1iFuy+YtsG7MxNsZkTGL6Jd
	jPTZXnlZG8/wgnVPdZtH+YM92M7vDECZlVvZBBhgTaFmKlC0p24870u2RoTZ1/cEVvrMHKjHsRJ
	UVG3HWx4yp4ZTvLFaq7cvdeF6zMx7wzk=
X-Google-Smtp-Source: AGHT+IGUP8KmwWsyJVkbFL3ChhSRLJM0hfwN3udKweQ31QmMpDI2+5lcOPPfybMB/iI0kyV9jSgunDkpQrwkzvMsC6c=
X-Received: by 2002:a05:6214:1d07:b0:6fa:a4b7:c664 with SMTP id
 6a1803df08f44-6fb09c63bd2mr51564626d6.22.1749229297515; Fri, 06 Jun 2025
 10:01:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603065920.3404510-1-song@kernel.org> <20250603065920.3404510-2-song@kernel.org>
 <20250606144058.GW299672@ZenIV>
In-Reply-To: <20250606144058.GW299672@ZenIV>
From: Song Liu <song@kernel.org>
Date: Fri, 6 Jun 2025 10:01:26 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7UeycwNjmm1mH9q1ZhjKLC4Shc0hbZ_o7a5zD2bRMzQQ@mail.gmail.com>
X-Gm-Features: AX0GCFucxmg5JO3P3a3C0kxsaNoBTalGKKNBxoM4YNJ9bu19AeAlrfXDOWhXvvs
Message-ID: <CAPhsuW7UeycwNjmm1mH9q1ZhjKLC4Shc0hbZ_o7a5zD2bRMzQQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/4] namei: Introduce new helper function path_walk_parent()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, brauner@kernel.org, jack@suse.cz, 
	kpsingh@kernel.org, mattbobrowski@google.com, amir73il@gmail.com, 
	repnop@google.com, jlayton@kernel.org, josef@toxicpanda.com, mic@digikod.net, 
	gnoack@google.com, m@maowtm.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 7:41=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Mon, Jun 02, 2025 at 11:59:17PM -0700, Song Liu wrote:
> > This helper walks an input path to its parent. Logic are added to handl=
e
> > walking across mount tree.
> >
> > This will be used by landlock, and BPF LSM.
>
> Unless I'm misreading that, it does *NOT* walk to parent - it treats
> step into mountpoint as a separate step.  NAK in that form - it's
> simply a wrong primitive.

I think this should be fixed by Micka=C3=ABl's comment. I will send v3 with
it.

Thanks,
Song

