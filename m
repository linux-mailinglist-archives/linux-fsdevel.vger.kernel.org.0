Return-Path: <linux-fsdevel+bounces-73089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DD0D0C146
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 20:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8C9630E2322
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 19:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC322DFA5B;
	Fri,  9 Jan 2026 19:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEWA0c/M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0742EA482
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767986904; cv=none; b=pVewqfDZWfnMqrYO7Wd0yypgQcIH7kvs4IHb7N/m2IHe86RekarO8B2Cq+ZjnY9qy+DBT15e9iu9Z5zEYfSb+nSU1GkyVLpxhlmkBFMLsKcU/UWIsFquVV/M3x+ALYN5FQD981Yx3HrVBtV9FoPnqyzKTJrihBkU/skI8fjQYb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767986904; c=relaxed/simple;
	bh=dRzIa5fiWLrN01LsjE0RlZGEKs+FvhThtYhX9NAu9iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLaqKUYgqnldvrJfaJXfc4UQFQd3QyHAP8CJ2i82ibKue4oUllpuPXcJOwavTmlRRiQFQ/p84UDaDEtZ3l4gBvw3PuL9ZMyp8Trl29Lu0rd8aUqP/PravEy0WPPH7NJRdCV5Kf6r4vVY35jpISl42J7/a+XlnbifM86PQy262OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEWA0c/M; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64d02c01865so7548217a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jan 2026 11:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767986901; x=1768591701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eimWlUcV7d3iFQvcuTg31PKCAdqdZkUyezXhEbiXQzk=;
        b=lEWA0c/M0p5PwbS7PpzcSw4fTwXrAKdrFH3VeaETBkOVdVl/DF5GRM0AjJKaOkTamc
         hoEsvGeiNpd5Nidf727gtwooxrp/ZvJ47aVO4m5kDplJFBc7SFDL3XBQxDLb3LedqD0B
         1xRdF9b3fexqfk6kH0QH563uWGlvkXEg8wZPauRIQ0so7NQ4QD++L9MprpVGGhBkRANv
         V38wbQ5h2zMtwTA9GUTJQO+PRukjl770a3jluDrRLHGVTLXngDax+yqgw+DR1IKZ+NY9
         16t2RVDAKtiAKCJqptfVHUi88Q1n1co+ELNZniM+FCKdHkSxSluT59VIjGS72ha9pNR+
         xExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767986901; x=1768591701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eimWlUcV7d3iFQvcuTg31PKCAdqdZkUyezXhEbiXQzk=;
        b=gRiyudqpmAUtc6CwUIsM1Q/y3CafdNIagbVzBARydsRZI5x7Xa3Mp1NZNAVd6cURiJ
         s720AWPZIuURUoW2MkI4J7Hc6Cm1tj+xzdIj8TfP8m64VmCGiyzjEwtbaM3XFRP/CTAO
         tjhytoO/GktErsIDC3yOdInUVsGw1xUtmnhz0EPgEml6RSQK+OV2xkp6BNAywjwqmanb
         cn5HN2abhYJbWXSZ8v65sSAFAaK4fr31aLB3Yw+HHHG+bemV80e0xIw078zeRzTZaJL2
         UkMJ7FO3MaCLauBINb5EJco/NinqOH4rkrtNXHDNg6cyxI1zcHV20lJflhs2WZE6Wmin
         ObNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrjUrnUfJh2Ykp1czMl+XHFe8wpPYUav6B7Q6Mq6RdgO4GSIpEWG5I4zd0DuMeyGPvy5grsSNxnzhAyAMh@vger.kernel.org
X-Gm-Message-State: AOJu0YynKIc+x8EyLFgxlZlClkwNRUCaOvmon2f9IoNdWcygr5lu8lzL
	6WTec84sWBznEuBg5n7GiwNc9JiNc7cX7HLgPuA/TcVj8Oy/NzppGBxTjBY/eDLMfMLEih8/B64
	Su/kMWkaxvbP1tiiYaGPPoinoyMXHbQprtpJLQLs=
X-Gm-Gg: AY/fxX7wSaLPhVKYJ5Qfocng1kAnlmHtZx2xzB6+gMYgVLd5oXVxjEIh//9KPPLDooh
	sYT+L/GrG5chOQtnNZYZ6UDUBvo8Sg9jfEek2Rk3baoqUwIGJ0SXdzen+6XBdLwtI1PAb39W0Uv
	e9rkPdVtawSux4oAUHNEZwwolw+FYIU8krJkwXh4/5FAiHu6kJkd21/PgkbaaVGBTI23rvpC3SI
	9BeozOBJGNL3PB2CzglK0kPC70Z3nHPYU15Si3cwxEWR0AY32zTC0b+XDqDzA3NP+z/HVmtB+dm
	1rJsGgNuaxzpmiJ0XdQJylDgMbtKjBnUle31/P63EvwICEYR1j0=
