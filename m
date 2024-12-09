Return-Path: <linux-fsdevel+bounces-36830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 066309E9A0F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 16:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1BA1889308
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 15:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFEA1B425D;
	Mon,  9 Dec 2024 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hbw5TsxK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE5A1B4245
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756840; cv=none; b=aBJuqadLn2FqmCTDR1mCplYoEUqmp8P3wV1JS66wHgoUizYMgHzLnKteyKek7S00IWhx9qvE7VTzoi4rO1bNrXe2Ll/wjKN+U+oKZchddm54a2/4AZL5StwlmpLDwtpGTI2+KtO8IppW4tjPl/FGcwLMt9BtPe+jw7FJifNXeic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756840; c=relaxed/simple;
	bh=nSGs1g/NCpq1KbnDsKyJgJc99WN3P2Cb5E37f+M4j2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfgtboK1GzxacwcK2jxXwspAaWbTLDTncsCMWY80HDl2DfbfjX/fPS/mYo8LH3xfb36rFCL1uhm4iLz+BzQWA6QRdMMsYbb+os++jOW/tf5lAYALjhMIspWCgPzDMAoIXwXrpuAZJYM/SSxigtU3vel0AljEUkUjb+yUVfA4SL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Hbw5TsxK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fnLB7SDpey7vS7P8nj96omhRADKCgFfNwIQ3YS0Ir/k=; b=Hbw5TsxKO1LpzOQtWTcrcWyWyk
	VHNCUHsW/mX6H4kGEQCND6XCcLFJD4lnSF+6CVJ7sJXM1o2nTU2uJxANxe3JfYnA9vWCcVqYao5Ya
	ODLlQmCnh86hhJp6YBGppirIRE0isSxRjz8N1v9VLCO+UH2LGZw+M0myoig8XdYNkHNzXW6S1rpGx
	Wm3EA0lvgPVsWr9mbHmppHJwB5BqJAt8p3f0ngTE9sIDJEmPPKwVJLOwoqIQY+SPlwh2954sekihs
	uAyHtUZ14szRdNrrTePg4+rcfcskPA9GBMCqP+vWZKq+ZR9rT+vVTOh5W0yj/qSuaX360vSaZwBYu
	4snsQlvA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKfLx-00000008KQU-2cyD;
	Mon, 09 Dec 2024 15:07:17 +0000
Date: Mon, 9 Dec 2024 07:07:17 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, cel@kernel.org,
	Zorro Lang <zlang@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fstests: disable generic duperemove tests for NFS and
 others
Message-ID: <Z1cHpXAS0S8R6_g4@infradead.org>
References: <20241208180718.930987-1-cel@kernel.org>
 <Z1b1d3AXTxNhunYj@infradead.org>
 <6dc5c09f-e1a2-4296-93d7-b2cda471a73f@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dc5c09f-e1a2-4296-93d7-b2cda471a73f@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Dec 09, 2024 at 10:00:58AM -0500, Chuck Lever wrote:
> 2. How to disable this test on filesystems (like NFS) where duperemove
> is not supported or where the test is not meaningful. The current check
> for the presence of the duperemove executable is IMO inadequate.

I've not looked at dupremove, but the name suggested it's de-duplicating
and thus needs a working FIDEDUPERANGE ioctl.  So the test should check
for that using the _require_test_dedupe / _require_scratch_dedupe
helpers. generic/{559,560,561} do that, so something either in these
helpers is probably broken given that NFS rejects remap_file_range
with REMAP_FILE_DEDUP, although a bit of tracing would be useful if
there actually is something broken in NFS or the VFS.

