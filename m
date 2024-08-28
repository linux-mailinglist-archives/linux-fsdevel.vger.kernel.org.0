Return-Path: <linux-fsdevel+bounces-27543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBD19624FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 12:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360441F24A81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 10:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F1616C692;
	Wed, 28 Aug 2024 10:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldSd9mY4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E255216C680
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 10:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724841194; cv=none; b=Px9wFo5zu5kHDYTP1tKOiRBaYzEVVVSd8XHSAB9NkUaQf2y9N8Uy8a5qZ0/4COJSb9Z7QKbahhoXiO7YsHwtlvKA+UwnZXOdt14uN5h072u6iRKBzAG1rrBPYlNcX05MTKzPqNdU53InzGTgs03UcDGQ7W5+0ajhD0VGNtVxCxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724841194; c=relaxed/simple;
	bh=ERT/Lj/oip3ia9VnZxEruZ+wtZTFWrQ9ftJbZFKo3Mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9FwK31F1wywlQAJVlS3sKX2qKkdid8AGi/XkJTj/wU9dDSzlo7BNSTuDNvCnlOB9KvI5xVtijIDiNblIQoutQyrXr8kYR4/FpxzP2r9Wrbfbj9HGKQlDXwvUNRgjyD6aKkL74W6x41buGsU173RaqG6uoarB9MfTXztEucsdJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldSd9mY4; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d3c05ec278so4811513a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 03:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724841192; x=1725445992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERT/Lj/oip3ia9VnZxEruZ+wtZTFWrQ9ftJbZFKo3Mw=;
        b=ldSd9mY4lNFm5zC5xjAOdPIAOSQD42UXyMkYUBQuvpYmVpd1smmwGAhatJqwcNMFdn
         ReMJIbYOvKsO/pFwz0Gtam6T7cesyMp7OiTYFh3vIqSFyL3WN3GstnAHskt8m+tGlsHA
         mdCfTLQrHPra29b1gppRwWmZESQB1q2usbGD9LMC8Atwr+vis7vLl0frXp875Ha81QWJ
         W0AWh011FkKQvn7kTzMKwha5mZS2Lr48TQcm2vtkoKMS9wtp54qd7Gtx1w2u9QZ1S7I9
         IFgrxVWWYFh4b4esHtlMOSgVLeNWcY6vsf035zJPBt8+rF/JmO5q6meR7ghn+pZxr0D/
         144w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724841192; x=1725445992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERT/Lj/oip3ia9VnZxEruZ+wtZTFWrQ9ftJbZFKo3Mw=;
        b=E9PV2NkXvucdYqMm8znD+cTzOTY5Iz0S7jaMYhQnGDX7F17LBLwszSWTAfZBz5RuiM
         7EU6tL2gMxbiBkHnFT7d7ETaCJaGSmf/6bc/fBdqGTiu9UGN90tfWZmLsKnqhAz/GkwM
         prmrr2cXmmQmVz77mKvJ3VWNryRrXh6Cm7MnzKPNhhtzZwxHfMHamxmQx3C1w5cpghjm
         zp14zLRzqOR3eiMPE9K7CI9GDvyj9nfXLVTTdaPOEc4UpK23JD8RaxX+gi2kshVTtpXg
         IrJLJk3ndl9+LGTG3ntUzev9O21vJ3txZGk8DRu8Pj5klpO9Cak/Be6a7WdPyTAPmCi7
         pAdg==
X-Gm-Message-State: AOJu0YzI/2zTQjkFrJSIma16rTKlKdISG3RWMgQWkiI3GP9zC8/vhYPz
	a2ZENYoCRfFIIVKwTCUBukZO5Ll/cXYl1P7HUTvsVAVnqY7ZqidkY5uOxvT599pb9A6Yd0aMbWR
	oJBvvZmG+fblndWBU4w3e5HR1DIE=
X-Google-Smtp-Source: AGHT+IEILa7dftgSns3/OLg1V+sBGNybOsBfq6BWZpYYpHiLfvVaUYS4pkCL9uUhc4t8hq1IQdL6Ta38DoMIHAENruM=
X-Received: by 2002:a17:90a:dd83:b0:2c4:b0f0:8013 with SMTP id
 98e67ed59e1d1-2d646bcc06dmr13714341a91.11.1724841191962; Wed, 28 Aug 2024
 03:33:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOw_e7bB3C_zbpq6U+FdrjbwJAOKFJk1ZLLETrR+5xqRmv44SQ@mail.gmail.com>
 <CAOQ4uxi=9WpKFb24=Hha_mwj9=bsj9qxiv0f0Z-FMfuBRCvdJA@mail.gmail.com>
 <CAOw_e7YnJwTioM-98CoXWf7AOmTcY29Jgtqz4uTGQFQgY+b1kg@mail.gmail.com> <CAOQ4uxhApT09b45snk=ssgrfUU4UOimRH+3xTeA5FJyX6qL07w@mail.gmail.com>
In-Reply-To: <CAOQ4uxhApT09b45snk=ssgrfUU4UOimRH+3xTeA5FJyX6qL07w@mail.gmail.com>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Wed, 28 Aug 2024 12:33:00 +0200
Message-ID: <CAOw_e7axjatL=dwd2HAVcgC4j8_6A393kBj7kL_VHPUKfZJaqg@mail.gmail.com>
Subject: Re: FUSE passthrough: fd lifetime?
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 12:06=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Wed, Aug 28, 2024 at 12:00=E2=80=AFPM Han-Wen Nienhuys <hanwenn@gmail.=
com> wrote:
> >
> > On Tue, Aug 27, 2024 at 3:48=E2=80=AFPM Amir Goldstein <amir73il@gmail.=
com> wrote:
> >
> > > BTW, since you are one of the first (publicly announced) users of
> > > FUSE passthrough, it would be helpful to get feedback about API,
> > > which could change down the road and about your wish list.
> >
> > I guess it is too late to change now, but I noticed that
> > fuse_backing_map takes the file descriptors and backing IDs as signed
> > int32. Why int32 and not uint32 ? open(2) is documented as never
> > returning negative integers.
> >
>
> It seemed safer this way and allows to extend the API with special
> return codes later.
> Why? what is to gain from uint32 in this API?

Consistency. Almost all fields in the FUSE API are uint64 or uint32.
Having it be different suggests that something special is going on,
and that negative numbers have a valid use case. If they're always
non-negative, that could be documented.

Similarly, it looks like the first backing ID is usually 1. Is it
guaranteed that 0 is never a valid backing ID? I am not sure, and it
would certainly help implementation on my side.

--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen

