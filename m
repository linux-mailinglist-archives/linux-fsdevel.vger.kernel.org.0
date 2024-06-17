Return-Path: <linux-fsdevel+bounces-21820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D85F90B1D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 16:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45EEF1C22FC7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 14:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5991AC223;
	Mon, 17 Jun 2024 13:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r/K3PmNz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mpq6t8K2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r/K3PmNz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mpq6t8K2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E1119AD49;
	Mon, 17 Jun 2024 13:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631592; cv=none; b=ZYWij3zvgMxJJmCQqGD08k9ePoa6vFhaUqkfZSil+T6D1lHNqhw8tcs6T+HQrBnJIiUXv6yX5DkE3SH4EnX952+nwiqauRcny9W8mUqxXs4viBI50yzM50KQ78kvjCDHBNri6ZG9tHxPnZf7HqlsjjMyl4C4KghYpKrxRoCOru8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631592; c=relaxed/simple;
	bh=grf+gfPIry7cjE0QCoWI519+41pP+TNkQsjMbIeAo5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twBZlKzD6P06xILf+W04TtkrDnGuC6h7nAVkmVlxaXJfBmbbYiJc/RNN+5TAPoyimI12Nt8MQJiCDH8qAMsselxD9oOvrSzaPFAHSb6ddFuKpbXXyzuSMwsQHIAF/2zEt1izy2Ep5erwZiQs6yX8THmkkHAR7S+RqzNTNgKS4GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r/K3PmNz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mpq6t8K2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r/K3PmNz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mpq6t8K2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2788438263;
	Mon, 17 Jun 2024 13:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718631589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ma2i8ZOEdYL8rm1BANCfMWT47zZ325d/hxqoHMQs+gQ=;
	b=r/K3PmNzZiuTKIvUjp6uXM7uHKd7+couYQZSOJWwVjCbPGszak31oLUuhi2F0Pz7ox9+5f
	WXg02AUF0LKVvxENCbVGkyAWBczdkuDE7ulZIGFpDd8BgiksDisoP6qmOxJvn1MuOwni07
	u9RX3pjs9kohSiwMDAxmZNvucqjan4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718631589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ma2i8ZOEdYL8rm1BANCfMWT47zZ325d/hxqoHMQs+gQ=;
	b=Mpq6t8K2kABw2O6JloFVNqK2DLQ6NKIdtywGqkzdy5iB32Wsee2o8+DFUHbaFux0qSErLd
	yu9/YpH5+JMAkWCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="r/K3PmNz";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Mpq6t8K2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718631589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ma2i8ZOEdYL8rm1BANCfMWT47zZ325d/hxqoHMQs+gQ=;
	b=r/K3PmNzZiuTKIvUjp6uXM7uHKd7+couYQZSOJWwVjCbPGszak31oLUuhi2F0Pz7ox9+5f
	WXg02AUF0LKVvxENCbVGkyAWBczdkuDE7ulZIGFpDd8BgiksDisoP6qmOxJvn1MuOwni07
	u9RX3pjs9kohSiwMDAxmZNvucqjan4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718631589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ma2i8ZOEdYL8rm1BANCfMWT47zZ325d/hxqoHMQs+gQ=;
	b=Mpq6t8K2kABw2O6JloFVNqK2DLQ6NKIdtywGqkzdy5iB32Wsee2o8+DFUHbaFux0qSErLd
	yu9/YpH5+JMAkWCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C9A513AAA;
	Mon, 17 Jun 2024 13:39:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5ev2BqU8cGYcSAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 17 Jun 2024 13:39:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BB70DA0887; Mon, 17 Jun 2024 15:39:48 +0200 (CEST)
