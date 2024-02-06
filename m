Return-Path: <linux-fsdevel+bounces-10436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF0784B250
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 11:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C3428B17E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 10:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1375112E1EA;
	Tue,  6 Feb 2024 10:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q8YQ2uEN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8RFn8U0p";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ENeWwoV8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VUEmkgTN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D6912E1F1;
	Tue,  6 Feb 2024 10:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214603; cv=none; b=Nih5Sxv+VkMBJPl6N8x2dyHKXrzbu7VQ07GT8HNxhwu2mOp96eLxKLODqGXD2tfMlb4JPpQn3HNCuS/m4OuyZb1ArBAAHvv1HdKVc7RmhlSIhnqI9ZQVQwPjqYGYhQb5eUJJGx0Jiyk7aI82FVB4am0GH1Z0VBc4ObolhSbtfpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214603; c=relaxed/simple;
	bh=/MWYtwrNcDazX//rRzn6aA+QmI17u6cG1k6o3dpPB+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+ugy5aTOiPSEg7WXsG5Oo+QnkFamUOmxkrsY3MXal7+e2/Vx8OHzfMqGvIoGHiFKrt8Kkvht/2Q3gV9Iq+tGpwyuknFuOYMWTDFlgy1SfUdxttITb6Jfpa17RxSJFRuPvRzIR6xmMayNE7QjOY4zPN08AmIlzUxdPvlbqW/yRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q8YQ2uEN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8RFn8U0p; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ENeWwoV8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VUEmkgTN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EEE3E220F9;
	Tue,  6 Feb 2024 10:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707214600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2LirOyLh0zu+s7wRq1797ksT14unjmeWiaZ9SYdvS8I=;
	b=Q8YQ2uENU3Rnr2gHqXLol4WmotIFMOutXpkRfTHW2gLST/88wgUHtVSuOHiXOEv1qqaTsV
	X6dbQBGfiRKMLof872fAgdr1YmEf6XS3Q0CwFI3weChYmSjTYqJf6950nkko4bfu52A/yv
	Kp49LCi8benjFvyDS7F+1VPuX8DDkk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707214600;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2LirOyLh0zu+s7wRq1797ksT14unjmeWiaZ9SYdvS8I=;
	b=8RFn8U0pEZJ3W+YBB7s1CMNn2MZFUgqLOLhfrZRTAWNpJYaNAED5f7jB7QNb6acc9mKG92
	4y/avmbiNtmlRSDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707214599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2LirOyLh0zu+s7wRq1797ksT14unjmeWiaZ9SYdvS8I=;
	b=ENeWwoV8nglWM/9SSNvAlvlkV1mVYNIyWRihOLvqUIvBAZguhmuhP43O2x+LfailCUcysw
	oK+cpxrtTX5Rt2Yh2XGfA0yceJaqbc/nbIoXPkug9ajUqFNft67lkhwru6JOJvWxTuFK6V
	ZKP0kOzQcRO25YIXXsWxZiRDaUYP+9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707214599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2LirOyLh0zu+s7wRq1797ksT14unjmeWiaZ9SYdvS8I=;
	b=VUEmkgTNEZVNFaY8rrBvaTxjceSk/L43rXxLq8TdvFjZwib94x+lXVaRlpEFiBvqWIfYb3
	y2wJ37BcN9wrzRCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E349A13A3A;
	Tue,  6 Feb 2024 10:16:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VHB3NwcHwmXifAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 06 Feb 2024 10:16:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A01A2A0809; Tue,  6 Feb 2024 11:16:39 +0100 (CET)
Date: Tue, 6 Feb 2024 11:16:39 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+8c777e17f74c66068ffa@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, ghandatmanas@gmail.com,
	jack@suse.cz, jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	mushi.shar@gmail.com, shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com
Subject: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in dbSplit
Message-ID: <20240206101639.waddtknizshby3x3@quack3>
References: <0000000000005a02da05ea31b295@google.com>
 <000000000000ba28410610b33cc5@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ba28410610b33cc5@google.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [2.89 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.01)[47.67%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=26188a62745981b4];
	 TAGGED_RCPT(0.00)[8c777e17f74c66068ffa];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[kernel.dk,kernel.org,gmail.com,suse.cz,lists.sourceforge.net,vger.kernel.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Level: **
X-Spam-Score: 2.89
X-Spam-Flag: NO

On Tue 06-02-24 01:31:04, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=110ffd6c180000
> start commit:   708283abf896 Merge tag 'dmaengine-6.6-rc1' of git://git.ke..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=26188a62745981b4
> dashboard link: https://syzkaller.appspot.com/bug?extid=8c777e17f74c66068ffa
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138fb834680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1399c448680000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
 
Makes sense.

#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

