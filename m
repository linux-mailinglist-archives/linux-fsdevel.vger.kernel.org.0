Return-Path: <linux-fsdevel+bounces-20256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C76978D087B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 18:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 666DD1F23FCF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 16:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F2615DBBB;
	Mon, 27 May 2024 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3VrS/btS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA47761FF8;
	Mon, 27 May 2024 16:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716827220; cv=none; b=biE4yqX7O9KgaX2TDk5VZ2UTyVi2ZTuhCvIEHN1yRxHBNVdxgDdmfzspf17tPOqYz3VeFWOVFBNY8DzUEKVYAf3gLvFrO4j1Yd9I/C4y7te/ieUtF5DpxD1swI7DIDyIK2JcIB6UVPtAXQ64+TQCWWLI1RA3n/8UiytEJYMPAW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716827220; c=relaxed/simple;
	bh=N3T0iokdGjgaxTl5DDrZLylVWBk2xIN+ZtHeuYuFZhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBaEIv0Ph9bZCzURcTHZohxwOVfLJXxOn+QAxcXIjuyg5BqvpcmacbMF4YR19NyG5ZXF2xk12y+2HZqayXtwyMfneFkHLQYY0SKNuC2NQq6SEJO3UBpScAWEUDZVLe6eAgCeUBgZYg720Gwcgg+9q4wkpqSMzIQDkTOxMdvcY2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3VrS/btS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tQsO4SaydnXLBPNeL0H4YBhfEOm39hnINjbn0T0Y+1E=; b=3VrS/btS4VXAKufHScBClUyDbt
	6UiEuh5WsFSWvMTK3lEb4Bk3VyxwS1c4a8H4q8PMG3rD16sK+km5vsAoj3U4zw+IxvyEunk7e3daQ
	rPhNq7M0HKz+86LRd5kXabkqmrep19grjTc/dle2MHORmK21xyky7fhXHjjJoY785AnFPv1dcoV/o
	p0UQ6ralUumy523TCseTlKI6Te7vYru8Z+Ru4FR4ZlVXk9LUdch1VPQzgvfvWrVSLIQwWeJis5P7X
	KzRoiUilcJUKFWgKq4ngaH8JiCs4rmfpIhXvArRfdgvwruHLor78WkPm9XCbtYG4CJCPz7b5b1Rgq
	nZeP6Hhg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBdBX-0000000Fqnu-1o9E;
	Mon, 27 May 2024 16:26:55 +0000
Date: Mon, 27 May 2024 09:26:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Hongbo Li <lihongbo22@huawei.com>, viro@zeniv.linux.org.uk,
	jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca,
	lczerner@redhat.com, cmaiolino@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	yi.zhang@huawei.com
Subject: Re: [PATCH v2 2/4] fs: add path parser for filesystem mount option.
Message-ID: <ZlS0Tw96cthn6pNf@infradead.org>
References: <20240527075854.1260981-1-lihongbo22@huawei.com>
 <20240527075854.1260981-3-lihongbo22@huawei.com>
 <20240527-groll-mythisch-8580c32ab296@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527-groll-mythisch-8580c32ab296@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, May 27, 2024 at 04:32:00PM +0200, Christian Brauner wrote:
> That smells like a UAF:
> 
> dfd = open("/bla");
> fsconfig(FSCONFIG_SET_PATH, dfd, "blub", 0);
> close(dfd);
> umount("/bla");
> 
> and that result->ptr now has a dangling pointer which will be triggered by:
> 
> fsconfig(FSCONFIG_CMD_CREATE);

Yeah.  Also the whole path thing is entirely unused.  The best thing
to do about it is to remove it, we can always resurrect if if/when we
actually need it.


