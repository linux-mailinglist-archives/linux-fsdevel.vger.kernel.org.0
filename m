Return-Path: <linux-fsdevel+bounces-68764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D75DC65B12
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 19:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 581BF4E1C51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 18:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9614302756;
	Mon, 17 Nov 2025 18:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="IpzOdkO/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B133930AD00
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 18:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763403648; cv=none; b=s6OENTUXsWil4PNH6hASODSwvQ4iVviV11YAFn71VrCnXFzRkjn1ZfuFpV8GIpJvqNccNgG7EzWW+j+zIgFSeH8QqVnzMpUr3HD5WVJKca4a9wdPDRsJnRW60VJ3eftwGGOPMvxi/8oWK0ermGCDjweKb/5fHMep5Mwe5GoJRrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763403648; c=relaxed/simple;
	bh=CZtsj+hifIsZJbKTfeb8TuUonR9rJOLyCJoinWAfVZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H91UGlq+Op+2sOsrYBNF3D+AHnETJicl2r3jbrkdPmcX2k6h0nYfJkWp2O1jbOTa3JIRvAGBmPWzHL2pVDwaX5rFk0QT62LN/RLS7n6GwCoIB5yB5jdQXaScDcWzFD0SeoDkk5SZAxM6L21vVtvGgz/zR9eMJ8CQvTRgxwcAVY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=IpzOdkO/; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso7887383a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 10:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763403645; x=1764008445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8uyJ9UgvBm8P+z5AaxjU/5GgC74k2Y8kBRaWb+wv/8=;
        b=IpzOdkO/TAphkuNLFQKOlMCFibMB7FXtwyELkClcZK/UQMitx5pYr6aLyTVD7HivrA
         yZ9TyaHfpn1tXwTDvcz9UE1jK6kILYxxIprO1UczbPyJAhZQF/Zw5wKmGg5uBjvB/0Ed
         wu9eUfc8dA9n4Sw2YarHZh4P0Mb7oNH+ULUozCRT/M4kNFBJulpSFaeq19eUR24SWdNA
         tU62ePkikquYMiUW0xcCZfA0igD2z5u5cAGVoxi5edaVuxaUPurQM1FlznHFZ98QCjaD
         olouksHmBWu3Fqn30s2sg1M/TWI9mLVwCrvGVuSL9o1TBhIuPeUTXIt8lrSAsnsOMwEv
         35KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763403645; x=1764008445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j8uyJ9UgvBm8P+z5AaxjU/5GgC74k2Y8kBRaWb+wv/8=;
        b=XiRHNeLBoJie92tcd37AE/ajt4pObRtpxGMvkzTm0cFXUVUenDz+Z31lrtPBn/IQ3R
         s2TDsbPwceWis6YUHhStOONzViYZrCIi9+YbVFBYGNtHYQJwh96dvKYEZ1UYVU71qP3k
         eoXoPH5v5/nyLbo0RRmADf3VzQsZD+DcEdkVl0ajlt9XSoNS3YIzfBWDj1JcJLeMCYrY
         Wj2BtyrCpF8h9Px2+UCMDjcvJvzrtTZ1fQNyPIdSMqs5zhXWxf/zeSPmWRXos5xT5ba/
         SNPQqt9xOBulPWYj/2/+DZteP6lCL8xctAfyfOMKO0jhfXbWnaun90hNyCSviTQrPtSS
         pLrw==
X-Forwarded-Encrypted: i=1; AJvYcCWprDA7Db7UVI2kwU1JYVrs/bSKNeIiyBUXGyW/gG85cV2IgbVVwDlwgirmj7n0uH1it6tT/7WaN/blJQ4L@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcj/jj0jX0zJnK6lKeTM9tU1cSMTSNZdTBZn1ommFtrK6pi5Y4
	y/xqu+ibeuEMJNkC3IsL7I93YN4gjts8AxFES9dMBE0BZ8ExnP83ZyMw4UWSX9rQLvu2t4pAlhG
	qhSHjYgA4IC8gfDfhsm97bVFNs2iFIBrDSISVorwPPQ==
X-Gm-Gg: ASbGnct76Yn9/u3yKrhug6KBxbAwcbxsX4eAgno7b+rhgOoOGdo3/a5H0xUQhuaPYKL
	H34xpk5Puvi8ZFH3mooWtgKs5PDhA7vpwp9V7MbsDRUx6YXsVnZoE6o2wTqZD01UN5oRY6K2rKd
	6qvLhhkdIigRaapDG/npLYh0EpahOGKWsAxasSkkmW6Kg5eikTx7BOqYjgZTXXxMf8HbI/grAHz
	WS96Gfbi1tQVk4/qe2hPIw7bAUhRtpgV3+FpbXm3MxKTQ6ocT4f5AUHxkmrzKT8H1Ko
X-Google-Smtp-Source: AGHT+IGM1Tr15Cbgk4QQHnvYqnvMCGG164LW1Q1ssAN2iVzR9VtHS4h71YwFJlzXxkn+A9bvWz6u1Z5jGfTyNzSIJ9I=
X-Received: by 2002:a05:6402:50d1:b0:640:c807:6af8 with SMTP id
 4fb4d7f45d1cf-64350e9c5c3mr10832591a12.30.1763403644857; Mon, 17 Nov 2025
 10:20:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-11-pasha.tatashin@soleen.com> <aRrtmy--AWCEEbtg@kernel.org>
In-Reply-To: <aRrtmy--AWCEEbtg@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 17 Nov 2025 13:20:07 -0500
X-Gm-Features: AWmQ_bngMkZtOLXtzvbIhDYg36rxAp3uf7c25ogdWq8dWGd7IJgw-yYh-gP9XSc
Message-ID: <CA+CK2bCVf2RppZbALAuFZyZarWukzhwkmOgtG2PcKqUQuao6uw@mail.gmail.com>
Subject: Re: [PATCH v6 10/20] MAINTAINERS: add liveupdate entry
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 4:41=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Sat, Nov 15, 2025 at 06:33:56PM -0500, Pasha Tatashin wrote:
> > Add a MAINTAINERS file entry for the new Live Update Orchestrator
> > introduced in previous patches.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  MAINTAINERS | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 500789529359..bc9f5c6f0e80 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14464,6 +14464,17 @@ F:   kernel/module/livepatch.c
> >  F:   samples/livepatch/
> >  F:   tools/testing/selftests/livepatch/
> >
> > +LIVE UPDATE
> > +M:   Pasha Tatashin <pasha.tatashin@soleen.com>
>
> Please count me in :)
>

Sure, added.

> > +L:   linux-kernel@vger.kernel.org
> > +S:   Maintained
> > +F:   Documentation/core-api/liveupdate.rst
> > +F:   Documentation/userspace-api/liveupdate.rst
> > +F:   include/linux/liveupdate.h
> > +F:   include/linux/liveupdate/
> > +F:   include/uapi/linux/liveupdate.h
> > +F:   kernel/liveupdate/
> > +
> >  LLC (802.2)
> >  L:   netdev@vger.kernel.org
> >  S:   Odd fixes
> > --
> > 2.52.0.rc1.455.g30608eb744-goog
> >
>
> --
> Sincerely yours,
> Mike.

