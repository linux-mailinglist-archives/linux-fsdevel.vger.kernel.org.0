Return-Path: <linux-fsdevel+bounces-23174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9D2927F33
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 01:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA681C2204B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 23:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6578144D0F;
	Thu,  4 Jul 2024 23:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i3UJVn4O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC9E1442E8;
	Thu,  4 Jul 2024 23:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720137400; cv=none; b=e8B2FCIBmdVMk52068kgokgcOtkUVbt+Y4DOvp+c3YFPVSwV19tgb2HP5lEOE2APTf1WrMeYYozI0eXvs9xE5xRFluEEHb6mSBDFwleEoC7OY5PB/XwXuwxU7Sav+THS+godwcBmAO8fDRh6UhBU011Dfha83a8wfr0KXugbVxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720137400; c=relaxed/simple;
	bh=Xs46nOwYHJgTIupLsnCjY/fzgBTYbfF9hkb/20rxUWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=peq/eUT7aEJShF+fv8aMIY/MqqVfkETahYho3C5G6w5LtxtWD165sIqANSFC9/mnRVQUsz80b3uPOopDymGWJOS+ehHVIuVJj3XA+cS9l5KfKkAM8pI3yF0CpNWCBQnDh5okh7VNflwtB4QwafyOlS93G1XmMeIhwgG1g72ftGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i3UJVn4O; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4RxnX5dG7TVykPcShsgjuHYL9eFLAVZdu3tr/LHBW7w=; b=i3UJVn4O5dAMVdhCht3dXBnhOy
	WsY/cAA4hHyjzGtrmCdt8bkRXNnNyLk4H8crFOG1YMEy5dZ99Q3xfyPn+DWbVdOH6AFxDPWAdthOU
	QFzC9+L/8oMMwdxR6yXarHEZzEzFiefH2zEffWrkEqYgK+3fhRQVC3pAY/wmGqjrnMRyWyBBhgSoD
	YsC4d5zkPtyrRL/pr17skDLdar1dfKxyD231dV0Bgl0TxG+RKrrD+nBfWWiopZhRY1wE/y5WtjMSk
	MXLSjw6FripgICfXYHGRyXQn8OP5qKBRW8zIZv2+Z0hGnlEZhav81Wevs4yX0UCAIAu9jLRgan6dA
	HGRAEbBA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPWJQ-00000003N58-190o;
	Thu, 04 Jul 2024 23:56:28 +0000
Date: Fri, 5 Jul 2024 00:56:28 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	chandan.babu@oracle.com, djwong@kernel.org, brauner@kernel.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com, linux-mm@kvack.org,
	john.g.garry@oracle.com, linux-fsdevel@vger.kernel.org,
	hare@suse.de, p.raghav@samsung.com, mcgrof@kernel.org,
	gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 01/10] fs: Allow fine-grained control of folio sizes
Message-ID: <Zoc2rCPC5thSIuoR@casper.infradead.org>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-2-kernel@pankajraghav.com>
 <cb644a36-67a7-4692-b002-413e70ac864a@arm.com>
 <Zoa9rQbEUam467-q@casper.infradead.org>
 <Zocc+6nIQzfUTPpd@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zocc+6nIQzfUTPpd@dread.disaster.area>

On Fri, Jul 05, 2024 at 08:06:51AM +1000, Dave Chinner wrote:
> > > It seems strange to silently clamp these? Presumably for the bs>ps usecase,
> > > whatever values are passed in are a hard requirement? So wouldn't want them to
> > > be silently reduced. (Especially given the recent change to reduce the size of
> > > MAX_PAGECACHE_ORDER to less then PMD size in some cases).
> > 
> > Hm, yes.  We should probably make this return an errno.  Including
> > returning an errno for !IS_ENABLED() and min > 0.
> 
> What are callers supposed to do with an error? In the case of
> setting up a newly allocated inode in XFS, the error would be
> returned in the middle of a transaction and so this failure would
> result in a filesystem shutdown.

I suggest you handle it better than this.  If the device is asking for a
blocksize > PMD_SIZE, you should fail to mount it.  If the device is
asking for a blocksize > PAGE_SIZE and CONFIG_TRANSPARENT_HUGEPAGE is
not set, you should also decline to mount the filesystem.


