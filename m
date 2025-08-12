Return-Path: <linux-fsdevel+bounces-57591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82812B23BAF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 00:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97CDF2A7F32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 22:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE2D2DEA99;
	Tue, 12 Aug 2025 22:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfN/JBwI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575372F0669
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 22:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755036891; cv=none; b=dUAdF1FKl7CetEH2DTyAKoqUAfDlH7/74JtSAeY/mny19azKYDAyx75KqehG5ot/ryKtXJrDmIfQhHn4Q7QTzBooXYRyGMfIZx2Rok8kzvau+1aJm+hnsvWT55QJfmG8QBDMBT+mkZedkGnm6iFmZC9t610g65Xg6FVLuvdJKAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755036891; c=relaxed/simple;
	bh=QoxYZpbpPjLVCi2RozTU73DUXSyCs6iw8cP3ErEioig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TmfNgt2+nEIb7DbnAqLVztb/4PybrJuPwKSEtXgalbTQhw22GgjGh/FXcoivpPnJq1mSUTJcBYYs3ESsS2d/T6r5+6xhqcRhJp+WItTsWrX98Gu+8vKdhkW4A7g98wc0s+Igo4ajwpcyuDI8jIQUuMy8frkclFd0rZ3mRyiKiAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfN/JBwI; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b06d162789so69721381cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 15:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755036888; x=1755641688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoxYZpbpPjLVCi2RozTU73DUXSyCs6iw8cP3ErEioig=;
        b=JfN/JBwIHtT7khc9NeKIbNSnnYihrhiUb6nPJpZUf9fDhplytx93zhjMq3UmulHuAx
         5FzMZFgyO8USvM7Rcv20WQaEBd1Thl8GedHAsIFCHBNlTiMpJayrbcShyhtPA8KqsIlM
         UODyN8VfZezeKmodZZCQic52mfVz9pH5h0ZqkPWkYVVlgFQjwPfLBE5A3QIA9fgxcZuN
         8VELfhCpoFzf4i7uSdgx9ynUe5gVLRknDlU6ydjiFLXnWmjA9pwzNJUt/+yuS5qk4KW3
         NO0X3uYyxGfFJZ0szXiiPhcxg1JCHRt82XUTAif6+EXZ9JRnf4cjy4akAmYUdPawkosg
         u8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755036888; x=1755641688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QoxYZpbpPjLVCi2RozTU73DUXSyCs6iw8cP3ErEioig=;
        b=geoaAehXcEoK4pfhpkSqJkrqnEIMcQLVNVibA9WFMGz9TaAnrpoxx6vJZ52Ey7oJcn
         xFJ0iZcJHMiuyr7ipofwbDXcNHCsu5XBS0mgw2z/7tC8r5OZP4L+i/tDAxrzOHBPFuqi
         CM9nmPsl7f+xYF/K6Znn7unrzgpBeKASjIGe5PcTBBGngSP6IX3gPCVFUJf/vwk3XUJH
         ggwbm1LktlTELv7ZOt+oJaisKIGj1GXP6dSI0a4y34WenAILCfBMc6xq7EZPElkyAcLk
         qEMSLrEga3FE6eEmkI3EyXUZmlieMAwxaJQqPACPjyqn2ye1fqc6so9EOCCBJoyhIY6V
         5CPw==
X-Forwarded-Encrypted: i=1; AJvYcCW6y80DbSRtEQ6R57Vt0Tmub4QIaQ7GBoHJ12xcrqRjAjyq8/Ln+l1jpMWKll8M3ARXaHVydg+/QPnDVTun@vger.kernel.org
X-Gm-Message-State: AOJu0YyHDUSLAx2P3E96kWUxxqjVLP4QPOXfPmt0JLnaordQdW3OIoXs
	3TkQc9eOtFfOzcgJ27wICZvT0ZXp8JaZL6cH3aZLv8wJjX7ca9NyPEoMAW7sR96w0R20r8x0W/g
	M4SDdxWDAHnpEHUC7Lk1tQwRT60BfWcc=
X-Gm-Gg: ASbGncuAAuRq3r2WxEH7DJ2Gq+hC18GP+E239NLiclIu6ol3ayXQkjC0EBcsGXbDKgS
	NtC2MPfPRdHu3DsELhGVuJI63P1T+ekVAEMFIwTvLUo/vqMTri+L5NvgEYK9tqhhhqBotxtOCJh
	M8mjhrgkVV0cm/xk00cxospP2JoA0FdO8jrpQlQ8TutYEtrY5EAxZ1dW/gbfXILvZokcPbXzHHH
	U4KKs3f
X-Google-Smtp-Source: AGHT+IFv5Oo2ua/E+dWrf8rEjBjvGaM8cc33XQ/Z2JGgsyO9MBL6I7vytY6OvGK1y0vw4e5Qmw0XQ8HHjcgbcriycns=
X-Received: by 2002:a05:622a:1f07:b0:4b0:dde4:7fbb with SMTP id
 d75a77b69052e-4b0fc68c254mr12066511cf.10.1755036888117; Tue, 12 Aug 2025
 15:14:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJnrk1ZLxmgGerHrjqeK-srL7RtRhiiwfvaOc75UBpRuvatcNw@mail.gmail.com>
 <20250812032538.2734-1-luochunsheng@ustc.edu>
In-Reply-To: <20250812032538.2734-1-luochunsheng@ustc.edu>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 12 Aug 2025 15:14:36 -0700
X-Gm-Features: Ac12FXzHEH03TIYntK7YKgbluGitLr8nqCdjoHlKkmzF5m0CNtsCRzf_P3Ks0kc
Message-ID: <CAJnrk1ZAZm3ayvRu_6Ke-ByHrRSP6rAsrZHzUMLmOFfCSyBUvw@mail.gmail.com>
Subject: Re: [PATCH] fuse: enable large folios (if writeback cache is unused)
To: Chunsheng Luo <luochunsheng@ustc.edu>
Cc: bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, 
	kernel-team@meta.com, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 8:26=E2=80=AFPM Chunsheng Luo <luochunsheng@ustc.ed=
u> wrote:
>
> On Mon, Aug 11, 2025 Joanne Koong <joannelkoong@gmail.com> wrote:
> >>
> >> Large folios are only enabled if the writeback cache isn't on.
> >> (Strictlimiting needs to be turned off if the writeback cache is used =
in
> >> conjunction with large folios, else this tanks performance.)
> >
> > Some ideas for having this work with the writeback cache are
> > a) add a fuse sysctl sysadmins can set to turn off strictlimiting for
> > all fuse servers mounted after, in the kernel turn on large folios for
> > writeback if that sysctl is on
> > b) if the fuse server is privileged automatically turn off
> > strictlimiting and enable large folios for writeback
> >
> > Any thoughts?
>
> Should large folios be enabled based on mount options? Consider adding an
> option in fuse_init_out to explicitly turn on large folios.
>

Hi Chunsheng,

Personally I'm not a fan of doing it through the init request because
it is tied hand-in-hand with disabling strictlimiting (which requires
admin privileges) and imo
a) it feels clunky that the user needs to opt into it for writeback
(for non-writeback cases, ideally large folios are the status quo) and
then also find the bdi that corresponds to that fuse mount, then go
into /sys/class/bdi/* for that bdi to disable strictlimiting, all
while making sure this happens before write workloads start
b) I think users (who most are not familiar with kernel internals)
will likely be confused by what large folios are and whether/when they
should opt into it or not

imo if the fuse server is mounted as a privileged server, I think it's
reasonable that strictlimiting could be turned off by default.

Thanks,
Joanne

> Thanks
> Chunsheng Luo

