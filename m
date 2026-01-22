Return-Path: <linux-fsdevel+bounces-75059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GPvIhJGcmnpfAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:45:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30691691FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6A973009FB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 15:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE3944A725;
	Thu, 22 Jan 2026 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j6JxqPze";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0iqPGW1a";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j6JxqPze";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0iqPGW1a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1CA449EA3
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769096542; cv=none; b=nQCkQit59iq36fYY/8Z/uMduisIYnl9tjMRgBbg4Q4aZDXT8k7+Z7DEoEMACZrameaeWMxusmIYV9jcdhSexGiRp65tKsip4gpn1sqKgg0KsYpwBLJ0k0/UsJ5QT6lAjhT0TkxzoZMNACq1JBNyf1v5/tdqXT2xH4Ce6oUo7Bzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769096542; c=relaxed/simple;
	bh=lvRJnEpqGKml9ZZukNMsShpYKPXGJJ3h5jLBmdm7izg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQPzw90+DFHTosoI7U8PRcnYBZrk1HVvgkovuezyQpdBy4Z97hsrv4sobwZ7i0zuL115asAw3EvXdOZlkwDGU32+0p5XoYFRPCAa95b5VVt4CypPIWvnIw1iT7TJIWi308EzdvVwFVzJU/9RRvzqs3IpM2vuOwgatSk+JZGvMRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j6JxqPze; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0iqPGW1a; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j6JxqPze; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0iqPGW1a; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6FE955BCD7;
	Thu, 22 Jan 2026 15:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769096536;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eXgjnBxZ8BrNqn4Sk6A4xpE60v2fmF+nX+2I0eOLLCg=;
	b=j6JxqPzePV1v3VMwls0tzTsZjgdG9emkov+yXkAfgU/rTXQf8T3zUIk9y6kwTpmIwFH+jg
	+tGTZOAzNSt5DmyeGJlQYLKpb2hgbWczQo2u8RmaFCK8Kyk9Ad8W0Ksxyx6AoNHndiNUd3
	pgQ09os0+EUkMbgwfaOlHtEStLw+2xM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769096536;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eXgjnBxZ8BrNqn4Sk6A4xpE60v2fmF+nX+2I0eOLLCg=;
	b=0iqPGW1agNVaVnQmF+2mMFaHz5jf38AXI7KkERuGiInWYYKzTGrVODUWzChReQtemzPfna
	a8MSgMwRXxKctUBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=j6JxqPze;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0iqPGW1a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769096536;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eXgjnBxZ8BrNqn4Sk6A4xpE60v2fmF+nX+2I0eOLLCg=;
	b=j6JxqPzePV1v3VMwls0tzTsZjgdG9emkov+yXkAfgU/rTXQf8T3zUIk9y6kwTpmIwFH+jg
	+tGTZOAzNSt5DmyeGJlQYLKpb2hgbWczQo2u8RmaFCK8Kyk9Ad8W0Ksxyx6AoNHndiNUd3
	pgQ09os0+EUkMbgwfaOlHtEStLw+2xM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769096536;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eXgjnBxZ8BrNqn4Sk6A4xpE60v2fmF+nX+2I0eOLLCg=;
	b=0iqPGW1agNVaVnQmF+2mMFaHz5jf38AXI7KkERuGiInWYYKzTGrVODUWzChReQtemzPfna
	a8MSgMwRXxKctUBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DF1F13533;
	Thu, 22 Jan 2026 15:42:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0Tn4DlhFcmlzbQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 22 Jan 2026 15:42:16 +0000
Date: Thu, 22 Jan 2026 16:42:15 +0100
From: David Sterba <dsterba@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: Re: fsverity cleanups, speedup and memory usage optimization v2
Message-ID: <20260122154215.GV26902@suse.cz>
Reply-To: dsterba@suse.cz
References: <20260122082214.452153-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122082214.452153-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.21
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75059-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 30691691FF
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 09:21:56AM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this series has a hodge podge of fsverity enhances that I looked into as
> part of the review of the xfs fsverity support series.
> 
> The first part calls fsverity code from VFS code instead of requiring
> boilerplate in the file systems.  The first patch fixes a bug in btrfs
> as part of that, as btrfs was missing a check.  An xfstests
> test case for this was submitted already.
> 
> The middle part optimizes the fsverity read path by kicking off readahead
> for the fsverity hashes from the data read submission context, which in my
> simply testing showed huge benefits for sequential reads using dd.
> I haven't been able to get fio to run on a preallocated fio file, but
> I expect random read benefits would be significantly better than that
> still.
> 
> The last part avoids the need for a pointer in every inode for fsverity
> and instead uses a rhashtable lookup, which is once per read_folio or
> ->readahead invocation and for for btrfs another time for each bio
> completion.  Right now this does not increse the number of inodes in
> each slab, but for ext4 we are getting very close to that (within
> 16 bytes by my count).
> 
> Changes since v1:
>  - reorder to keep the most controversial part last
>  - drop moving the open handling to common code (for now)
>  - factor the page cache read code into common code
>  - reduce the number of hash lookups
>  - add a barrier in the fsverity_active that pairs with the cmpxchg
>    that sets the inode flag.
> 
> Diffstat:
>  fs/attr.c                    |   12 ++

For the btrfs changes

>  fs/btrfs/btrfs_inode.h       |    4 
>  fs/btrfs/extent_io.c         |   37 +++++---
>  fs/btrfs/inode.c             |   13 ---
>  fs/btrfs/verity.c            |   11 --

Acked-by: David Sterba <dsterba@suse.com>

