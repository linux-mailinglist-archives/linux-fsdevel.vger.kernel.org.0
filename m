Return-Path: <linux-fsdevel+bounces-9054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F65483D8FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 12:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F016128872B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 11:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D73014015;
	Fri, 26 Jan 2024 11:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jYnnLwbZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fb/J5BeT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p8O3HT8x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AVYGOCcf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3712134A3;
	Fri, 26 Jan 2024 11:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706267171; cv=none; b=spQyNt0SkprsGKsB80IdvrCSrQ+GnB6p37aqnrdu/+6BEH9142KADM7t84yVGhiwQIHELR0ispoenk/Avu3DyVzLcpDGGL2YQ8HV3S01PQWYphi6Clr+doSIdN5xM6DrxWPx8r5EFA7DJJTvz0stj+pwRXndB4wLP/+UbvDWu9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706267171; c=relaxed/simple;
	bh=4dvkGFk45JEH0TJH5g3LyphMC0E2eiuJFV9HXzhFYc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HivYzm4v9HGqkanNZTPVOMSvl7nD6LyAdYBdfdmKU5LijUFh+FCCfCxMcLJ8IXOCBqdka6WLSAdckpOtSj8GUifvWnw6iAZ9XHkgIMEIN2p4wAeDAUD0PIkPEjK9E+CEWMketCYs+n7gz3NqgM2bMIRhOEsvdy7BI2Lxtfllwck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jYnnLwbZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fb/J5BeT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p8O3HT8x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AVYGOCcf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DC0B11FD38;
	Fri, 26 Jan 2024 11:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706267168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dbkeSPiFMYS4fWv45pqaCiMPxPH/2P+XDGohr6cgfb4=;
	b=jYnnLwbZa+hEU0K3yyOet9j8XvcuvpDN6WATXZi8LmJ3Kkv3c1j48CpkWuHQObWUic+g3N
	6MAr6Iw2NIeWvKQPpVqehOzfPEKcIRBYuojSy94O4h0DSAw7xk4F230AMjVpaQVyZhDi6q
	OLN284wVYpPtoYGHb34mgR6YrBMOK1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706267168;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dbkeSPiFMYS4fWv45pqaCiMPxPH/2P+XDGohr6cgfb4=;
	b=Fb/J5BeTrbxnY8bIdhgkqvPK9L7MUJGTh11k+sVqLpwEyB23kwmezYqoMn93XUovMwGccn
	EkohWaQGMF2hIwDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706267167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dbkeSPiFMYS4fWv45pqaCiMPxPH/2P+XDGohr6cgfb4=;
	b=p8O3HT8xKPbe7gmP4LaOSYxsUI1ClIdserIuMYZMZMdXZ5ixrROg9pKHGiwMVbFPTNUCN2
	Ovbb1xlxZO7vLpSdn7o4uNoYnRKrK7Q9nkxGZXa6BRpvm+klbhw61JyHhxPWSOV/2tq5WA
	KGEA0eKAFmFh2F7oT1P9vuVi54Gci4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706267167;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dbkeSPiFMYS4fWv45pqaCiMPxPH/2P+XDGohr6cgfb4=;
	b=AVYGOCcf11qrUekIdC9sXCHXAlnfWB92rr4GjAJRtxAKT+c7K+xYpheIU8jTK4Jnwa02Sa
	RArsW7Hxt4oKcMCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21124134C3;
	Fri, 26 Jan 2024 11:06:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qeQMCB+Ss2UPLgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 26 Jan 2024 11:06:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0542CA0805; Fri, 26 Jan 2024 12:05:22 +0100 (CET)
Date: Fri, 26 Jan 2024 12:05:22 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+198e7455f3a4f38b838a@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, axboe@kernel.dk, brauner@kernel.org,
	jack@suse.cz, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data_end
Message-ID: <20240126110522.kltwopnoabgxiu6j@quack3>
References: <000000000000562d8105f5ecc4ca@google.com>
 <00000000000007cd5c060fbc9da4@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000007cd5c060fbc9da4@google.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.44 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-1.46)[91.38%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=93ac5233c138249e];
	 TAGGED_RCPT(0.00)[198e7455f3a4f38b838a];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Level: *
X-Spam-Score: 1.44
X-Spam-Flag: NO

On Wed 24-01-24 19:17:03, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1682e45fe80000
> start commit:   90b0c2b2edd1 Merge tag 'pinctrl-v6.7-1' of git://git.kerne..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=93ac5233c138249e
> dashboard link: https://syzkaller.appspot.com/bug?extid=198e7455f3a4f38b838a
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17277d7f680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123c58df680000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
 
Makes sense:

#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

