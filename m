Return-Path: <linux-fsdevel+bounces-12438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAEC85F52B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 11:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 992BA1F25E9D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 10:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CAF38DF9;
	Thu, 22 Feb 2024 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G/3DnYvA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lQVnGFre";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G/3DnYvA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lQVnGFre"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770C338F8F;
	Thu, 22 Feb 2024 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708596107; cv=none; b=jkppZMcXhtsSwK99lmkhvwD9PZTDVXcjmPBRpyVJMSXgVGJe5mVLRmyFaWlfWH6d4nAW9AXpfiUOrKaAEgc3AyfwcP8wTLh/xP4hNMwGoHPjt+tclgB6zAZ/hnO5I6N7QkvkO93FB3dIWZgEcyoXvePjfEVj7B6JjPbi3uJDfgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708596107; c=relaxed/simple;
	bh=otTDC+Z1k3Ai1e0bYmqWNrn1qICmWD+yD9Si+0NcFgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDmY3An7/0KAv2uoGKjCpxBYKc9nr9fA9zozmrqAL/zD/q+hgPMSgHXQ0nk2S02jsRO2XbT9MXKSN5epcrlpTY+E5hamDK/5lIvkfIzL62WsjMkw6FD94cbFnsJWwQLAqbUgmYNBY9YVMP3Dg29YsnoQgzo0fqVcY7RuARyd5Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G/3DnYvA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lQVnGFre; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G/3DnYvA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lQVnGFre; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9230B21EEF;
	Thu, 22 Feb 2024 10:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708596103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5F2SXZJviDeMEw/YLbFLlHXpTk9eAeZuRldhmomYW8c=;
	b=G/3DnYvA792n9BQOfMxqArw9RhC2+68ey4XUlAG/bZhRov4TLdBbpiPWevhENTmG8GEuIN
	kAMo0Nx2vNbqmiYv2GZcaKMUtFylKda2ic38ircgkl2QsqPp/Rt4+9LfzagXh+CgUwKBL7
	Q5dTbeOpJDwWZu5f/Ik63ZyMqLEfw6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708596103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5F2SXZJviDeMEw/YLbFLlHXpTk9eAeZuRldhmomYW8c=;
	b=lQVnGFreZsK1M388RLMuwjiE88jZ94YxP2n17m25x/++iDRtQ0hygiuuyAMPNtls91m16/
	hnOcX+iAjpbVZoDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708596103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5F2SXZJviDeMEw/YLbFLlHXpTk9eAeZuRldhmomYW8c=;
	b=G/3DnYvA792n9BQOfMxqArw9RhC2+68ey4XUlAG/bZhRov4TLdBbpiPWevhENTmG8GEuIN
	kAMo0Nx2vNbqmiYv2GZcaKMUtFylKda2ic38ircgkl2QsqPp/Rt4+9LfzagXh+CgUwKBL7
	Q5dTbeOpJDwWZu5f/Ik63ZyMqLEfw6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708596103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5F2SXZJviDeMEw/YLbFLlHXpTk9eAeZuRldhmomYW8c=;
	b=lQVnGFreZsK1M388RLMuwjiE88jZ94YxP2n17m25x/++iDRtQ0hygiuuyAMPNtls91m16/
	hnOcX+iAjpbVZoDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E4EF13A6B;
	Thu, 22 Feb 2024 10:01:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Xe/LHocb12WFKAAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 22 Feb 2024 10:01:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2068FA0807; Thu, 22 Feb 2024 11:01:43 +0100 (CET)
Date: Thu, 22 Feb 2024 11:01:43 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+41a88b825a315aac2254@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org,
	eadavis@qq.com, ernesto.mnd.fernandez@gmail.com, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com,
	torvalds@linux-foundation.org, willy@infradead.org
Subject: Re: [syzbot] [hfs?] possible deadlock in hfs_extend_file (2)
Message-ID: <20240222100143.ibz76z7uapncfo4x@quack3>
References: <000000000000d95cf9060c5038e3@google.com>
 <00000000000031b4140611f09e02@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000031b4140611f09e02@google.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="G/3DnYvA";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lQVnGFre
X-Spamd-Result: default: False [2.69 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLtn5sxynxhjcb7o9m7xjmbmnz)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[39.78%];
	 SUBJECT_HAS_QUESTION(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,qq.com];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=247b5a935d307ee5];
	 TAGGED_RCPT(0.00)[41a88b825a315aac2254];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,suse.com:email,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[linux-foundation.org,kernel.dk,kernel.org,qq.com,gmail.com,suse.cz,vger.kernel.org,dubeyko.com,googlegroups.com,infradead.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 2.69
X-Rspamd-Queue-Id: 9230B21EEF
X-Spam-Level: **
X-Spam-Flag: NO
X-Spamd-Bar: ++

On Wed 21-02-24 20:10:04, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12bedb0c180000
> start commit:   610a9b8f49fb Linux 6.7-rc8
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=247b5a935d307ee5
> dashboard link: https://syzkaller.appspot.com/bug?extid=41a88b825a315aac2254
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1552fe19e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1419bcade80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: fs: Block writes to mounted block devices

Unlikely. The report seems more like a lockdep annotation problem where
different btrees used in HFS share the same lockdep key.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

