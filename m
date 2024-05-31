Return-Path: <linux-fsdevel+bounces-20650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2B58D6609
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 17:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B959B24A5F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 15:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC42155CA1;
	Fri, 31 May 2024 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JetiMsk2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E157A81725
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717170446; cv=none; b=Djyw/3p+2Fe5pFdBBuqYBzJ/hFXccWjdon8WjIRa+zDC/HsRjQ/Ez+amArEyrVCORNFVvSkLJeWYMf9bG0aOup9C4KojLtZGsYZnbbxOwDxyK+hGMUVDszFLCS8GpWgk1JDk9gp1nIUAZ+C8M3PxitaNk8mUhHoPV3INtK8sMA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717170446; c=relaxed/simple;
	bh=hWFZ/V332u6k3fNB59cuO4HATknVnL+ShwJd8fzVto0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoW2lem6CsdPPotlFvm1hID5S/8Xb2benSUIRUmJsJHTGTac6AwYKiRtQl0FEcsrrK/FZD7LQT6nKyRwztciJZXohW3IRWGAtSCF8Wt+Y8vcHWHxwXAv9i7NbjlszsKjvluvBB2pfurVbSxKK1bulPQsKPX6R5Mq1zrk9K0KAvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JetiMsk2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KVfH790qGwx5nczioSeEaOxkLjtb03deFnL1/0VWPxs=; b=JetiMsk2M0dp0zV5eVZBjRfiol
	S5STb7JCAmhxx8E/B/FEnCuMJ1ycvfeDmzs8hi485v8ZEFS7mMvvmTrzHQP9TqueL8TLnKL8AqpS2
	KSu8qRRIn9kXnxLYyoEDFGOGOotoI3DPhm9k01JiDZvnUfSV/vms+X6O2brDfTTROQ/2NEeUt2rjr
	DqnRQMxPXqq0Qir4xEy9yPNi7+0sT4dhlgF7RdeF3eSxH4ZUiTrrbxhpTWPF/xLDUaJSdecfGZZFc
	r1+3aGIWX0XKuPXPUXELjtYroUsaAK3cHf6RbuBHVhC9lnWmEEH7HNLLvyGhpmJ7xpnuu/aB9Fdjp
	bazz8y2w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD4TQ-0000000Bpwf-2oXI;
	Fri, 31 May 2024 15:47:20 +0000
Date: Fri, 31 May 2024 16:47:20 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, david@fromorbit.com,
	hch@lst.de, Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH][RFC] fs: add levels to inode write access
Message-ID: <ZlnxCJ-14kVXxyV9@casper.infradead.org>
References: <72fc22ebeaf50fabf9d14f90f6f694f88b5fc359.1717015144.git.josef@toxicpanda.com>
 <20240530-atheismus-festland-c11c1d3b7671@brauner>
 <CAHk-=wg_rw5jNAQ3HUH8FeMvRDFKRGGiyKJ-QCZF7d+EdNenfQ@mail.gmail.com>
 <20240531-ausdiskutiert-wortgefecht-f90dca685f8c@brauner>
 <20240531-beheben-panzerglas-5ba2472a3330@brauner>
 <CAOQ4uxhCkK4H32Y8KQTrg0W3y4wpiiDBAfOs4TPLkRprKgKK3A@mail.gmail.com>
 <20240531-weltoffen-drohnen-413f15b646cb@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531-weltoffen-drohnen-413f15b646cb@brauner>

On Fri, May 31, 2024 at 04:50:16PM +0200, Christian Brauner wrote:
> So then I propose we just make the deny write stuff during exec
> conditional on IMA being active. At the end it's small- vs chicken pox.
> 
> (I figure it won't be enough for IMA to read the executable after it has
> been mapped MS_PRIVATE?)

do you mean MAP_PRIVATE?

If so, you have a misapprehension.  We can change the contents of the
pagecache after MAP_PRIVATE and that will not cause COW.  COW only
occurs if someone writes through a MAP_PRIVATE.

