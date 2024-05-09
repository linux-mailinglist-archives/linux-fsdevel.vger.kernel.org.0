Return-Path: <linux-fsdevel+bounces-19188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA588C11A1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 17:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85317B21606
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 15:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C433A15ECE2;
	Thu,  9 May 2024 15:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p7jh5Wrw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F2239AC9;
	Thu,  9 May 2024 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715267136; cv=none; b=GXYaPKRLaBofFj0a4SwiPRaYZi2aExh+RLcu37GgP0r6kzMN6xcDNfAZ8u2ErvmbaE3CYWfKbxBkRA8UCvxj8sxQRlD458/pss0+7xWIwKPLuBxNTNrhtx0Nn97v3mfkP5bwAAbTFE5NnJC5NVySaeTMaettcUAdN4rlmNwuAeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715267136; c=relaxed/simple;
	bh=I2fi4aAARoQ12m4ga3tovbUtAqHm2adC5Q0NtQoh148=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lxzi/iZSclILXqQDBP2QBPfa8YHM2QtRuK15a4JzP33wfiHuPW5T8mSPo6lQtIyTl4HLk5YfajXttWeAPOmzaF5rAtzCImqzm5OvYQ3yau+QFNcaMfnXgtZCKf68P/kXmgWaVvv5RB1/ZrnvPZzvV+0DOcr4yoDSwcVWlMRI+kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p7jh5Wrw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NTxQ6b9gJV4qPcNNolosfP527XGyNxAyMqN2wlfwLmo=; b=p7jh5Wrw8y3OsGiGmfbt4hL1jK
	taC66FQQcRrAfbtFdUUVPhAx8vcQAFvszEAqNmrMe+KvnqhwT5WkDsfd4z3E7fxZz1VGuWckP66nr
	SNd9Wf1LvVmE6yVcHASC2PpdPNuw98Kg6YhvlNSBgxhvSjCTMdCBpH4kqEY/Tw7x8wpKqKRfaoXRS
	FyvwPWYLQycN5drHGFb5cMC+Fwc0HWo+et5hQ5h3GRZ3vMXLuzzV4nIaBtBo5Q1ram383ZNoOmdYH
	ZvB8dT5gr9zx0A1ckhFczLA4LDJ6TfqroFB4a0Qflggf8SBoG0NubsSj8Q+SyVzNRF4NblXEZy7K7
	8jnMko/Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s55Km-00000001ogW-0Vwe;
	Thu, 09 May 2024 15:05:24 +0000
Date: Thu, 9 May 2024 08:05:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, hch@lst.de,
	willy@infradead.org, mcgrof@kernel.org, akpm@linux-foundation.org,
	brauner@kernel.org, chandan.babu@oracle.com, david@fromorbit.com,
	gost.dev@samsung.com, hare@suse.de, john.g.garry@oracle.com,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	ritesh.list@gmail.com, ziy@nvidia.com
Subject: Re: [RFC] iomap: use huge zero folio in iomap_dio_zero
Message-ID: <ZjzmNF51yb_EyP4W@infradead.org>
References: <20240503095353.3798063-8-mcgrof@kernel.org>
 <20240507145811.52987-1-kernel@pankajraghav.com>
 <ZjpSx7SBvzQI4oRV@infradead.org>
 <20240508113949.pwyeavrc2rrwsxw2@quentin>
 <Zjtlep7rySFJFcik@infradead.org>
 <20240509123107.hhi3lzjcn5svejvk@quentin>
 <ZjzFv7cKJcwDRbjQ@infradead.org>
 <20240509125514.2i3a7yo657frjqwq@quentin>
 <ZjzIb-xfFgZ4yg0I@infradead.org>
 <20240509143250.GF360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509143250.GF360919@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, May 09, 2024 at 07:32:50AM -0700, Darrick J. Wong wrote:
> On Thu, May 09, 2024 at 05:58:23AM -0700, Christoph Hellwig wrote:
> > On Thu, May 09, 2024 at 12:55:14PM +0000, Pankaj Raghav (Samsung) wrote:
> > > We might still fail here during mount. My question is: do we also fail
> > > the mount if folio_alloc fails?
> > 
> > Yes.  Like any other allocation that fails at mount time.
> 
> How hard is it to fallback to regular zero-page if you can't allocate
> the zero-hugepage?

We'd need the bio allocation and bio_add_page loop.  Not the end
of the world, but also a bit annoying.  If we do that we might as
well just do it unconditionally.

> I think most sysadmins would rather mount with
> reduced zeroing performance than get an ENOMEM.

If you don't have 2MB free for the zero huge folio, are you going to
do useful things with your large block size XFS file system which
only makes sense for giant storage sizes?

