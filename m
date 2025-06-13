Return-Path: <linux-fsdevel+bounces-51545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FB7AD817E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 05:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141893B5EA2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 03:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2336C253350;
	Fri, 13 Jun 2025 03:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="AlZriJi0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B25824676E;
	Fri, 13 Jun 2025 03:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749784455; cv=none; b=TYJdDW2tsfsN1Z99OWPgFA3lSfuKN5wjvbFvfpB6FPOmOkJv/OWTj8JkikXUyBH4LNZDDgd9ZX6vCNfB6XnKui1yfD4O5JA1tpXbrQMuJIq8XKr5d4/vwJ6PwFbyxDoTlVqIF542F7GdUQC6AI3dmzJ5rpd5yLZFD81UqVXyXZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749784455; c=relaxed/simple;
	bh=HE+g2t8+44f4zR1L1lGY4Jw1mqV4Icb0EfC0KFwqHY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8QLs1cTldOxHP6BXGjf2GLt8U2O9IRjGas6DiDAuDVmV+9+6Bs1nBl1S8hN79qKt+1VnPBxwg+Scrnog+tkzUKeiwoG8R/psHgZE2VuMHN3h4ekkl+0YMNcY1SvkgAz1Amti9FNkI8Sz2SOGmMYGLYx82eQA/aK+31R9NyOjcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=AlZriJi0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fXHeiFVBZbW7pKN3Egobq3xvQoHMALrpO53rjShEvQg=; b=AlZriJi06ScczqPovgk07QKijU
	vW+8YWeKcKrPGaievLLhpybCAE5CSEUK/Ui4UT6I6SxDDkTE52yg/cW9EfzIIuwi8j+5ZqPzS0eCG
	Xc8e6xRjZvrWwU270TlelaD6e9Hjb4Hmi+9ItoRPfKEzdE578GUDTdMMG23AWSYCd7DoXx3xqQ2it
	HkOvA5p7qkkQO7p5Y+B1QyfcvFXC7o4jTulAgOrHPP51dBFIc4I4nld9W9yguvsJzqjGcht/T7TbA
	bdYO89eU5pn+4GHPYV98Xtno64T+BvPG2rJ23bAuKhqDlax3O6RVAhvGgy6GHmn6HfN90wn0JsABE
	BDHWV/fg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPurr-00000005O2k-44h7;
	Fri, 13 Jun 2025 03:14:12 +0000
Date: Fri, 13 Jun 2025 04:14:11 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>,
	linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] proc_sysctl: Fix up ->is_seen() handling
Message-ID: <20250613031411.GH1647736@ZenIV>
References: <>
 <20250613020111.GE1647736@ZenIV>
 <174978225309.608730.8864073362569294982@noble.neil.brown.name>
 <20250613024134.GF1647736@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613024134.GF1647736@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jun 13, 2025 at 03:41:34AM +0100, Al Viro wrote:
> On Fri, Jun 13, 2025 at 12:37:33PM +1000, NeilBrown wrote:
> 
> > If two threads in the same namespace look up the same name at the same
> > time (which previously didn't exist), they will both enter
> > d_alloc_parallel() where neither will notice the other, so both will
> > create and install d_in_lookup() dentries, and then both will call
> > ->lookup, creating two identical inodes.
> > 
> > I suspect that isn't fatal, but it does seem odd.
> > 
> > Maybe proc_sys_compare should return 0 for d_in_lookup() (aka !inode)
> > dentries, and then proc_sys_revalidate() can perform the is_seen test
> > and return -EAGAIN if needed, and __lookup_slow() and others could
> > interpret that as meaning to "goto again" without calling
> > d_invalidate().
> 
> Umm...  Not sure it's the best solution; let me think a bit.  Just need
> to finish going through the ported rpc_pipefs series for the final look
> and posting it; should be about half an hour or so...

FWIW, I think we need the following:

	mismatch in name/len => return 1
	in_lookup => return 0, let the fucker get rechecked later when
it ceases to be in_lookup; can only happen when we are called from
d_alloc_parallel().
	otherwise, NULL inode => return 1; we are seeing a dentry halfway
through __dentry_kill(); caller is a lockless dcache lookup, under RCU
	otherwise, check ->sysctl and sysctl_is_seen().

And yes, you do need rcu_dereference() there.  Caller must be holding
rcu_read_lock or dentry->d_lock or have a counting reference to dentry.

