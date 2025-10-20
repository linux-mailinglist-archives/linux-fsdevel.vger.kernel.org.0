Return-Path: <linux-fsdevel+bounces-64680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B5FBF0E6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 13:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F0718950DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 11:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8235F303C9C;
	Mon, 20 Oct 2025 11:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aBoqO3eD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B8F2F657A;
	Mon, 20 Oct 2025 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760960672; cv=none; b=suryNZep1+Islxiom0HHmny/Y4PdXfhFyKghHCKhOt0aoK7xvcezimJ/Lu3Qd98UvqcGNMuZeJ75oeSt1qloq7sVWpJ/07ac8QRM2/h66VzALtrepvXQSPIxb/tNHnpTo9WN1rqgyVFBBFTy3hvbrhVljnKP8jRDe+QxA4hJPsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760960672; c=relaxed/simple;
	bh=owWyHdvi0HS3t8JhNPcTnZRFuiIG9AN3CmEGyRxJJgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQBiEhslaHWriETlBruhndPp7PfDoTy2xh4mpr4vTO/fVCbq5xorbpOpRKc/4OdU8CAoyunqZiRP7yTlFhMGR2NhJZB4vr8A+pxSwPq8o1q6ZcTF9cm4Vz8FzViO3UVQ1RsZS7q784BUMWmxLARbIKavHGK0810RXZHrl3tEJ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aBoqO3eD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LlJHH7GKULBSEuT5LoQ4g/IkuhD4tO0XQl2oZHZZRe8=; b=aBoqO3eDFMGv0ZvvPfgSILWBQA
	a2owlrlvFh8FfnKwzbB+0hbDMZLVbAqyvhPHDse+jvjzWvWqjMvrkB9qKzd3RmSk8ukxNwZhWogLt
	At1lB/TwnABz3PiEKr/PoN4rBn5mRpRmtHsCFVFCJ6DJiGPKmrbGpovj14e5TfjxbXEx5pdjXPn85
	LqA5AxkX+KhhqjBLbZ7QY7y5yB4fp7xFCKPzfFMDKyjsgsHZgcRi3gA63Y67stlMthQG4ehJP6NpW
	diJ0mQ8Bk6AiOPEu3MeuWcmpYFCU5AzTS9TKDIVGbUzAeb26+9boNc4j3zHgmA0IN48ojhQLpzXqH
	1FhW135w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAoJP-0000000D6vc-2d9U;
	Mon, 20 Oct 2025 11:44:27 +0000
Date: Mon, 20 Oct 2025 04:44:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, djwong@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	martin.petersen@oracle.com, jack@suse.com
Subject: Re: O_DIRECT vs BLK_FEAT_STABLE_WRITES, was Re: [PATCH] btrfs: never
 trust the bio from direct IO
Message-ID: <aPYgm3ey4eiFB4_o@infradead.org>
References: <1ee861df6fbd8bf45ab42154f429a31819294352.1760951886.git.wqu@suse.com>
 <aPYIS5rDfXhNNDHP@infradead.org>
 <56o3re2wspflt32t6mrfg66dec4hneuixheroax2lmo2ilcgay@zehhm5yaupav>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56o3re2wspflt32t6mrfg66dec4hneuixheroax2lmo2ilcgay@zehhm5yaupav>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 20, 2025 at 01:16:39PM +0200, Jan Kara wrote:
> Hmm, this is an interesting twist in the problems with pinned pages - so
> far I was thinking about problems where pinned page cache page gets
> modified (e.g. through DIO or RDMA) and this causes checksum failures if
> it races with writeback. If I understand you right, now you are concerned
> about a situation where some page is used as a buffer for direct IO write
> / RDMA and it gets modified while the DMA is running which causes checksum
> mismatch?

Really all of the above.  Even worse this can also happen for reads,
e.g. when the parity or checksum is calculated in the user buffer.


> Writeprotecting the buffer before the DIO starts isn't that hard
> to do (although it has a non-trivial cost) but we don't have a mechanism to
> make sure the page cannot be writeably mapped while it is pinned (and
> avoiding that without introducing deadlocks would be *fun*).

Well, this goes back to the old idea of maybe bounce buffering in that
case?


