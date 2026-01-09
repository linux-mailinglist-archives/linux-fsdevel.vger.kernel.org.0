Return-Path: <linux-fsdevel+bounces-72992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EDFD07333
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 06:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A4F9302E070
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 05:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DE62D8391;
	Fri,  9 Jan 2026 05:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCNW4zBK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0891F1513
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 05:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767936385; cv=none; b=e1pcPnoxVXKnNu1d5ggAoIvN00F4GdGqzhaZb5s5UILApuGPrINIH5SCV4UDjSP+78wicwbbQUHAkgKwb+PQFLnuAFlCXiYqFbsa8kkOUvYwMnA6nkJanz69p8s/nPccjf2eXnoCKujzU/CfvovPND7o80sngApAyBOqQdL3TLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767936385; c=relaxed/simple;
	bh=SMlm1Zj+VPtmhO+U2BlswVGk3VmIYNq8C/pi+eNGgFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nvN749WA9semtUY8U8R4YqU8NjiT7yDIMhrNYsUQ73TgLN9iFPI+wBqJe91F5ahKtWsRmuFMPL2fGlykYV+JKdJoMbSwSNT2lHAhuHfV7hwrwOMv+gJWzKYL+RibdnO40aUrWRpdsdlZhM8okN5Im6oyKG7qVRK399xwzXq2DCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCNW4zBK; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-382fea4a160so23998041fa.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 21:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767936380; x=1768541180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEF8CAf2dAOD+neWtLdI+w7NxCIZ2WohswMXxqPrdck=;
        b=FCNW4zBKvwe06rYcMueAfiJkXaVx77askqwvwX7CaEFH+6L3KlGJSk+bEnT7twnFlu
         P/yPNDuhFF9KldguIgfQJUEYrjzXBpzGr9ymhPd8+54KoK8cbP5kMcMedYnuV8Kj4agV
         DY0xjwrqP/6J413PUFdioqjbYLqYGCmxXPgnNCdMLjil7XqO5qmH5efBobLJT6gh3OGz
         VE+LNRMzj1W0betHwvCbJtPCcXjicJ4dWKL9ELgIHdLGNeHo8bGeEw3mOVIMRWPnhzPQ
         gBNuDOAwxH6WtvQg2uVaK+Xg7hl16AIP+FUkv3+pddWPJlc9FSeriHsKVG5oPAPuqF32
         hcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767936380; x=1768541180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EEF8CAf2dAOD+neWtLdI+w7NxCIZ2WohswMXxqPrdck=;
        b=ubD0BJyX9nIdmxm1tZE8fiBJshfHKrKVKohHR/7Pc8acgMM+I2ekZyAeoeGzU4gBHY
         Rkg67J8b55fY14WzZhnOEXkDJmTHni0xoIZ8L62iSHXABLGpTUQ7Yf7tVJHHYOgnZc97
         5iIdPCfoeZORr50TZQ6olptojHXGOdmghTAJMNkSvNIyupXy2vprL+EEk40ldNYj6fSJ
         i3cMkSffc9PYbhMbwYqqaIFhnHwJAs3aq4tNFzORWFTbhDumR5GfFp1MFomBHj5+G76F
         A86rNiaD0e4NhY3BG536H85EaYxIqwODL0UD0tuDtkJJSMN25vYX/N/PWHbHSMLfM5gd
         Im3g==
X-Forwarded-Encrypted: i=1; AJvYcCXygyn2ODj9LIKnxDWjgAF7vDRQ7AwufV+c/P1FH6gGPvrnQGBuJaNiN1wc2ee28wpa+IQQHgaGf3awbsav@vger.kernel.org
X-Gm-Message-State: AOJu0YxHtdYcMUgjes/MIzsvMdYv92zGKkRRvgqTDq5Ay8kIh9bvOiNp
	ZyZPenALCSnNiL+kzcBmHMuez2pI4GK/28CmEKj31dPFDv49svz00WYmoB+W/3c7AxcCLS9PKDd
	Sx6omTyHwdWHW07tIia/G1YQ4c2aFu78=
X-Gm-Gg: AY/fxX7GQ2nKjNtzit9zsqfQKcGSrtznFj2YzfqV5GtJs/h8d4rGMQv++BvUaqxyu6n
	ptkkQg9BVoQ+Nyp391FOg8RfSE+uW3FJ2V/FgYRswk/E7IDnxflNmxVTXI2BIn1Qbg3zL3EO3o6
	/T8vphKNI/I0nhbdvTpTOr5Qwc2r1ZuSfXyqFm4BhRfWvI92ukp8S+SGiOsmdkp7Hjvym0Iwlgv
	OEnH9HY0Hj883pAiHLB1lFW4GHSZnsWU3c/HM84fBiOgbJLUzE+hAvC+o3jTbSW+trP90+7
