Return-Path: <linux-fsdevel+bounces-53199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E84FAEBC3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 17:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40AE41C276AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 15:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0CC2EA148;
	Fri, 27 Jun 2025 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n4oL3gyp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54772E9EBE;
	Fri, 27 Jun 2025 15:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751039166; cv=none; b=imsd+qokC2K6e3405bJW17a9Amjjkx2kEwar12hC1RZ1QppdCrmT/7UrSN6pRr2XGQuRvbieFBqcPnzUZ3/eS3DvrgWgI7K40XxIXiSVl0TGMnQhZA4XWwP5egunoNWBQZKLGRV5gs2b4dBxbya9Xs6iN05M9OcEDwBPichTvqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751039166; c=relaxed/simple;
	bh=pX+4k3111DQycypNzgJjqu+X5auTYHwX1w8qTrIgzYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1ULLAtzfUML1GhHppRv3XtSL91EjFTISQvVm0nPiqzw0VxIE2L22mIa/By9I8KJnRA2leLhx1WSiZk/Wj1IgdkxugFwvRdRHC90FpCGI/dgageOQ1CNTaAqCJ9bd8NbdfFyKWptZU1ik6JXNkJX7ZLuDhdOqb3SMzJawzkAUW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n4oL3gyp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=c3vCkFbhdgYVqqEDes1QFepeOfqXaiheP5+7KDv7Ebw=; b=n4oL3gypIqI5TK4THtINSLCpag
	SLp8q5VAaIR2EAkfhPLrL7o2dw/4U+ToS3OxEkKznV75IoTM1GcozkaWQ/8eEI33+FO5aDjg13dQ9
	DylQV6P3+OXB19c6sT+eReDIh97U+/GmnY8WvId1nHr4daVmwDz7ydeDjadHBnDQG7QrNElKKx/m9
	hFgxuHXLCzivX/7zTwZqwWToFNjne1uEIhM5GhdaBPk0i4oEdgw2GF8trCoksP0lS41SPzRnPF+R1
	pcmWZq+1ZNQMmJ4HglF5LEQKe1q2dAZxj5+MQJwTlZFK5lmsOXAISpwtg5rwx4xV34HpBgEEXMxOQ
	9Fo+Gong==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVBGy-0000000EQ1q-4BPK;
	Fri, 27 Jun 2025 15:45:53 +0000
Date: Fri, 27 Jun 2025 16:45:52 +0100
From: Matthew Wilcox <willy@infradead.org>
To: =?utf-8?B?6ZmI5rab5rab?= Taotao Chen <chentaotao@didiglobal.com>
Cc: "tytso@mit.edu" <tytso@mit.edu>,
	"hch@infradead.org" <hch@infradead.org>,
	"adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
	"rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
	"tursulin@ursulin.net" <tursulin@ursulin.net>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"chentao325@qq.com" <chentao325@qq.com>,
	"frank.li@vivo.com" <frank.li@vivo.com>
Subject: Re: [PATCH v3 3/4] fs: change write_begin/write_end interface to
 take struct kiocb *
Message-ID: <aF68sKzx24P1q54h@casper.infradead.org>
References: <20250627110257.1870826-1-chentaotao@didiglobal.com>
 <20250627110257.1870826-4-chentaotao@didiglobal.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250627110257.1870826-4-chentaotao@didiglobal.com>

On Fri, Jun 27, 2025 at 11:03:11AM +0000, 陈涛涛 Taotao Chen wrote:
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
> index 841a5b18e3df..fdc2fa1e5c41 100644
> --- a/fs/exfat/file.c
> +++ b/fs/exfat/file.c
> @@ -532,10 +532,12 @@ int exfat_file_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
>  	return blkdev_issue_flush(inode->i_sb->s_bdev);
>  }
>  
> -static int exfat_extend_valid_size(struct file *file, loff_t new_valid_size)
> +static int exfat_extend_valid_size(const struct kiocb *iocb,
> +				   loff_t new_valid_size)
>  {
>  	int err;
>  	loff_t pos;
> +	struct file *file = iocb->ki_filp;
>  	struct inode *inode = file_inode(file);
>  	struct exfat_inode_info *ei = EXFAT_I(inode);
>  	struct address_space *mapping = inode->i_mapping;
> @@ -551,14 +553,14 @@ static int exfat_extend_valid_size(struct file *file, loff_t new_valid_size)
>  		if (pos + len > new_valid_size)
>  			len = new_valid_size - pos;
>  
> -		err = ops->write_begin(file, mapping, pos, len, &folio, NULL);
> +		err = ops->write_begin(iocb, mapping, pos, len, &folio, NULL);
>  		if (err)
>  			goto out;
>  
>  		off = offset_in_folio(folio, pos);
>  		folio_zero_new_buffers(folio, off, off + len);
>  
> -		err = ops->write_end(file, mapping, pos, len, len, folio, NULL);
> +		err = ops->write_end(iocb, mapping, pos, len, len, folio, NULL);
>  		if (err < 0)
>  			goto out;
>  		pos += len;
> @@ -604,7 +606,7 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
>  	}
>  
>  	if (pos > valid_size) {
> -		ret = exfat_extend_valid_size(file, pos);
> +		ret = exfat_extend_valid_size(iocb, pos);
>  		if (ret < 0 && ret != -ENOSPC) {
>  			exfat_err(inode->i_sb,
>  				"write: fail to zero from %llu to %llu(%zd)",
> @@ -655,8 +657,11 @@ static vm_fault_t exfat_page_mkwrite(struct vm_fault *vmf)
>  	struct file *file = vma->vm_file;
>  	struct inode *inode = file_inode(file);
>  	struct exfat_inode_info *ei = EXFAT_I(inode);
> +	struct kiocb iocb;
>  	loff_t start, end;
>  
> +	init_sync_kiocb(&iocb, file);
> +
>  	if (!inode_trylock(inode))
>  		return VM_FAULT_RETRY;
>  
> @@ -665,7 +670,7 @@ static vm_fault_t exfat_page_mkwrite(struct vm_fault *vmf)
>  			start + vma->vm_end - vma->vm_start);
>  
>  	if (ei->valid_size < end) {
> -		err = exfat_extend_valid_size(file, end);
> +		err = exfat_extend_valid_size(&iocb, end);
>  		if (err < 0) {
>  			inode_unlock(inode);
>  			return vmf_fs_error(err);

This is unnecessary work.  The only ->write_begin/write_end that we'll
see here is exfat_write_begin() / exfat_write_end() which don't actually
need iocb (or file).  Traditionally we pass NULL in these situations,
but the exfat people probably weren't aware of this convention.

exfat_extend_valid_size() only uses the file it's passed to get the
inode, and both callers already have the inode.  So I'd change
exfat_extend_valid_size() to take an inode instead of a file as its
first argument, then you can skip the creation of an iocb in
exfat_page_mkwrite().

