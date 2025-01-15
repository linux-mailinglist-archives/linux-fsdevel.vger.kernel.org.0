Return-Path: <linux-fsdevel+bounces-39301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A86F7A12607
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 15:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89D8188CB66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 14:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A85D78C6C;
	Wed, 15 Jan 2025 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alufC6GM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468D843AA9
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 14:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736951433; cv=none; b=aCLduLcqi0Eg5bLe7PpO3BFNeJomx40hRCr5Pd25fYvz+OfQxJB97mySIeFvasq2B1VVuSF4d/fiswZ1z/sbuuPFmkV83rIZfGrkDn3s3yT2LR0CG14A3uWfrRiAuKxa0S2GXQ/iy45+vjWC0zpFlGhNEB3IahhmYU7mv2+ZTCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736951433; c=relaxed/simple;
	bh=sCJC02eMOdA0o+qrOQIriyJQhWHEmCP/bNjox33kIpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ceftx7EYmKXnXJhhfIIcgJLs0BpMhGd8CyhMbVcIi1iM/VdRKEx4Kq2eVcPXifaMgUQHRX/GPPipD5Wp7j2Wi7ORH/itl4ZcDBH4eTHVduueVI/D6+b9/qfJ8u2ivad73umi5qENe2rQ7IQglUrjIzsVUmCZl0KFRqVx40zCnwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alufC6GM; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaec61d0f65so1351730066b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 06:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736951429; x=1737556229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCJC02eMOdA0o+qrOQIriyJQhWHEmCP/bNjox33kIpU=;
        b=alufC6GMtw2yQvLXzSEo/ULHeOZVIcva6lfwNuOYb1TPPxlRgaIBqQ0TlXYAcUKUXH
         edy4wd6PpOik+C5SA6QyVNLtqYgXDMPYaYAAZ7BeWnIJm9CMie5FmvLjdyhSL70pMV74
         J3sz49y9nC9axnVWR4F1HRLPn9sEytU23iFMJBysocI3sqmzIGY61yikiOY9WHHYSdLr
         sZjeGGkqoAVFjE5EbvVq96uS5OJkne7isMMYAjqk+ps7ZniXfus5MwEP/ik2znPPC4B5
         uYJS1bK+3fk1HtUmKSAwglB1l4/GfCJYcqn3DPn9gsL5JpcKl6YbemyATy7fYswdQSyy
         Ae8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736951429; x=1737556229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCJC02eMOdA0o+qrOQIriyJQhWHEmCP/bNjox33kIpU=;
        b=FGpCciSvwkkxDZoMPZpDJ5pqtws2Acq+aRvTCYwGtl11J+3/AO1SeiPk4+79Y1Iv8F
         IGp9djZsHPiNcO/+oOLRdvCuSR7oFZI9w4jmaYL50D5YiR3Ji4mS6wZSuKb2cTFOKdz6
         OlwCGd8sma8/zj4W/lHm1DjXYC6AfaH3gkYvEnK1fww3K7kXBUm7R0bA9D7VJJ3Gh7ht
         mglWSx2J462r5TmYTZYQIpznkY5hR3fdIz431sXc0VizNrAEoHDjCrcUD40uBatUNi3o
         TijsEUHGR3w25O4snonvZfhzT5GxE5kcV7GX6NqmOkVI4WjuAmnKWrVdWoneaIqtFR94
         R+lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpyx/SqAahf+TKgHMie5diYdkrssw5huy9aFxxpXYp8VbliUmsV8b9noio3GxEb5ftPPaW1/NjT4yxyTah@vger.kernel.org
X-Gm-Message-State: AOJu0YyePHuo/uhjnnJAh6bVGJDmR3/ndWJNdx6P1I2kabWI0GXCuIMA
	p1HIFfpeseyj0UhLfRkNZDy/iRHIu59wZhmMUqEorza3RHGkxB8FlWEGF2muSxsMo42RKIbIuyF
	smJZ9F+VaFRfflYg36HFRkF21Wr0=
X-Gm-Gg: ASbGncswllVLIgJG6zZZE/fm6c5IDs4ovZQp67vsGRrgpmb8l7A2cUKj2ArLCJPTlj9
	jhfc7M+c8ukVVeBZJQxLeNw1TabJZ7QzZnoKdFoRHkK2aM3ImLDE0JWGz1PYd9IPYx/N/Xg==
