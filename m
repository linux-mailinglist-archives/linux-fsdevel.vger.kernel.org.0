Return-Path: <linux-fsdevel+bounces-24136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0471A93A143
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 15:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365621C22223
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 13:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1814315382C;
	Tue, 23 Jul 2024 13:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CBF5X8Uy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8722B1514F3
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jul 2024 13:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721740854; cv=none; b=qYVUnbjgwgcAC25fgIdrbNuYVUtqmr4wJlX5TD0RbvzRhXrPvVekCsmZecYaorKvlr9I4FDjSAfadAkMsuDOs/PhhqPlAx+lnH7/6qYwXhXnjnP4wBcICF6hvTakgc39KC1jWDnyTSGNPvdt5w02Rxpma97XgAuvg7MIdFEVu5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721740854; c=relaxed/simple;
	bh=GznZx83qLzLwfY5R8qVMtQs++l7ZxcEy5TKy1gX3v5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4Fn40AUXvTVj6OIF17ODCZRx9WbwOCsRmZZ+yGEe9sVrCkSLhwoFjfZD+7ce4EVduDqEOJhL993BZFkAUfYpa6LnUP+a/k2y5kfYzEsl1qfhO+f1zAVxXingi0PQKfR+RBmlJHeSisOEFrxgFlKKoDM4UdnQpYvnUrgb7QXUAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CBF5X8Uy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3ZaBSTcNGLsNsHotGx6Ku2kTYfstMYbrCs+0ypZFM7s=; b=CBF5X8UyAvhc+tChqxHV9h5hQI
	wiZjr3oYnodEnM/ZeJ6eoHn7a4XHFn4jE1n8o/wcrSgEgqRA5wSnO0KnOYoUMIu3DWx2Ue97oE/9w
	o1YPefCmi41skEqxIjFVCSuZi+Q8eh2xoQyNvLnnRw0PhZDCmHtCApd7K8nANrRE8anjZ2etW0STo
	qIrfWrinXs0K2xELR2YwqL605uuUxW8Idh5vkGoSUevgcplba1Ner0bnN86+b1dzF0Ucdb/eMzFwv
	wOANaKpef2feG0nQpkvqxDl8UZPhdE5oF4uEz9MBxJ3LrYJwpSnMyvJZCTUdOYTgAZ9qIjLS/z5df
	/p6I/jtg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWFRe-00000006tv7-3fx3;
	Tue, 23 Jul 2024 13:20:46 +0000
Date: Tue, 23 Jul 2024 14:20:46 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/23] Convert write_begin / write_end to take a folio
Message-ID: <Zp-uLk9wCP5tIc6c@casper.infradead.org>
References: <20240717154716.237943-1-willy@infradead.org>
 <20240723-einfuhr-benachbarten-f1abb87dd181@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723-einfuhr-benachbarten-f1abb87dd181@brauner>

On Tue, Jul 23, 2024 at 09:49:10AM +0200, Christian Brauner wrote:
> On Wed, Jul 17, 2024 at 04:46:50PM GMT, Matthew Wilcox wrote:
> > You can find the full branch at
> > http://git.infradead.org/?p=users/willy/pagecache.git;a=shortlog;h=refs/heads/write-end
> > aka
> > git://git.infradead.org/users/willy/pagecache.git write-end
> > 
> > On top of the ufs, minix, sysv and qnx6 directory handling patches, this
> > patch series converts us to using folios for write_begin and write_end.
> > That's the last mention of 'struct page' in several filesystems.
> > 
> > I'd like to get some version of these patches into the 6.12 merge
> > window.
> 
> Is it stable enough that I can already pull it from you?
> I'd like this to be based on v6.11-rc1.

It's stable in that it works, but it's still based on linux-next.  I think
it probably depends on a few fs git pulls that are still outstanding.
More awkwardly for merging is that it depends on the four directory
handling patch series, each of which you've put on a separate topic
branch.  So I'm not sure how you want to handle that.

