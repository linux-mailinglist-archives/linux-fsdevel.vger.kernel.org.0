Return-Path: <linux-fsdevel+bounces-45471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6357A781B3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 19:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F75D7A50D1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 17:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDDC20459B;
	Tue,  1 Apr 2025 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDyPDnpv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D20F1D95A9
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Apr 2025 17:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743530025; cv=none; b=uVXWa3c5sWbIN5OUzJ8YdZdCP2edFXVWpBd2TxQLvzq7Wr6TpApPE8W+t9Ce95q19wSGISC8DRTCCa5zpWGTeo3If1JM+KKFXJHaxG6YXg5QPxYnlQ/X6jfFlRClYkUsZ9lbJlPlxEgbkOPnr7YcGn+fr4yvYeHoW5f68/QhlXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743530025; c=relaxed/simple;
	bh=ELtEbwyWn9IU9i/OfS2cXR1WMrwWmpb2kmstAKMzzkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o84BXLp8VNt/p3SFmt68GPKDU1swMdnRlxgAsH1/2w1tRGdb3qPQ0psLXQSOkP0TztBPmxOjKCkjjDKLFvGIpV9GIdBxe/L72JncZWbJ47I5kDBn1m+bf/Qcy50yowtNKrDHOlHqK7P/HdOQc9XKBQmE7pvFXUUZWTFx4v6Us6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDyPDnpv; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c5675dec99so214913885a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Apr 2025 10:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743530023; x=1744134823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZV3opnykoFyTLMOH/BZC2uJPDKHqgfRSYGW+7c7/yw=;
        b=ZDyPDnpvAzcJvg7oIvvoq4zVAIMwBHDJ2gPx70STCmAGb7nmtvV5O7uOLDGcxWTm6G
         JJ0+jgRYnUecIHGTW0X0mqjas9PHGT6p/h9K4qX1ZSHYXtTsIP9Gqcy0RjOZkpYSm39h
         +UYAqbbOAbd5sBjSSA24bVTd7yztd0/hyV+8K149QrlOLGC0TP9vyvD9Iqjc25DCcM1U
         PMPNzjLdRcbKwOhjxI4rUn4XqeLIQQ7VBJnfpiX+HLus4d4PDR9RveEYDveW444Mp+Vc
         SWwHQkuf98W7ITwwHB1ZqLqald7tuGeBniEqIIW0fRoFwHAz4pCVGdbYyETte52ugzQ0
         TUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743530023; x=1744134823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZV3opnykoFyTLMOH/BZC2uJPDKHqgfRSYGW+7c7/yw=;
        b=wh3mBu0S80AQ5odF28lWwzp0/a9woLgnpyQNsUcrCNnAPgJMmNiDgX6NTEbPLM71NA
         yCzM+vjsVMrqS6eNMLJotc4nQ8IQotn4+SasJY0POdjHhL3Zaiv1RCgJ3lwUPG0raB3n
         +VA/pDFzqxotkM1pAMxeayQs65vOOvVlquGDTlTQ2HF1XyGFHldbPE8yxE9/RPv0pm9z
         PUWOP1C5cRkFjI0MsbdwG307rzFw1L5lnShk3LfXpMSyfwKkaca7hgk5zUdgPgUYclmM
         0x/Y9zH5XsknzgrKnAztNR3z8j2ubINSouYSGHQCJ1jrocDFyCcBR5Hg3w2XASvj7vTD
         NUQA==
X-Forwarded-Encrypted: i=1; AJvYcCUojGhUywchlRglyxzgUvr2C8uAHLJY2Kr0X1pY925rXytuXmQhMj9w5cQbK/iFCNAger5ZpvsLaFSCillG@vger.kernel.org
X-Gm-Message-State: AOJu0YyPfz7vPYgDSBULDqZK/M712tSVFXkd40aixIBfyfuW63B8p+xM
	MsJl/SqQzPDQILGvk3rjoG+l67Aca6vXLj11n2P/L7aaawSt8SPNal2vSeKA0/gxzASJvfmW74R
	kZcHQpxtKyiSb3/DLEiIujhJEkgg=
