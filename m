Return-Path: <linux-fsdevel+bounces-64290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E749BE02AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 20:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61B5550837D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 18:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB85233EAF6;
	Wed, 15 Oct 2025 18:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABqpJ7Ek"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA381519A6
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 18:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552509; cv=none; b=ilBeiW5iWq2FdwXkew+idhJXamunwN3cL+ESjA1q3capREi9W6vor9mBwqpvtfwJXc5BemF0R7xRt1YTeqBdkXZGo1E9ajiVJsts1s/ib0z8Si5iuZeHjgPergGWrJj8ITOIaVMbbIAK53DDRTpF6sfV+pUMK7I1Xkb+opPo8B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552509; c=relaxed/simple;
	bh=xnHTzgCJhJfAjaQf5Iwvu9AJsBigAESwuF3dE9O6yqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tDE8sqkWEnclOPa3Wba/sj6iM2GD73IjvOJ8xbdCpLEWLFknbzHszGMsheLbQ6Z6HAMsqJRMikh0JhoVa7SgiYJXExnvQc9YmgCtqE1MfHIUw1kDXg1RA6v3iYlUlp2U2Yvh9fyaMTO1B2BWrp3DFud5z20cB2SmLiZIqR9EgPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABqpJ7Ek; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-86420079b01so231795485a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 11:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760552506; x=1761157306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnHTzgCJhJfAjaQf5Iwvu9AJsBigAESwuF3dE9O6yqE=;
        b=ABqpJ7EkbB8UEAPe3TNHCIu9Z11J7HpKcNiiYD1KZa7Gkcd5iV0RRn0hWVZCpfSKA4
         ozOB8k7cTlVEqf+BbHKtDFUo0f02HEjnkFfd7/YsMfsX9lSmPd8EPA351ZcsyszSFXrj
         jp/F4kuz81q/JwPmGmqOqbToRn7ios1yfbBLihyX8C3bG7LGn6j4MXtmEt4Dhc4cjrUG
         +BM4KuxvWUflDqHhudMMOZXkIqEG6o3bO4YOHYbO4ZnnFe2eKr9Sac5XG0/zbZAyjrec
         6htSNnBinlX1wKn6FQpDTk1RRYaNPVi0Y9O4PtsV+3P2QAQ0n+1sT/bJhpcHIKm8cA8n
         XZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760552506; x=1761157306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnHTzgCJhJfAjaQf5Iwvu9AJsBigAESwuF3dE9O6yqE=;
        b=FjyQGEbkDEhJ4dCOjU+zNwno0VwP9S+/8n5+jeUGGqrNljKyUc0nbjXr4h2OAWmSqE
         cq/OWYwjHs9s2mD9o6xoMBGLSsEDsdvCVKffnYor5YrjiyfvUz2bo+OGzN8Tj6K/Z/9r
         sNr+ZnRpkqyELKCCrH8jXxhGfCHQ3KBdrm7HiYmySIMMFVHICQVjCQz0mHsVHhMujP+l
         t8l2B8ODsLBaHMMdeWsHGTS3YaqeUcZNDD3b1HDaret1CwPMpGUtWbuwPXixOWn0PEwu
         pv3ZzpDZHttmaD755jWnk+l1P8hccbBVptl51UkTdx0eVtB2E3IQ6OUl32qskSuINsWt
         +Low==
X-Forwarded-Encrypted: i=1; AJvYcCUbsQ8+o3Vb2U1GLUqMy7JoedHrsffkYPjjCBqTTXJSxbgYtUe4l6RDO4cjrmLmWduMKsK6wxDT9AyDcZ7Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Z7mBUV60u3cfQJbUnZn5ibXyTjOQRKcH+YiqhZE/S1Nr0pVH
	rAvn+3f84a0xTfArKjEfTB4iJQ9bIbatg0A24P32G8yj3QRYyexfvDReCSmJJyMQlOtGWxyvNCO
	Ltdpa38TKzi7WQUlHNX3Vtx8WG/Nlm0o=
X-Gm-Gg: ASbGncvHma5qkZ8Zils9+WesCYVoBIpt8AfKXXoYTpn1p5JvbdG6HBcyIu3GvVrjYEK
	Ygfvxnqb+iU/UVqkirVAifC/TdkwoxnEULhjnVrrosS5KvkOkQtnI/DuLpvHzONre5EhbL6nVQD
	rXzPNzPDPW2EW2b5Rm51GGxq3cAUlOI4NbrKw/Xg9hl9JDPImt3NVasUsl5eUKTmRoAZgJwnwkr
	HIXsbZ+FTz873/n1F7KTpR3Tdi/61zVrwixk4bpwPWKCUziqdFXcstKtzIonnworlAl
