Return-Path: <linux-fsdevel+bounces-10939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6117E84F4CD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 12:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907191C256CE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B342E834;
	Fri,  9 Feb 2024 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Uh/fXDaY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eDXces+u";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Uh/fXDaY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eDXces+u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEF72E644;
	Fri,  9 Feb 2024 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707479118; cv=none; b=hwgrD3UyrlmNc/QcvngQ95qRvszdyjlANcOQYFWsj5AipfmVD0YYgcxor/1pCxX0aP2RYDhIUkGLeTF17N4TiNNXCagKS7Ko/AvUEVfJhFTThPU3B7jvpD/N+lZ6OPvv+87BjN2jYZbx9LhksJ87JwjnlV7ivlnOpKUET61bF+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707479118; c=relaxed/simple;
	bh=E+nDtwUiAUEttvi/h3TCd85GOi6BilvqY46+H19p2aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDOXGZhSEYadtn4uYB7WLVQ6oEncpbiZ0lbqTiepUPwTsVC+t6CHvSyx+exghLHr7pT6YRsI7PH0d+Xfs0nhvXy0r+YBF9liLDT72miajbTttE45O2RXPgKbzWIZbFiaIaeeB3oOgcElUnE/YsKpBtd+4PO33D/DzGUGjkYpmbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Uh/fXDaY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eDXces+u; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Uh/fXDaY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eDXces+u; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 073211F801;
	Fri,  9 Feb 2024 11:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707479115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3RuNfboIvjxcDFUI4VvI/0RuJT/ZKE0oxstd9sPZhk8=;
	b=Uh/fXDaYYTO770PZkPdffP6bc7PZuZf50qu+GmWvzpugL7tU7/kYgoJZ1DwvojliRhY1ih
	iCHJqa/mivef34NsGgHQ+eNEiAPzE/ZUSPYXinjMzBNnhV3GISLHuSlZ4kHACYlvbwIgZa
	cpWsvTyQAvGYd85xNqD10vUx9HxMEKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707479115;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3RuNfboIvjxcDFUI4VvI/0RuJT/ZKE0oxstd9sPZhk8=;
	b=eDXces+uXrE8aH6fVuFB1YpOBAx8Nox7XwFAzlQEGLKUbvNkqgH/sBJm0QugFkXVa9Yok6
	ZJQVhOfcvn6pJTBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707479115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3RuNfboIvjxcDFUI4VvI/0RuJT/ZKE0oxstd9sPZhk8=;
	b=Uh/fXDaYYTO770PZkPdffP6bc7PZuZf50qu+GmWvzpugL7tU7/kYgoJZ1DwvojliRhY1ih
	iCHJqa/mivef34NsGgHQ+eNEiAPzE/ZUSPYXinjMzBNnhV3GISLHuSlZ4kHACYlvbwIgZa
	cpWsvTyQAvGYd85xNqD10vUx9HxMEKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707479115;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3RuNfboIvjxcDFUI4VvI/0RuJT/ZKE0oxstd9sPZhk8=;
	b=eDXces+uXrE8aH6fVuFB1YpOBAx8Nox7XwFAzlQEGLKUbvNkqgH/sBJm0QugFkXVa9Yok6
	ZJQVhOfcvn6pJTBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE9DF139E7;
	Fri,  9 Feb 2024 11:45:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WsY9OkoQxmWyPAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 09 Feb 2024 11:45:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8701AA0809; Fri,  9 Feb 2024 12:45:14 +0100 (CET)
Date: Fri, 9 Feb 2024 12:45:14 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+4b52080e97cde107939d@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hfs?] KASAN: slab-use-after-free Read in
 hfsplus_read_wrapper
Message-ID: <20240209114514.exbuygzal4ghfkat@quack3>
References: <00000000000075136e05fbf73d67@google.com>
 <00000000000087bf8a0610efbdcc@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000087bf8a0610efbdcc@google.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: *
X-Spam-Score: 1.70
X-Spamd-Result: default: False [1.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.00)[35.32%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=be2bd0a72b52d4da];
	 TAGGED_RCPT(0.00)[4b52080e97cde107939d];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO

On Fri 09-02-24 01:42:03, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15065d50180000
> start commit:   88035e5694a8 Merge tag 'hid-for-linus-2023121201' of git:/..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=be2bd0a72b52d4da
> dashboard link: https://syzkaller.appspot.com/bug?extid=4b52080e97cde107939d
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148fa88ae80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15067cc6e80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Makes sense:
 
#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

