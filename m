Return-Path: <linux-fsdevel+bounces-43190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5D5A4F1A8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 00:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC9F188C46C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 23:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36B7259CA4;
	Tue,  4 Mar 2025 23:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NE73DCj+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDBE1EBA1C;
	Tue,  4 Mar 2025 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741131602; cv=none; b=Y2mXYTMKgxba3dQGeClxQw0v/0UJXlM4HUOzpb4CZErUBHO+kEeUWM3Rj9N2OEmduMQWJv7aGOo1W90C81BB9Ku/5Q8yCm1MsZeyf1w7hFYbg5N6yKoo+yk96G+EIhA+5fzJ9Ix8/exENjVODWMfnmGIBH/3m37yBwXgxB70LzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741131602; c=relaxed/simple;
	bh=QZVDvEFUU0e/0iB+w5j1DnY0DCmhWxMFhb8RsVzuLUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFxuoE7KwFmLTpquiFbeNrikrKcxw6O9V7Gs4EuEkitvB31oLAe0RjK+P+sAtSrYlEqPMEVXVFQWdEw3aF3y0gwgTlWTg7VbRl/xMiC36MJXYKQ4VwVFyKuV1/GONEr9XZwlrXIbky8zxA9y1p+2BrVh0F8KG8EYBvD8zPGP9dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NE73DCj+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+m1aYezl8/hAr3njLk/YkPvClWtmRrt93Sm/63bNujo=; b=NE73DCj+tA4WV+jlcWBBANUV1e
	/nHUcvDbtn3lDh52EQt6y+osJ+7ipVXNmHhMeWnQibNsS0o+Af5HRlOO3z55XosCneuKhHulhv5bj
	tyAV77UhTBBv3Dc7hyY0WEdE8oohkySQQnCJJPImEuytCKEXwRiy4/B+djAarIO0UMqsrrYCiROjE
	232Bf2I4nHMmej7LZIhEYNR6yKzpg+6lbZItAAPku94qKqXRdywWRB65hC1jZ0bRnkB5K+sx3+pa6
	5MyA0ThBeCna9NAXvNBevUDlXnCxgD9yHxTDHP7ob6Cy0zApqDIZE9ez/sGEh2L7ENEQvi5VxtGfi
	72QSZ0Mg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpbrk-00000006XnH-1jgA;
	Tue, 04 Mar 2025 23:40:00 +0000
Date: Tue, 4 Mar 2025 15:40:00 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	wu lei <uwydoc@gmail.com>
Subject: Re: [PATCH v2 1/1] iomap: propagate nowait to block layer
Message-ID: <Z8ePUCfjuAANXlQo@infradead.org>
References: <f287a7882a4c4576e90e55ecc5ab8bf634579afd.1741090631.git.asml.silence@gmail.com>
 <Z8dsfxVqpv-kqeZy@dread.disaster.area>
 <970ec89d-4161-41f4-b66f-c65ebd4bd583@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <970ec89d-4161-41f4-b66f-c65ebd4bd583@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 04, 2025 at 10:47:48PM +0000, Pavel Begunkov wrote:
> Are you only concerned about the size being too restrictive or do you
> see any other problems?

You can't know the size beforehand.  A stacking block driver can split
the I/O for absolutely any reason it wants, and there is no requirement
to propagate that up to the queue limits.  That's why we need to be
able to synchronously return the wouldblock error to get this right.

