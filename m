Return-Path: <linux-fsdevel+bounces-39279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B4FA12289
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 12:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973033A52E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 11:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE7620967A;
	Wed, 15 Jan 2025 11:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3LX5oHf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD591EEA54
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 11:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736940439; cv=none; b=Ao+NEezksuiNFSJK+kyObO/rXtUsdC2DK4mW7NcFht+g2PrruVO1w3clkzghJLtV6gOyS8z8KZszhRgpFXIaIPXE/IIcmvYw1gjA4vtrIPTVpANFejhhnmr0Ru2V7TKCHZvTGxIfXbz6R6sv0XKjg9y7LWgklSnO+yGT166b8qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736940439; c=relaxed/simple;
	bh=tC/USVkD7u5A+CkiGS1ymR6/SBGLkkgxeJaxuDF7ATE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AGII9PifcEFacXB7dlmW19WyEyLk85HcMrK6BzQKbj8m8mrL1vQqyndEZMRGEZMDqXPJ9DN2hC5eAbD9FllQVuq/RtTG9rvoEtyt/5zCYY/aLDT6srLJKOWqFHioU3ZjkA0sK14SPpWn9vVjIVbt6fAMYaOMUGHuq0SgPEd13pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3LX5oHf; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaf57c2e0beso1359301066b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 03:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736940436; x=1737545236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tC/USVkD7u5A+CkiGS1ymR6/SBGLkkgxeJaxuDF7ATE=;
        b=A3LX5oHf1cpPbn3IzyI9SPInLQKdjjYIfi64Jc/CnU8ewBcpU8WcD4jZ7Ti7aKYGZb
         GHBVU1eQTtYLnxDt16+CqCHEG2uOmf8L3GWvMMn+CsanJVeievEQYc7Kn/U0Mvh1bV0N
         BiioaWp44ANE4tGuU53/7RFnY+r5s5XyhqPyWXzlh34OD4oTRet8jA6wP2zZTVlsLJsr
         4pSZn47P8PXoXl9eP0/vUwDWUAlmwzNaz9igw8TpqD2ZpKiIxUYGjSabigCN/381lt4H
         aN9z33YTdjyvZs7XRAg1QhoEVnItPvJ4+Q9Pt1pv3C8asqou5ysh2MOGJcYWfTtei91n
         Pu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736940436; x=1737545236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tC/USVkD7u5A+CkiGS1ymR6/SBGLkkgxeJaxuDF7ATE=;
        b=ddNrku39yWova/oqMTVOsa9UmTappr5hYwui6sVUQzG/tmAjQuLIY7klb2z+xMJxhF
         1Lhfrt9GPrVVCrCbQmXHM7MQMm04hACQ9LOuiW8p2GQYPKgNYx58cWsFh6WHjcdrR1kK
         xV4DumDr3EUSOqS1aDcR6sP/t4xs1CcdxKBlK+jtY+tFgJ3Ll53GYLqW2s/HheiGPVhe
         DKalvzcqXmAYB0vZLX2oFLu4iNuJtgUvhrOtUa+fizocEv2dHEFlR7wzKrQMj1aiJVPH
         evvSCr1RMkMdKGhmVE1SqKN+iSx8GKsKe1b29wbOI95ZBV2pmUDMV7COp4/v7k6uTlTi
         t2Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWQbIvOAEFw5R4Y+Hu2AK8NY15upQlDns0mBy3Z7w07TKsZfS6mTT4AlTzQBfIaxo55L0N88ePfSvqXcMK9@vger.kernel.org
X-Gm-Message-State: AOJu0YwaRm8dYbsnNQnheeY0Yi8bIaWj7K3Hiw/xERaNLySlarXFmZy8
	4P52jKs6wJMjTtgNIpm45mQWz6DjUEgnN+4eawyqDFNfSAFy82ZQTYh3rX6I2QniVSsY+uVorNw
	AULGs/GNo/Pe0awQueW+nW+jFEfU=
X-Gm-Gg: ASbGnctsv7JALYCIhbk/B8F3rZbYxIbRuj4rRXXqq/wjOgp/uv81uDXXdy+CxDsLhff
	M8PNSMAxRiUeK89GlO74jbBM7XGmbM4cz7eBqnr6gSCa/WEx+Al6cu4UnkZfMQhvsuEod
