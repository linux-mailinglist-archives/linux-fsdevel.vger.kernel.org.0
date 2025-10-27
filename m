Return-Path: <linux-fsdevel+bounces-65668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB906C0C33C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 08:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D0A1897FD8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 07:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A272749D6;
	Mon, 27 Oct 2025 07:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t/gXiQku"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA432571DA
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 07:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761551655; cv=none; b=Snv+qUlThSydrnIas5B1sK6o4/Ay/wvO6rXsTnDxmDOINP67SUqBEby3jWrTNEx+L8TGdjgs7agce5GoSygfQlqXvnhwDDGMFaCm6lU9PD+LxhefECGNgxVmdb93chTeBIrPiZYXeTrDG8r+ROd81cq2yRL9gm4MyASrg0TDxrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761551655; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrZVI+URxiMYvbiEN0ICDv86qmWWN0O5wJfI3Bsi602B4k0SkaI/jR/Mx3IfHoVdbopls3BnOvPN3mz9eDl55EeXhiAAhBCmQgw098j1OV2aJHzWG7+bv4I/2Kxd+Odzg8TMZ8weutnNaGbGOJJc8dDXZlSFOk0yLhgEd+oBAy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t/gXiQku; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=t/gXiQkuTnG2yI2p4BkN1b6Xb5
	QOBArQBoWxCuyT00CDyXXgpr+/NYSJU1KQfW5oOPidw/5wHPCux13N3o8X587nKyYiqMdIrDckBjh
	dkHM63tNXsr+OWIPMhHpz3wcSiKILtNiBBlKYE0HaZnsHZMPwLhs+gJfd6E0JiJ1Jj8qgpHCjHtE2
	iwPslEif7tXXuSH++a8LlLGFVSxh5WG2uqDNaxB53GWpkfZDhvo2mkRBadZwedKa1kemmqHwh7KaA
	NIlRZ5aYTW4urgg1AKRGpZuZ1nKtoeU8eDjg2msPepaghibGuiv61uB/n0bnskEJm769mFwum3OXy
	w4U55lAQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDI3R-0000000DJ7k-3SXo;
	Mon, 27 Oct 2025 07:54:13 +0000
Date: Mon, 27 Oct 2025 00:54:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH 10/10] mm: Use folio_next_pos()
Message-ID: <aP8lJYc3olHusUTr@infradead.org>
References: <20251024170822.1427218-1-willy@infradead.org>
 <20251024170822.1427218-11-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024170822.1427218-11-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


