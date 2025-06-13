Return-Path: <linux-fsdevel+bounces-51537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54978AD80BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 04:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB651E120E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 02:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006171DF742;
	Fri, 13 Jun 2025 02:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MQcj317D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F29190679;
	Fri, 13 Jun 2025 02:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749780075; cv=none; b=bb8bAFBx4P3e9zGDXUztjCMVF7kZPsuhhMAPeSV2XhQUYZMH3mBsrZmO0Z+oj0jBUfJO8inqMyghJPGTAu4nMRMt6fBtBrSfDD2vnSo4jDo7TKfZLhshNGFg2y/kg2bbTHHaDhNb2QBlYwdG2hLsnoTm16TLx3PSiZsqTmj8l5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749780075; c=relaxed/simple;
	bh=NUqXZbIF2PxxNbybudEPnBZX7TO9jM36gjeNJuIXgQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iv4/tsvXYd6B+n7smVjMUag2E8zNXbkLeg4nwsK4W+EFSPOTQ8RguAdFY7xC6XLG1oDYppbFwgk6JDAxJmBOSVLNJhTYhhlbHf2e/2hCOIoD8R9wq5wo0wBGmG7vj4Eqt7IG+20JEhbmilfMnZboyn52dFl0aYkpnmZeNnXo400=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MQcj317D; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PCD74P9rBhM5BWb+vDQDA0gUoD+FEe8gAbcb3Ihn/Sk=; b=MQcj317D1avppnw4FYcS+2tLAK
	oeQbQCr7oSjk7dSxtr2k+YWNvXBOBtpnAB5gfCmM/Pr2mAftbmRQ4vLuvhOtrnBIiZOpKIV1JcVfY
	xzhrw9pJ+L3IHi4/LfQ1qS0Pv7pwWfCsrbSWpq16GTXRv0bZgfSRLOxZv2smnyOJwf92CaQLpSCSL
	F/rwzTAJQzn1NMPf6Zd5UQR7OA4TUuvRX0KgzmBFEYONoncIqp6nTbolGztOPtR3VY21nkH7IUiyq
	I3zm62TtN7Zs6uJRsMlRysX+LfKos651u7tfZSY03rILxphvmWRzjFPgemWj982d/3hIr15LJCY97
	LgRBT4Aw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPtjD-00000004gvS-3MBg;
	Fri, 13 Jun 2025 02:01:11 +0000
Date: Fri, 13 Jun 2025 03:01:11 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>,
	linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] proc_sysctl: Fix up ->is_seen() handling
Message-ID: <20250613020111.GE1647736@ZenIV>
References: <174977507817.608730.3467596162021780258@noble.neil.brown.name>
 <20250613015421.GD1647736@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613015421.GD1647736@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jun 13, 2025 at 02:54:21AM +0100, Al Viro wrote:
> On Fri, Jun 13, 2025 at 10:37:58AM +1000, NeilBrown wrote:
> > 
> > Some sysctl tables can provide an is_seen() function which reports if
> > the sysctl should be visible to the current process.  This is currently
> > used to cause d_compare to fail for invisible sysctls.
> > 
> > This technique might have worked in 2.6.26 when it was implemented, but
> > it cannot work now.  In particular if ->d_compare always fails for a
> > particular name, then d_alloc_parallel() will always create a new dentry
> > and pass it to lookup() resulting in a new inode for every lookup.  I
> > tested this by changing sysctl_is_seen() to always return 0.  When
> > all sysctls were still visible and repeated lookups (ls -li) reported
> > different inode numbers.
> 
> What do you mean, "name"?

The whole fucking point of that thing is that /proc/sys/net contents for
processes in different netns is not the same.  And such processes should
not screw each other into the ground by doing lookups in that area.

Yes, it means multiple children of the same dentry having the same name
*and* staying hashed at the same time.

