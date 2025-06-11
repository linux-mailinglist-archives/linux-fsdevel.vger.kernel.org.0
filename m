Return-Path: <linux-fsdevel+bounces-51217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691BFAD47C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 03:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 986283A840E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 01:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF63322615;
	Wed, 11 Jun 2025 01:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hqs1Q6xW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EEC4C80
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 01:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749604392; cv=none; b=IjRv5QcGPlsySZzZ8AoQZY3ZWEI7y2bpc0QTgvVTAUQmW6PSviyOEH3xRXmQ1R6wGg4yX214jOPN63a2SV/WYmqHeuqbpYCd+mWfMVo0tbPM7zYJIl0lOisntEL14oZxr06reDTXXW8mPejFvnZ/E3DvaIhAm1VUvpdkQKJwqI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749604392; c=relaxed/simple;
	bh=AjTl62TMnpgSn3017tpohVzyIZqI3HMGdDwi2tRgghA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFS0CadwugSu79+3N0e53tmXcdKArjS80N2l1s8/vjvyw/MyTiBbYq3Tef6wxo0VP7OiuQ2gqL9wGeeyJUV7bUvuL91XFC5o4OAid4TeBowoWJk6WU2/PnI1MrRyEGNWfs6F8DuBrymkBoW33QjDkLeD5vql2gRchLfKuWmRgh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hqs1Q6xW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+173dFevUk9aAIlNEWcst117XM2PcZOiQHmHqZSmYYA=; b=hqs1Q6xWzKMsmPsXG/KaywFuRD
	Pzu4KgOy3Gx4nMIxlV4/4AQM58EbZq+Xjcno9cUBFOfChCgjO0HW8A70R7Wka4GsnCGMTHXHSsrVI
	I+ckgXDWxCs36rk9WPFU17CjL9Cu+u9cQbQ6RVTXGnr2Mh+9W0pnLbUeVVqntha5UyfVtql/0Pn2O
	cVnAvARLpsS8O5gujc091Qr+/7lQWvt648hc3G9lGNyEHvin2g66LAiirJ4WAxMOwzxAfySYD555o
	5zu9aT+pluuMm00PvvC58fZBxS9M1H3kr9UcRDOXOuOu7qjTwfgu7srpxE25q6+du+PyLLiMSXtZw
	SCp9+U7A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPA1b-0000000DpUU-0eeD;
	Wed, 11 Jun 2025 01:13:07 +0000
Date: Wed, 11 Jun 2025 02:13:07 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/8] Introduce S_DYING which warns that S_DEAD might
 follow.
Message-ID: <20250611011307.GI299672@ZenIV>
References: <>
 <20250610205732.GG299672@ZenIV>
 <174960360675.608730.17207039742680720579@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174960360675.608730.17207039742680720579@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jun 11, 2025 at 11:00:06AM +1000, NeilBrown wrote:

> Yes.
> 
> > 
> > Where does your dentry lock nest wrt ->i_rwsem?  As a bonus (well, malus, I guess)
> > question, where does it nest wrt parent *and* child inodes' ->i_rwsem for rmdir
> > and rename?
> 
> Between inode of parent of the dentry and inode of the dentry.

That's... going to be fun to prove the deadlock avoidance.
Looking forward to such proof...

Look, the reason why I'm sceptical is that we had quite a few interesting
problems with directory locking schemes; fun scenarios are easy to
miss and I've fucked up more than a few times in that area.  Fixing it
afterwards can be a real bitch, especially if we get filesystem-specific
parts in the picture.

So let's sort it out _before_ we go there.  And I mean proof - verifiable
statements about the functions, etc.

Incidentally, what was the problem with having dentry locked before
the parent?  At least that way we would have a reasonable lock ordering...
It would require some preliminary work, but last time I looked at the
area (not very deeply) it felt like a plausible direction...  I wonder
which obstacle have I missed...

