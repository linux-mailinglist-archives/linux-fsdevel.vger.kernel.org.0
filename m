Return-Path: <linux-fsdevel+bounces-34107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2896A9C2770
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 23:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0211C22761
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 22:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9488E1E105E;
	Fri,  8 Nov 2024 22:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="assHBipu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D80A233D8C
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 22:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731104459; cv=none; b=Ky8WfUoLR1bHwUaSCHPTbhwFby0Io4GMS8ckN2iMiwBkLorQ5THFIOjuUlj1eI8+PgXasv8qYR8zYfTHH1f7Ib1+FWIjr6SEtL3RizN2EYiviG9gKQkkEFvxIJfoP3rR9Cpcatc4IKOWzaDKwhuO7han8WvC5xOO+KU2LUxhNWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731104459; c=relaxed/simple;
	bh=/eV7yIiGClJmlBWDxOZToND9LVAjexaBCVR7wOvI6tU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e7BmjAZzjCOnx2s8TPZ91jS1nVtey40CmfghMA9o8BHvdnR1jhjoQFgf5mlKwJu3go/PErskWUKwLxJr74sGcc0wgH9EbKlqp/LV0wpuPOFkTqWfcA+x2/XFfv5YF2PsSCdxvsz4A4kPDQxy21uHUTwov/1HdKPuli4UZHE9Hik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=assHBipu; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-46094b68e30so17218821cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 14:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731104456; x=1731709256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zk3C+1JTPp3pJQJS7qPZOOhEZbsfkT4VTT27QRdSEag=;
        b=assHBipuVrHUM5ZYqugZQYUbrC0rV9cOmtJlZ9UUIquVYSmJzKaU85DhVisPWSGQI/
         uEIFqbEnw4R5ndWm3DQ4zYN6BffRzKybaotpG1tqlolH1QHj22XiXlpjGDOM3d0xtIuo
         6ctbM0+DaxooDi1XLGrJNmcLaAkS4RzOJ9wrE+ahDXY6WvPAgd2T/m95dqtXUtb+hp2H
         sZCMF2pXyxNwmHY6LY2bdzxeto1LnBN9fSarnTR5Q/xet/A5Cb5eX59aYSk4D5sJF9lx
         juIWjZcfQ1qKB/AvIvdj9OvSR2V+wEQ97VLCyL5yJ++48CGISsEbmSgiVBvjjbxpSE0o
         oNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731104456; x=1731709256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zk3C+1JTPp3pJQJS7qPZOOhEZbsfkT4VTT27QRdSEag=;
        b=e48evOfCQzpdOdQv/qn6l+vG7VXpX5q64gFc44l4BKQqoxBNm4ZYMmvJ6P3y5SBsDx
         enfep1YbHAaqwLWphnNSYZCcij1EB8sGv8I+ij1/oYTecJ+rWToDzcBv0bc/5JCMqP/7
         Bv+TSNliPZrH5pOOVggqgKUoitPuC9FOZQJRqRtxoCx5eQscoZQ5oOJaLG1XA94Hdi+h
         VVWab1fPzLDUFYGZNeD769/rskgUYygM5vRrGjNOsrEiNoyHbXOMZ+844Na/3iUTDV2y
         9aJgX8NtM0m1rESB0+9dnIizuGpp5Hq+goNrCFMOF8338hlcPgnMQooBm+qoZ4sKbuhM
         5k3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVG5ZmXf0XN+1g/77NHm2E+9dyFuDnYBdlRJrnnzhx3QETHFevUIfXvhfIDpNzbIqJR5bZWtCuyfKtEsjko@vger.kernel.org
X-Gm-Message-State: AOJu0YxDFi01ySQpjyV48f5zgrVqEkd90hyY3FR4p1iA8/iK+dR/MDW3
	I+Wv4O6JTWX0sjaoRCAInmCsIdFZLuDBR65tjuEsWqhkcCNW7XEp6zb81p8wxBvXakoihwuJ7db
	8gXYHxp9F3tK8goSZ+2jFXyan0Nc=
