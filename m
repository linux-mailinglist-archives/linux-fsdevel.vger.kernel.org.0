Return-Path: <linux-fsdevel+bounces-11122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C5385156E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 14:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96F31F2223F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 13:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8874D11B;
	Mon, 12 Feb 2024 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vR7e3xt/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="syssijZ8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vR7e3xt/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="syssijZ8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318CD3BB4E;
	Mon, 12 Feb 2024 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744536; cv=none; b=ANNKW3F97Cmbh+LDo9dRZcC/b19TqAgGAeoe60D+pvCNspep8ZxDHtw4rNXTEkBAuyPXO1goJumXjSUAfGMhAHsFsjxzTk2SbTsb6dADB0PStbNdgAA16GxePzdzfgKREde+zPXaSS8eeGLo9VuxfYEVCW7Jf8nFMtLinOMqQs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744536; c=relaxed/simple;
	bh=gtNWNqW+p053rHN1mhZLDu6kAzHlUBS/GKYNIgNduGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnjN0iz6PzGOADsDW6vlwxHI/36BbVjT82BR3fuhTjCsfDIF+cKh8SkfJdKa4/1vPYXQZFgMSje0OZj1EBLLRRj257o1r3HLpAMSlwDzpAtopOSWrszqNEjmCMN1pnsxTHmiCH/t6Th/qHt5iMcDfVAyefAOXFtuqohnH3a7tzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vR7e3xt/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=syssijZ8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vR7e3xt/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=syssijZ8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5171B21C2B;
	Mon, 12 Feb 2024 13:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707744533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ltX91ZleV/4/D3s8Gkh2BZLWSXktt3sddwV27eMAeo=;
	b=vR7e3xt/E75AmOPL2iZbtiE5Pv5qPfJldpsbxKJndM2kuyBR6NkIE6ktoREoFS6QhcPu8+
	xs0JmrO/MT/0R+jeIs1H4c8564/Kr7u7O0ps6IzEq8j4Sj7AeiMSKStSR53QzotlXPigW8
	0uuqOTF5ijp9tpjT6IIAZT1w+ZXjeV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707744533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ltX91ZleV/4/D3s8Gkh2BZLWSXktt3sddwV27eMAeo=;
	b=syssijZ8cvRD+m3WeKBUwB/ecZSftsy+FZWhwLOMixKhuppZrbEpdrE3UtlmhvVjNqYj9y
	A2/xFvueX0mVwGAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707744533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ltX91ZleV/4/D3s8Gkh2BZLWSXktt3sddwV27eMAeo=;
	b=vR7e3xt/E75AmOPL2iZbtiE5Pv5qPfJldpsbxKJndM2kuyBR6NkIE6ktoREoFS6QhcPu8+
	xs0JmrO/MT/0R+jeIs1H4c8564/Kr7u7O0ps6IzEq8j4Sj7AeiMSKStSR53QzotlXPigW8
	0uuqOTF5ijp9tpjT6IIAZT1w+ZXjeV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707744533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ltX91ZleV/4/D3s8Gkh2BZLWSXktt3sddwV27eMAeo=;
	b=syssijZ8cvRD+m3WeKBUwB/ecZSftsy+FZWhwLOMixKhuppZrbEpdrE3UtlmhvVjNqYj9y
	A2/xFvueX0mVwGAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 45EDC13212;
	Mon, 12 Feb 2024 13:28:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id gU8TERUdymVzNAAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 12 Feb 2024 13:28:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EB326A0809; Mon, 12 Feb 2024 14:28:52 +0100 (CET)
Date: Mon, 12 Feb 2024 14:28:52 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+2c4a3b922a860084cc7f@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, axboe@kernel.dk, brauner@kernel.org,
	eadavis@qq.com, jack@suse.cz, libaokun1@huawei.com,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	tytso@mit.edu, viro@zeniv.linux.org.uk, willy@infradead.org,
	yangerkun@huawei.com
Subject: Re: [syzbot] [ext4?] WARNING in lock_two_nondirectories
Message-ID: <20240212132852.5fxliee4izjkx74w@quack3>
References: <000000000000e17185060c8caaad@google.com>
 <000000000000b9df7e061123f594@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000b9df7e061123f594@google.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [2.62 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.28)[74.44%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[qq.com];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=e043d554f0a5f852];
	 TAGGED_RCPT(0.00)[2c4a3b922a860084cc7f];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RL9mptuuj8f371ag1nhgyt86ac)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,syzkaller.appspot.com:url,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[dilger.ca,kernel.dk,kernel.org,qq.com,suse.cz,huawei.com,vger.kernel.org,googlegroups.com,mit.edu,zeniv.linux.org.uk,infradead.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Level: **
X-Spam-Score: 2.62
X-Spam-Flag: NO

On Sun 11-02-24 16:00:04, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15477434180000
> start commit:   a39b6ac3781d Linux 6.7-rc5
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e043d554f0a5f852
> dashboard link: https://syzkaller.appspot.com/bug?extid=2c4a3b922a860084cc7f
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1687292ee80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d8adbce80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Another repro that seems to be corrupting the fs metadata:

#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

