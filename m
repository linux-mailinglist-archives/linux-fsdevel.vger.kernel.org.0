Return-Path: <linux-fsdevel+bounces-43265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EC6A502DA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 15:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B0763B674D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 14:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789E224EAB6;
	Wed,  5 Mar 2025 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O+YSP4rZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4916424EA91
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186286; cv=none; b=Mi2ZEdbYIv/nvx3qACrTAETxgjNiBdKfEv9osQPe1RfWBkBLDjQWU04A+bYNcJnPPt6/zjM51H73QFZ5avHVNnK3Ayj7ZRZM647D360es5Jp4F1+kxTj2ezmWm9lVXzcxdbWEB2ZuMKcTanZGnuQIrjvglGoGkWvIr9E7XqX4xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186286; c=relaxed/simple;
	bh=Td9UtRdDdBJMDr3/TUZzeFtouuzekWef9iswoDm/rc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKY6qKqA2yGCzNJ9liwAcigL+CenaBpzoTbM5bvNBY6cy5+GglVt2zVNtRAb+kZrVxMuE3wsanKfUnq+TH+01NdN0tGErydwe3BDSvRBsXtBXNpOGshdqk34XRrrWkagPJij4Jg8tZCg5lAKafgb+53SssMN4w3YLRo96kzFSXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O+YSP4rZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ynGVQb1Gab/NZSFdpaegZt9vxG/19uFuTJm2C48LoMY=; b=O+YSP4rZHZyabtn+/U/Ee4CQNF
	n2SQViwg4wpDx49cfrrKr9kB7XZ5rNEGFC/OAB+YfAU6Am7aAH55+ejwfGmu6WrjyI5FL2cKZgEMV
	OZsOIypDRRMKg+i2dJe0bqMNNXTJLsC7dsD1BnFr3pbZXEPqoYkBR7+zYnPZVeCBv6w0SSlnc+cgl
	oopafz282Rx6pdUjlPOQ6b1BzZYjctrbOaIJAvigyfUTWLgj3QepslLa5PpcbsU8mElWpjVqYFpjz
	UBkGOtxKjOTCP2L1XCs7u8CCR6qmySzhS/VKW+SRBaA+1uLvd4JkpKpDlrVMXW/gVWCdyDHDCfTl8
	rukoUh4A==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpq5i-00000005hS0-1fzR;
	Wed, 05 Mar 2025 14:51:23 +0000
Date: Wed, 5 Mar 2025 14:51:22 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] vboxsf: Convert to writepages
Message-ID: <Z8hk6qw1KTQQp_s8@casper.infradead.org>
References: <20241219225748.1436156-1-willy@infradead.org>
 <Z780TsepBGDVZOKL@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z780TsepBGDVZOKL@casper.infradead.org>

On Wed, Feb 26, 2025 at 03:33:34PM +0000, Matthew Wilcox wrote:
> On Thu, Dec 19, 2024 at 10:57:46PM +0000, Matthew Wilcox (Oracle) wrote:
> > If we add a migrate_folio operation, we can convert the writepage
> > operation to writepages.  Further, this lets us optimise by using
> > the same write handle for multiple folios.  The large folio support here
> > is illusory; we would need to kmap each page in turn for proper support.
> > But we do remove a few hidden calls to compound_head().
> 
> ping

ping

