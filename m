Return-Path: <linux-fsdevel+bounces-32096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D31319A06DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 12:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E67A28165D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 10:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD848206956;
	Wed, 16 Oct 2024 10:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="hVNs7IMv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A75205E0F
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729073804; cv=none; b=ej6IJ2sGfMFLOV674zJkpsVH+eBwFndjjWgb0hy2xM22cOtxxbc+wcdI+rIjWLuiIUDeXr+TjmVeAMprezQl/ZE5nX8IwQUSkrTp2FFhrbjUSbcsfZiWyJvCbgYYclvRMwX80vUVRfy+UWLn2sKOZdfQTdU4aibOp3vSr4WAck0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729073804; c=relaxed/simple;
	bh=yht8hn1onR8/5y/Q5Giz7ylBfHJjM49BDkQdUk/6qL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOdO404O4mpUGfMrB+k1Jc5aNQWoW14ixRoygNOpp2cHDnsJjbWx/tagNKlfvlB98x1CI5MBc8n7Xf8PZGUDzNx8pWgENInj+O/bW1dJWZ30YRaOBo10Pwr7m2rC81yHG/PSpZKD0XCChiDt8fcxQKaAWIRWGHlYFgtmOfvh3xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=hVNs7IMv; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4XT67q19ZYz9tSH;
	Wed, 16 Oct 2024 12:06:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1729073207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sOzG0cX3sai5dakTTrL0FJHVbrUqwT6b+G39uDNzeQc=;
	b=hVNs7IMvyZxZVObgylgjWNpB2G4SBMa/ka4yRUBmpRzK1FazRa6rDaq6xdI+llHB2cCURi
	CHCYxfnQCfPvAL3Sx/eoEG5VhDIOWbWLbq4MTBgkLnI+wO/yP3KULWxJB3LaDkLeE1HO4T
	ShGpTjDdyHECSUMZuyYgfe37UTz/w4hLq8SnZsAL/Ezo/l6L6onwLU8s+MAVyOWxnNTtk0
	tU6ZvWX/pBCAeGOVgpQnnmcJ1XZk1z7lrEfeJ9Ojdo8/3t/nxE9BzWCLayRZ/zDzrWcHPw
	LiIfwoVbUmbhxodqdH0mSud5w5HxqVoN6oKeA4H/FvBzB+Ltd+eZTfaVeO3cEA==
Date: Wed, 16 Oct 2024 15:35:27 +0530
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, mcgrof@kernel.org, gost.dev@samsung.com, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: Re: [PATCH v14] mm: don't set readahead flag on a folio when
 lookahead_size > nr_to_read
Message-ID: <cwugg63urgcknylwum4lfcxyemx3epcejfchrpfwcii5pvsp3k@2f5d5kjw7tlq>
References: <20241015164106.465253-1-kernel@pankajraghav.com>
 <Zw6nVz-Y6l-4bDbt@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw6nVz-Y6l-4bDbt@casper.infradead.org>
X-Rspamd-Queue-Id: 4XT67q19ZYz9tSH

On Tue, Oct 15, 2024 at 06:33:11PM +0100, Matthew Wilcox wrote:
> On Tue, Oct 15, 2024 at 06:41:06PM +0200, Pankaj Raghav (Samsung) wrote:
> 
> v14?  Where are v1..13 of this patch?  It's the first time I've seen it.

Sorry for the confusion. My git send script messed up the version
number. It is v1 :)

> 
> > The readahead flag is set on a folio based on the lookahead_size and
> > nr_to_read. For example, when the readahead happens from index to index
> > + nr_to_read, then the readahead `mark` offset from index is set at
> > nr_to_read - lookahead_size.
> > 
> > There are some scenarios where the lookahead_size > nr_to_read. If this
> > happens, readahead flag is not set on any folio on the current
> > readahead window.
> 
> Please describe those scenarios, as that's the important bit.
> 

Yes. I will do that in the next version. do_page_cache_ra() can clamp
the nr_to_read if the readahead window extends beyond EOF.

I think this probably happens when readahead window was created and
the file was truncated before the readahead starts.

> > There are two problems at the moment in the way `mark` is calculated
> > when lookahead_size > nr_to_read:
> > 
> > - unsigned long `mark` will be assigned a negative value which can lead
> >   to unexpected results in extreme cases due to wrap around.
> 
> Can such an extreme case happen?
> 

I think this is highly unlikely. I will probably remove this reason
from the commit message. It was just a bit weird to me that we are
assigning a negative number to an unsigned value which is supposed to be
the offset.

> > - The current calculation for `mark` with mapping_min_order > 0 gives
> >   incorrect results when lookahead_size > nr_to_read due to rounding
> >   up operation.
> > 
> > Explicitly initialize `mark` to be ULONG_MAX and only calculate it
> > when lookahead_size is within the readahead window.
> 
> You haven't really spelled out the consequences of this properly.
> Perhaps a worked example would help.
> 

Got it. I saw this while running generic/476 on XFS with 64k block size.

Let's assume the following values:
index = 128
nr_to_read = 16
lookahead_size = 28
mapping_min_order = 4 (16 pages)

The lookahead_size is actually lying outside the current readahead
window. The calculation without this patch will result in incorrect mark
as follows:

ra_folio_index = round_up(128 + 16 - 28, 16) = 128;
mark = 128 - 128 = 0;

So we will be marking the folio on 0th index with RA flag, even though
we shouldn't have. Does that make sense?

> I think the worst case scenario is that we set the flag on the wrong
> folio, causing readahead to occur when it should not.  But maybe I'm
> wrong?

You are right. We might unnecessarily trigger a readahead where we
should not. I think it is good to mention this consequence as well in
the commit message to be clear.

--
Pankaj

