Return-Path: <linux-fsdevel+bounces-32032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE9299F71A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 21:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19A6282D1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 19:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029421EBA0B;
	Tue, 15 Oct 2024 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="heRGDCJA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32E31F80D8
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 19:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019852; cv=none; b=GVsFwZGUT5hp79RkHz68IH698q5GSWXvyzFEQ/RvcrGCQU6QElPPprtOQxJ4OBm+BcV2C2kjo7e7jQYppU9cBkazNzh5qMJM/Gy0ObDerHqNgunze9mGEDfKqR7/9Pyhd78wg9TPDW6hTKex/uZBMHHHnVBPSX0XiqpFwLZuVJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019852; c=relaxed/simple;
	bh=DHDu6dLOdLzntjWcEhDWHDq5FCg2oReJ3SICL4KpBow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InHMAxlbWgk3NB2UFwsXtV4hGKtu+ciHD7rQioif5HtsblfkVn1OF8x05HAUYB2tgrgW/1MBSy/kUiZU7Bvdk8fQTe679V4GpEvUpTWI7jJsT2n4P0JD+vurej+ZqMS2BGPpeVpjQi/LaSJDAXzz2xu/7PrfWU5NaqTzruiiPK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=heRGDCJA; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 15 Oct 2024 12:17:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729019846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xMk7NYWnpFsmIrjE2x+tJklQeOWwKwQSoxh5vfQIXC8=;
	b=heRGDCJAruY94iowmaFXuDd8xlyZiFBCY228BaF4OWzjHfLsVrenr9Qbx09qL/f47NgJaY
	2oMDoAuch5zt39oON/DGkaGdVJ86aOT2bj67BaHQcmBJMmoFoJEp4Mc77zH4PPxkIhSbPJ
	LoFzp91AIil1NCF4wGgyFdT5q2NjMnk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, 
	hannes@cmpxchg.org, linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and
 internal rb tree
Message-ID: <ntkzydgiju5b5y4w6hzd6of2o6jh7u2bj6ptt24erri3ujkrso@7gbjrat65mfn>
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <20241014182228.1941246-3-joannelkoong@gmail.com>
 <CAJfpegs+txwBQsJf8GhiKoG3VxLH+y9jh8+1YHQds11m=0U7Xw@mail.gmail.com>
 <CAJnrk1a5UaVP0qSKcuww2dhLkeUqdkri_FEyVMAuTtvv3NMu9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1a5UaVP0qSKcuww2dhLkeUqdkri_FEyVMAuTtvv3NMu9Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 15, 2024 at 10:06:52AM GMT, Joanne Koong wrote:
> On Tue, Oct 15, 2024 at 3:01 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Mon, 14 Oct 2024 at 20:23, Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > > This change sets AS_NO_WRITEBACK_RECLAIM on the inode mapping so that
> > > FUSE folios are not reclaimed and waited on while in writeback, and
> > > removes the temporary folio + extra copying and the internal rb tree.
> >
> > What about sync(2)?   And page migration?
> >
> > Hopefully there are no other cases, but I think a careful review of
> > places where generic code waits for writeback is needed before we can
> > say for sure.
> 
> Sounds good, that's a great point. I'll audit the other places in the
> mm code where we might call folio_wait_writeback() and report back
> what I find.
> 
> 

So, any operation that the fuse server can do which can cause wait on
writeback on the folios backed by the fuse is problematic. We know about
one scenario i.e. memory allocation causing reclaim which may do the
wait on unrelated folios which may be backed by the fuse server.

Now there are ways fuse server can shoot itself on the foot. Like sync()
syscall or accessing the folios backed by itself. The quesion is should
we really need to protect fuse from such cases?


