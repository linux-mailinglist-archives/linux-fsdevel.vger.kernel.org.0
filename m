Return-Path: <linux-fsdevel+bounces-59136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B473CB34B98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 22:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0812F7A4A18
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 20:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342E6275AF0;
	Mon, 25 Aug 2025 20:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="U6M1h2L7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71161DE2D7
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 20:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756153106; cv=none; b=i94dALxU5naQgp+lV+5dyAfEyInXmb6YQs/kYpFFiqB6pzMc+B4XWVj2tgC6Qxlme9wRK6SETsWIyh5M7FBezNsO151WQYKtgtT5ZW+1Q4RO/08O8ZMbHYg1oTgJW0cZNHPDzIwEPRNJZxa2pa4AiqaR1rjpKZEVMpeRPLsQWdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756153106; c=relaxed/simple;
	bh=fiqKOy77eYS07WWKIXLlEwMifMk4aqNeJlIdjLlvJjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYWVgVuH0GpDyc0Ep0CRsDg0yViIeSvW5oKiYiBF0lYAZHbWw67s/fJuUSNNaw+GZ8fBlIz2fV6SND2ApqlTa/EbY5aYDw3LMXpHew1dFVmr7IviGoI4we9Ioy5gBrv1JF7CVUKhtJoB2fVEppPpXdZVJpM12KTUT/2nFQK4E4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=U6M1h2L7; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-121-146.bstnma.fios.verizon.net [173.48.121.146])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 57PKI4Xn031801
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 16:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1756153087; bh=UTyoW2izf9GPlI5+e+q40qCjoiUUqbN8XEyZ9SBw5Qk=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=U6M1h2L749vgUm5d6jeBMPriCOX0pCKCjJ51wApUbieWgpgGQgTZc/Ifx1GUUP3Hx
	 ZQqy4qdWkhaWmaLdM2nkaR/BsYaNXIGjlQ8ts1XXMa5SyETduI3dnCK2NX+0rmCPjC
	 oP8nu9RWJb3GbSUpVtVuGkJwTgnUBIWqaxUVfTnxTs2/Tsro0LeNxCOXv1rmZiLe0a
	 iRUzwf/S66PqeQ9Scoh8l2+Nj9QHK6dbhrbbgmH8M+SUKR0rKXu9EkFvXFxEJkJNTu
	 5VWWzrlK0gKve7i5+RFagZJ0tBAYtZ/1dJgYiurUZosKsHMKcD6PPn146QYpLhyZbV
	 R9QMQzE41BM9A==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id B99B52E00D6; Mon, 25 Aug 2025 16:18:04 -0400 (EDT)
Date: Mon, 25 Aug 2025 16:18:04 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCHED][RFC][CFT] mount-related stuff
Message-ID: <20250825201804.GA1603531@mit.edu>
References: <20250825044046.GI39973@ZenIV>
 <20250825-glanz-qualm-bcbae4e2c683@brauner>
 <20250825161114.GM39973@ZenIV>
 <20250825174312.GQ39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825174312.GQ39973@ZenIV>

On Mon, Aug 25, 2025 at 06:43:12PM +0100, Al Viro wrote:
> I mean, this _is_ what I hope would be a discussion of that stuff -
> that's what request for comments stands for, after all.  How is that
> supposed to work?  Going back through the queue and slapping lore links
> at the same time as the reviewed-by etc. are applied?

Lore links are useful when a maintainer is applying someone else's
patches into their git tree.  I think that's what Christian was
thinking about.  In this case, however, where the maintainer is the
one autoring/sending the patches the patches, there is the
chicken-and-egg prblem that you've described, and so I don't
understand why Christian has made that request.

Usually I just construct the lore URL from the Message ID from the
patch series, but what I've seen other olks do for very large patch
sets is that they'll also publish the patches on git, for example from
Darrick's recent fuse/iomap patches, he included a link in the
patchset cover letter to:

https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache

							- Ted

