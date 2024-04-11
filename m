Return-Path: <linux-fsdevel+bounces-16646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFAF8A06A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 05:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4939C28A502
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 03:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD4E13BACA;
	Thu, 11 Apr 2024 03:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CqMOQ0Xg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9673613B58D;
	Thu, 11 Apr 2024 03:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712805925; cv=none; b=AGAkQDL/qD/6qYdMdBANKOIUQy8u7aT0LmbCHfXzs/hJ7sy3VyqIFZj5FtcwuC+LEz9Y8xKrGSJJJWA52sLc3OSmu/bToNy7WQlR4XzYAbxv0SieJulekVu+hniNcZnB8c5HAYg5ld7JHv9dwrYVngY+2unpcR14wYA+PNuRdZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712805925; c=relaxed/simple;
	bh=Rsu7lnRE7qLxZ3vALiR4jB5fT6SGMAZhVfY0x4uifXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGy734j4m4cXA9+LFaN9kbNHGe71RwRn6AIUDeEzVdZP/9uiW98fCH7T/GXF3lshzjprtC8nxvCkzLR9Hk43r0Oagkl9P9buJjqdSWfKkjdnzcVYj/SbKAcYzp+sw+J9fGeDRlxFfYk2ZJ8LU46xrzqR5GybVgHsmrl5l0IYP/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CqMOQ0Xg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LxTlRZfxc6qpE+GhC/kSKeDD6IK4f6zyajTImQXumN4=; b=CqMOQ0XgNFd0H3BfGPc3OCKzqo
	ZwRDVJarq4KwheYqHgHa38N0L1G7FEUKyWsXYQ/SC+iSxLYR6F9lNF9jL1EJl5dzEh/5dR1lYaUG0
	oIgrMb2EvUV6KH0FrJb4awD+1MfqgBSLojvQnIVxe6v5fWOm/q25Da4nzcX+N9RXCEhgzbQ/Z3T7r
	GQX8YriIhqeFIeJqizBphPBAUeg+sGg+q+3/fbciaeQ8d0lfsbe1dRF/Py10d/L73VUkE+XxL1O1A
	FcZGJUOlq89KY8dj0oBFA62wDoO/1zKD7lWgpR+RazL+bERulnDs6OuKTUp/UxtFRw8kHQZQQtyP4
	MuU62r3Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rul3v-0000000A8uU-1Yr3;
	Thu, 11 Apr 2024 03:25:19 +0000
Date: Wed, 10 Apr 2024 20:25:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 15/14] xfs: capture inode generation numbers in the
 ondisk exchmaps log item
Message-ID: <ZhdYHzt9N8N27AKC@infradead.org>
References: <171263348423.2978056.309570547736145336.stgit@frogsfrogsfrogs>
 <20240410000528.GR6390@frogsfrogsfrogs>
 <20240410040058.GA1883@lst.de>
 <20240410183931.GX6390@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410183931.GX6390@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Apr 10, 2024 at 11:39:31AM -0700, Darrick J. Wong wrote:
> 	/*
> 	 * This log intent item targets inodes, which means that it effectively
> 	 * contains a file handle.  Check that the generation numbers match the
> 	 * intent item like we do for other file handles.  This is the first
> 	 * new log intent item to be defined after this validation weakness was
> 	 * identified, which is why recovery for other items do not check this.
> 	 */
> 
> How about that?

Sounds good.


