Return-Path: <linux-fsdevel+bounces-43800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D160BA5DE49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 14:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBBFA7A2265
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 13:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D2524A064;
	Wed, 12 Mar 2025 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nnPbfcl/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F039C42A82;
	Wed, 12 Mar 2025 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741787115; cv=none; b=oSG14+jwrjW/cgELILXJIlXbWrVwbxLBTjZ0zHAZ+FIEVKF9AZlhACfJJJj/IwwHApnAbejKuCY285GEuUI8nVidslVfd6lrwkLUuhn7f+pTUxQ9j9GxxQFHqaeZVirxgIB6/gddp+uV5fH2amIZrmgWdlsCXThLfNWQYzUAX0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741787115; c=relaxed/simple;
	bh=4HAhK6US9YpNBFYaYDKcncY7tvv/cqOdDvxd9JID8Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDxUuEjw800RYfrm0ngQLa/2vPaRt4uw1MvzNJfyxQ68J1vMpa0PyHAKubg+6wxq1UqYIfVAFWU0WUgjZ65RFcJMhh4FCz2j08UMb8Wt7DVRVB1xHXy2Cy9tMMJFCleOPuTANCTp7B+moZhlKUMbfJMcMxcUmzLqDOQPnE28ugk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nnPbfcl/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mIH+fIUpb4z14XLHnYSwL/PB/xBu/Oavn7NhiKaNRus=; b=nnPbfcl/JjzVTpEx8LURT5nSKQ
	k4uhb+XrcpQZD3Q3aE3nwvl8B/48TLJGDtzEvuIJW0n2ikKGtbNuu1Pp6erFa8sO42hDXcsaQcPmZ
	SSMZClF1BgjfoIygwpKflWJfZ3ObOK5gLUDb8kndMdBGD2QnXVbvqf37hQge2omBtE0Pn1uIfjjLP
	u0Zu6nDy73/7RKXiHwoQJ0hBNCcYrVeuvskDmT2Smwc2qtpEsVWxmbDRU0nOwk8WiA/O6u61W0DeB
	TJNvcbsU5cVAjTscbk6X9CmtSii24BCOwrvCMhNH+COZzwGVuqzjVxaOMYyNVvcTi0h9FF13dwTnO
	sum7AIbA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsMOW-00000008by9-0y8J;
	Wed, 12 Mar 2025 13:45:12 +0000
Date: Wed, 12 Mar 2025 06:45:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
	djwong@kernel.org, cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v5 09/10] xfs: Allow block allocator to take an alignment
 hint
Message-ID: <Z9GP6F_n2BR3XCn5@infradead.org>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-10-john.g.garry@oracle.com>
 <Z9E679YhzP6grfDV@infradead.org>
 <4d9499e3-4698-4d0c-b7bb-104023b29f3a@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d9499e3-4698-4d0c-b7bb-104023b29f3a@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Mar 12, 2025 at 08:05:14AM +0000, John Garry wrote:
> > Shouldn't we be doing this by default for any extent size hint
> > based allocations?
> 
> I'm not sure.
> 
> I think that currently users just expect extszhint to hint at the
> granularity only.
> 
> Maybe users don't require alignment and adding an alignment requirement just
> leads to more fragmentation.

But does it?  Once an extsize hint is set I'd expect that we keep
getting more allocation with it.  And keeping the aligned is the concept
of a buddy allocator which reduces fragmentation.  Because of that I
wonder why we aren't doing that by default.


