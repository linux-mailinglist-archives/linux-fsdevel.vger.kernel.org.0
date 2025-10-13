Return-Path: <linux-fsdevel+bounces-63893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD347BD14D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 05:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FCC74EB731
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 03:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D4026B971;
	Mon, 13 Oct 2025 03:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nASwXKni"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3FE1A9F9B
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 03:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760324447; cv=none; b=nSkJpsQ8fEfdfFF80/CmCDgqaVIpcw8l0bXe5x3q9HG1z3ypYsvIMm5zsN1Ee9F7Q7SQecJnLfzSvzwiRwGfNl09XNgaOJRwxqzh1Dgm5SXVJrnDoqHJs+ZtDDBLL65zkuJwPADexhUlZCsK9eHnXBoKCGZ9qjZybQGlq1uKYM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760324447; c=relaxed/simple;
	bh=f2EBs3im/Sonf7dZ7kV6JHjBMb4FAlyDHGoLEfS0knA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shjUYQ9KtNmQ/5I9Xxs811lxJcogleIJOHvNrkY87FAl1ZPNirvSlyikJMtXRIX27U2s0nnYQGuc07kiRy3C1SfMWMLIRJ5rGsmBJ2yg+DsB21v0OsEz3knYwNhFQwm7fHbN9CCUFRLj121qM9OxuFcevxjTPpeo7PCANsAmspA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nASwXKni; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tSBKBgKVDAYxyaRZybZnebr0CnrIujPAPvGqRph2jsE=; b=nASwXKnimt600Y0t5QY345PlL3
	i1Nryc6lyMIEGQWVCkKbltJ6Xv0SL55xYVkpuNOxa/jJitY74M8Fb9ba0/QNzv8Rt4GgAL1avpW6U
	7kuF0PBqK6i0TQ2C7Dg7uXhYFySSUB8Vlc1JRLw/SfPqwZsvBjAXwBkA7ynCJWQspmG5V4Yz4TIoK
	jBCGT/yJxrPcWFgBOMDbjsgHvmWIocj/tvYorhWzKLvNH30Urd1AsqYkj6Js4dQH0jl9j4f6V2mq5
	/F0dx++pWv4hePewcQxijgUEg7y4cd2ClybCHUsxFTRfQju80pNBpqDFj5+0eo/aYoHEt+ckYJUi7
	pLewu4Fw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v88nl-0000000C8qc-1zAQ;
	Mon, 13 Oct 2025 03:00:45 +0000
Date: Sun, 12 Oct 2025 20:00:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org,
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v1 1/9] iomap: account for unaligned end offsets when
 truncating read range
Message-ID: <aOxrXWkq8iwU5ns_@infradead.org>
References: <20251009225611.3744728-1-joannelkoong@gmail.com>
 <20251009225611.3744728-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009225611.3744728-2-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 09, 2025 at 03:56:03PM -0700, Joanne Koong wrote:
> The end position to start truncating from may be at an offset into a
> block, which under the current logic would result in overtruncation.
> 
> Adjust the calculation to account for unaligned end offsets.

Should this get a fixes tag?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

