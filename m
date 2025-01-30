Return-Path: <linux-fsdevel+bounces-40425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B97A234BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 20:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E4E3A6547
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 19:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE6A1EF081;
	Thu, 30 Jan 2025 19:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vQnmABSd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7FE1E522
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 19:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738265983; cv=none; b=umt91R3QbLBOysca8+JffNIszXE8ZQxtijJy1kmodYwLJIFyl3nll6WP5BKJaWmTarqKl5URgpsZxecCJUe0EzRPxBm18/9Q0U+try1XiWTWl8lrK7L0+61+hSW/+IbqPeo7Q4RKWjcZCKUen0KQozXm4yQHQSGjRdqa8w1CI6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738265983; c=relaxed/simple;
	bh=YYTR6rXZKCuinMW1yjrx0nf3HNV/krug3GDdTcW3CGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlQEIG3VvdYbl6IP+3YKD+g0xCwy/1lWbYkDZOJXnUbDs7/EDBX7IFBUVU5XOzfWsTDXQsLavxQrmlDF931H9r3eMjVAEScVdluT+kNJAp5Y1oDJ22r+geLyAfMZrOMflEMfErV8JqJAQzrRJb3DmNRLGyiKehoiRaxccDp01E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vQnmABSd; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4679b5c66d0so31741cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 11:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738265981; x=1738870781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYTR6rXZKCuinMW1yjrx0nf3HNV/krug3GDdTcW3CGI=;
        b=vQnmABSdOlWnkXPSHcbsEW8UscW1X9qwYtpfjCeKbIzAB0dqM8AVJBbacG7g0oHQug
         1HyDJ34MhzA/bVJvkvX73FN5FqQKar/3mWi6C3wYNWA+awG+IonidvItjvCI3qtaM/Wx
         nWOUxWy54o6GbIgerlKKymvinC8+f+hrGuZJ5q0P14g0MFtwpm6x1M12pk4RzKWILOry
         +Yr0IxoU+a1hsHnf7qOygk0IFj+vQ8NMvZiLMdFI2OQmFVo8Lwu0Iza569//J4lt0QbT
         /2IhPgebvvb0KTc9H06vj4Xw6ucpIU24MCFpvBB+XqEW5Q/h/mzvEa1NbyDr0NVvt7at
         1I0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738265981; x=1738870781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYTR6rXZKCuinMW1yjrx0nf3HNV/krug3GDdTcW3CGI=;
        b=qrejQ8SgGks/EQPa7nr4yROKfCQstJy5T6KMCeohkvoUqHoSoAVmnitgmuy89XB6EK
         urvtSESHuhmtP4ZH5JO54GnN++8e3fKpXXdADRdw98KmY6b3hsS45uvR62pxSYOpWpyT
         goYILJrrDbIupE+uwwsd/Nnc/v+BXpaQ6rkOCiZepBpfs6eVaDbte7zIseJBoodNrrE3
         DH1c+tGhsE2cxjGcssJPsUrKyRSniNHdueftnbSYyniQa7i6GTCCAgj4QFRGDW5nVBCX
         tPRzPBMBOhQktxArEtkR9sPsVChD3aEmYJzXImx5I3ZSvJqO9g6Y+zsUe0URPUQfIkmU
         P08Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNyoxyyKHfEQaY64Ya0KPu/JOdRVAt2orC1WlkJMJPxW4/k+5auJiycncgUsNgWrDqtsP6MG8NW1EEEdrS@vger.kernel.org
X-Gm-Message-State: AOJu0YwE6B66MpRYk23eifHhukt4sLYCZDk/ejvHA6q0nzBaR2vRL0zo
	xNa+hIYlJVhMS8/8dppAdoKFBnWCW/LXbf4y8CWAiKngJIgk4kvt0ai9dU24LN2a+EZn9OewHaH
	gzhdI9GobIIodg7lcQUaGD9P4l6LoW9+8sm8V4yQkKro1nWSwUw==
