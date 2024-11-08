Return-Path: <linux-fsdevel+bounces-34104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DF49C2720
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 22:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA421F21C4B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 21:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E271DD9A8;
	Fri,  8 Nov 2024 21:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TimYM+Ay"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981ED233D80
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 21:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731102150; cv=none; b=TQNKM818DkynjyYN/Rg0PzvVj8sKvLn52UuUx82OquxrYh5/cH6t7Gi6Pr4MQ+KI04aCpsvdTzr3zcLioK87br3zaKA2BxB+ThAzjGC433Wrs+xGDldSd58Qa6ca83oe1TvTFzXLLIL2MjC048tBNPK7Y/XcF+f/RZHbBaSZ2VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731102150; c=relaxed/simple;
	bh=NpmgcLqFJSqPL2e/BFItLXfuljINd/KJhpfmeWb0oZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aTyHEbC8c1dSHWol8QnWFS1HDuAt/G7FV7QFVWGiM6bPCoBEUetQuJYOb9rvIPRksUTY/RF1BpO3DNC3+d+BJSrKVnfK76U7WnVBK6A4pMo0xUueI5EVnPNqSbRJHmH+MkHbuBe6DZV3+fFR+XTdvB8a9HOoHfYsKmKrtJSJJ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TimYM+Ay; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-460b2e4c50fso17312651cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 13:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731102146; x=1731706946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cRCwbpKjjIqOK5lS+eD2zYiVNNi39iKV2tM/FA/gpI=;
        b=TimYM+AyBQ1PTpNyYdzP/LjemU/Dz4Qmy7K0yNFFJR6Cn3X3rzPsCCQPS/ZQQrWJlP
         Bekd8Ltk7meB9dn87YUA/pVFExbIyZHJZyokxvRfEVDnjR+pwKOsUnpJIymDICgdM+Tb
         WxAfQJ9w3Yem1hciEVtVwLzgdZ7w/jHdtpTUcIfivgqkxqVo/HsvV104r3GQj71X7J/8
         TvoNfwtRzAoJDHs+2lReYt3n/F4qtyP1BTmSbH5DYngRvK1aS+NH9IXDUKTTLG4X65YX
         vJ4dpjs/vLk7N4mmQLKV3OMHNWpcrM4LippPM+uoz4muoVr3P0Tqr7jcYGZeC46UzM8W
         ghOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731102146; x=1731706946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cRCwbpKjjIqOK5lS+eD2zYiVNNi39iKV2tM/FA/gpI=;
        b=fMynS2mbeLI/Pyj+82+8mFgf22z2i/Pw5RuERSO9u8I7IxzK9XWFmEqlee2POfMzl3
         Dip5MRmNq1XM9sC/KAfLGE4/AuY+5IYi9x+yRz56Z+dXf6MgaoMDX76JVdCL6GVEwhlj
         VyYKBHzJpzvAxs1y/7zt5CXExl+hVPqWQos24a7IrYtvhZ1d/0fHtyhuW5T92q8EkmvS
         4tA1mKoXjVwRtq4U7Cx885MviTFkbiuYRGmV1sqFMB7raNt7MNhcpVhwnudLU8Ox2QOv
         ZLnKHxUH5BjRSC2eyp/5twO6oRFy7KaCTAUdz8SmCNAOG7rJ2M2fVMIPiALL46mTREFh
         sS2w==
X-Forwarded-Encrypted: i=1; AJvYcCWq4MJUinOJJmgd1FL2fts5jQlACFo1mN9eCZvvBmVC27W6juA0GwkQdh+cfI6imphJxCQkj5GGEtYE2ZhY@vger.kernel.org
X-Gm-Message-State: AOJu0YyTL2ngSkFQZwXnSAn2O6OYWSeYuvbbCwr3XWUi1dKCy7BrGkO9
	g/aVOvGi5/zj8CdRwJzbNFNdBkdPLl9Ivu8QmBzUQVxB/VohNTtEzlFXSeMJydSsjS2QOTUBf75
	E45zRVA+NmgMDHpNjopPKb9yndII=
X-Google-Smtp-Source: AGHT+IHq100ugMRlsPPoszRN4yErc4jmWDRnK4I2csN1bK6ma3n38X65oAkX29Q25TVJz5DOX18EFIsueG++B03s5oc=
X-Received: by 2002:a05:622a:5919:b0:460:850d:cbda with SMTP id
 d75a77b69052e-4630938b6f7mr70858491cf.31.1731102146347; Fri, 08 Nov 2024
 13:42:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108173309.71619-1-sj@kernel.org> <04020bb7-5567-4b91-a424-62c46f136e2a@redhat.com>
 <4d2062bd-3cf3-4488-8dfc-b0aa672ee786@redhat.com> <ubpkgutgkm2te7tu3dyvjxxkcmhelawd24lyaqnxrbvzgj7psl@zli7u63w4qgu>
In-Reply-To: <ubpkgutgkm2te7tu3dyvjxxkcmhelawd24lyaqnxrbvzgj7psl@zli7u63w4qgu>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 8 Nov 2024 13:42:15 -0800
Message-ID: <CAJnrk1Y-BRg6qyQoUvZW7mUfydp+cM1Rxtd_v0UaKOLuL9OUUQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] mm/memory-hotplug: add finite retries in
 offline_pages() if migration fails
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: David Hildenbrand <david@redhat.com>, SeongJae Park <sj@kernel.org>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, linux-mm@kvack.org, bernd.schubert@fastmail.fm, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 1:27=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> On Fri, Nov 08, 2024 at 08:00:25PM +0100, David Hildenbrand wrote:
> > On 08.11.24 19:56, David Hildenbrand wrote:
> > > On 08.11.24 18:33, SeongJae Park wrote:
> > > > + David Hildenbrand
> > > >
> > > > On Thu, 7 Nov 2024 15:56:12 -0800 Joanne Koong <joannelkoong@gmail.=
com> wrote:
> > > >
> > > > > In offline_pages(), do_migrate_range() may potentially retry fore=
ver if
> > > > > the migration fails. Add a return value for do_migrate_range(), a=
nd
> > > > > allow offline_page() to try migrating pages 5 times before errori=
ng
> > > > > out, similar to how migration failures in __alloc_contig_migrate_=
range()
> > > > > is handled.
> > > >
> > > > I'm curious if this could cause unexpected behavioral differences t=
o memory
> > > > hotplugging users, and how '5' is chosen.  Could you please enlight=
en me?
> > > >
> > >
> > > I'm wondering how much more often I'll have to nack such a patch. :)
> >
> > A more recent discussion: https://lore.kernel.org/linux-mm/52161997-15a=
a-4093-a573-3bfd8da14ff1@fujitsu.com/T/#mdda39b2956a11c46f8da8796f9612ac007=
edbdab
> >
> > Long story short: this is expected and documented
>
> Thanks David for the background.
>
> Joanne, simply drop this patch. It is not required for your series.

Awesome, I'm happy to drop this patch.

Just curious though - don't we need this in order to mitigate the
scenario where if an unprivileged fuse server never completes
writeback, we don't run into this infinite loop? Or is it that memory
hotplugging is always initiated from userspace so if it does run into
an infinite loop (like also in that thread David linked), userspace is
responsible for sending a signal to terminate it?


Thanks,
Joanne

