Return-Path: <linux-fsdevel+bounces-33918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D636E9C0B01
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 17:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C961C22111
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 16:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D06216E17;
	Thu,  7 Nov 2024 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pcYuprwN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4505216DEB;
	Thu,  7 Nov 2024 16:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995798; cv=none; b=sM+ntK574AwQKrWArmIzRtg2HXqC1YVsVGubyFiVhEgncHoy0F2YHl/k+HgLBmZ9yWNfI3oBxnfqkou6tDBH3dapw6WlM91s0mVFfj0g4my4nrnT+uEwwp4nGMoK3r3Pw8cL1nKFGavVOCNUTKFNezfezgbRzXglpE0G/Thnt8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995798; c=relaxed/simple;
	bh=Mpe1yanq/Uu+SRjRb+5eD084HJb8hdCPeGqjBMndUvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9NtX8wwB9Lb73PZa26rTCWwUI9We5Juu9TQMCPv2IGjHDFUl9NJuH3xnpnFF5Ub/XjKLCjTAnQOWMCePUZ4l71LF2pcYSrfY3QS/iKVvIHqrfbpVEeckoGo9rH2m8hSmqtX8Jf4Zxhdcwq74CrUlr7cZPmvvUHJBScaWR+kN/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pcYuprwN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r/NDUsG2aDKB3uC6YveYjLlK3F8ZxVs/bPaI8H9TOlw=; b=pcYuprwNIEuVYRpI+Y18x0G3mz
	CWJ38iYNMeOlOMoSCQvWB6y0lcwORd//UD9fSuNnmDmV8MGq96jop1G1ReQTS692mh8S5ctYjCOYT
	nEYNfb1vyuitmw5A/ESFt4vWerdEqN5w3d0JTMNKzjIkB/hwUmPMNLQdDDGkZPW+j2wrcA045A8RZ
	8Rff+qhmOCpluq881RYvXMwO9BH9PboUnOKNzgXWpheUh02PPj3l+ZFsTvTXpI9phcYt2j1b7nvOE
	hnmZVFaBmgxMCRn1s64a1HrjQxS886luk1mSSawBHjJgIStX78knjRtkEwX+ehJ1XAwRuScidBqOG
	UGRsuVfw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t954z-00000006wmb-3hn8;
	Thu, 07 Nov 2024 16:09:54 +0000
Date: Thu, 7 Nov 2024 16:09:53 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-fsdevel@vger.kernel.org,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, kvm@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Thomas Huth <thuth@redhat.com>
Subject: Re: [ISSUE] split_folio() and dirty IOMAP folios
Message-ID: <ZyzmUW7rKrkIbQ0X@casper.infradead.org>
References: <4febc035-a4ff-4afe-a9a0-d127826852a9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4febc035-a4ff-4afe-a9a0-d127826852a9@redhat.com>

On Thu, Nov 07, 2024 at 04:07:08PM +0100, David Hildenbrand wrote:
> I'm debugging an interesting problem: split_folio() will fail on dirty
> folios on XFS, and I am not sure who will trigger the writeback in a timely
> manner so code relying on the split to work at some point (in sane setups
> where page pinning is not applicable) can make progress.

You could call something like filemap_write_and_wait_range()?

> ... or is there a feasible way forward to make iomap_release_folio() not
> bail out on dirty folios?
> 
> The comment there says:
> 
> "If the folio is dirty, we refuse to release our metadata because it may be
> partially dirty.  Once we track per-block dirty state, we can release the
> metadata if every block is dirty."

With the data structures and callbacks we have, it's hard to do.
Let's see if getting writeback kicked off will be enough to solve the
problem you're working on.

