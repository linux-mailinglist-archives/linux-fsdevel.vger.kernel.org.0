Return-Path: <linux-fsdevel+bounces-8059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB95482EF02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 13:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0801C2330C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 12:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE22D1BC2B;
	Tue, 16 Jan 2024 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oX4AD7ES";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OIhEUiDW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oX4AD7ES";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OIhEUiDW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCD41B96D;
	Tue, 16 Jan 2024 12:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF9031FB9F;
	Tue, 16 Jan 2024 12:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705408150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dP+emcvCW5fP+6umlhUsSdA7TL7B9j1Yq22phRxTYbc=;
	b=oX4AD7ESp7lF5pLSnUKycQ5N2fv3MPe8br4/ZmRV2h+/B0fOmPSjZSQMve0RCVVylpPUSS
	UjH0KJpfTZ1bqD3QJMtBk88Q8CrGNl+KmRUWzc1XkguvpWf0IxnRCTskVeGpva5wBTceZ0
	CItIOCCzVeINgYyGzL2edGlZlPdxkNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705408150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dP+emcvCW5fP+6umlhUsSdA7TL7B9j1Yq22phRxTYbc=;
	b=OIhEUiDW+MDZ2rK5vBboyam5O5qAT8hu7sEX+HUN+yeL6R0yaHI0CkZ+2ZnmVs9DQFdtcv
	R3FT2oA4mjEnWRBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705408150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dP+emcvCW5fP+6umlhUsSdA7TL7B9j1Yq22phRxTYbc=;
	b=oX4AD7ESp7lF5pLSnUKycQ5N2fv3MPe8br4/ZmRV2h+/B0fOmPSjZSQMve0RCVVylpPUSS
	UjH0KJpfTZ1bqD3QJMtBk88Q8CrGNl+KmRUWzc1XkguvpWf0IxnRCTskVeGpva5wBTceZ0
	CItIOCCzVeINgYyGzL2edGlZlPdxkNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705408150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dP+emcvCW5fP+6umlhUsSdA7TL7B9j1Yq22phRxTYbc=;
	b=OIhEUiDW+MDZ2rK5vBboyam5O5qAT8hu7sEX+HUN+yeL6R0yaHI0CkZ+2ZnmVs9DQFdtcv
	R3FT2oA4mjEnWRBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A282713751;
	Tue, 16 Jan 2024 12:29:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OOSlJ5Z2pmXWSwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 16 Jan 2024 12:29:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 40673A0803; Tue, 16 Jan 2024 13:29:10 +0100 (CET)
Date: Tue, 16 Jan 2024 13:29:10 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+e381e4c52ca8a53c3af7@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org, jack@suse.com, jirislaby@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [udf?] WARNING in __udf_add_aext (2)
Message-ID: <20240116122910.qthqhskjsjzz3hzl@quack3>
References: <00000000000049c61505fe026632@google.com>
 <0000000000004d6ecb060e98a1cb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000004d6ecb060e98a1cb@google.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.90
X-Spamd-Result: default: False [0.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.80)[84.72%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=33c8c2baba1cfc7e];
	 TAGGED_RCPT(0.00)[e381e4c52ca8a53c3af7];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO

On Wed 10-01-24 06:56:04, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 2aa91851ffa7cdfc0a63330d273115d38324b585
> Author: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Date:   Sun Aug 27 07:41:46 2023 +0000
> 
>     tty: n_tty: extract ECHO_OP processing to a separate function
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=129425e5e80000
> start commit:   b19edac5992d Merge tag 'nolibc.2023.06.22a' of git://git.k..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=33c8c2baba1cfc7e
> dashboard link: https://syzkaller.appspot.com/bug?extid=e381e4c52ca8a53c3af7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1515b4f0a80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: tty: n_tty: extract ECHO_OP processing to a separate function

Unlikely. The bisection seems to have gone wrong in the first step. I'd
rather suspect this was fixed by "fs: Block writes to mounted block
devices".

So:

#syz fix: fs: Block writes to mounted block devices

									Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

