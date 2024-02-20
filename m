Return-Path: <linux-fsdevel+bounces-12148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 926AD85B86F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 11:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43AD428424F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 10:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DACC60DEC;
	Tue, 20 Feb 2024 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F3fSdRfB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UNrJPI4S";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F3fSdRfB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UNrJPI4S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4195D725;
	Tue, 20 Feb 2024 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423256; cv=none; b=ryfG6jazOY8SS9GJ8xxHVGkecxZAvVOU1N6drxE4xilGYS/pOFTXdEro6StN+nPT0zuPuDZMOQ2C4ku4mtf6ZPMkJscBWQslY3lujPg5ibDbKtmJfjNYGs5+C3naUHU7ybKOVt2v5/MNTWJt22B0BkKtMI9S0ht+AnfsIO+gFqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423256; c=relaxed/simple;
	bh=YTi/aO2DKVDheV5Y5cpS66CFzB3oXSzsrt96DZOCW7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjg1JtjRLlbpF3MJD6e7TRIT7Q1QlYNNAuDVHtzU2zHQ7dQBL8B/pVIt25Vi+NFPERhYSwMa/CnkDba/BAECVlGaxJybyXTxTh5Fn2anKZP16NLfoaEEdNex872UsViG1kWtc6sbH6eyYxH/XxJWftPupZPLj9jNUe/XuTCFH5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F3fSdRfB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UNrJPI4S; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F3fSdRfB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UNrJPI4S; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0B8EE1F867;
	Tue, 20 Feb 2024 10:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708423253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3WLQmR6MxvKLiMYg1hRU/njfnb6/TPnqY3GDfUW2pNg=;
	b=F3fSdRfBUhmVBWxOQMwJH1ycbQw2jgi/lLSKMhSk7pGofNgaunQCvSyyyJKKDrNfy59tOa
	0k4KGFn7s7MA1fqYB20cJiLKTRnvrP0yF1NAEL++MydDGxFAdEFxrWB2qP9FYCobKeqnku
	BB4vKApSeoK6vqmg9sBsh4xmCCqARsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708423253;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3WLQmR6MxvKLiMYg1hRU/njfnb6/TPnqY3GDfUW2pNg=;
	b=UNrJPI4Sh03bTChsAI/c6H4MlFs2a0Iz9o6YI8AkqBEHdhoZGcwEHHRlwxH0OvqfBuJ53x
	xd+djClGy+knSjCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708423253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3WLQmR6MxvKLiMYg1hRU/njfnb6/TPnqY3GDfUW2pNg=;
	b=F3fSdRfBUhmVBWxOQMwJH1ycbQw2jgi/lLSKMhSk7pGofNgaunQCvSyyyJKKDrNfy59tOa
	0k4KGFn7s7MA1fqYB20cJiLKTRnvrP0yF1NAEL++MydDGxFAdEFxrWB2qP9FYCobKeqnku
	BB4vKApSeoK6vqmg9sBsh4xmCCqARsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708423253;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3WLQmR6MxvKLiMYg1hRU/njfnb6/TPnqY3GDfUW2pNg=;
	b=UNrJPI4Sh03bTChsAI/c6H4MlFs2a0Iz9o6YI8AkqBEHdhoZGcwEHHRlwxH0OvqfBuJ53x
	xd+djClGy+knSjCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id ECA5E1358A;
	Tue, 20 Feb 2024 10:00:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id q1xsOVR41GWkbwAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 20 Feb 2024 10:00:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8853BA0807; Tue, 20 Feb 2024 11:00:52 +0100 (CET)
Date: Tue, 20 Feb 2024 11:00:52 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+7d5fa8eb99155f439221@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, apparmor-owner@lists.ubuntu.com,
	apparmor@lists.ubuntu.com, axboe@kernel.dk, brauner@kernel.org,
	jack@suse.cz, jmorris@namei.org, john.johansen@canonical.com,
	john@apparmor.net, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, paul@paul-moore.com,
	serge@hallyn.com, syzkaller-bugs@googlegroups.com, terrelln@fb.com,
	tytso@mit.edu
Subject: Re: [syzbot] [apparmor?] [ext4?] general protection fault in
 common_perm_cond
Message-ID: <20240220100052.gbuy6dopqql7m7yl@quack3>
References: <000000000000ae0abc0600e0d534@google.com>
 <000000000000af682a0611c9a06f@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000af682a0611c9a06f@google.com>
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=F3fSdRfB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UNrJPI4S
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.49 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLrqdkzci5prbpfh8ttufrg9xb)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[44.04%];
	 SUBJECT_HAS_QUESTION(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=6769a69bd0e144b4];
	 TAGGED_RCPT(0.00)[7d5fa8eb99155f439221];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[19];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 1.49
X-Rspamd-Queue-Id: 0B8EE1F867
X-Spam-Flag: NO

On Mon 19-02-24 21:39:02, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1644f22c180000
> start commit:   b6e6cc1f78c7 Merge tag 'x86_urgent_for_6.5_rc2' of git://g..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6769a69bd0e144b4
> dashboard link: https://syzkaller.appspot.com/bug?extid=7d5fa8eb99155f439221
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137b16dca80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14153b7ca80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Makes sense.
 
#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

