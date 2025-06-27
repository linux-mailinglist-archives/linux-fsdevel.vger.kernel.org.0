Return-Path: <linux-fsdevel+bounces-53200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AF2AEBC79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 17:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 672397A8E5D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 15:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC382EA496;
	Fri, 27 Jun 2025 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z0ceVbAZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8427623B61F;
	Fri, 27 Jun 2025 15:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751039546; cv=none; b=folD3kd1+eNGMSsZz+jhDRf+p5V8Xv73tNONYwk5+u5Bc5amWrdtimE1+hls0ImydF9BZYxAKzChjVCVJN/XO1IRNANNuSDj149LW6FfHQBBZqA0w/nvyB2okjBFCC6dHIVO3ONfmHnpqbkSwLReWOhx3sdISwVUExu9CGrKxVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751039546; c=relaxed/simple;
	bh=d40eK7td5Xa1FR52S3Q2YnEJMCDbNmnB5/xe1+8KVxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/dCTWmNR0A1z+ekx7OLIwpGWjlE4mAzVryI7xqXNKN5jmElNUnJM8VOBoh0F21KmtW1c0azrAUw5WEyHYxwZKgzr8BKcYnm6e9HmC2WA/Nigiil3VwL/+FnpeXJfpKRCLhq6KOPosrraEoMkSKxyepdIVUuwDUqZypU7obqtKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z0ceVbAZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Z+c/vMVBxvVliRM5Ba7u5qi1BNZCmTnatXuCT2DSf3s=; b=Z0ceVbAZOy3oDx3Jzp0zWCkcEC
	5+/Ux5Woml8GdpSfkIhVTxnoD/1Ma1995s/H+9SLhMV2WFdH9AnA9VE6AMi5lmgAUc/GeLJBH8dv8
	E+M91T3jrx+/xDUjfEcpMkKP2yciCidFInvaEizsorLfYjYs4vSQqrO5c8ROi7216sQU8i31mcYAN
	tujVt5eFpXiIQNYSJqIuB4VKAotXXyXWuUkTHDWgreQsgQoRPqOcBBnTBM8tXQMMJZ9gn6FY62Phu
	Xf2fu73K0hPBw9c5br2aSuebLqlrVwLN+UclnVhjVRg3/Iu1SkfzhW56ODmF5CZeO5B9qaQwK9fRF
	+21HmNKA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVBN9-0000000EQf9-17Tf;
	Fri, 27 Jun 2025 15:52:15 +0000
Date: Fri, 27 Jun 2025 16:52:15 +0100
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
Message-ID: <aF6-L5Eu7XieS8aM@casper.infradead.org>
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
> @@ -1399,13 +1400,10 @@ static int write_end_fn(handle_t *handle, struct inode *inode,
>  }
>  
>  /*
> - * We need to pick up the new inode size which generic_commit_write gave us
> - * `file' can be NULL - eg, when called from page_symlink().
> - *

Why delete this?  It seems still true to me, other than s/file/iocb/

>   * ext4 never places buffers on inode->i_mapping->i_private_list.  metadata
>   * buffers are managed internally.
>   */
> -static int ext4_write_end(struct file *file,
> +static int ext4_write_end(const struct kiocb *iocb,
>  			  struct address_space *mapping,
>  			  loff_t pos, unsigned len, unsigned copied,
>  			  struct folio *folio, void *fsdata)

