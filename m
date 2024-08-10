Return-Path: <linux-fsdevel+bounces-25597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F29B594DD73
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 17:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B8B21C20CC1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 15:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFCD1607B9;
	Sat, 10 Aug 2024 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CNJ87e1W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E54222F19;
	Sat, 10 Aug 2024 15:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723302776; cv=none; b=ndyIlL/hX6p1V5xodbdlrfzyl/GrRIbIOxNosUVViu0vixJs4tqw7+CfZ4GiVKgk6qd4t4vf9Lk5rsyO0vUCZ0aP4AkdzPIf7Gp7SNV4ouS968yO2tCzFEVSe7IjB9EtFa2zFosHvXXI0+1naYN/ITeZOqQbwrUn5qoTffRdXNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723302776; c=relaxed/simple;
	bh=+FqUvjivvNo6/mXFykJw3XBMSX5eA5160Foe6mSNeKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGxAP4KQkWNGBblRsdcEFYaksgp20TaHnGUMy1JPvWbSgEaIv5xIaSGZIKH/xFOFVapkGD64WtaP/BfHl2YdbFg9U8JsQItN6yWWofa00TSQMWAjC+Yxp3ZLjcXhW5XekMpRnLlCvTFu5Ix1W3Ep19nZOcPavJYkDeIo73fP2yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CNJ87e1W; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Gin6srKZjfK6glpZLgdRH/ndfMIF95CcZlc4NF2uisw=; b=CNJ87e1We/H5rXvp+7o3K+o7U6
	suZ4qD3VwRcC/BfbpKw0nEQEV1hnbEjDK8JVJHmjHl9Cdq7CswxrU4Jz3pC2K6BZIY3OEf0fwfGaE
	MNYVqEsvK23a28B9+nNlSeZzwiIHXhPfaGWMkIgv9wBXHALnYlSmNEswJgDa8kYm9PktnrkpsYgzm
	92d4eC404exFFZI92a7iombrY/DsabaRPJvg4ctHQe+Giq3YwctHuPnQIesbCLZohSokCruSh/ueq
	DqxoPhoysl+rdtG+PZC/az3XmmDSO2i3c8hWYJ7oRPSQ4LlwvVgjjOaUbok+MYdv0lE4G1oAx4TYy
	6/YGF55A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scnlz-0000000CMAB-1BVP;
	Sat, 10 Aug 2024 15:12:51 +0000
Date: Sat, 10 Aug 2024 16:12:50 +0100
From: Matthew Wilcox <willy@infradead.org>
To: =?iso-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] fuse: copy_file_range() fails with EIO
Message-ID: <ZreDcghI8t_1iXzQ@casper.infradead.org>
References: <792a3f54b1d528c2b056ae3c4ebaefe46bca8ef9.camel@bitron.ch>
 <ZrY97Pq9xM-fFhU2@casper.infradead.org>
 <5b54cb7e5bfdd5439c3a431d4f86ad20c9b22e76.camel@bitron.ch>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b54cb7e5bfdd5439c3a431d4f86ad20c9b22e76.camel@bitron.ch>

On Sat, Aug 10, 2024 at 07:56:21AM +0200, Jürg Billeter wrote:
> Thanks for the quick response.

Thanks for the quick test!

> On Fri, 2024-08-09 at 17:03 +0100, Matthew Wilcox wrote:
> > Do you have CONFIG_DEBUG_VM enabled?  There are some debugging asserts
> > which that will enable that might indicate a problem.
> 
> With CONFIG_DEBUG_VM enabled, I get:
> 
> page: refcount:2 mapcount:0 mapping:00000000b2c30835 index:0x0 pfn:0x12a113
> memcg:ffff9d8e3a660800
> aops:0xffffffff8a056820 ino:21 dentry name:"bash"
> flags: 0x24000000000022d(locked|referenced|uptodate|lru|workingset|node=0|zone=2)
> raw: 024000000000022d ffffd9ce04a827c8 ffffd9ce04a84508 ffff9d8e0bbc99f0
> raw: 0000000000000000 0000000000000000 00000002ffffffff ffff9d8e3a660800
> page dumped because: VM_BUG_ON_FOLIO(folio_test_uptodate(folio))

That's what I suspected was going wrong -- we're trying to end a read on
a folio that is already uptodate.  Miklos, what the hell is FUSE doing
here?