X-Google-Smtp-Source: AGHT+IEJ1YZX/IPynYGWqcY7XfO8Q+lX8kNXo13gm7vkOErWnlLDKM2zYGmEjYvPV68EmPEYItvAuXF8074qPtKaxpQ=
X-Received: by 2002:ac8:5fcd:0:b0:461:6054:52c with SMTP id
 d75a77b69052e-4630938866amr58248991cf.29.1731104456457; Fri, 08 Nov 2024
 14:20:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108173309.71619-1-sj@kernel.org> <04020bb7-5567-4b91-a424-62c46f136e2a@redhat.com>
 <4d2062bd-3cf3-4488-8dfc-b0aa672ee786@redhat.com> <ubpkgutgkm2te7tu3dyvjxxkcmhelawd24lyaqnxrbvzgj7psl@zli7u63w4qgu>
 <CAJnrk1Y-BRg6qyQoUvZW7mUfydp+cM1Rxtd_v0UaKOLuL9OUUQ@mail.gmail.com> <2ecmqokellladmioa5rvw57lqbz3ouevx5q5weyydjius3cu2s@vl3siu2b3gs6>
In-Reply-To: <2ecmqokellladmioa5rvw57lqbz3ouevx5q5weyydjius3cu2s@vl3siu2b3gs6>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 8 Nov 2024 14:20:45 -0800
Message-ID: <CAJnrk1Yh8_KCUhfgxmVz6cDjZxNfmrOuFfe-sQsn7uQFTsTnwQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] mm/memory-hotplug: add finite retries in
 offline_pages() if migration fails
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: David Hildenbrand <david@redhat.com>, SeongJae Park <sj@kernel.org>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, linux-mm@kvack.org, bernd.schubert@fastmail.fm, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 2:16=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> On Fri, Nov 08, 2024 at 01:42:15PM -0800, Joanne Koong wrote:
> > On Fri, Nov 8, 2024 at 1:27=E2=80=AFPM Shakeel Butt <shakeel.butt@linux=
.dev> wrote:
> > >
> > > On Fri, Nov 08, 2024 at 08:00:25PM +0100, David Hildenbrand wrote:
> > > > On 08.11.24 19:56, David Hildenbrand wrote:
> > > > > On 08.11.24 18:33, SeongJae Park wrote:
> > > > > > + David Hildenbrand
> > > > > >
> > > > > > On Thu, 7 Nov 2024 15:56:12 -0800 Joanne Koong <joannelkoong@gm=
ail.com> wrote:
> > > > > >
> > > > > > > In offline_pages(), do_migrate_range() may potentially retry =
forever if
> > > > > > > the migration fails. Add a return value for do_migrate_range(=
), and
> > > > > > > allow offline_page() to try migrating pages 5 times before er=
roring
> > > > > > > out, similar to how migration failures in __alloc_contig_migr=
ate_range()
> > > > > > > is handled.
> > > > > >
> > > > > > I'm curious if this could cause unexpected behavioral differenc=
es to memory
> > > > > > hotplugging users, and how '5' is chosen.  Could you please enl=
ighten me?
> > > > > >
> > > > >
> > > > > I'm wondering how much more often I'll have to nack such a patch.=
 :)
> > > >
> > > > A more recent discussion: https://lore.kernel.org/linux-mm/52161997=
-15aa-4093-a573-3bfd8da14ff1@fujitsu.com/T/#mdda39b2956a11c46f8da8796f9612a=
c007edbdab
> > > >
> > > > Long story short: this is expected and documented
> > >
> > > Thanks David for the background.
> > >
> > > Joanne, simply drop this patch. It is not required for your series.
> >
> > Awesome, I'm happy to drop this patch.
> >
> > Just curious though - don't we need this in order to mitigate the
> > scenario where if an unprivileged fuse server never completes
> > writeback, we don't run into this infinite loop? Or is it that memory
> > hotplugging is always initiated from userspace so if it does run into
> > an infinite loop (like also in that thread David linked), userspace is
> > responsible for sending a signal to terminate it?
>
> I think irrespective of the source of the hotplug, the current behavior
> of infinite retries in some cases is documented and kind of expected, so
> no need to fix it. (Though I don't know all the source of hotplug.)
>

Awesome, this sounds great. Thanks!
>

