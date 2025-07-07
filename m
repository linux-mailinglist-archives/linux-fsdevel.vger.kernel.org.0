Return-Path: <linux-fsdevel+bounces-54135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84252AFB68B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 16:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DECF4177D22
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 14:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B672E173F;
	Mon,  7 Jul 2025 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dzLlM0hU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFBB190472;
	Mon,  7 Jul 2025 14:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751900091; cv=none; b=CM/wnHjnDzdobUbsmgnLi2LxryMwSL5VcHgPdcKUxb1cXBlYTpJ1iqwyqeXfBWf4/flPTrSgXKWm4fFkkijwZXMNuq/+atTP5RCJXwWJ+3bEoZ9g90HI3GS+JrU46QNpCV1Q65+EKbnizSxVLU9hQGRCG6y12Yjpz7Sh+DMSWH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751900091; c=relaxed/simple;
	bh=Uw+QK7zVpDDDWj8PBAhmbUc8RHcgipi1naREnBRErGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mj+mQxowELancgk1br3eaIRFcuUD8QwBPBgpwf34o0m4wJJnbWnMy2WcSNvajHYUp1pZLk/V+Uwt9q+U0NPIMmAuDun9KQW6LIU8nxaVxtujrxUV/viOJ2YtjGKO3SDWTDyMFb27dXxRfjbkmbj0GbKY8In/oTcvsTopj0SiT4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dzLlM0hU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=o/+i29+EsaHRjTzivT96VVcgGobCX8dLFJXYN29x5S0=; b=dzLlM0hUZ6iClIBOvZOKXBqq2C
	E+u6WgXHMDatqhaFYT9DdBAsUvrJjBRgmCufxUccg7Ddlr8RI5+RqFOfxeQ7SULeoE/ttv6qtPi79
	PMnphhz4vZu/BGyg9DF5KbWGTH5EFGB1GWGJ1qTRCdDkIqXo59u6NRG4KLeO/Mv626pnjHXYNpCuo
	LLPCNwfiLl6JUdeas3gqP5it3rgyFRu2il+fOheOCmaYOeq8YegBZDuKgqUVYw6KyC+VekTOg+AAV
	luqptV/g6COpriR6jZHeFGHPBY7hwh0/fSQBHyR81gGP6XUixw0hd63szAfYMVfU4PY0+xQTTrFeQ
	aBx8DwuQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYnEu-0000000DVBX-0MLk;
	Mon, 07 Jul 2025 14:54:40 +0000
Date: Mon, 7 Jul 2025 15:54:39 +0100
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
Subject: Re: [PATCH v4 4/5] mm/filemap: add write_begin_get_folio() helper
 function
Message-ID: <aGvfr_rLUAHaUQkY@casper.infradead.org>
References: <20250707070023.206725-1-chentaotao@didiglobal.com>
 <20250707070023.206725-5-chentaotao@didiglobal.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250707070023.206725-5-chentaotao@didiglobal.com>

On Mon, Jul 07, 2025 at 07:00:33AM +0000, 陈涛涛 Taotao Chen wrote:
> +++ b/mm/filemap.c

I think this should be a static inline function.  I don't think it's
worth moving out of line.  Of course if you have measurements that show
differently, you can change my mind.

> +/**
> + * write_begin_get_folio - Get folio for write_begin with flags
> + * @iocb: kiocb passed from write_begin (may be NULL)
> + * @mapping: the address space to search in
> + * @index: page cache index
> + * @len: length of data being written
> + *
> + * This is a helper for filesystem write_begin() implementations.
> + * It wraps __filemap_get_folio(), setting appropriate flags in
> + * the write begin context.
> + *
> + * Returns a folio or an ERR_PTR.

We prefer:

 * Return: A folio or an ERR_PTR

as this gets its own section in the kernel-doc output.


