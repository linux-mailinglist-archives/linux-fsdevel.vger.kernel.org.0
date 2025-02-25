Return-Path: <linux-fsdevel+bounces-42621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE779A45110
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 00:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703C6188F71D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 23:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D2F235BE5;
	Tue, 25 Feb 2025 23:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iQraQPNH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9357B1A2392
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 23:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740527794; cv=none; b=JbNZ5C1ClcPcOPGsnGo0OiF/5lLPle1N/F0yM6cCJ8mq8hm3v7TYm+yXDVMQvnIWSOjae091egf7NZkezASFRPrR3hXnFzx5IFn9wLagpBVK3SyjONRgcgNwnOtynvNfbsaoTE3Ro1CcEQov7OGEEdnOh8lEK0rNxsJmy3XyLtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740527794; c=relaxed/simple;
	bh=hjQtGFs+Q3kljwTc+DEMx9YoDYFloJK+5irr67GswcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcFCPFooxkpalsVL57fnx5yEZwCOsaSKbOs6QM+8CpZOoQTk02p0HShzrYh20sgf/ak9L9frfSDXjfV9oNlbnxc9YP12Hsyt7vak/6mIRwtSHMb6U/32UNl+TlFkXmBTo5jJFaJsoO3BW33vZ3U2bvpOvz+F7CWGT04Te+9ZIpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=iQraQPNH; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p4Hq/3BAEfyylVgZIRys/xg0UojbZUdqkBf6knGSBBQ=; b=iQraQPNHJciCe2pCwO3GUYWtPu
	afdkrr6n0H2Axte/JkALw+PbTMyHqLp8OCa+wYSfn31e6QkFgRVmOSvYH+54a0Bh/1O/K+/I2yCDx
	OCHuqxxyI5IlZPjLmZEj3F7obXAZsZdFmQu11qBJshDuFjkAlDwA/3KKzaZB+nJIpt6mHo0wlhRDb
	tTuvKbH1G2y5JmAYzce718Y7IKDvaCGMZoKuOXafMXWSOKy+O09naAn5h0Ew7lq3NtNYUVDXyETsj
	RRlqK2nC0iP3hzonwtcpQ/HGe5OiGPGGufvMj+kLNGlxdI5Zztx5hQQZTlXEFFtgZtwIsVLK6Da83
	dEotZWUw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tn4mr-00000008adZ-1al9;
	Tue, 25 Feb 2025 23:56:29 +0000
Date: Tue, 25 Feb 2025 23:56:29 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH 01/21] procfs: kill ->proc_dops
Message-ID: <20250225235629.GC2023217@ZenIV>
References: <>
 <7xagwr27m3ygguz7nv53u5up2jnzjbuhqcadzwjz7jzmafp4ct@rgkubaqwpwah>
 <174052622191.102979.9523419116370013917@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174052622191.102979.9523419116370013917@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Feb 26, 2025 at 10:30:21AM +1100, NeilBrown wrote:
> On Wed, 26 Feb 2025, Jan Kara wrote:
> > On Mon 24-02-25 21:20:31, Al Viro wrote:
> > > It has two possible values - one for "forced lookup" entries, another
> > > for the normal ones.  We'd be better off with that as an explicit
> > > flag anyway and in addition to that it opens some fun possibilities
> > > with ->d_op and ->d_flags handling.
> > > 
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > 
> > FWIW I went through the patches and I like them. They look mostly
> > straightforward enough to me and as good simplifications.
> > 
> 
> Ditto.  Nice clean-up
> It might be good to document s_d_flags and particularly the value of
> setting DCACHE_DONTCACHE.  That flag is documented in the list of
> DCACHE_ flags, but making the connection that it can usefully be put in
> s_d_flags might be a step to far for many.

Probably...  The thing is, I'm resurrecting the DCACHE_PERSISTENT
patchset (aka tree-in-dcache stuff) and that will have non-trivial
interplay there.  But you are right - it's probably worth documenting
that thing in this series.

Re documentation - I'll be posting bits and pieces of dcache
docs/audit/proofs of correctness over the next few weeks; at some
point we'll need to collect that into a single text, but at the
moment what I've got is too disjoint for that.  OTOH, we could
start a WIP variant in D/f/<something> and have it augmented as
we go...  Not sure.

