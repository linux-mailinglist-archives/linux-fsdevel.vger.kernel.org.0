Return-Path: <linux-fsdevel+bounces-74500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 819E1D3B2E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 17:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34AA5317E479
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5F03A784A;
	Mon, 19 Jan 2026 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I08FL+hn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D303A7829
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841016; cv=none; b=E/ulCnLDeMQIejEcjdf0gVq3t1R91Q3yEoh0HyUPW3aeJ7MbZoBz/dQwbAbuR3O06zbG3aqf2YsZXnJ/jg7RMXbapPUltdUYidORnsZkoDZg+M4QZEl4fZOwSFqxScJGLJXqHSz7JoUwDGngA1ynoMkJxWx2ztfsGyBPCeafQ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841016; c=relaxed/simple;
	bh=CQ3IL8fqKnWIgvRv+IOv0Cfz8J1ZjzxNV5oCIJJcLY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RigvV8gVAQ6lrBFAOApDNlm78XmHDZanQ8UqSvC8XnpFHMzkHo7TTPoyvcis17+3hIBIRLXveiF7B/1Z/mlRITTkXEqcaYQJerTTHx89LWuTiY+KlRFbEZCwOczmVZMx+7G5QCbdxwY2UKaMxmMhFmAPn/5AiLrIuLOHurcj9Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I08FL+hn; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64b9b0b4d5dso9321434a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 08:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768841011; x=1769445811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7xapJC59KqqTTsHRvPEloTsuOjJhUfycEcUpCAL4U8=;
        b=I08FL+hnhz8d4kYl7Y2qUf8KhTCV3L1gtSSYiUt44LfuwlJOhbuXloyFunmZ9tNOVl
         9RitHVVjJ1hi2U5+dH19ve+S5OSb0vxhAvjiJ4hKFGFD33p+sqLphDuH6giQCXBMz2CY
         6HE9IU+g1NQYM7UojcBIqap0wIhOhJR1a3Olt8Wq682EaAzfzDXjfRqUgsdIWkTHbmDC
         dnmxSuWuEkfrVI4iJJEASrwV2WkB2wOt9C0R5PWwkXIvwcuNWrPlPauMwIINawvCoalA
         m9uPz3sLVwivbMRhJ+EpVLIx+DVdAMpOF87J/A41Ie5jnE4mhIuTEQUJ2YQvda+ZBdY4
         oUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768841011; x=1769445811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t7xapJC59KqqTTsHRvPEloTsuOjJhUfycEcUpCAL4U8=;
        b=JctKlZgPyzJVqeftN5BHBKSjZLmh73zYWi2YmffpVtPpM7dkmL/D69iwMwgL3oFMrR
         oJsa6vwl5G6U++4H5rQOaDC99iy8xJg+TX/zOZrGiNPkV9t3X6n14gR+5CJgr3tJQya2
         uz7ZQ39ihvMBm9LqOWZWyv6jqfQL9tqPEdjRvccidi8B9grSP266+3cuZ43DVkA9ElJa
         D1sdBfM3SKD76Xk+mEjEQcbzH9WpUWx7WDWHdkz23bHF4CMUKn1xflWDZwCMtjHL7NpK
         rHx2Z9fY7HlBT32kv2TXiMlI+1cxeUZ5eQOLVrMrnwT0tGu/6sVGrfpDZYhklLa5hwSN
         Llkw==
X-Forwarded-Encrypted: i=1; AJvYcCVQyVqf7v8YVlVJX8n8ZHJv50U62MGtRz+plmLtH3hclNRyFrRzFeeEQNEmO7kbedfpsZsgtgydTrccXx/V@vger.kernel.org
X-Gm-Message-State: AOJu0YxoB8igLjROcVBGBaqPkjTG+l5FiNhnOrYYSCQcs1EApIvWKRe7
	CZGQT+8bAyC48XLWijb1DY5S4WHLt2dMcM1v8StN5lfC7yLvZSYiq15te7H5fgn2VaVpIcpaV3W
	/RlNuQXw4+5TjyUFXcSUvcue/rKJnYiY=
X-Gm-Gg: AZuq6aJMyvh252mIgvJaw8wMf+lDPOj6f1JRJBQkcQgXU11UumdgwLdV5dgEE0KSdOq
	DiQdnPTmbpcm24imFcCVMhLurH+CxW3sNHvsge44UBfvoIEaYvtwtnx5tlm4CTFKuGNkcGgj9EU
	awJG5T4AtdXHNglnvO2hP0Fx08KJG3mwBa4AVhHwsFdHsi30B7DYuActaHTZdjgw92q0FlK/Qs3
	HUfbE1BKcrFG+N6IP54uvBZYIRkWneo6gfoyrO1PnHcj9ficUCe0RBgF07JPEhgbXps7UGHhVsf
	/xb4pe+ofzuXg8wdUJV8qUu1WL4iAi4tvX6BWZSa
X-Received: by 2002:a05:6402:5106:b0:64c:584c:556c with SMTP id
 4fb4d7f45d1cf-654bb6192admr8530585a12.30.1768841011353; Mon, 19 Jan 2026
 08:43:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-exportfs-nfsd-v2-0-d93368f903bd@kernel.org> <20260119-exportfs-nfsd-v2-27-d93368f903bd@kernel.org>
In-Reply-To: <20260119-exportfs-nfsd-v2-27-d93368f903bd@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 19 Jan 2026 17:43:19 +0100
X-Gm-Features: AZwV_QgQ6YFmczFqASwqjyOa509PoCTPsOB-sET1G173IBHOd4X5kFjH9N6z5MI
Message-ID: <CAOQ4uxjyTdf21G1Y=_5Eox58drVPA0gAMeSQZxh=T36_yzssNw@mail.gmail.com>
Subject: Re: [PATCH v2 27/31] fuse: add EXPORT_OP_STABLE_HANDLES flag to
 export operations
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, 
	Carlos Maiolino <cem@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Phillip Lougher <phillip@squashfs.org.uk>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Bharath SM <bharathsm@microsoft.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Dave Kleikamp <shaggy@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>, 
	Andreas Gruenbacher <agruenba@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Laight <david.laight.linux@gmail.com>, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	linux-unionfs@vger.kernel.org, devel@lists.orangefs.org, 
	ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	linux-mtd@lists.infradead.org, gfs2@lists.linux.dev, 
	linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 5:30=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Add the EXPORT_OP_STABLE_HANDLES flag to fuse export operations to indica=
te
> that this filesystem can be exported via NFS.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/fuse/inode.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 819e50d666224a6201cfc7f450e0bd37bfe32810..df92414e903b200fedb9dc777=
b913dae1e2d0741 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1215,6 +1215,7 @@ static const struct export_operations fuse_export_o=
perations =3D {
>         .fh_to_parent   =3D fuse_fh_to_parent,
>         .encode_fh      =3D fuse_encode_fh,
>         .get_parent     =3D fuse_get_parent,
> +       .flags          =3D EXPORT_OP_STABLE_HANDLES,
>  };
>
>  static const struct super_operations fuse_super_operations =3D {
>
> --
> 2.52.0
>

