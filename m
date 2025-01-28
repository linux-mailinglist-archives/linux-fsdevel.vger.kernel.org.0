Return-Path: <linux-fsdevel+bounces-40199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B756AA20410
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 06:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3423A688E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 05:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EC81C3BE7;
	Tue, 28 Jan 2025 05:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wyXeP1Jg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC5F42A92;
	Tue, 28 Jan 2025 05:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738042743; cv=none; b=o3VkVr5aEBOlAZyy2kiMUeVeVGndvzjN/2dKWcm/aDcTPWSksdLstoS5IhHR9aNSCWmoz5krz5lDjYNPAoNMczPY8hMHva7Wnr6nZ/s6EVoek48AzfqMHs16wuRL2tke+xKt3ucsHhZZ7DsTIqFyIfZq8z6B/FZE8M43xiQKV6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738042743; c=relaxed/simple;
	bh=18nj9d48WMCi0d1vq/eZDF25aVHWA54z++aOHdpvwkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGwdT1fIVIHrlBFauhRYg54XKOM6kckM90K2diy0NLEyATfd04Wws+8MgIKWA8/afVeN2moLznGhjqf0m//WyvskcRedEXTFxhUfmKh+8geuAYcPjN0uLvOAEp0RtrQKygG8GZk7oJ6jsgBL31fYMHAA4Zttm+km7wm0ThEc/Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wyXeP1Jg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9AIkOdZzcl0McqhRzzbqVepoF/qn6fcxfObuIiC5F1w=; b=wyXeP1JgluGob64mc4QJ0j4AmL
	L/Kxy7ilkDBEIjnRZ4jAUfyt6bUEDEC7wYf/CwqepVrc6gH85b3NEL86ED1JUr27xXVDZz6scQy3P
	aHQNmhWDH/QTGPMKaOKCK2Wpmnvy0NJwoeIiB5Wu4KlcyMY23AtSq9ZerKE9K9L/C5QX0wgqjmqUa
	tjr+5Fb2kBqu2qkRCLc0tZTQXe9wXUA6Sg7HisZtI9qgwuCx/KYQLSrK6Y+9EB2qLmC8kP7rAt8pS
	/wMKOs6ouFoFL04vVEpJ7+s0qflDpMNmeROVWOIp3M00y1fLWRnKeL+0TPBe3jApmDO1uENFcjKSA
	6deKBoIQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tceJS-00000004Arg-02KH;
	Tue, 28 Jan 2025 05:39:02 +0000
Date: Mon, 27 Jan 2025 21:39:01 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 6/7] iomap: advance the iter directly on unshare range
Message-ID: <Z5htdTPrS58_QKsc@infradead.org>
References: <20250122133434.535192-1-bfoster@redhat.com>
 <20250122133434.535192-7-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122133434.535192-7-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jan 22, 2025 at 08:34:33AM -0500, Brian Foster wrote:
> +	size_t bytes = iomap_length(iter);

> +		bytes = min_t(u64, SIZE_MAX, bytes);

bytes needs to be a u64 for the min logic to work on 32-bit systems.

