Return-Path: <linux-fsdevel+bounces-51506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7CAAD7761
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 18:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D1D3A4220
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88B227144B;
	Thu, 12 Jun 2025 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="adteXiLO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB16D1B3957
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743818; cv=none; b=NJbMOBqFHD9WUTea4yuYnCzYr3QFWuLC9sGkFbKcTkMrPQvmPBGkiUFJMV8UZEEjc0xkMIMfouS7fT+OXD45+0zJKmrAMEuKNa+cN3pJSijFraob+ez+nCF5aMMqn3xBIj6QzPxHrIpdsAaecyzIf1+AZ1VuyAb4OMo4pn7PlPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743818; c=relaxed/simple;
	bh=QaeCKRF5h21BnrbklbxGTMMCMqaScCZDI/SD6f2jAI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wn08I8NB8bv4FRM2Ho8ojtAWVeyOP5TSn5pm05SobmJwFJM7ek62HOjQKe7kUT3swY6Xkw5o0gbMr6NHwvQumHFdR6KoQFWzeGnMT3jNch26Y5elKh3XRbXkigWA+utcDFhbQMtHawctz1Wbu1i6gxUDb40axbLJ4LrCNcJG/D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=adteXiLO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-235a3dd4f0dso8035555ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 08:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749743815; x=1750348615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaeCKRF5h21BnrbklbxGTMMCMqaScCZDI/SD6f2jAI0=;
        b=adteXiLOWS9T9XvVtbACWfggZ4ZZgyWsz4NQ7Pt+lrusJ+6m6JKl7jeFURXh/Elhi1
         Kv9amv11c2Jl0oIypOUtmE7f7A0rEWjuKwyGwyMuMf4U8/ie0N2/zgUDYMlH4xZiuDmx
         DX/XhHo+D2rrDlSsCseImQ81I0yWlaFA5OVgx6cO5qagCaHl2ogp5OJPF1KUpNRjY4Mc
         pfSQZHx6oGy71eIlAsiwW9tdqPRSGkqLr3VTUCF9cljr5vYn3sU4EFdOVnvweGyI2VHg
         HarkInbzrjXYimOpSN0RsTFoDhvyXw35XdZIm2cA+9MXRDaaVHfunCs1TwXyJ2I6yGl/
         UoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749743815; x=1750348615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QaeCKRF5h21BnrbklbxGTMMCMqaScCZDI/SD6f2jAI0=;
        b=kQB6tBhYtjA7aZIECOArCrdrX8z+x56CDkxMCEVMa1R7f5URQfYjGAPE7mfVpLE8/O
         8OmQjZlDImscrUqfmdtZ+ctbWDmGFh5yexAHBskFCK8n4BjmNHJFmng7u1gAwQE/7yaf
         Ccsqd9fUsxCG7/Ea8okD1grYMpTj2K2W1k9JAAL3huNnM2+LvAFdvDvpO0lhTl+EZ1WS
         1hiNyEy4aPVqzyAhPaHetJZxI1tNSsKDKPS//Qpxr9Zd6roke4l3PnVcxGuCQPkfDv/+
         6MIJho5WEjzUzqO3mlQKTkN9rdLw8tFhhW4pTpVACWmCk/rP1a0CWwrQjTdduEqUTNrP
         /FGg==
X-Gm-Message-State: AOJu0YykLmK+y9NqJCeTA+b48Ov/V5gqfSRpDnIE3HYWJ8818H2qzfK+
	8FSBHCjKqvqxS6cHQusdmkbsoP/rMM9Mq2XuERNmpSM2wwXN8lj+qPexVFG74N2SEnY32VSfuRv
	/MmkgI66s+Ih05P4tmDt5pEjAS7OuzXG8s+zmf8wP/cF1ec184HfhYOz99QU=
X-Gm-Gg: ASbGnctk/9BaTBH82jZhVvP0KRYojI8qFWS5/3xySzQX1zKrCg7EOvnVw984Q3kYfd2
	K4PAeaxuZV+975mNLHe/zcuWk+YOYzVcCk5LdqCJLgnlMtPoll+zyuSdQ+l3dhV/DWnjfitDAF8
	GU2OWkxStgBljWLzES5UPv+FYDSm5HTCbcEMrx3HHvYpSinMBovDzdt7icNb4rey9S3e2BPGHdQ
	8Gycw==
X-Google-Smtp-Source: AGHT+IE6+4Wa76KO9TPIgorE8i8beUVbaKDNVVNagZ0s500Wmvq7ngPLwT8NKEqDzNQ401T76r/dF7B7h1oKfRhh3rA=
X-Received: by 2002:a17:902:cf46:b0:235:e71e:a396 with SMTP id
 d9443c01a7336-23641b40a37mr73558125ad.51.1749743814944; Thu, 12 Jun 2025
 08:56:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEW=TRpJ89GmQym_RHSxyQ=x97btBBaJBT7hOtbQFKyk4jkzDQ@mail.gmail.com>
In-Reply-To: <CAEW=TRpJ89GmQym_RHSxyQ=x97btBBaJBT7hOtbQFKyk4jkzDQ@mail.gmail.com>
From: Prince Kumar <princer@google.com>
Date: Thu, 12 Jun 2025 21:26:43 +0530
X-Gm-Features: AX0GCFuumoT0JTeyGuDKSLZ3th6nLb68tn4JyQVJRFNO3pKf4y3XUhjAvck1YuI
Message-ID: <CAEW=TRp9t2dTsp+Fd6szDdSrn4j350j0Yrju0GLtFDzzG7i_xw@mail.gmail.com>
Subject: Re: Getting Unexpected Lookup entries calls after Readdirplus
To: linux-fsdevel@vger.kernel.org
Cc: Aditi Mittal <aditime@google.com>, Ashmeen Kaur <ashmeen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle reminder!!

-Prince.

On Thu, Jun 5, 2025 at 2:53=E2=80=AFPM Prince Kumar <princer@google.com> wr=
ote:
>
> Hello Team,
>
> I'm implementing Readdirplus support in GCSFuse
> (https://github.com/googlecloudplatform/gcsfuse) and have observed
> behavior that seems to contradict my understanding of its purpose.
>
> When Readdirplus returns ChildInodeEntry, I expect the kernel to use
> this information and avoid subsequent lookup calls for those entries.
> However, I'm seeing lookup calls persist for these entries unless an
> entry_timeout is explicitly set.
>
> One similar open issue on the libfuse github repo:
> https://github.com/libfuse/libfuse/issues/235, which is closed but
> seems un-resolved.
>
> 1. Could you confirm if this is the expected behavior, or a kernel side i=
ssue?
> 2. Also, is there a way other than setting entry_timeout, to suppress
> these lookup entries calls after the Readdirplus call?
>
> Regards,
> Prince Kumar.

