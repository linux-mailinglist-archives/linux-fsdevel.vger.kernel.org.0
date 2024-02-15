Return-Path: <linux-fsdevel+bounces-11735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD38856AB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 18:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD931C23805
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 17:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E0F13667F;
	Thu, 15 Feb 2024 17:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J2x03zKk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7655213399E;
	Thu, 15 Feb 2024 17:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017382; cv=none; b=qXfrtBuIeRHwoAOl0+ZDRI8VnYDG4bxrTfhdDB5b24LxwL4p0+KFtZ3LpA0Gr4+xXw6Duv+SwYCLH9RqxcaeFQJqcyLerZz2v86+L9Qs2xz0KJV/4P8yXy/2RIC41eNePxrfWApPCJeXy6VHHkgGAqR5lbglxpzywkVWk0JCogY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017382; c=relaxed/simple;
	bh=VbPhq+uqtD0wh4xdtcIH/nBhQoxzNU7yJP6GxEcdnl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBC2rbHII/F7BYdvcvSjegEaU9c9LxqiTI0Q4S8jRYrqW4Q0rjka0C4XMDXX/W8vuR6SdDURmNemsTUxvUoQs9v7SDwVCaG6+yzWtlMFMiXN3P6GXm4FfIbNx/WH0GXK95y+WzAqk8Tf7ufR10M0DhQh57g9ku/ts7FZIczCuL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J2x03zKk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mjtUPw1XtkanAX7DpRAs9DDb/3wQHhRms0qJ3CAstOs=; b=J2x03zKk8Y+WdwlkSSOo+8lrTP
	efYt8Aiiw9DGvVxvI3y+UnVYRl4YGh0t0HCkhDsj0sGaRN1YgEnkCTT5GPlOGMM5Btifb8rSwpoqo
	tzL5CEAHxfdC+Ot7PdSGLya0iNNK68dM1H3nDUzIZSyqET1uVyQjm/NkuviJbeZMhxOuMH5j0Z6xo
	Yi6ODLJbMvDUqDyUftlDBOWbVbKEPFVzPe6BIU49KLlkuHqOC3hlzF8YZwiH49JZZ6cKHY9q2H8Y2
	zRIqlXkIDMDbMQkhwRcx574gUc+VrTG6wHbC7scOevJ2RcFM7gHZlHlB5DAwhq3QCENztXL/zB08U
	F40o9u6w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rafLM-0000000H8gW-48qU;
	Thu, 15 Feb 2024 17:16:16 +0000
Date: Thu, 15 Feb 2024 09:16:16 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>, zlang@redhat.com,
	Pankaj Raghav <p.raghav@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>, linux-mm@kvack.org,
	xfs <linux-xfs@vger.kernel.org>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, kdevops@lists.linux.dev
Subject: Re: mm/truncate.c:669 VM_BUG_ON_FOLIO() - hit on XFS on different
 tests
Message-ID: <Zc5G4PcKcQKCB54E@bombadil.infradead.org>
References: <ZXObKBfw/0bcRQNr@bombadil.infradead.org>
 <ZXQAgFl8WGr2pK7R@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXQAgFl8WGr2pK7R@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Sat, Dec 09, 2023 at 05:52:00AM +0000, Matthew Wilcox wrote:
> On Fri, Dec 08, 2023 at 02:39:36PM -0800, Luis Chamberlain wrote:
> > Commit aa5b9178c0190 ("mm: invalidation check mapping before folio_contains")
> > added on v6.6-rc1 moved the VM_BUG_ON_FOLIO() on invalidate_inode_pages2_range()
> > after the truncation check.
> > 
> > We managed to hit this VM_BUG_ON_FOLIO() a few times on v6.6-rc5 with a slew
> > of fstsets tests on kdevops [0] on the following XFS config as defined by
> > kdevops XFS's configurations [1] for XFS with the following failure rates
> > annotated:
> > 
> >   * xfs_reflink_4k: F:1/278 - one out of 278 times
> >     - generic/451: (trace pasted below after running test over 17 hours)
> >   * xfs_nocrc_4k: F:1/1604 - one ou tof 1604 times
> >      - generic/451: https://gist.github.com/mcgrof/2c40a14979ceeb7321d2234a525c32a6
> > 
> > To be clear F:1/1604 means you can run the test in a loop and on test number
> > about 1604 you may run into the bug. It would seem Zorro had hit also
> > with a 64k directory size (mkfs.xfs -n size=65536) on v5.19-rc2, so prior 
> > to Hugh's move of the VM_BUG_ON_FOLIO() while testing generic/132 [0].
> > 
> > My hope is that this could help those interested in reproducing, to
> > spawn up kdevops and just run the test in a loop in the same way.
> > Likewise, if you have a fix to test we can test it as well, but it will
> > take a while as we want to run the test in a loop over and over many
> > times.
> 
> I'm pretty sure this is the same problem recently diagnosed by Charan.
> It's terribly rare, so it'll take a while to find out.  Try the attached
> patch?

Confirmed, at least v6.8-rc2 no longer as this as the commit
fc346d0a70a1 ("mm: migrate high-order folios in swap cache correctly")
was merged as of v6.7-rc8. I ran the test 400 times in a loop.

I'll remove this now from the expunges on kdevops for v6.8-rc2 baseline.

  Luis

