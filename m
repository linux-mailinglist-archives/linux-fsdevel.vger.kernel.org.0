Return-Path: <linux-fsdevel+bounces-72921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3710BD058F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 19:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF293322CF3D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 18:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CD42FE571;
	Thu,  8 Jan 2026 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="gca1nAhL";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="dpcKqiHv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6597A2EC080;
	Thu,  8 Jan 2026 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767895965; cv=none; b=bkkNf1teI3t0z9UDteDFYCAOdTutTJfuRnVkzjEbGLT6LznIKTzj2ttJGGiJqVpuFFnh5Tvv2zkr9y6So1HUDEieE+G5Picbme2rpFZAwLbnRR5/Unqa073UgfRZdXcjpfor2g1sC8el7z7zYI4CHmm1t/q9B3A2TY6VTXHEovo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767895965; c=relaxed/simple;
	bh=lr6OlOmY3kB/ZOQaj06MsqhcOcUPK4OqDP6ZzEwKWhA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZVKpVoYhhVykBlxvo6Vcs1n8+EJowOiOSWsjADIILSoWQ2KCHnwncIIKwgV6elBjJj7LGstNpiYZ/M1S3Ke4OEpXOk/i6MJE5xd6nwFfmihOitr2htXOIWjZPLU0pN6PTZHolDreveu75Rl9Z9mNP9J0hewj2d9TtjtpkBRXfNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=gca1nAhL; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=dpcKqiHv; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 4677D26F765D;
	Fri,  9 Jan 2026 03:12:33 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1767895953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VE+eLbPxS+2/NxdS4iC5ykEp/h4Ri6SH4uWUI0CKCww=;
	b=gca1nAhL0iYeKhrMxVW/YkNVQGsmR2FtA0K2e0pt9zd3L8VZwxpcEfUTVG6wgn+2tFPTSO
	HeW+ni5Q59lRV2kUjNcId9ow+1k5DhIo1N5oAHHp1l0frRz0p+GdCrJ5yDI66gxE8KEOn7
	v8zc7gU5ici9xYmL+L7s3KQ9RND4Zj9v/GNEYNheUomswbwI2MAFPIY0boWLymkQQnV9lD
	55Q1xjqtAMVsY4vr4S+L3pqkV4l+GHZ+5Sx/JiLr+J5yUBW4ypUc8Y8oNHBEL1KgKVh31j
	qSpaEXlZVcdannHzIb1g2WajxumAtmJFSTEQRXXN49o5ilDnu6uppAB9swxKLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1767895953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VE+eLbPxS+2/NxdS4iC5ykEp/h4Ri6SH4uWUI0CKCww=;
	b=dpcKqiHv5kPZON+sXPbBLz5lebhV2Omji1CcWNcfUdqkirKgF5cr6kEKLmZbrHERXCyoN2
	F8vLjq1Lz09KhaCQ==
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 608ICUsL013625
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 9 Jan 2026 03:12:31 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 608ICTic019851
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 9 Jan 2026 03:12:29 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 608ICKe4019849;
	Fri, 9 Jan 2026 03:12:20 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Jeff Layton <jlayton@kernel.org>
Cc: Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki
 <salah.triki@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
        Christoph
 Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Anders Larsen
 <al@alarsen.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian
 Brauner <brauner@kernel.org>,
        David Sterba <dsterba@suse.com>, Chris
 Mason <clm@fb.com>,
        Gao Xiang <xiang@kernel.org>, Chao Yu
 <chao@kernel.org>,
        Yue Hu <zbestahu@gmail.com>, Jeffle Xu
 <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>,
        Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>,
        Jan Kara <jack@suse.com>, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger
 <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        David
 Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>, Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi
 <konishi.ryusuke@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark
 Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi
 <joseph.qi@linux.alibaba.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Miklos Szeredi
 <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Phillip
 Lougher <phillip@squashfs.org.uk>,
        Carlos Maiolino <cem@kernel.org>, Hugh Dickins <hughd@google.com>,
        Baolin Wang
 <baolin.wang@linux.alibaba.com>,
        Andrew Morton
 <akpm@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Yuezhang Mo
 <yuezhang.mo@sony.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander
 Aring <alex.aring@gmail.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Matthew Wilcox (Oracle)"
 <willy@infradead.org>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet
 <asmadeus@codewreck.org>,
        Christian Schoenebeck
 <linux_oss@crudebyte.com>,
        Xiubo Li <xiubli@redhat.com>, Ilya Dryomov
 <idryomov@gmail.com>,
        Trond Myklebust <trondmy@kernel.org>,
        Anna
 Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>,
        Paulo
 Alcantara <pc@manguebit.org>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
        Bharath SM <bharathsm@microsoft.com>, Hans de Goede <hansg@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
        linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, gfs2@lists.linux.dev, linux-doc@vger.kernel.org,
        v9fs@lists.linux.dev, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Subject: Re: [PATCH 09/24] fat: add setlease file operation
In-Reply-To: <20260108-setlease-6-20-v1-9-ea4dec9b67fa@kernel.org>
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
	<20260108-setlease-6-20-v1-9-ea4dec9b67fa@kernel.org>
Date: Fri, 09 Jan 2026 03:12:20 +0900
Message-ID: <875x9c3rej.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Layton <jlayton@kernel.org> writes:

> Add the setlease file_operation to fat_file_operations and
> fat_dir_operations, pointing to generic_setlease.  A future patch will
> change the default behavior to reject lease attempts with -EINVAL when
> there is no setlease file operation defined. Add generic_setlease to
> retain the ability to set leases on this filesystem.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

> ---
>  fs/fat/dir.c  | 2 ++
>  fs/fat/file.c | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/fs/fat/dir.c b/fs/fat/dir.c
> index 92b091783966af6a9e6f5ead1a382a98dd92bba0..807bc8b1bc145a9f15765920670c6233f7e87e55 100644
> --- a/fs/fat/dir.c
> +++ b/fs/fat/dir.c
> @@ -16,6 +16,7 @@
>  
>  #include <linux/slab.h>
>  #include <linux/compat.h>
> +#include <linux/filelock.h>
>  #include <linux/uaccess.h>
>  #include <linux/iversion.h>
>  #include "fat.h"
> @@ -876,6 +877,7 @@ const struct file_operations fat_dir_operations = {
>  	.compat_ioctl	= fat_compat_dir_ioctl,
>  #endif
>  	.fsync		= fat_file_fsync,
> +	.setlease	= generic_setlease,
>  };
>  
>  static int fat_get_short_entry(struct inode *dir, loff_t *pos,
> diff --git a/fs/fat/file.c b/fs/fat/file.c
> index 4fc49a614fb8fd64e219db60c6d9e7dd100aea1c..d50a6d8bfaae0c75b2dbe838d108135206d0f123 100644
> --- a/fs/fat/file.c
> +++ b/fs/fat/file.c
> @@ -13,6 +13,7 @@
>  #include <linux/mount.h>
>  #include <linux/blkdev.h>
>  #include <linux/backing-dev.h>
> +#include <linux/filelock.h>
>  #include <linux/fsnotify.h>
>  #include <linux/security.h>
>  #include <linux/falloc.h>
> @@ -212,6 +213,7 @@ const struct file_operations fat_file_operations = {
>  	.splice_read	= filemap_splice_read,
>  	.splice_write	= iter_file_splice_write,
>  	.fallocate	= fat_fallocate,
> +	.setlease	= generic_setlease,
>  };
>  
>  static int fat_cont_expand(struct inode *inode, loff_t size)

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

