Return-Path: <linux-fsdevel+bounces-54022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7144CAFA24F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jul 2025 00:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12BF1BC23B7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 22:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB5029B77A;
	Sat,  5 Jul 2025 22:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwj8HT9t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5B21E832A;
	Sat,  5 Jul 2025 22:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751756189; cv=none; b=fYvQqEA8NxDNEVuSNFfC+HMuSWceUUAoBUJUZ3uCZ6bASfnO8ZJzRcb1WiZsil3k8mZm2wfw6hgxHqc/Z9BBABtl9mvn+S3kfesrHB94Z/SGwj6N9PzaW/MMTN3ZSPyBeqmEF37stX1Hk0DramPOnWtYfStYJXHLc7VPHs0LcJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751756189; c=relaxed/simple;
	bh=a3i4jRGxXCB5XfKRUE99TThgc+EDm/z2Y0g4eZ2mpP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6kIPoejdwUv50SUiaXXzBPLVTp/23tYMC7eqV7/eeSJxXh3kpKlX3AyA8ThF27KhsD+itsN57zBXrI3sA1yLvyFyK+nLxQ9vZojasHboeUya2OrA5oluOs2QWc3O0AfnLe9bWS4yq1MA1G89Fn0Immoev5VQVUEYZ4DfpEnv+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwj8HT9t; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-735a6faec9eso1201111a34.3;
        Sat, 05 Jul 2025 15:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751756186; x=1752360986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nICa9Cy/Ik1mDrNaapm3C7wILSwFMeL/8n8Vc7ARhtA=;
        b=lwj8HT9twKAz9tI1c2XIWxhcy4LABS5nVEwKhWS75l2eiDFB3xCLQZDeXBMluUW5m8
         y0e34B8T3EWQFgn3hNri9zc3b5sVnH2g5DJ+lBSSSu2WiOgotUl4HBvWpXgKCz59PWlj
         j5Fah4/dCz6adhAiACXYwaC+XnYwCaLRhOJ7TLaHdBqT+eMqN/9MwlKopc08FYci4W53
         lVIFX7gALMBZjnlRlj3dMGt0R/qq7G10fMAaHdzLoEL7MaChWHicjvnV9Qfeqim5CIrC
         aaavWaKdczM5ZZ+t1/SiJEZfK8RewSkmndZYSRzTZIUwwOUHxGhCN7lovpoOahTfztmk
         +Wog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751756186; x=1752360986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nICa9Cy/Ik1mDrNaapm3C7wILSwFMeL/8n8Vc7ARhtA=;
        b=aCgldi3CLvqW9sxUEWgmApB+Vrkr0gDKZvPKJ4qyJGuAP6fI4xeZ4UMHxrDTbbmEEr
         WbureXObv6RX4J/sD+sP8prnC+yOoM2/zBJymGEueAgZV30/XYW9QhemX6iCi2fJCniM
         9m5+/4w6KBLW98lYdaUHpYOAumAU4jy3gu5GgLd9fm2BPsh6CYPYAFzotuHE6hPHUy2E
         FjHrtXB5PoMkbDH6Jy2riV3s5Fsyv7syoXHt89ceZ7AA+aX3x9fvStoaYIluaajFGNSN
         coPAlcjxVzqlJqAoqN4EGSiuYIa10/dGmfJ/Rmiu59IWjaCwgUtQYhUIAR8kEWeabfhW
         4lgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUah21wnZX/PkVKvErhigoBddAUXXvLKvwGNY15+/IZcaSLkQUjAEVSkpbz4BfrgOk6V1bBGCooIVJPMnwn@vger.kernel.org, AJvYcCVBcFklTcw1UqQVp+rWJ5nQa20bqy9l41hQQh6zCY8V43QcNgej8j4ku7OVrlCHiFsMkWoHaiI9EdfXL8d2Wg==@vger.kernel.org, AJvYcCWBkkm1NWTF0lbzvnmBONjdxlSBp1V7QbknAGO1drCZ7BIcrupVv3lQU2Ds103l1sk0BMLCE0pEl6U=@vger.kernel.org, AJvYcCWot9Vn1kXMZBwO5w/oMYi037MleCi3cu/V4Wz2YCavCpsogQSRyGUhqReCr58StzBatwO/wJmnq5xI@vger.kernel.org
X-Gm-Message-State: AOJu0YyA6ceJRu4qCJQephEnaigqRm3YomN1WIzqTA6slh02MYCEcKXE
	XLQL71xQm6UYQDc1gUn2YuQ0HR1A4XlDWJwk0yAZNZaMmhlsC2LLTA2HlOUNgcjr
X-Gm-Gg: ASbGnct8ihRmJ01mQR/aHSOdpvXiPNS8TS+RaStzk6qM7LM4gekAsnEV6rOih39UpAk
	Z1ufvZym5/apLvsRUxC2K6uDVhTMDODFVT08tqDLI20Ddw7aBzB9IJbI1nivLPqlPrsjIGWw5w2
	kc5o8VhwqzakZ8z0ZIHpXa5qF9veI8dRuvQV4XrTtGVbuPXoIdCILC9TTKOLE/zbvj9IPpTyYRy
	gFu5njiPy7dLT36Dn6c8hrtCvgC50GgXABkzfzTDod7kGc8lNBBoUFBpqrlMRRB+FIM+kVMOXiI
	kwPP/TOF0x5o5O0NT3jt+bRH/AWgjzmhMhgS4LxTW/ZjayIHn6D9Li6zILEU+8glEJnQxjiXMYL
	o