X-Google-Smtp-Source: AGHT+IFacKbx/HloTRDyL3KNE+dISSFeSIeO5gnLVmi9ry+Gc3uB4ma+c7Q9oZoxnNZINjg1j054MzA1urN4ujLkRdE=
X-Received: by 2002:a05:651c:419b:b0:378:e3f9:2d26 with SMTP id
 38308e7fff4ca-382ff823bdamr21702801fa.39.1767936379607; Thu, 08 Jan 2026
 21:26:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org> <20260108-setlease-6-20-v1-13-ea4dec9b67fa@kernel.org>
In-Reply-To: <20260108-setlease-6-20-v1-13-ea4dec9b67fa@kernel.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Fri, 9 Jan 2026 14:26:03 +0900
X-Gm-Features: AQt7F2pmUKGJKWpVwxhIrI-U32G4ALuqYGKPCGsBpfUc51GGTfk1sxJMQ_5a6zs
Message-ID: <CAKFNMok9FG=hhzr8YrHYws5z3jTWOf2TXtFWvSfYbNy6+XLHxw@mail.gmail.com>
Subject: Re: [PATCH 13/24] nilfs2: add setlease file operation
To: Jeff Layton <jlayton@kernel.org>
Cc: Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Nicolas Pitre <nico@fluxnic.net>, Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, 
	Anders Larsen <al@alarsen.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, Jan Kara <jack@suse.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Dave Kleikamp <shaggy@kernel.org>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Phillip Lougher <phillip@squashfs.org.uk>, Carlos Maiolino <cem@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, Xiubo Li <xiubli@redhat.com>, 
	Ilya Dryomov <idryomov@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	Hans de Goede <hansg@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org, 
	ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, 
	linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org, 
	gfs2@lists.linux.dev, linux-doc@vger.kernel.org, v9fs@lists.linux.dev, 
	ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 2:15=E2=80=AFAM Jeff Layton wrote:
>
> Add the setlease file_operation to nilfs_file_operations and
> nilfs_dir_operations, pointing to generic_setlease.  A future patch
> will change the default behavior to reject lease attempts with -EINVAL
> when there is no setlease file operation defined. Add generic_setlease
> to retain the ability to set leases on this filesystem.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good, Thanks!

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Ryusuke Konishi

> ---
>  fs/nilfs2/dir.c  | 3 ++-
>  fs/nilfs2/file.c | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
> index 6ca3d74be1e16d5bc577e2520f1e841287a2511f..b243199036dfa1ab2299efaaa=
5bdf5da2d159ff2 100644
> --- a/fs/nilfs2/dir.c
> +++ b/fs/nilfs2/dir.c
> @@ -30,6 +30,7 @@
>   */
>
>  #include <linux/pagemap.h>
> +#include <linux/filelock.h>
>  #include "nilfs.h"
>  #include "page.h"
>
> @@ -661,5 +662,5 @@ const struct file_operations nilfs_dir_operations =3D=
 {
>         .compat_ioctl   =3D nilfs_compat_ioctl,
>  #endif /* CONFIG_COMPAT */
>         .fsync          =3D nilfs_sync_file,
> -
> +       .setlease       =3D generic_setlease,
>  };
> diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
> index 1b8d754db44d44d25dcd13f008d266ec83c74d3f..f93b68c4877c5ed369e90b723=
517e117142335de 100644
> --- a/fs/nilfs2/file.c
> +++ b/fs/nilfs2/file.c
> @@ -8,6 +8,7 @@
>   */
>
>  #include <linux/fs.h>
> +#include <linux/filelock.h>
>  #include <linux/mm.h>
>  #include <linux/writeback.h>
>  #include "nilfs.h"
> @@ -150,6 +151,7 @@ const struct file_operations nilfs_file_operations =
=3D {
>         .fsync          =3D nilfs_sync_file,
>         .splice_read    =3D filemap_splice_read,
>         .splice_write   =3D iter_file_splice_write,
> +       .setlease       =3D generic_setlease,
>  };
>
>  const struct inode_operations nilfs_file_inode_operations =3D {
>
> --
> 2.52.0
>

