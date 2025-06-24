Return-Path: <linux-fsdevel+bounces-52760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C32AAE64D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 14:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2391188EF8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 12:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C952989BC;
	Tue, 24 Jun 2025 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S2Um+0qp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A1128E576;
	Tue, 24 Jun 2025 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767801; cv=none; b=SFaM6/ngsZymr3XbBeavarUuElhOOXRk7SclOvTSf2SaL2snqBsVFQxgiSq8IoMUxD1FyjtVIQPb4qpT7lY7lFs+rPrtIB4J//4lsXDmcreCj9EQ5J5v8yK9yonnDNEthYzJZbgRRFdmHm9UA59dtsGSuu0EPpVFxNszlO72iA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767801; c=relaxed/simple;
	bh=k7CB2mm5XvGp1gKkpn4RX3zrwfN8DJKxj80du2EqrtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AS/fCA9cCGXm9n3tE78symqfcJg5b9QQArleStpn20pyLbL0Ijciqp7sZ1DAkitZOK//O0V9DJKazgDC7PFqaEDXLTEbwL4E7Q5u9ct37LGJ8p+SJ65fNE0AT/MWP5VuWEqtkHi2lWWJlZJFaGA3sRHP2IyIQEvTB0WQ34+o25s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S2Um+0qp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=u2DmQaokTW2/gnjH2cgnlfjmMToaryjzjXcqnXsp80s=; b=S2Um+0qpagjVrhSQsPtu/Y9Ki/
	qT4VCiz5D6Hf7xDHltAe+KRt7fHQLqHv0UCpc9w1zthcz8KjmNZ2CVeMcpCwT/TJqEXysR8c9CwDu
	vqzHC65Fq240pfKWV3nGQhGhzdCTpTIGbZvyf/Z0ZGRBRPGNbX1WRxPt034gUSlPqPHkBj9DzWuNS
	BaFAqEYcflqmFmayixuy5iaOWNh4p7Tih0ACK126a0Z16IkyVDVQOtz91tRsBCpCpTvEzylIiHonW
	zakG4Ry8rOhUB7dD3NNe9m2JxYVEHbBSgzM+IbcRxItxFOPiXEyubfjCK2Ty3Fxr3Hi91Y7XGbXMY
	Jyayik5A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU2g7-00000006YWM-2gs3;
	Tue, 24 Jun 2025 12:23:07 +0000
Date: Tue, 24 Jun 2025 13:23:07 +0100
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
	"chentao325@qq.com" <chentao325@qq.com>
Subject: Re: [PATCH v2 1/5] drm/i915: Use kernel_write() in shmem object
 create
Message-ID: <aFqYq-tLtjZjU0Ko@casper.infradead.org>
References: <20250624121149.2927-1-chentaotao@didiglobal.com>
 <20250624121149.2927-2-chentaotao@didiglobal.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250624121149.2927-2-chentaotao@didiglobal.com>

On Tue, Jun 24, 2025 at 12:12:04PM +0000, 陈涛涛 Taotao Chen wrote:
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -637,8 +637,7 @@ i915_gem_object_create_shmem_from_data(struct drm_i915_private *i915,
>  {
>  	struct drm_i915_gem_object *obj;
>  	struct file *file;
> -	const struct address_space_operations *aops;
> -	loff_t pos;
> +	loff_t pos = 0;
>  	int err;

I think 'err' needs to become ssize_t to avoid writes larger than 2GB
from being misinterpreted as errors.


