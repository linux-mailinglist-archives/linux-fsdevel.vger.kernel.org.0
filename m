Return-Path: <linux-fsdevel+bounces-39378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AF3A1329C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 06:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A60017A03D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 05:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D425614B087;
	Thu, 16 Jan 2025 05:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CBbuZ/vF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D894C85
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 05:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737005486; cv=none; b=AFlnvo6/T4inLh0D93VAtRxk8btfBYNnMSHd6mPs2LEeHzNv9MFKAB+DKIz5xxwf3ZRwiCV668RZ+w5BGeFNVm16q8ATCjrXZm8pranXBDPutrOYAwiQ8QN6AYQPQQ23VDqIcki1+zBVP/dmKbJq1SdA2JjYS3Sxh4XX49DwHHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737005486; c=relaxed/simple;
	bh=qhfUJarLBjp/Ix4B3Mt6G2NOxpfsp+UVYVv6kdiNXqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VD9vf0CM06pRGcprhWZ3y++FdDDj+lHEMq7SzMM35oFYi4U82DGhaFblG3K5KQKIf7qL7pQY7B2iC9rQlbx74O01Y7TDtm8y6jxcI1fRSbv4NSpMlsGJdYV+00zBcUPYDTaEcGswAt63v+xurLhzS+TZWB8dfeK1ZvbrTQNEYaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CBbuZ/vF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qhfUJarLBjp/Ix4B3Mt6G2NOxpfsp+UVYVv6kdiNXqs=; b=CBbuZ/vFYBSt+mEC0dO9uNUlId
	FnsepPjHcW4VhHEL3HXSNUa1wUnZOMqEjMSneAukScemxdbzkKg1XHvXgEiHsR5GsJUiFBsCx+zQO
	oJcmK+Ap/a055V3HiXV2iMfmANOHbMzSki6zXcFkag6BZJS0pqGSrIm83tNw2bF1zl9O8wPiYescO
	VMTlpad/VBSRABiAILqWQWNEfzIJCizzavR6YnhXvyv6Zb4ZcY5C6vu2mBzX0sCdbNNGK5QjeV40l
	U9q9VgaQB+PXtTu9rPiAtFii9F0P6477O34e0XtNJIpqATcB8iEIBOrcBxmkf/4rapPx8E7xg0VG6
	unUHuPmQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYITT-0000000DswE-2ysO;
	Thu, 16 Jan 2025 05:31:23 +0000
Date: Wed, 15 Jan 2025 21:31:23 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Shyam Prasad N <nspmangalore@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mm@kvack.org,
	brauner@kernel.org, Matthew Wilcox <willy@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@redhat.com>, Steve French <smfrench@gmail.com>,
	trondmy@kernel.org, Shyam Prasad N <sprasad@microsoft.com>
Subject: Re: [LSF/MM/BPF TOPIC] Predictive readahead of dentries
Message-ID: <Z4iZq4P0wFyHB180@infradead.org>
References: <CANT5p=rxLH-D9qSoOWgjYeD87uahmZJMwXp8uNKW66mbv8hmDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANT5p=rxLH-D9qSoOWgjYeD87uahmZJMwXp8uNKW66mbv8hmDg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Why don't you implement a prototype and post the results?

Weirdly enough every year people come out of the woods more or (usually)
less interesting totally handwavy ideas just before LSF/MM and spam
the lists with their philosophy.

Put your effort where your mouth is and give it a try and if it's useful
send patches.

