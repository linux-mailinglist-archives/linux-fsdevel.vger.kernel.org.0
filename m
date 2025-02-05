Return-Path: <linux-fsdevel+bounces-40912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F57A28B28
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 14:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CFBE18829CA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 13:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26ECF86337;
	Wed,  5 Feb 2025 13:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8xyOu9s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31F515E97
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 13:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760614; cv=none; b=IA8A2MQYj8HSh02TQ2QQY4XePOzHGERO0CbX/8wSUszAbCoceEbTvtWFZlYrJQboU/gDt/brLN6mVuhCl7SCAK4XIaWz1cChBPdHOwJ3mJK0UOH5ORURj/ybPFGssC6EPQNlwavuoeU4qvKAEGtfUoJRaHg5aurQTmwJQd9pnEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760614; c=relaxed/simple;
	bh=BOSJf1U+Nbg5gigVlZ2hnJt3nIMlCZrCwGGWsGl4xAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sirhOzJWrAfDsYvEleARO7sw4PjhQgBudj5Io+XVdYfLGtT/+R8UyCQND4V8o+w5tGCgunxcJ6wcedEJiXNwXchfhTZWfR4mkUcQ712MRK3vpi12HvTjCimc6UXm6QpPMepdJ7m9DhQWKkVWMnaDz6unIPNL+ZM3+vOi2TNpG2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e8xyOu9s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738760610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l83Dw368hueJll8PyntCW0Nb5bpCWlX4zt8mq3uaKys=;
	b=e8xyOu9suDOEhyW1mYGaLKcIJGBjrcqeVXECLhKDkkSK9/9WxBUmeLY8jPukXrRwHvqZUT
	idD6vGpmfT7frs/Ir/O6HV0g1JSs8RfHN2RzPcQh65CJKBZVfWgY7/6USJxKzvuQ9EeeMS
	5Z34rgC89sFvm/ChZyDIFZ44EbS9338=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-1l4K9GaVMGO1d3Se1A4h_Q-1; Wed,
 05 Feb 2025 08:03:26 -0500
X-MC-Unique: 1l4K9GaVMGO1d3Se1A4h_Q-1
X-Mimecast-MFC-AGG-ID: 1l4K9GaVMGO1d3Se1A4h_Q
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FC961801A0D;
	Wed,  5 Feb 2025 13:03:19 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.186])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72B8C3000197;
	Wed,  5 Feb 2025 13:03:15 +0000 (UTC)
Received: by fedora.redhat.com (Postfix, from userid 1000)
	id A724B6AA37D; Wed,  5 Feb 2025 08:03:13 -0500 (EST)
Date: Wed, 5 Feb 2025 08:03:13 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: akpm@linux-foundation.org, dan.j.williams@intel.com, linux-mm@kvack.org,
	alison.schofield@intel.com, lina@asahilina.net,
	zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com,
	bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca,
	catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
	npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com,
	willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
	linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
	david@fromorbit.com, chenhuacai@kernel.org, kernel@xen0n.name,
	loongarch@lists.linux.dev, Hanna Czenczek <hreitz@redhat.com>,
	German Maglione <gmaglione@redhat.com>
Subject: Re: [PATCH v6 01/26] fuse: Fix dax truncate/punch_hole fault path
Message-ID: <Z6NhkR8ZEso4F-Wx@redhat.com>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <bfae590045c7fc37b7ccef10b9cec318012979fd.1736488799.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfae590045c7fc37b7ccef10b9cec318012979fd.1736488799.git-series.apopple@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Jan 10, 2025 at 05:00:29PM +1100, Alistair Popple wrote:
> FS DAX requires file systems to call into the DAX layout prior to unlinking
> inodes to ensure there is no ongoing DMA or other remote access to the
> direct mapped page. The fuse file system implements
> fuse_dax_break_layouts() to do this which includes a comment indicating
> that passing dmap_end == 0 leads to unmapping of the whole file.
> 
> However this is not true - passing dmap_end == 0 will not unmap anything
> before dmap_start, and further more dax_layout_busy_page_range() will not
> scan any of the range to see if there maybe ongoing DMA access to the
> range. Fix this by passing -1 for dmap_end to fuse_dax_break_layouts()
> which will invalidate the entire file range to
> dax_layout_busy_page_range().

Hi Alistair,

Thanks for fixing DAX related issues for virtiofs. I am wondering how are
you testing DAX with virtiofs. AFAIK, we don't have DAX support in Rust
virtiofsd. C version of virtiofsd used to have out of the tree patches
for DAX. But C version got deprecated long time ago.

Do you have another implementation of virtiofsd somewhere else which
supports DAX and allows for testing DAX related changes?

Thanks
Vivek

> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Fixes: 6ae330cad6ef ("virtiofs: serialize truncate/punch_hole and dax fault path")
> Cc: Vivek Goyal <vgoyal@redhat.com>
> 
> ---
> 
> Changes for v6:
> 
>  - Original patch had a misplaced hunk due to a bad rebase.
>  - Reworked fix based on Dan's comments.
> ---
>  fs/fuse/dax.c  | 1 -
>  fs/fuse/dir.c  | 2 +-
>  fs/fuse/file.c | 4 ++--
>  3 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> index 9abbc2f..455c4a1 100644
> --- a/fs/fuse/dax.c
> +++ b/fs/fuse/dax.c
> @@ -681,7 +681,6 @@ static int __fuse_dax_break_layouts(struct inode *inode, bool *retry,
>  			0, 0, fuse_wait_dax_page(inode));
>  }
>  
> -/* dmap_end == 0 leads to unmapping of whole file */
>  int fuse_dax_break_layouts(struct inode *inode, u64 dmap_start,
>  				  u64 dmap_end)
>  {
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 0b2f856..bc6c893 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1936,7 +1936,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  	if (FUSE_IS_DAX(inode) && is_truncate) {
>  		filemap_invalidate_lock(mapping);
>  		fault_blocked = true;
> -		err = fuse_dax_break_layouts(inode, 0, 0);
> +		err = fuse_dax_break_layouts(inode, 0, -1);
>  		if (err) {
>  			filemap_invalidate_unlock(mapping);
>  			return err;
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 082ee37..cef7a8f 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -253,7 +253,7 @@ static int fuse_open(struct inode *inode, struct file *file)
>  
>  	if (dax_truncate) {
>  		filemap_invalidate_lock(inode->i_mapping);
> -		err = fuse_dax_break_layouts(inode, 0, 0);
> +		err = fuse_dax_break_layouts(inode, 0, -1);
>  		if (err)
>  			goto out_inode_unlock;
>  	}
> @@ -2890,7 +2890,7 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
>  	inode_lock(inode);
>  	if (block_faults) {
>  		filemap_invalidate_lock(inode->i_mapping);
> -		err = fuse_dax_break_layouts(inode, 0, 0);
> +		err = fuse_dax_break_layouts(inode, 0, -1);
>  		if (err)
>  			goto out;
>  	}
> -- 
> git-series 0.9.1
> 


