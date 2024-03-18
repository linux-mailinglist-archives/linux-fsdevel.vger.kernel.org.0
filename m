Return-Path: <linux-fsdevel+bounces-14689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B3187E1DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 02:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1BFDB2319D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 01:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC911BF3F;
	Mon, 18 Mar 2024 01:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PzHsnob+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD5C17547;
	Mon, 18 Mar 2024 01:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710725959; cv=none; b=FlBV81cGpCkH+2b+3kneyPnn1Et+mV1ODWSP7mclooVw0JzjmRuDYLDJufxJ3O5Xlrd5jlr25jobWGqrJZabwhDTajYcyJS17zUej1ZWKU1vbqcy3BYZvXqo+EvwQWk6+cs9GE6a5HiOpRSPB7l3o7Da8fKFvxczBDqCOhWKJlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710725959; c=relaxed/simple;
	bh=amWpCoH+YQU6btZs9epPvWBHCG1BzXHjqmT8XzBQba0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfxsfyH0Y8b/voQPT+zSL9rU1YPuxMdOV49SsyV4vQ7WQ2vItMD69ga8vzbhIFcdj+1x87HKS1V4SbfzmuA2oc3j/R/kib2E39+xvmLsdWIbdEjZ9N0pLWnfS6uwifc8iHb1I50bCjh7NYSX+B/ElTbV7i3iJTot0XDC6x/QAY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PzHsnob+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BhhRpX9DYCFVLdLgChEZtHtVFcoXO9TtgwMQFj1k99A=; b=PzHsnob+e0sHyxwEyRCYyyS342
	7GiVfqriETkJABrKtYTfwBO+j1Avkdq7iMrSKHH1pBTJQzrM9EnFaC2CQflmljB59MQ8mmL56I9V9
	8ivuRD1BLlcBy0TBoiMcWB12FKyXcnh81cyF+OZShtaSTbM5v0YJWohRCZSirYeL9w/Y/ShLkXojj
	pHi7UZC0DHDFBu/bZ+wkxJF98GkiF3zUzntF84CeyQczc5z54PjMeh0HzEF4JLhRB0pdGJYKi4hjs
	JoL3nMJ6MIK3yTROyKL9c1nzp/ZP04nS4padRU8Tuup7ngVsJNVr6P5dywIAWAIAeAq2+D6y+Mgcx
	BKJhFspA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm1y8-00000006x84-4374;
	Mon, 18 Mar 2024 01:39:16 +0000
Date: Sun, 17 Mar 2024 18:39:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@redhat.com, ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCHBOMB v5.3] fs-verity support for XFS
Message-ID: <ZfebRH_fGx8EoRfu@infradead.org>
References: <20240317161954.GC1927156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240317161954.GC1927156@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Mar 17, 2024 at 09:19:54AM -0700, Darrick J. Wong wrote:
> Note that metadump is kinda broken and xfs_scrub media scans do not yet
> know how to read verity files.  All that is actually fixed in the
> version that's lodged in my development trees, but since Andrey's base
> is the 6.9 for-next branch plus only a few of the parent pointers
> patches, none of that stuff was easy to port to make a short dev branch.

Maybe we'll need to put the verity work back and do a good review cycle
on the parent pointers first?

Can you send out what your currently have?


