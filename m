Return-Path: <linux-fsdevel+bounces-33940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2BF9C0CA7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 18:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5B81F22C8B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 17:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AFA216DE3;
	Thu,  7 Nov 2024 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sZXFKR/p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8zVfBtfm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3McfhKv2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oYjRdY0U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DCC21501F;
	Thu,  7 Nov 2024 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730999694; cv=none; b=h2mlBKj792ECzgXsuP1Qi0jOmIUCeXpPRH5V2WMj1UmIOKjVTA0Ikq0Q4koeWs6R6YyqsJX26us616tAp41IWuVjvI0YvrDZL3SrE7MYHf+BQK2pCMoFoeXXAel1KkzADs3lKGqYQ5LXDX58RB2KLK1DxcBFKOBCjoppkjVn/Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730999694; c=relaxed/simple;
	bh=6oA4k/T7OVzyse0dwtaaQ2xHJgH9+T8yVJ4ZbS1FYyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyhT5GSFdeEiT5+dEfCJamNLw3KSQAGZBcETHT65otmgAji1/ZEqLHUUgfQTDlR11Q4/nqKyRCSs1VIPiKziJXdzOhnJuAC9HsBy2KJs7w+g09y+m6GGxwNliU5TIq4hRLhMvyRqgOAef03b+crIFyG9+rawxzd4nJB34WzAQMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sZXFKR/p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8zVfBtfm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3McfhKv2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oYjRdY0U; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D94451F7CE;
	Thu,  7 Nov 2024 17:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730999691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C9YZ64A1YSr5tuwhrHOT8emxFU3dW+6QzaoQchvGWek=;
	b=sZXFKR/pao99FSFXVj9puC6B+k/pxPbjjOvBMsviTxS43J/xGHRgJyHSjcELoqWYajLC0e
	SPxEAO5jGYnYoA1VpgtwE9xyIffXERbxasA1IOLJoeap3ajDaqyYBb3NIyqvykM/gUufbn
	8G2gUWYjZgHdPxRS7r4dx3+i6zlaz6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730999691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C9YZ64A1YSr5tuwhrHOT8emxFU3dW+6QzaoQchvGWek=;
	b=8zVfBtfmfM8Oul8Sks3yfNwJpm8jTuBnoLlYxPFCOVaiWkh/rPIb51nKL12tIBJbhA1K9N
	1VqaDioUMVIQxcDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730999689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C9YZ64A1YSr5tuwhrHOT8emxFU3dW+6QzaoQchvGWek=;
	b=3McfhKv2j3Zw2c/zoqEMR6nP6TbCFva0FveJaCNMSY17czOYRA8VsJEz/Jz/ju1MgTrq+m
	ea1WSVWIYzqp/G6mNizUKdwz2iWnIxeY7wkwJE7WgMOlMOZd1DZXNi4pzcwkIQs0jEuluc
	RI84LEzZz31r3YHXNqyeO2NbD7rESes=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730999689;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C9YZ64A1YSr5tuwhrHOT8emxFU3dW+6QzaoQchvGWek=;
	b=oYjRdY0USGtNcxxOlbKyJo8+HQW1PGfUYEUfFcHIjix3RN2yJbkFzGA+ceQ14b1sbYcoIX
	kP9qiYFaejLLeMCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C70AA139B3;
	Thu,  7 Nov 2024 17:14:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GEWRMIn1LGfRGAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 07 Nov 2024 17:14:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6D56CA08FE; Thu,  7 Nov 2024 18:14:41 +0100 (CET)
Date: Thu, 7 Nov 2024 18:14:41 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+ee72b9a7aad1e5a77c5c@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, adilger@dilger.ca, eadavis@qq.com,
	hdanton@sina.com, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, tytso@mit.edu,
	wojciech.gladysz@infogain.com
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_xattr_inode_iget (3)
Message-ID: <20241107171441.he2rix37qopi6ane@quack3>
References: <000000000000163e1406152c6877@google.com>
 <6726ae7b.050a0220.35b515.018a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6726ae7b.050a0220.35b515.018a.GAE@google.com>
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=1a07d5da4eb21586];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[qq.com,sina.com];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[ee72b9a7aad1e5a77c5c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[dilger.ca,qq.com,sina.com,vger.kernel.org,googlegroups.com,mit.edu,infogain.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infogain.com:email,syzkaller.appspot.com:url,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat 02-11-24 15:58:03, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit d1bc560e9a9c78d0b2314692847fc8661e0aeb99
> Author: Wojciech Gładysz <wojciech.gladysz@infogain.com>
> Date:   Thu Aug 1 14:38:27 2024 +0000
> 
>     ext4: nested locking for xattr inode
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1245f55f980000
> start commit:   fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1a07d5da4eb21586
> dashboard link: https://syzkaller.appspot.com/bug?extid=ee72b9a7aad1e5a77c5c
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12407f45180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140d9db1180000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 

Makes sense:

#syz fix: ext4: nested locking for xattr inode

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

