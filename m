Return-Path: <linux-fsdevel+bounces-70085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2370CC9040B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 22:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C523A9B73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 21:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D77318135;
	Thu, 27 Nov 2025 21:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPwhbzWO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C2E311C35
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764280375; cv=none; b=EDYYBo++xWcHwB9zpepaw5kcJyDuRU0qC0VxAbnZl7jRh1YQ4RpIaHqeFJB6moGEnm6zU3HFTHWbIPSexjHogVESa2tdDlMGUjyGB+t6fucq8YawNYapNYYGywRMSWbwjhbwuNlW3P1uG1kyt9bXcCoVkWD4SIgmY3yg1XnnAR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764280375; c=relaxed/simple;
	bh=4Pj66Y3umMwlrabEjE1lX88865iL+KzgEAusgbBYyKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sVXHAl1Fuuiua6BG8xGvy5Dg09YhNtHd4iMq5M+Yn6N9KvQP0m5WhEciIVUahpK9N3Vw3OygVSdMqNxnCFgnfkjYq0+MGobxL3BLSbA2buZghb2amCJNEQ1DzXSnr/g54+9/g9JQp7z9cVxfQX17/bedUqExYuMFClG+lJdWtWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPwhbzWO; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8824ce98111so18450176d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 13:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764280372; x=1764885172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jttLJ8TWGePu+ngSo1n4o5hp2pzXFGAv2t0XowsTZMg=;
        b=TPwhbzWOGf2/62dZBmZzJ1KK5GHczMKctFSVTSa02I984aRldpda+C8QshDpc60TDR
         F5P72PVJXZwZshQZvo1i5TCNEE2NAPygOLOl4TOugZXYL0MAxIMuM5vPLF8RH6++Q84m
         o0LotgaHJqtgnpDQTQ5kvmgWhv0q+H5S/LUYsZ0Fwr7mq2GqZHfy7miVERXYk1L7O14P
         RpYHDpZysn6fHCW/+mYBMo68r6vx8ylPWwYXn/F3rVWP0Ao4FgcV7walYCt33RKgAmJO
         DVrsqWgjtircVXIRuUIDi11fkXTasnYkejpxTk7kfHTW6OdPtC7X61KxmtfNrCMMDGbs
         U3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764280372; x=1764885172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jttLJ8TWGePu+ngSo1n4o5hp2pzXFGAv2t0XowsTZMg=;
        b=sR/lPr7r/y9bWsAgaNjxY+EWYUXcX8hRS3MN9u1Xgw37N7RDlyowDuHtTUZBUR/NMQ
         2w2E4Ktfr6F9zTXyFunHr7EXlggSDZHe9a2OMVzhKcuYaQ6qZkatb3a0UKWaxrblU30m
         nnqdWrBtCvhj3eygSVjb7jrxmZO0bhA3l77kgyoKTkzscti4sxbxEiaD+DKuUefxXSrU
         3e4b8/DuZw13RHBSWO4DJX/+SaiJHizhPlO0LOl2VzeFOfhXmoGD3e9wZUET+7sbIbcS
         uf5rlN0MpDtne5TZrg12K1UkFs8IfypB09bV+TB0dU/SdJWqfUGrdzWTl+Ei5x1nt8sE
         h7uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQJDZV4QGXrQzeY59gyqJdkVWo/y7YYNvouNyNtCoEjorCB4xz1TmTT7ZLL31OuQ7fd1bzAPuIe9ddjvOm@vger.kernel.org
X-Gm-Message-State: AOJu0YwsPg1nmx6/KwgDbIo/aO3rTdX6hQPdTABk9tE2yhgzUDJDjKt1
	KdwRb+/fFPNaOlr35YLxS8SmR7wbuoDE3sK9humlPRSBwne4aXY8tx8B/DIjq8oFVIXISnSa7aM
	KMwstd7j6RlUyOh3fCTgYGhfnOs+UOTY=
X-Gm-Gg: ASbGncu7D321uB3o0koZZdCIbo7nmBl8bipaBleSgFmlZRlooqAjiRd2n6Tkgt77fCx
	tjYCt4+QVgpOgprPPczMIvGBoEufKEN4G+b7MinjC6/8Dea7Z5y7k9dTu/OaL13ZbdLJamvT7HN
	yccZJVEtP6uTH41lL0NyXLxzjBGTl6WL4guEXCc3uiGZZXmYSQHW/dYQP+xDWkEfhYAS/HmFvoF
	qxg5NxPzSMa68g6tETPSQTArBLAvsZucopyPgq/SkSrCdXZRJk8JLDtAXwcBatrf6jgNw==
X-Google-Smtp-Source: AGHT+IGi53ssJfVFEVeCKpbOH4PM/Uba/gyP2VL/mpIj2xLrn6No0jDJl3wOawm61ht0VMTz1HcUV32B95MPtil1ISg=
X-Received: by 2002:a05:6214:19c9:b0:880:49bd:e217 with SMTP id
 6a1803df08f44-8847c486a0bmr364162506d6.10.1764280372486; Thu, 27 Nov 2025
 13:52:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127011438.6918-1-21cnbao@gmail.com> <aSfO7fA-04SBtTug@casper.infradead.org>
 <CAGsJ_4zyZeLtxVe56OSYQx0OcjETw2ru1FjZjBOnTszMe_MW2g@mail.gmail.com>
 <aSip2mWX13sqPW_l@casper.infradead.org> <CAGsJ_4zWGYiu1wv=D7bV5zd0h8TEHTCARhyu_9_gL36PiNvbHQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4zWGYiu1wv=D7bV5zd0h8TEHTCARhyu_9_gL36PiNvbHQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 28 Nov 2025 05:52:40 +0800
X-Gm-Features: AWmQ_blYpw-GPSWAvHSSwIXD1PKL1aIx4iCUo78DT2gXpdF1CZ018OhwLE5_XJY
Message-ID: <CAGsJ_4wvaieWtTrK+koM3SFu9rDExkVHX5eUwYiEotVqP-ndEQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] mm: continue using per-VMA lock when retrying
 page faults after I/O
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 4:29=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Fri, Nov 28, 2025 at 3:43=E2=80=AFAM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > [dropping individuals, leaving only mailing lists.  please don't send
> > this kind of thing to so many people in future]

Apologies, I missed this one.

The output comes from ./scripts/get_maintainer.pl. If you think the group i=
s
too large, I guess we should at least include Suren, Lorenzo, David, and
a few others in the discussion?

[...]

>
> >
> > This use case also manages to get utterly hung-up trying to do reclaim
> > today with the mmap_lock held.  SO it manifests somewhat similarly to
> > your problem (everybody ends up blocked on mmap_lock) but it has a
> > rather different root cause.

If I understand the use case correctly, I believe retrying with the per-VMA
lock would also be very helpful. Previously, we always retried using
mmap_lock, which can be difficult to acquire under heavy contention, leadin=
g
to long latency while the pages might be reclaimed. With the per-VMA lock, =
it
is much easier to hold and proceed with the work.

Thanks
Barry

