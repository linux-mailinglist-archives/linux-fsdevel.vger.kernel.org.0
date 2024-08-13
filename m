Return-Path: <linux-fsdevel+bounces-25756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB54094FC1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 05:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0883F1C22436
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 03:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A7C1B970;
	Tue, 13 Aug 2024 03:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpxiS30S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293961AACA;
	Tue, 13 Aug 2024 03:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723518729; cv=none; b=Jwx2BoPyZsSRK3EoDU8sU9oP4iYuDeVIM678RkTfKK4NhXviTew1umAIr6bNMVXcvGU2t08MiUL9yFCR3FzIlGIcwqcs2vLgPRMoHyPeQG2hxa6kwsTsSKCSY0VsGfU4nzl9jXC+qX1InLhsnhiDV7diFsmDExjSfoj9XDxg7nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723518729; c=relaxed/simple;
	bh=rTtnXF99PTHPF2ZHz6+Yl/cT93BFrIKnjBWBmoxYJ1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/zDSU9r2igC046Gv7hvzeD8d3GGZrmQJS6iehGA1A7AgtwOZU/pK8hztJ+aZuyDrvksComgkbO1NjVvCkCj/pokBZM6TDd78jNrPrXWo6CLhdrFxhRiRUIhbKCm0uEwiECdLVnxXZxgGTRzWd9lWNNsh2RGKX8A0PdfNQdMvXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpxiS30S; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a8e73b29cso452386666b.3;
        Mon, 12 Aug 2024 20:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723518726; x=1724123526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTtnXF99PTHPF2ZHz6+Yl/cT93BFrIKnjBWBmoxYJ1c=;
        b=TpxiS30SnvQMSH33lviT/pcZUGltSb7O0ec31e9qlqZfzGpjfF/TaXv01kChT3uKCK
         BY2EByK6yw+m21JS6WT2E2R+Rnd9J2lyHvbhtknxKtfrEeyLEG7UjMHxQusrvWf2RjoB
         hKkLT6T7h0Yf5oMpFKdRtbZlw4xOFofXObeBEcpOtwmBEp7vKYYVyahcVD2b/u8Pt62q
         YKC6ghwl7qqn/mOfUwIVii+xBnUrlYXXCT3k8B5pKFYXdFGS184jJpxtwixq2BtkgKXE
         4JOmsa+kwQXCQOPntY2H1G0oBid4ADN5zs6EazjwtSdTvzg3NiCO5tkccHQl//AZcfKS
         0n2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723518726; x=1724123526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTtnXF99PTHPF2ZHz6+Yl/cT93BFrIKnjBWBmoxYJ1c=;
        b=Izd9N/3PaLX0PnJSJlmdB3EcTUE3L7ICqNoeUtNwhP5fJWEvdcHmJBJpvQxXd5cJ5F
         URyNF6XcxLE8BsSO/yyIPjnPmmCcI6RtAXV7tgDL9mmDSmc1bQ8KRv6iZzo53Q+t1SNJ
         GOWXA6mJ/CEO59IleKf4IOxeoSowGyUoJTGqIrw/a1jSM8vl0d8CeTgJQS6wrLaAm2Bz
         5DZr/zDgQyrFc2jJSJtRJzzXgX6WPuM5GmbmNu10rze4ruopPv6wUZDQGSnbSCaW+Pn4
         L7pqNytsrZEnHmf55fqISK+K/nulxCr3Ek6wcFuqE0gpNpByTaMVoWqzlRAhZQ4WsOO0
         RHrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJLxsxtVBc7/G7kmiMt1dYX6eNCa9VC7RKtYMZVWtIhq0SZUMFvvfr3eY2Fhegoq/8mui5JAPZT80GDyinPfPVdmeNiMj7Q19Ll2E3kOUpdld/sBU5OWJLiXT04B8iBzPt5w==
X-Gm-Message-State: AOJu0YzBxxq/qQ1MsswVqWjcaxGC7iSzhtdcK34ymrzT22Sbo55wJ3p3
	sLHmK9YJDFhl8ZlR0FHGB5ovYVny+KERJguuue7/e3Ra5KOe6hKZn0ukbuKWXtfhAVsu9qk+dSy
	N8i3mDFt0cBoCwmH8WqPToQACxsU=
X-Google-Smtp-Source: AGHT+IGryIF97jL72LtObexbretu1TBnT67f9tiepatQNyfk+8+b+X25SMytGgrA2Qx65P6YIFaHKS/Oh3kTbZktFJw=
X-Received: by 2002:a17:906:794f:b0:a7d:c148:ec85 with SMTP id
 a640c23a62f3a-a80ed2d1de8mr142537866b.62.1723518726153; Mon, 12 Aug 2024
 20:12:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813002932.3373935-1-andrii@kernel.org> <20240813002932.3373935-10-andrii@kernel.org>
 <ZrqxXfZE5bFy-5qv@tassilo>
In-Reply-To: <ZrqxXfZE5bFy-5qv@tassilo>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 Aug 2024 20:11:51 -0700
Message-ID: <CAEf4BzbNdOUv5iUbkmw0n2uUWK78kUcbjs92pJc1EhGHqscGGA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 09/10] bpf: wire up sleepable bpf_get_stack()
 and bpf_get_task_stack() helpers
To: Andi Kleen <ak@linux.intel.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, adobriyan@gmail.com, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, osandov@osandov.com, song@kernel.org, jannh@google.com, 
	linux-fsdevel@vger.kernel.org, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 6:05=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> On Mon, Aug 12, 2024 at 05:29:31PM -0700, Andrii Nakryiko wrote:
> > Add sleepable implementations of bpf_get_stack() and
> > bpf_get_task_stack() helpers and allow them to be used from sleepable
> > BPF program (e.g., sleepable uprobes).
>
> Is missing the header actually a real problem you saw?

It's hard to quantify this from production data, because there are
multiple possible reasons to fail to get build ID in BPF program. All
of which will result in "no build ID" condition.

But more generally speaking, failure to read some piece of memory from
non-sleepable BPF programs is a real problem for a meaningful
percentage of cases, so being able to do that more reliably in
sleepable context is important.

In this case, given this build ID fetching code is used from
PROCMAP_QUERY ioctl() on top of /proc/<pid>/maps, it's good to have a
guarantee that if underlying file is a proper ELF file with valid
build ID, that API will return it. It allows applications to avoid
overhead of retrying it through other less reliable and more
cumbersome means.

>
> I presume the user tools do have a fallback to read the
> build by themselves if it happens
>

It's all best effort, strictly speaking, but the percentage of
successful cases matters across the entire fleet, so anything that can
be done to improve the success rate is helpful. Retrying is possible,
but comes with extra complications, which are not always acceptable.
E.g., it's just racy (application might exit by the time we retry), or
will require extra privileges (because user space will be accessing
entire ELF file contents), etc.

