Return-Path: <linux-fsdevel+bounces-65670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F206DC0C348
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 08:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EF684F0BB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 07:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF1E2E54BC;
	Mon, 27 Oct 2025 07:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="huV3is2O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF1A2E283E;
	Mon, 27 Oct 2025 07:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761551697; cv=none; b=ZF+rQwBpUptdIWsujo3Xw5o9k1Pdthfxa2dHn7oFtJp5sgohJ7alXMF7G6/jlwyVBiFnEc2K8ESPa0IR9sSFf624cyZMkTl9qw4CbAeAsPZVQe68oZOueODPmyWwUDOPgaCnoIvTX/JYqf/BcOHlSObLwtcnf4PvuNuxN+iFjps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761551697; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPbWcL1gDqkD7OZ+jdsegqNGvAzaMY90b2/O9RZ4sTl4ah37c5Wng6pG247cfSylXMr9ih7cccfswX5kXSmI2LeyhZBUXoiSQB56TPp8ut4+TMC2i78xjVPPEaR4URyhQQa5Pa1tb0sa1DUMmlYJdbHDOkG83D+Q0iTIrbK1AHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=huV3is2O; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=huV3is2O0rvpgOVcbIqBzTZkfK
	WAzOStuQPcv9pwT2TzZfNYAHjivYSDy0TJ0o+j5vJot+PESEQy5IsiGovP9yNf+rSMymG3j5kQ9bf
	C15vFDAfW1F2pyUQ3G1IYshCkRVxkPdgckgR1JgpqUsh3QTU6Err3lgAHP3eSO9OjlBrKcF7t4Wwx
	p8TdssQsW5EZjvv9Gi6HC0sZ4lqoSdIh6/RywFGhuK03yTyrBVboRWeQtNqwagET/VlFRxggRXJKv
	v8cnq+N0/Be/zOmiypR3hWtvdQJ06AX+pY9XKT3U+DOwVCrfB/nwNIFzH2Kn7rJzy3AcZ8BeZeRtA
	6KUXkNzA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDI46-0000000DJFv-2P6J;
	Mon, 27 Oct 2025 07:54:54 +0000
Date: Mon, 27 Oct 2025 00:54:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 04/10] ext4: Use folio_next_pos()
Message-ID: <aP8lTs-NiC602Kia@infradead.org>
References: <20251024170822.1427218-1-willy@infradead.org>
 <20251024170822.1427218-5-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024170822.1427218-5-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


