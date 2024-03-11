Return-Path: <linux-fsdevel+bounces-14145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3837687858F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 17:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07C71F22666
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 16:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A1941211;
	Mon, 11 Mar 2024 16:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="safowM3Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VKQWZ1kA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="safowM3Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VKQWZ1kA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BE21388;
	Mon, 11 Mar 2024 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710175017; cv=none; b=emvCP/evR1objES3tajP5JUzj2xwipaUqNVP/Fx0iEWUJgd1wMLixBz3QFyoV2nj1eP6o4rc/zlG4EWtXCb/QrVFFrrzjhNsMQxle+bBMnzCu6feSf3FZP71AJRFkj/rZ6w9khjHYekixl6E7COuj3lDhqMOOO0Vfz1NME+XDks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710175017; c=relaxed/simple;
	bh=2DAaiJU1UIMYZU0rHIPc+7144fKAfr/e19Fv4G05lNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6gIMBY7lTH8iTVe/qeyPAu67Uv/iNxT1ynuO7UWEFTTwPKLKEKH5NJ5fQalWVclW+2JghVyPK47Chs1W8JKPGrtTtlgxUgLnD+jgJkNs1sOIj/IGCVVdm5tbU/3i86IRiTgoWUcTMzh3DWx2PI9YXSUuW/pYga9jAVw1RQ1JDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=safowM3Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VKQWZ1kA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=safowM3Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VKQWZ1kA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 838A65C947;
	Mon, 11 Mar 2024 16:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710175013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p/OdawrM0/sD3T/Xgs0TctF7VC0mNp6IkRXxs28E6/k=;
	b=safowM3Zv9IxdQWGsBm+1guipc3dFuJb7IRL46o5AVXrYWBcDZqdEEHFmAANyZl/1AGvm2
	YjzAh73eMOJOD03TWu4bTXXNFCAj5R8J7k8ZG/f1fQeLLiMaQoy6dvpVgLdAzC1xdu2rR8
	t5Hky/2x5b2YQM5X05DSCaZ2xLURRwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710175013;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p/OdawrM0/sD3T/Xgs0TctF7VC0mNp6IkRXxs28E6/k=;
	b=VKQWZ1kAIWFfAROpw/O9gtxwYeEezlLDN5LRWV8fYSziAr2JsjdQ7G2Xz/b9DGNXJhZ6in
	Z8IX3g5Z2uyHtkCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710175013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p/OdawrM0/sD3T/Xgs0TctF7VC0mNp6IkRXxs28E6/k=;
	b=safowM3Zv9IxdQWGsBm+1guipc3dFuJb7IRL46o5AVXrYWBcDZqdEEHFmAANyZl/1AGvm2
	YjzAh73eMOJOD03TWu4bTXXNFCAj5R8J7k8ZG/f1fQeLLiMaQoy6dvpVgLdAzC1xdu2rR8
	t5Hky/2x5b2YQM5X05DSCaZ2xLURRwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710175013;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p/OdawrM0/sD3T/Xgs0TctF7VC0mNp6IkRXxs28E6/k=;
	b=VKQWZ1kAIWFfAROpw/O9gtxwYeEezlLDN5LRWV8fYSziAr2JsjdQ7G2Xz/b9DGNXJhZ6in
	Z8IX3g5Z2uyHtkCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 777BF136BA;
	Mon, 11 Mar 2024 16:36:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Iu8hHSUz72V+GQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 11 Mar 2024 16:36:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 209D5A0807; Mon, 11 Mar 2024 17:36:53 +0100 (CET)
Date: Mon, 11 Mar 2024 17:36:53 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+c853277dcbfa2182e9aa@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz,
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] BUG: unable to handle kernel NULL pointer
 dereference in dtInsertEntry
Message-ID: <20240311163653.67zyxohwwohi32rq@quack3>
References: <0000000000007898e505e9971783@google.com>
 <0000000000003becc106134ed015@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000003becc106134ed015@google.com>
X-Spam-Level: **
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [2.89 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.01)[49.42%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4];
	 TAGGED_RCPT(0.00)[c853277dcbfa2182e9aa];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: 2.89
X-Spam-Flag: NO

On Sun 10-03-24 06:58:02, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16cb0da6180000
> start commit:   a4d7d7011219 Merge tag 'spi-fix-v6.4-rc5' of git://git.ker..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
> dashboard link: https://syzkaller.appspot.com/bug?extid=c853277dcbfa2182e9aa
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15cc622d280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1762cf83280000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Makes sense:
 
#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

