Return-Path: <linux-fsdevel+bounces-74413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C793D3A1D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 09:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 249C53024264
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4F634404F;
	Mon, 19 Jan 2026 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuxGl/Kv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD44343D8A
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 08:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768812024; cv=none; b=dyfMIf35Ih9d9VvjESH+ujvurCvcQP+pBqIL/cynQHc6AS1pHtnRUXvi0h2uOwowg6nNNybgQn1bYdwLLjbXgd4/C2oP4HRs6k7RGknZOOFCgWvEeaM8kB7vt/oj5+h4ASvdHwHtHfezhZQ0LRgkFpaKqphkWcszQoqrh+yGn6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768812024; c=relaxed/simple;
	bh=KJoYOa5K18nqNKCWxkYAOdRPH4EyPY3p5tSvazTt+nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBjjIy07xmQhFdLshjLY+CKjxsP8VarxTUj7RB9yo9NUKNETd6U6W6LojEgNuZxr/BtbRLHcQS/sNOs2DBoLcTCSAbMBr5fgxh1/GvN4lPdDdXQW1nmdH2RVxuCjzuY/+Y16qF1lCRxBZ8IrmsP0brzm8KSHkFGL5V5AIkoIxkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuxGl/Kv; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-383122fbc9bso31224801fa.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 00:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768812015; x=1769416815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJoYOa5K18nqNKCWxkYAOdRPH4EyPY3p5tSvazTt+nc=;
        b=UuxGl/Kv2qbGAjCEuVUsVj/4oQWOPGu5XmvQpfk1Drz9vatodzGETG9e+31hfYmt3n
         ShdJ9cGy+7c9CgwMx4qNCOsEOk9b7rrbcW9sllSEaJR/ulmbCFLctH/tiveRVhVmQJZj
         ZrQS/De/lTOaQvMCUNZ46O3ZwPI2hOtJTSCk476OkZmTVTYeDoCcH0QcYd74HbrVYGP5
         dRxjA25g4F4+RYExRaQ85YPkw0VdL1A/Nqoc3cVOU/36LCP0N30pJwOygCxiPuv4wfnm
         BmbGAhPj2faOMfQG3X54EB1BGuZFqNEdx1RUYWOLd+pHmqzJSVSsnNIpi2nsXvu5e3ka
         PSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768812015; x=1769416815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KJoYOa5K18nqNKCWxkYAOdRPH4EyPY3p5tSvazTt+nc=;
        b=eT1k0NpkRTuToAup7GTxt39LEOV9nSKxROyMZTFlFbHp7UgkiuMajl9k0gbF6jpLU6
         7+TVkm7TngnNtFNj8VMgX3+7SkyWUk4SLkgQ1zkEFa7S70DFnHmjAay7XY1w+wTNLCMx
         Qh/qcSItg7OKEHAB4sWjNXWQa8rNetFqcpzp39+2KAe910zExsvcm7vdnTQ2sQwXMZWz
         QOX2tjfuqfjN+ynC6RyJjlKDIKeuqRPje+CLx8zfNft1CkqLwqgOnGwGDanzb+S85Gwf
         Ax9HRAL5v6cPmdKpElI9icr3FbXwwIDvfHprmKAvGRebzPdl8oswp7c5TvsfpN/0R4fX
         xyvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaRLTh38g8XQlWPbNgOy6tuecDCk17fodGF7Qssx2yzA7gwxEe54Dn9F92mui++YJyLAw55NtNOkVeOktw@vger.kernel.org
X-Gm-Message-State: AOJu0YwfyTTnANlKmYbLi8082idoJC2OKyIO/OdTUX6eFIaY1uwn4G6Z
	FGqt/RdKd7t0WrtdAd+Oz4mvAtp60knA268N6ZrmRmptSYReOGMQN1ZpnE1Vhp5F8G7+Sf5Z6C5
	8KEx3/fdQq+ZkPrd+IzxJRv6H45aKRM0=
X-Gm-Gg: AY/fxX6FTq11EbUQTbz174ExZYZSZwdCv3P0taC2enlcOKkkaKpuJSdQ0I4fK6PntuA
	eRThH7u1yy9O8tfJE/bCYEAoJTpCN6hUWFJuiZpzGgG6jCCq9VoFJxKgIQIGmp8YAh7GNLL8M3N
	oNX0hzaoDnH94RHu9kZfDGcHHOAjWZxXPLioJEp0T/csXaWEPJ3zLMBrGjFNCH9uH0XDzQmsq89
	4Kz6Aybz6xobPhwV7ovScZXlp86uUQ04taJk6xnuTsLP7LoCoso6FkymPO1FhcI00SuOQ1V
X-Received: by 2002:a05:651c:31d3:b0:37b:9ab6:a071 with SMTP id
 38308e7fff4ca-383842a1f56mr38777111fa.28.1768812014411; Mon, 19 Jan 2026
 00:40:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org> <20260115-exportfs-nfsd-v1-20-8e80160e3c0c@kernel.org>
In-Reply-To: <20260115-exportfs-nfsd-v1-20-8e80160e3c0c@kernel.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Mon, 19 Jan 2026 17:39:57 +0900
X-Gm-Features: AZwV_QgvoiJk-4c_7XszNQLNhAbjR94vrEkk8toY4eDKXl6u9TqMllUY3n06aqo
Message-ID: <CAKFNMomS-8MMAjy8yuFwzuLBuQQA8r7gPJeJh1ci6RvVc9u4EA@mail.gmail.com>
Subject: Re: [PATCH 20/29] nilfs2: add EXPORT_OP_STABLE_HANDLES flag to export operations
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Amir Goldstein <amir73il@gmail.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
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
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Dave Kleikamp <shaggy@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>, 
	Andreas Gruenbacher <agruenba@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-unionfs@vger.kernel.org, 
	devel@lists.orangefs.org, ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	linux-mtd@lists.infradead.org, gfs2@lists.linux.dev, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 2:50=E2=80=AFAM Jeff Layton wrote:
>
> Add the EXPORT_OP_STABLE_HANDLES flag to nilfs2 export operations to indi=
cate
> that this filesystem can be exported via NFS.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks,
Ryusuke Konishi

