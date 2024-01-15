Return-Path: <linux-fsdevel+bounces-7934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACA182D854
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 12:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE551F221F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 11:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE062C68D;
	Mon, 15 Jan 2024 11:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZOeTiQzg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SYeCE1Ml";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0LUkx/s3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vVs3ogSY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED592208A;
	Mon, 15 Jan 2024 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7928C1F8AA;
	Mon, 15 Jan 2024 11:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705318237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ds0QNZdlqOPWM3wbiQOUG4rSsjMSm36pA7PawZRmBsQ=;
	b=ZOeTiQzgPG8a/6cCLSQq7I6S7pMWL6yHQ2I54XwXl9owzF3eMVTjzSXDvVSNKva3fuwKQN
	GY7ziMTYo0bAFPHAVzxLZ1tnTSvmHiVY0PMZu0Hd0zRPslumOsKcvpZigPD0pzOh9Iippf
	M6xMFUTjq2dm/l8NCN6uUCUDK7QiBig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705318237;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ds0QNZdlqOPWM3wbiQOUG4rSsjMSm36pA7PawZRmBsQ=;
	b=SYeCE1MlmyIGUkI6htYZDGN2UMfQCYApyzBv2LrzpsGe5AOhk5fcuw4RvZ16zt6+249OJz
	PkYSNAY22Vu8TmCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705318236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ds0QNZdlqOPWM3wbiQOUG4rSsjMSm36pA7PawZRmBsQ=;
	b=0LUkx/s3v+D/Of5qr+0Gb4jEUf3Eagrj9cZWvmcQuAFgKIObfB5ycV1xcmHswXNOSNXnX1
	RO7uE1Bs2VuK7MrI17rTxA+gDUOnSYrN9CuUTyXqxy7RfXOMh2Jsfo37t5QGU0ysIOw3TS
	Cr0aNQvdK2ozcNqPUcf0Q/amNtqxY4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705318236;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ds0QNZdlqOPWM3wbiQOUG4rSsjMSm36pA7PawZRmBsQ=;
	b=vVs3ogSYAcHdWhQhauBRc2Rc5HTxq2aDPKel0gEYkGm1p1pgA10qINxdZLDkF8GeSp4C/x
	eZeozyLDGQbbhoDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E9C913712;
	Mon, 15 Jan 2024 11:30:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kCj8GlwXpWVAPQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Jan 2024 11:30:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2067FA07F7; Mon, 15 Jan 2024 12:30:36 +0100 (CET)
Date: Mon, 15 Jan 2024 12:30:36 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+3699edf4da1e736b317b@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz,
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] kernel BUG in txEnd
Message-ID: <20240115113036.bkgeheh3556cy7g6@quack3>
References: <0000000000009e798305fe8e95ac@google.com>
 <00000000000032d485060ec9b172@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000032d485060ec9b172@google.com>
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="0LUkx/s3";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vVs3ogSY
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.30 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.19)[70.91%];
	 SUBJECT_HAS_QUESTION(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=e74b395fe4978721];
	 TAGGED_RCPT(0.00)[3699edf4da1e736b317b];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 1.30
X-Rspamd-Queue-Id: 7928C1F8AA
X-Spam-Flag: NO

On Fri 12-01-24 17:28:04, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1280b62be80000
> start commit:   692b7dc87ca6 Merge tag 'hyperv-fixes-signed-20230619' of g..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e74b395fe4978721
> dashboard link: https://syzkaller.appspot.com/bug?extid=3699edf4da1e736b317b
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b373a7280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1749e8f3280000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Makes sense:
 
#syz fix: fs: Block writes to mounted block devices

									Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

