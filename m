Return-Path: <linux-fsdevel+bounces-63795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C9ABCE126
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 19:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D094189C76B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 17:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDE6221554;
	Fri, 10 Oct 2025 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1OxWOKu+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1NhIdrOQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1OxWOKu+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1NhIdrOQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AB3218AB0
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760117039; cv=none; b=gwbXx3StjuJ5X0WoejOSiqcwtZUPvMZbfIImDJm9KzTsnslyphyeZC1l4kzLb/cMFWwTFcOvY54FZjft4Nbmy5/VtWATS7Jaz1qEF4WBi8gzit7shCizBywTbXJGwwga09wi5XvdSB8DQrYRNNB0DMwU1bVRqlXf5eQHesmJAxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760117039; c=relaxed/simple;
	bh=khQBrh7iIFxCcZodsB1RIMfB8GCvKXdrxqcMvButon4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJtqRYF4wbrDqeT+6na9EDNZKOQO1UlQM4hGqUWvTHUr24b6EUszB2/51+J1q2zLobeUXjNTHWy8inJazPYF0MouZSeKiQYFmRoFqd4fJ9WzQcaGpInwEWTNhqAtZzKmHU0I7hAXzw1y5zR7cFP4K/00+Mxv0jkRTc78FqJqkNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1OxWOKu+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1NhIdrOQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1OxWOKu+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1NhIdrOQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 484451F84E;
	Fri, 10 Oct 2025 17:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760117035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2r0Y2zd9Y9wO+ftaMPA4yxgNkyWpqDr7EAewUvgQdZo=;
	b=1OxWOKu+1ALG/J2FOf3zNc4dIfSe5n3cFKZlEFvi8wzRKCJamp2OLr1ls2o6Mi7n2Rlxw/
	o0F99edfgIDLRHJl6VK6VL15Nzhn5BJGreohyScK9NJzm3Z+zbW3x1ZuXd8edgdv8Qz68r
	DX32lcTQPzk93xmS7MaGJjmV0Ymjopo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760117035;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2r0Y2zd9Y9wO+ftaMPA4yxgNkyWpqDr7EAewUvgQdZo=;
	b=1NhIdrOQMTtPb/5quhU+GH/0xYy4HX884CUOsPZLs8zSR7hY2snrpLbsimaMjzynUTn8Zf
	svSfoQlR6mZESOBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1OxWOKu+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1NhIdrOQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760117035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2r0Y2zd9Y9wO+ftaMPA4yxgNkyWpqDr7EAewUvgQdZo=;
	b=1OxWOKu+1ALG/J2FOf3zNc4dIfSe5n3cFKZlEFvi8wzRKCJamp2OLr1ls2o6Mi7n2Rlxw/
	o0F99edfgIDLRHJl6VK6VL15Nzhn5BJGreohyScK9NJzm3Z+zbW3x1ZuXd8edgdv8Qz68r
	DX32lcTQPzk93xmS7MaGJjmV0Ymjopo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760117035;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2r0Y2zd9Y9wO+ftaMPA4yxgNkyWpqDr7EAewUvgQdZo=;
	b=1NhIdrOQMTtPb/5quhU+GH/0xYy4HX884CUOsPZLs8zSR7hY2snrpLbsimaMjzynUTn8Zf
	svSfoQlR6mZESOBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B22613A40;
	Fri, 10 Oct 2025 17:23:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j0prDitB6WjGOwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 10 Oct 2025 17:23:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CA414A0A58; Fri, 10 Oct 2025 19:23:54 +0200 (CEST)
Date: Fri, 10 Oct 2025 19:23:54 +0200
From: Jan Kara <jack@suse.cz>
To: Matt Fleming <matt@readmodwrite.com>
Cc: Jan Kara <jack@suse.cz>, adilger.kernel@dilger.ca, 
	kernel-team@cloudflare.com, libaokun1@huawei.com, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu, willy@infradead.org
Subject: Re: ext4 writeback performance issue in 6.12
Message-ID: <ok5xj3zppjeg7n6ltuv4gnd5bj5adyd6w5pbvaaaenz7oyb2sz@653qwjse63x7>
References: <20251006115615.2289526-1-matt@readmodwrite.com>
 <20251008150705.4090434-1-matt@readmodwrite.com>
 <2nuegl4wtmu3lkprcomfeluii77ofrmkn4ukvbx2gesnqlsflk@yx466sbd7bni>
 <20251009101748.529277-1-matt@readmodwrite.com>
 <ytvfwystemt45b32upwcwdtpl4l32ym6qtclll55kyyllayqsh@g4kakuary2qw>
 <20251009172153.kx72mao26tc7v2yu@matt-Precision-5490>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009172153.kx72mao26tc7v2yu@matt-Precision-5490>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 484451F84E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Thu 09-10-25 18:21:53, Matt Fleming wrote:
> On Thu, Oct 09, 2025 at 02:29:07PM +0200, Jan Kara wrote:
> > 
> > OK, so even if we reduce the somewhat pointless CPU load in the allocator
> > you aren't going to see substantial increase in your writeback throughput.
> > Reducing the CPU load is obviously a worthy goal but I'm not sure if that's
> > your motivation or something else that I'm missing :).
>  
> I'm not following. If you reduce the time it takes to allocate blocks
> during writeback, why will that not improve writeback throughput?

Maybe I misunderstood what you wrote about your profiles but you wrote that
we were spending about 4% of CPU time in the block allocation code. Even if
we get that close to 0%, you'd still gain only 4%. Or am I misunderstanding
something?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

