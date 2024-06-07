Return-Path: <linux-fsdevel+bounces-21161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB168FFB09
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 06:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E571F266A0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 04:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CDD155344;
	Fri,  7 Jun 2024 04:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ytg5WFU7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD877345D
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 04:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717735804; cv=none; b=Jr/nmTMvAzFuhsxpBmpje0FTZ9qgYNsPYP4oTXUDxJJnFHbKC27DQGBZB4b1eecMGsuESBld92jDz3+/0VFZlzJin0NZ0A8vGyh4wYpVlNLy9RqlWN8AZ2+H/0CF8mcQeXvKUh3hb0lof3wrRqddzDamM3qwb4OQnZxUjlj3zUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717735804; c=relaxed/simple;
	bh=1OMwRxgwj+2Lw2MVW9xikQESYYRalRbmuAOI6SNrrD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4wsrjbp8Cwc+ZBZyST3/yN17Kk5nqplZGXy5jMJb1MHibnJdrZZmrjZvMZCZTiHk++14wm3QRgkTyekJkdxlUF43h9MBFFcneoL8k4QRBWLtfrq60j0WHRmW4tqwTOtiWHeQjmOU9yIWm+nGjV/TZFAk+riMSUyAuvqdGwryrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ytg5WFU7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sEaKrvURUcenTvmCUulgLPcsbg1aXtm+VQO4NA9UfeQ=; b=Ytg5WFU7NOSrVIBE5f3gNcEJk8
	dFH8jsgBDMQD82D1D938nd7OTZM5+r+9R7QIfZvO28BW86fxCeCpKMp+ppRs7b3jR/1pscyRA1WQF
	+meQ7RK2o6vq7rYpSE7Zo7vqWHHsKSgQp0l9iF8b0B2G50GOmbTE88J5DW9zd6Guw6u+a5GQbuB9H
	5m6j9WwMEEuYgZs/n4pxVmxaxGsVzq2q9xFUDCWCIl2fpCKVemiOnc+ObbZe7/wJrQ8ryZjaaoohG
	Mt83kBO0geK0HBxrBmoSR2o82VY/bKaS9BX1QbgE6XQhKCCqKzfOlT0ztZ/Opti4CP+xuUCTUChwI
	dFv3KsNg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFRY4-0000000CPCQ-08Cd;
	Fri, 07 Jun 2024 04:49:56 +0000
Date: Thu, 6 Jun 2024 21:49:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Bernd Schubert <bschubert@ddn.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"bernd.schubert@fastmail.fm" <bernd.schubert@fastmail.fm>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH RFC v2 06/19] Add a vmalloc_node_user function
Message-ID: <ZmKRc1Pl4uGhGvCE@infradead.org>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-6-d149476b1d65@ddn.com>
 <ZlnW8UFrGmY-kgoV@infradead.org>
 <sxnfn6u4szyly7yu54pyhtg44qe3hlwjgok4xw3a5mr3r2vrwb@3lecpeavc2os>
 <984577b6-e23d-4eec-a5da-214c5b3572ba@ddn.com>
 <Zl6V-qsxKTOBS860@infradead.org>
 <ZmJwwwtpdpGccFtC@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmJwwwtpdpGccFtC@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 07, 2024 at 12:30:27PM +1000, Dave Chinner wrote:
> IOWs, vmalloc() has obeyed GFP_NOFS/GFP_NOIO constraints properly
> for since early 2022 and there isn't a need to wrap it with scopes
> just to do a single constrained allocation:

Perfect.  Doesn't change that we still need some amount of filterting,
e.g. GFP_COMP and vmalloc won't mix too well.


