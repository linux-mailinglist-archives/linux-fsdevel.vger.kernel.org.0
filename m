Return-Path: <linux-fsdevel+bounces-12812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BA1867695
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 14:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59D10B228AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 13:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E02C128839;
	Mon, 26 Feb 2024 13:30:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7286128368;
	Mon, 26 Feb 2024 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954244; cv=none; b=h7Fin6XOyAfKsfOr5+CzaOhk4+KVD9wW+usUweDCNtCuDFXCoG8LcA+5Vzindu5RU/XunTDONtZx4kxh6uGvf2HBoZRmDca8PdIj9c9t4LeEImbPYd8TJy8LFttlCCuPb0SbVm/26nTcc92ZI53hWUM9gLOUKnLPy7PwLRc7vUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954244; c=relaxed/simple;
	bh=WmTzU75gfsPPhSRwgy0QA82m5EmwYSqwqUgyS5HWrKI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RbyJ/r2VmvhrVfZ8LBiwbfWG/+WFlOZHhXpvnMgAcdLTwwKDr4rplq+SqjGSxNNqbwtHJGlhZcwFaDKivjQk47wtlbxpiyUBvj0Rpcpw9UW/P6qBFPNOB2IYGvm2TheJzIODqLRyu9cqfvVwh96eRaReq5iKeFxtQH7OENo/820=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tk1bd08dZz6K5wc;
	Mon, 26 Feb 2024 21:26:21 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 13A2A140A70;
	Mon, 26 Feb 2024 21:30:40 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Feb
 2024 13:30:39 +0000
Date: Mon, 26 Feb 2024 13:30:38 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: John Groves <John@Groves.net>
CC: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, "Dan
 Williams" <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
	<linux-cxl@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <john@jagalactic.com>, Dave Chinner
	<david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>,
	<dave.hansen@linux.intel.com>, <gregory.price@memverge.com>
Subject: Re: [RFC PATCH 13/20] famfs: Add iomap_ops
Message-ID: <20240226133038.00006e23@Huawei.com>
In-Reply-To: <2996a7e757c3762a9a28c789645acd289f5f7bc0.1708709155.git.john@groves.net>
References: <cover.1708709155.git.john@groves.net>
	<2996a7e757c3762a9a28c789645acd289f5f7bc0.1708709155.git.john@groves.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 23 Feb 2024 11:41:57 -0600
John Groves <John@Groves.net> wrote:

> This commit introduces the famfs iomap_ops. When either
> dax_iomap_fault() or dax_iomap_rw() is called, we get a callback
> via our iomap_begin() handler. The question being asked is
> "please resolve (file, offset) to (daxdev, offset)". The function
> famfs_meta_to_dax_offset() does this.
> 
> The per-file metadata is just an extent list to the
> backing dax dev.  The order of this resolution is O(N) for N
> extents. Note with the current user space, files usually have
> only one extent.
> 
> Signed-off-by: John Groves <john@groves.net>

> ---
>  fs/famfs/famfs_file.c | 245 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 245 insertions(+)
>  create mode 100644 fs/famfs/famfs_file.c
> 
> diff --git a/fs/famfs/famfs_file.c b/fs/famfs/famfs_file.c
> new file mode 100644
> index 000000000000..fc667d5f7be8
> --- /dev/null
> +++ b/fs/famfs/famfs_file.c
> @@ -0,0 +1,245 @@

> +static int
> +famfs_meta_to_dax_offset(
> +	struct inode *inode,
> +	struct iomap *iomap,
> +	loff_t        offset,
> +	loff_t        len,
> +	unsigned int  flags)
> +{
> +	struct famfs_file_meta *meta = (struct famfs_file_meta *)inode->i_private;

i_private is void * so no need for explicit cast (C spec says this is always fine without)


> +
> +/**
> + * famfs_iomap_begin()
> + *
> + * This function is pretty simple because files are
> + * * never partially allocated
> + * * never have holes (never sparse)
> + * * never "allocate on write"
> + */
> +static int
> +famfs_iomap_begin(
> +	struct inode	       *inode,
> +	loff_t			offset,
> +	loff_t			length,
> +	unsigned int		flags,
> +	struct iomap	       *iomap,
> +	struct iomap	       *srcmap)
> +{
> +	struct famfs_file_meta *meta = inode->i_private;
> +	size_t size;
> +	int rc;
> +
> +	size = i_size_read(inode);
> +
> +	WARN_ON(size != meta->file_size);
> +
> +	rc = famfs_meta_to_dax_offset(inode, iomap, offset, length, flags);
> +
> +	return rc;
	return famfs_meta_...

> +}


> +static vm_fault_t
> +famfs_filemap_map_pages(
> +	struct vm_fault	       *vmf,
> +	pgoff_t			start_pgoff,
> +	pgoff_t			end_pgoff)
> +{
> +	vm_fault_t ret;
> +
> +	ret = filemap_map_pages(vmf, start_pgoff, end_pgoff);
> +	return ret;
	return filename_map_pages()....

> +}
> +
>


