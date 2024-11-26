Return-Path: <linux-fsdevel+bounces-35867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835F29D91C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 07:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29B97164E7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 06:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D47D14A617;
	Tue, 26 Nov 2024 06:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CK8MtKho"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500303208;
	Tue, 26 Nov 2024 06:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732602524; cv=none; b=gKF0QdbYnyEQYLbDI0gswfLND7NvDwDZcrWp315s8h5ULQGZQl7pbrxywKxb5xgapSfE/MpDRRlHazfBZqi3ZdJ7C+dbc3WtZ4/2Daw1fR9tYG0hxO+L3vRFZ0wsb0yzDrh46Dr72i4RFVBFq0sYix9wRkGBzkVJ6sfKwoK7XVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732602524; c=relaxed/simple;
	bh=jBvsXUa+KVetyDO3nuKh8DRxmU9B0Eh5CkdbwSGujQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTRGp9tj1ACxZry4KNx2lbWCCM1JsoueBYJbVLLfQ21uvoPiQPOV/NH9aneTGXROu9/LgAgrHgBSeHTPN2wOO2efVxJBWQE5H7Y6en3VXH+yPLXENsvcsWN6RpI+ki6HJjeYcAPcG1xQd5GlbzuGhvST4JZSSQFUI6nliRx5g0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CK8MtKho; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NkCBw0T+wvzvEh7PS8MNuGE6nh/Xikzq0/DxGMZnHvE=; b=CK8MtKhosFjJbxe93sg6+KrV9L
	tABNe+9eDAWd0mSnrkvYfv3haqCXv2h5Qxd4OAvKMMrmlvvZxMoWBVw/6kAL42I3pRZazQ2fuEbPl
	Uj0k0e5fO5EBd7nffMzOp582KlFdevw99nBnsZ5UMli/cMYsP1yUvvKT5/OdovunOv84NBTClhbcw
	QyV4L8nCBP/w49rUS1M2TL0BLBlUvsAPt3nDihKcZKAzGh7J685fwC65zFvqwHmkBPcQ5FuYC6c5h
	w9BiwE/W1FnhvmgEqoEb19lyHhlZAlGuoNX5X85DAsyKGWIhWTZwY5Vpv2OwlCjn9sY4wWz275WCR
	81C8sjPw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFp3y-00000009kY0-3VFv;
	Tue, 26 Nov 2024 06:28:42 +0000
Date: Mon, 25 Nov 2024 22:28:42 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Long Li <leo.lilong@huawei.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
	djwong@kernel.org, cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, yi.zhang@huawei.com,
	houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v4 1/2] iomap: fix zero padding data issue in concurrent
 append writes
Message-ID: <Z0VqmgQisdDxlSAy@infradead.org>
References: <20241125023341.2816630-1-leo.lilong@huawei.com>
 <Z0Qb1HKqWJKyR5Q0@infradead.org>
 <Z0R-2Jmj2u-Cqwxu@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0R-2Jmj2u-Cqwxu@localhost.localdomain>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 25, 2024 at 09:42:48PM +0800, Long Li wrote:
> I agree with Brian's point. The scenarios where rounding up io_size
> enables ioend merging are quite rare, so the practical benefits are
> limited, though such cases can still exist. Therefore, I think both
> approaches are acceptable as there doesn't seem to be a significant
> difference between them. 

Given that not rounding and using the unaligned value should be
a lot simpler, can you give it a try?

