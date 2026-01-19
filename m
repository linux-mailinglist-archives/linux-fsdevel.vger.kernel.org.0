Return-Path: <linux-fsdevel+bounces-74499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FADD3B27C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 17:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D492A310D4E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54F43A35BF;
	Mon, 19 Jan 2026 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jk+foR3Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D09C3A35B9
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 16:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840991; cv=none; b=q0rQTI93m4jPF87v0q2CPpjjYSRFPP8+GEI5ISQe9ADVcEN7ZJg/S5JPARgtk/+xMaYy4QtWqCb+g8TMhGEScdn7uqLPC5rCkH8j2foi27+sttQNZVipUBqNVUjUUopAujDvuzgULQJGrwdMqaTFIGxk6MPHFxnYW1ghgDmXrfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840991; c=relaxed/simple;
	bh=vfqhKWwiRrrnfWX4CrdJmI0n1g3fK/4yGHAQKrOzOrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ceuPEurgxC440a+v5u5zrqrYbdEs8sfq7XnJIKfDxercpMv9U0Xs3EhnnJQS5xHpJR0u1PdoZCBcfsAzO2ihzvdSgBnKKiIRZb3107a8SfY52rFcWyu7NJ5mwbjUtLvg27b6l3uki3DXDOIm5A9BfUzRN2WAz1rIhlKzYaOlCMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jk+foR3Y; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64d1ef53cf3so6169668a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 08:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768840987; x=1769445787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OP488vxzDs37SDvqB3SvtrET0fHZKVUQCP8+UqFkiUw=;
        b=Jk+foR3Y1NyYtu656bCn/sfEHgBt409+gCsXCs/0LgaZFGGwg8DXPQrt9bRa+w85ZO
         7GAONGC9gQZalHggLbpBLn648PK0NMNfnCUa3VAb5DgBjer+MHLLOXY0NfL9j5bLzwgO
         25Tr+eMpP07UuyrNoXeZ2KzBCRNzYtk87vifNwyoAYTJ11vF5HmFCwW9CzIqapg4rrsM
         stIWgt1eQ8hCiTLmpqOSk5MQF1Zj4X3TYgueWu4EwFEwvZEsVIqaBr7etT03WJajjXGO
         wcAv+wQmKEhMJ7mzsh+FvfF5aFDUoQCDacxCMGDN9eQcnBQogCEHWoSenfGpJx1OAZm3
         MQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768840987; x=1769445787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OP488vxzDs37SDvqB3SvtrET0fHZKVUQCP8+UqFkiUw=;
        b=eq9teYwyxEVIJyFGvf29XEPApz4EI5ao8wU3H1xQlQuA+tliPn6hG1CaJHDzdHPOYS
         m6ztg7oTuraBV8jc+MWt+IHdSftBasFU6Ko+IC57AIfnO0UvM/cqpboCIpsVX/Cm9z00
         VX5L7JgU89wFW1YFu3RfuwHcq01vwf+dXbCNcfvDoYuhz/gRiwDrze3nq9EVqDSfhHCY
         6NqTtaxCwzlFrUX6F1JwJUNCybyhaFsa2/NH2WWgZaqT9zVD1nBBsgo3bam0IDt4xT8w
         QChAk5+JyNzNQNMJ1IwCGC+C5hLCI0re0SIAcCt3UUwHLQ90jmd0O/nyoDWtJTaL6rDa
         F/QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPX2lBg5mOYDcvd5HUQJG536YR4h6ZXqd+CM3sll9c6ByNXfAOaHbp3XQSzpg/36Eqm6SVc9uwtmvsPfzl@vger.kernel.org
X-Gm-Message-State: AOJu0YzDivhJxasPZem/iEMa0+qiz+D89Vaaqi4p92gOIbMIvDEAAJnq
	BN60ysuWwuci8UvAV8hV7BMbER9PsZDuS3NfdyxbSec67/KHFdJ5hw79b5TzEdrN9wdr1grkt7T
	y1AicJhwfUTwbjmb2lZQ++h1VXCwIM/M=
X-Gm-Gg: AZuq6aIReYlYIcX7+qWulYsyB65PN3M9VgEA5sVSNIjRdn4xAhh4z64nlYGese9P2kr
	lwyzn4Nv1sw7RMySNDDsVKBfwveADeBMxH9YDBBBZfvyLFbnAApvJsn7+K7zLDy+U8U60MWM8yo
	CdIX1PuOlQXBOFD5TG6LsYWKyXrxF8SCgLwc/F0OAAwe0Do18Z5WYOuLXMMuElW10iuE3IoCFGa
	6Rd1X2W37EFvHPGss18YMdnuf5q+2d+r/5uGIMdECnxKyemdKTw8N2w/n0+LWvntA52xhFtxoNK
	qsnGe68Cg13nwhZ9/oKmyLHKXsFoKw==
X-Received: by 2002:a05:6402:4304:b0:649:b200:afe9 with SMTP id
 4fb4d7f45d1cf-65452cca909mr8384256a12.27.1768840987066; Mon, 19 Jan 2026
 08:43:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-exportfs-nfsd-v2-0-d93368f903bd@kernel.org> <20260119-exportfs-nfsd-v2-17-d93368f903bd@kernel.org>
In-Reply-To: <20260119-exportfs-nfsd-v2-17-d93368f903bd@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 19 Jan 2026 17:42:54 +0100
X-Gm-Features: AZwV_QiQ9eetgKyRnXUMiKJDXK2vIOYhTLzpDlKP7IN3cG_hSRVA59Z6sNZRsnw
Message-ID: <CAOQ4uxgXovX-rPuAE55D8x4jbNOQdAKJH3O5gpHJDMsT7kNGgw@mail.gmail.com>
Subject: Re: [PATCH v2 17/31] ovl: add EXPORT_OP_STABLE_HANDLES flag to export operations
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

On Mon, Jan 19, 2026 at 5:29=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Add the EXPORT_OP_STABLE_HANDLES flag to overlayfs export operations to
> indicate that this filesystem can be exported via NFS.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/export.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> index 83f80fdb156749e65a4ea0ab708cbff338dacdad..18c6aee9dd23bb450dadbe8ee=
f9360ea268241ff 100644
> --- a/fs/overlayfs/export.c
> +++ b/fs/overlayfs/export.c
> @@ -865,6 +865,7 @@ const struct export_operations ovl_export_operations =
=3D {
>         .fh_to_parent   =3D ovl_fh_to_parent,
>         .get_name       =3D ovl_get_name,
>         .get_parent     =3D ovl_get_parent,
> +       .flags          =3D EXPORT_OP_STABLE_HANDLES,
>  };
>
>  /* encode_fh() encodes non-decodable file handles with nfs_export=3Doff =
*/
>
> --
> 2.52.0
>