X-Google-Smtp-Source: AGHT+IHuG5FCYsJhjMJavIVyVhItZa43h5Kj54uCqORVbS+uRUzsxc+GupAT4W0CSWAPweEMZrVidA==
X-Received: by 2002:a05:6830:348f:b0:73b:1efa:5f43 with SMTP id 46e09a7af769-73ca0fdda45mr5358902a34.0.1751756185894;
        Sat, 05 Jul 2025 15:56:25 -0700 (PDT)
Received: from groves.net ([2603:8080:1500:3d89:d5d4:7402:f107:a815])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73c9f75354bsm944468a34.16.2025.07.05.15.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 15:56:25 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Sat, 5 Jul 2025 17:56:23 -0500
From: John Groves <John@groves.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	Miklos Szeredi <miklos@szeredb.hu>, Bernd Schubert <bschubert@ddn.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC V2 04/18] dev_dax_iomap: Add dax_operations for use by
 fs-dax on devdax
Message-ID: <ahu24cm4ibrrch4jo2iobhrlxfs3kzyt46ylfovmhy2ztv2qad@upimvr47jvwf>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-5-john@groves.net>
 <20250704134744.00006bcd@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704134744.00006bcd@huawei.com>

On 25/07/04 01:47PM, Jonathan Cameron wrote:
> On Thu,  3 Jul 2025 13:50:18 -0500
> John Groves <John@Groves.net> wrote:
> 
> > Notes about this commit:
> > 
> > * These methods are based on pmem_dax_ops from drivers/nvdimm/pmem.c
> > 
> > * dev_dax_direct_access() is returns the hpa, pfn and kva. The kva was
> >   newly stored as dev_dax->virt_addr by dev_dax_probe().
> > 
> > * The hpa/pfn are used for mmap (dax_iomap_fault()), and the kva is used
> >   for read/write (dax_iomap_rw())
> > 
> > * dev_dax_recovery_write() and dev_dax_zero_page_range() have not been
> >   tested yet. I'm looking for suggestions as to how to test those.
> > 
> > Signed-off-by: John Groves <john@groves.net>
> A few trivial things noticed whilst reading through.

BTW thanks for looking at the dev_dax_iomap part of the series. These are
basically identical to the two standalone-famfs series' I put out last year,
but have IIRC not gotten review comments before this.

> 
> > ---
> >  drivers/dax/bus.c | 120 ++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 115 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> > index 9d9a4ae7bbc0..61a8d1b3c07a 100644
> > --- a/drivers/dax/bus.c
> > +++ b/drivers/dax/bus.c
> > @@ -7,6 +7,10 @@
> >  #include <linux/slab.h>
> >  #include <linux/dax.h>
> >  #include <linux/io.h>
> > +#include <linux/backing-dev.h>
> > +#include <linux/pfn_t.h>
> > +#include <linux/range.h>
> > +#include <linux/uio.h>
> >  #include "dax-private.h"
> >  #include "bus.h"
> >  
> > @@ -1441,6 +1445,105 @@ __weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
> >  }
> >  EXPORT_SYMBOL_GPL(dax_pgoff_to_phys);
> >  
> > +#if IS_ENABLED(CONFIG_DEV_DAX_IOMAP)
> > +
> > +static void write_dax(void *pmem_addr, struct page *page,
> > +		unsigned int off, unsigned int len)
> > +{
> > +	unsigned int chunk;
> > +	void *mem;
> 
> I'd move these two into the loop - similar to what you have
> in other cases with more local scope.

Done, thanks.

> 
> > +
> > +	while (len) {
> > +		mem = kmap_local_page(page);
> > +		chunk = min_t(unsigned int, len, PAGE_SIZE - off);
> > +		memcpy_flushcache(pmem_addr, mem + off, chunk);
> > +		kunmap_local(mem);
> > +		len -= chunk;
> > +		off = 0;
> > +		page++;
> > +		pmem_addr += chunk;
> > +	}
> > +}
> > +
> > +static long __dev_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
> > +			long nr_pages, enum dax_access_mode mode, void **kaddr,
> > +			pfn_t *pfn)
> > +{
> > +	struct dev_dax *dev_dax = dax_get_private(dax_dev);
> > +	size_t size = nr_pages << PAGE_SHIFT;
> > +	size_t offset = pgoff << PAGE_SHIFT;
> > +	void *virt_addr = dev_dax->virt_addr + offset;
> > +	u64 flags = PFN_DEV|PFN_MAP;
> 
> spaces around the |
> 
> Though given it's in just one place, just put these inline next
> to the question...

Done and done.

> 
> 
> > +	phys_addr_t phys;
> > +	pfn_t local_pfn;
> > +	size_t dax_size;
> > +
> > +	WARN_ON(!dev_dax->virt_addr);
> > +
> > +	if (down_read_interruptible(&dax_dev_rwsem))
> > +		return 0; /* no valid data since we were killed */
> > +	dax_size = dev_dax_size(dev_dax);
> > +	up_read(&dax_dev_rwsem);
> > +
> > +	phys = dax_pgoff_to_phys(dev_dax, pgoff, nr_pages << PAGE_SHIFT);
> > +
> > +	if (kaddr)
> > +		*kaddr = virt_addr;
> > +
> > +	local_pfn = phys_to_pfn_t(phys, flags); /* are flags correct? */
> > +	if (pfn)
> > +		*pfn = local_pfn;
> > +
> > +	/* This the valid size at the specified address */
> > +	return PHYS_PFN(min_t(size_t, size, dax_size - offset));
> > +}
> 
> > +static size_t dev_dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
> > +		void *addr, size_t bytes, struct iov_iter *i)
> > +{
> > +	size_t off;
> > +
> > +	off = offset_in_page(addr);
> 
> Unused.

Righto. Thanks.

> > +
> > +	return _copy_from_iter_flushcache(addr, bytes, i);
> > +}
> 
> 

Thanks!
John