X-Google-Smtp-Source: AGHT+IGkxX1oJVbWNqWuERiuCtvnJ7o5bYpMTdqFcMNQmvUV5s6Erl0isxmmBlsuQy4R1Niq7Ik9y5tz6h0+4hrVnJQ=
X-Received: by 2002:a05:6402:4316:b0:64b:7dd2:6bc2 with SMTP id
 4fb4d7f45d1cf-65097de7d06mr9662290a12.7.1767986900764; Fri, 09 Jan 2026
 11:28:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212181254.59365-1-luis@igalia.com> <20251212181254.59365-5-luis@igalia.com>
 <CAJfpegszP+2XA=vADK4r09KU30BQd-r9sNu2Dog88yLG8iV7WQ@mail.gmail.com>
 <87zf6nov6c.fsf@wotan.olymp> <CAJfpegst6oha7-M+8v9cYpk7MR-9k_PZofJ3uzG39DnVoVXMkA@mail.gmail.com>
 <CAOQ4uxjXN0BNZaFmgs3U7g5jPmBOVV4HenJYgdfO_-6oV94ACw@mail.gmail.com>
 <CAJfpegsS1gijE=hoaQCiR+i7vmHHxxhkguGJvMf6aJ2Ez9r1dw@mail.gmail.com>
 <b2582658-c5e9-4cf8-b673-5ccc78fe0d75@ddn.com> <CAOQ4uxhMtz6WqLKPegRy+Do2UU6uJvDOqb8YU6=-jAy98E5Vfw@mail.gmail.com>
 <CAJfpegsLPJ5B_A34qP-3nXrXc7v2d-QpL3rkGS5rMfGq0g+FCw@mail.gmail.com>
In-Reply-To: <CAJfpegsLPJ5B_A34qP-3nXrXc7v2d-QpL3rkGS5rMfGq0g+FCw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 9 Jan 2026 20:28:09 +0100
X-Gm-Features: AQt7F2pTq4DKc5fZ2w_H1ImJzirmY770zynFR-AwYy_D_i5fPZT5x-PugxUbF4I
Message-ID: <CAOQ4uxiVwrane=X+fwPrgyVYMRox6DgCpbZJvi_DeMNF8NvTCA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the FUSE_LOOKUP_HANDLE operation
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bschubert@ddn.com>, Luis Henriques <luis@igalia.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matt Harvey <mharvey@jumptrading.com>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 8:01=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Fri, 9 Jan 2026 at 19:29, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > I thought that the idea of FUSE_CREATE is that it is atomic_open()
> > is it not?
> > If we decompose that to FUSE_MKOBJ_H + FUSE_STATX + FUSE_OPEN
> > it won't be atomic on the server, would it?
>
> This won't change anything wrt atomicity, since the request and the
> reply are still a single blob.  The reason to do this is that the
> interface itself is cleaner and we can swap out one part (like we want
> now with the file handle stuff) and reuse the other parts.
>
> So I mostly look on this as a trick to make the interface more
> modular, not something that the servers will care about.
>
> > I admit that the guesswork with readdirplus auto is not always
> > what serves users the best, but why change to push?
> > If the server had actually written the dirents with some header
> > it could just as well decide per dirent if it wants to return
> > dirent or direntplus or direntplus_handle.
> >
> > What is the expected benefit of using push in this scenario?
>
> I was thinking of detaching the lookup + getattr from the directory data.
>
> Now I realize that doing it with a FUSE_NOTIFY is not really useful,
> we can just attach the array of entries at the end of the readdir
> reply as a separate blob.
>

Sure, that works, as long as there is some header to the array,
it could contain the new entry_handle and statx payloads.

> > My own take on READDIRPLUS is that it cries for a user API
> > so that "ls" could opt-out and "ls -l" could opt-in to readdirplus.
>
> Yeah, that would be nice.  What about fadvise flag?
>

Definitely, like readahead we would need to support
NO (RANDOM), YES (SEQUENTIAL) and AUTO (NORMAL).

Honestly, I got discouraged from completing readdir passthrough
because of the complexity involved wrt readdirplus, but
maybe I will just post the patches I have for readdir(not plus)
passthrough with the fadvise to facilitate it.

Thanks,
Amir.

