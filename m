Return-Path: <linux-fsdevel+bounces-20399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4894A8D2C54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 07:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4131F247B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 05:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB9A15B986;
	Wed, 29 May 2024 05:21:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A18C13A412;
	Wed, 29 May 2024 05:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960079; cv=none; b=h8zHlsBZ9Bkha9i+uk5QEUWyPc04v09BDZMFf2RWMkU5V5Bcl0ppYqhC5nXOooSb0wU8j2EBuh4wqGiKA0A1r6tgN1Ns6N7bzzjcZu7RK1V/zmQwHBXUdvKLkG+uUFczoUv/a8NSD4MI/TDhOB+9uEyq+Vf2YsSGO5rZMn+oiOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960079; c=relaxed/simple;
	bh=8fNwj5Xd7Lscbex+dXasTvy/V4LM/jP9gdlh+d6jw3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYzA5tey6MhYgfh48sbut+ewn1XspKD3MBr1SjTKPqUvLOrll9XU+C4WtQHagKlgymds0ZOSaJ8fJeaH3Rk3Ug+ZoxJiLO9OkVxpNcHnf8pHH7AtaXihEKNU330NDfCAjlpFD/fNBSJvb8AZiQjNDkW7W4ck4uJM3GzGRIo5CH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 82B8868AFE; Wed, 29 May 2024 07:21:14 +0200 (CEST)
Date: Wed, 29 May 2024 07:21:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/7] fs: Introduce buffered_write_operations
Message-ID: <20240529052114.GB15312@lst.de>
References: <20240528164829.2105447-1-willy@infradead.org> <20240528164829.2105447-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528164829.2105447-2-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, May 28, 2024 at 05:48:22PM +0100, Matthew Wilcox (Oracle) wrote:
> Start the process of moving write_begin and write_end out from the
> address_space_operations to their own struct.
> 
> The new write_begin returns the folio or an ERR_PTR instead of returning
> the folio by reference.  It also accepts len as a size_t and (as
> documented) the len may be larger than PAGE_SIZE.
> 
> Pass an optional buffered_write_operations pointer to various functions
> in filemap.c.  The old names are available as macros for now, except
> for generic_file_write_iter() which is used as a function pointer by
> many filesystems.  If using the new functions, the filesystem can have
> per-operation fsdata instead of per-page fsdata.

The model looks good, but buffered_write_operations sounds a little
too generic for a helper that hopefully won't have too many users in
the end.


