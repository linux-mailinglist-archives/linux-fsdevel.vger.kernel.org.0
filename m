Return-Path: <linux-fsdevel+bounces-54100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DCFAFB33D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 14:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 009824A25BF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 12:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0A729B22C;
	Mon,  7 Jul 2025 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LShA2euv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C207029AB1D;
	Mon,  7 Jul 2025 12:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751891229; cv=none; b=VkO4WPTkKXKz7j96+5YV6OiPMHZCqq6DeMBZTQLzXHc78ptLjwuzarwt2nW5brFEusaIBs9Z100qtJodyPnIXvNPSP9X9j8KofImPZP2KvAgyME5CnrhSIKLzDOFjbdj/yqNdAUsfXvBGoRpImos3tsUkdMgBda5Ok7m7r3i0OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751891229; c=relaxed/simple;
	bh=SGG3D9WopLeBB75uKMFhOYBdJ0qpwAJZgrfSTmqdzM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZH1KgDvf57XXpyPHvyH/M9wGQzlwZ/0UjzQOj03XOFLjvH0ItCEUm3mK10q5d3xlFU4cvXP3OUQQbW1sqvcJSsm6dFw3las4Yc+U9V+PJfCIvCconboCkzrJUU1tyfHHc49KUDS4OCGyJv0TdG2mQ+5xwXIzO226DnIboCb5+cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LShA2euv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vdT3AgUINABtwE8EihkZZFkgFWExnIToCc9PtsmmP28=; b=LShA2euvaWLp3TUtJvlXH4Hwc3
	ki8zSGrrYpbbC33U7vTxcSB2v4aYx9fsLxdfv0hO1B/XtIeVg/vZEKImqbzEgMt8xEpVIYBNxRJch
	JcPrfBezDUk+O3KyHrljn3gnhWcsZyP7o2vOY2+gzdmVd64pIIaGYt9cCBeE0o9Vr9yylRt4UdzkS
	7e54tjm/iMe2THJjQbAQWGnkaO2H+fTFod3+fh0cLaTV6A5NyQFJncPgujvjc3rN9/Q7g49jjNjSM
	1PnZ8enN3cylXat4ZIEkue08LwLKX4Y0udQqwhETMjTHK5aPm0sPrQxpQw31X9ZP/V5oUovGjOway
	6Bd4M5Fw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYkvv-0000000CzOX-09LD;
	Mon, 07 Jul 2025 12:26:55 +0000
Date: Mon, 7 Jul 2025 13:26:54 +0100
From: Matthew Wilcox <willy@infradead.org>
To: hanqi <hanqi@vivo.com>
Cc: =?utf-8?B?6ZmI5rab5rab?= Taotao Chen <chentaotao@didiglobal.com>,
	"tytso@mit.edu" <tytso@mit.edu>,
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
Message-ID: <aGu9DiKbxpkq2xlx@casper.infradead.org>
References: <20250707070023.206725-5-chentaotao@didiglobal.com>
 <a4cc7c59-2dfd-497e-9f20-b12ea86a1baa@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4cc7c59-2dfd-497e-9f20-b12ea86a1baa@vivo.com>

On Mon, Jul 07, 2025 at 07:48:34PM +0800, hanqi wrote:
> I think it might be worth considering adding an fgf_t parameter to the
> write_begin_get_folio() helper, since in some filesystems the fgp_flags
> passed to __filemap_get_folio() in write_begin are not limited to just
> FGP_WRITEBEGIN. Something like:
> struct folio *write_begin_get_folio(const struct kiocb *iocb,
> 				    struct address_space *mapping,
> 				    pgoff_t index, size_t len,
>                                     fgf_t fgp_flags)

The point is to make the simple cases simple.  Filesystems which need
something more complicated can do it all themselves.  NAK your idea.

