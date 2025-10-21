Return-Path: <linux-fsdevel+bounces-64829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B65FBF5196
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 09:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8BB188FE5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 07:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65E730215B;
	Tue, 21 Oct 2025 07:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OW3j3cpZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26172BE036;
	Tue, 21 Oct 2025 07:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032993; cv=none; b=ZOza9vDE1U9w03EQle4bRQl2QYgJmvFkdVGXBQZZA+Y0b4sxaXRSLm4Wo0N4v3f+ZqlzceHVTom4ceQRqwUk+VuS8RNeEKIyaSnSRICytJGWfF9lQwPdGE6Zw/sA1ytXNX4kJi6Nu6nlHwHtaDMteY9qRzzAP7ydUBaFDKxJJok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032993; c=relaxed/simple;
	bh=PWEzCwcpnN90kQeqxT2BhJgAZAVWaFLnxqJzbbWcZvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ib0Glg6kIyHvmFSTZv0CyO08egrKZn/dJfmc7vTnpWrzEow8FCsN7s3RIF2fldYz/JMnFkB/0zK3ZH8KZm0e33jmx+RIh9RGHr82mtESlLXeF6cVP/57cT0mJpYy31EQB3BeuTbGzRhFBq/790UpaxvMNuFMSG+COs7I8K/XFFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OW3j3cpZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X1AmHMZPbGfEo4D99A/2+yXenwXAflQA3dgEjfBmhjE=; b=OW3j3cpZD7DfoFDCZc8YBGCHTV
	Gq2dCWXiw0YgkWz2d3KTGPIHB2riACl8SwC/9E8acFS+o87US7hYHRnNvHi8P3isvf6E7EdjhZ12S
	uUxr2G7dYbyXEzHhGi6xTEvanmO6U7JcqtlHB93XzB1musPKxmhGI9V07bNQYdGnX0g6rMwL/8L0a
	cIZMk2dZ3lrYsgyZsh3JRmv1VL1JCmcOjCdeiOIsT8BS7/aVFiPF0C45ECw+Lfj9Y1G8pWFzrD72t
	qOqKJAjdwLizVgLuTU3p3wF9mQKsHG9fjhkwp5r0XOhzc/sCvqgeaIb7NUK0CNGKiKkWw2GhZ/BnX
	s57SBmXA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vB77t-0000000G9z4-184H;
	Tue, 21 Oct 2025 07:49:49 +0000
Date: Tue, 21 Oct 2025 00:49:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, djwong@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	martin.petersen@oracle.com, jack@suse.com
Subject: Re: O_DIRECT vs BLK_FEAT_STABLE_WRITES, was Re: [PATCH] btrfs: never
 trust the bio from direct IO
Message-ID: <aPc7HVRJYXA1hT8h@infradead.org>
References: <1ee861df6fbd8bf45ab42154f429a31819294352.1760951886.git.wqu@suse.com>
 <aPYIS5rDfXhNNDHP@infradead.org>
 <56o3re2wspflt32t6mrfg66dec4hneuixheroax2lmo2ilcgay@zehhm5yaupav>
 <aPYgm3ey4eiFB4_o@infradead.org>
 <mciqzktudhier5d2wvjmh4odwqdszvbtcixbthiuuwrufrw3cj@5s2ffnffu4gc>
 <aPZOO3dFv61blHBz@casper.infradead.org>
 <xc2orfhavfqaxrmxtsbf4kepglfujjodvhfzhzfawwaxlyrhlb@gammchkzoh2m>
 <5bd1d360-bee0-4fa2-80c8-476519e98b00@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bd1d360-bee0-4fa2-80c8-476519e98b00@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 20, 2025 at 09:00:50PM +0200, David Hildenbrand wrote:
> Just FYI, because it might be interesting in this context.
> 
> For anonymous memory we have this working by only writing the folio out if
> it is completely unmapped and there are no unexpected folio references/pins
> (see pageout()), and only allowing to write to such a folio ("reuse") if
> SWP_STABLE_WRITES is not set (see do_swap_page()).
> 
> So once we start writeback the folio has no writable page table mappings
> (unmapped) and no GUP pins. Consequently, when trying to write to it we can
> just fallback to creating a page copy without causing trouble with GUP pins.

Yeah.  But anonymous is the easy case, the pain is direct I/O to file
mappings.  Mapping the right answer is to just fail pinning them and fall 
back to (dontcache) buffered I/O.


