Return-Path: <linux-fsdevel+bounces-62718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A176B9EE15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 13:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88221BC0738
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 11:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD732F617E;
	Thu, 25 Sep 2025 11:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hR/tfPno";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fr2unMqP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hR/tfPno";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fr2unMqP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC18C226D04
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 11:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758798952; cv=none; b=DulczBSFUKu59E+w0xovnR6Dt8mZKd71E4ggA5pagPxdaD2q+eE06Gs5jHc0ipx1kLXahoDG5ckX90VgEDQM3HxpA8LacmXh271MNlxMR4uyxvK0Mz1QlDNl0qaHSGHSd2AkAgTefQTSwJNQtt1nsi+tfxm9qKQhHnCiO2miCc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758798952; c=relaxed/simple;
	bh=4+83uNj7FLjIilIC1KgRlb9om6bxirO7EEyFX1Pwp8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqYjFlr6B2fQwIA0ysrAImQ6OiFyw1Ouh8T3islyBLvma33EF0Ii2AKFUo+3TpU3GUwY4XvieHIjf/Hw3T6eJhbtVkRVpAH0E8UaWyFTIs11maMEfJyCvvaDYLx7xUpdsFzTLjdw5J7SRW+KYLsDY4D6vCaxS6fLhzpza6qsVxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hR/tfPno; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fr2unMqP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hR/tfPno; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fr2unMqP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B1E613F6F;
	Thu, 25 Sep 2025 11:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758798948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w0xQSYS96X0CCzsC2Hn3fZEFseD4jJSukmCKDmDMAS8=;
	b=hR/tfPno5srkyp1kecJxgvySH/8IMi+5Ntg8GcCantnyY7yDoeC8uv9y60mWiu9dWVlMzg
	MxPy3NJvf3I8zR7JfAlg4a+8QPvDHhywmnCEoCtjxWNIngyVuuh4JTB8CAQvNEpryJKPsn
	cdWXIP0vQ4RwepPAdLGdQsqh1E8LRpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758798948;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w0xQSYS96X0CCzsC2Hn3fZEFseD4jJSukmCKDmDMAS8=;
	b=Fr2unMqPJjULsPWpU+mpBYI9HwPdWcC4l1ffc49bQxqol6H0cVTLEsxRRcV49jj4GqWI/6
	5aoBs+r3cHxS0RCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758798948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w0xQSYS96X0CCzsC2Hn3fZEFseD4jJSukmCKDmDMAS8=;
	b=hR/tfPno5srkyp1kecJxgvySH/8IMi+5Ntg8GcCantnyY7yDoeC8uv9y60mWiu9dWVlMzg
	MxPy3NJvf3I8zR7JfAlg4a+8QPvDHhywmnCEoCtjxWNIngyVuuh4JTB8CAQvNEpryJKPsn
	cdWXIP0vQ4RwepPAdLGdQsqh1E8LRpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758798948;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w0xQSYS96X0CCzsC2Hn3fZEFseD4jJSukmCKDmDMAS8=;
	b=Fr2unMqPJjULsPWpU+mpBYI9HwPdWcC4l1ffc49bQxqol6H0cVTLEsxRRcV49jj4GqWI/6
	5aoBs+r3cHxS0RCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6A2213869;
	Thu, 25 Sep 2025 11:15:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E0OpKGQk1WjWfwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 25 Sep 2025 11:15:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4F862A0AA0; Thu, 25 Sep 2025 13:15:48 +0200 (CEST)
Date: Thu, 25 Sep 2025 13:15:48 +0200
From: Jan Kara <jack@suse.cz>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Jan Kara <jack@suse.cz>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Dave Chinner <david@fromorbit.com>
Subject: Re: [RFC PATCH 0/2] Defer evicting inodes to a workqueue
Message-ID: <4klhsgin7x366lye57ne6cebydannae2z7xhhgou2y7orhgeeq@ovmq46yxbyhh>
References: <20250924091000.2987157-1-willy@infradead.org>
 <wuel5bsbfa7t5s6g6hgifgvkhuwpwiapgepq3no3gjftodiojc@savimjoqup56>
 <CAJnrk1YjoB4A_iS-VS1T059yNuVjm2hAAJJfnMAmXgLZwQyf=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1YjoB4A_iS-VS1T059yNuVjm2hAAJJfnMAmXgLZwQyf=A@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Wed 24-09-25 10:45:35, Joanne Koong wrote:
> On Wed, Sep 24, 2025 at 4:35 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 24-09-25 10:09:55, Matthew Wilcox (Oracle) wrote:
> > > +++ b/fs/inode.c
> > > @@ -883,6 +883,10 @@ void evict_inodes(struct super_block *sb)
> >
> > Why evict_inodes? I think you want prune_icache_sb() -> inode_lru_isolate()?
> 
> I think prune_dcache_sb() can lead to inode eviction in reclaim as
> well (eg prune_dcache_sb() -> shrink_dentry_list() -> shrink_kill() ->
> __dentry_kill() -> dentry_unlink_inode() -> evict()), so maybe this
> should also be done there too.

Well, this will end up removing the inode only in some corner cases (like
inode being deleted or when I_DONTCACHE flags is set. But in the most
common case iput_final() will just insert the inode into the LRU list.
But you're right that if we want kind of guarantee that reclaim won't block
on inode eviction, then this path should be handled as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

