Return-Path: <linux-fsdevel+bounces-57790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABC7B25491
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 22:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D36887B19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 20:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CD9247287;
	Wed, 13 Aug 2025 20:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BX57pz3u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940ED136349
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 20:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755117316; cv=none; b=OnbfWFsuc2Ww5cOkfPOYEk5l/g07QQ9KD1Mg9dIzdZpEqb72fXSIfJVq6+ilISXUNsC+zlrGFGOleNXRERXDOQGG+p+gJ2pYrzuNDD3mboZgpJ0LZDSVwx69SwZ3YCyNMig7g4gmeGqUql/2wSPuTyNugiD1+2LVwtgIdHUF5pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755117316; c=relaxed/simple;
	bh=cUfLr/k6bHuseyyPEXetDz/VMEF5KdKPH6XBz9/3mLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HBY/d30gh61Ztz+FvQJ9nWxEiYTraCJDGK++kkx4zTJ5rBGrASINYKi2lU3CZXJaIdFdmxbTJuI7Yl12R+tBq5jVBi0Srv97Pv2QkXKMdSY7nrTdKCrlJH0TVdgypSJ4iYUg2x2c8oZkgFqonVu+fgB3qcc3jHhVxWd6+8lP+BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BX57pz3u; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b109c4af9eso3002161cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 13:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755117313; x=1755722113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uICrvG6ojAlohoCgGms+JoY6Fk0yJO7Igw8Lx8nnaMw=;
        b=BX57pz3udKvGUzgVYTndNG18MkXuyIP8HgQ2/XjqdvLQTscY+kXiB+EiA5Jy+fiCd4
         ye9UFDhq/R70vOOEV9vUxJQkV7JzhS2I1xRxP3enQAbZvgJ4l5TA8NG5Oa6nx1kRf2/d
         HTmLFJkdAXCLQ2zz5/P/OlvCOs2H7C1xqpyA8X1ijYaUkuVgrWO3NKWtvxocvwKvBrkI
         YrVri+MxS2AF4J0/YjPgW8zTqtNekxSmXt109PWv5DKxK2FFqUy7tqVE1a9Om6R2Qtg1
         UALuYFfqKaGOU6d62Rv7+TTPvwkpTcVpIKM7ovtn2xvlds2GvMwEcV6Jq6yFb85AYJI9
         o79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755117313; x=1755722113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uICrvG6ojAlohoCgGms+JoY6Fk0yJO7Igw8Lx8nnaMw=;
        b=fijBY4kJ0Bg8RNFXSiF8WHnXUaHtulEoxTXCdUAWSjtMyBqdvp2FVvbPxKhBCyhnpy
         i9YaM4FMRC8GjEFEzXxIaicgyMJH+vxlMGXPkmEcHNQ36Dmf/iovNJRyFAfqlG5uIh8b
         bPVYPB4mEGlA6hH/xOoBtg4gWTGob17Iia6HYwIxe8wkc4nBA1MFxNl4tgOR7RMeGqJe
         r/ZAuY6c9DmJbQZOO9PuZSixlDgWXcmyeY89kL328Oe1yIfmSuiGyyas4TOpwmL50XkG
         l8qIFI1FomP1cEjKsRS0wXDZBOfm8GhZ5qozWom4AGnPRTXeP5/H448gPE9ToiijokiX
         YQow==
X-Forwarded-Encrypted: i=1; AJvYcCWAEiPpToEvMs4C6O7MKIWFPj48Mhcvh6ino9BoUEJ9QYOmVOg7YoKpuys+dC2rwXZ5Fu93FYCR2qZSKB+6@vger.kernel.org
X-Gm-Message-State: AOJu0YzEGoPPZx5efa5XGwWzFgLFFbUQsjV7axS1S5Sbh9hYDw8oYrQY
	VywD2GF5ZFMYXiUqsY012LchpVDfHpn7klFE/YVBKxVxeTvQ9/BNkd2fMAAcIKz0ZpPi2s7PNaG
	wVTYOC61ZGMrvnRZzmsyz1MwOeD0LISo=