Date: Mon, 17 Jun 2024 15:39:48 +0200
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+d31185aa54170f7fc1f5@syzkaller.appspotmail.com>
Cc: jack@suse.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [udf?] KMSAN: uninit-value in udf_update_tag
Message-ID: <20240617133948.4kubbcbmn2q5j5pp@quack3>
References: <000000000000cf405f060d8f75a9@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="xic7exfhiajb22in"
Content-Disposition: inline
In-Reply-To: <000000000000cf405f060d8f75a9@google.com>
X-Rspamd-Queue-Id: 2788438263
X-Spam-Score: -1.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[d31185aa54170f7fc1f5];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	HAS_ATTACHMENT(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org


--xic7exfhiajb22in
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu 28-12-23 02:34:28, syzbot wrote:
> syzbot found the following issue on:
> 
> HEAD commit:    861deac3b092 Linux 6.7-rc7
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=16e0171ae80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3
> dashboard link: https://syzkaller.appspot.com/bug?extid=d31185aa54170f7fc1f5
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17561579e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1277e7a5e80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0ea60ee8ed32/disk-861deac3.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6d69fdc33021/vmlinux-861deac3.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/f0158750d452/bzImage-861deac3.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/f35551f8a991/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d31185aa54170f7fc1f5@syzkaller.appspotmail.com
> 
> =======================================================
> UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2022/11/22 14:59 (1000)
> =====================================================
> BUG: KMSAN: uninit-value in crc_itu_t_byte include/linux/crc-itu-t.h:22 [inline]
> BUG: KMSAN: uninit-value in crc_itu_t+0x287/0x2e0 lib/crc-itu-t.c:60
>  crc_itu_t_byte include/linux/crc-itu-t.h:22 [inline]
>  crc_itu_t+0x287/0x2e0 lib/crc-itu-t.c:60
>  udf_update_tag+0x5c/0x2a0 fs/udf/misc.c:261
>  udf_rename+0x13dd/0x16a0 fs/udf/namei.c:877
>  vfs_rename+0x1a79/0x1fa0 fs/namei.c:4844
>  do_renameat2+0x1571/0x1ca0 fs/namei.c:4996
>  __do_sys_rename fs/namei.c:5042 [inline]
>  __se_sys_rename fs/namei.c:5040 [inline]
>  __x64_sys_rename+0xec/0x140 fs/namei.c:5040
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> Local variable diriter created at:
>  udf_rename+0xbb/0x16a0 fs/udf/namei.c:768
>  vfs_rename+0x1a79/0x1fa0 fs/namei.c:4844
> 
> CPU: 0 PID: 5011 Comm: syz-executor409 Not tainted 6.7.0-rc7-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
> =====================================================
> 

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 6ba59ff4227927d3a8530fc2973b80e94b54d58f

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--xic7exfhiajb22in
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-udf-Fix-bogus-checksum-computation-in-udf_rename.patch"

From 1657db149c4c596cf1b2451b73f72db94b612800 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Mon, 17 Jun 2024 12:57:50 +0200
Subject: [PATCH] udf: Fix bogus checksum computation in udf_rename()

Syzbot reports uninitialized memory access in udf_rename() when updating
checksum of '..' directory entry of a moved directory. This is indeed
true as we pass on-stack diriter.fi to the udf_update_tag() and because
that has only struct fileIdentDesc included in it and not the impUse or
name fields, the checksumming function is going to checksum random stack
contents beyond the end of the structure. This is actually harmless
because the following udf_fiiter_write_fi() will recompute the checksum
from on-disk buffers where everything is properly included. So all that
is needed is just removing the bogus calculation.

Fixes: e9109a92d2a9 ("udf: Convert udf_rename() to new directory iteration code")
Link: https://lore.kernel.org/all/000000000000cf405f060d8f75a9@google.com/T/
Reported-by: syzbot+d31185aa54170f7fc1f5@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/namei.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 1308109fd42d..78a603129dd5 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -876,8 +876,6 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	if (has_diriter) {
 		diriter.fi.icb.extLocation =
 					cpu_to_lelb(UDF_I(new_dir)->i_location);
-		udf_update_tag((char *)&diriter.fi,
-			       udf_dir_entry_len(&diriter.fi));
 		udf_fiiter_write_fi(&diriter, NULL);
 		udf_fiiter_release(&diriter);
 	}
-- 
2.35.3


--xic7exfhiajb22in--

