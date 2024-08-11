Return-Path: <linux-fsdevel+bounces-25602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2449F94E08E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Aug 2024 10:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57A7C1C20DAB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Aug 2024 08:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1514E2AE8A;
	Sun, 11 Aug 2024 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f3idcTy9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE32B1C6B4;
	Sun, 11 Aug 2024 08:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723365645; cv=none; b=n6a2NK+Ar4EHgHklvVf6RJW7bTAxs8fGJxav8+SI0ql2p5EiFp/qdRDZWA6CQdZPJty4DYNBjOPgaeIH2OIdJYClz5niftHTh5+5MDCLXgc2EX6Grhy56QeyJ5EPPNLseWOD0021jiEI/pgyKJhMPc8q8J4XUsLDEiJyKBWKPp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723365645; c=relaxed/simple;
	bh=QGRthnBNsgCX/rkj3qykOd7gYtY7zS7dzixUi3MlraQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0N4N9zPS+GakGc4+sjTJNiZf59aE4hAWMr0tyf52x8xaqb1cVPeGyY2sG7B7sjBDRl62ggFvQ50VzqnGGxa6UDkzERxMzTThQ7/m4F0erECkdZzoz/gMnbFzgWgAliDCOloyFvrzS7yJdw3bfEeH8k0T5saW5uTTj5FnKgZOf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f3idcTy9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=71zU2uGJ4cUNvQCtzWFrbGZ/Likl9IFnr0YoQDE5/A0=; b=f3idcTy9GMwu15N+xuOuUh4S6W
	S0b9cRcmYKA775FTbfhBWZ16IEDY7tnBV8gyjiXlh1cis3rLXxetwiski5I9uuxwAvdJHAp2n8anO
	A3SqVb9xJ/cr/GuwpHl5Gob4FQi53ixRONFWx5R6MbVmDQGUGtEo1KilB4ddxKtxCn1Mf1jwONL/R
	+7xvHCvFNVHlad29mfAfWkWGGkAv8GjR2HUIBNcAT189z/XJnc3vjjUwR0JYDUfkTclju0FbHRx1t
	yifWdRk6N9LCspg+7BjPwP292WNUUPJ63YNcV2L1ivCS2JLqndAriLnU+leCAmzJ2LdRxlWZP+0wt
	oxujEc/Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sd47x-0000000FJjt-2tkU;
	Sun, 11 Aug 2024 08:40:37 +0000
Date: Sun, 11 Aug 2024 01:40:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v3 16/16] xfs: add pre-content fsnotify hook for write
 faults
Message-ID: <Zrh5BS3I1yuOHXuY@infradead.org>
References: <cover.1723228772.git.josef@toxicpanda.com>
 <89eb3a19d19c9b4bc19b6edbc708a8a33a911516.1723228772.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89eb3a19d19c9b4bc19b6edbc708a8a33a911516.1723228772.git.josef@toxicpanda.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Aug 09, 2024 at 02:44:24PM -0400, Josef Bacik wrote:
> -	if (write_fault)
> -		return xfs_write_fault(vmf, order);
> +	if (write_fault) {
> +		vm_fault_t ret = filemap_maybe_emit_fsnotify_event(vmf);
> +		if (unlikely(ret))
> +			return ret;
> +		xfs_write_fault(vmf, order);

This now loses the return value from xfs_write_fault and falls through
to actually do the read fault as well.  I somehow doubt this can work
at all as-is.

Please also move the filemap_maybe_emit_fsnotify_event call into
xfs_write_fault to keep the write fault handling isolated there,
which is the reason that it exists.


