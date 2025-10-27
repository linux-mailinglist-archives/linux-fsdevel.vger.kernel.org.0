Return-Path: <linux-fsdevel+bounces-65663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B314C0C29E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 08:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52BF24F037B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 07:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E902E03EF;
	Mon, 27 Oct 2025 07:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PiheCWsq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77C527E06C;
	Mon, 27 Oct 2025 07:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761550814; cv=none; b=tHYnzODnzfleJl2uAo/g9TUvedpYcVloz4LlMugReHRZHnWXOKmKTunUNMwhxEJ1fxf91wJOkNSGGWhKNCSDaPbCZMsbDJAmX44LNwka6noyqsY9XS/U6lyV2Hx7VhZPcOisgGj3Mr6arGy9aoWf8RRxdYJPG+dGbJ5k63G+yEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761550814; c=relaxed/simple;
	bh=4AUKMRAsAp22IJZUtp5f+8gpkrQvUtZ8fKI89RfiftI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jxaftd7bmQnvHz/WDp8rukruI6rMJ5kJ8Wf736e5czl+Z5ec3M/qYGrIMDEFO1Qd6TDijgZqREkZKiOcze5ER1f/8ZDz03y8edNzah95rqWQowAFaYyqsWv0aP1kth/ewOgu2ND/BzDjocZigaq1WA4LCNV8Y1jQN+yCoq6qOU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PiheCWsq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9jMl20VeWz5/kixKog9nGx1c3XBZkDdSCBaR7mjSQx8=; b=PiheCWsq42Vhc0KTiC/bg8ndkG
	MeK55Ev+k6GwF8Vb5G4IDqHCtpXpfby7eMipiOb16PeGrIljYOjpJEdHJqF95VaEMSdVojOn6Nv/A
	EG/mDPY166eH6hQ1JSoHjFVhYQT5TSZol8BJqgbJBEnM8vrIbge33wl3i0a7ePlte9O4fs5+i22tt
	qLKNBCWPGm9yg0JrOc6ivDGSWeVOOFu3DW31rm53IlzXqlAiVzK5KJlOCDoPgUhefNlokG+TJ3MH2
	fXm3s8eNmp786D/xL/55EOEiQJh8OrDFryydlujf/BM8QHr3/Frek4i0leO8GuZhM4DKOVH0zr/XT
	v946VGTA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDHpm-0000000DI50-0JnV;
	Mon, 27 Oct 2025 07:40:06 +0000
Date: Mon, 27 Oct 2025 00:40:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Baokun Li <libaokun@huaweicloud.com>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-ext4@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	linux-kernel@vger.kernel.org, kernel@pankajraghav.com,
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, yi.zhang@huawei.com, yangerkun@huawei.com,
	chengzhihao1@huawei.com, libaokun1@huawei.com,
	catherine.hoang@oracle.com
Subject: Re: [PATCH 22/25] fs/buffer: prevent WARN_ON in
 __alloc_pages_slowpath() when BS > PS
Message-ID: <aP8h1jz8JEN-3du0@infradead.org>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-23-libaokun@huaweicloud.com>
 <aPxV6QnXu-OufSDH@casper.infradead.org>
 <adccaa99-ffbc-4fbf-9210-47932724c184@huaweicloud.com>
 <aP0PachXS8Qxjo9Q@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP0PachXS8Qxjo9Q@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Oct 25, 2025 at 06:56:57PM +0100, Matthew Wilcox wrote:
> If filesystems actually require __GFP_NOFAIL for high-order allocations,
> then this is a new requirement that needs to be communicated to the MM
> developers, not hacked around in filesystems (or the VFS).  And that
> communication needs to be a separate thread with a clear subject line
> to attract the right attention, not buried in patch 26/28.

It's not really new.  XFS had this basically since day 1, but with
Linus having a religious aversion against __GFP_NOFAIL most folks
have given up on trying to improve it as it just ends up in shouting
matches in political grounds.  XFS just ends up with it's own fallback
in xfs_buf_alloc_backing_mem which survives the various rounds of
refactoring since XFS was merged.  Given that weird behavior in some
of the memory allocators where GFP_NOFAIL is simply ignored for too
large allocations that seems like by far the sanest option in the
current Linux environment unfortunately.