X-Gm-Gg: ASbGncuW+oDE0yDfm5kVQvij7t5nUcxavoJ6UVxeeiUajo4PzYIirwaWTgvfOfpGnid
	uqTHxl0CRW5k474oUI+jZLkWdSnsO/SB8aAEKGeAv0fKB8NQl7kbLye1QZevGk7PfmNxUVBDgYI
	hsK1ZJS8w2KSS5TGHx0CZruQIYjA==
X-Google-Smtp-Source: AGHT+IFeBMXd3RwuUxr6J3MM6BVVql8fQcFUYp4EAHDlEXYF9EXaQ8w9cWlq+FJ/Z7nAIl1cIqTv1CN4X5zi3LiejoE=
X-Received: by 2002:a05:620a:46a4:b0:7c5:497f:1002 with SMTP id
 af79cd13be357-7c6908754b7mr2029328285a.46.1743530023032; Tue, 01 Apr 2025
 10:53:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331205709.1148069-1-joannelkoong@gmail.com>
 <CAJnrk1a4fzz=Z+yTtGXFUyWqkEhbfO1UjxcSk1t5sA7tr8Z-nw@mail.gmail.com>
 <c2ab84de-84b7-4948-8842-21dd8e8904b3@fastmail.fm> <CAJnrk1YgRVqQriykVRuburcGK5oN8bzGRNTvyKhr19P-siJ4xg@mail.gmail.com>
In-Reply-To: <CAJnrk1YgRVqQriykVRuburcGK5oN8bzGRNTvyKhr19P-siJ4xg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 1 Apr 2025 10:53:32 -0700
X-Gm-Features: AQ5f1JogVbXTB5q0CBdvhKcmHPPPpMg7Wo3CJxhdvuBbiS12gNscrT0hD3oTt2w
Message-ID: <CAJnrk1ZBECeMoUnMmL4dtd7DjFDYtykodvaEYmzsSwh=0YaCDg@mail.gmail.com>
Subject: Re: [PATCH v1] fuse: add numa affinity for uring queues
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 10:50=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Tue, Apr 1, 2025 at 1:11=E2=80=AFAM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
> >
> > On 4/1/25 01:42, Joanne Koong wrote:
> > > On Mon, Mar 31, 2025 at 1:57=E2=80=AFPM Joanne Koong <joannelkoong@gm=
ail.com> wrote:
> > >>
> > >> There is a 1:1 mapping between cpus and queues. Allocate the queue o=
n
> > >> the numa node associated with the cpu to help reduce memory access
> > >> latencies.
> > >>
> > >> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > >> ---
> > >>  fs/fuse/dev_uring.c | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > >> index accdce2977c5..0762d6229ac6 100644
> > >> --- a/fs/fuse/dev_uring.c
> > >> +++ b/fs/fuse/dev_uring.c
> > >> @@ -256,7 +256,7 @@ static struct fuse_ring_queue *fuse_uring_create=
_queue(struct fuse_ring *ring,
> > >>         struct fuse_ring_queue *queue;
> > >>         struct list_head *pq;
> > >>
> > >> -       queue =3D kzalloc(sizeof(*queue), GFP_KERNEL_ACCOUNT);
> > >> +       queue =3D kzalloc_node(sizeof(*queue), GFP_KERNEL_ACCOUNT, c=
pu_to_node(qid));
> > >>         if (!queue)
> > >>                 return NULL;
> > >>         pq =3D kcalloc(FUSE_PQ_HASH_SIZE, sizeof(struct list_head), =
GFP_KERNEL);
> > >
> > > On the same note I guess we should also allocate pq on the
> > > corresponding numa node too.
> >
> > So this is supposed to be called from a thread that already runs on thi=
s
> > numa node and then kmalloc will allocate anyway on the right node,
> > afaik. Do you have a use case where this is called from another node? I=
f
> > you do, all allocations in this file should be changed.
> >
>
> I don't have a use case I'm using but imo it seems hardier to ensure
> this at the kernel level for queue, pq, and ent allocations instead of
> assuming userspace will always submit the registration from the thread
> on the numa node corresponding to the qid it's registering. I don't
> feel strongly about this though so if you think the responsibility
> should be left to userspace, then that's fine with me.

Thinking about this some more, if the responsibility for numa affinity
should be left to userspace, then that should hold true too for
configurable queues, no?

Thanks,
Joanne

>
> Thanks,
> Joanne
>
> >
> > Thanks,
> > Bernd