X-Google-Smtp-Source: AGHT+IHkYjkVBNjoJsdzJ0DyFJuugBprc54W+XoQWHG6fXpYKdRkvKlwNObdMmVbrn90prLvBAZj2q0yzNNV4Kh4KSo=
X-Received: by 2002:a17:907:1c24:b0:aa6:85d0:1492 with SMTP id
 a640c23a62f3a-ab2abc6d423mr2838381466b.37.1736951429202; Wed, 15 Jan 2025
 06:30:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANT5p=rxLH-D9qSoOWgjYeD87uahmZJMwXp8uNKW66mbv8hmDg@mail.gmail.com>
 <CAOQ4uxjk_YmSd_pwOkDbSoBdFiBXEBQF01mYyw+xSiCDOjqUOg@mail.gmail.com>
 <460E352E-DDFA-4259-A017-CAE51C78EDFC@redhat.com> <dbc41d4c3113c0e3a7915d463ddcb322@manguebit.com>
In-Reply-To: <dbc41d4c3113c0e3a7915d463ddcb322@manguebit.com>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Wed, 15 Jan 2025 20:00:17 +0530
X-Gm-Features: AbW1kvZxXJF1cn4PgRgyinppCUqG_5upMAH8uxcLMF9S6w7BaIRYpL59BoIfeaM
Message-ID: <CANT5p=r1t5hG9jQ8Py1VkvkNFxLJpGUXimxVBTR=ApqEFWL6hA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Predictive readahead of dentries
To: Paulo Alcantara <pc@manguebit.com>
Cc: Benjamin Coddington <bcodding@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
	lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mm@kvack.org, brauner@kernel.org, 
	Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, 
	Jeff Layton <jlayton@redhat.com>, Steve French <smfrench@gmail.com>, trondmy@kernel.org, 
	Shyam Prasad N <sprasad@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paulo,

On Tue, Jan 14, 2025 at 8:31=E2=80=AFPM Paulo Alcantara <pc@manguebit.com> =
wrote:
>
> Benjamin Coddington <bcodding@redhat.com> writes:
>
> > On 14 Jan 2025, at 8:24, Amir Goldstein wrote:
> >
> >> On Tue, Jan 14, 2025 at 4:38=E2=80=AFAM Shyam Prasad N <nspmangalore@g=
mail.com> wrote:
> >>>
> >>> The Linux kernel does buffered reads and writes using the page cache
> >>> layer, where the filesystem reads and writes are offloaded to the
> >>> VM/MM layer. The VM layer does a predictive readahead of data by
> >>> optionally asking the filesystem to read more data asynchronously tha=
n
> >>> what was requested.
> >>>
> >>> The VFS layer maintains a dentry cache which gets populated during
> >>> access of dentries (either during readdir/getdents or during lookup).
> >>> This dentries within a directory actually forms the address space for
> >>> the directory, which is read sequentially during getdents. For networ=
k
> >>> filesystems, the dentries are also looked up during revalidate.
> >>>
> >>> During sequential getdents, it makes sense to perform a readahead
> >>> similar to file reads. Even for revalidations and dentry lookups,
> >>> there can be some heuristics that can be maintained to know if the
> >>> lookups within the directory are sequential in nature. With this, the
> >>> dentry cache can be pre-populated for a directory, even before the
> >>> dentries are accessed, thereby boosting the performance. This could
> >>> give even more benefits for network filesystems by avoiding costly
> >>> round trips to the server.
> >>>
> >>
> >> I believe you are referring to READDIRPLUS, which is quite common
> >> for network protocols and also supported by FUSE.
> >>
> >> Unlike network protocols, FUSE decides by server configuration and
> >> heuristics whether to "fuse_use_readdirplus" - specifically in readdir=
plus_auto
> >> mode, FUSE starts with readdirplus, but if nothing calls lookup on the
> >> directory inode by the time the next getdents call, it stops with read=
dirplus.
> >>
> >> I personally ran into the problem that I would like to control from th=
e
> >> application, which knows if it is doing "ls" or "ls -l" whether a spec=
ific
> >> getdents() will use FUSE readdirplus or not, because in some situation=
s
> >> where "ls -l" is not needed that can avoid a lot of unneeded IO.
> >
> > Indeed, we often have folks wanting dramatically different behavior fro=
m
> > getdents() in NFS, and every time we've tried to improve our heuristics
> > someone else shouts "regression"!
>
> In CIFS, we already preload the dcache with the result of
> SMB2_QUERY_DIRECTORY, which I believe NFS does the same thing.
>
> Shyam, what's the problem with current approach?

We load the dentry cache with results of QueryDirectory. But what I'm
proposing here is a read ahead, even before the next readdir is done
by the application. i.e. the idea is that the data necessary to emit
dentries is already in the cache before it is even called. That should
speed up the overall directory reads.

--=20
Regards,
Shyam