X-Gm-Gg: ASbGncstW8nDBxB4e2u5y9xumOu4N9PRJ6TrZyCz3fb9/SIwUMxgr05KaPnMZwrmAYE
	5ccPQmMcdfWPbJMELKpGOS8O2ykwISNzo31NGAgwFxUtPulMzy4C8aoLJv+DKeaCc9aZNeFD/vY
	iFghtjje9XujSoBpZLGmep1yr2myaXBsneGxjqdFrD5fVL0VOhP/bovhntSTf8E9PeDx8D2UQh7
	35Vem0i
X-Google-Smtp-Source: AGHT+IGPs59gfEJnrov/iQovf1cjNX8Smc18+bFD57OsuvkLgEXDggRtS9ifS/ms2BIY/gtUoLsCQyWfCwcFwbMxFls=
X-Received: by 2002:a05:622a:cf:b0:4a8:1841:42ff with SMTP id
 d75a77b69052e-4b10a9184afmr9892191cf.8.1755117313165; Wed, 13 Aug 2025
 13:35:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813152014.100048-1-mszeredi@redhat.com> <20250813152014.100048-4-mszeredi@redhat.com>
 <CAJnrk1bfoumJHwc5p-WASXYxWG8tzz91LfzpiEkPTSOoTDK1ig@mail.gmail.com> <lhuwm776n92.fsf@oldenburg.str.redhat.com>
In-Reply-To: <lhuwm776n92.fsf@oldenburg.str.redhat.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 13 Aug 2025 13:35:02 -0700
X-Gm-Features: Ac12FXy80ui3s19vOkSdZ17X3xiPGSincLLZKxmNVobFFf1osDxpeB_KHdVYmM8
Message-ID: <CAJnrk1ZpG5RHQEaBu3vnK80fLyXRBTQj0-K2PzG2pZk18om7cQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fuse: add COPY_FILE_RANGE_64 that allows large copies
To: Florian Weimer <fweimer@redhat.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Bernd Schubert <bschubert@ddn.com>, Amir Goldstein <amir73il@gmail.com>, 
	Chunsheng Luo <luochunsheng@ustc.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 12:21=E2=80=AFPM Florian Weimer <fweimer@redhat.com=
> wrote:
>
> * Joanne Koong:
>
> > On Wed, Aug 13, 2025 at 8:24=E2=80=AFAM Miklos Szeredi <mszeredi@redhat=
.com> wrote:
> >>
> >> The FUSE protocol uses struct fuse_write_out to convey the return valu=
e of
> >> copy_file_range, which is restricted to uint32_t.  But the COPY_FILE_R=
ANGE
> >> interface supports a 64-bit size copies and there's no reason why copi=
es
> >> should be limited to 32-bit.
> >>
> >> Introduce a new op COPY_FILE_RANGE_64, which is identical, except the
> >> number of bytes copied is returned in a 64-bit value.
> >>
> >> If the fuse server does not support COPY_FILE_RANGE_64, fall back to
> >> COPY_FILE_RANGE.
> >
> > Is it unacceptable to add a union in struct fuse_write_out that
> > accepts a uint64_t bytes_copied?
> > struct fuse_write_out {
> >     union {
> >         struct {
> >             uint32_t size;
> >             uint32_t padding;
> >         };
> >         uint64_t bytes_copied;
> >     };
> > };
> >
> > Maybe a little ugly but that seems backwards-compatible to me and
> > would prevent needing a new FUSE_COPY_FILE_RANGE64.
>
> Even with a capability flag, it encourages the presence of bugs that
> manifest only on big-endian systems.
>

Interesting, can you explain how? size would always be accessed
directly through write_out->size (instead of extracted from the upper
32 bits of bytes_copied), so wouldn't the compiler handle the correct
memory access?


Thanks,
Joanne

> Thanks,
> Florian
>

