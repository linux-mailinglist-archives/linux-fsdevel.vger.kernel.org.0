Return-Path: <linux-fsdevel+bounces-19591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2CF8C798A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 17:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAB72B21003
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 15:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93B214D6F1;
	Thu, 16 May 2024 15:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LkWEIgTn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3mQ5IpWH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LkWEIgTn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3mQ5IpWH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8840814884E;
	Thu, 16 May 2024 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715873530; cv=none; b=pXV/hlSu08W3WR+ruuon4MSSti91oC62T3JsuixOFOLTyQKgil1Or8mO1YTwgXyX/j90HOqOUmgZCLlfn57sH0EuvbCAGs0qOJ7Ks3TfWZEdTnQUy3NToU2UdkwmLMUQaSVn26Svne8dWn5L8evd+UUBKVfDnUS9foZ37TyrkbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715873530; c=relaxed/simple;
	bh=kQyRGHwFV9EB0D1MNdKQ04WmVe+yF6Troh3WRIVi2SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yf0KqRfqLgtVxGfa/syxHDLsXLXJKFTU9fHnh80c8AkzZMzDXCfEzrcBtuHNX16QFebGmqTzqPvs9zE5H8rbEJXBbWsumrsm2LW3wRRoH9qjqTWJk8mxtarki3K1l2pIsHiOiR4dRbCMv2j/jEBafD2SrLqtwkRLaIzfVU4isMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LkWEIgTn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3mQ5IpWH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LkWEIgTn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3mQ5IpWH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 754BE34439;
	Thu, 16 May 2024 15:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715873526;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VhU2JclVgo+abpYV6ZYar66kfkQ1msvfEKBsfACUK8U=;
	b=LkWEIgTn3sbChPgzra2zO5CrjIi+VzynFj6Zalv2SuHU+hzv3lwkc8UP0d8YplIYOLsNz2
	7ad0LRVeC8oi8qTz44QIs8uI6uUPezeN56lOW/tw96NEa0qQnm9/TKnc3QicHYfDw/2Zeu
	QCN52+ps0a7b4ZlzyXwTxydMntpIb5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715873526;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VhU2JclVgo+abpYV6ZYar66kfkQ1msvfEKBsfACUK8U=;
	b=3mQ5IpWHXcw6nlwPUiEaCt22wAv7aMRElj3peGAsu9JDBEo8CXRJvMGSgRJ4Pxyb5mypRW
	v4Gw2dBBeX4FeMAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LkWEIgTn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3mQ5IpWH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715873526;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VhU2JclVgo+abpYV6ZYar66kfkQ1msvfEKBsfACUK8U=;
	b=LkWEIgTn3sbChPgzra2zO5CrjIi+VzynFj6Zalv2SuHU+hzv3lwkc8UP0d8YplIYOLsNz2
	7ad0LRVeC8oi8qTz44QIs8uI6uUPezeN56lOW/tw96NEa0qQnm9/TKnc3QicHYfDw/2Zeu
	QCN52+ps0a7b4ZlzyXwTxydMntpIb5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715873526;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VhU2JclVgo+abpYV6ZYar66kfkQ1msvfEKBsfACUK8U=;
	b=3mQ5IpWHXcw6nlwPUiEaCt22wAv7aMRElj3peGAsu9JDBEo8CXRJvMGSgRJ4Pxyb5mypRW
	v4Gw2dBBeX4FeMAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5850613991;
	Thu, 16 May 2024 15:32:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 35pgFfYmRma0BgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 16 May 2024 15:32:06 +0000
Date: Thu, 16 May 2024 17:32:00 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+d56e0d33caf7d1a02821@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, fdmanana@suse.com,
	johannes.thumshirn@wdc.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] kernel BUG in create_pending_snapshot
Message-ID: <20240516153200.GD4449@suse.cz>
Reply-To: dsterba@suse.cz
References: <0000000000006cb13705ee3184f9@google.com>
 <000000000000a8f4b30608b0be9c@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a8f4b30608b0be9c@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-0.51 / 50.00];
	BAYES_HAM(-1.80)[93.83%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=5ea620bd01d9130d];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[d56e0d33caf7d1a02821];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 754BE34439
X-Spam-Flag: NO
X-Spam-Score: -0.51
X-Spamd-Bar: /

On Fri, Oct 27, 2023 at 04:11:06AM -0700, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit df9f278239046719c91aeb59ec0afb1a99ee8b2b
> Author: Filipe Manana <fdmanana@suse.com>
> Date:   Tue Jun 13 15:42:16 2023 +0000
> 
>     btrfs: do not BUG_ON on failure to get dir index for new snapshot
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1584c385680000
> start commit:   0136d86b7852 Merge tag 'block-6.2-2023-02-03' of git://git..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5ea620bd01d9130d
> dashboard link: https://syzkaller.appspot.com/bug?extid=d56e0d33caf7d1a02821
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14657573480000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16dd145d480000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: btrfs: do not BUG_ON on failure to get dir index for new snapshot

Yes, that's correct.

#syz fix: btrfs: do not BUG_ON on failure to get dir index for new snapshot

