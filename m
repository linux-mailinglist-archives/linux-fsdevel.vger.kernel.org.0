Return-Path: <linux-fsdevel+bounces-54851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41532B03FC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 15:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 087A016075D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 13:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1750258CED;
	Mon, 14 Jul 2025 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OLHUV3Ui"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FBF258CD4;
	Mon, 14 Jul 2025 13:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499383; cv=none; b=RMC6Ti531WRgtgULf6lQ8GS/HACEIS2VblTmmG31sGCNdDYp9wm2tLB38E+FnLtRJKDOv/KrggEAOuph80YOJZniM0PqiAAacVDpCeh+dPHoqMYF4WLcYx2ATvJSvEvmCVo3xhvoaVwmjJpyRUcT7qc//6Z+izgswM2w/9ItIrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499383; c=relaxed/simple;
	bh=IyGzZoAmrjxn0MwMU9ZqFWkarMZebH/h2HjcIT8XkNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOAPbK7IrLrAiTuUp6nVypK5/eUBaAsiOicvbPOUfM2hf0znBlQc+H5+EQuNVSjtyk/rbHchQSi0pi1rIyEXR4BxsyIzIrWk03IN0M6MgMCgllVaTU9G5/+21/KiMWIXVGqfxE1L47a/aclXGGIsozXa2PQIPO1lHpfqqiBEiQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OLHUV3Ui; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2uv57CtZpiuAjvDOswZuOxUwJAP5zphK+XJePPHH5gk=; b=OLHUV3Uic71jXM2HJSjq5EaZnL
	EuXIgZAn92tPI9T4uHGT0oQbOK9aXUo1aoxzaQZCjmgkSi4mE43+tNS3j/gbF542VLcmacz9NT/7z
	4UrG4j5KiLJZxim0vrhcxzFTtc575k6nB0r2TFvsP+KTtNeLr9tEyyqkbZoOpZUVNkTvVNYuakesR
	A92l9s+FLdrPN/9R4yCs3lKtnwmvQ8enJMBJbq5tF7Hau9LNC5q2PbJzlQcrSsOLGG0/PStJGzHC0
	Iljb6/RGnKVh5ZkjBIluAzrtY+KIGY2eaNlpQb330FuL6qciEYyOtCGOdB7TU46G+iTF3xtGscioP
	5tjfqytg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubJ93-00000002H6p-2R5f;
	Mon, 14 Jul 2025 13:23:01 +0000
Date: Mon, 14 Jul 2025 06:23:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, hch@infradead.org, djwong@kernel.org,
	willy@infradead.org
Subject: Re: [PATCH v2 7/7] xfs: error tag to force zeroing on debug kernels
Message-ID: <aHUEtVJK6PPepNde@infradead.org>
References: <20250714132059.288129-1-bfoster@redhat.com>
 <20250714132059.288129-8-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714132059.288129-8-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jul 14, 2025 at 09:20:59AM -0400, Brian Foster wrote:
> -	error = xfs_free_file_space(XFS_I(inode), offset, len, ac);
> -	if (error)
> -		return error;
> +	/* randomly force zeroing to exercise zero range */

This comment feels very sparse for this somewhat confusing behavior.
Can you add a shortened version of the commit message here explaining
why this is useful?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

