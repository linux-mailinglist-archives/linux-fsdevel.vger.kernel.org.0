Return-Path: <linux-fsdevel+bounces-39133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB015A106E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 13:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E7918895D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 12:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4F6236A75;
	Tue, 14 Jan 2025 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T2poHIuS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="88lQqFN9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T2poHIuS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="88lQqFN9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6AF236A7B
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736858372; cv=none; b=Dml/pd2Q9ZROsuF/pbezLviZ3eCSnPLbMv/3qknoPXDUrwYf8FwpvKeWlNqDzCZ8m1oT2Ob/vCRrRAFZoAwycXdLphyLuqmKXCnAkYTAs5kAEb3Ecspepl2s6Wxodcp6OpulWJhkPUz1yvoNxBYDV1mpxeQh2duNMJ+d168E90M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736858372; c=relaxed/simple;
	bh=7lLVV8CD1O8vnLsz2UK+UU7bKUUj4KnbL1xvYJiL464=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qosv6W7LBEixXrLWYymVKCDTmR9lvEKp+Mx4L1Y3dkwBpK2W/JQAd2T0MnQHQlFZYUB1cIT3jjddaUGpQc4eUG5qjzcTZoy5sDLYVPFf35tfSUua+YDogdOWpOkbgZzzP9IIhJd86cwpMLreQDkBwU4qI6Mr0aMMB4oOoSvaeAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T2poHIuS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=88lQqFN9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T2poHIuS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=88lQqFN9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1A2C12115A;
	Tue, 14 Jan 2025 12:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736858369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bxZl4LR+WA11+D31Pi4AlAKojYOnGZrQ4tY0MJSgQ1U=;
	b=T2poHIuS5KRb+nvjUNTbLSeuLfPv43LwNcw0UzZ22uych2PdrFkpowLbZEpRGtyzbnS4rg
	4y+qSAHUmNxeIe/CiQhrMeZeiuyof8IPJdIPSC8QcH3PaFREjfGUc2Sgbb3vBzohEscrij
	lF4ZGbbjybG6TEYUqutjb5MNm/+jaFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736858369;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bxZl4LR+WA11+D31Pi4AlAKojYOnGZrQ4tY0MJSgQ1U=;
	b=88lQqFN9OQ00BqcO9i7Fff1Sex3aGI/Y+QNEtoihgjv7aMnRci1Fq92RgPR1JjGkyRNpkR
	Nb2YlhA8iELEojAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=T2poHIuS;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=88lQqFN9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736858369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bxZl4LR+WA11+D31Pi4AlAKojYOnGZrQ4tY0MJSgQ1U=;
	b=T2poHIuS5KRb+nvjUNTbLSeuLfPv43LwNcw0UzZ22uych2PdrFkpowLbZEpRGtyzbnS4rg
	4y+qSAHUmNxeIe/CiQhrMeZeiuyof8IPJdIPSC8QcH3PaFREjfGUc2Sgbb3vBzohEscrij
	lF4ZGbbjybG6TEYUqutjb5MNm/+jaFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736858369;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bxZl4LR+WA11+D31Pi4AlAKojYOnGZrQ4tY0MJSgQ1U=;
	b=88lQqFN9OQ00BqcO9i7Fff1Sex3aGI/Y+QNEtoihgjv7aMnRci1Fq92RgPR1JjGkyRNpkR
	Nb2YlhA8iELEojAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E3CF1384C;
	Tue, 14 Jan 2025 12:39:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1JF2AwFbhmdANgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 14 Jan 2025 12:39:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B93E8A08CD; Tue, 14 Jan 2025 13:39:28 +0100 (CET)
Date: Tue, 14 Jan 2025 13:39:28 +0100
From: Jan Kara <jack@suse.cz>
To: Shyam Prasad N <nspmangalore@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mm@kvack.org, brauner@kernel.org, 
	Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, 
	Jeff Layton <jlayton@redhat.com>, Steve French <smfrench@gmail.com>, trondmy@kernel.org, 
	Shyam Prasad N <sprasad@microsoft.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Predictive readahead of dentries
Message-ID: <6wcmvyeuelngltuiohumo6pffwptgbgofqba453pdi45ahydkn@ern4qy4i2zoa>
References: <CANT5p=rxLH-D9qSoOWgjYeD87uahmZJMwXp8uNKW66mbv8hmDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANT5p=rxLH-D9qSoOWgjYeD87uahmZJMwXp8uNKW66mbv8hmDg@mail.gmail.com>
X-Rspamd-Queue-Id: 1A2C12115A
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[11];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,kvack.org,kernel.org,infradead.org,redhat.com,gmail.com,microsoft.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hello!

On Tue 14-01-25 09:08:38, Shyam Prasad N wrote:
> The Linux kernel does buffered reads and writes using the page cache
> layer, where the filesystem reads and writes are offloaded to the
> VM/MM layer. The VM layer does a predictive readahead of data by
> optionally asking the filesystem to read more data asynchronously than
> what was requested.
> 
> The VFS layer maintains a dentry cache which gets populated during
> access of dentries (either during readdir/getdents or during lookup).
> This dentries within a directory actually forms the address space for
> the directory, which is read sequentially during getdents. For network
> filesystems, the dentries are also looked up during revalidate.
> 
> During sequential getdents, it makes sense to perform a readahead
> similar to file reads. Even for revalidations and dentry lookups,
> there can be some heuristics that can be maintained to know if the
> lookups within the directory are sequential in nature. With this, the
> dentry cache can be pre-populated for a directory, even before the
> dentries are accessed, thereby boosting the performance. This could
> give even more benefits for network filesystems by avoiding costly
> round trips to the server.
> 
> NFS client already does a simplistic form of this readahead by
> maintaining an address space for the directory inode and storing the
> dentry records returned by the server in this space. However, this
> dentry access mechanism is so generic that I feel that this can be a
> part of the VFS/VM layer, similar to buffered reads of a file. Also,
> VFS layer is better equipped to store heuristics about dentry access
> patterns.

Interesting idea. Note that individual filesystems actually do directory
readahead on their own. They just don't readahead 'struct dentry' but
rather issue readahead for metadata blocks to get into cache which is what
takes most time. Readahead makes the most sense for readdir() (or
getdents() as you call it) calls where the filesystem driver has all the
information it needs (unlike VFS) for performing efficient readahead. So
here I'm not sure there's much need for a change.

I'm not against some form of readahead for ->lookup calls but we'd have to
very carefully design the heuristics for detecting some kind of pattern of
->lookup calls so that we know which entry is going to be the next one
looked up and evaluate whether it is actually an overall win or not. So
for this the discussion would need a more concrete proposal to be useful I
think.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

