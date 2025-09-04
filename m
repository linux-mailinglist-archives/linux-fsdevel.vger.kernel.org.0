Return-Path: <linux-fsdevel+bounces-60269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF85B43B5B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 14:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DDF37C1DB5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 12:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26F4287267;
	Thu,  4 Sep 2025 12:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="t82d6lIT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184992773CB
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 12:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756988321; cv=none; b=R9YCSYXiKjz6bM1hV5GWe4y30Tji/XLW5jAMvEkRR5kS8SqzKZzwSBpG4tSh2+pXx6JQvGsOkWPa+IQJRnnQ4z4RPBZh5i0ahCJZ+qevaYI/pAxiaef1Oohv4XOs7qWOF+W8WTOuRHQL70XdvD/Bk/PXzmzeUpoIL+mPDCr2cGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756988321; c=relaxed/simple;
	bh=O+fmhNDnfriW/CrDMSv1sKFfrH/YMKi23TpuE36ZHf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mucgmkD0Uiy+d7Kv7WCp8zitKNznKRQUjqQkP8wzipahLkrDqezGILwSGPory7zfXZ/oAlDcKXLenEAQi3HjriFNgp7PHFUfuFtLfmKc1J9C31iqAC8hd3z+z2kr5PuwysvMx7S8WJTmOXWQ802ypnDAx9VY/0ujWv49+4xG6NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=t82d6lIT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uFCLS3pJ8t3bQm1VwY7Wirh9MMSwgQnfRsfmBY+FBQw=; b=t82d6lIT8x0EZVKMNELLws/RG6
	1CHbYccEbDb544bfA5Cm3QaXwva8HERMvPey9udDMJbIDh2q2lH9bYyen1PqucP8rZQit3GSUdVzF
	9jFlSJJO/9k9c0MkvSmP8dvRNjHCalQBdJsDiAAd4r34xjyK7SuP88W6ITkE1lWaQCsC/kofYeBGi
	8Gqp2V9gDIkFYWxpVjgHEloiRh42JTtgAv15rGBzlXFauUbpC6L1bExE5xsflsx//t/dAmeBSJzdg
	KOOmnCBnJv5+1A3UZRA58lQc/gyimRzGy4YxiGd/e1BXDvQF7Wvzhnj3RwrdDB0WUxlV8CObHB9Ms
	rP3b9/jA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uu8vE-00000001E1b-0dKQ;
	Thu, 04 Sep 2025 12:18:36 +0000
Date: Thu, 4 Sep 2025 13:18:36 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Dave Chinner <david@fromorbit.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCHES v3][RFC][CFT] mount-related stuff
Message-ID: <20250904121836.GO39973@ZenIV>
References: <20250825044046.GI39973@ZenIV>
 <20250828230706.GA3340273@ZenIV>
 <20250903045432.GH39973@ZenIV>
 <CAHk-=wgXnEyXQ4ENAbMNyFxTfJ=bo4wawdx8s0dBBHVxhfZDCQ@mail.gmail.com>
 <20250903181429.GL39973@ZenIV>
 <aLjamdL8M7T-ZFOS@dread.disaster.area>
 <20250904032024.GN39973@ZenIV>
 <20250904055514.GA3194878@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904055514.GA3194878@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Sep 04, 2025 at 06:55:14AM +0100, Al Viro wrote:

> Bugger...  Either I've got false 'good' at several points, or it's something
> brought in by commit 2004cef11ea0 "Merge tag 'sched-core-2024-09-19' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip" - bisection has
> converged to something within the first 48 commits of the branch in question.
> 
> Which is not impossible, but then the underlying race could've been there
> for years before that, only to be exposed by timing changes ;-/
> 
> Anyway, I'll get the bisection to the end, but it looks like the end result
> won't be particularly useful...

It's definitely within that branch; breakage reproduce on dae4320b29f0
"sched: Fixup set_next_task() implementations" and does *not* reproduce
on 8e2e13ac6122 "sched/fair: Cleanup pick_task_fair() vs throttle"

Trying to bisect it further runs into a bisect hazard left there -
commit 54a58a787791 "sched/fair: Implement DELAY_ZERO" has
+SCHED_FEAT(DELAY_ZERO, true)
and
2e0199df252a "sched/fair: Prepare exit/cleanup paths for delayed_dequeue" -
+               if (sched_feat(DELAY_ZERO) && p->se.vlag > 0)
6 commits before the definition.

I'm not going to try and reorder that branch into something bisectable -
I do not know that area anywhere near well enough for that.

In any case, I doubt that it's a scheduler bug; something exposed by
the timings change, but that's about it...

