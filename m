Return-Path: <linux-fsdevel+bounces-55176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C61AB07814
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 16:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 820A34A4886
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 14:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9587F25C704;
	Wed, 16 Jul 2025 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CB8+OILg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2090220F2F
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676196; cv=none; b=lvTC/k5EzLMWlWJFhr3DpDdsEtFNwvWHN9za3flJnetDo/tSUWU1I0lKo0tDcZswVKusDv+LO+0xSmK+6814MWXZLZXLMWBipWAuExACFahPhLDDEIZJNYld9kDLkY9+59r2eflt/+1U1Hwq2MH1LGpu5yrY1/sL2S9LxLyGUNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676196; c=relaxed/simple;
	bh=01PZ/xKuO5lByV/sYsB5ZFdAMbt7OpQEfhoPNdSub8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mF9L8AXoTgEbW5WaOHuP/dZnV8z669WSx71Mu3bIINvB42V5Ia36jJ/02lngabNgjkKErtfCxT75/P5OEcz3y71+QpQTSOikmjKsp8Prd+WwXxKr1TSCYSfobWQGU2gMdEmB6Lw4P5bEBa4nbaIYvR+mjpdCe/tKaJxKNcLGkcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CB8+OILg; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ab86a29c98so482681cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 07:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752676193; x=1753280993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9dJcIYNmFLt97FV6TaWcTMU/S/O8suqtyZyGxaHRnM=;
        b=CB8+OILgwaZ4T539JjNAnDn/MaCIONMJ0tfXFUFpoFMzLhHrZAfbWb/tvBL11Krtv2
         LfZQAoMSDdcwXOoe30pHwRlCkn9vdtmpsjQgiyWTyWGJumzQWpVTbv7qY1GasFOF5eOb
         OBiF/Gc0Y/fjVSQZrEWHOgVgFaBbuMDypNhikVMyMpByS63JFHS99DzeRhJ2j9eCaZni
         PDWNIZu2Byb73uk61duti0xNI6Dv8ydo8mb7g8oWhAeCS+wdiB/0rd7HiecGmgE5655m
         PpGZN236WNDqc5DS5mb5C2rw3J27hXJ3RZvz3M7b5pnVnN9XWe1SkdyYTNzudFPRi42S
         5QPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752676193; x=1753280993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9dJcIYNmFLt97FV6TaWcTMU/S/O8suqtyZyGxaHRnM=;
        b=Ef1E7KnQHoH0sxl43LxB22GtnDl2dH7M+OcpjLfB/Nz2dv5LoxhKjfCk8s3XlEaiLY
         p9dyzljLNMtv8eTHVrIBa7P2xL0lEJrtRgSN/Ln+88fVwUO2VS8h33PU6hWZRmOfwpGe
         oZsiAvmLeQj14KozkyCznOn4UUEpmqYxFgbkVoMf/QdbZnBx4V5DIObSJFhh3GKNBUJv
         Fr9ffNptt/k/jjPqpa5b+mhjgf0V/5yROqoI1exx5GA5sCEKhVMVToo9cqudQejBQ5mo
         7QSYvDbzSI0KHwE76fO+TeK8e9TcxNy8ryoQkf/Wo0Hdmc1bxS7hG55ndL+gyd+LNE3j
         0SjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmQ1CKDXfk9AhGeN75MtWY3nepBB9NUamJXGJ4VEGkvVpfqX+XXOH4mU23x1U/QqkS+kNRYU8cCPdKSqQ4@vger.kernel.org
X-Gm-Message-State: AOJu0YyFGOHd/6yDgNDclslreC8AEACYlBn9+r/9YHWIZsTfB30ala1P
	Dx9f+kzO2kC00eCG+ylYXK2AbA7iL1vX3kg2Zegv9ZOKgkNv2GR5v9EmPjP7eBWzvFLoyKyt5f4
	RSUjcjPsi2QxG+f2+0MoT5UsVSWZC9Sz4WR3uGpYw
X-Gm-Gg: ASbGncv81cdz33EdE5LXXDvt1X9ZCjhgigD3WHbgHFt2lVS2waaa4BoNWzzuHJeiYsS
	cVmPj+er6HexYmcosjGpYXzs4l6wpVRZYPUtXTxbSysqfq12ITMsJmgsoKNprg4Cc1Q43lHMN1l
	BPq4oTTZA2LzO3rfikrJjTU1MXVxJCuFiU/gLgt0lfn3h+31Agp/rKbvF5ohRaiEr79/qEF/ng6
	IBv4LU0uMeH6hnMI0poktUTtV29AoUR+3Tn
