Return-Path: <linux-fsdevel+bounces-12896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C0986847B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 00:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDB321F22D84
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 23:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5710A135A51;
	Mon, 26 Feb 2024 23:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uv3CONTJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3501A1350C7;
	Mon, 26 Feb 2024 23:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708988981; cv=none; b=gqPJJeYaG6rKrhvOsDSqBrI9EAhmXLFsOM2t42MJu8HQnHFBzRHn2vTZ4MmBv5amz6aYsQSaCEj8xB668tcPvppOA3GZ3h+2KEKFYU1YPaHFuTb1jW0YXrOzYyGA+nxRkRxmS8I4kOn3zhY92CGI8wJLfXcQB22yR2lsa5ytB+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708988981; c=relaxed/simple;
	bh=uYkkN/FdFgankiteLx48VCnumQrJ/b0UgjIilRQi83E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cp9SIirN0jw/Gve48XnHjAZ0kv/nbb1FB2O2iZeVQDbgPjmYc5ZXlwpkG4bn9aWi0Wa0PrFjyQxFq02xTItk7BGHutulcN1IJiXHwvB3YZt7oJ3s+nyC9ktE06OQQptKJ1PrMljL3Qbj5+lNi+jOTK/QIsX+9Sv8n61B/HMaCFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uv3CONTJ; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bba50cd318so2710174b6e.0;
        Mon, 26 Feb 2024 15:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708988978; x=1709593778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hsNP5EK+LFjyhVcocZelct19finr3VBZ9CwQlQrhIjw=;
        b=Uv3CONTJdx62rIj/pxGVvHfUF2uIwgW6WwyTcV+xIY0di440BUw3mMDuXFacFmsqY3
         i+YdjgyIq/VEHBIidnTixP2n703rFlfq/ZNmfPiAH2H5IvSP2W9PH70xvz6mppSAoHqK
         4dkAs6FZpa6hHp6LW9Y6pBmvoIoWmf0bU9aIaMGND1VVbaHjv4AmE8MH9PviiEYWWlDs
         yEBIxwG3dMCbSHf9Gf+wg/AV2fKg9F41PhJVVym2j0Ry5ayo5FaKj6vYpv9uPEml8/ek
         5+oRTfmBEKcACdLyjVfzHHcQyMvY6fUCewCbkpbziV0F1WPTAeg76KtMh4D4Q18Lw/7Z
         netA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708988978; x=1709593778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsNP5EK+LFjyhVcocZelct19finr3VBZ9CwQlQrhIjw=;
        b=Td7tbHBx+UaUt1CvKE/3xlLkKPPRWPJNtoXzrXQ1vd9DChYGVrCYf0UJd8AdkhYhy4
         4ETiucvgIkGyasUXKkU8zW0QUVofeAwxVYRBVh/epZ/s6JwZEdM/K2fXO+xix5kH46F+
         VgQXCpofxTMhMbRxihhjDdDhU3b4/D7V29IfVQH9MNt3xnxKYfcXA5pNimKCx0rxVoBi
         6N007MFI6g4cFoF7KOgU50ZiLBnC4LPVVjM3HqBHtKsr9gi0JqB2M8wl9Esn/zp09a9O
         ZeVCfj7A0ynogmZbevwAXFHU4oAgFiP2+wdeXWZbdh4aav7d2rIOE4/nb6ymN0KH2uBa
         uvIw==
X-Forwarded-Encrypted: i=1; AJvYcCXXnt64gDv9ALbQcSMjmq+Bc6W9lU/UfLYT5J7Z0CoGcFn04yVfN/Tq2e+ceZhUfOtDg+JLNyGrZ7RwkC83GoISTkkrlVf6oL8Kot/ZsS9KYSKBloWnOTYEzg5s7nhFPuTMRdlKMjFeEnx/2EMSaj2e6aYWJXQLXuESi6ql5PSv4E3WKON89v06U/aJgspCZpscgQRoc8BQ8LmCQlIQGX8F2g==
X-Gm-Message-State: AOJu0YxzY7pgVNfCNSzNrWUtIFa5M6UaXenABRCNMirKCsEp1GnluIDy
	Z/8yInX4X4PAfv1/HQeE8c/1K5e019ioOG/R0HwEh3xdOgUyyJPdl5I9ZtShCHY=
