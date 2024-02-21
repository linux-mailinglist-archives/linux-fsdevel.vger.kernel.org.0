Return-Path: <linux-fsdevel+bounces-12280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5665085E3A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 17:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878301C21D9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 16:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D740A82D6B;
	Wed, 21 Feb 2024 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rUngedc9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4D87F7D7;
	Wed, 21 Feb 2024 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708533939; cv=none; b=JdIdRYaJbOSqZ+OEtiKrTk1X2AW7VrTnKEF9naGzIsh6WMVFSMT0bzepZwf2/d2tbKJZf4v5XT2Lh38EfQA/Gretrg1j0qlOb8mk42WAYygZ0oRCaNCQSrFgUQAf+5Wl7mX36r7mtcJ4aoccRM1owN8GpUhXA2gUQLf86+gsS3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708533939; c=relaxed/simple;
	bh=4JMWbhQV+29Rdcn1RpSS9UYeFw2pVRmS/GFDmbNSndw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/p9/zU0Pn4zJ27d3gKa8NkqolR7MjTTD8hQpwrZyPMMDk0BYAWL9yVyvyKeg+8K38W3m67mcZ4bhsAXFhqPaSSbX/Q3K7y0Y5aelLjOxyliWPHCLN0NtjBaGE0VWBeBCTKNqrmitThlE+ZAo5AVsRsTweRaCs+xkm4kNTuchCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rUngedc9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QpZsIq9jWdUdflTreC/PGvxwfLFPgooOwnblTIlbOQ8=; b=rUngedc9QYD7gFPjemZ9VQfNQL
	SuK7txvLsnMrUZsLNIN/r32TwIeS0pxpNpQPKE382WJLWMMaM+avHMCJ/SPd9UcYxorlOetQbr3LQ
	JfM0JGrSTetmUhkFqQq2t8JKQjcVjYD5/AAzlqfGGim7vOTd9L7niLD2QpjFLCfd1KnGS7kfXoPc1
	iRyePGc/MxV+yLI2ZMSWDO0pgWogf3Sq133lWtCrsrrFn1cllgmY17pzEi+qyuWyxKS03eJEC3Y77
	uQx0duvLbxBL3SoxkhSPFev9LnHsc3iepU7Dsytn4ziFEWvlX+gQQI1ruDQxRCS5gRWc/jiVIdj5r
	NIntZiFQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcpiz-00000001mZ3-0qfI;
	Wed, 21 Feb 2024 16:45:37 +0000
Date: Wed, 21 Feb 2024 08:45:37 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, anand.jain@oracle.com, aalbersh@redhat.com,
	djwong@kernel.org, linux-fsdevel@vger.kernel.org,
	kdevops@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH 2/3] check: add support for --list-group-tests
Message-ID: <ZdYosXHe9ec04kBr@bombadil.infradead.org>
References: <20240216181859.788521-1-mcgrof@kernel.org>
 <20240216181859.788521-3-mcgrof@kernel.org>
 <ZdLNJD5pYaK84w3r@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdLNJD5pYaK84w3r@dread.disaster.area>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Mon, Feb 19, 2024 at 02:38:12PM +1100, Dave Chinner wrote:
> On Fri, Feb 16, 2024 at 10:18:58AM -0800, Luis Chamberlain wrote:
> > Since the prior commit adds the ability to list groups but is used
> > only when we use --start-after, let's add an option which leverages this
> > to also allow us to easily query which tests are part of the groups
> > specified.
> > 
> > This can be used for dynamic test configuration suites such as kdevops
> > which may want to take advantage of this information to deterministically
> > determine if a test falls part of a specific group.
> > Demo:
> > 
> > root@demo-xfs-reflink /var/lib/xfstests # ./check --list-group-tests -g soak
> > 
> > generic/019 generic/388 generic/475 generic/476 generic/521 generic/522 generic/616 generic/617 generic/642 generic/648 generic/650 xfs/285 xfs/517 xfs/560 xfs/561 xfs/562 xfs/565 xfs/570 xfs/571 xfs/572 xfs/573 xfs/574 xfs/575 xfs/576 xfs/577 xfs/578 xfs/579 xfs/580 xfs/581 xfs/582 xfs/583 xfs/584 xfs/585 xfs/586 xfs/587 xfs/588 xfs/589 xfs/590 xfs/591 xfs/592 xfs/593 xfs/594 xfs/595 xfs/727 xfs/729 xfs/800
> 
> So how is this different to ./check -n -g soak?
> 
> '-n' is supposed to show you want tests are going to be run
> without actually running them, so why can't you use that?

'-n' will replicate as if you are running all tests but just skip while
--list-group-tests will just look for the tests for the group and bail right
away, and it is machine readable.

  Luis

