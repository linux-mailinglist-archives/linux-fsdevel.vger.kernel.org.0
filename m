Return-Path: <linux-fsdevel+bounces-50458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A893EACC74E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 15:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4EB11881F48
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 13:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08C5231833;
	Tue,  3 Jun 2025 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z32h8USJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF186E555;
	Tue,  3 Jun 2025 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748955870; cv=none; b=K+BBzAI17sccQ/rSBLENWecUn6VcAtL+MlkMEU2G5sclaRwvXrcwc+wxdgBeZKrgpgZSGPtIxA5FoksVLNE25JPhTje4+KwEhAA/FCKs7GSxxpi3YZ9sqc1QKSTUVf+WyCxlQqcLqWf1tpV7VFUqQioMWA03jFzHm/NBiuHm1nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748955870; c=relaxed/simple;
	bh=WzFBIq2DtheqQxiEtOPK9KR+ToJi/9e0l39t2GO+em4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqDvgTu6pCk3oNuj47p7QkojJofe7b8xJxMbqS4+2eKEiHZw5MLB5A4fRsATfyKWOJp7oQoiQMogvWs21fIyyqXTzfUyrbN+QV1srW9XQPhaVYr+uv6vhDKH6VohtSUqauTa9SAPICAKWDv9Ps/+gVSeZ/AWHdy/zsD+wm1RMnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z32h8USJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=D9uwUqknLusDgbp0HRUYDNcdU0WC/Bc+jDReHlPJQc8=; b=Z32h8USJkXlLg0CzemLyp4Dye/
	TtgKgAOXUjrqt+T++4R1iz9ez3e6cFStt6mEWlFuA+g0hgYL5NYhocctT3VSG3VET+U98CtqWxSkB
	i/b2Zxt24tLvhL7Ln2xSKveG0lF1p+Ni/TSQ2GDoSQylbsUHKd+sd+NMN0rABOHYn06TYB6ugDf2n
	3dUSZfqqSYZG0hGYatjGoyvlhW4VyArjWi2Nm8mDx62ir8FN8k2TjCo9FUWAgeRZGMRiuMFbqpIgE
	TNv010SvGK7DCV8EzcXfcg86R8jnrSbvHabK1HLPv7coX733r0lqEg34KPdFSHdCsEDsIvI16X2AT
	/93VCYzA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMRJU-0000000AzFD-1LA9;
	Tue, 03 Jun 2025 13:04:20 +0000
Date: Tue, 3 Jun 2025 06:04:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: wangtao <tao.wangtao@honor.com>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, kraxel@redhat.com,
	vivek.kasireddy@intel.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, hughd@google.com, akpm@linux-foundation.org,
	amir73il@gmail.com, benjamin.gaignard@collabora.com,
	Brian.Starkey@arm.com, jstultz@google.com, tjmercier@google.com,
	jack@suse.cz, baolin.wang@linux.alibaba.com,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	bintian.wang@honor.com, yipengxiang@honor.com, liulu.liu@honor.com,
	feng.han@honor.com
Subject: Re: [PATCH v4 2/4] dmabuf: Implement copy_file_range callback for
 dmabuf direct I/O prep
Message-ID: <aD7y1PgUyd-xkS1u@infradead.org>
References: <20250603095245.17478-1-tao.wangtao@honor.com>
 <20250603095245.17478-3-tao.wangtao@honor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603095245.17478-3-tao.wangtao@honor.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 03, 2025 at 05:52:43PM +0800, wangtao wrote:
> +static ssize_t dma_buf_rw_file(struct dma_buf *dmabuf, loff_t my_pos,
> +	struct file *file, loff_t pos, size_t count, bool is_write)
> +{
> +	if (!dmabuf->ops->rw_file)
> +		return -EINVAL;
> +
> +	if (my_pos >= dmabuf->size)
> +		count = 0;
> +	else
> +		count = min_t(size_t, count, dmabuf->size - my_pos);
> +	if (!count)
> +		return 0;
> +
> +	return dmabuf->ops->rw_file(dmabuf, my_pos, file, pos, count, is_write);

So despite claiming in the cover letter that dmabufs can't support
direct I/O you are just reimplementing it badly here using a side
interface.


