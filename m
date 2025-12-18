Return-Path: <linux-fsdevel+bounces-71612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC40CCA4F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 06:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60097302D92E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 05:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AC53081B0;
	Thu, 18 Dec 2025 05:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NRk/Wsuo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B92306D36;
	Thu, 18 Dec 2025 05:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766035381; cv=none; b=u487GDHEDIEpUT9fGvZMlE2COJlWRf95P5bo31nZyodQ0YUFn2WD5BqVKuqzpLVRJ6qv4/kIvVWSHv9gOmUiKOR25IInMj1bRGaTtdtrkgqFDfg1zd0Hq4ofimk8zwIkrMiWFvA/7WjbKDl9Qd4Kp+6wNAAxF7Yg+jZpNVI2rbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766035381; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbqA/so9ewVhdFju4TO/+ht2X7On4fx2vlqI7nT89382AaWJxrtrlmIlEsrDUZkWvZN63/wbWfxhuVEKndFAKOt7WNuNzFYymZduLw9JAe4CGt/BcqIWcU9i9hdQurFp6XjvozVE07/ns6kVVF4VwdvH2uvp5qprnpIRDiSXzqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NRk/Wsuo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=NRk/WsuoVhvj1LmcJUvYis3c7i
	6FpdWWEepDfrQqpFSppq8ROjQT6KlO7wgkOj/ojBExvaZYQML5wCAY0loz+uuuSnfRN0oQwOs1AoF
	lrJIi5SIchAWRGjo5pVOdCq6RKShbD8iKDlJaiOdI5nKTkfw55WFECcHrdcRGJ9LytyCdd3rKY8R/
	8Q4oFvqBIbpZ1Zg++1nvbILp2XVZL4ZaX19b7uibfCcmWRemqiw1l/z8VzDvi3Nhc+19ZaLGph5An
	+PfEbkiOJuGYBtRIHJydfwTtb3G8EPfQBXW5anQYkT9lvY25RkiKGN3olgswSRX4xl+oTtzag3+C5
	Oct7gRIw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW6Tb-00000007q1W-3Yby;
	Thu, 18 Dec 2025 05:22:59 +0000
Date: Wed, 17 Dec 2025 21:22:59 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, linux-ext4@vger.kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	gabriel@krisman.be, amir73il@gmail.com
Subject: Re: [PATCH 4/6] xfs: report fs metadata errors via fsnotify
Message-ID: <aUOPsxEH3xU-7DKy@infradead.org>
References: <176602332085.686273.7564676516217176769.stgit@frogsfrogsfrogs>
 <176602332214.686273.889498283534575167.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176602332214.686273.889498283534575167.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


