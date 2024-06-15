Return-Path: <linux-fsdevel+bounces-21749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFC190964D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 08:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D483C1F223A3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 06:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1FC17580;
	Sat, 15 Jun 2024 06:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CKKdDrmR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F23D171A7;
	Sat, 15 Jun 2024 06:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718432982; cv=none; b=M+q0W0bfYSiDS7VlT6on93wMog+p7lU1P5/EbSzRYjGPO5+7uK4La2iHYiyyoV2mKm6TBfUG+HLNtuOu+1O0m6PRvC3NInIFeZfP/uI1L9/+KJ1x2NL9KvZYblt9LlbCugQL6JUe8RhTB0g8PMZ0Mu15e2SnNncwSYsNzHzPFOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718432982; c=relaxed/simple;
	bh=0zM6gJVJvoOmYTuTb0pxv20OuNzO82Jy5LiDFJyCn5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEpixJwPxu9MM4FkPqGeJwwFtA+R6EAzS8xCNxqHvEkXiouVMKQjHECfZ+LDudtlCXr1TCEUtk84rdZhjyK5Zims3MNjRUpSWN7iH5XNJZhEnZcYUQBd45KZ6uKjOoTrAk1HtszFG29t0gRM/XiUN2Io+XraGoFILK9xSAlUWz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CKKdDrmR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5cfpNhUeQXoiMt8QIStiYYLXtYSXmM9M5tXUD/QDu14=; b=CKKdDrmRm8Oi6I17Cs1sa3UEXm
	jkl72unEqvU5duMWnvjO8KXokXQTGN1t3XChuMQILlrtvYS3NzEG21+fC1HEsYuNrNG5fJ5CZvBlQ
	cYr2IS/ymR08lDStsw5h7TpyQ9esEU2flMB3716Sl78UkpMScs++l6c0NaukGTxbcR7lQB5eCzfX2
	yBUYfiH0unsAylR1ifdfMApo+E/CVh+U5+QnPMdoWYRt9xA1tDEW6SOrgrlI7wWI3XpfIXIsTI2aI
	0cXSVSsINi0HKjwz1x4VW4skYwk9EJ9YBqhguGM4qaxFDFDYfkDLoA0EPXSxD/KBbT1IgdvFoQ8IM
	nRKjzEqA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIMuw-00000004nqX-3HBv;
	Sat, 15 Jun 2024 06:29:38 +0000
Date: Fri, 14 Jun 2024 23:29:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Congjie Zhou <zcjie0802@qq.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: modify the annotation of vfs_mkdir() in fs/namei.c
Message-ID: <Zm000qL0N6XY7-4O@infradead.org>
References: <20240615030056.GO1629371@ZenIV>
 <tencent_63C013752AD7CA1A22E75CEF6166442E6D05@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_63C013752AD7CA1A22E75CEF6166442E6D05@qq.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Jun 15, 2024 at 12:38:32PM +0800, Congjie Zhou wrote:
> modify the annotation of @dir and @dentry

Well, it is clearly obvious that you modify them from the patch.  But
why?


