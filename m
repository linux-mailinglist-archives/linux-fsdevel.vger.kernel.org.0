Return-Path: <linux-fsdevel+bounces-59181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931B5B358DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 11:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03FD3AD8DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 09:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481D12F83C1;
	Tue, 26 Aug 2025 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ea4ru5og"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E9629ACDB;
	Tue, 26 Aug 2025 09:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200490; cv=none; b=CGnAXMuGSvqkDhAm+crEvXiVhqMqnoC1PyfjgEauSr4ajbX3p7qAhaCAvkjcjUK+PguLDfeyEXTq4RJoCdT2tKTTCYCCdNn5ak0LxETW2i2z4cNJN/ezlVO7pLk+qq5x5UP4WzI/Ts8L76hpmRTzR3TDePvicLHQVLl0TvfDiT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200490; c=relaxed/simple;
	bh=O3iN0jD6PenlzfLPlOGEZZfLRHixSQ3x5jl4pZxP18E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6HoQyjqCo7tUyu52rbOiPvKm6tpwryH2qEq03EkOlYf4i6MY5W3zv5YXmykFoVHxwWEP43R9aWQhyczHn3wlwFwrqrGivP4bmwjFUGm1RXwWDVo7XPREpBsNBuUsmweUdjBn3CcAwY5Be+skKcttnuzV201FY5iKhK48ekOF5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ea4ru5og; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F39CC4CEF1;
	Tue, 26 Aug 2025 09:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756200489;
	bh=O3iN0jD6PenlzfLPlOGEZZfLRHixSQ3x5jl4pZxP18E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ea4ru5ogSJey9drBsOFOIkw+HwL0/JBeiPxEVKQ1jwG+HvvBhS/erYaM2Apw/mPgL
	 wh+1mKaQt56/fmi6l90Kq+ZKvc2lldJrxktURZwIpYs7bh3WU7a1zVYFaiya4VBhCY
	 ii8DoXbArqhxH/bjoEL7BE2SdKoBxTf4TbzilQx9kkGDkWLq+IjeMsbEOUOWOz2mlc
	 7wmEDBj23AdZKV6jjdDXOTiBfzCkuvVQWaCAyduVNQGFlWsBa/Pwr0AHZ02b29D12T
	 F6uZ+17nu6AA+Ql9sX0uTd7WjteHNpno9pLVPECeyBaXfwNBe+APx10ZARgm8b5FjD
	 ukv6+7OqKHpaQ==
Date: Tue, 26 Aug 2025 11:28:05 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 18/50] fs: disallow 0 reference count inodes
Message-ID: <20250826-benimm-muster-781f3fa24fe8@brauner>
References: <cover.1755806649.git.josef@toxicpanda.com>
 <6f4fb1baddecbdab4231c6094bbb05a98bbb7365.1755806649.git.josef@toxicpanda.com>
 <20250825-person-knapp-e802daccfe5b@brauner>
 <20250825192610.GA1310133@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825192610.GA1310133@perftesting>

