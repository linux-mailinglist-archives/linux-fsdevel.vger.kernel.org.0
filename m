Return-Path: <linux-fsdevel+bounces-37224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE879EFC9D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 20:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CFD2188412A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 19:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B96019D089;
	Thu, 12 Dec 2024 19:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CH1hSBan"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7427E183CD9;
	Thu, 12 Dec 2024 19:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734032358; cv=none; b=GVERikrTfpsCAy23Ch3GBJbUD4JKoD74o4xTnPypuZXwaqwDH1guqYh4xeciD4YLj2daDEDUyiM5Aq1ggzQYTDEgtuqT066APzKV0tZD39vWAFuQicxQUTBQWRI+KuENACijNG12PtEfbA9pl2n4Fh5gv+xdMcJWz8jjtyJSUz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734032358; c=relaxed/simple;
	bh=Kz3lTnnPV47L/qHM5RGdDtOdAl3uMd0bW/EbShUkRYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RgNtoipkaI7xbEMXry2FjXYiK+F+b1FQ6HZkfo8DT1T0XAmYOzgAabx3eV6WGH1JOgChTK6QNh+me7ZGwdHUsdRNwWZGEySIMDZ6kIzeonc0TRLN8dItURzwfLXyt6wNbLlRv9j1tiOeKTXtLmAW6TbiiHkyrrGNlCOplNz+mE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CH1hSBan; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so753239a12.1;
        Thu, 12 Dec 2024 11:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734032357; x=1734637157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXUTpPssHcay1QdWG1rkSODw/xMx016p0D9tmsgF2Zo=;
        b=CH1hSBanYRGfs2Veje3rKGMWfWrazmN0NzvTBQbHDd/u0pk5NRBMXXHCBhDKj60E1a
         vp5mDRPcY52pAP+ZG+MqPlSzKwbcGzOCvwdrnS+XJMg+4quPQuqN7BAbRZNZoLy7F0pA
         pPET9rryCGCtcI8oxnbRK+oCEr/MxwnCPzXgR9pbLemeDEnSxSByL8BWocHd7H++htxP
         Bw0knmPJBNjbm2eXJCHQR6TwhwhynMm4kSqjE/fI5TgrIbwpe3U/BqIlB5UV5yFT+KpE
         af8ytuvu1sUHPAiuMCIrQaTynJrjnGJA5LSggwcF5AYV2hs/HU11k//8MMLulbmNvt4X
         AtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734032357; x=1734637157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXUTpPssHcay1QdWG1rkSODw/xMx016p0D9tmsgF2Zo=;
        b=ctLcURXsKCs3nYJJR64loPmeOmGm+P/t9Vhz2bbEViu+EsYSCPh36gLz0j7hM8g9sl
         +Ri360y2OwGmqLtHq3IcwQ+uYiju7S7v4KgkXjWurKWz2lqv2/OmlC3kZt91Cd1pdw7Q
         d8AuX1EPW4zk82e9hHBybNhrTE+VwoUKwZ2UD8ESr1d/TpTjpjRg67hN9W2T2lVAUgRT
         s+rzg7PW6r2zkXLAsxwOGw8pyx73WBwCAL1r4WwcMYSXaw+nNBSJkT8d9Pdv1orK7T6T
         wTY1prb8bNSUFiA7nKsTqCAQOPaenFgmUEPqeUt02OvO7XIEfSvlKmKBDGZuTqofo/K+
         +czw==
X-Forwarded-Encrypted: i=1; AJvYcCUZVZ03WxiP9u2OluZGaeF4pVIGMfhdgIGfsvKjVZ8mWGR8vNg+KfQhdgC9GE1j9Cf4qvvv2zf1OGSaT3k38A==@vger.kernel.org, AJvYcCUxq6zKYYOj26u+M03R7MOd6bxTpRXnJe82TPiZEk/qwKgsF2MnjeaYnRF1Qz40OMYCMPYMXd6ACaIv3yqmGFV1PaacImvL@vger.kernel.org, AJvYcCVcPgibmXpb1RzBYF2zQptI2NpTETlG9FbBM/PWOLEUoKQuSy+I45Zb8Q/9EqfPrtvbL6Vsf3GdF4QlI+rO@vger.kernel.org, AJvYcCXhMbTWf/evcLvIdYMZHuxX05s/Hkn2CYrmoJ2qnasRDvXV19CbwwdIzLU599yrJjMIWp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV4zddmxTLWvvJYlqx7eEMEVpGHL2OKOGvdqDqTGkvXzlHMck3
	UvjOHpADLD3N3jxXndXQFrhkVhDvBwORT8/WuWdFZUH2uUAjF4Dik4gi/W58pkgpJE0kCeqXnIM
	Oem7kGLE364EoAd1gxtW6dTfM45E=
X-Gm-Gg: ASbGncvbqwqruBOG1s183q7yewKPaSPxZPXb46BPgfdW/ZrADBj0kAbq/PSboCfC7ug
	APtUAcWggbvEV+ZEFzqQ0L/50P2GgIWGYLSwSGyEDBMwwjDbMgThcVA==
X-Google-Smtp-Source: AGHT+IEuE6sRVYHDo79XRdWminxIlKw78Xt6GJKIrhH1SKjsZYwk9bCf6Z2d8KVqCCTtTxsUwPflkjjForcaRWkBvtk=
X-Received: by 2002:a17:90a:de98:b0:2ee:b4d4:69 with SMTP id
 98e67ed59e1d1-2f128048ef7mr12274134a91.35.1734032356691; Thu, 12 Dec 2024
 11:39:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210220627.2800362-1-song@kernel.org> <20241211131804.GA1912640@mit.edu>
In-Reply-To: <20241211131804.GA1912640@mit.edu>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Dec 2024 11:39:04 -0800
Message-ID: <CAEf4BzakJcZr-Kt+09PF-2jQRAHtzaw+YLibof5z=wvfqddq-Q@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 0/6] Enable writing xattr from BPF programs
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Song Liu <song@kernel.org>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org, 
	mattbobrowski@google.com, liamwisehart@meta.com, shankaran@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 5:18=E2=80=AFAM Theodore Ts'o <tytso@mit.edu> wrote=
:
>
> On Tue, Dec 10, 2024 at 02:06:21PM -0800, Song Liu wrote:
> > Add support to set and remove xattr from BPF program. Also add
> > security.bpf. xattr name prefix.
>
> If the system allows for the execution of unprivileged BPF programs
> (e.g., ones where a random user can load their own BPF programs), will
> they have hte ability to set and remove security.bpf.* xattrs?  If the
> answer is yes, should this be disallowed?

It's not 100% clear from Song's reply, but the answer is "no". You
can't use this from unprivileged BPF programs (BPF LSM is privileged
and requires root, effectively).

>
> I note that one of the use cases seems to be BPF-based LSM's, so we
> may want to have something even more restrictive since otherwise any
> BPF program could potentially have the same power as the LSM?
>
>                                             - Ted

