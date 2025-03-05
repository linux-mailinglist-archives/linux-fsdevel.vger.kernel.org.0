Return-Path: <linux-fsdevel+bounces-43270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 500B9A50321
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 16:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3981B3A424B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 15:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE8524F5A5;
	Wed,  5 Mar 2025 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E0fyhTpI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AB224EF99
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 15:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741187055; cv=none; b=lnFYvdGgzQyQuNnjr/h10Aq38Ng2624T1nL1KnlwwJ+sll/KWxNCQW5EFVTA808yDTbEXP8ujNubh9IKyIi5jXPxT5gW5OEaviNBd760LAB/P2ntFD96OBuOsmMagl1igackn/H4wH5ShEBeNezcwViwHizvKVLIDUU72v1POxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741187055; c=relaxed/simple;
	bh=t5eNaNrX2l+tZef9ZgJzRD8AjzR4E3n2CK9UhuofW3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1SsSE8s96M7DYCKAG0aKoOMnyyp1e8zfaEcnqInrrnubhGe3hbXdgY3jGrMaIsqo/3dMnKzSRf3Ym94VacM5FIoFeWaSbOEQwMKDHCNZ3xpgDktgQtywHdiDXCxzgkuWNgKr/lLUc/I+5qf4p0l3dm423rIEWR+3cAqhDdK3Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E0fyhTpI; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-390fb1b987fso4957354f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Mar 2025 07:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741187051; x=1741791851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NLmgp+4BNcFGyEe+zA1DNg0CWSPx2N1T/nc5ywlKYT8=;
        b=E0fyhTpId/xgNl4mabkCJHJlzGzPtK4E5BvoAhvo19Y0up2Rdhafm/wcZoHuPEKFQx
         thcCC4Mief+uWfCxeVps+muFMU2CrE+XNW7ZbIQOJEjt0eWJxROgfS1uL/CeDzKK+4Op
         0aSHbmv2iKKppZ60uvwgMNpbi8NEn21B2+VKGKWGFOdKqDEnt5eBlRNrD7Sxn/uwuKWL
         a+oX1rIJw4Gz7ur+HjoVXgdkHz2P58fagKBc3B4Wq1vgaBclSwWjSJCugyhFCTLUP3lW
         T8agu8SD68LHPYdh6kXkb4EI0waExr0BWcscMWRCgRNbzbqMHrIU9OyfMSEPNPZ6wtiz
         i1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741187051; x=1741791851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLmgp+4BNcFGyEe+zA1DNg0CWSPx2N1T/nc5ywlKYT8=;
        b=eqvG4Zabmrh2R/zUrT3JRxbEvzbaEsv8Fh4SCPg96o7lnVuUKZenusc1wRVhczJQi0
         iwKU6P1MRucW18UwFAdxOPgdHbd6DFU5OkMga3zBBKeEO6NT7uKhx1nimmteMYVbsh0a
         /aJUkzuQK+UldwJM8GkoVV8RHucMyV+rcMZ2Wx5Bl/QA1XECIrBF15iSVwQEDtaXQWBt
         f+OrsYlJVHYI2Puj2nEpu5fKB+Ylx/vkPU62khOS2hqrMcpovgcVLfH84Npgr8+L1P6Z
         guwUnLVe2SCagu2QwFP5FEeil9iJkXlU9yFHfu8YWuipyYkqt0T/qbcKwxJw5uS95Fvk
         i39Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/hNXQzXw8amJ2OW3yd+njKntFq9FlYmwOyci1YL0GqZz3H2QiKSL/tmUEdsrYjcMytrvfP+TssSH5kp9k@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2xjdxt+LnkUWMYFZ1kxjxeuqeXKLfPem0AK85PyY8JOMCJkbC
	SM9Hozq1GP4imZb/LG43CkwijdQCfxOvPNCbhe5f//VPauycPuYD3jWj5BVUmoU=
X-Gm-Gg: ASbGncuCTZpQ57tfNQStI5YlfrSgwt/JJkCof9itzdTdOvTmbwHTbPJ6BNhrDsA/Bfy
	A9BZ8L33sRK4IIKDnVjdB+XJTccEOGYgS12K76JtjwFh4VzKmEg0r2xOvd92LGkqtFhkVcMzmrr
	RV4APVvqSYGhxgLGaomhTEuNIQUZLK2uTz0LhP7crF0qHdolgPKKCs9z0vDJZJnNfonaQZHqfiN
	ABfTRLZcHa91a5MUQEyPIUf9Zsc9h0WKUIYudyhq/GbsgJr2ufRk24t6b2vuOO+Z9IJ4A3CifSo
	Kg7E41Jx0KtyZ9YpRaHfCc7t5j1G5IuRmkvlUaocQGH3m6k=
X-Google-Smtp-Source: AGHT+IGlWpXBw5ri3FaDBssVibQSzlL8JZY/24FSPaE5MWfcweC0DmUsA0HmZ1zjcuQDZS2k9Zzqjw==
X-Received: by 2002:a5d:59a5:0:b0:390:f1c1:d399 with SMTP id ffacd0b85a97d-3911f7bb9b8mr2998938f8f.41.1741187051174;
        Wed, 05 Mar 2025 07:04:11 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485d8e4sm20907920f8f.85.2025.03.05.07.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:04:10 -0800 (PST)
Date: Wed, 5 Mar 2025 16:04:08 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>, 
	"Eric W . Biederman" <ebiederm@xmission.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 2/2] pid: Optional first-fit pid allocation
Message-ID: <glmbovmv7ahln6omzoas5lrktaafbmxdkbs4mfoummhrlayl7u@s2nv66r7yx43>
References: <20250221170249.890014-1-mkoutny@suse.com>
 <20250221170249.890014-3-mkoutny@suse.com>
 <20250221161854.8ea0dd0b2da05d38574cefc4@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yphetxzk2ql5urd5"
Content-Disposition: inline
In-Reply-To: <20250221161854.8ea0dd0b2da05d38574cefc4@linux-foundation.org>


--yphetxzk2ql5urd5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 2/2] pid: Optional first-fit pid allocation
MIME-Version: 1.0

Hi.

On Fri, Feb 21, 2025 at 04:18:54PM -0800, Andrew Morton <akpm@linux-foundation.org> wrote:
> This seems thin.  Is there more we can tell our users?  What are the
> visible effects of this?  What are the benefits?  Why would they want
> to turn it on?

Thanks for review and comments (also Alexander).

> I mean, there are veritable paragraphs in the changelogs, but just a
> single line in the user-facing docs.  Seems there could be more...

I decided not to fiddle with allocation strategies and disable pid_max
in namespaces by default.

Michal

--yphetxzk2ql5urd5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ8hn5QAKCRAt3Wney77B
SeH/AQCl7M3g6jWcHR92iwej1BFLEym+t1kmSZ8IyoLg8iToxwEAolDqAbNbU2Vi
T/noTfl//D4KGYDllskbpZOuGNvu2gQ=
=t4Hk
-----END PGP SIGNATURE-----

--yphetxzk2ql5urd5--

