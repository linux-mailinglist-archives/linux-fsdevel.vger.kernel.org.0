Return-Path: <linux-fsdevel+bounces-8145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE8A83032B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 11:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038721F25B9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 10:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76941EB36;
	Wed, 17 Jan 2024 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E4D3qnT8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7/it6KLu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E4D3qnT8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7/it6KLu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778E71EB34;
	Wed, 17 Jan 2024 10:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485699; cv=none; b=N5dVk+SG49Luei4s9DcZ/pvjGz/Bh8ZeDBa439epCt0IiaAHj//wbZ5aTFy9dvAIzZuvNMQg07oIEuNyNP9apZA86yaMYmIYRWVmj0irI2FGkHW/1E/5y2Jm7qMAdyCKKBogRjkKOFgWpE0Epy6zIhHee4I6XRd3re16bP8ua9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485699; c=relaxed/simple;
	bh=1YwSIJw/A5Q1wIZVbJRnxhPQV+dQhnyBEW6ORLojnRU=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spamd-Result:X-Rspamd-Server:
	 X-Spam-Score:X-Rspamd-Queue-Id:X-Spam-Level:X-Spam-Flag:
	 X-Spamd-Bar; b=CLS3BQApCInWFIWhnrB+rObRwnUBEDp/vsPUd6sWOj77QmYGddBnwR9+F8nN1FpqOYfcN4ZVmToByXw2EyZW3uj68NZgVu1aHnMRDIsk44vQD3cZpBnUv2e7sfQqw8PDmorZmyWTHrL/KX7Mqc3FdsNaRmprX/JM/xll7uXRexY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E4D3qnT8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7/it6KLu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E4D3qnT8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7/it6KLu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 988951F385;
	Wed, 17 Jan 2024 10:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705485694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ol/M+JgSYlGWPI1CdJ0jD7AkIa4yZuAQGdo6jqJQz9M=;
	b=E4D3qnT8lX97MO0MxnxuyYNQ8UJ36FqSuWC/XiAyYOi/S4ox8zs9REVhmFFxqPnct0VyO0
	Cni3Gyjtibg6rAxLxUcEVHDVomIaAZpP7FruHeqYUxyGzFoS/GYW3phW7QT22uwoZ4n4Qc
	dzOgdaLzX0D/oQ4j5UEHoUiuYyCW1cM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705485694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ol/M+JgSYlGWPI1CdJ0jD7AkIa4yZuAQGdo6jqJQz9M=;
	b=7/it6KLu3XQazsuP7YRI6Mjv4oLifFGWnHSqBGqP/mRZCOtW5lR6BH7Z2OU7lDlxJCDeGH
	bL+UR3M3ZKn949AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705485694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ol/M+JgSYlGWPI1CdJ0jD7AkIa4yZuAQGdo6jqJQz9M=;
	b=E4D3qnT8lX97MO0MxnxuyYNQ8UJ36FqSuWC/XiAyYOi/S4ox8zs9REVhmFFxqPnct0VyO0
	Cni3Gyjtibg6rAxLxUcEVHDVomIaAZpP7FruHeqYUxyGzFoS/GYW3phW7QT22uwoZ4n4Qc
	dzOgdaLzX0D/oQ4j5UEHoUiuYyCW1cM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705485694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ol/M+JgSYlGWPI1CdJ0jD7AkIa4yZuAQGdo6jqJQz9M=;
	b=7/it6KLu3XQazsuP7YRI6Mjv4oLifFGWnHSqBGqP/mRZCOtW5lR6BH7Z2OU7lDlxJCDeGH
	bL+UR3M3ZKn949AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A81E137EB;
	Wed, 17 Jan 2024 10:01:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VHLLIX6lp2VjJwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Jan 2024 10:01:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3B5C9A0803; Wed, 17 Jan 2024 11:01:34 +0100 (CET)
Date: Wed, 17 Jan 2024 11:01:34 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+60369f4775c014dd1804@syzkaller.appspotmail.com>
Cc: agruenba@redhat.com, axboe@kernel.dk, brauner@kernel.org,
	cluster-devel@redhat.com, gfs2@lists.linux.dev, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [gfs2?] BUG: sleeping function called from invalid
 context in gfs2_make_fs_ro
Message-ID: <20240117100134.o2wthveeef4bx34w@quack3>
References: <0000000000007caa3f06014cad2e@google.com>
 <00000000000088f73f060f1999fa@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000088f73f060f1999fa@google.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=E4D3qnT8;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="7/it6KLu"
X-Spamd-Result: default: False [2.65 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=a4507c291b5ab5d4];
	 TAGGED_RCPT(0.00)[60369f4775c014dd1804];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	 BAYES_HAM(-0.04)[57.71%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 2.65
X-Rspamd-Queue-Id: 988951F385
X-Spam-Level: **
X-Spam-Flag: NO
X-Spamd-Bar: ++

On Tue 16-01-24 16:48:04, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=126262dbe80000
> start commit:   46670259519f Merge tag 'for-6.5-rc2-tag' of git://git.kern..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a4507c291b5ab5d4
> dashboard link: https://syzkaller.appspot.com/bug?extid=60369f4775c014dd1804
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1602904ea80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d67e9ea80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Makes sense:
 
#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

