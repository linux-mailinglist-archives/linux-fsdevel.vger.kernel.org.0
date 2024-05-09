Return-Path: <linux-fsdevel+bounces-19172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B686F8C0FE4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 14:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DC34B22FBB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 12:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A971514F4;
	Thu,  9 May 2024 12:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jDbif7ib"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5CC1FAA;
	Thu,  9 May 2024 12:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715258824; cv=none; b=ulUqkKpyNFtrE8t0E4bH/hgzmWyOTaRcPj1I9330Hg6htVewScNVT9/vCrcER4HcjgpdRAMHj6b5JYAjZbztrb/mGB3aSfXwGyv6maNb74Cxm3AliKEnWOv30WX27OJaK+DHMNymEuuOzjv5Q2ID2Lp4z+RF3syRhczYilGpYQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715258824; c=relaxed/simple;
	bh=t0jf/H6HfGlWtNMItNNrhOCxHvelcDY5aghbar+0Dv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uC9/EVS+25ZtA9zZgZg65xp4UaQ0vkA00cHpJh8JNJEmx9Z82XwATS2DPpbXZCN1qI6JK3qJbqw8qjNl+w3PbjE3+qqW7/OQNFgVT+ywNtRnY7K7Bz5zw8HfEqY5MX0+YVRM7NgCfdCkbpgP3Vaz5yZV2z2uRJtGLsMFE+lLOq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jDbif7ib; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N2ymIQ4SsJGpIWSTK0c3WPAw6ggOxtbl/S0hlzGrq8E=; b=jDbif7ibDbh5aLoH4hTssJX4rL
	qhd2lu2gCkirS1lT+kNSrVuNhnHEtxAl7cYimVQs/+shVV3dnIKSWPpI5WZ2SX+kN9mKNeh6Of6c8
	ZutFJ8uyS1Xh/JGHtDQJLoZ0+nAav598JCmxorINaWdpGcAMoMnnpv19TY0+Ksa3HGhujefpH2wqW
	Dp3cXY1XvOfA/e33L7CieFhhr/HGalWwAb/nJ2JKhoLfnHhxPGttFSJxf7KFJ1wtaj72SKzIfHus/
	XjKoTkmzmL5bFWviJtXAjNNip7zD6cOyK4+UdOjS7uC47EmRSQLa2maK+dLRaDFHf7qzRYhFaCoIL
	im5iyCcQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s53Al-00000001TaS-1N6z;
	Thu, 09 May 2024 12:46:55 +0000
Date: Thu, 9 May 2024 05:46:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Christoph Hellwig <hch@infradead.org>, hch@lst.de, willy@infradead.org,
	mcgrof@kernel.org, akpm@linux-foundation.org, brauner@kernel.org,
	chandan.babu@oracle.com, david@fromorbit.com, djwong@kernel.org,
	gost.dev@samsung.com, hare@suse.de, john.g.garry@oracle.com,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	ritesh.list@gmail.com, ziy@nvidia.com
Subject: Re: [RFC] iomap: use huge zero folio in iomap_dio_zero
Message-ID: <ZjzFv7cKJcwDRbjQ@infradead.org>
References: <20240503095353.3798063-8-mcgrof@kernel.org>
 <20240507145811.52987-1-kernel@pankajraghav.com>
 <ZjpSx7SBvzQI4oRV@infradead.org>
 <20240508113949.pwyeavrc2rrwsxw2@quentin>
 <Zjtlep7rySFJFcik@infradead.org>
 <20240509123107.hhi3lzjcn5svejvk@quentin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509123107.hhi3lzjcn5svejvk@quentin>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, May 09, 2024 at 12:31:07PM +0000, Pankaj Raghav (Samsung) wrote:
> > Well, that's why I suggest doing it at mount time.  Asking for it deep
> > down in the write code is certainly going to be a bit problematic.
> 
> Makes sense. But failing to mount because we can't get a huge zero folio
> seems wrong as we still can't guarantee it even at mount time.
> 
> With the current infrastructure I don't see anyway of geting a huge zero
> folio that is guaranteed so that we don't need any fallback.

You export get_huge_zero_page, put_huge_zero_page (they might need a
rename and kerneldoc for the final version) and huge_zero_folio or a
wrapper to get it, and then call get_huge_zero_page from mount,
from unmount and just use huge_zero_folio which is guaranteed to
exist once get_huge_zero_page succeeded.


