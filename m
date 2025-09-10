Return-Path: <linux-fsdevel+bounces-60733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8E1B50CBF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 06:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C4071BC5C47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 04:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E563A2686A0;
	Wed, 10 Sep 2025 04:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZrDHZKu5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F6D286885
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 04:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757477824; cv=none; b=s43fmSlTnP7rpNXzNRZv/n5/wshZ9vcF070COguoWc1kuwLmACFFTomeplWhxeGuBGUwMEt6kfy2rbQhQc7WDYm7ZOfysqwtnWzbdipnKmhN9iS0BNKBz626yIDOlFIKevtV0Elo1H+0SKh1eXj6NmbOo7XxOsXGj/g3W5wgI/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757477824; c=relaxed/simple;
	bh=/laTe3PlHjA19ga2uBuAmEqCgdyXYIkkxAoOSezHTWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R83/SokMypmSnNsnuAyFo8BhJ+QfdVfCFMnWHeBujqN8JRxLKCf/GYrVZInRidS0MxWm7EhHUbX/kmLD/QLsE8nE8dsPlc75u7qhIk9CorJsngA3w+1iQgxWmk/N5GncRDzWaGoBfI4cdV6dPK+hiCTJLsyl69dR9oprOOrvWco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZrDHZKu5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hb8VCXTm1wZ4gkaOq82hZUwwhjKffA5MeETwHGEMr+w=; b=ZrDHZKu5kGw20I+4s1U1aCKSJ8
	ktf1K/ssT+rIPzODIfxHvLlM0lq7knib3HkP/dSkQyEPsfCmg6CH0cI4JI6gHB9a7ktIPJeIUBLfx
	r7Iuuu3WFDhfgqeCEFQDNb3gs7pe8/jguA0NB1DO5t+35RjpvDwfPCHGdHmMl9R0cD25FEm6H4nmX
	RsFLM6ms2UOSeJA1w3AnoEq013iEwcyu9OE7KQoLkRt4z82R0oyPkmdcHcwipU9vIQzmNz47nsJvJ
	9hCMZP+ZeMe5rdlWquCYmbS1Z1ThwlmPWGDH7qL8YWsQhIwlLBIfVAIMdMoP1pNJbTngfIg8rmSb0
	1c7iLzJw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwCGQ-0000000EJ4F-2s4u;
	Wed, 10 Sep 2025 04:16:58 +0000
Date: Wed, 10 Sep 2025 05:16:58 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] Use simple_start_creating() in various places.
Message-ID: <20250910041658.GQ31600@ZenIV>
References: <>
 <20250909081949.GM31600@ZenIV>
 <175747330917.2850467.10031339002768914482@noble.neil.brown.name>
 <20250910041249.GP31600@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910041249.GP31600@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 10, 2025 at 05:12:49AM +0100, Al Viro wrote:
> On Wed, Sep 10, 2025 at 01:01:49PM +1000, NeilBrown wrote:
> > On Tue, 09 Sep 2025, Al Viro wrote:
> > > On Tue, Sep 09, 2025 at 02:43:21PM +1000, NeilBrown wrote:
> > > 
> > > >  	d_instantiate(dentry, inode);
> > > > -	dget(dentry);
> > > > -fail:
> > > > -	inode_unlock(d_inode(parent));
> > > > -	return dentry;
> > > > +	return simple_end_creating(dentry);
> > > 
> > > No.  This is the wrong model - dget() belongs with d_instantiate()
> > > here; your simple_end_creating() calling conventions are wrong.
> > 
> > I can see that I shouldn't have removed the dget() there - thanks.
> > It is not entirely clear why hypfs_create_file() returns with two
> > references held to the dentry....
> > I see now one is added either to ->update_file or the list at
> > hypfs_last_dentry, and the other is disposed of by kill_litter_super().
> > 
> > But apart from that one error is there something broader wrong with the
> > patch?  You say "the wrong model" but I don't see it.
> 
> See below for hypfs:

... and see viro/vfs.git#work.persistency for the part of the queue that
had order already settled down (I'm reshuffling the tail at the moment;
hypfs commit is still in the leftovers pile - the whole thing used to
have a really messy topology, with most of the prep work that used to
be the cause of that topology already in mainline - e.g. rpc_pipefs
series, securityfs one, etc.)

