Return-Path: <linux-fsdevel+bounces-42249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5624AA3F7CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 15:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F6107A7242
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 14:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB732101A1;
	Fri, 21 Feb 2025 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vo/p4Xn9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fLZGES4G";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vo/p4Xn9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fLZGES4G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2682066C3
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149800; cv=none; b=Jtf95n4kRrcnkL/IMqW07WxwoGPz58SxjHpRqIMiIHggXMJfMCf3cJSxnEWgZpToDseK7hQfhQ9twWyxx+0yOkvUT2G9t8lH1ySw+URkoAy/gEd1x/1OpO7ah++lPf7FJXWp7oT5RCvusOuWdJVMVuOgoPPGwh1oJEy+nupnWdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149800; c=relaxed/simple;
	bh=49cMVSIZWQ4mYHNVpy6x/I4VjXgW9GQu+xRSI0eEh50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvO8KYU9oLkTM4i3HBfYJ/rURxFAliaopPj7xj7ApiI4fyrhDSdyLyKv4/ac5ieSPvOUofeexbYA5R8C5vMj1Ubw0PoqPEtQxS7NUV5PioiK5rYGMx1dw4C7Ud5ZKia97oVxceVayMl2Z8KbHlDzbXDSFuBeifZIbTtsAODDhTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vo/p4Xn9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fLZGES4G; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vo/p4Xn9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fLZGES4G; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6FDF520767;
	Fri, 21 Feb 2025 14:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740149797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U3tdkkVcZBTwST2E6GpjkH/ouVBmmMWrSkcKf+qgNqk=;
	b=vo/p4Xn9NZ4ap7+Ccr/egoBFAfSBW4m9T25GxQ2QT80yFCU3kxRTtOyExFapwDg5/epJ4U
	/N8bQ117R6Wn8yeC3GcoYjqgzKwwxu8GcJTlejXUJSIXx/LzAwJTxJr1vwt26OxB2Ur/ka
	ZN3Uhmu6M4hA3XXzRV3bg8PmWakp32s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740149797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U3tdkkVcZBTwST2E6GpjkH/ouVBmmMWrSkcKf+qgNqk=;
	b=fLZGES4G54XPkkSQbVTnSYddTAOTbpV9BhTYVrh/zmGGkvuBid287mrts7/aL5H5j+/z+p
	YWPbi5oIujTeLIBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740149797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U3tdkkVcZBTwST2E6GpjkH/ouVBmmMWrSkcKf+qgNqk=;
	b=vo/p4Xn9NZ4ap7+Ccr/egoBFAfSBW4m9T25GxQ2QT80yFCU3kxRTtOyExFapwDg5/epJ4U
	/N8bQ117R6Wn8yeC3GcoYjqgzKwwxu8GcJTlejXUJSIXx/LzAwJTxJr1vwt26OxB2Ur/ka
	ZN3Uhmu6M4hA3XXzRV3bg8PmWakp32s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740149797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U3tdkkVcZBTwST2E6GpjkH/ouVBmmMWrSkcKf+qgNqk=;
	b=fLZGES4G54XPkkSQbVTnSYddTAOTbpV9BhTYVrh/zmGGkvuBid287mrts7/aL5H5j+/z+p
	YWPbi5oIujTeLIBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6520B136AD;
	Fri, 21 Feb 2025 14:56:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WlKqGCWUuGcPEgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 21 Feb 2025 14:56:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EA3CEA081E; Fri, 21 Feb 2025 15:56:32 +0100 (CET)
Date: Fri, 21 Feb 2025 15:56:32 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+47c7e14e1bd09234d0ad@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	willy@infradead.org
Subject: Re: [syzbot] [mm] [fs] possible deadlock in page_cache_ra_unbounded
Message-ID: <y5kibif4m6shs4c44o6c46mhi6mengffft2rfnnjk4djtxiqbb@bxbhd6rx6uof>
References: <000000000000d0021505f0522813@google.com>
 <67b75632.050a0220.14d86d.02e4.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67b75632.050a0220.14d86d.02e4.GAE@google.com>
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=e1e118a9228c45d7];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[47c7e14e1bd09234d0ad];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 20-02-25 08:20:02, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16e867f8580000
> start commit:   861deac3b092 Linux 6.7-rc7
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e118a9228c45d7
> dashboard link: https://syzkaller.appspot.com/bug?extid=47c7e14e1bd09234d0ad
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=100b9595e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1415ff9ee80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Makes sense:
 
#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

