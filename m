Return-Path: <linux-fsdevel+bounces-43828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D42A5E30A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 18:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1A7E7A56E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 17:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EFF2566CE;
	Wed, 12 Mar 2025 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIhQX92l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98476253359
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 17:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741801634; cv=none; b=TG9cWoGMioO7IbvBpXNAmOpH3sOh0FXyRv1we7nB5QYAY12QTvSMW1idrkgI5/OnWYjqMR1DNLnaKMJNvJp+4cDjt0oZ78tHFAXa9nvpxawv0eWUxlHtO7UhItzQFuvp7/JlGf2/99IIs/rNcEPPbevCeSx05xOMGe9qMPxpCLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741801634; c=relaxed/simple;
	bh=dyQcXzKhNCuzYrP5t3xdHaTAtWHFSj7lhXVElLuyq08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpVq/KXc9ZGtFEt8En63SS/MieYsBuV1qABT2bZ68c+Q1hSHECYz4xfKM+PnN+aF49xfl4Ez2NkuUTAs9RqKvwWOi2ldShohxGytRiDVklbQLmCV7N7WMo9uTwPDZS9o5IMzpPkVla3X4Nj/HQzKYSCaq5aSo4kxZYFtWR33BFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIhQX92l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43E7C4CEDD;
	Wed, 12 Mar 2025 17:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741801634;
	bh=dyQcXzKhNCuzYrP5t3xdHaTAtWHFSj7lhXVElLuyq08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eIhQX92ldMD1DiD9hvhTlDOAfP1z3ceftUkdDNY92+xIm2rCU9/pT7K1YiDex5Rqh
	 1PCoOGobb7H1G2avYv2gFlj9VH6Rq4/0c/95SSXIrnNJ8SK3n3jL66+ob8jz6QQ8XZ
	 DQEYMLiBFiOEqB+athBddQoVgUYnUbyxy/kVC2SmUs61HfS8v4J0a/QkV/2EKbZAfW
	 1Q0TANgsCpJq6QGzdSsT0i6xPBSUzs+tZ7RV2DE2yK2EjIWV8+84EHPLFHvpeU+4ca
	 XL3YQ0Bkl1T7IHHujVX9sdSx1NJrhLxjoVWv3XeyWxa1zgyYhyuTcsRP+kKFd8b2Oc
	 PjJ3RUvlUboJg==
Date: Wed, 12 Mar 2025 10:47:12 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Dave Chinner <david@fromorbit.com>, David Bueso <dave@stgolabs.net>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Kundan Kumar <kundan.kumar@samsung.com>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	anuj20.g@samsung.com, joshi.k@samsung.com, axboe@kernel.dk,
	clm@meta.com, willy@infradead.org, gost.dev@samsung.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Parallelizing filesystem writeback
Message-ID: <Z9HIoJZmuVsyXdh9@bombadil.infradead.org>
References: <CGME20250129103448epcas5p1f7d71506e4443429a0b0002eb842e749@epcas5p1.samsung.com>
 <20250129102627.161448-1-kundan.kumar@samsung.com>
 <Z5qw_1BOqiFum5Dn@dread.disaster.area>
 <20250131093209.6luwm4ny5kj34jqc@green245>
 <Z6GAYFN3foyBlUxK@dread.disaster.area>
 <20250204050642.GF28103@lst.de>
 <s43qlmnbtjbpc5vn75gokti3au7qhvgx6qj7qrecmkd2dgrdfv@no2i7qifnvvk>
 <Z6qkLjSj1K047yPt@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6qkLjSj1K047yPt@dread.disaster.area>

On Tue, Feb 11, 2025 at 12:13:18PM +1100, Dave Chinner wrote:
> Should we be looking towards using a subset of the existing list_lru
> functionality for writeback contexts here? i.e. create a list_lru
> object with N-way scalability, allow the fs to provide an
> inode-number-to-list mapping function, and use the list_lru
> interfaces to abstract away everything physical and cgroup related
> for tracking dirty inodes?
> 
> Then selecting inodes for writeback becomes a list_lru_walk()
> variant depending on what needs to be written back (e.g. physical
> node, memcg, both, everything that is dirty everywhere, etc).

I *suspect* you're referring to abstracting or sharing the sharding
to numa node functionality of list_lru so we can, divide objects
to numa nodes in similar ways for different use cases?

Because list_lru is about reclaim, not writeback, but from my reading
the list_lru sharding to numa nodes was the golden nugget to focus on.

  Luis

