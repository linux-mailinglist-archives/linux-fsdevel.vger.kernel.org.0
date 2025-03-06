Return-Path: <linux-fsdevel+bounces-43385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5961A5586C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 22:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03FCB189810B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 21:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3823126BD82;
	Thu,  6 Mar 2025 21:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vo7MOfEb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LGV2QuWi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vo7MOfEb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LGV2QuWi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCA5207A03
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Mar 2025 21:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295536; cv=none; b=ZFhJqmwREFq3g6jj8Qg81IOA5RfacnL485/Ercz74YVf1WeoMFl3jmmHkB4dtjyOAyEnMpDt6G751MKtcqhZMpQeWkb4Y3UoRGnjgUlSwyjaImutGH7ARN83Ko3L3bVsjoS2VovvWOkCzjCBSm+z+CsV+M+0EShElFR6F64Nln0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295536; c=relaxed/simple;
	bh=07Q5s0YnaGkcco6cGr31nyoGcEQOFUkbSK/2I4+E2lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6rqUFbJciNN74ihSsIqt2XmO6mWRJ2vHOAEnsOHzptokAjzWX9WO91/g+VRiIYMsvgtXdC2aSCOnyhoVgrHCl55uhxxanV3VgOIoCiIyyacUYQ7q6JsKK0X36Hhl5/qWbZL0u4cH2agp7u1IJyFp5BL/Sr3Za0kUiYMaIoue+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vo7MOfEb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LGV2QuWi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vo7MOfEb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LGV2QuWi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F322B21172;
	Thu,  6 Mar 2025 21:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741295532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WP//qILTTvyXuat8p3kG7Vms/HKG/PDTdBkdsKbMTQo=;
	b=Vo7MOfEb/uXt/aVyQEd9sy+Ng9wbLmLUo8Q9+xgfgBnOHnAZlaJ1doyBlDeY8ByKhaXPrc
	gWRfCwi3MgqyNWNU7qE+5V8keisj3DRgDVvGLG+FMlACuXIXHumXFyhEFGP6+2rWlQT38w
	tbDA93YjulfuFLj790Mx2ptwbaXIalE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741295532;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WP//qILTTvyXuat8p3kG7Vms/HKG/PDTdBkdsKbMTQo=;
	b=LGV2QuWino1TRK7OigczeiaaYvrRdu5vzPOwAeS8Sjz9IeuV5ufpVxDyXPJ9BFpPLncWoI
	tSqDt5+X6rJR5zCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Vo7MOfEb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LGV2QuWi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741295532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WP//qILTTvyXuat8p3kG7Vms/HKG/PDTdBkdsKbMTQo=;
	b=Vo7MOfEb/uXt/aVyQEd9sy+Ng9wbLmLUo8Q9+xgfgBnOHnAZlaJ1doyBlDeY8ByKhaXPrc
	gWRfCwi3MgqyNWNU7qE+5V8keisj3DRgDVvGLG+FMlACuXIXHumXFyhEFGP6+2rWlQT38w
	tbDA93YjulfuFLj790Mx2ptwbaXIalE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741295532;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WP//qILTTvyXuat8p3kG7Vms/HKG/PDTdBkdsKbMTQo=;
	b=LGV2QuWino1TRK7OigczeiaaYvrRdu5vzPOwAeS8Sjz9IeuV5ufpVxDyXPJ9BFpPLncWoI
	tSqDt5+X6rJR5zCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3EA513A61;
	Thu,  6 Mar 2025 21:12:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KuxHN6sPyme5egAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 06 Mar 2025 21:12:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7EA3EA087F; Thu,  6 Mar 2025 22:12:07 +0100 (CET)
Date: Thu, 6 Mar 2025 22:12:07 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+a9c0867e4d1dd0c7ab19@syzkaller.appspotmail.com>
Cc: amir73il@gmail.com, asmadeus@codewreck.org, brauner@kernel.org, 
	corbet@lwn.net, eadavis@qq.com, ericvh@kernel.org, jack@suse.com, jack@suse.cz, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, mjguzik@gmail.com, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev, viro@zeniv.linux.org.uk, 
	willy@infradead.org
Subject: Re: [syzbot] [udf?] general protection fault in d_splice_alias
Message-ID: <bcodvjvbdcv5xtwgf454feurvlg6nawmbhgb7tsyynigtlp7wz@kbnid2eeebnd>
References: <67a11d8a.050a0220.163cdc.0051.GAE@google.com>
 <67c96503.050a0220.15b4b9.0030.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67c96503.050a0220.15b4b9.0030.GAE@google.com>
X-Rspamd-Queue-Id: F322B21172
X-Spam-Score: -1.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=d1a6d4df5fcc342f];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,qq.com];
	FREEMAIL_CC(0.00)[gmail.com,codewreck.org,kernel.org,lwn.net,qq.com,suse.com,suse.cz,vger.kernel.org,crudebyte.com,ionkov.net,googlegroups.com,lists.linux.dev,zeniv.linux.org.uk,infradead.org];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_RCPT(0.00)[a9c0867e4d1dd0c7ab19];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 06-03-25 01:04:03, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 902e09c8acde117b00369521f54df817a983d4ab
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Mon Feb 3 21:16:09 2025 +0000
> 
>     fix braino in "9p: fix ->rename_sem exclusion"
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11d77078580000
> start commit:   69e858e0b8b2 Merge tag 'uml-for-linus-6.14-rc1' of git://g..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d1a6d4df5fcc342f
> dashboard link: https://syzkaller.appspot.com/bug?extid=a9c0867e4d1dd0c7ab19
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125d0eb0580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a595f8580000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
 
#syz fix: fix braino in "9p: fix ->rename_sem exclusion"

Not sure how 9p got into this but given where cause bisection landed this
makes a lot of sense.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

