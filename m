Return-Path: <linux-fsdevel+bounces-64213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98955BDD1B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 09:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B0EA3BBD6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 07:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8A5317706;
	Wed, 15 Oct 2025 07:30:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B6A21B9E0;
	Wed, 15 Oct 2025 07:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760513424; cv=none; b=jOOe93+ZiYO67f7XXZLSauZzQ8ugYXC9mapEQsfaloM9/rVFPm4OvHwjgaGd8617I6a7Oo7X4p6cyoRYu4rj9Igb10YSoNREzQgZ77MD9cAcvPIm04D3DQVvK+jFUCWms6iZRE2QQAed2NkRL7pAT01DxTkS0nf3PGnO8oJGTtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760513424; c=relaxed/simple;
	bh=wwsMcO8kxKDe39xAaR0wfWWvJXHr4ArjIXG9EGSFt8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaBfMQU13uj3cMyLf1sigcWROviSGKnQVgL75UBCihF+pntD2HYGJT5CztfM8yJP4GhY6KsTdUvViOhTq1bIa/G1bTxdrFwmJTVZxqUGcMDqM5ur1SNVMPoEvCQwCQZjTNfVR7OuQmqkEo/83uYTcz1ZYDSCqSb8ArVxA5v97Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7A8E9227A8E; Wed, 15 Oct 2025 09:30:18 +0200 (CEST)
Date: Wed, 15 Oct 2025 09:30:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu,
	agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org,
	akpm@linux-foundation.org, willy@infradead.org, mcgrof@kernel.org,
	clm@meta.com, david@fromorbit.com, amir73il@gmail.com,
	axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com,
	djwong@kernel.org, dave@stgolabs.net, wangyufei@vivo.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com
Subject: Re: [PATCH v2 16/16] writeback: added XFS support for matching
 writeback count to allocation group count
Message-ID: <20251015073017.GB11294@lst.de>
References: <20251014120845.2361-1-kundan.kumar@samsung.com> <CGME20251014121135epcas5p2aa801677c0561db10291c51d669873e2@epcas5p2.samsung.com> <20251014120845.2361-17-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014120845.2361-17-kundan.kumar@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Please split this into the writeback infrastructure and an XFS patch.
Adding infrastructure and the user in the same patch is really annoying
for bisecting, reverting or even just reading commit logs.

