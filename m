Return-Path: <linux-fsdevel+bounces-51101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D30C7AD2C8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 06:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D42D3B0430
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 04:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4041C25DB1A;
	Tue, 10 Jun 2025 04:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vKTrabqX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729C425DAFC;
	Tue, 10 Jun 2025 04:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749529342; cv=none; b=fgGbj3e8br4Oa9+i1LTF70stCjOTu20F0ivuvWlGV2gft0KJxzpaBXyhc7kzaRP01xhaByQgMtkGKt7I56i5xOcvubqKb935i5QYyeWMkqgkxpM9IFSyL5IoV/2V2zD2Py+aWZHKSACBXbxgt3E9Nnf2t9kL+Yq8S3yWy8EKleU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749529342; c=relaxed/simple;
	bh=QUa17jhCudLWuhw8pjqa0ECLiW5512gg0pDXKQZcw2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyJyB7NzjCuhZQ0iKMmTjXfOiA3Yuy/JM3CgAhwx1xOyWUNFX18az8SkRx6VpTA+fynNgLplSbZw2izJPCZnY8TamAnVeHtfh2YpYcHYe+gmh+I5QHhztvxRvqsY0c4zBzgpdcg2B0wIhsSXKgVCpPSAHYYoC8mx3HMgQWt4GFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vKTrabqX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w+AZigyEDNfL3bND+nDNpgFpnH4Oa1zpGwvKz3U2VkY=; b=vKTrabqXBsJq+TJs177GBxW6cW
	FpbLgLE5gjzKJghClry5M+lXn5n0KtqOt7IUCkIatnaYFgdHG7qURpCpLfY9cxBq1DqlbzcHhKu7d
	W+SACWSv+3AFW2Rh4OU6w+/3umrozyHNC6nNTxJTRkTTU0asF5d2uIVF/jsQ3hEIezVe6QpdJMk+V
	z3XbGlnTGxb3mX6+K9LvJaQCU4y9La0p4hFwgzI13H192nTJ4TFZ0shDjeqc2VmZA4L1VlmVEkgSu
	PQY5KGgVq2SJ5KbediciYA3RamAGpA0kKjONG6sg2J+ejn0+3YRLmt+HQYe+db8tS8jgpG8woa8b3
	BZUmlo+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOqVB-00000005k3X-0Mrm;
	Tue, 10 Jun 2025 04:22:21 +0000
Date: Mon, 9 Jun 2025 21:22:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/7] filemap: add helper to look up dirty folios in a
 range
Message-ID: <aEey_duRKNO0ol8d@infradead.org>
References: <20250605173357.579720-1-bfoster@redhat.com>
 <20250605173357.579720-3-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605173357.579720-3-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 05, 2025 at 01:33:52PM -0400, Brian Foster wrote:
> +EXPORT_SYMBOL(filemap_get_folios_dirty);

Right now this is only used in iomap, so it doesn't need an export
at all.  But if it had one it should be EXPORT_SYMBOL_GPL.

Otherwise this looks fine, but as Darrick noted a kerneldoc comment
would be nice.


