Return-Path: <linux-fsdevel+bounces-14035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F20876E23
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 01:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ACFC1F23111
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 00:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1931E10EF;
	Sat,  9 Mar 2024 00:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3TnBNkrV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KGpfX1iJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="11OMVG5k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kdZWHlhS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4271E37A;
	Sat,  9 Mar 2024 00:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709944146; cv=none; b=GiDG7emYOMfGR2M4+SO8vaIwh9KQoQtiY8MNzof3TBRG3d32QJ17VajyKojmKtv1UKLJuOMszh4F9H0kkQ3y/3bCJ1QHa9oO0AQRzLWN05Mo5kGv/sB9M2Z5/jbZZuYlThcC/i25no7AHd4HtK6v40RgA1dEfC+UTZ+OnVP2Dt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709944146; c=relaxed/simple;
	bh=hKBfxrSmNRaZ1C0QVb8ykK5TUgaExQKKJu1L+1QMJnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyOCsYrPB6HmnuMtYifowu10APw60Pjaayt9MZxDxQ7feuXGGaURJS96ER9oaMr8BhnKEn0fSpHlC30ydrGyEbpuFZ4sW2zoefE/PFdLYA6/KzLNCosQFwIWhwJF7mRv4eIxmSbILLyY05RpxROMYoLDs5ifA3fl3vJyB1CrkVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3TnBNkrV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KGpfX1iJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=11OMVG5k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kdZWHlhS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B52DF2070C;
	Fri,  8 Mar 2024 22:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709936387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zwRPwzFnD9SACxO6sDVxQL/jE1uGXeBYAssp/iPTmM8=;
	b=3TnBNkrVM0mCT8bjbeCYqaaOUE9BQglZRzBcXLjIvGTnRRCKmr1OgeW7hVsgvgoopwkf0l
	+x8p+tm+c3MWKRXl1sVYvHsrQ9yKP0pX2YajmDUjvT19pUVKMboUF/Lipl2P4VqkErUKzi
	TvUInpJhdG+J4qqcsGKEKT83jTTSng8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709936387;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zwRPwzFnD9SACxO6sDVxQL/jE1uGXeBYAssp/iPTmM8=;
	b=KGpfX1iJQoRrdghVjkjbXgVVQE039JeTw9lo6vkzqhdyx11fy0+iBF3j7N2eMFqJUqVg+/
	Sg5/zdF9Cr759ECw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709936385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zwRPwzFnD9SACxO6sDVxQL/jE1uGXeBYAssp/iPTmM8=;
	b=11OMVG5kgv1+zC9B+ihdFfkqPM8k2VdFfWD13ogOpv5QZh+Gw0ZdQUFs765x/XfzsG0xDR
	hFliGY7ZfjgCyO1B0SeclxqCiRrnd/u7fCQ7n8XN/Oyx4dgfw4fo/osrcQGLAu/5sBEz/L
	7D4yIrlD7+V+iM3q/Z4blEXKQb4ZXuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709936385;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zwRPwzFnD9SACxO6sDVxQL/jE1uGXeBYAssp/iPTmM8=;
	b=kdZWHlhSs7J0madnPwZzPOEUErCnWbCYQBibr6yoq8BlYdLuvg15FBpuhe4Jag5bPSgezg
	t8twFFLUCI1EmLBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA6A1133DC;
	Fri,  8 Mar 2024 22:19:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aNGUKQGP62WLQgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 08 Mar 2024 22:19:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6C5FCA0807; Fri,  8 Mar 2024 23:19:45 +0100 (CET)
Date: Fri, 8 Mar 2024 23:19:45 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+4f7a1fc5ec86b956afb4@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hfs?] KASAN: slab-out-of-bounds Write in
 hfs_bnode_read_key
Message-ID: <20240308221945.2ddq5o2h75x7eoej@quack3>
References: <000000000000a2c13905fda1757e@google.com>
 <0000000000004b8d8206123dd402@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000004b8d8206123dd402@google.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: *
X-Spam-Score: 1.69
X-Spamd-Result: default: False [1.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.01)[45.68%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=162cf2103e4a7453];
	 TAGGED_RCPT(0.00)[4f7a1fc5ec86b956afb4];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,syzkaller.appspot.com:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO

On Sun 25-02-24 16:17:04, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12e81c54180000
> start commit:   e5282a7d8f6b Merge tag 'scsi-fixes' of git://git.kernel.or..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=162cf2103e4a7453
> dashboard link: https://syzkaller.appspot.com/bug?extid=4f7a1fc5ec86b956afb4
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12feb345280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123cb2a5280000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
 
Unclear but let's see whether there are other reproducers.

#syz fix: fs: Block writes to mounted block devices

								Honz
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

