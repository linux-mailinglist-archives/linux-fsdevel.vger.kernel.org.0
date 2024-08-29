Return-Path: <linux-fsdevel+bounces-27845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F6896474F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D7CBB2DCDC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373ED1B3F00;
	Thu, 29 Aug 2024 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T6TED+FM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0331AC891
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938382; cv=none; b=AP5wQjYd1KPDSOHcL8fEM8ACDpsuLdzhsXGHJg/Vtev2NSp+47rowsHAkWutc/yEswBw59NwIlvBJSJr69COgfPQa44VYWXJC2hvOFO7kGT3B2qzhSnSESOirLJt0Po/7JfwupYbcNC6FiBfoDXg24scQn9vnv8ZbiuTIYVsdbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938382; c=relaxed/simple;
	bh=Ei5nGh3aP7XlmeeonQ5fBYgrdr2m+tmjjLP1aSXD12Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNh/rRFPt3/Kav1mPMgdr55k4Q7RUeaV37OdXGkRrT4TlLu5IqkzAXQ4dbmzhaP5wtSO1hTDMhlOnorSR0+yUC7dmLOsbfTHAczYppywwmmdt84xlOxMBu10suny+Uak3gYPXltf29LDnwyCC9QbAAHnJoa9XNTlZnVbyTrbKZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T6TED+FM; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Aug 2024 09:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724938377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FMYh2t/Xz06IccaIYuj8PThdY4q4wdLBkOxrHA87gG0=;
	b=T6TED+FMht0q0Dk5tidPaathkn2+ohL6nI1MGeFi5us1haLo+ggRUNhu0qAUGwtH9Hp5rB
	eblF+eWaDFMMxxJhCwe7KQxVGHZu9wXtip0wmFtBgOyjN5F06V9a+PM/SQlwjlcOeId2Ek
	UUUYcOya0qr4wKo+OFZ0keJMADwF7dg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: Michal Hocko <mhocko@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, 
	Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-bcachefs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <myb6fw5v2l2byxn4raxlaqozwfdpezdmn3mnacry3y2qxmdxtl@bxbsf4v4qbmg>
References: <20240826085347.1152675-2-mhocko@kernel.org>
 <20240827061543.1235703-1-mhocko@kernel.org>
 <Zs6jFb953AR2Raec@dread.disaster.area>
 <ylycajqc6yx633f4sh5g3mdbco7zrjdc5bg267sox2js6ok4qb@7j7zut5drbyy>
 <ZtBzstXltxowPOhR@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtBzstXltxowPOhR@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 29, 2024 at 11:12:18PM GMT, Dave Chinner wrote:
> On Thu, Aug 29, 2024 at 06:02:32AM -0400, Kent Overstreet wrote:
> > On Wed, Aug 28, 2024 at 02:09:57PM GMT, Dave Chinner wrote:
> > > On Tue, Aug 27, 2024 at 08:15:43AM +0200, Michal Hocko wrote:
> > > > From: Michal Hocko <mhocko@suse.com>
> > > > 
> > > > bch2_new_inode relies on PF_MEMALLOC_NORECLAIM to try to allocate a new
> > > > inode to achieve GFP_NOWAIT semantic while holding locks. If this
> > > > allocation fails it will drop locks and use GFP_NOFS allocation context.
> > > > 
> > > > We would like to drop PF_MEMALLOC_NORECLAIM because it is really
> > > > dangerous to use if the caller doesn't control the full call chain with
> > > > this flag set. E.g. if any of the function down the chain needed
> > > > GFP_NOFAIL request the PF_MEMALLOC_NORECLAIM would override this and
> > > > cause unexpected failure.
> > > > 
> > > > While this is not the case in this particular case using the scoped gfp
> > > > semantic is not really needed bacause we can easily pus the allocation
> > > > context down the chain without too much clutter.
> > > > 
> > > > Acked-by: Christoph Hellwig <hch@lst.de>
> > > > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > > 
> > > Looks good to me.
> > > 
> > > Reviewed-by: Dave Chinner <dchinner@redhat.com>
> > 
> > Reposting what I wrote in the other thread:
> 
> I've read the thread. I've heard what you have had to say. Like
> several other people, I think your position is just not practical or
> reasonable.
> 
> I don't care about the purity or the safety of the API - the
> practical result of PF_MEMALLOC_NORECLAIM is that __GFP_NOFAIL
> allocation can now fail and that will cause unexpected kernel
> crashes.  Keeping existing code and API semantics working correctly
> (i.e. regression free) takes precedence over new functionality or
> API features that people want to introduce.
> 
> That's all there is to it. This is not a hill you need to die on.

And more than that, this is coming from you saying "We didn't have to
handle memory allocation failures in IRIX, why can't we be like IRIX?
All those error paths are a pain to test, why can't we get rid of them?"

Except that's bullshit; at the very least any dynamically sized
allocation _definitely_ has to have an error path that's tested, and if
there's questions about the context a code path might run in, that
that's another reason.

GFP_NOFAIL is the problem here, and if it's encouraging this brain
damaged "why can't we just get rid of error paths?" thinking, then it
should be removed.

Error paths have to exist, and they have to be tested.

