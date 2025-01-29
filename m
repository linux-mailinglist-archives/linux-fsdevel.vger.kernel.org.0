Return-Path: <linux-fsdevel+bounces-40272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2350BA2160C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 02:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E7A518877CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 01:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BBA1779B8;
	Wed, 29 Jan 2025 01:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSzaw9fm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B7C25A641
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 01:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738113965; cv=none; b=CFjYrWoYedPS/MokGImYcBBdrsanyl/m1JsiIA/R3m/HOJETMF7AkrceHiAYYvKHtZuPYQpLkBPQhnEgu0nM5zMiMbuR25ozkcXGoSRhkSlKNJdw2tMNjCRsWY1kKcAHpkue/4FgWAsvk4xEvY36XGbL0GXuD3nFe/+2MGjirEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738113965; c=relaxed/simple;
	bh=Taz/zS3kYLMy0ZgGVAe/f51YeZlrwVjP6HZ9bJOerlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBIW7R/HJoMGF3dqNkxZ1xpkvDQFDSKdoVBlY9aSW5mygD4xhND3u56dhQhTu+mBe0g1Sc2ay6c9Aq2AO6aDnDwZNWgwGokxGELc7rDyjmT6o6SFMFBpY7Y60RvLCHlkCojFJoGwXtA6S1diq9QXvcuCyb/I9mpOGT9u8fN9OyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSzaw9fm; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-467a6ecaa54so54799451cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 17:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738113963; x=1738718763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJxgDdVu4VnEencq7uAkHLaqv2cHzoxF+zokk9mDXeo=;
        b=iSzaw9fmMbuChoWFhWPKjVB27LwI1Nyct967vjBoleZURtlbzYdqbnDJu2n11/NG6/
         WcRhG7+IaATj4ALojUjGg8swcFT1BzSWl4daAROU4A2XeCIxpEcQEt6ofvPA3CPXrWYu
         9er+yCYlPYgbOFKWN2PV3hT/9Jn/F6jN9ZdpYs2jHaCVLx+PV3bNgMQd12OWnUv9+n9B
         PWRq6IOnF883sI1//OBZvSSKID9QmSyvVfem3Wwa/Pha3yZrdt0FqFKf26+cKdT8LL3X
         P1/3HzOrfuc6Kc3tiSdRAtMQjT9VxdgOJ8CB7Ey6S0MKtriTvBIICBvahePsEFTIloeO
         CxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738113963; x=1738718763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJxgDdVu4VnEencq7uAkHLaqv2cHzoxF+zokk9mDXeo=;
        b=ZkUJ+cJjICUC++XMHrLmJxWVT7M3Q/nPzfIub4onmMSZhDp/93qy2xjbRFbunrm/rP
         G4tKd/NNOmpnN5y1q1PIPrBtfcAJG2S834LKpfXkuC2zKJ63Zn3nSshP5JwzL0+0pXIQ
         Cx1EPa5Hs4xccpq2egiQ7AIkQCOoY7SikDf2mme924xyI61ds0HRWrmxphZMcTsXDktU
         bN3RC3mC15HqvPxEI31bkFN8qVKB7lJh/K39ucVOpZIRqKFPY9XWc33pKoxjDrjn/wqP
         24k/IeQ2fnBdxpigYGCbPijP/fbxj3A/2B9FUsnL1gV2HijytnTLwfqXWYExWASTYHaO
         0/oA==
X-Forwarded-Encrypted: i=1; AJvYcCXnObKFX2trGDTMaBbHM3OwAtMnxLFJKS64NizHmqP/PoZk5oJXFeMOxFppoCJPXnrz+3M5yCDR5vbg+c0+@vger.kernel.org
X-Gm-Message-State: AOJu0YxOF6vHN2orHJsxqapSJ6GyJdjjT3ms0DXlg7hfmciFE8Y75tk+
	dBBslui6mS2kpJ4Dagn0Ntxr6OG0STpNy04Wqrcq6fhzJiwk2zxOV2G0P0MqjLdoZuzWPByYy1r
	W/MHwFtWJqYNTpITBRDD8geqzLG0=
