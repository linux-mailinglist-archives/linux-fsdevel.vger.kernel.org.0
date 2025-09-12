Return-Path: <linux-fsdevel+bounces-61000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBFBB54396
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 09:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50AD7463DB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 07:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7C12BE7B1;
	Fri, 12 Sep 2025 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F+k8sby3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3984282E1;
	Fri, 12 Sep 2025 07:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757661214; cv=none; b=l9q6Kc21bf88XVUa1Bt4W7Tqlk/MtXRo/E4OeWqx1bL7nU3M5xigWjjDd9xU5FM7YciuPUxta07K0THQPkAv2atD7vkFx/8icdOPI0prIHtN5h+JTJxbyE+aoBoHRqfjmCwOPtE3Jy/x1Rfh4lBpD5wC3tD4fknu+IpsXa3d70g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757661214; c=relaxed/simple;
	bh=apC34MggOTqhcFIv40H9SqkpG4NcvYferg7VtwQ2W2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bka5ckL8K/67BGuXFn2XrAZF6ahJOO4oQKavByK0AIlQqWVLkbzkixasnj62ZPCNQIZDtYA3SFS8lYJhS/srHcNo+GHsM73wKMgXnshF0JpcQF7GPGvfL6sDkOBVxxk3t49hipCQVTjbLVba58x3t9+mdRiqBsD1hdrGsekKtFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F+k8sby3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=apC34MggOTqhcFIv40H9SqkpG4NcvYferg7VtwQ2W2s=; b=F+k8sby35GwKMn2i4D5u75o2K7
	jFzWb5DRAo2lQLHvbTwATDpDDemi8J6babAz0/mCqr/j9uhOc2kT7wdMqZl/NPQW6hv2f1eaFq5Xp
	yXR4yobUQ28AzTh6NTV0gYTod/ugUaM7mj+KfQtbX+gvJFxtTdyKMHMB5S7xWSBskTgCBo9EYtHmS
	+xnsC0+AeL1khcdDB3+DLULdk55pDvjLINRyy3+Fjw7/8ABtkwrn8LzSn+kvT73sh8Tuvjw3+mqPJ
	0bRH/CCLWLOAmF770UiPo/vlxcFcLDZF2NfH8eWvefOs0DT6fg1RM3AQ0uShhHNx5RJkw0qxiZFg7
	2bEkHOEA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwxy8-00000007aBS-3s8R;
	Fri, 12 Sep 2025 07:13:16 +0000
Date: Fri, 12 Sep 2025 00:13:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jinliang Zheng <alexjlzheng@gmail.com>
Cc: hch@infradead.org, alexjlzheng@tencent.com, brauner@kernel.org,
	djwong@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	yi.zhang@huawei.com
Subject: Re: [PATCH v3 0/4] allow partial folio write with iomap_folio_state
Message-ID: <aMPIDGq7pVuURg1t@infradead.org>
References: <aK20jalLkbKedAz8@infradead.org>
 <20250911091726.1774681-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911091726.1774681-1-alexjlzheng@tencent.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Sep 11, 2025 at 05:17:26PM +0800, Jinliang Zheng wrote:
> Also, have you found any issues with this patchset in the past two weeks? If so,
> please let me know. And I'd be happy to improve it.

I think the patch itself looks good, it just needs better documentation.