X-Google-Smtp-Source: AGHT+IFIrhgO9yu3Wu8+NKBBfqkdirFtdOow9gxbgvURHYyV17jgLC1lo0eVlkJObl/+YCGyJWGzel3n58TcuAzGnz0=
X-Received: by 2002:ac8:7d41:0:b0:4b7:9abe:e1e4 with SMTP id
 d75a77b69052e-4e6ead8011emr392797091cf.82.1760552506083; Wed, 15 Oct 2025
 11:21:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009225611.3744728-1-joannelkoong@gmail.com>
 <20251009225611.3744728-2-joannelkoong@gmail.com> <aOxrXWkq8iwU5ns_@infradead.org>
 <CAJnrk1YpsBjfkY0_Y+roc3LzPJw1mZKyH-=N6LO9T8qismVPyQ@mail.gmail.com>
 <a8c02942-69ca-45b1-ad51-ed3038f5d729@linux.alibaba.com> <CAJnrk1aEy-HUJiDVC4juacBAhtL3RxriL2KFE+q=JirOyiDgRw@mail.gmail.com>
 <c3fe48f4-9b2e-4e57-aed5-0ca2adc8572a@linux.alibaba.com>
In-Reply-To: <c3fe48f4-9b2e-4e57-aed5-0ca2adc8572a@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 15 Oct 2025 11:21:35 -0700
X-Gm-Features: AS18NWBjkSGay6FYfd2ymHOA-NdDXZpI0_6NT0m_TZnJ4JNXh2JD4Nw0FkB4_JE
Message-ID: <CAJnrk1b82bJjzD1-eysaCY_rM0DBnMorYfiOaV2gFtD=d+L8zw@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] iomap: account for unaligned end offsets when
 truncating read range
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org, djwong@kernel.org, 
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 11:06=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba=
.com> wrote:
>
>
>
> On 2025/10/16 01:49, Joanne Koong wrote:
> > On Wed, Oct 15, 2025 at 10:40=E2=80=AFAM Gao Xiang <hsiangkao@linux.ali=
baba.com> wrote:
> >>
> >> On 2025/10/16 01:34, Joanne Koong wrote:
> >>> On Sun, Oct 12, 2025 at 8:00=E2=80=AFPM Christoph Hellwig <hch@infrad=
ead.org> wrote:
> >>>>
> >>>> On Thu, Oct 09, 2025 at 03:56:03PM -0700, Joanne Koong wrote:
> >>>>> The end position to start truncating from may be at an offset into =
a
> >>>>> block, which under the current logic would result in overtruncation=
.
> >>>>>
> >>>>> Adjust the calculation to account for unaligned end offsets.
> >>>>
> >>>> Should this get a fixes tag?
> >>>
> >>> I don't think this needs a fixes tag because when it was originally
> >>> written (in commit 9dc55f1389f9 ("iomap: add support for sub-pagesize
> >>> buffered I/O without buffer heads") in 2018), it was only used by xfs=
.
> >>> think it was when erofs started using iomap that iomap mappings could
> >>> represent non-block-aligned data.
> >>
> >> What non-block-aligned data exactly? erofs is a strictly block-aligned
> >> filesystem except for tail inline data.
> >>
> >> Is it inline data? gfs2 also uses the similar inline data logic.
> >
> > This is where I encountered it in erofs: [1] for the "WARNING in
> > iomap_iter_advance" syz repro. (this syzbot report was generated in
> > response to this patchset version [2]).
> >
> > When I ran that syz program locally, I remember seeing pos=3D116 and le=
ngth=3D3980.
>
> I just ran the C repro locally with the upstream codebase (but I
> didn't use the related Kconfig), and it doesn't show anything.

Which upstream commit are you running it on? It needs to be run on top
of this patchset [1] but without this fix [2]. These changes are in
Christian's vfs-6.19.iomap branch in his vfs tree but I don't think
that branch has been published publicly yet so maybe just patching it
in locally will work best.

When I reproed it last month, I used the syz executor (not the C
repro, though that should probably work too?) directly with the
kconfig they had.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20250926002609.1302233-1-joannelk=
oong@gmail.com/T/#t
[2] https://lore.kernel.org/linux-fsdevel/20250922180042.1775241-1-joannelk=
oong@gmail.com/
[3] https://lore.kernel.org/linux-fsdevel/20250926002609.1302233-1-joannelk=
oong@gmail.com/T/#m4ce4707bf98077cde4d1d4845425de30cf2b00f6

>
> I feel strange why pos is unaligned, does this warning show
> without your patchset on your side?
>
> Thanks,
> Gao Xiang
>
> >
> > Thanks,
> > Joanne
> >
> > [1] https://ci.syzbot.org/series/6845596a-1ec9-4396-b9c4-48bddc606bef
> > [2] https://lore.kernel.org/linux-fsdevel/68ca71bd.050a0220.2ff435.04fc=
.GAE@google.com/
> >
> >>
> >> Thanks,
> >> Gao Xiang
> >>
> >>>
> >>>
> >>> Thanks,
> >>> Joanne
> >>>
> >>>>
> >>>> Otherwise looks good:
> >>>>
> >>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
> >>
>