On Mon, Aug 25, 2025 at 03:26:10PM -0400, Josef Bacik wrote:
> On Mon, Aug 25, 2025 at 12:54:01PM +0200, Christian Brauner wrote:
> > On Thu, Aug 21, 2025 at 04:18:29PM -0400, Josef Bacik wrote:
> > > Now that we take a full reference for inodes on the LRU, move the logic
> > > to add the inode to the LRU to before we drop our last reference. This
> > > allows us to ensure that if the inode has a reference count it can be
> > > used, and we no longer hold onto inodes that have a 0 reference count.
> > > 
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > ---
> > >  fs/inode.c | 53 +++++++++++++++++++++++++++++++++--------------------
> > >  1 file changed, 33 insertions(+), 20 deletions(-)
> > > 
> > > diff --git a/fs/inode.c b/fs/inode.c
> > > index de0ec791f9a3..b4145ddbaf8e 100644
> > > --- a/fs/inode.c
> > > +++ b/fs/inode.c
> > > @@ -614,7 +614,7 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
> > >  
> > >  	if (inode->i_state & (I_FREEING | I_WILL_FREE))
> > >  		return;
> > > -	if (atomic_read(&inode->i_count))
> > > +	if (atomic_read(&inode->i_count) != 1)
> > >  		return;
> > >  	if (inode->__i_nlink == 0)
> > >  		return;
> > > @@ -1966,28 +1966,11 @@ EXPORT_SYMBOL(generic_delete_inode);
> > >   * in cache if fs is alive, sync and evict if fs is
> > >   * shutting down.
> > >   */
> > > -static void iput_final(struct inode *inode, bool skip_lru)
> > > +static void iput_final(struct inode *inode, bool drop)
> > >  {
> > > -	struct super_block *sb = inode->i_sb;
> > > -	const struct super_operations *op = inode->i_sb->s_op;
> > >  	unsigned long state;
> > > -	int drop;
> > >  
> > >  	WARN_ON(inode->i_state & I_NEW);
> > > -
> > > -	if (op->drop_inode)
> > > -		drop = op->drop_inode(inode);
> > > -	else
> > > -		drop = generic_drop_inode(inode);
> > > -
> > > -	if (!drop && !skip_lru &&
> > > -	    !(inode->i_state & I_DONTCACHE) &&
> > > -	    (sb->s_flags & SB_ACTIVE)) {
> > > -		__inode_add_lru(inode, true);
> > > -		spin_unlock(&inode->i_lock);
> > > -		return;
> > > -	}
> > > -
> > >  	WARN_ON(!list_empty(&inode->i_lru));
> > >  
> > >  	state = inode->i_state;
> > > @@ -2009,8 +1992,29 @@ static void iput_final(struct inode *inode, bool skip_lru)
> > >  	evict(inode);
> > >  }
> > >  
> > > +static bool maybe_add_lru(struct inode *inode, bool skip_lru)
> > > +{
> > > +	const struct super_operations *op = inode->i_sb->s_op;
> > > +	struct super_block *sb = inode->i_sb;
> > > +	bool drop = false;
> > > +
> > > +	if (op->drop_inode)
> > > +		drop = op->drop_inode(inode);
> > > +	else
> > > +		drop = generic_drop_inode(inode);
> > > +
> > > +	if (!drop && !skip_lru &&
> > > +	    !(inode->i_state & I_DONTCACHE) &&
> > > +	    (sb->s_flags & SB_ACTIVE))
> > > +		__inode_add_lru(inode, true);
> > > +
> > > +	return drop;
> > > +}
> > 
> > Can we rewrite this as:
> > 
> > static bool maybe_add_lru(struct inode *inode, bool skip_lru)
> > {
> > 	const struct super_operations *op = inode->i_sb->s_op;
> > 	const struct super_block *sb = inode->i_sb;
> > 	bool drop = false;
> > 
> > 	if (op->drop_inode)
> > 		drop = op->drop_inode(inode);
> > 	else
> > 		drop = generic_drop_inode(inode);
> > 
> > 	if (drop)
> > 		return drop;
> > 
> > 	if (skip_lru)
> > 		return drop;
> > 
> > 	if (inode->i_state & I_DONTCACHE)
> > 		return drop;
> > 
> > 	if (!(sb->s_flags & SB_ACTIVE))
> > 		return drop;
> > 
> > 	__inode_add_lru(inode, true);
> > 	return drop;
> > }
> > 
> > so it's a lot easier to follow. I really dislike munging conditions
> > together with a bunch of ands and negations mixed in.
> > 
> > And btw for both I_DONTCACHE and !SB_ACTIVE it seems that returning
> > anything other than false from op->drop_inode() would be a bug probably
> > a technicality but I find it pretty odd.
> 
> Not necsessarily, maybe we had some delayed iput (*cough* btrfs *cough*) that
> didn't run until umount time and now we have true coming from ->drop_inode()
> with SB_ACTIVE turned off.  That would be completely valid.  Thanks,

Ah, right, thanks! Yeah, that's seems legit.

