Return-Path: <linux-fsdevel+bounces-38710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB53A06E91
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 08:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79EC1886384
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 07:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B4820102E;
	Thu,  9 Jan 2025 07:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RCH36RRl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A6E37160;
	Thu,  9 Jan 2025 07:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736406154; cv=none; b=M0aYZfbQaErFb7Ml963ofmHNur774+/ZNeCWYRBVRDpysAR1HznT0E6G5ANUQ92XcWa25DdLEcY44R9CAXWLvUx//oRnnkcO+As5+aSQHz1Rb+NsD5KWv3AWxN6FKnXqykm51w2x1K8LNBjRDz/2Vwb2Hq7AExXswjtefTOm+gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736406154; c=relaxed/simple;
	bh=uhdMHQiMIgG0tObI4bHKhWWKpDrnQcDd2/GR2fGBTcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCekPD8wPYHWfCiNv7mjcTEw4gBGQCPohCyFfAITeiHDZhstf1oA3D+ZOyILOHzo4lxd3SAkxCX7Pfwv9N/2GKx7GC6+gFF5VM9Rytb5LP4wczrjJtoq2FeIvwtDDm16hXBzSNc7D0ZOoQ0kpKAETdx+2DcSK73cUvX/unR0A+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RCH36RRl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dYaSzXCkNd7U2OoLfONGfzJgDSKjBbj483PLTwNj3UY=; b=RCH36RRlypffLv8GUfjel2MuzJ
	i5HjUR3OCZpWH5tzsPT6lRT37qD7HnD7btna9OmxtwdV5FAqQD5GHu+PwqdIvDbhmvBl+ilHXQhsP
	EoPTz3LLYz3vooOcimlVzHINIp76q7UgnXjnMnRMdW8sIyehmMdONUvXdbddiYScqBZm794KI0lsQ
	3kglq1yvfNmwP6lX359UTcGqI+vvzh/KuDdFLGszirBTsBhqUwpjMJmx1PLnRm3qxKhN9KV6dyiz3
	mKDjcPITUMV1dlxaHZbo5PbY2U1bv3hGleCLDF7lDRTaOg4xSbI66p1QxVeQPj9Rz1OX8IAREa5qd
	GfRoKU0w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tVmYp-0000000Az6K-0lAm;
	Thu, 09 Jan 2025 07:02:31 +0000
Date: Wed, 8 Jan 2025 23:02:31 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/6] iomap: factor out iomap length helper
Message-ID: <Z390h2_8AmSQp_7R@infradead.org>
References: <20241213143610.1002526-1-bfoster@redhat.com>
 <20241213143610.1002526-3-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213143610.1002526-3-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Dec 13, 2024 at 09:36:06AM -0500, Brian Foster wrote:
> In preparation to support more granular iomap iter advancing, factor
> the pos/len values as parameters to length calculation.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>  include/linux/iomap.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 5675af6b740c..cbacccb3fb14 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -236,13 +236,19 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops);
>   *
>   * Returns the length that the operation applies to for the current iteration.
>   */
> -static inline u64 iomap_length(const struct iomap_iter *iter)
> +static inline u64 __iomap_length(const struct iomap_iter *iter, loff_t pos,
> +		u64 len)

__iomap_length is not a a very good name for this, maybe something like
iomap_cap_length?  Also please move the kerneldoc comment for
iomap_length down to be next to it.


