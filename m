Return-Path: <linux-fsdevel+bounces-51220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DD8AD4996
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 05:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A913A6727
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 03:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8845C218593;
	Wed, 11 Jun 2025 03:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HnE7AoRU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBC718BC0C;
	Wed, 11 Jun 2025 03:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749613493; cv=none; b=mR1SI10ePmxDYcMwaFB8HyDM57WoTCp/6fwfLe3IOJjHhD0W9jmhOcw9V9mvhehj10pk3A+r4oQRHR8wI6xHFN7x0PO/CodJZUBrIOAbvZ+im4mZR/lL4KGaBw9YuqvmiQqxXIO+4kp5td3bKTQf8wrSWEETW+ktrJWz9/n55wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749613493; c=relaxed/simple;
	bh=/TXkbMydY8uOmsfQLJNaPiZdlornKRi47nI0OrlB6ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXfOpImPZ4MMO2POIppkuFSf9FJFkijKZSgBnevHTjRHJ9UWHJl6VI6wRhDl8wC3/XUoF1yA2aKXk0psenaB9Unwnr00WUOC10bui4nyn4mnA/cG+bEj8RmZMZlVgn60SUCE4UFlGUmLHNqjLJtg9iBHf/oQsGajSE0V5XJhyjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HnE7AoRU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KWraIXPTfRx0DCMJBcG8HoU+xZCV/C4wom1Hf8BESv4=; b=HnE7AoRUD6YdKiEH4UrFkHdJru
	VhKTQJu5ZJym5pfQmsT4Rwhzra2sEq79+iB8SM3PidwRxgm2HGIUq86cprki8SNAZ8Xh85EV8bSUG
	VXWwV7ACy+7Eh7goBKwq2o4G3tF59O9k4dqSXhCi83sHzij2onnlNdnCe+fR0RdvkpSHBwLv9h7h0
	X95At21AjkoWWP2O1uWvMtsX9LEhgOe1EG2UJuuxu4BDBOeV1OD9f2LL9Td7ROjrehdjDzrRREsq9
	YyLnBjUh5EMxLp1bZRWXe8dtphhjfiXysg9Z5gYirUchH8CmlbnkNAGqK5Jj82K+GgfMd6Z996Bms
	62FDSMSg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPCOL-00000008l1w-3Y2t;
	Wed, 11 Jun 2025 03:44:45 +0000
Date: Tue, 10 Jun 2025 20:44:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
	adilger@dilger.ca, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH for-next v3 1/2] block: introduce pi_size field in
 blk_integrity
Message-ID: <aEj7rT0hsBc2fRn3@infradead.org>
References: <20250610132254.6152-1-anuj20.g@samsung.com>
 <CGME20250610132312epcas5p20cdd1a3119df8ffc68770f06745e8481@epcas5p2.samsung.com>
 <20250610132254.6152-2-anuj20.g@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610132254.6152-2-anuj20.g@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 10, 2025 at 06:52:53PM +0530, Anuj Gupta wrote:
> +	switch (bi->csum_type) {
> +	case BLK_INTEGRITY_CSUM_NONE:
> +		if (!bi->pi_size) {
> +			pr_warn("pi_size must be 0 when checksum type \
> +				 is none\n");

Based on the message and how the code should work I think the
test above is inverted.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

