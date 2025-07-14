Return-Path: <linux-fsdevel+bounces-54857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF9DB0408B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 15:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F02C16A5B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 13:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F1C253F05;
	Mon, 14 Jul 2025 13:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dA5RnhSL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8069F24A044;
	Mon, 14 Jul 2025 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501012; cv=none; b=jOjd2Pcv9dHGzymSoPogQtIGC//7S28WqP1xjyA3IolPezCn8sXVVgmbDBSKrzTpA7SebcTr5Wk8f0BfsN483GpHgcRQGQ01Q3dDB9T6z1u/Sna53iyBm6X8NQMgniIG3SBFYVSGI9QFaq+Keh6mTwqeeV9CWzCBIiblV1Jbjw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501012; c=relaxed/simple;
	bh=0TP3xid4HyfS/q5CALXUWBgaZa8LPhsdYQVwoFfdolw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFUgMByybp0+RUGghdtjcOktU93kS/9qHs49S+LxdcIYt3sC5ycgaP4jT+b9RwIIVTXppLd94+UbibqtZPOp3HlBFsvRBAsS7I4+jGiZ+wi070XUmB5EskVZlx/EnDdvNPhXq3TspZKEM32Of7gXsjDKjbww3VTfzSATBxIc4pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dA5RnhSL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=czBUTEEl6Gw7IKindFaK1YcrN9r3/Sl2wLQw5Z+YuxA=; b=dA5RnhSLE9i/TyJGauyHmbrzjm
	XHwuZNISLapnPrTzEaYzlCo4vNLbIiyd0Qn7t1sio3CAcDtB03q9U8ZJs8epBUgpElbPVUJtpAXnv
	pAgG06OCEC6WQ8ah+PCn1jgQDgfZt1KSRokWHaszem/ClKbqsmSSz/RmLdzwSqrt9MLs2UVfugDHF
	YYlffTVBkXAqYxG44GV3w/N2S1qR77BTMa3GgJmmMJCS0GOslBnjqci6Lbo//rcDXsraWiRZLW/SI
	jolCm5NOoNh92JYBMswQ5obvitiUQFX6GuupNDboKe+BFEBoM2MFNRF9tGJzueBY5FwPvwDQ3NkbB
	qTzY2ikA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubJZI-00000002MhE-43OO;
	Mon, 14 Jul 2025 13:50:08 +0000
Date: Mon, 14 Jul 2025 06:50:08 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <aHULEGt3d0niAz2e@infradead.org>
References: <20250714131713.GA8742@lst.de>
 <6c3e1c90-1d3d-4567-a392-85870226144f@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c3e1c90-1d3d-4567-a392-85870226144f@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jul 14, 2025 at 02:39:54PM +0100, John Garry wrote:
> On 14/07/2025 14:17, Christoph Hellwig wrote:
> > Hi all,
> > 
> > I'm currently trying to sort out the nvme atomics limits mess, and
> > between that, the lack of a atomic write command in nvme, and the
> > overall degrading quality of cheap consumer nvme devices I'm starting
> > to free really uneasy about XFS using hardware atomics by default without
> > an explicit opt-in, as broken atomics implementations will lead to
> > really subtle data corruption.
> > 
> > Is is just me, or would it be a good idea to require an explicit
> > opt-in to user hardware atomics?
> 
> But isn't this just an NVMe issue? I would assume that we would look at such
> an option in the NVMe driver (to opt in when we are concerned about the
> implementation), and not the FS. SCSI is ok AFAIK.

SCSI is a better standard, and modulo USB devices doesn't have as much
of an issue with cheap consumer devices.

But form the file system POV we've spent the last decade or so hardening
file systems against hardware failures, so now suddenly using such a
high risk feature automatically feels a bit odd.


