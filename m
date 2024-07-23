Return-Path: <linux-fsdevel+bounces-24137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C348993A1A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 15:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593CF283A23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 13:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4194E153598;
	Tue, 23 Jul 2024 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nlYrEs+C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A13D208A0;
	Tue, 23 Jul 2024 13:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721741831; cv=none; b=ZrH+Vw2O/Qc5up6BiRDsaBW0MLPti9MHHdNM6bWcicff0BPHd+U/oJdtztIZvmTR6v69VriMRKR5Y3lVuIE76bpEwXwcnBlWu3kN8HJxCPV8keBZXa3BUpo1TZt3Dy8UggFfg6LSaI+CkPEvfH+paqODTAf+5DAXtR3OhBmro30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721741831; c=relaxed/simple;
	bh=5t0Khf/IjSWvffPIkr/PEt4jzqjCx4H/OB6GTH3EtOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DU5UlF6Rm0DIb3RQin9EEDyLFEs34QOu4LNBUwBxyoBivqSU59d2eBu8Ry+yT387qlv2bCOVBWVXXXowp6FlY4x5BH2lOD5zVnKS/wtGvBScsByrJBuNwb30NmTlm3ZTSOVRCyirdK8t0ZTuZ1mLtOPd+IBaEHc/qKq7lYa5c0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nlYrEs+C; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=cQRHyNXL3w6huhz8TyiMZxjBFclafzptvvSA+EclITA=; b=nlYrEs+CwE5yOSVXh8sNf1Tey8
	g4FuX77+0cv7nVi6DJhB7mo3aIluINkKkpPDmOKZJtF2gVtcXx4EyruLqot5CnPgx8ClkO8NAl38I
	vk4ly1n/XTQ/xcgrclVU5KVi5g+Ld0zWFY3w0f8yig2YpsdeECGPBbcajHkeBk0wFSrz08f+Ez5xS
	D5xKE+IYVy0tdqTvH3QJPIkjwMvbt7/6Y2aM+naoqUjeFqSHENpKXEVBIFZcIasWsy2PsHgeP6Bgl
	ubj2B6Biye9mBU7oyBe6202b+0H+COUNZDWoOtrzW1IAT2BtlnTRyp4nOleGNjbe1pjVV7SAYG9E7
	njlPGo9g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWFhP-0000000CZQi-0A45;
	Tue, 23 Jul 2024 13:37:03 +0000
Date: Tue, 23 Jul 2024 06:37:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Youling Tang <youling.tang@linux.dev>
Cc: Christoph Hellwig <hch@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, tytso@mit.edu,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH 0/3] Add {init, exit}_sequence_fs() helper function
Message-ID: <Zp-x_zm7Jp1FBol5@infradead.org>
References: <20240711074859.366088-1-youling.tang@linux.dev>
 <Zo-XMrK6luarjfqZ@infradead.org>
 <b58e6f36-9a13-488a-85d2-913dd758f89b@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b58e6f36-9a13-488a-85d2-913dd758f89b@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 23, 2024 at 04:44:14PM +0800, Youling Tang wrote:
> Thanks for your suggestion,  I re-implemented it using section mode,
> and the new patch set [1] has been sent.

Nice!  I'll review it.


