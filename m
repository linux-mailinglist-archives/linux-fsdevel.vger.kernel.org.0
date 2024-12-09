Return-Path: <linux-fsdevel+bounces-36808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B73B9E988F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 15:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64F2162B0E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 14:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051CF1B042A;
	Mon,  9 Dec 2024 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dr0GGrD4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="02tE/xNQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dr0GGrD4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="02tE/xNQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805B935946;
	Mon,  9 Dec 2024 14:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733753776; cv=none; b=oBoynU8tGpKDd2WLIQAZDkQfW4oxq+ruhunvuCBuHCwlD8l0NgQKJdV01Lcp4PExjy8t8tRBAKbMxUT/SXiLhiSqMBErf4+pgQwzcnGr0v4yxXkuCZ1dm89OXM5ZNfvfWixD310W/PN2nvFpkUv+2yXbUHf6mnsRNbX6x5YMPEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733753776; c=relaxed/simple;
	bh=BM0q7NbSDtClP/DFiqvzvOyp0DiW2makmqbS/Ayr7KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkyikvsJP7gQ+BPD7NCWFVtQIUztjHv4fF6V1btIkPaCKzb62NjncHZpraC6bbVGd3GnCFuEVYi14geRKbQ3N6i0cdl744vMh8iqbTQ3oUwYufbiBYszxA24QLtcl8z7de2QxEo3re9bNlVz6Whe38SMnp1v1LGOXedv3juai6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dr0GGrD4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=02tE/xNQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dr0GGrD4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=02tE/xNQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BFD7C211D3;
	Mon,  9 Dec 2024 14:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733753772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X21WmVeRotOreOUDuaW7CWWm46V9QKf04q+yG+mPlF4=;
	b=dr0GGrD45D25MNefPhUdHe7n8ICbL0JpYJqkYMSJeR3PC0XDVb2hdy9QJxkRUj2wNh9XIm
	dBWmce7tOw4u+uMeOTNQylOZWmlVWYqoZqc6LSUUiXiEGwVNFSc35hxC0CbyXo3qrcpcIN
	cBuy7YHWyuELtl1yBOfCo4Jurgbr96k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733753772;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X21WmVeRotOreOUDuaW7CWWm46V9QKf04q+yG+mPlF4=;
	b=02tE/xNQzzKHBSiwiNBefAPFE05K38AoRmMzMOuz1tPcD1kuWTlHHx4KGZgdqLGDhwuUwB
	A9Rb3MWeiH5o7GBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733753772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X21WmVeRotOreOUDuaW7CWWm46V9QKf04q+yG+mPlF4=;
	b=dr0GGrD45D25MNefPhUdHe7n8ICbL0JpYJqkYMSJeR3PC0XDVb2hdy9QJxkRUj2wNh9XIm
	dBWmce7tOw4u+uMeOTNQylOZWmlVWYqoZqc6LSUUiXiEGwVNFSc35hxC0CbyXo3qrcpcIN
	cBuy7YHWyuELtl1yBOfCo4Jurgbr96k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733753772;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X21WmVeRotOreOUDuaW7CWWm46V9QKf04q+yG+mPlF4=;
	b=02tE/xNQzzKHBSiwiNBefAPFE05K38AoRmMzMOuz1tPcD1kuWTlHHx4KGZgdqLGDhwuUwB
	A9Rb3MWeiH5o7GBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AEB6F13A41;
	Mon,  9 Dec 2024 14:16:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oj+QKqz7VmfzegAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Dec 2024 14:16:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 63CDFA0B0C; Mon,  9 Dec 2024 15:16:12 +0100 (CET)
Date: Mon, 9 Dec 2024 15:16:12 +0100
From: Jan Kara <jack@suse.cz>
To: Klara Modin <klarasmodin@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com, brauner@kernel.org,
	torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-ext4@vger.kernel.org, sraithal@amd.com
Subject: Re: [PATCH v8 16/19] fsnotify: generate pre-content permission event
 on page fault
Message-ID: <20241209141612.wtst3obur3xxbtiq@quack3>
References: <cover.1731684329.git.josef@toxicpanda.com>
 <aa56c50ce81b1fd18d7f5d71dd2dfced5eba9687.1731684329.git.josef@toxicpanda.com>
 <5d0cd660-251c-423a-8828-5b836a5130f9@gmail.com>
 <20241209123137.o6bzwr35kumi2ksv@quack3>
 <604c3501-f134-4a6e-ad41-ace84c2fd902@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <604c3501-f134-4a6e-ad41-ace84c2fd902@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,toxicpanda.com,fb.com,vger.kernel.org,gmail.com,kernel.org,linux-foundation.org,zeniv.linux.org.uk,kvack.org,amd.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Mon 09-12-24 13:56:47, Klara Modin wrote:
> Hi,
> 
> On 2024-12-09 13:31, Jan Kara wrote:
> > Hello!
> > 
> > On Sun 08-12-24 17:58:42, Klara Modin wrote:
> > > On 2024-11-15 16:30, Josef Bacik wrote:
> > > > FS_PRE_ACCESS or FS_PRE_MODIFY will be generated on page fault depending
> > > > on the faulting method.
> > > > 
> > > > This pre-content event is meant to be used by hierarchical storage
> > > > managers that want to fill in the file content on first read access.
> > > > 
> > > > Export a simple helper that file systems that have their own ->fault()
> > > > will use, and have a more complicated helper to be do fancy things with
> > > > in filemap_fault.
> > > > 
> > > 
> > > This patch (0790303ec869d0fd658a548551972b51ced7390c in next-20241206)
> > > interacts poorly with some programs which hang and are stuck at 100 % sys
> > > cpu usage (examples of programs are logrotate and atop with root
> > > privileges).
> > > 
> > > I also retested the new version on Jan Kara's for_next branch and it behaves
> > > the same way.
> > 
> > Thanks for report! What is your kernel config please? I've just fixed a
> > bug reported by [1] which manifested in the same way with
> > CONFIG_FANOTIFY_ACCESS_PERMISSIONS=n.
> > 
> > Can you perhaps test with my for_next branch I've just pushed out? Thanks!
> > 
> > 								Honza
> 
> My config was attached, but yes, I have

Ah, sorry, somehow I've missed that.

> CONFIG_FANOTIFY_ACCESS_PERMISSIONS=n. I tried the tip by Srikanth Aithal to
> enable it and that resolved the issue.
> 
> Your new for_next branch resolved the CONFIG_FANOTIFY_ACCESS_PERMISSIONS=n
> case for me.

Thanks for testing! Glad to hear the problem is solved.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

