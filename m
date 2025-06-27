Return-Path: <linux-fsdevel+bounces-53206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0336DAEBE0F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 19:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0575817E72D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 17:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5501A2EAB80;
	Fri, 27 Jun 2025 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lLKFhWE7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7292EA162;
	Fri, 27 Jun 2025 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751043801; cv=none; b=NeqikWzcwaAqID9vqqUSCMRl7hPYdJID+S+8F+fTJHY5/vXJ/AxdxBMhle2uMcTtWIUbNNIxnlKTUVEpeP3rQwSmPsIbg+tDp6UjIq+LRCZYQem1wzZOac9IKSBretYgLdt97LvVAgcgyi/9YQefIrCTqxTFVrokp2ixzVSkHJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751043801; c=relaxed/simple;
	bh=6iU4sKtqulwtJbHdtTjfBW2WtHCU3a8mQLkMyO716dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAj1DxKr/1aSg59b6nOevskiOwY1cu23NU98E51YUyvIaKZgR619ChKkPRPzefBUi/4rNWo05ZhUO9kuvJDPwiB7QDxFXMsStTBCjl6giP/E4Bui+Cw3GdHXXmTbQQfeA1rLFFMHi6cQaym583rk7tF1DO8VrKSbZlG8Ldg/Gxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lLKFhWE7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=BX8yP699mQd1hqQWYrl2/cTWYSKTaQhOnRx2XR4O0nI=; b=lLKFhWE7lu96o6X4WT3tH4Sf1O
	oFn+aopDUWdGLcdZZzN4QfYf4S6XDwKRYHArQn5ap3m58Et87mT4Ayt6ydcfEgKSJk9PEFzYHQGW/
	JMPMcvwErhnhXiakaH6uPHmYcq+T3F3YwECBJHYqoUiNPo9ymCBd1Ib/d9+WGAmCO0GI/fl3FtOmv
	+toLcyd8ZL6SW5pWju0H9RRNwMPb2ngciRiSRQuHslvf32Vy10QFJC1mkVGwPE+K86H2nT+LgoeKL
	1nQzjkHMiGrUvnzfn32qPmJoVD+pIIBdxrgVJB1unlnK8fQDHJ9XR/SU0LsqA909wugZbwr1k3AbM
	5BCG5tNw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVCTl-0000000EZN4-26cY;
	Fri, 27 Jun 2025 17:03:09 +0000
Date: Fri, 27 Jun 2025 18:03:09 +0100
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
Subject: Re: [PATCH v3 4/4] ext4: support uncached buffered I/O
Message-ID: <aF7OzbVwXqbJaLQA@casper.infradead.org>
References: <20250627110257.1870826-1-chentaotao@didiglobal.com>
 <20250627110257.1870826-5-chentaotao@didiglobal.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250627110257.1870826-5-chentaotao@didiglobal.com>

On Fri, Jun 27, 2025 at 11:03:13AM +0000, 陈涛涛 Taotao Chen wrote:
> +++ b/fs/ext4/inode.c
> @@ -1270,6 +1270,9 @@ static int ext4_write_begin(const struct kiocb *iocb,
>  	if (unlikely(ret))
>  		return ret;
>  
> +	if (iocb->ki_flags & IOCB_DONTCACHE)
> +		fgp |= FGP_DONTCACHE;

I think this needs to be:

	if (iocb && iocb->ki_flags & IOCB_DONTCACHE)

because it's legit to call write_begin with a NULL argument.  The
'file' was always an optional argument, and we should preserve that
optionality with this transformation.

I wonder if it's worth abstracting some of this boilerplate.  Something
like:

struct folio *write_begin_get_folio(iocb, mapping, index, len)
{
	fgf_t fgflags = FGP_WRITEBEGIN;

	if (iocb && iocb->ki_flags & IOCB_DONTCACHE)
		fgflags |= FGP_DONTCACHE;
	fgflags |= fgf_set_order(len);

	return __filemap_get_folio(mapping, index, fgflags,
			mapping_gfp_mask(mapping));
}


