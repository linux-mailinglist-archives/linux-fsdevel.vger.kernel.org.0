Return-Path: <linux-fsdevel+bounces-28365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C3E969D9C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 14:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E7CF284C3A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 12:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31D61D61A8;
	Tue,  3 Sep 2024 12:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qn0o1gnF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A811D0958
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 12:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725366604; cv=none; b=IG7Vk/6/hCTzwsstg8uVEDNd9Ir4fs0uOzufuT3jrSTWgXfrXPE37o1XjshwN56BH0vEQzRi/Id+cwyulUlRY81a1zLSbdPdwAoTQa3oQhdrIT5KzQ2fRc+Z20eSIUR5eGtSSDGFvsBPBLdYFscWfWhLgrSmqHcUANNA9HvxsvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725366604; c=relaxed/simple;
	bh=MadOy1n9lMn2gJiTmCo/b3sxyuT0+3q42VXhnUpkc+k=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=g0IQbucu1fehUPEpE0QCWbW93FIgeTNMq95GexX15bL0sd7Ij8aQg705BLiR9lkN341m7FxBk1hZ/e29LAh4H/F8fS+CIhBBxMHBIRslPJxTbR9w+USJYp3HVcGEXp3ONXOYkvEAPl5OHSoxXn6FhELnuh6cgdZlSMoCeC2JmO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qn0o1gnF; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240903122954euoutp01c3fc7872adcc17009ce7e5a37b369699~xu8bBqCeb2524225242euoutp01C
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 12:29:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240903122954euoutp01c3fc7872adcc17009ce7e5a37b369699~xu8bBqCeb2524225242euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725366594;
	bh=cgNOgNReNzAJFf9P5wa3Kro2zVp3TLloPkWMjpgBKgI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=qn0o1gnFDe30/e5l1CNLn8s6VRfRR4IZnoshRZ5H/dfQFW/dnweGOz1wEGpuK8ejY
	 3fMvN4SZzwnOJvlA8hNFLYq18YYKFMZbxMVUX8ekj24TP4NEo8PG/10+sW5G7k8YWf
	 N7eeu1FWQY93iu2gdIO3BPMiZwKOUaJ2PLjh/kp0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240903122952eucas1p2ac10c1a77d1c5248183d9ccffd55c25a~xu8ZW4yn20966109661eucas1p2g;
	Tue,  3 Sep 2024 12:29:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 0B.49.09624.04107D66; Tue,  3
	Sep 2024 13:29:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240903122952eucas1p208675907d19ad2a8f7f46756163f0b59~xu8YuAl6V2062120621eucas1p2D;
	Tue,  3 Sep 2024 12:29:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240903122952eusmtrp1603deb26a30cdd3061f0cbdab62f6f61~xu8YtMypv2418124181eusmtrp1F;
	Tue,  3 Sep 2024 12:29:52 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-f3-66d70140ec54
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id FD.CD.14621.F3107D66; Tue,  3
	Sep 2024 13:29:51 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240903122951eusmtip21569f5ad77ab643529872aec9866690e~xu8YabmBK0762607626eusmtip2R;
	Tue,  3 Sep 2024 12:29:51 +0000 (GMT)
Received: from localhost (106.110.32.87) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 3 Sep 2024 13:29:50 +0100
Date: Tue, 3 Sep 2024 14:29:50 +0200
From: Daniel Gomez <da.gomez@samsung.com>
To: <brauner@kernel.org>
CC: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	<akpm@linux-foundation.org>, <chandan.babu@oracle.com>,
	<linux-fsdevel@vger.kernel.org>, <djwong@kernel.org>, <hare@suse.de>,
	<gost.dev@samsung.com>, <linux-xfs@vger.kernel.org>, <hch@lst.de>,
	<david@fromorbit.com>, Zi Yan <ziy@nvidia.com>,
	<yang@os.amperecomputing.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <willy@infradead.org>, <john.g.garry@oracle.com>,
	<cl@os.amperecomputing.com>, <p.raghav@samsung.com>, <mcgrof@kernel.org>,
	<ryan.roberts@arm.com>, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH v13 10/10] xfs: enable block size larger than page size
 support
