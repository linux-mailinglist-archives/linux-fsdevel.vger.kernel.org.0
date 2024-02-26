Return-Path: <linux-fsdevel+bounces-12895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C11868429
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 00:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927A01F22913
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 23:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEE9135A4E;
	Mon, 26 Feb 2024 23:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZv8aGO6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B49134CE3;
	Mon, 26 Feb 2024 23:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708988406; cv=none; b=oZLmMK7GrMs5bbjM/46RRU+bxFz2fwhBkZT5250AtoNFp+l9A57uLdZJiai0VvGQp7zFEHXJM8BiRMy1Ls7919ztyugNnYbVkaahCCi/53x2i0p7fKo34AmyWwcB+CS2r3+04KV4w6NZvgKnzSBLpzrqeovfl0LKdper3RD165Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708988406; c=relaxed/simple;
	bh=eDdDRpRLOs+TLu9DRUmMhRRpoJ/GPPb+1lbirKhJPXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3SnwahZQIC9R8FhKxfQbEyzEbxovNP+LfwQkuyJSC0rhn6UAum09gvOesxyFhd+OhVppxHkQFNPcYxHvKUueJbfJx6LXLij6gm3bK6Y+QDsSYCYFQc/bYPI595xWH1kuPcCXV1aa2j8kzHnrP9mtVqEdsBVMY28L/xGWKWaYJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZv8aGO6; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5a054fa636eso2001859eaf.0;
        Mon, 26 Feb 2024 15:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708988403; x=1709593203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zww+OwBsoYB5pURroMSrOkz/ZQvrjX3VS1JUC45kLpM=;
        b=WZv8aGO6ryajzFRToQ2E9JUurbQjzqasuLOOQjViyK/CUZQ3tTji+DbKD93jlap9LL
         c67tsyu7ZYu6VvbSIBCZiqN9yEzx2dUPOBRJHzwiq3Uxoh5bZdVz1lt3af5zpIf59sbH
         RGIpzG/GMNJHyzRwwWakqgZAFN7NBhRer2ui4llSiW2n62Jx/nGd+e0Xer+6O4Azhjcf
         NLXvwpM5ajaQ3MMGKJiVyYiAR05TwBR57XqfKsPPMVtGDJWgdQ+J/zPieYmGLGwNxmSq
         +DOUYP6eZoNMJotduP9iaSXJc0/RMB4DWPRS6pooqwxr1rOKQuwBeNIfQI5qm8/PxELJ
         26PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708988403; x=1709593203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zww+OwBsoYB5pURroMSrOkz/ZQvrjX3VS1JUC45kLpM=;
        b=seBhbM+1W480hFZFbbeS4+zNAPMhcoVGbbQ0QlE9AhYbB6w52Ehvdlzb8/kSM3YRq2
         wCXNxa0IvPDzJYDbnEabMbsYMAMaRPXpX3akhfhloXqAZ9Hf8XMLiMy6uiQ7OEbgkzZj
         D9Si1h+e/Fo2o/nVqQs+MahDcdgTb4rStC2IYDC4p94WJYUr0wfg/wEeJP1OUPkyOk2+
         Wo2Ik+QRMdNEHd+6CN+cII3gKj5j6azzTznu8qVsdjQ1RERIEXihWF9w9QnnpFTH826T
         l+pZAhD+wprhsM55Amw5K5m4N+1/BNudQBV6Oxu8tfuGjYWgS5rNUr2pomhKjKLIZaX/
         PmdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTZCBPUfMFvAWFyVw1Oh7QFD19cZLxfvEpbwzIpuZZvZbPRepuy847zByakFLH1+nEYlbyxtubmMnoslj88smdV5oFcR75txp6dJVjMPua1GBvxY2sbIkn4GcgESnrTj7xJvooQ80vd99kHepY8udXStSrsGoGnVR6kmMs+4fxtNRvfJ2MKGrEaL7uTo9FPWWHuISZund0eOa8SK6+YDuSSw==
X-Gm-Message-State: AOJu0YzgX5aPXutSkN859xcSvqc84MVcaXH/A5nZnUf4/8WnZBuAftoq
	oCTtEcChH6pGLKsZL5U6ekKoLqsPycOMDXBA4l+/b1HZuHs03BWbbNmFNBJyNcM=
