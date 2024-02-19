Return-Path: <linux-fsdevel+bounces-11996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A0885A21E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 12:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D03FB23F0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 11:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F7A2C6A3;
	Mon, 19 Feb 2024 11:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DBmA0oPj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fo9NBRLD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DBmA0oPj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fo9NBRLD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007448493;
	Mon, 19 Feb 2024 11:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342715; cv=none; b=ctjU3XkPvTVJK6vjr12Mc5i6ghNoS1q61vnFZEeA8jLROFqKx0Ey0jFpZrYqCGOrnlgnu0XO0y9UVW/lBDZ+lo/k12UG4pAmyeMW4WPBSn0QTtSptn8beMHUb8emKyBEN/C1RH7uu95ZpNOIyw2Lu61huf+vKqFu00E9XCF5OOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342715; c=relaxed/simple;
	bh=rsXavOSekkeBHCyWxv91+jak94ihRfE56oyOQYTdd5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUNZWzU4vzJMpdEEFBiizkcAC2lETFlbMrTq/eMyW5oh4/hNYNb1yom2pLZ+FtNw8FP3S5r6cwCR3/8pNQEsq73enX5E9ZkO6qxowKr9fIvfhyQ7EsD+vKbB405ehB5LvlkXIw2QVGxclP5DcSTDih1E6+KUgwmEHx9HjDCJVww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DBmA0oPj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fo9NBRLD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DBmA0oPj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fo9NBRLD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 15F1D22169;
	Mon, 19 Feb 2024 11:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708342710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6cpGHb436M8tiQFmyhEwTl+dw5Jqu8yY4B4qSAho98M=;
	b=DBmA0oPjT+8pJ/W5oAS3yqD0RPB1Ydt7O+xVwXtrgardb136cIpEtu8Uamb1W7p5zmhJWA
	wGkjTnaM9eS4WgHQJEw7EuvuPk+uVaWFeFHCCd2L/GbYlCflxf9RHO5gsszxHt6MLSCP4Y
	0HwB9UMkHlRFoornfGteUXu93hQ0slE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708342710;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6cpGHb436M8tiQFmyhEwTl+dw5Jqu8yY4B4qSAho98M=;
	b=Fo9NBRLDQsMdoRWgnN8ecQZ0HjfTuEyNhV11rJVsV800HfmLUVPQdVoMc28HxeyXdJovMo
	/W2K2VUm9klAMvCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708342710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6cpGHb436M8tiQFmyhEwTl+dw5Jqu8yY4B4qSAho98M=;
	b=DBmA0oPjT+8pJ/W5oAS3yqD0RPB1Ydt7O+xVwXtrgardb136cIpEtu8Uamb1W7p5zmhJWA
	wGkjTnaM9eS4WgHQJEw7EuvuPk+uVaWFeFHCCd2L/GbYlCflxf9RHO5gsszxHt6MLSCP4Y
	0HwB9UMkHlRFoornfGteUXu93hQ0slE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708342710;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6cpGHb436M8tiQFmyhEwTl+dw5Jqu8yY4B4qSAho98M=;
	b=Fo9NBRLDQsMdoRWgnN8ecQZ0HjfTuEyNhV11rJVsV800HfmLUVPQdVoMc28HxeyXdJovMo
	/W2K2VUm9klAMvCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0746C13585;
	Mon, 19 Feb 2024 11:38:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id TDHBAbY902URbAAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 19 Feb 2024 11:38:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AD2C8A0806; Mon, 19 Feb 2024 12:38:25 +0100 (CET)
Date: Mon, 19 Feb 2024 12:38:25 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+34a0f26f0f61c4888ea4@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, axboe@kernel.dk, brauner@kernel.org,
	jack@suse.cz, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, tytso@mit.edu, yebin10@huawei.com
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Read in ext4_search_dir
Message-ID: <20240219113825.sxjpdxhkn6w7qzy4@quack3>
References: <0000000000000d7d6e05fb6bd2d7@google.com>
 <0000000000001924f506118e5748@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000001924f506118e5748@google.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DBmA0oPj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Fo9NBRLD
X-Spamd-Result: default: False [2.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=d05dd66e2eb2c872];
	 TAGGED_RCPT(0.00)[34a0f26f0f61c4888ea4];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-0.00)[43.10%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 2.69
X-Rspamd-Queue-Id: 15F1D22169
X-Spam-Level: **
X-Spam-Flag: NO
X-Spamd-Bar: ++

On Fri 16-02-24 22:55:04, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d6758a180000
> start commit:   7475e51b8796 Merge tag 'net-6.7-rc2' of git://git.kernel.o..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d05dd66e2eb2c872
> dashboard link: https://syzkaller.appspot.com/bug?extid=34a0f26f0f61c4888ea4
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10221a14e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112fd18f680000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Makes sense.
 
#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

