Return-Path: <linux-fsdevel+bounces-42407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E37A41FCF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 14:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7755A3A2F30
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 12:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4684723373F;
	Mon, 24 Feb 2025 12:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GVq+obXY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LEKZcQHr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GVq+obXY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LEKZcQHr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010D8158870
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740401796; cv=none; b=l2eXiOXYNZbR2aHTN8Pe9NJ9xWc7e2tCVpw1w4YVsNf3eczeK/cLg6whZ+cbJvDQD3p/mHlSjbdbiJX7lPdix5ex3QoNBkS71gY4uKqc8ppk/dYtAWdmSh5Wvju+7wlJykvLyDS+9pq2unF/cVl9c41hvhXQXcBpVX7L3yhwDLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740401796; c=relaxed/simple;
	bh=oDyS/AraXRNm8wcHj3D1nm9uGm2OtEX21Oiw70mX3wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyT3QoP230vihrMYZnNz74+2/PYGk8QVuXBcVHktj0SloPOdfcLQr0VQI0/L6wHQ4yP2EUpH11QwkbW33Wf7RRcwQ4XSTbWr+jNwfzhowcVUUkqIgZ2qBQ5Y8pQEgi4j9L+t2KY/QiShmJF9olio46wZjCdWX89dJSYJ4XAW7vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GVq+obXY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LEKZcQHr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GVq+obXY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LEKZcQHr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 032DE21160;
	Mon, 24 Feb 2025 12:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740401793;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ABRZsikHdvHqgE/zdj7fxNHzmZtBSGT51GLjtRuTsHE=;
	b=GVq+obXYC2PEKWxQrTR6ckn0Kos0taQ6X+8d579oZwSxoROr9t1lkTh48lG72ZRRh+4XFl
	gpisgfvfrx/KnkNe7dP8ko524hFyXyY/QCoXYwQHtVblW4RUycI0AWjzGTEq5AgJ0wvkrI
	ffBJYSSx2A7G3JdL4KPdF3Ilm56Rshk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740401793;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ABRZsikHdvHqgE/zdj7fxNHzmZtBSGT51GLjtRuTsHE=;
	b=LEKZcQHrvukA4tbFLWJnBVXwryF3YCkPyG+iPqFnwmgTiiF1DlndoshV/Q+0mVnNtTvKnb
	xYYyuAngjStAH7AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GVq+obXY;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LEKZcQHr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740401793;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ABRZsikHdvHqgE/zdj7fxNHzmZtBSGT51GLjtRuTsHE=;
	b=GVq+obXYC2PEKWxQrTR6ckn0Kos0taQ6X+8d579oZwSxoROr9t1lkTh48lG72ZRRh+4XFl
	gpisgfvfrx/KnkNe7dP8ko524hFyXyY/QCoXYwQHtVblW4RUycI0AWjzGTEq5AgJ0wvkrI
	ffBJYSSx2A7G3JdL4KPdF3Ilm56Rshk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740401793;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ABRZsikHdvHqgE/zdj7fxNHzmZtBSGT51GLjtRuTsHE=;
	b=LEKZcQHrvukA4tbFLWJnBVXwryF3YCkPyG+iPqFnwmgTiiF1DlndoshV/Q+0mVnNtTvKnb
	xYYyuAngjStAH7AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D59BB13332;
	Mon, 24 Feb 2025 12:56:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mR/wM4BsvGeoJwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 24 Feb 2025 12:56:32 +0000
Date: Mon, 24 Feb 2025 13:56:27 +0100
From: David Sterba <dsterba@suse.cz>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Kalesh Singh <kaleshsingh@google.com>,
	lsf-pc@lists.linux-foundation.org,
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Juan Yescas <jyescas@google.com>,
	android-mm <android-mm@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>
Subject: Re: [LSF/MM/BPF TOPIC] Optimizing Page Cache Readahead Behavior
Message-ID: <20250224125627.GL5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CAC_TJvfG8GcwG_2w1o6GOTZS8tfEx2h9A91qsenYfYsX8Te=Bg@mail.gmail.com>
 <87wmdhgr5x.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmdhgr5x.fsf@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 032DE21160
X-Spam-Score: -2.71
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[14];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sun, Feb 23, 2025 at 11:04:50AM +0530, Ritesh Harjani wrote:
> Kalesh Singh <kaleshsingh@google.com> writes:
> 
> > Hi organizers of LSF/MM,
> >
> > I realize this is a late submission, but I was hoping there might
> > still be a chance to have this topic considered for discussion.
> >
> > Problem Statement
> > ===============
> >
> > Readahead can result in unnecessary page cache pollution for mapped
> > regions that are never accessed. Current mechanisms to disable
> > readahead lack granularity and rather operate at the file or VMA
> 
> >From what I understand the readahead setting is done at the per-bdi
> level (default set to 128K). That means we don't get to control the
> amount of readahead pages needed on a per file basis. If say we can
> control the amount of readahead pages on a per open fd, will that solve
> the problem you are facing? That also means we don't need to change the
> setting for the entire system, but we can control this knob on a per fd
> basis? 
> 
> I just quickly hacked fcntl to allow setting no. of ra_pages in
> inode->i_ra_pages. Readahead algorithm then takes this setting whenever
> it initializes the readahead control in "file_ra_state_init()"
> So after one opens the file, we can set the fcntl F_SET_FILE_READAHEAD
> to the preferred value on the open fd. 
> 
> 
> Note: I am not saying the implementation could be 100% correct. But it's
> just a quick working PoC to discuss whether this is the right approach
> to the given problem.

> @@ -678,6 +678,8 @@ struct inode {
>  	unsigned short          i_bytes;
>  	u8			i_blkbits;
>  	enum rw_hint		i_write_hint;
> +	/* Per inode setting for max readahead in page_size units */
> +	unsigned long		i_ra_pages;
>  	blkcnt_t		i_blocks;

If your final patch needs to store data in struct inode, please try to
optimize it so that the size does not change. There are at least 2 4
byte holes so if you're fine with a page size unit for readahead then
this should be sufficient.

