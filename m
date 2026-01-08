Return-Path: <linux-fsdevel+bounces-72812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DD7D043F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 17:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE4B830CCACB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4C338A296;
	Thu,  8 Jan 2026 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJdPzVoW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C13937E2E6
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767865403; cv=none; b=kvKk7qMEtULPI4Pfg11uYd64Ddur1xEJSI99zOe6sSTY5HBRauf+M6TEv1iNh+s3AH2+sF7c9LEaI2NAjYNCodoAUiihfMaUEyFxYuHP89oRiUS3B3l0QK+aJMHaHF4RTWWNgwE4+mMyERDfwzLntFJA2ElZZ9BOqcrmwbbE54k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767865403; c=relaxed/simple;
	bh=sfxDBmCexDpJeVckjNjWiUluzw6B197qmSgmmOgJ86E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JpyKSLeDr/vLDsMirBMwYSckjz3hnHZVZ+BSQyyvEgXMS0vR/KDV8UjzHgjfFt9nT/xyLsf6YiZ51DZ6nWbdVk6neT67m8DPKT60ioJ2yDpc2gXn+DijCIT2SFu90P2VhQvs5dyQ8XIX5LpWR0Kyv4JNHMqYizyEG8GIdteuFBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJdPzVoW; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b802d5e9f06so424580666b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 01:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767865392; x=1768470192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRw3PJoXwX+xdp9i/McIwKxflspWMmZgC/PQP/RKUM8=;
        b=fJdPzVoWGh0Ej2RrhC8i5kUzDy9Rmw9iVXY/QXqDyawXePhLmSWaGQSiZ5y0G4tfHx
         0mmsFHlq8QrJjWEFw1dCCXJ32mXPxRDKwY30uQsFAwoI8o2Q15hqWifxXAIHFaBD1crM
         gPf1scpjoTc15iNwfbCmJlMwBjKYPDhvniBv4u9QJ/2QtOaQQCNzoqQfKS2gAMKbc2Bm
         cL7rp1zAMo/5IQDvtfrO5KK2vKd8/dmlij04JWg1/87ce6hRM5aqps2GmquhGjFRsEcw
         6k3iShlR4HGDP0wxomnRldydjVLtqRE7eBzIs1ObDCOsP8+O/RBTQGQi5I3gMXflccz7
         1gRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767865392; x=1768470192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XRw3PJoXwX+xdp9i/McIwKxflspWMmZgC/PQP/RKUM8=;
        b=o7BTGvY/Up+uGPJDJ8qukhapUDvhzazJUawNYZAacEsQw7lj8Bo4RR4oXYk381jzn0
         8N7jfdt4ZW0Bi3YV0Kj2H7eNcYq/+ZaUZEgtgy5nModZQKPE0/rVgJjcQMvFyInU+i3q
         gXULBan9sJ9wdpT5s7veSC/T1j4Rpsn1IA00SL8oE2jSTp69mNRwM6BG61NlESj+hN3N
         CkOJ3njdSl4ougnJZ3PHyHn9dAWF9V5OZ8KuDCnTLViuhRG7N5Vb4nfAt6Bno2rvZPY0
         /mabUg4C9KmHPhpSCoxXlNCm7GKjXzL7rWKNeateepWiAkqaqFjEp9bSxdFl2N39CCF+
         2LiA==
X-Forwarded-Encrypted: i=1; AJvYcCVwPl7N/5JkmoaE48e+Ol/MdfaV1nT3zaunfukXoZ0tKdsHc/LdWWA4gMbTlaskef6PH3idqxWwjz/B+tNM@vger.kernel.org
X-Gm-Message-State: AOJu0YwHAvzflqIeOLMn8DHbr80Os+UMz0hqueUHvGH0p4sU17UOn0du
	XPARTXVzNP8yIzrYvHVw8s12JP8hTyWYIXChfWh9oMZHsnffeVt/p/CkMdvC3qNaChYPLygYxPk
	s0uLNJf/nKIKQknZmLMi7ChlMyiCMUfE=
X-Gm-Gg: AY/fxX75chYHDbeQy33AKRw/0LtC4leSjL1mKJMCHjDXuzlPVemFc3ijWN24so95Y1O
	2utvCgC1KIshqNIsDb0bIIM+kz2ODAiJrtvV7uSuV/tAHXmVNiAZiF2ZDwUAPNsYNmtecqKoF/i
	7GNc6wvFQnSzQJiXVdqJrdy5MOudT8toqKPK7yxUBcXQ6pd7mA8pgSAC2WfT/zVfaF9DDEMPABS
	J7iRsW8IkaBVIsYLnGXM6i8ZZ4Hz3xw7mtScat+D1LaRXb+pmioB3S6LwZS7xdwOpYs0Yj/hZp4
	IGPvhNyfj94svek+vxe5HKLX
X-Google-Smtp-Source: AGHT+IHj9h+CAXViTE65niWDnsYgwHBfVs04OxKQOOSCciSwXHZxgC24jtaG0Rlnwtw/s4+7+rpAlWWKIEDDHCdFODY=
X-Received: by 2002:a17:907:a4a:b0:b81:ec75:d649 with SMTP id
 a640c23a62f3a-b84451dd880mr495728966b.27.1767865391554; Thu, 08 Jan 2026
 01:43:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-dcache-v1-1-f0d904b4a7c2@debian.org> <h6gfebegbbtqdjefr52kqdvfjlnpq4euzrq25mw4mdkapa2cfq@dy73qj5go474>
 <yhleevo3p4d7tlvmc4b27di3mndhnv7dmnlrupgrtjy23ehqok@whlvpgy4kqrv> <20260107205410.GN1712166@ZenIV>
In-Reply-To: <20260107205410.GN1712166@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 8 Jan 2026 10:42:59 +0100
X-Gm-Features: AQt7F2rIcAVAOgsY-bwGxOVzyYLVKy1nFevD8Y4NSgLOU5HJduiLcJwviLtlNtc
Message-ID: <CAGudoHEjifON3TvRBtf-yrT11Ty-O0qentcGQKp4hjA42a3Bhw@mail.gmail.com>
Subject: Re: [PATCH] fs/namei: Remove redundant DCACHE_MANAGED_DENTRY check in __follow_mount_rcu
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Breno Leitao <leitao@debian.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jlayton@kernel.org, rostedt@goodmis.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 9:52=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
> TBH, this (starting with READ_ONCE()) is quite pointless; documentation i=
s
> badly needed in the area, but asserts will not replace it.
>
> Note that mount traversal *is* wrapped in mount_lock seqcount check; anyt=
hing
> that used to be a mountpoint, but has ceased to be such will automaticall=
y
> trigger a full repeat of pathwalk in non-rcu mode.  What's more, the same
> check is done upon the transition from rcu to non-rcu, with the same effe=
ct
> of a mismatch.
>
> This READ_ONCE() is pointless, with or without a check in the next line
> being done the way it's done.  We are explicitly OK with the damn thing
> changing under us; the check in the beginning of __follow_mount_rcu()
> is only a shortcut for very common case, equivalent to what the loop
> below would've done if we didn't have that check there.
>

As far as I can tell it currently happens to not matter for
__follow_mount_rcu, so there is no correctness issue as is.

I do claim that basic hygiene in case of lockless code dictates stuff
gets read and acted on once if feasible, even if the code at hand
would be fine without it.

Any outsider (e.g., me) reading this diff has to pause and ponder if
it changes anything and this is trivially avoidable by passing the
found value into the routine.

