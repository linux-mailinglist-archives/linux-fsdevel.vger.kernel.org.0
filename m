Return-Path: <linux-fsdevel+bounces-50281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71164ACA8B5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 07:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5456F3AED61
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 05:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E152C325B;
	Mon,  2 Jun 2025 05:00:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783701DFF7
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jun 2025 05:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748840438; cv=none; b=PFOmzIYHuRHsSGNJQaJ59u6dtrKqs8dInfvmslkIzbBP+xdTxPosS3wJP/NjV741FNjw8KLxgV0AUhAF1OcxpVi1GBSL0n2j+63u17oBC6GUlGbCI6jwuzmMjxPmGHGXRmcLRTN+LOxYlC+CDkhwqiITw9A0wuhA8a0WkvHPl8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748840438; c=relaxed/simple;
	bh=lLEiW0T2qHCHUZjRLRubTtc7et929ZxcBizZQho0DTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0Ke/pzaS5T6L1LAF01fBAUiaH/xluGPXEFkPMDNACPkvIobk2PzlMlnTg42Y8rrEoOwsyVd/inZCtWmuKKjXJCT+aUzeXuxlO7UFnIBBdsdBJEPPfJdg2O/9KE3B3xunlGU3gAfocI6X87GS9WXj7RJpQsVUoYpjWGF1CBr+8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 577DB68CFE; Mon,  2 Jun 2025 07:00:31 +0200 (CEST)
Date: Mon, 2 Jun 2025 07:00:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	syzbot+c0dc46208750f063d0e0@syzkaller.appspotmail.com
Subject: Re: [PATCH] f2fs: Fix __write_node_folio() conversion
Message-ID: <20250602050030.GA21716@lst.de>
References: <20250601002709.4094344-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250601002709.4094344-1-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Jun 01, 2025 at 01:26:54AM +0100, Matthew Wilcox (Oracle) wrote:
> This conversion moved the folio_unlock() to inside __write_node_folio(),
> but missed one caller so we had a double-unlock on this path.

Looks good, thanks!

Reviewed-by: Christoph Hellwig <hch@lst.de>


