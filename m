Return-Path: <linux-fsdevel+bounces-62797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B71EABA1174
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 20:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C931C21FB9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 18:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC3731B11F;
	Thu, 25 Sep 2025 18:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IA3S1Gxu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B1531A544
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 18:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758826544; cv=none; b=XJ6RQVmpjHkF1+72SUXL7tTfiYkoeCKYOKd2g3cBotNqed21+KvK649/68+Mj2fDUnlVbihQiHalu9A0ZEH6PjwXUJRr23GHzNk7DEefHj7qXn/3OGe+dPR3dUaoCfRZ496asMddViM3ebdO+jT7bJbjV7vLgK1qPl8L6ex3l+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758826544; c=relaxed/simple;
	bh=x7ygrI33kIAzoBAo55q0Aa5oENsdcjKJIJkw1CzXsQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrVEU8CHqd22mzFTjRPmbjpi/tXIXkpfqJ3x4qFsD3k8KpNCk+tcIS0RVQ5T3sSwxioml0ML+Mf3gaoaENkOBzKVpTFJefyjlv8AdUHLV93yZ/BzkzOywFGEFQsab+X74IPZVglGgdb6rrEAZqXGDQ6wmQYWpAVKz3QDQDI1Ynw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IA3S1Gxu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758826541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tMONzo2AhO5H0XYthMIALnHr8kJUEuRK/ZwZjgdlpeQ=;
	b=IA3S1GxuaMugUDo7X1DRDtQsAANRyvwftgznCzKeNkkdpkgSkjbWgV/JqCIS+CNQpLtEoR
	1L7Ui/6dp1bL5FA7XauKN6XdA7Og7SYeJzNN7HsrdQUPDOmrL9NEtAa7pbFYYqynD9GZfD
	1+C1B0Mpq3bXcNp+yjwXcoI0SKh3xY0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-S84nCjDdP6O1k0a0wG0M8w-1; Thu,
 25 Sep 2025 14:55:36 -0400
X-MC-Unique: S84nCjDdP6O1k0a0wG0M8w-1
X-Mimecast-MFC-AGG-ID: S84nCjDdP6O1k0a0wG0M8w_1758826534
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 677C71956086;
	Thu, 25 Sep 2025 18:55:34 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.134])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28E9430002D1;
	Thu, 25 Sep 2025 18:55:32 +0000 (UTC)
Date: Thu, 25 Sep 2025 14:59:42 -0400
From: Brian Foster <bfoster@redhat.com>
To: alexjlzheng@gmail.com
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org,
	kernel@pankajraghav.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH v5 1/4] iomap: make sure iomap_adjust_read_range() are
 aligned with block_size
Message-ID: <aNWRHkLos9bM8a_8@bfoster>
References: <20250923042158.1196568-1-alexjlzheng@tencent.com>
 <20250923042158.1196568-2-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923042158.1196568-2-alexjlzheng@tencent.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Sep 23, 2025 at 12:21:55PM +0800, alexjlzheng@gmail.com wrote:
> From: Jinliang Zheng <alexjlzheng@tencent.com>
> 
> iomap_folio_state marks the uptodate state in units of block_size, so
> it is better to check that pos and length are aligned with block_size.
> 
> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> ---
>  fs/iomap/buffered-io.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index fd827398afd2..ee1b2cd8a4b4 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -234,6 +234,9 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
>  	unsigned first = poff >> block_bits;
>  	unsigned last = (poff + plen - 1) >> block_bits;
>  
> +	WARN_ON_ONCE(*pos & (block_size - 1));
> +	WARN_ON_ONCE(length & (block_size - 1));
> +

I thought Joanne's patch [1] enhanced this function to deal with this
sort of corner case. Is this necessary if we go that route or am I
missing something?

Brian

[1] https://lore.kernel.org/linux-fsdevel/20250922180042.1775241-1-joannelkoong@gmail.com/

>  	/*
>  	 * If the block size is smaller than the page size, we need to check the
>  	 * per-block uptodate status and adjust the offset and length if needed
> -- 
> 2.49.0
> 
> 