Message-ID: <20240903122950.eugl53tler4n52ao@AALNPWDAGOMEZ1.aal.scsc.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240822135018.1931258-11-kernel@pankajraghav.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf1CTdRy+7/u+vO+75bjXsfJ7aFZI6ixQLquvB2eA5r2X52VX7jrJZMrr
	oMbgNhHCuNDudjk2VHIKA2mHpMwt0MHhfgCdowEbktakSHSpgZ0w4ASj1KJ8fdfpf8/n+TzP
	fZ/nc18al87GxNN5mt2cVqNUJ5Bior3n3vdJ6eDnXavqf1qK6locJBrvngboR/9i1PzNDQy1
	9YQBGhg7TqHQSCzqaKjCkM3ux9Cl+y6ALtyeIVBHZ4BAIU8dicKOf2OQ528XhYYOjQJk9JoB
	evDXw4WpMUChWn+YSpexjnoHYIMNkG1tWsE6Tx8gWed0FcX2VT8gWO8v5SRr+nySZO+MXiHY
	itAQxQ7YMtiprkGSbe3fy844F2+O3SpOy+HUeXs47cq12eJco/cSWTj4UknjyctUObAuMQCa
	hsxq2O1dYwBiWso0ATjuK6eE4S6AR2udmDDMAHiuw0MYgOiRw3rdD4TFKQAt+puPVefvTuHC
	4ASw3n8N8BaCSYS3Bo+QPCYZOewKOCn+cRkDoadBwetxxk9AfdMoxmviGAW0/voDzmskzEb4
	j/sznpYw82GgZuRRCpx5GVq90yQvwZmF8NQczdMiJh1WmH6nhKAvwOrDtmjoMhhsu4IJeL8Y
	HhzNE/B62Dm8L8rHwbHetqh3Eez/0hj1qmBjsyWKC2HHsCVGOF0qrLygFugM2HvNFqVj4dDE
	fCFkLKxqP4YLtAR+oZcK6qXQHo4Qh8ASyxO1LE/UsjyuZQX4abCAK9LlqzhdioYrTtYp83VF
	GlXyzoJ8J3j4Nfvneqdd4PjYnWQfwGjgA5DGE2SSbWcHd0klOcpPSjltwXZtkZrT+cBCmkhY
	IHkx5zlOyqiUu7mPOa6Q0/6/xWhRfDmWGLR9CLcPlLylMLgnli8KuGZPXnd9ZMoozDo8efWr
	M/NMx4p/M5vvg3V9y69ORpQ3DxR7kkuXhfdUdvscxvbVedkXxz1/4M71ubi8TN26+ah+VZnG
	Pu87Q1ZBMO489XQN8LW8kbWtRfPqt+rO15D1g2cHZIqV3MFNFyPASpfWDifNlr33/LtT3drW
	kcw/x1vMX8e539b02n1yRfyMuejGphTZZVb/lCjz1rqU5uCa2/u67u0Fcuv7mUfeeWXLjpq1
	Sen2rdmpkVRjWkgxXHAi0lDxzIk397sdn6ZJ+5gNdS6jZi6x1ORunCoWJU2Emis3vt5WvWMD
	IxLDnapzJfIeVQKhy1WmrMC1OuV/WFlUoAkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsVy+t/xe7r2jNfTDG4ut7CYs34Nm8Xrw58Y
	LS4dlbNYt/Yhk8WWY/cYLc6+mstucfkJn8WeRZOYLFauPspkceHXDkaLMy8/s1js2XuSxeLy
	rjlsFvfW/Ge12PVnB7vFjQlPGS16dk9ltPj9AyjRu+Qku8Xso/fYHUQ81sxbw+hxapGEx+YV
	Wh6bVnWyeWz6NInd48SM3yweu282sHn0Nr9j8/j49BaLR/flG+weZ1c6erzfd5XNY/Ppao/P
	m+QC+KL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0
	Mnp2X2AruKpdsWTZFfYGxgXKXYycHBICJhILHhxl7GLk4hASWMoosWDyARaIhIzExi9XWSFs
	YYk/17rYIIo+Mkqc3XwfytnEKLF7wQ4mkCoWARWJZ1ensIHYbAKaEvtObmLvYuTgEBGQkNi1
	KAyknlngKItE24qnYPXCAmESC+5fZAap4RXwlvi7sx4kLCRwglGiZ6UiiM0rIChxcuYTsIOY
	BXQkFuz+xAZSziwgLbH8HwdImFPAQaK79zk7xJ2KEjMmroS6v1bi899njBMYhWchmTQLyaRZ
	CJMWMDKvYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECEwg24793LyDcd6rj3qHGJk4GA8xSnAw
	K4nwxm68mibEm5JYWZValB9fVJqTWnyI0RQYEBOZpUST84EpLK8k3tDMwNTQxMzSwNTSzFhJ
	nNft8vk0IYH0xJLU7NTUgtQimD4mDk6pBiZdt+45Z3mV3M1lJ62bPv9R4HmL32yxT9tef++N
	bGLSDMr45373gE7v2+2NFxW/zdicphp5tjG18Nq7wI53bkXvQ0U2Ci065fn1tZzF1NsqNS01
	HZ4Fp89E3u82DF1r9U6b9f7KBJ5ztiuunc5k/eN7NPrt3Q8zr99mNHG4ZqhifFgrzf3000NH
	d/tMlxQNyZN6dN1F3f93urL0utSzMfrPWlezxd6+dTvqpPEXeYF50re9yx9e3TDBlFnOyDnb
	hzuJ6+CrvnMi7jfyjCu7lueEbvNsWdzw/feJ+TznmzhPvGT2dFd6pfaNhb3NpqziwfzAh+pV
	u6RyPkfYXZh9RemYKUNPaSRPC/vHBW6lRUosxRmJhlrMRcWJAG+r+XKpAwAA
