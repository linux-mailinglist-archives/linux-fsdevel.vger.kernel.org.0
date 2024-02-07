Return-Path: <linux-fsdevel+bounces-10574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F74D84C665
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 09:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258611F25232
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 08:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFE2208BA;
	Wed,  7 Feb 2024 08:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uo2iAS4V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g6lFN9sT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uo2iAS4V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g6lFN9sT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B81E2032B;
	Wed,  7 Feb 2024 08:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707295257; cv=none; b=Cw1tXhxdyxZ2uFzIpj/gPSys0gZZJVzhHnz5b+H5Emrp2Govani6fDHl3qhkR00Ce+N8AJ+2uyhIKOToMGknfNRUaFSSNZLV5fJfaDxRdU8WFYlSprXAXEpJC30RSsomcXVks3cJSyIrQLkX8anEf6bq0X9aA+kMEFVwRS31Vtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707295257; c=relaxed/simple;
	bh=7mWCDilBtyn6a8R/MQs4iWeqLin9foUbZ3OlyKHlEtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvKYUbX8UkoXUFWL/V/ISV6zuVmPDadKXc8MJ3F2LNIzOP6+rJJSTwtM88HsS8wor298mBEsAlHzdVEpQwlGq+Xk+WtBblZ7GmHkU9cebOCV0/dHTNWG/+GkadlQN0ytixSjDOxSFQeO1Zht89rwwFUqY00WqIB/ZcjBSfiOAIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uo2iAS4V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g6lFN9sT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uo2iAS4V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g6lFN9sT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 50666221D1;
	Wed,  7 Feb 2024 08:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707295254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R7q8iY10uoxfBBuRXr+Ei/C8akP0H6jzk/X1fqaQvQY=;
	b=uo2iAS4VHfmzbP8+sGhwxwBhz+ITGZl9aP7Eg4thsPHmTH4Q4BSFt0SmR80AT8NeCxoAE+
	ClThyH205khyJ4lwUie453vYGg/E21jtlQASqbOVwRoQtX3TbeTjfrnt6dUx5+zPfzdoDE
	xg/ZhFcksSLcX0jP2GVJUZBpq3i1oEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707295254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R7q8iY10uoxfBBuRXr+Ei/C8akP0H6jzk/X1fqaQvQY=;
	b=g6lFN9sTD/PIiY3ic7OCv2L/NLz6tjpsciHv8cGE0TTVGwwBl5WNTHRilGSwbuertuNxWz
	/78FUB4U2yS1TMAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707295254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R7q8iY10uoxfBBuRXr+Ei/C8akP0H6jzk/X1fqaQvQY=;
	b=uo2iAS4VHfmzbP8+sGhwxwBhz+ITGZl9aP7Eg4thsPHmTH4Q4BSFt0SmR80AT8NeCxoAE+
	ClThyH205khyJ4lwUie453vYGg/E21jtlQASqbOVwRoQtX3TbeTjfrnt6dUx5+zPfzdoDE
	xg/ZhFcksSLcX0jP2GVJUZBpq3i1oEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707295254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R7q8iY10uoxfBBuRXr+Ei/C8akP0H6jzk/X1fqaQvQY=;
	b=g6lFN9sTD/PIiY3ic7OCv2L/NLz6tjpsciHv8cGE0TTVGwwBl5WNTHRilGSwbuertuNxWz
	/78FUB4U2yS1TMAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EFF8139D8;
	Wed,  7 Feb 2024 08:40:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pjggDxZCw2U6QwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Feb 2024 08:40:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9CC16A0809; Wed,  7 Feb 2024 09:40:53 +0100 (CET)
Date: Wed, 7 Feb 2024 09:40:53 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+9924e2a08d9ba0fd4ce2@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, dan.carpenter@linaro.org,
	dave.kleikamp@oracle.com, ghandatmanas@gmail.com, jack@suse.cz,
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org, lkp@intel.com, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, oe-kbuild@lists.linux.dev,
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com,
	syzkaller@googlegroups.com
Subject: Re: [syzbot] [jfs?] KASAN: slab-out-of-bounds Read in dtSearch
Message-ID: <20240207084053.ydlu3fnyzzvjpdr3@quack3>
References: <000000000000332a2505e981f474@google.com>
 <00000000000014c9ca0610b7aec6@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000014c9ca0610b7aec6@google.com>
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uo2iAS4V;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=g6lFN9sT
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.49 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLjmuxkameenh34oafz4d4fopd)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[33.64%];
	 SUBJECT_HAS_QUESTION(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=b45dfd882e46ec91];
	 TAGGED_RCPT(0.00)[9924e2a08d9ba0fd4ce2];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[18];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[kernel.dk,kernel.org,linaro.org,oracle.com,gmail.com,suse.cz,lists.sourceforge.net,vger.kernel.org,lists.linuxfoundation.org,intel.com,lists.linux.dev,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 1.49
X-Rspamd-Queue-Id: 50666221D1
X-Spam-Flag: NO

On Tue 06-02-24 06:49:05, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13767e8fe80000
> start commit:   bee0e7762ad2 Merge tag 'for-linus-iommufd' of git://git.ke..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b45dfd882e46ec91
> dashboard link: https://syzkaller.appspot.com/bug?extid=9924e2a08d9ba0fd4ce2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152bfc22e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1608f4a2e80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Makes sense.
 
#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

