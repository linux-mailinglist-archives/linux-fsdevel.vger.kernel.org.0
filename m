Return-Path: <linux-fsdevel+bounces-69336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E509C76DC0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 02:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 38F1E358B9B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 01:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB14F13D503;
	Fri, 21 Nov 2025 01:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAxNgqCi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074D3279DAD
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 01:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763687868; cv=none; b=s2urdj6zrUJovfgdQeKSXr9UzFCAVmiFWYBVDlzMlgCEAMbECKK24ex4/ushCDAeN/wFpyI/5Fhgj6xo3xRjap6mVfOBXwSpSYO48jn6oi+pUwK7YxNrMTekAPVpkNg+xXHWUzgQChILeXXhuAfw9nNc1eECrAmHRux1dwKnZ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763687868; c=relaxed/simple;
	bh=rM3EETMGws/9HzBYP5Tdt7ngRKc/A6dE/gKDpmDllB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9XocEGtJdLJAS/rj1qIG8grQtJSBLMuAkWXIsJ5utmVXtGie3pSJypMFQytCz8RhUidfvYhdkBZZ1sYz11uW3IdFA574GGLXb8uE0/7SOwYb3+SnM6akMv0nVsqB9GAnGkJ5Pq5lLofkcpTDP6P4TxJNi5tlcTxAQybnnWj4L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAxNgqCi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A99C4AF09
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 01:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763687867;
	bh=rM3EETMGws/9HzBYP5Tdt7ngRKc/A6dE/gKDpmDllB4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JAxNgqCi5fsa8LLaBCcC2RtKodPjLghcxc5aXKN67T0zGdj/DyL/QL8Ht/YvAI+Zh
	 O0gzZ/Cim9sbZjYCsow3OKWQ9obZJMiZ7l48xvmZNnNQeVwPG+jyvITxINS3elfbPx
	 eL/pXhnLF0P4jqwnq9c3FRhntlD6iFF2jR/b4Er/tUSdgza6ikoInxcHgGRdiQaOuG
	 zWSc+cVy4ZetlKCuN1b+fLpn6RpNMFKHMt1cOjorVCGVasfuvpPh3uNSuuu9SgTtbx
	 kjkWBD33eJAdxV4x2jSZopBr8oszpcAnzEEKGANwGSRTDF+oXkPVDdfnWIlamECvDW
	 t2SxGthscagcQ==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640ca678745so2420837a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 17:17:47 -0800 (PST)
X-Gm-Message-State: AOJu0YxEpTxVXCKotIPeI2IB6Lx7IARW4u7GKEWY7UjxL9LJ9HrQGI8U
	Tnvr1i/fF26GDRUM/IBuAGCN1O8+g1BCuuJyi4vQdl+8IG6ihg5Xkp6SAtgKP6NPBJF3atiGZ/f
	7tZ1M/DTJnexsovN5Kbl66+OtK7O/WrE=
X-Google-Smtp-Source: AGHT+IGYVmnHxe7uHE87lJUioiOj3jsnzZoYbQder3CJCj30AwLap+PVCVRmhWW8JGcPedAEV4dZAyYWleC38Hsw50o=
X-Received: by 2002:a17:907:1c25:b0:b72:5d08:486c with SMTP id
 a640c23a62f3a-b76715b02cbmr34821066b.27.1763687866260; Thu, 20 Nov 2025
 17:17:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118082208.1034186-1-chizhiling@163.com>
In-Reply-To: <20251118082208.1034186-1-chizhiling@163.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 21 Nov 2025 10:17:33 +0900
X-Gmail-Original-Message-ID: <CAKYAXd962j=77AQSk2dVmBeQak3yWhGP5B1TptLfSjzNX23CSg@mail.gmail.com>
X-Gm-Features: AWmQ_blP2UUBc75ULbgAxLL8Gr7znnopnQ6pkM9vpa5p52vKktJtP6xTGj-nWPc
Message-ID: <CAKYAXd962j=77AQSk2dVmBeQak3yWhGP5B1TptLfSjzNX23CSg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Enable exfat_get_block to support obtaining
 multiple clusters
To: Chi Zhiling <chizhiling@163.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>, Chi Zhiling <chizhiling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 5:26=E2=80=AFPM Chi Zhiling <chizhiling@163.com> wr=
ote:
>
> From: Chi Zhiling <chizhiling@kylinos.cn>
Hi Chi,
>
> The purpose of this patchset is to prepare for adapting exfat to iomap
> in the future. Currently, the main issue preventing exfat from supporting
> iomap is its inability to fetch multiple contiguous clusters.
Do you have a plan to work iomap support for exfat ?
>
> However, this patchset does not directly modify exfat_map_cluster and
> exfat_get_cluster to support multi-clusters. Instead, after obtaining
> the first cluster, it uses exfat_count_contig_clusters to retrieve the
> subsequent contiguous clusters.
>
> This approach is the one with the fewest changes among all the solutions
> I have attempted, making the modifications easier to review.
>
> This patchset includes two main changes: one reduces the number of sb_bre=
ad
> calls when accessing adjacent clusters to save time, and the other enable=
s
> fetching multiple contiguous entries in exfat_get_blocks.
Are there any performance improvement measurements when applying this patch=
-set?

Thanks.
>
> Chi Zhiling (7):
>   exfat: add cache option for __exfat_ent_get
>   exfat: support reuse buffer head for exfat_ent_get
>   exfat: reuse cache to improve exfat_get_cluster
>   exfat: improve exfat_count_num_clusters
>   exfat: improve exfat_find_last_cluster
>   exfat: introduce exfat_count_contig_clusters
>   exfat: get mutil-clusters in exfat_get_block
>
>  fs/exfat/cache.c    | 11 ++++--
>  fs/exfat/exfat_fs.h |  6 ++-
>  fs/exfat/fatent.c   | 90 ++++++++++++++++++++++++++++++++++++---------
>  fs/exfat/inode.c    | 14 ++++++-
>  4 files changed, 97 insertions(+), 24 deletions(-)
>
> --
> 2.43.0
>

