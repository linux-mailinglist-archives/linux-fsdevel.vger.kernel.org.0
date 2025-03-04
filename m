Return-Path: <linux-fsdevel+bounces-43188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF70A4F186
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 00:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8FCA163500
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 23:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3C61FECB8;
	Tue,  4 Mar 2025 23:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jXg4CK0b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B09279323
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 23:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741131241; cv=none; b=jBS42uyylXW8aeT22Gli5r+v/0If0Kj4rY372V1CJLj+UZSqe2h+i7xgyXTGSh/gkYllx1n6Sxs+YMT4CEpVVQP9QwA5vtM2oG9wEWzzQSj8TP0yZG9jFxjxRKNSQwkV3PM+3DWlnzLhQjev/xF/i5Zof2Vc9V/6GapCTbhO4BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741131241; c=relaxed/simple;
	bh=V/YoStQ3/xbCkUXOS7/+yWRWr3s8j+10DNeiBXO3GNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mk+anUSpkKWonYAsBb14nrsbi6itF0ZWAWv5q6pt/VbLqm4tSQM9d/ZuuK8iFQxmyZDyJZow4ZNjxl9Dd3I+l23RxThKlyvWa/lBUAmVX7A48OushFLNDFAHem/piA7MOdf+tsPaNuCENqzEFcpDHNXhk1WAhMf1E+JpNjshRXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jXg4CK0b; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3Qaca/vWJRDE0W37UsBW/xAUI1NqmwtDJ04dpELM1kg=; b=jXg4CK0batN5Li4i7dSvtjWpgI
	x7mTYzgEpsQWU1fhqZYbeHAEZLAa3LRQX1XA9l3FPeD/uv3k1TEtc2zNEFyNW9v6SMz0VGlA8lkg+
	XEj2Nn4SGzrlmQ89yA3NZp1xT0/O42WoUJ13nraJuMjMkdFTMR/g2NSV7NinNF0CssZHQagwOzT4X
	bEC9j5sTvZ9Pmbe7oSRnXD7JeRxSUc8GGenWJtqDqn10i6Tgao67MfuyH9uVnzzyoXZnIcMEAiiu5
	vLpyjXPet5XJwCHmgJzosd3eCwpamdP73HZA7mS94K895FHgpHznVvlpm/RLt/qcJdGGp9cyCxFSz
	RACtGqHw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpblw-00000006XQd-0e7Y;
	Tue, 04 Mar 2025 23:34:00 +0000
Date: Tue, 4 Mar 2025 15:34:00 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Changing reference counting rules for inodes
Message-ID: <Z8eN6Nd1iuQC2noS@infradead.org>
References: <20250303170029.GA3964340@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303170029.GA3964340@perftesting>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 03, 2025 at 12:00:29PM -0500, Josef Bacik wrote:
> Hello,
> 
> I've recently gotten annoyed with the current reference counting rules that
> exist in the file system arena, specifically this pattern of having 0
> referenced objects that indicate that they're ready to be reclaimed.

The other way around is worse.  E.g. the xfs_buf currently holds a
reference of 1 for buffers on the LRU, which makes a complete mess of
the buf rele and related code.  And it prevents us from using the
lockref primitive.  Switching it to have a refcount of zero greatly
cleans this up:

http://git.infradead.org/?p=users/hch/xfs.git;a=commitdiff;h=8b46634dd6199f332f09e6f730a7a8801547c8b5

I suspect the inode just needs more clear rules about what state an
inode can be in.


