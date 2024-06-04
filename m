Return-Path: <linux-fsdevel+bounces-20888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 524AB8FA915
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 06:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8A61F265AE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 04:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6014813D88B;
	Tue,  4 Jun 2024 04:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nambwvGB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D81338B;
	Tue,  4 Jun 2024 04:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717474270; cv=none; b=sENFGZXywzYUIlsIYrMbzqSdNkl59AHhCUKBi75vffPuarohpkuehDNB6jrsZ4YyBttHWdFUPMeQVOCpRcNyolQqIzrz87qs6u9sbT0z1uT6IRAL4Mt2rSBCQdvNSpxmd4fpdCqrpBiuwKuwSB1TuzVZcUQNQ0Yoev39XkrRwL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717474270; c=relaxed/simple;
	bh=V2WZCFPqnAunVFFrco1WSI82L9F8sakAZbs4jtJMAoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRCdrQW6cbZ+0boYHVpYXhCMCGatAhZ+kw9XJn+dalmqPBsZUB9upRvCI+8Dw0Rm5Egu6WJYTMbGR6euc2kHWxtLbgnKBuJRxaqY32W7XQu1gVF+phEY42YAIje/zwaEcSJyVbWFGCPu2xKaRbFuK1HFTmRr2gIsDqt9sZdQoUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nambwvGB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DH6ViuO+t06Pd2BFIzJBr9k1OdXpqwO26RV8UaMPTvw=; b=nambwvGB3x02/JV681L1MOlYSH
	BbCbys+zE8uw8nVgqtgYC6/cZJDO2q50KRD79hGcocDZY2CpdNZUn5iuAEbnIs5LBkvZXzBoW3oOY
	lPuI04PHV8BR8Lz6qqRZW4q4TkfsCW196uZdzVRTBcBLVLfUJxmEClrfo53zyQoiUIm2nQB+0jedx
	bvd5ZQ9FW7B++uhnjgeFtMutxafN1UcChV0Tgk1JEQHYQTcRmHz1UqRs8F8t0wIttByVObjjginov
	GkZgBv7QHCCjgrpupx1m609pCu6J0FLNgtGmUFSz42vYE28DrlXmxgXAEyJx9TpJBi0WJCd2L/DKI
	WAcrWjFw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sELVt-000000018yk-0SSc;
	Tue, 04 Jun 2024 04:11:09 +0000
Date: Mon, 3 Jun 2024 21:11:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: linux-xfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCHv2 0/2] iomap: Optimize read_folio
Message-ID: <Zl6T3Ymqnw8JTHiX@infradead.org>
References: <cover.1715067055.git.ritesh.list@gmail.com>
 <878qzlmtsm.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qzlmtsm.fsf@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 04, 2024 at 06:02:41AM +0530, Ritesh Harjani wrote:
> > Ritesh Harjani (IBM) (2):
> >   iomap: Fix iomap_adjust_read_range for plen calculation
> >   iomap: Optimize iomap_read_folio
> 
> Hi Christian, 
> 
> I guess these 2 patches are not picked yet into the tree? In case if
> these are missed could you please pick them up for inclusion?

The first one sounds like a 6.10 candidate, the other ones is probably
6.11 material at this point.


