Return-Path: <linux-fsdevel+bounces-14679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C1B87E1A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 02:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6FC28257E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 01:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFEB1CD07;
	Mon, 18 Mar 2024 01:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P+gdu8Dl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DA717547;
	Mon, 18 Mar 2024 01:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710725308; cv=none; b=Ig7npOTDN7bBaPvGrJg3U+IXFLlZMS4bk1Cs7MbPz7Xb7zV3Oon0+hIF1n3CKx0s7UbyaucOW3EKgdlD9QAE4P1VOPuuZhku1ZT0azH3ADmsaamt1ny+/3pRiBt4xlxjDKbEIRsP9jM3MseT6bDWtaWvWq3y3crrQnJnv0b6hj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710725308; c=relaxed/simple;
	bh=AlbZN+vGvjXXms1bYQpdPhYbRme9N9s2nuII9UEMaPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuxhDwaDG0LQgwsAESpzCxJ/X5K18m6AFrlhAGUKlKZdzClJvXmcjknFZK33vgIfU3n/IB92u0OoKOC3BD09arYlnWqFV4rEUFdK/RrGR0T1gHIwqExNMCeDV8B+682KZoxxicKMYupKIwFIF2k1nDdGli6NUJw/QhF6EYNsOtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P+gdu8Dl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AlbZN+vGvjXXms1bYQpdPhYbRme9N9s2nuII9UEMaPw=; b=P+gdu8DloCxDQmbCwFduCqsjh7
	cUXUm0JrzyAmH/iCUvCLzbXQL1vI42GHdjWUSsJioOJdlYp7J56aiPT6lVwQUVPvAD9+q5VtfFEVn
	yWQB/R7SVxDdmTxTW3bzZ6wKM1oUZkK70iv7otN0HHGRPn3UtLReqdYm3830i+ow9DyV/fuIRa7PV
	VdD6AuZgYZZ1vePAXQYp4+A3qkySLT8jKQNxJm1SE3lzNd9lNklwC6hBcR+h7cTWbiK5GUrSg+6rf
	XTr+ha1P8O09D/zjnwkcnVVww1Sex3uv0XWYLsPOLlfsCJ4y0yEd0sdCd5nXe43pBFp40brS9+1V9
	LOVpo9Yw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm1nb-00000006vAA-3ELB;
	Mon, 18 Mar 2024 01:28:23 +0000
Date: Sun, 17 Mar 2024 18:28:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, tytso@mit.edu,
	jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [PATCH v2 02/10] xfs: allow xfs_bmapi_convert_delalloc() to pass
 NULL seq
Message-ID: <ZfeYt6zWcX7u1zMG@infradead.org>
References: <20240315125354.2480344-1-yi.zhang@huaweicloud.com>
 <20240315125354.2480344-3-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315125354.2480344-3-yi.zhang@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The patch looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But maybe I'd reword the commit message a bit, i.e.:

xfs: make the seq argument to xfs_bmapi_convert_delalloc optional

Allow callers to pass a NULLL seq argument if they don't care about
the fork sequence number.