X-Google-Smtp-Source: AGHT+IEmmB2wgYc/dKohpH8hAGiid/eaRbwOHLzXdUGFfNAOSSLSS1QubvTxHY/CInTKJw0aVBdejg==
X-Received: by 2002:a05:6808:3021:b0:3c1:8493:751f with SMTP id ay33-20020a056808302100b003c18493751fmr552923oib.9.1708988978297;
        Mon, 26 Feb 2024 15:09:38 -0800 (PST)
Received: from Borg-9.local (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id 3-20020a544183000000b003c17fd0ed2bsm1216111oiy.47.2024.02.26.15.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 15:09:38 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Mon, 26 Feb 2024 17:09:36 -0600
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
Subject: Re: [RFC PATCH 14/20] famfs: Add struct file_operations
Message-ID: <ulweov27unhr4q6x6oad7vpmemi4ivl5ztls7gish7c7a52t3e@peoqzqt6pk4l>
References: <cover.1708709155.git.john@groves.net>
 <3f19cd8daab0dc3c4d0381019ce61cd106970097.1708709155.git.john@groves.net>
 <20240226133237.0000593c@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226133237.0000593c@Huawei.com>

On 24/02/26 01:32PM, Jonathan Cameron wrote:
> On Fri, 23 Feb 2024 11:41:58 -0600
> John Groves <John@Groves.net> wrote:
> 
> > This commit introduces the famfs file_operations. We call
> > thp_get_unmapped_area() to force PMD page alignment. Our read and
> > write handlers (famfs_dax_read_iter() and famfs_dax_write_iter())
> > call dax_iomap_rw() to do the work.
> > 
> > famfs_file_invalid() checks for various ways a famfs file can be
> > in an invalid state so we can fail I/O or fault resolution in those
> > cases. Those cases include the following:
> > 
> > * No famfs metadata
> > * file i_size does not match the originally allocated size
> > * file is not flagged as DAX
> > * errors were detected previously on the file
> > 
> > An invalid file can often be fixed by replaying the log, or by
> > umount/mount/log replay - all of which are user space operations.
> > 
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  fs/famfs/famfs_file.c | 136 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 136 insertions(+)
> > 
> > diff --git a/fs/famfs/famfs_file.c b/fs/famfs/famfs_file.c
> > index fc667d5f7be8..5228e9de1e3b 100644
> > --- a/fs/famfs/famfs_file.c
> > +++ b/fs/famfs/famfs_file.c
> > @@ -19,6 +19,142 @@
> >  #include <uapi/linux/famfs_ioctl.h>
> >  #include "famfs_internal.h"
> >  
> > +/*********************************************************************
> > + * file_operations
> > + */
> > +
> > +/* Reject I/O to files that aren't in a valid state */
> > +static ssize_t
> > +famfs_file_invalid(struct inode *inode)
> > +{
> > +	size_t i_size       = i_size_read(inode);
> > +	struct famfs_file_meta *meta = inode->i_private;
> > +
> > +	if (!meta) {
> > +		pr_err("%s: un-initialized famfs file\n", __func__);
> > +		return -EIO;
> > +	}
> > +	if (i_size != meta->file_size) {
> > +		pr_err("%s: something changed the size from  %ld to %ld\n",
> > +		       __func__, meta->file_size, i_size);
> > +		meta->error = 1;
> > +		return -ENXIO;
> > +	}
> > +	if (!IS_DAX(inode)) {
> > +		pr_err("%s: inode %llx IS_DAX is false\n", __func__, (u64)inode);
> > +		meta->error = 1;
> > +		return -ENXIO;
> > +	}
> > +	if (meta->error) {
> > +		pr_err("%s: previously detected metadata errors\n", __func__);
> > +		meta->error = 1;
> 
> Already set?  If treating it as only a boolean, maybe make it one?

Done, thanks

John


