Return-Path: <linux-fsdevel+bounces-14159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A94BB878854
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 19:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 059EEB215F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 18:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5978658AA8;
	Mon, 11 Mar 2024 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rjRJLpdA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oUKhupSn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ELHSdRsA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eNLSWRaW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1123358203;
	Mon, 11 Mar 2024 18:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182888; cv=none; b=CraxYKbE4FMd+zAAmh9lHVq5JZrX/OhbtN5N3SxY7nLPBy7E9uuX9fta2hB8XBd3oTGIQb4BDdKdkPmrMNxKyjp6RrLLcbAMlQrk9FWtDaw1TkiLl2ISF8r8rmUkB88ojo9TpzSjuTbLzrVQwrQs5B4eP/5aRvIa3yrCOn4nFAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182888; c=relaxed/simple;
	bh=mUUzn+Ga9yhfHo9EKvOS/7OF9mFKpbnPSScMGiqQnkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6M9L4DOvpdKSHvQxSUSbCEYCQRwc8QqDmc+Vj/FcU8mPowbpKfRWxyP78lpHAUhxrBIMFrD/4yY/VScmPmIkX9Avw25GEHTaMiKKeCgYP7MmiwhfXV4vOh1XLGhz28icL73AxpGDTBsCf3cR1M/2iNu4jCx62sEFsgHrMdwoaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rjRJLpdA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oUKhupSn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ELHSdRsA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eNLSWRaW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6CF8B5CA53;
	Mon, 11 Mar 2024 18:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710182885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZB0gBvy/L4auocycyQAq42K+/ZipH3RzMsqZu8eZW+o=;
	b=rjRJLpdADGapW+bLtHloCCk4PmeYcq0jiS7wTjt515EnHOKrohoW48hQ3RwEe0k39J7E/g
	hQIJaqjuEXk6+ODkWk+LiUchTXMWYLk2RY54NlLaMKmu6dtXc6tZyXCPlFA5Zc95hoZPy/
	gzFgoLH2WRIGGfn47Uw4khSrmn8IMtQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710182885;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZB0gBvy/L4auocycyQAq42K+/ZipH3RzMsqZu8eZW+o=;
	b=oUKhupSnzt45jAJgpSvY5GsowEJi0NYIT4eHexWP1E02MkUFJZN0jmBVZX4w1t1BStFFMS
	NnDcn69ix0l0qmBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710182884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZB0gBvy/L4auocycyQAq42K+/ZipH3RzMsqZu8eZW+o=;
	b=ELHSdRsANKie5iUgl7dXE3yszldSlyrKlHtEqk4/6NHf5Dy7sCAe8r4CgXlwIksAQEZh+p
	CpPBUp0GaJ7V+7yDcJJ/KrP+zn+3czJag018U4VYdZSY0GD9tb8qizhXauQPE+gpG85zlO
	emZJ1ZilKI9fn1PlhV/KpVCbmUsJFJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710182884;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZB0gBvy/L4auocycyQAq42K+/ZipH3RzMsqZu8eZW+o=;
	b=eNLSWRaWklb2CNS5F0nbYwuAha+vBN6q+kz6gUgwvUmHb3xNQTnjJnGvN30wN9XTrovp39
	3ddbFK1A++IvqSAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D1D613695;
	Mon, 11 Mar 2024 18:48:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZiqvFuRR72VWQgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 11 Mar 2024 18:48:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 08AA1A080A; Mon, 11 Mar 2024 19:48:00 +0100 (CET)
Date: Mon, 11 Mar 2024 19:48:00 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+6ec38f7a8db3b3fb1002@syzkaller.appspotmail.com>
Cc: almaz.alexandrovich@paragon-software.com, anton@tuxera.com,
	axboe@kernel.dk, brauner@kernel.org, ebiederm@xmission.com,
	jack@suse.cz, keescook@chromium.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-ntfs-dev@lists.sourceforge.net, mjguzik@gmail.com,
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
	tytso@mit.edu, viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [syzbot] [ntfs3?] WARNING in do_open_execat
Message-ID: <20240311184800.d7nuzahhz36rlxpg@quack3>
References: <000000000000c74d44060334d476@google.com>
 <000000000000f67b790613665d7a@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f67b790613665d7a@google.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: *
X-Spam-Score: 1.68
X-Spamd-Result: default: False [1.68 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.02)[53.82%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=bdf178b2f20f99b0];
	 TAGGED_RCPT(0.00)[6ec38f7a8db3b3fb1002];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLn6wwtsxnyhk5uph3gjrme911)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.979];
	 RCPT_COUNT_TWELVE(0.00)[18];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[paragon-software.com,tuxera.com,kernel.dk,kernel.org,xmission.com,suse.cz,chromium.org,vger.kernel.org,kvack.org,lists.sourceforge.net,gmail.com,lists.linux.dev,googlegroups.com,mit.edu,zeniv.linux.org.uk,infradead.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO

On Mon 11-03-24 11:04:04, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17e3f58e180000
> start commit:   eb3479bc23fa Merge tag 'kbuild-fixes-v6.7' of git://git.ke..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bdf178b2f20f99b0
> dashboard link: https://syzkaller.appspot.com/bug?extid=6ec38f7a8db3b3fb1002
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15073fd4e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b20b8f680000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
 
#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