X-Gm-Gg: ASbGncvREB49b8oH9d8HQBZtIWda3xGxlStWMmVEspJdTPNHC3K6Da+PjRL0/Q7Y3iL
	rlOM62PboRAA32tGwog49pwrOoDtBGI1Q+NjgA1D6ImGxR8uL5EdfqlikAYG4XGKPzKVJHIGzBg
	==
X-Google-Smtp-Source: AGHT+IEhGF1kpI+7LxVd6jDQIdFNufW6YdGnkM8qBgbzXX1TjXE09XqaZHUC9TqifxPIDCLKe0XLNAMoVTTme86zjuA=
X-Received: by 2002:a05:622a:244e:b0:467:7fbf:d121 with SMTP id
 d75a77b69052e-46fd0a1dc54mr21557761cf.12.1738113963066; Tue, 28 Jan 2025
 17:26:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJnrk1ZCgff6ZWmqKzBXFq5uAEbms46OexA1axWS5v-PCZFqJg@mail.gmail.com>
 <CAJfpegsDkQL3-zP9dhMEYGmaQQ7STBgpLtkB3S=V2=PqDe9k-w@mail.gmail.com>
In-Reply-To: <CAJfpegsDkQL3-zP9dhMEYGmaQQ7STBgpLtkB3S=V2=PqDe9k-w@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 28 Jan 2025 17:25:52 -0800
X-Gm-Features: AWEUYZmrM3sG-2CiyD2ojmc3iyFacdaY05MAVSjZ1G-qEecMOLpqLi1RfLYIVJE
Message-ID: <CAJnrk1ZEuCsDe6hhUy2Ri_a-KXk4zXUftrCHKvhN8GFrTFQVtw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Removing writeback temp pages in FUSE
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: lsf-pc@lists.linux-foundation.org, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, Zi Yan <ziy@nvidia.com>, 
	Jingbo Xu <jefflexu@linux.alibaba.com>, Jeff Layton <jlayton@kernel.org>, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 3:10=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Mon, 27 Jan 2025 at 22:44, Joanne Koong <joannelkoong@gmail.com> wrote=
:
> >
> > Hi all,
> >
> > Recently, there was a long discussion upstream [1] on a patchset that
> > removes temp pages when handling writeback in FUSE. Temp pages are the
> > main bottleneck for write performance in FUSE and local benchmarks
> > showed approximately a 20% and 45% improvement in throughput for 4K
> > and 1M block size writes respectively when temp pages were removed.
> > More information on how FUSE uses temp pages can be found here [2].
> >
> > In the discussion, there were concerns from mm regarding the
> > possibility of untrusted malicious or buggy fuse servers never
> > completing writeback, which would impede migration for those pages.
> >
> > It would be great to continue this discussion at LSF/MM and align on a
> > solution that removes FUSE temp pages altogether while satisfying mm=E2=
=80=99s
> > expectations for page migration. These are the most promising options
> > so far:
>
> This is more than just temp pages.  The same issue exists for
> ->readahead().  This needs to be approached from both directions.
>

I was assuming the cases for readahead and writethrough splice was
going to be covered in the more generic mm session about which
existing things in the system currently lead pages to be
indeterminately unmigratable and which can be handled vs not. David,
were you still planning to propose that as a topic? Maybe if there's a
solution for the readahead/writethrough splice case from that, then
that could also be applied to writeback too but if not, I think it
might still be useful, given the non-trivial perf improvements we saw
in the benchmarks, to align on whether there's any acceptable option
that exists for removing writeback temp pages or whether we should
abandon the attempt altogether.

> This year I'll skip LSF but definitely interested in the discussion.
> So I'll watch LWN for any updates :)

This discussion about the FUSE writeback temp pages (and depending on
that, the problem of how to integrate large folios with temp pages
writeback state tracking) imo would seem more fitting as a BoF
discussion as it seems pretty FUSE-specific. Maybe if there does end
up being a discussion around this topic and it's a BoF, there could be
an informal videocall option for it?


Thanks,
Joanne

>
> Thanks,
> Miklos