X-Gm-Gg: ASbGncvn1QsvDPz0YykiwcRcViWpCWwZlxQVcxQ4Ul4gTNzWjhQr4OyF11x3y7YNAM4
	oui3xtYDCGkQ4VPEnrrhq4WNcx4D4SsIiTj1VOsob+nzNZQ8d3CGVkoirjzAg864oRYTvZw==
X-Google-Smtp-Source: AGHT+IHhKBd7dNubRiwyGndNcsiaFwetl/eM0V1Kf3Op4HcqGv3uLGgg1Y37PP3XKrjCj0ShSAdSCry7Oyv/CyMjvS4=
X-Received: by 2002:a05:622a:181f:b0:46c:78e4:a9cc with SMTP id
 d75a77b69052e-46feb0d5af2mr179561cf.25.1738265980886; Thu, 30 Jan 2025
 11:39:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <882b566c-34d6-4e68-9447-6c74a0693f18@redhat.com>
In-Reply-To: <882b566c-34d6-4e68-9447-6c74a0693f18@redhat.com>
From: Frank van der Linden <fvdl@google.com>
Date: Thu, 30 Jan 2025 11:39:29 -0800
X-Gm-Features: AWEUYZlTkvH928Ha5DSmcYuBqPngMiE6zModhb0fpz3OEznPldEh7lpaOmc5cEk
Message-ID: <CAPTztWbVjObmLc9=WXPx6fAfuVT3B7+gts7gQmGseWjS37atvg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Migrating the un-migratable
To: David Hildenbrand <david@redhat.com>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Jeff Layton <jlayton@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Joanne Koong <joannelkoong@gmail.com>, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 8:10=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> Hi,
>
> ___GFP_MOVABLE allocations are supposed to be movable -> migratable: the
> page allocator can place them on
> MIGRATE_CMA/ZONE_MOVABLE/MIGRATE_MOVABLE areas: areas where the
> expectation is that allocations can be migrated (somewhat reliably) to
> different memory areas on demand.
>
> Mechanisms that turn such allocations unmigratable, such as long-term
> page pinning (FOLL_LONGTERM), migrate these allocations at least out of
> MIGRATE_CMA/ZONE_MOVABLE areas first.
>
> Ideally, we'd only perform this migration if really required (e.g.,
> long-term pinning), and rather "fix" other cases to not turn allocations
> unmigratable.
>
> However, we have some rather obscure cases that can turn migratable
> allocations effectively unmigratable for a long/indeterminate time,
> possibly controlled by unprivileged user space.
>
> Possible effects include:
> * CMA allocations failing
> * Memory hotunplug not making progress
> * Memory compaction not working as expected
>
> Some cases I can fix myself [1], others are harder to tackle.
>
> As one example, in context of FUSE we recently discovered that folios
> that are under writeback cannot be migrated, and user space in control
> of when writeback will end. Something similar can happen ->readahead()
> where user space is in charge of supplying page content. Networking
> filesystems in general seem to be prone to this as well.
>
> As another example, failing to split large folios can prevent migration
> if memory is fragmented. XFS (IOMAP in general) refuses to split folios
> that are dirty [3]. Splitting of folios and page migration have a lot in
> common.
>
> This session is to collect cases that are known to be problematic, and
> to start discussing possible approaches to make some of these
> un-migratable allocations migratable, or alternative strategies to deal
> with this.
>
>
> [1] https://lkml.kernel.org/r/20250129115411.2077152-1-david@redhat.com
> [2]
> https://lkml.kernel.org/r/CAJnrk1ZCgff6ZWmqKzBXFq5uAEbms46OexA1axWS5v-PCZ=
FqJg@mail.gmail.com
> [3]
> https://lkml.kernel.org/r/4febc035-a4ff-4afe-a9a0-d127826852a9@redhat.com
>
> --
> Cheers,
>
> David / dhildenb
>
>

We have run in to the same issues (especially the writeback one), so a
definite +1 on this topic from me.

- Frank