X-Google-Smtp-Source: AGHT+IF1jgIoyk5R1Kif1z4ud/Iv9ltObgmGNfl91kkWVCZZHs4vDHtmbDAOFhVoWxeWru8tTtLk2fMmer7cvrmEICE=
X-Received: by 2002:a05:622a:1aa0:b0:4a9:d263:dbc5 with SMTP id
 d75a77b69052e-4ab954da1cfmr2945571cf.20.1752676192219; Wed, 16 Jul 2025
 07:29:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716030557.1547501-1-surenb@google.com> <20250716030557.1547501-8-surenb@google.com>
 <dd88b2fc-6963-454b-8cc0-7bd3360a562e@suse.cz>
In-Reply-To: <dd88b2fc-6963-454b-8cc0-7bd3360a562e@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 16 Jul 2025 07:29:41 -0700
X-Gm-Features: Ac12FXzno4zj4-9Yms3LsC7vLEmlFKsL-np6yaN8ehs9Whc_WjCHA4V2guD--iU
Message-ID: <CAJuCfpGRAL6YPqTR9SpPPuTamGJLdg4OEGmPUMERYDgjQCHAiA@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] fs/proc/task_mmu: read proc/pid/maps under per-vma lock
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david@redhat.com, peterx@redhat.com, 
	jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org, 
	shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, tjmercier@google.com, 
	kaleshsingh@google.com, aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 6:57=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 7/16/25 05:05, Suren Baghdasaryan wrote:
> > With maple_tree supporting vma tree traversal under RCU and per-vma
> > locks, /proc/pid/maps can be read while holding individual vma locks
> > instead of locking the entire address space.
> > A completely lockless approach (walking vma tree under RCU) would be
> > quite complex with the main issue being get_vma_name() using callbacks
> > which might not work correctly with a stable vma copy, requiring
> > original (unstable) vma - see special_mapping_name() for example.
> >
> > When per-vma lock acquisition fails, we take the mmap_lock for reading,
> > lock the vma, release the mmap_lock and continue. This fallback to mmap
> > read lock guarantees the reader to make forward progress even during
> > lock contention. This will interfere with the writer but for a very
> > short time while we are acquiring the per-vma lock and only when there
> > was contention on the vma reader is interested in.
> >
> > We shouldn't see a repeated fallback to mmap read locks in practice, as
> > this require a very unlikely series of lock contentions (for instance
> > due to repeated vma split operations). However even if this did somehow
> > happen, we would still progress.
> >
> > One case requiring special handling is when a vma changes between the
> > time it was found and the time it got locked. A problematic case would
> > be if a vma got shrunk so that its vm_start moved higher in the address
> > space and a new vma was installed at the beginning:
> >
> > reader found:               |--------VMA A--------|
> > VMA is modified:            |-VMA B-|----VMA A----|
> > reader locks modified VMA A
> > reader reports VMA A:       |  gap  |----VMA A----|
> >
> > This would result in reporting a gap in the address space that does not
> > exist. To prevent this we retry the lookup after locking the vma, howev=
er
> > we do that only when we identify a gap and detect that the address spac=
e
> > was changed after we found the vma.
> >
> > This change is designed to reduce mmap_lock contention and prevent a
> > process reading /proc/pid/maps files (often a low priority task, such
> > as monitoring/data collection services) from blocking address space
> > updates. Note that this change has a userspace visible disadvantage:
> > it allows for sub-page data tearing as opposed to the previous mechanis=
m
> > where data tearing could happen only between pages of generated output
> > data. Since current userspace considers data tearing between pages to b=
e
> > acceptable, we assume is will be able to handle sub-page data tearing
> > as well.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>
> Nit: the previous patch changed lines with e.g. -2UL to -2 and this seems
> changing the same lines to add a comment e.g. *ppos =3D -2; /* -2 indicat=
es
> gate vma */
>
> That comment could have been added in the previous patch already. Also if
> you feel the need to add the comments, maybe it's time to just name those
> special values with a #define or something :)

Good point. I'll see if I can fit that into the next version.

>

