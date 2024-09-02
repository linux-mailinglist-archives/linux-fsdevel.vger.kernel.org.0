Return-Path: <linux-fsdevel+bounces-28266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B4B968A3F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 16:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFDC6283339
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 14:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D620319F11E;
	Mon,  2 Sep 2024 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="sRtSVxXz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5817F13E02B;
	Mon,  2 Sep 2024 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725288535; cv=none; b=OUU5jHhQNX01Wrbfx16dsCPBf13ML7oyjJ2UcF8R7S/Mx27jsBNokZG+JVF9C58IHZ8uspcJH90LAmI9nmucnpyfdC/eT43ZmmQVV8ixwa41Ge4KriTpK6hjmbOp7RfZGR/WXShTjBvpKJjyMo3zD8I3npQsguydQDoN/5QOmdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725288535; c=relaxed/simple;
	bh=o57CHjjJ8Kj/lGbzMqgIy3RRSeijR0sqKhkFD9lrdmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMd0jWgSPkYiogUrVAnYBZJCsuYxmTpyP0wACUGnO8wOwhPvv5ina60nBKEwVgIHW2OlF1UfGWsOy9lh3iZWR6i4fiSvREy7Dc7HRRz61/gCcP523YG70wcnfqwls+aHgg8HaDmw1bc50emZCIyXI2iSMO/iSbBAgRvq8A2LkVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=sRtSVxXz; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WyBTW0yv0z9s9s;
	Mon,  2 Sep 2024 16:48:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1725288527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eRC1BvtLT2vA0iVXzms3Z2oYXmmRg/cLCIDrpDyKuD4=;
	b=sRtSVxXzSTx8suCqivUdxTopF/qs1vmlknYQADnE84cSnOnEJYkK00HoUqTznXGpFAEX3Y
	GBgpQzpVhLl/C0CVJCDwczLrIPFKWjMdOcSVZu0aV4EzKBf+/ykcc+nOXiERk3xsBeksQF
	Y2XMVd+wsqFqAc3B2tO67Ovgi6C6W2P3IRDrI34vwdUnfPcIlxKluzzEB/AfTk3OvZyU1z
	ck/3+kej41HeK4F/PTnOpxSs4raty8q0tnmMFvpBm66sl4h7CnUuPfV3EA4YevhUnZGl1r
	IBRtiDnsbP/OCyK2IQyCcHxZ/oZV3F4cYjJnnXolEyekVAgPwbbdGcZOFm9hhA==
Date: Mon, 2 Sep 2024 14:48:41 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, sfr@canb.auug.org.au,
	akpm@linux-foundation.org, linux-next@vger.kernel.org,
	mcgrof@kernel.org, ziy@nvidia.com, da.gomez@samsung.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Pankaj Raghav <p.raghav@samsung.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH] mm: don't convert the page to folio before splitting in
 split_huge_page()
Message-ID: <20240902144841.gfk4bakvtz6bxdqx@quentin>
References: <20240902124931.506061-2-kernel@pankajraghav.com>
 <ZtXFBTgLz3YFHk9T@casper.infradead.org>
 <20240902-wovor-knurren-01ba56e0460e@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902-wovor-knurren-01ba56e0460e@brauner>

On Mon, Sep 02, 2024 at 04:21:09PM +0200, Christian Brauner wrote:
> On Mon, Sep 02, 2024 at 03:00:37PM GMT, Matthew Wilcox wrote:
> > On Mon, Sep 02, 2024 at 02:49:32PM +0200, Pankaj Raghav (Samsung) wrote:
> > > From: Pankaj Raghav <p.raghav@samsung.com>
> > > 
> > > Sven reported that a commit from bs > ps series was breaking the ksm ltp
> > > test[1].
> > > 
> > > split_huge_page() takes precisely a page that is locked, and it also
> > > expects the folio that contains that page to be locked after that
> > > huge page has been split. The changes introduced converted the page to
> > > folio, and passed the head page to be split, which might not be locked,
> > > resulting in a kernel panic.
> > > 
> > > This commit fixes it by always passing the correct page to be split from
> > > split_huge_page() with the appropriate minimum order for splitting.
> > 
> > This should be folded into the patch that is broken, not be a separate
> > fix commit, otherwise it introduces a bisection hazard which are to be
> > avoided when possible.
> 
> Patch folded into "mm: split a folio in minimum folio order chunks"
> with the Link to this patch. Please double-check.
Thanks a lot!

I still don't see it upstream[1]. Maybe it is yet to be pushed?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs.blocksize&id=fd031210c9ceb399db1dea001c6a5e98f3b4e2e7

