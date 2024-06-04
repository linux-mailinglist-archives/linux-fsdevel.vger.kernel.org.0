Return-Path: <linux-fsdevel+bounces-20887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA268FA90E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 06:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35E65B22530
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 04:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FBC13D886;
	Tue,  4 Jun 2024 04:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JbzeD2vD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB2D38B;
	Tue,  4 Jun 2024 04:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717474131; cv=none; b=nmX6dr4f4jM6rzqfe9QDGm3aLmvLV66A29gBPspXAQr6HqvNuxQ5spZng0zgHoPm2RhywTGN71+uf61oeNfdVHeDKQJOjVONt3h7xLcAEH6RboAvQMuEygQsX1Afa4PaXSY3+naRsmrMqQsiYBdHd4A8NbQoDNu7ZcB8XDv3XQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717474131; c=relaxed/simple;
	bh=wz9kD/SzgOwfEiPgTA74JYDHW8oF79LuN34jmdDoAGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmUhVEyUdOvHl3Wbx8iz7fs+YsMhNU3g72pVY72IX+WOeQq0CFBqFs5G1jNtIWug/KhBo3qCoWJsJxDR1KqYtjj4CE+j1XpHG0ivZqhkFzJQQD/VFWjflcqixDd9YwquVkZMVzwjyZR0NeJNm4GYi96Cz+YaeQ3/0OyIXDb/PhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JbzeD2vD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wz9kD/SzgOwfEiPgTA74JYDHW8oF79LuN34jmdDoAGo=; b=JbzeD2vDbGLdrcc1VnWi4bv6lf
	1ThOn1wh2iS8M0vue/UgGKZi8WMQ72qsz4v8Tbh1TrcamInmrjrl3F2VcZjS6AJ6WGhSLpD9bBKfn
	/yia5EHcWVkqmd/URecuiGFmtKCu2DQZ9eZXO2LCPyPeJi4kt4kpshZtbXxQElwlCN1qsg2QI3sqN
	42vlVkfnE6q05GXgnMz9qjqhKHq8LUxZ5xfwTLvv6XO+SuPfpLQUn6TIt/3TU3f98nXzLc0e5T783
	v8lbck6+vAMvcnQUek1swBKpne611Gjxr7rYxYz5wtsQZlCrbxYOcykrNNPkEO3XK3Na+RlNzRuHo
	CX4WNJDA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sELTc-000000018oP-0xCW;
	Tue, 04 Jun 2024 04:08:48 +0000
Date: Mon, 3 Jun 2024 21:08:48 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
	jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [PATCH] iomap: keep on increasing i_size in iomap_write_end()
Message-ID: <Zl6TUJhShRc2pqzF@infradead.org>
References: <20240603112222.2109341-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603112222.2109341-1-yi.zhang@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

hopefully we can bring it back soon.


