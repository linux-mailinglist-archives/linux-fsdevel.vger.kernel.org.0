Return-Path: <linux-fsdevel+bounces-70976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CA9CADC85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 08 Dec 2025 17:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 241B93032FEC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Dec 2025 16:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1C521CFF6;
	Mon,  8 Dec 2025 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M1xzyeNg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1F3757EA
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Dec 2025 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765212532; cv=none; b=TnZQaXmP8qvfrYQv5+Yrz2GMzpfo0J0AwSZfsRUz7x3RqErQ3SSw4qI3Ye9S54v6/0QGbk7Q2hh0fOM3t7D19Qo4dYRsk4EQY8T0oNpOMRKNqSJ9i8Jp61bLas1N6bJW+mUMU+7N+UUub/xB65seF3iReS9vpYdWZnPa9hrLR98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765212532; c=relaxed/simple;
	bh=NGTtmc49qGm8JmqTcihsC/mRcolGTztLq1MYlXidkeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tss8ea1A4TrW4rob0v4lr2mIUZ17BcWhyVRPZgEZJH61/cMaF0WMROmSePLD58p7uFG5GH5o4lwTC4jbMr0kRzQuKBcL+KOm3CDm8UCyFAJrKm/fzQUhDSy1xs0V4AOe87dT8Tjumn3CC3FUF16CloDP5Eb5cJOv8MSMBNZnW40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M1xzyeNg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so43955625e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Dec 2025 08:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765212529; x=1765817329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NGTtmc49qGm8JmqTcihsC/mRcolGTztLq1MYlXidkeo=;
        b=M1xzyeNg1qdBDLmQSIcJW/0LctwD5atkNCH+PY3SZYzBB9GPEugIcVSSW9U/YGoPol
         xE/VYOreEATv98Fixgoc0bffXVTRt2jeIRNbRVA8u3yAdsbag2hjPO5YNDjU12j+B3Dn
         kVrPyoNq9UII0pVZ8X8IAO/eqRmia3re0S3ajad/pLj8UKZaX8HdXgjaNovcIlo3gGiY
         A+4W3ZAtQFPLNhkp13hmi3uHJWDZL+MLYULrwJ14LC4eBxi8thT68CSlWxF+UJV9PlMh
         StKLBzqrLvrRB9zrko+ZOnvzvymldYW3hMY1SYTCxDkWP7RX1Tc04iOVtjTgwBV3YtmG
         acvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765212529; x=1765817329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGTtmc49qGm8JmqTcihsC/mRcolGTztLq1MYlXidkeo=;
        b=s54xute8KXqA7PD+oUCeltASA9THo/HAVmy5bBG6mDXyb/vQ3WqLzyWpjlZWJxCpQm
         ftIPHhBDDx+VyrJiu8abTJFEA4SFvj4gYYKqAT4XgSP+cKu4z/ErAUxfERLAJncXLDkM
         vm11XtXdoF3fGUBbyV/YrgSG695IQ4BnzlfOKcwcBbppYfb4tlCS7Ycihj9ZUraxg40/
         zQaIxkEIqDY6evJxFrH2Q1SwPd4PLsaeUdYRRRu7FmrPgxkUqWYd5WhtL4FlOuXucg64
         AxE/ldu1WdQoRoLKtuksOXvMLNjGKDI5GCNYL41brFByOK/TglKJRYl9GLjbkBHos1g1
         OPYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX67YFM4ZEhllsoEfo4WEwO7ReoCVIACYexWs7oP9yel9JszwY6Tuxy7+fIAEGH9cESDlumUraRdy1v93ne@vger.kernel.org
X-Gm-Message-State: AOJu0YwQaChjCbyLJmNrRFjBPqCMOVxF1u5gqxRZnmEkPPTf2Mq4P2pe
	GLvHMaeN/mE5TqAU+f+gaE3Pa/BbQF18S2Mun3TOGQ9QeFNaDkUlAsUp/HvN7GSfiYQ=