X-Google-Smtp-Source: AGHT+IG3rstfE0sxQj75CLdtkz7tDS/WIIMftEy2NPTiJzeS4j0Vku5utN7c2f5g6t9XbBlzt+Z8DA==
X-Received: by 2002:a05:6820:2c07:b0:5a0:651d:4238 with SMTP id dw7-20020a0568202c0700b005a0651d4238mr5467910oob.2.1708988403399;
        Mon, 26 Feb 2024 15:00:03 -0800 (PST)
Received: from Borg-9.local (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id ej5-20020a0568200d0500b005a06c8ecf54sm1135729oob.25.2024.02.26.15.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 15:00:03 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Mon, 26 Feb 2024 17:00:00 -0600
From: John Groves <John@groves.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, john@jagalactic.com, 
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, 
	dave.hansen@linux.intel.com, gregory.price@memverge.com
Subject: Re: [RFC PATCH 13/20] famfs: Add iomap_ops
Message-ID: <y4gzithu2qurexucsa5kq542pws3qfxf5rtpza6a7qzsb3r2bv@b434hxvv7hv2>
References: <cover.1708709155.git.john@groves.net>
 <2996a7e757c3762a9a28c789645acd289f5f7bc0.1708709155.git.john@groves.net>
 <20240226133038.00006e23@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226133038.00006e23@Huawei.com>

On 24/02/26 01:30PM, Jonathan Cameron wrote:
> On Fri, 23 Feb 2024 11:41:57 -0600
> John Groves <John@Groves.net> wrote:
> 
> > This commit introduces the famfs iomap_ops. When either
> > dax_iomap_fault() or dax_iomap_rw() is called, we get a callback
> > via our iomap_begin() handler. The question being asked is
> > "please resolve (file, offset) to (daxdev, offset)". The function
> > famfs_meta_to_dax_offset() does this.
> > 
> > The per-file metadata is just an extent list to the
> > backing dax dev.  The order of this resolution is O(N) for N
> > extents. Note with the current user space, files usually have
> > only one extent.
> > 
> > Signed-off-by: John Groves <john@groves.net>
> 
> > ---
> >  fs/famfs/famfs_file.c | 245 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 245 insertions(+)
> >  create mode 100644 fs/famfs/famfs_file.c
> > 
> > diff --git a/fs/famfs/famfs_file.c b/fs/famfs/famfs_file.c
> > new file mode 100644
> > index 000000000000..fc667d5f7be8
> > --- /dev/null
> > +++ b/fs/famfs/famfs_file.c
> > @@ -0,0 +1,245 @@
> 
> > +static int
> > +famfs_meta_to_dax_offset(
> > +	struct inode *inode,
> > +	struct iomap *iomap,
> > +	loff_t        offset,
> > +	loff_t        len,
> > +	unsigned int  flags)
> > +{
> > +	struct famfs_file_meta *meta = (struct famfs_file_meta *)inode->i_private;
> 
> i_private is void * so no need for explicit cast (C spec says this is always fine without)

Yessir.

> 
> 
> > +
> > +/**
> > + * famfs_iomap_begin()
> > + *
> > + * This function is pretty simple because files are
> > + * * never partially allocated
> > + * * never have holes (never sparse)
> > + * * never "allocate on write"
> > + */
> > +static int
> > +famfs_iomap_begin(
> > +	struct inode	       *inode,
> > +	loff_t			offset,
> > +	loff_t			length,
> > +	unsigned int		flags,
> > +	struct iomap	       *iomap,
> > +	struct iomap	       *srcmap)
> > +{
> > +	struct famfs_file_meta *meta = inode->i_private;
> > +	size_t size;
> > +	int rc;
> > +
> > +	size = i_size_read(inode);
> > +
> > +	WARN_ON(size != meta->file_size);
> > +
> > +	rc = famfs_meta_to_dax_offset(inode, iomap, offset, length, flags);
> > +
> > +	return rc;
> 	return famfs_meta_...

Done

> 
> > +}
> 
> 
> > +static vm_fault_t
> > +famfs_filemap_map_pages(
> > +	struct vm_fault	       *vmf,
> > +	pgoff_t			start_pgoff,
> > +	pgoff_t			end_pgoff)
> > +{
> > +	vm_fault_t ret;
> > +
> > +	ret = filemap_map_pages(vmf, start_pgoff, end_pgoff);
> > +	return ret;
> 	return filename_map_pages()....

Done, thanks

John