X-CMS-MailID: 20240903122952eucas1p208675907d19ad2a8f7f46756163f0b59
X-Msg-Generator: CA
X-RootMTR: 20240822135125eucas1p1c9928c1596c724973055d94103adba96
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240822135125eucas1p1c9928c1596c724973055d94103adba96
References: <20240822135018.1931258-1-kernel@pankajraghav.com>
	<CGME20240822135125eucas1p1c9928c1596c724973055d94103adba96@eucas1p1.samsung.com>
	<20240822135018.1931258-11-kernel@pankajraghav.com>

On Thu, Aug 22, 2024 at 03:50:18PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Page cache now has the ability to have a minimum order when allocating
> a folio which is a prerequisite to add support for block size > page
> size.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> ---
>  fs/xfs/libxfs/xfs_ialloc.c |  5 +++++
>  fs/xfs/libxfs/xfs_shared.h |  3 +++
>  fs/xfs/xfs_icache.c        |  6 ++++--
>  fs/xfs/xfs_mount.c         |  1 -
>  fs/xfs/xfs_super.c         | 28 ++++++++++++++++++++--------
>  include/linux/pagemap.h    | 13 +++++++++++++
>  6 files changed, 45 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
> index 0af5b7a33d055..1921b689888b8 100644
> --- a/fs/xfs/libxfs/xfs_ialloc.c
> +++ b/fs/xfs/libxfs/xfs_ialloc.c
> @@ -3033,6 +3033,11 @@ xfs_ialloc_setup_geometry(
>  		igeo->ialloc_align = mp->m_dalign;
>  	else
>  		igeo->ialloc_align = 0;
> +
> +	if (mp->m_sb.sb_blocksize > PAGE_SIZE)
> +		igeo->min_folio_order = mp->m_sb.sb_blocklog - PAGE_SHIFT;
> +	else
> +		igeo->min_folio_order = 0;
>  }
>  
>  /* Compute the location of the root directory inode that is laid out by mkfs. */
> diff --git a/fs/xfs/libxfs/xfs_shared.h b/fs/xfs/libxfs/xfs_shared.h
> index 2f7413afbf46c..33b84a3a83ff6 100644
> --- a/fs/xfs/libxfs/xfs_shared.h
> +++ b/fs/xfs/libxfs/xfs_shared.h
> @@ -224,6 +224,9 @@ struct xfs_ino_geometry {
>  	/* precomputed value for di_flags2 */
>  	uint64_t	new_diflags2;
>  
> +	/* minimum folio order of a page cache allocation */
> +	unsigned int	min_folio_order;
> +
>  };
>  
>  #endif /* __XFS_SHARED_H__ */
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index cf629302d48e7..0fcf235e50235 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -88,7 +88,8 @@ xfs_inode_alloc(
>  
>  	/* VFS doesn't initialise i_mode! */
>  	VFS_I(ip)->i_mode = 0;
> -	mapping_set_large_folios(VFS_I(ip)->i_mapping);
> +	mapping_set_folio_min_order(VFS_I(ip)->i_mapping,
> +				    M_IGEO(mp)->min_folio_order);
>  
>  	XFS_STATS_INC(mp, vn_active);
>  	ASSERT(atomic_read(&ip->i_pincount) == 0);
> @@ -325,7 +326,8 @@ xfs_reinit_inode(
>  	inode->i_uid = uid;
>  	inode->i_gid = gid;
>  	inode->i_state = state;
> -	mapping_set_large_folios(inode->i_mapping);
> +	mapping_set_folio_min_order(inode->i_mapping,
> +				    M_IGEO(mp)->min_folio_order);
>  	return error;
>  }
>  
> diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> index 3949f720b5354..c6933440f8066 100644
> --- a/fs/xfs/xfs_mount.c
> +++ b/fs/xfs/xfs_mount.c
> @@ -134,7 +134,6 @@ xfs_sb_validate_fsb_count(
>  {
>  	uint64_t		max_bytes;
>  
> -	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
>  	ASSERT(sbp->sb_blocklog >= BBSHIFT);
>  
>  	if (check_shl_overflow(nblocks, sbp->sb_blocklog, &max_bytes))
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 210481b03fdb4..8cd76a01b543f 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1638,16 +1638,28 @@ xfs_fs_fill_super(
>  		goto out_free_sb;
>  	}
>  
> -	/*
> -	 * Until this is fixed only page-sized or smaller data blocks work.
> -	 */
>  	if (mp->m_sb.sb_blocksize > PAGE_SIZE) {
> -		xfs_warn(mp,
> -		"File system with blocksize %d bytes. "
> -		"Only pagesize (%ld) or less will currently work.",
> +		size_t max_folio_size = mapping_max_folio_size_supported();
> +
> +		if (!xfs_has_crc(mp)) {
> +			xfs_warn(mp,
> +"V4 Filesystem with blocksize %d bytes. Only pagesize (%ld) or less is supported.",
>  				mp->m_sb.sb_blocksize, PAGE_SIZE);
> -		error = -ENOSYS;
> -		goto out_free_sb;
> +			error = -ENOSYS;
> +			goto out_free_sb;
> +		}
> +
> +		if (mp->m_sb.sb_blocksize > max_folio_size) {
> +			xfs_warn(mp,
> +"block size (%u bytes) not supported; Only block size (%ld) or less is supported",

This small fix [1] is missing in linux-next and vfs trees. Can it be picked?

[1] https://lore.kernel.org/all/Zs_vIaw8ESLN2TwY@casper.infradead.org/

> +				mp->m_sb.sb_blocksize, max_folio_size);
> +			error = -ENOSYS;
> +			goto out_free_sb;
> +		}
> +
> +		xfs_warn(mp,
> +"EXPERIMENTAL: V5 Filesystem with Large Block Size (%d bytes) enabled.",
> +			mp->m_sb.sb_blocksize);
>  	}
>  
>  	/* Ensure this filesystem fits in the page cache limits */
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 4cc170949e9c0..55b254d951da7 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -374,6 +374,19 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
>  #define MAX_XAS_ORDER		(XA_CHUNK_SHIFT * 2 - 1)
>  #define MAX_PAGECACHE_ORDER	min(MAX_XAS_ORDER, PREFERRED_MAX_PAGECACHE_ORDER)
>  
> +/*
> + * mapping_max_folio_size_supported() - Check the max folio size supported
> + *
> + * The filesystem should call this function at mount time if there is a
> + * requirement on the folio mapping size in the page cache.
> + */
> +static inline size_t mapping_max_folio_size_supported(void)
> +{
> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> +		return 1U << (PAGE_SHIFT + MAX_PAGECACHE_ORDER);
> +	return PAGE_SIZE;
> +}
> +
>  /*
>   * mapping_set_folio_order_range() - Set the orders supported by a file.
>   * @mapping: The address space of the file.
> -- 
> 2.44.1
> 