X-Gm-Gg: ASbGnctqjda1CBtRgEHr+QMCHmShMscEOhhH47Lyif5lEMjkrkwdF4QRqtPKBCBHqz7
	1fzRFKLhXVraVKbiIFEHgPEeGNpC595/XNe8Xri79BqExhfsaijLu2P0GX5VTxROTJROPJtjUa5
	4DpSPAJlj9J7yDLNLNyK490eMkI1Ia1zEUOie5lJEcJz0orNInspWrrnG3MxqFmY1mIbc9PJsH1
	/Xfruj0GfUXIIKq2OZJxglsB3DFatr6UvErtqVoVSWrW4dOJdzcvhkiDeoJ+ydwWxEP54VJoZQh
	Ca8EB4fIH1l5Epawxl0QFfibpU0aQS++7Eph4QoTmIsg6f2yaQwPhVM7F7B47yg6GkWUt4Yi4FA
	SwGI8lJltOFxTQBDdaLS24A3XszlyIaOOqgIVavofWgcDdx8bU0UUQiVyDJly7K4X7z+tFhHNAR
	NsmHzWz+ovqxP2UK1SjM35Xf1TeR4u+igKs1DekotWVQ==
X-Google-Smtp-Source: AGHT+IEsJ/iSaDvwNh18lu2wFHnkomxJ8Hvg1XZtgMMg6hpjOz1LIBWnTk3op1li+CYOfSPEkMphCw==
X-Received: by 2002:a05:600c:1552:b0:477:73cc:82c2 with SMTP id 5b1f17b1804b1-47939dfbb50mr84510895e9.9.1765212529294;
        Mon, 08 Dec 2025 08:48:49 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d331e62sm26750068f8f.35.2025.12.08.08.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 08:48:48 -0800 (PST)
Date: Mon, 8 Dec 2025 17:48:47 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Andrei Vagin <avagin@gmail.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, 
	Andrei Vagin <avagin@google.com>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	criu@lists.linux.dev, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Vipin Sharma <vipinsh@google.com>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/3] cgroup/misc: Add hwcap masks to the misc controller
Message-ID: <6dmgfe5vbbuqw7ycsm4l2ecpv4eppdsau4t22kitjcjglg2gna@dyjlwhfhviif>
References: <20251205005841.3942668-1-avagin@google.com>
 <57a7d8c3-a911-4729-bc39-ba3a1d810990@huaweicloud.com>
 <CANaxB-x5qVv_yYR7aYYdrd26uFRk=Zsd243+TeBWMn47wi++eA@mail.gmail.com>
 <bc10cdcb-840f-400e-85b8-3e8ae904f763@huaweicloud.com>
 <CANaxB-yOfS1KPZaZJ_4WG8XeZnB9M_shtWOOONTXQ2CW4mqsSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qhatuyfusoefghqk"
Content-Disposition: inline
In-Reply-To: <CANaxB-yOfS1KPZaZJ_4WG8XeZnB9M_shtWOOONTXQ2CW4mqsSA@mail.gmail.com>


--qhatuyfusoefghqk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 0/3] cgroup/misc: Add hwcap masks to the misc controller
MIME-Version: 1.0

Hello Andrei.

On Fri, Dec 05, 2025 at 12:19:04PM -0800, Andrei Vagin <avagin@gmail.com> wrote:
> If we are talking about C/R use cases, it should be configured when
> container is started. It can be adjusted dynamically, but all changes
> will affect only new processes. The auxiliary vectors are set on execve.

The questions by Ridong are getting at the reasons why cgroup API
doesn't sound like a good match for these values.
I understand it's tempting to implement this by simply copying some
masks from the enclosing cgroup but since there's little to be done upon
(dynamic) change or a process migration it's overkill.

So I'd look at how other [1] adjustments between fork-exec are done and
fit it with them. I guess prctl would be an option as a substitute for
non-existent setauxval().

Thanks,
Michal

[1] Yes, I admit cgroup migration is among them too. Another one is
setns(2) which is IMO a closer concept for this modified view of HW, I'm
not sure whether hardware namespaces had been brought up (and rejected)
in the past.


--qhatuyfusoefghqk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaTcBbBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Ai8MAEAyeSN6KCarnIABEa5QMqm
oISbZ1p14CvmHATzKA1bOyEBALyv5+on7iSaLxmoTq8ygkMxgB3VKwZP81DcFFDB
DEQF
=v5da
-----END PGP SIGNATURE-----

--qhatuyfusoefghqk--