X-Google-Smtp-Source: AGHT+IH45zSej/+IjVUCeTIS1QCOIqGy6FhxMLz5CePH9bJAqfiiXOrNw0HIxitnpdaxI/L4g20icyJLfjqZwsNYArg=
X-Received: by 2002:a17:907:8690:b0:aac:742:28e2 with SMTP id
 a640c23a62f3a-ab2ab6a8df6mr2651790266b.6.1736940436237; Wed, 15 Jan 2025
 03:27:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANT5p=rxLH-D9qSoOWgjYeD87uahmZJMwXp8uNKW66mbv8hmDg@mail.gmail.com>
 <CAOQ4uxjk_YmSd_pwOkDbSoBdFiBXEBQF01mYyw+xSiCDOjqUOg@mail.gmail.com>
In-Reply-To: <CAOQ4uxjk_YmSd_pwOkDbSoBdFiBXEBQF01mYyw+xSiCDOjqUOg@mail.gmail.com>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Wed, 15 Jan 2025 16:57:05 +0530
X-Gm-Features: AbW1kvZ2dB3cdO4krmhiL-fP1yIMfDiH076-m9Adzt1SEjJKzvFXgfysprgQ93w
Message-ID: <CANT5p=rxOnq_jtnOpMTKA+ycKYzkJyjESbAkE5zj20h4XtE0Ew@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Predictive readahead of dentries
To: Amir Goldstein <amir73il@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mm@kvack.org, brauner@kernel.org, 
	Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, 
	Jeff Layton <jlayton@redhat.com>, Steve French <smfrench@gmail.com>, trondmy@kernel.org, 
	Shyam Prasad N <sprasad@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 6:55=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Tue, Jan 14, 2025 at 4:38=E2=80=AFAM Shyam Prasad N <nspmangalore@gmai=
l.com> wrote:
> >
> > The Linux kernel does buffered reads and writes using the page cache
> > layer, where the filesystem reads and writes are offloaded to the
> > VM/MM layer. The VM layer does a predictive readahead of data by
> > optionally asking the filesystem to read more data asynchronously than
> > what was requested.
> >
> > The VFS layer maintains a dentry cache which gets populated during
> > access of dentries (either during readdir/getdents or during lookup).
> > This dentries within a directory actually forms the address space for
> > the directory, which is read sequentially during getdents. For network
> > filesystems, the dentries are also looked up during revalidate.
> >
> > During sequential getdents, it makes sense to perform a readahead
> > similar to file reads. Even for revalidations and dentry lookups,
> > there can be some heuristics that can be maintained to know if the
> > lookups within the directory are sequential in nature. With this, the
> > dentry cache can be pre-populated for a directory, even before the
> > dentries are accessed, thereby boosting the performance. This could
> > give even more benefits for network filesystems by avoiding costly
> > round trips to the server.
> >
>
> I believe you are referring to READDIRPLUS, which is quite common
> for network protocols and also supported by FUSE.
This discussion is not completely about readdirplus, but definitely is
a part of it.
I'm suggesting doing the next set of readdir() calls in advance, so
that the data needed to serve those are already in the cache.
I'm also suggesting artificially doing a readdir to avoid sequential
revalidation of each dentry; or a readdirplus to avoid stat of each
inode corresponding to these dentries
>
> Unlike network protocols, FUSE decides by server configuration and
> heuristics whether to "fuse_use_readdirplus" - specifically in readdirplu=
s_auto
> mode, FUSE starts with readdirplus, but if nothing calls lookup on the
> directory inode by the time the next getdents call, it stops with readdir=
plus.
>
> I personally ran into the problem that I would like to control from the
> application, which knows if it is doing "ls" or "ls -l" whether a specifi=
c
> getdents() will use FUSE readdirplus or not, because in some situations
> where "ls -l" is not needed that can avoid a lot of unneeded IO.
>
> I do not know if implementing readdirplus (i.e. populate inode and dentry=
)
> makes sense for disk filesystems, but if we do it in VFS level, there has=
 to
> be at an API to control or at least opt-out of readdirplus, like with rea=
dahead.
That would be a great knob to have for network filesystems. We have to
rely on heuristics today to predict which of these patterns the
workload is using.

>
> Thanks,
> Amir.


--=20
Regards,
Shyam

