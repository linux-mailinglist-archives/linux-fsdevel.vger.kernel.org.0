Return-Path: <linux-fsdevel+bounces-71557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 418D9CC75D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 12:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18A9E303CF45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 11:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E569352951;
	Wed, 17 Dec 2025 11:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hn20hfZz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8FD350D49;
	Wed, 17 Dec 2025 11:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765971472; cv=none; b=Va4uksKVIAc9YMRsXfc7ba5vN6+bYJxDm+BusKZ7h3YjMmcL7dRNydlECMw6VVP6ubxhAdzQ/vxjXuBk2Wo8VtXlbj3cHeeiU97lBWLyb5RtCe8lAG5EDKOE8Mkz7mv2Kh36Z6VDxJeO3WjzH8HNibGQY10Rejj8rhFrM5mCV78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765971472; c=relaxed/simple;
	bh=hv94ldSnNEiyF0ZgOoJCe+vsQ350mUf/T91OfNg5nFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOIiPOyLl4dJ1txI75U1XlXP8xACWQReq0y9IQuaG60aJrK1tMwdy5e1oHAlhHRT+n2n3iIponwTOD4YLmLpAXht2Tn40iIWuBZUOJTevCpvprBQMKITBh0iU/e9GfZXKWy4eSNa1emnZnnweUCMvuTEYu7TORNXCiUL64/JcMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hn20hfZz; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PzZ/FiF0IOF/tMIYGr+lNaite/koi+9Kq6NTUp1+yVs=; b=hn20hfZzycTxuNXQ7ok4Gm+ebX
	eD0pVI72MOR6o8mRXqetnT1/Jx8JzP+ZBDskKNfw4TtK0uIXBZWx0KYCYLIDqkNCMsVHXF4dweZD2
	aEzQgOAaoTLOFurWIhCzB268D30T6ld/57mhMuzK4MY2IuP+AQOmqkSC+q/PwAx4yuz/hASdHfgqx
	szIko1PmMYDvxQf1M03gHW1IZQUGMRIVpFMlUvrWnZ4cdVUc+kdmiR+IIM7Eb7/Kd1ud4ZME0LUnD
	Uo+GlMq/s2FjNWr5tiEFqtJv5rv+Z2+mOdd/j8BWu3U4iTz9rXYwUSW9CdLwQcJ/Blpb9o3tQdF56
	aiBnA6KA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vVprP-0000000FQzp-1ytZ;
	Wed, 17 Dec 2025 11:38:27 +0000
Date: Wed, 17 Dec 2025 11:38:27 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, clm@meta.com
Subject: Re: [RFC PATCH v2] fs: touch up symlink clean up in lookup
Message-ID: <20251217113827.GW1712166@ZenIV>
References: <20251217112345.2340007-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217112345.2340007-1-mjguzik@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Dec 17, 2025 at 12:23:45PM +0100, Mateusz Guzik wrote:
> Provide links_cleanup_rcu() and links_cleanup_ref() for rcu- and ref-
> walks respectively.
> 
> The somewhat misleading drop_links() gets renamed to links_issue_delayed_calls(),
> which spells out what it is actually doing.

IMO the replacement name is worse; it doesn't say anything about
the purpose of those "issued delayed calls", for starters.

> There are no changes in behavior, this however should be less
> error-prone going forward.

I disagree, but at the moment (6:30am here, and I'd been up since 11am yesterday ;-/)
I don't trust my ability to produce coherent detailed reply.  I'll reply in detail
once I get some sleep...

