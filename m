Return-Path: <linux-fsdevel+bounces-17810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 683548B26CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 18:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A082C1C2213C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 16:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCF914D702;
	Thu, 25 Apr 2024 16:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEB3TvT9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BC6149E0E;
	Thu, 25 Apr 2024 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714063669; cv=none; b=RdS0vn3kg0dGojTbXKadyezdi9IViYD6ZDFfhTifMr91w/7pSfmYwXV0VvmCPt3RB/TblRxecBTSNPFnZzGFYUEcs1u6DBRpuqwIFojOfF/FDuSAfffp06L7RL3ZoMyN8wtO0Ji0ZX4b46rojGmO8E63DfXp4yeWzg0VRI6mjDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714063669; c=relaxed/simple;
	bh=2TM29JgVQLJFL9dQlAmJk0xwen5XvbcnRn6DsGNkuYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9p8eHybzdie5CYgnI4wxEHkK7Rn2mJEFav73ewDj3QYQTFLyHuFCYdg8YcYjacUzZs2lg6++Bz4W3t7sIfxp+D9SGpIehQSPHkhTISrC/FLGz7O2ejc8yZ2tjHkQ9Ky1EidXlDQ3jxo17YrwaOd8qZZvwxRDsPYrxQTs1a39ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEB3TvT9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1415C113CC;
	Thu, 25 Apr 2024 16:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714063668;
	bh=2TM29JgVQLJFL9dQlAmJk0xwen5XvbcnRn6DsGNkuYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vEB3TvT9y7TCfsNglmGkXEkbZeR8Tu8OemhEr3q1pi0H3d6dU56IF3VSlILC/fk16
	 gUMnqppINsTN3/e8+BVvNeC/SwWtURWkmy/va7TIwR9tzH6HXl1FI7qxBfqhROmnOC
	 v9TI0mo2q3xNEK93BRTRMmOHIaV84JMz2NiJVIcO0Oei4tE5yVRXt76YIMTCdcs1ir
	 w0fYTKvnYK+2u+sy4vhtIRpV4YQlZIC3vQ3jjZm1mMGxB6d4XWLS1EBwtjPz+T5R7P
	 7+USPbY0Uv+cC1JfklEjGQoUD7HmHSsIUFrHutcZLXfWEx6409c+dVYk8l2pNzEdqa
	 0bX+ReYK5cR7g==
Date: Thu, 25 Apr 2024 09:47:48 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 27/30] iomap: Remove calls to set and clear folio error
 flag
Message-ID: <20240425164748.GA360898@frogsfrogsfrogs>
References: <20240420025029.2166544-1-willy@infradead.org>
 <20240420025029.2166544-28-willy@infradead.org>
 <ZiYAoTnn8bO26sK3@infradead.org>
 <ZiZ817PiBFqDYo1T@casper.infradead.org>
 <ZiaBqiYUx5NrunTO@infradead.org>
 <ZiajqYd305U8njo5@casper.infradead.org>
 <ZipLUF3cZkXctvGG@infradead.org>
 <ZipQQYPLuFuh3ui6@casper.infradead.org>
 <ZipR4evzudGl-AgP@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZipR4evzudGl-AgP@infradead.org>

On Thu, Apr 25, 2024 at 05:51:45AM -0700, Christoph Hellwig wrote:
> On Thu, Apr 25, 2024 at 01:44:49PM +0100, Matthew Wilcox wrote:
> > On Thu, Apr 25, 2024 at 05:23:44AM -0700, Christoph Hellwig wrote:
> > > On Mon, Apr 22, 2024 at 06:51:37PM +0100, Matthew Wilcox wrote:
> > > > If I do that then half the mailing lists bounce them for having too
> > > > many recipients.  b4 can fetch the entire series for you if you've
> > > > decided to break your email workflow.  And yes, 0/30 was bcc'd to
> > > > linux-xfs as well.
> > > 
> > > I can't find it on linux-xfs still.  And please just don't make up
> > > your own workflow or require odd tools.
> > 
> > You even quoted the bit where I explained that the workflow you insist I
> > follow doesn't work.
> 
> I've regularly sent series to more list than you'd need for 30
> patches even if they were entirely unrelated.  But if they are
> entirely unrelated it shouldn't be a series to start with..

One thing I didn't realize until willy pointed this out separately is
that some of the list processing softwares will silently ignore an email
if it has too many entries (~10) in the to/cc list, because spam
heuristics.  I think vger/linux.dev is fairly forgiving about that, but
indie listservs might not be, and that adds friction to treewide
changes.

At least the whole series made it to fsdevel, but fsdevel is such a
firehose now that I can't keep up with it.  It's too bad that linux-xfs
can't simply mirror patchsets sent to mm/fsdevel with "xfs:" in the
title, and then I wouldn't have to look at the firehose.

All I'm really trying to say is, patchbombs are crap for collaboration.

--D

