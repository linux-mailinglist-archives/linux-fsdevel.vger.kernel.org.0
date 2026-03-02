Return-Path: <linux-fsdevel+bounces-78878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YB8dJ6VipWmx+wUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 11:12:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 008011D6276
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 11:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83FC03055DE1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 10:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE6B395D93;
	Mon,  2 Mar 2026 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HodwTgYJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7DE38F22B;
	Mon,  2 Mar 2026 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772446019; cv=none; b=LKfs1xFPyNlS05EEYywEo5cfBhi3Hb2SkPZZ+sHpmweJcnWp2CzrFpjLAr8AH+2zqqTHim82+w84nURKrCYwutjMUz4CSVddBLftUY5pon9ws9Owiv7ybZUdEv8WHjX+FF4p/GI17YWtWXtS/TwuqsLmKXWCeuIzPL1V6oLS2W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772446019; c=relaxed/simple;
	bh=g3floAcObkvaeafCOJ6rhcIBNt3NL60xTBljK0LwcnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpL0rIi3du3z69TolC/CKvmOOYl53/GAN/BfX2exDwVzusXg7uKTjiHOlM6L/6RYonlHbnpO42qloLU/Y4H2GJOVNghQl7Dlt1Jkt4+9WAFfhR2cppdP0GoahrfpZ6aDk9hffoet0cWJfVC46kEnnOKRJ+LvL88BxGMzGFdtvdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HodwTgYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9137CC19425;
	Mon,  2 Mar 2026 10:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772446019;
	bh=g3floAcObkvaeafCOJ6rhcIBNt3NL60xTBljK0LwcnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HodwTgYJRXawuioz6fWJbfhRDuJN9ptuur5qsUNjgkqN0KmODfHpQRQJWspSniAjF
	 nVtktb3KfiT7easFF+PRVx8w7mBAOpd5sCjcthpTJ3rarmA49p/diJ+WKo9u34xOHI
	 +4LbxYX7+gfPmg2CerBaEUWWDTI8Q7YkEwTvFnc7LXMvrTRT5xuFHe2VxdL+g2zejF
	 FBhUl2mXFNvFK0jRBjJP9o0K+HCO/fHK1HLTjuHwUWkcA6gcguQtkJeeIKNpxW6XI3
	 uTzyGPL3Qqs2GuL+HH1BfT7mBnEZA4ml1+oVXaxlNsY01vGXZW0eoWfRuy58lxNrYu
	 DKAwDOS8XRyIA==
Date: Mon, 2 Mar 2026 11:06:54 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>, linux-mm@kvack.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jann Horn <jannh@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 04/14] kernfs: adapt to rhashtable-based simple_xattrs
 with lazy allocation
Message-ID: <20260302-wahnsinn-bettdecken-2107be02c746@brauner>
References: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
 <20260216-work-xattr-socket-v1-4-c2efa4f74cb7@kernel.org>
 <3cnmtqmakpbb2uwhenrj7kdqu3uefykiykjllgfbtpkiwhaa4s@sghkevv7jned>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3cnmtqmakpbb2uwhenrj7kdqu3uefykiykjllgfbtpkiwhaa4s@sghkevv7jned>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78878-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.461];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 008011D6276
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 04:00:37PM +0100, Jan Kara wrote:
> On Mon 16-02-26 14:32:00, Christian Brauner wrote:
> > Adapt kernfs to use the rhashtable-based xattr path and switch from an
> > embedded struct to pointer-based lazy allocation.
> > 
> > Change kernfs_iattrs.xattrs from embedded 'struct simple_xattrs' to a
> > pointer 'struct simple_xattrs *', initialized to NULL (zeroed by
> > kmem_cache_zalloc). Since kernfs_iattrs is already lazily allocated
> > itself, this adds a second level of lazy allocation specifically for
> > the xattr store.
> > 
> > The xattr store is allocated on first setxattr. Read paths
> > check for NULL and return -ENODATA or empty list.
> > 
> > Replaced xattr entries are freed via simple_xattr_free_rcu() to allow
> > concurrent RCU readers to finish.
> > 
> > The cleanup paths in kernfs_free_rcu() and __kernfs_new_node() error
> > handling conditionally free the xattr store only when allocated.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> ...
> 
> > @@ -584,6 +582,12 @@ void kernfs_put(struct kernfs_node *kn)
> >  	if (kernfs_type(kn) == KERNFS_LINK)
> >  		kernfs_put(kn->symlink.target_kn);
> >  
> > +	if (kn->iattr && kn->iattr->xattrs) {
> > +		simple_xattrs_free(kn->iattr->xattrs, NULL);
> > +		kfree(kn->iattr->xattrs);
> > +		kn->iattr->xattrs = NULL;
> > +	}
> > +
> >  	spin_lock(&root->kernfs_idr_lock);
> >  	idr_remove(&root->ino_idr, (u32)kernfs_ino(kn));
> >  	spin_unlock(&root->kernfs_idr_lock);
> 
> This is a slight change in the lifetime rules because previously kernfs
> xattrs could be safely accessed only under RCU but after this change you
> have to hold inode reference *and* RCU to safely access them. I don't think
> anybody would be accessing xattrs without holding inode reference so this
> should be safe but it would be good to mention this in the changelog.

Done.

