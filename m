Return-Path: <linux-fsdevel+bounces-27351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2FC9607F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 12:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4221F23708
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 10:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B5C19EEB4;
	Tue, 27 Aug 2024 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SJKaibT9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5A019DF41;
	Tue, 27 Aug 2024 10:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724756122; cv=none; b=q8zJc9YcVLCMwM3ZAG5d/We+SMKvGva8DH4XNzosRnhgXdRGpru8VKb3UJwY/j6tOYhtZjr0kaIbyYJNPJbU8p3vD5yn7qAmqi8lUp+RQ7axDMuoC8A7yUzFIUArCtOMacAVbegLHFq3z0kLxMhGC2/+DPf59/4Wjwg5v+Q0V2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724756122; c=relaxed/simple;
	bh=2vqRct/Gg256TtLZ/5pgEPsyMRIswT2dNlShMlCCR5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIC2bS+oonV5u84XkTm2Kweofp2OP8349Zt78Jwop7PsKYCZFZBvHGejnCQBswuEYiY3egOkXbZNSQGB8ke9gGfRYzsKYAkQaBSNweDK/ba8CK1jOofoKe2apB+N1cw85pHhgbBSHiJOtfwPKFqV+Isxp9259btKMtwp/pwVmfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SJKaibT9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lhoagkGPhyqsMlw9HBpSCGiPaLXUsfqV3Ui9Yt4l4sY=; b=SJKaibT9ZP6OIbuFW5KInaSsJf
	E53DtS4muhCrJdLAh3tl1KJd4xZMEAE36xfcwe8boZ/z5qs6iZnDq438k3fHqLSFxCjqVBR5GoU0L
	hSz6Skl2+kcnVXldCHSdbzs2Cky64patPUR6toZojwhIbrUBDkcBRiSqCZAkQgLN8k3dxMXC39VFc
	BpPp6bKE2oR2qxdaU8mofKa8Fe9dFdyM6WBTg0YQ+hoXI+erSSuXpZHSlTKe38/YFqo7LHvgAFGZd
	jv+/SGWgS0tP9hz7MhWBIv+vNslDF0ed7nU3iqNCaAdNlfMnMIFmsP4nzRej6nuGW+nfLvL4Ey2AY
	nZgBjydg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sitr5-0000000AtVx-3nZw;
	Tue, 27 Aug 2024 10:55:19 +0000
Date: Tue, 27 Aug 2024 03:55:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-block@vger.kernel.org,
	dlemoal@kernel.org, djwong@kernel.org, brauner@kernel.org
Subject: Re: [PATCH][RFC] iomap: add a private argument for
 iomap_file_buffered_write
Message-ID: <Zs2wl4u72hxRq_VU@infradead.org>
References: <7f55c7c32275004ba00cddf862d970e6e633f750.1724755651.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f55c7c32275004ba00cddf862d970e6e633f750.1724755651.git.josef@toxicpanda.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Aug 27, 2024 at 06:51:36AM -0400, Josef Bacik wrote:
> In order to switch fuse over to using iomap for buffered writes we need
> to be able to have the struct file for the original write, in case we
> have to read in the page to make it uptodate.  Handle this by using the
> existing private field in the iomap_iter, and add the argument to
> iomap_file_buffered_write.  This will allow us to pass the file in
> through the iomap buffered write path, and is flexible for any other
> file systems needs.

No, we need my version of this :)

http://git.infradead.org/?p=users/hch/xfs.git;a=commitdiff;h=84e044c2d18b2ba8ca6b8001d7cec54d3c972e89

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>


