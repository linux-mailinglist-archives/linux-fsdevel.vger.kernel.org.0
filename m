Return-Path: <linux-fsdevel+bounces-30129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3198B98695F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 01:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61FF91C23D1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 23:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C74818BC2D;
	Wed, 25 Sep 2024 23:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wCdSFWDD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354DC18892F;
	Wed, 25 Sep 2024 23:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727305605; cv=none; b=utJm+W037KinbohuK5lXDYo3mSJKxQG7H7egR6HUtQ1YvZTMsIrXHLPgjvuOhXqHo0JWEHYUQ35+i2TjbE6zz9YwEDrekHp+z0SHHNdQazvGNcLf+vOJ7LgOaiBTgHa2lhGGt7TNKf5hZW1INAfueGz1v1jmaccFfW+qBn9BAow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727305605; c=relaxed/simple;
	bh=xVYXKaTqaVx9N4xkbegVh9lQ9UzxsWDgsAP0J/ZPiZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlRk33BmXGu0xAZK0ky9WwCsY3HyayZFvEmJSD2BEflsxyFtbI5IlUUKQDUBAWsZuQ3cTDrctqOgXmoJYIDtqgsT+8bWlHqFBDG3gO5VQlPzb6zvf0xBUI0FeAVE4nizMDEtwbrnTxxf+ZSlWjbSBOOkzhoYfC5lmYidIe4pXB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wCdSFWDD; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yrtMYChdvuNMjr/HrbESblHOkh2HUcwTiLzEeoF61Qc=; b=wCdSFWDDtPmieNNa5habCpb8iV
	pjtv94OgnfkRPMzDp+x63IFYPnrtloPivr+yTfz2hxEPMDffzcbOTYsgCEv2iSUOnK5vIXnF/FTk7
	KrohG5eSKhojEUGaiCjIIeM/cQe6VYwOSOMXcRWSb+1qbZRIwI8++yqRGZgTMIR5unE+9Ue7w0h7q
	mkUOSWe80AXjcZBuGCr2dOXzizrnkpaGRRzi1uFq8oeW6oisTlTduvobh/lMJjSbl+8xiZPWPTC7e
	SQoTF9mw/pWElBpvVxdy5nOzBRgY3/AVK47LdeUm0CwlcMiMb3kDtSWKuwCq11El+yjr06MGAvW9X
	nFfy7Esg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1stb5k-0000000FWdO-2oQc;
	Wed, 25 Sep 2024 23:06:40 +0000
Date: Thu, 26 Sep 2024 00:06:40 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH - RFC] VFS: disable new delegations during
 delegation-breaking operations
Message-ID: <20240925230640.GN3550746@ZenIV>
References: <172646129988.17050.4729474250083101679@noble.neil.brown.name>
 <20240925221956.GM3550746@ZenIV>
 <172730412642.17050.14414465745251978669@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172730412642.17050.14414465745251978669@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Sep 26, 2024 at 08:42:06AM +1000, NeilBrown wrote:

> I don't think so.
> The old delegated_inode_new will be carried in to vfs_rename() and
> passed to try_break_deleg() which will notice that it is not-NULL and
> will "do the right thing".
> 
> Both _old and _new are initialised to zero at the start of
> do_renameat2(), Both are passed to break_deleg_wait() on the last time
> through the retry_deleg loop which will drop the references - or will
> preserve the reference if it isn't the last time - and both are only set
> by try_break_deleg() which is careful to check if a prior value exists.
> So I think there are no leaks.

Yecchhhh...  What happens if break_deleg() in there returns e.g. -ENOMEM
when try_break_deleg() finds a matching inode?

I'm not even saying it won't work, but it's way too brittle for my taste ;-/

