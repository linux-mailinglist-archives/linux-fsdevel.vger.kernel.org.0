Return-Path: <linux-fsdevel+bounces-16048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB4B8975B5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 18:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D89E1F29993
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 16:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD41B152534;
	Wed,  3 Apr 2024 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q146yHsu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F2D15218A
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Apr 2024 16:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163412; cv=none; b=S4st6U0JmXGiBv3h5RiLD3zTKdfyyxVf2UZFgU4wIRv2PNAzwG58vxJz3CZjUz8r5DiJOFtrPwpa0By+VJSitIGetW8TGOyHhcCraTtcmNpK2lgaL2yUGraFEkF4qVQAOSi+P1TkhXTVTRMkDZ+w4h3nNjsmmSLlR1mTFly5Res=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163412; c=relaxed/simple;
	bh=IbWvIfTvSR+WvzUBN5UleMi6ZD+TbmvVk4lRrvzYRXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bt5SyOgDVBCRELrPpfPztOxDQQrBfQziwsOUrsemJRWplys/m/hyZokY7Qs+gHbv2laDRtpJl/JhrEVKBSKhc1Y8ssKGu9gJKro3JkfpyF1bv82DqbmmHWoTSdjKoVRSR5PcsizXw2yI5yMzLSNhN0makPiKhzzUMHR7q0nhcmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q146yHsu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712163409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u1iSn8bvEgGWCVXgdHv/OtOU9Q9NOuhKnF3ziO23kyo=;
	b=Q146yHsuGUD1qwSgUIsWJQOWqWyFPBKnyKe24HgcOI95NTZwjK0nUOwKqVBBxTqZerz6Nj
	v65ScLZJCipPr8Kad6e1aPSkOXWUJt3JCEQnT+fdbf9AITelKS/9GBThmNrplDTkEQnKtG
	W89XXXdjVB8LmVxJKHNPttZJsoZUPlw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-iTU1m7Q5N7uP72lIIm9dzA-1; Wed,
 03 Apr 2024 12:56:45 -0400
X-MC-Unique: iTU1m7Q5N7uP72lIIm9dzA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A93CB383CD7F;
	Wed,  3 Apr 2024 16:56:42 +0000 (UTC)
Received: from bfoster (unknown [10.22.16.57])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EFCA747FD;
	Wed,  3 Apr 2024 16:56:41 +0000 (UTC)
Date: Wed, 3 Apr 2024 12:58:40 -0400
From: Brian Foster <bfoster@redhat.com>
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 02/13] fs: fiemap: update fiemap_fill_next_extent()
 signature
Message-ID: <Zg2KwHF9qaWMgVsy@bfoster>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
 <58f9c9eef8b0e33a8d46a3ad8a8db46890e1fbe8.1712126039.git.sweettea-kernel@dorminy.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58f9c9eef8b0e33a8d46a3ad8a8db46890e1fbe8.1712126039.git.sweettea-kernel@dorminy.me>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Wed, Apr 03, 2024 at 03:22:43AM -0400, Sweet Tea Dorminy wrote:
> Update the signature of fiemap_fill_next_extent() to allow passing a
> physical length. Update all callers to pass a 0 physical length -- since
> none set the EXTENT_HAS_PHYS_LEN flag, this value doesn't matter.
> 
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> ---
>  Documentation/filesystems/fiemap.rst | 3 ++-
>  fs/bcachefs/fs.c                     | 7 ++++---
>  fs/btrfs/extent_io.c                 | 4 ++--
>  fs/ext4/extents.c                    | 1 +
>  fs/f2fs/data.c                       | 8 +++++---
>  fs/f2fs/inline.c                     | 3 ++-
>  fs/ioctl.c                           | 9 +++++----
>  fs/iomap/fiemap.c                    | 2 +-
>  fs/nilfs2/inode.c                    | 6 +++---
>  fs/ntfs3/frecord.c                   | 7 ++++---
>  fs/ocfs2/extent_map.c                | 4 ++--
>  fs/smb/client/smb2ops.c              | 1 +
>  include/linux/fiemap.h               | 2 +-
>  13 files changed, 33 insertions(+), 24 deletions(-)
> 
...
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 8afd32e1a27a..1830baca532b 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -99,7 +99,8 @@ static int ioctl_fibmap(struct file *filp, int __user *p)
>   * @fieinfo:	Fiemap context passed into ->fiemap
>   * @logical:	Extent logical start offset, in bytes
>   * @phys:	Extent physical start offset, in bytes
> - * @len:	Extent length, in bytes
> + * @log_len:	Extent logical length, in bytes
> + * @phys_len:	Extent physical length, in bytes (optional)
>   * @flags:	FIEMAP_EXTENT flags that describe this extent
>   *
>   * Called from file system ->fiemap callback. Will populate extent
> @@ -110,7 +111,7 @@ static int ioctl_fibmap(struct file *filp, int __user *p)
>   * extent that will fit in user array.
>   */
>  int fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 logical,
> -			    u64 phys, u64 len, u32 flags)
> +			    u64 phys, u64 log_len, u64 phys_len, u32 flags)
>  {
>  	struct fiemap_extent extent;
>  	struct fiemap_extent __user *dest = fieinfo->fi_extents_start;
> @@ -138,8 +139,8 @@ int fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 logical,
>  	memset(&extent, 0, sizeof(extent));
>  	extent.fe_logical = logical;
>  	extent.fe_physical = phys;
> -	extent.fe_logical_length = len;
> -	extent.fe_physical_length = len;
> +	extent.fe_logical_length = log_len;
> +	extent.fe_physical_length = phys_len;

Another nit, but would it simplify things to let this helper set the
_HAS_PHYS_LEN flag on phys_len != 0 or something rather than require
callers to get it right?

Brian

>  	extent.fe_flags = flags;
>  
>  	dest += fieinfo->fi_extents_mapped;
> diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
> index 610ca6f1ec9b..013e843c8d10 100644
> --- a/fs/iomap/fiemap.c
> +++ b/fs/iomap/fiemap.c
> @@ -36,7 +36,7 @@ static int iomap_to_fiemap(struct fiemap_extent_info *fi,
>  
>  	return fiemap_fill_next_extent(fi, iomap->offset,
>  			iomap->addr != IOMAP_NULL_ADDR ? iomap->addr : 0,
> -			iomap->length, flags);
> +			iomap->length, 0, flags);
>  }
>  
>  static loff_t iomap_fiemap_iter(const struct iomap_iter *iter,
> diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
> index 7340a01d80e1..4d3c347c982b 100644
> --- a/fs/nilfs2/inode.c
> +++ b/fs/nilfs2/inode.c
> @@ -1190,7 +1190,7 @@ int nilfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  			if (size) {
>  				/* End of the current extent */
>  				ret = fiemap_fill_next_extent(
> -					fieinfo, logical, phys, size, flags);
> +					fieinfo, logical, phys, size, 0, flags);
>  				if (ret)
>  					break;
>  			}
> @@ -1240,7 +1240,7 @@ int nilfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  					flags |= FIEMAP_EXTENT_LAST;
>  
>  				ret = fiemap_fill_next_extent(
> -					fieinfo, logical, phys, size, flags);
> +					fieinfo, logical, phys, size, 0, flags);
>  				if (ret)
>  					break;
>  				size = 0;
> @@ -1256,7 +1256,7 @@ int nilfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  					/* Terminate the current extent */
>  					ret = fiemap_fill_next_extent(
>  						fieinfo, logical, phys, size,
> -						flags);
> +						0, flags);
>  					if (ret || blkoff > end_blkoff)
>  						break;
>  
> diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
> index 7f27382e0ce2..ef0ed913428b 100644
> --- a/fs/ntfs3/frecord.c
> +++ b/fs/ntfs3/frecord.c
> @@ -1947,7 +1947,7 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
>  	if (!attr || !attr->non_res) {
>  		err = fiemap_fill_next_extent(
>  			fieinfo, 0, 0,
> -			attr ? le32_to_cpu(attr->res.data_size) : 0,
> +			attr ? le32_to_cpu(attr->res.data_size) : 0, 0,
>  			FIEMAP_EXTENT_DATA_INLINE | FIEMAP_EXTENT_LAST |
>  				FIEMAP_EXTENT_MERGED);
>  		goto out;
> @@ -2042,7 +2042,7 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
>  				flags |= FIEMAP_EXTENT_LAST;
>  
>  			err = fiemap_fill_next_extent(fieinfo, vbo, lbo, dlen,
> -						      flags);
> +						      0, flags);
>  			if (err < 0)
>  				break;
>  			if (err == 1) {
> @@ -2062,7 +2062,8 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
>  		if (vbo + bytes >= end)
>  			flags |= FIEMAP_EXTENT_LAST;
>  
> -		err = fiemap_fill_next_extent(fieinfo, vbo, lbo, bytes, flags);
> +		err = fiemap_fill_next_extent(fieinfo, vbo, lbo, bytes, 0,
> +					      flags);
>  		if (err < 0)
>  			break;
>  		if (err == 1) {
> diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
> index 70a768b623cf..eabdf97cd685 100644
> --- a/fs/ocfs2/extent_map.c
> +++ b/fs/ocfs2/extent_map.c
> @@ -723,7 +723,7 @@ static int ocfs2_fiemap_inline(struct inode *inode, struct buffer_head *di_bh,
>  					 id2.i_data.id_data);
>  
>  		ret = fiemap_fill_next_extent(fieinfo, 0, phys, id_count,
> -					      flags);
> +					      0, flags);
>  		if (ret < 0)
>  			return ret;
>  	}
> @@ -794,7 +794,7 @@ int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  		virt_bytes = (u64)le32_to_cpu(rec.e_cpos) << osb->s_clustersize_bits;
>  
>  		ret = fiemap_fill_next_extent(fieinfo, virt_bytes, phys_bytes,
> -					      len_bytes, fe_flags);
> +					      len_bytes, 0, fe_flags);
>  		if (ret)
>  			break;
>  
> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> index 87b63f6ad2e2..23a193512f96 100644
> --- a/fs/smb/client/smb2ops.c
> +++ b/fs/smb/client/smb2ops.c
> @@ -3779,6 +3779,7 @@ static int smb3_fiemap(struct cifs_tcon *tcon,
>  				le64_to_cpu(out_data[i].file_offset),
>  				le64_to_cpu(out_data[i].file_offset),
>  				le64_to_cpu(out_data[i].length),
> +				0,
>  				flags);
>  		if (rc < 0)
>  			goto out;
> diff --git a/include/linux/fiemap.h b/include/linux/fiemap.h
> index c50882f19235..17a6c32cdf3f 100644
> --- a/include/linux/fiemap.h
> +++ b/include/linux/fiemap.h
> @@ -16,6 +16,6 @@ struct fiemap_extent_info {
>  int fiemap_prep(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  		u64 start, u64 *len, u32 supported_flags);
>  int fiemap_fill_next_extent(struct fiemap_extent_info *info, u64 logical,
> -			    u64 phys, u64 len, u32 flags);
> +			    u64 phys, u64 log_len, u64 phys_len, u32 flags);
>  
>  #endif /* _LINUX_FIEMAP_H 1 */
> -- 
> 2.43.0
> 
> 


