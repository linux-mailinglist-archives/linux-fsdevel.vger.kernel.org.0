Return-Path: <linux-fsdevel+bounces-65667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DCAC0C336
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 08:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF4E3A60C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 07:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1EC2E0B5A;
	Mon, 27 Oct 2025 07:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i3vpkTc1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B17B2571DA;
	Mon, 27 Oct 2025 07:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761551639; cv=none; b=SLHD46mXa9Iy3CeJklPjjH3/88eZMpfRo4oXC9nopAhyq8al+frRJelWxeXgrP/rRRp6ufogPcu7Rn4MPEKrs59ZPc1dRRy33fEgVBMYOUF2/mUko33nJ8z4+CG+QTKnti7V+MHx0ARgHXQwcZwsj/ywqinvEikL1TsKT6m14p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761551639; c=relaxed/simple;
	bh=iJjRK8xbcUCiThr2DdEzsXdZJTU3s9bLInXQpuNHCpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgDXAziBJp1tmjLh5HBxaOBpGlqFMPByKD/c2+57Njx/ARzCOEk+iqonZ0NQOHrWfv0pVnQuH4EIyweKYcsKfP5gpMVaBetY/YhbzB3RsaAYqqCrh1IuusizwzLmsHOzR9MIJsB9FRzcSD6H42yvN3n6HSPVJ7zemZa58tLFiww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i3vpkTc1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iJjRK8xbcUCiThr2DdEzsXdZJTU3s9bLInXQpuNHCpc=; b=i3vpkTc1EdmvdCq2PlEvvMSrCZ
	t+4YkHRESjpcF4LLQgqYZE3BRixVBP5gMYL53XIHZAHsay7tVJGzVZG0iwwdXCOSgQFRgfqczGmxm
	NQw35mlGRfmlSpzAZ75sFfT8Sqw762SnnSEG9FwyHM8L0xOvFZQQVYtoAJVKLMwaVBpM1Dg8mCMOh
	japwoHDITkH/8WQ8rDr1fI5xqi/nU9ttoBdasHXggUTUpHosZvkfRLz7MpLX4k7hzS8Dkp6LQ9Udq
	ced3F6u7SAAhgRM415UnZqKSxDDTH6qXicScoFFE5h4g/Ue5R+Hd8VcjehgBZnL/lSH21j4arAJ0B
	xiO7TGQg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDI3A-0000000DJ6Y-1SOf;
	Mon, 27 Oct 2025 07:53:56 +0000
Date: Mon, 27 Oct 2025 00:53:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	ocfs2-devel@lists.linux.dev
Subject: Re: [PATCH 01/10] filemap: Add folio_next_pos()
Message-ID: <aP8lFER23GG3LeTw@infradead.org>
References: <20251024170822.1427218-1-willy@infradead.org>
 <20251024170822.1427218-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024170822.1427218-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 24, 2025 at 06:08:09PM +0100, Matthew Wilcox (Oracle) wrote:
> Replace the open-coded implementation in ocfs2 (which loses the top
> 32 bits on 32-bit architectures) with a helper in pagemap.h.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


