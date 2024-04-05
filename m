Return-Path: <linux-fsdevel+bounces-16193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9117899E38
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 15:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183591C22FAD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 13:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E748216D4F9;
	Fri,  5 Apr 2024 13:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LpKWoS6s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ThdltWrz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LpKWoS6s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ThdltWrz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695BA16D4CB;
	Fri,  5 Apr 2024 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712323432; cv=none; b=VU556fzIWF7K1i3qCn5aw59pIm5QCyrrF/ryqn/G6QqgqiJbKHO3B6Tepf6go9EjaLk52TOzAVP2JNARGa+/5potHTPxzvxIeb/aXfJB1rkkfYtmDBqv/yRPWjptoj5rzQR7MjSdtyco/rKbIjVronkibeboXN2q3XDZHQWaVXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712323432; c=relaxed/simple;
	bh=DPMknOuH9vr+k05xVTvqXXWGLrwhoTkiLzlaSjIFxYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfJXGM3VGKNJ24K6cApzKS+t1xcqzUqa6NxTtCfCMO7N1zWQY6+MUzR7xmFfJq9z+Z3Q+OGE6Yn7nU7fB7RZqiE4O7c+HUsAOloy/O+l6DWKGOjVyWlkFxE7vkfXxHDHZrTSYV0mwJMec1duttRANicVhB5C/HkAy62ldWw1AM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LpKWoS6s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ThdltWrz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LpKWoS6s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ThdltWrz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1E83321A3F;
	Fri,  5 Apr 2024 13:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712323427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n42MBEOvB6X48kVlozNmNk9ygiV1fw/me5TDb56HR4o=;
	b=LpKWoS6srTBTx019hPpl3W1ivZFNP82jfcXMt1JqxI4I61v4/Oh5Jy4frBXwN/OV+5yO5p
	USX/W8tgEnXtIGfSycDK/NnDdObnIUlV3cqY4q3jiKw1C5C+qnTc4ZBkod1uuWF73H73Yr
	gI7xhSS/MFxs3M5GuDQrOVtQG8vD9cw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712323427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n42MBEOvB6X48kVlozNmNk9ygiV1fw/me5TDb56HR4o=;
	b=ThdltWrzvzl/QgEsmegd0Cr7lC2l3svSok1a/AMlUWOGFk3v77rtMAYTQXlWGE5hgnl0wF
	3N8x97jlaUVoH+Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LpKWoS6s;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ThdltWrz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712323427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n42MBEOvB6X48kVlozNmNk9ygiV1fw/me5TDb56HR4o=;
	b=LpKWoS6srTBTx019hPpl3W1ivZFNP82jfcXMt1JqxI4I61v4/Oh5Jy4frBXwN/OV+5yO5p
	USX/W8tgEnXtIGfSycDK/NnDdObnIUlV3cqY4q3jiKw1C5C+qnTc4ZBkod1uuWF73H73Yr
	gI7xhSS/MFxs3M5GuDQrOVtQG8vD9cw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712323427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n42MBEOvB6X48kVlozNmNk9ygiV1fw/me5TDb56HR4o=;
	b=ThdltWrzvzl/QgEsmegd0Cr7lC2l3svSok1a/AMlUWOGFk3v77rtMAYTQXlWGE5hgnl0wF
	3N8x97jlaUVoH+Cg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 14259139F1;
	Fri,  5 Apr 2024 13:23:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id NsvnBGP7D2ZlLAAAn2gu4w
	(envelope-from <jack@suse.cz>); Fri, 05 Apr 2024 13:23:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BE900A0814; Fri,  5 Apr 2024 15:23:46 +0200 (CEST)
Date: Fri, 5 Apr 2024 15:23:46 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Kemeng Shi <shikemeng@huaweicloud.com>,
	gregkh@linuxfoundation.org, konishi.ryusuke@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	tj@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [nilfs?] KASAN: slab-out-of-bounds Read in wb_writeback
Message-ID: <20240405132346.bid7gibby3lxxhez@quack3>
References: <000000000000fd0f2a061506cc93@google.com>
 <00000000000003b8c406151e0fd1@google.com>
 <20240403094717.zex45tc2kpkfelny@quack3>
 <20240405-heilbad-eisbrecher-cd0cbc27f36f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="q5dy3frwjvcfpelv"
Content-Disposition: inline
In-Reply-To: <20240405-heilbad-eisbrecher-cd0cbc27f36f@brauner>
X-Spam-Level: 
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=afcaf46d374cec8c];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.cz,huaweicloud.com,linuxfoundation.org,gmail.com,vger.kernel.org,googlegroups.com,kernel.org,zeniv.linux.org.uk];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_RCPT(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1E83321A3F
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -1.51


--q5dy3frwjvcfpelv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri 05-04-24 13:05:59, Christian Brauner wrote:
> On Wed, Apr 03, 2024 at 11:47:17AM +0200, Jan Kara wrote:
> > On Tue 02-04-24 07:38:25, syzbot wrote:
> > > syzbot has found a reproducer for the following issue on:
> > > 
> > > HEAD commit:    c0b832517f62 Add linux-next specific files for 20240402
> > > git tree:       linux-next
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=14af7dd9180000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=afcaf46d374cec8c
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=7b219b86935220db6dd8
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1729f003180000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17fa4341180000
> > > 
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/0d36ec76edc7/disk-c0b83251.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/6f9bb4e37dd0/vmlinux-c0b83251.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/2349287b14b7/bzImage-c0b83251.xz
> > > mounted in repro: https://storage.googleapis.com/syzbot-assets/9760c52a227c/mount_0.gz
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+7b219b86935220db6dd8@syzkaller.appspotmail.com
> > > 
> > > ==================================================================
> > > BUG: KASAN: slab-out-of-bounds in __lock_acquire+0x78/0x1fd0 kernel/locking/lockdep.c:5005
> > > Read of size 8 at addr ffff888020485fa8 by task kworker/u8:2/35
> > 
> > Looks like the writeback cleanups are causing some use-after-free issues.
> > The code KASAN is complaining about is:
> > 
> > 		/*
> > 		 * Nothing written. Wait for some inode to
> > 		 * become available for writeback. Otherwise
> > 		 * we'll just busyloop.
> > 		 */
> > 		trace_writeback_wait(wb, work);
> > 		inode = wb_inode(wb->b_more_io.prev);
> > >>>>>		spin_lock(&inode->i_lock); <<<<<<
> > 		spin_unlock(&wb->list_lock);
> > 		/* This function drops i_lock... */
> > 		inode_sleep_on_writeback(inode);
> > 
> > in wb_writeback(). Now looking at the changes indeed the commit
> > 167d6693deb ("fs/writeback: bail out if there is no more inodes for IO and
> > queued once") is buggy because it will result in trying to fetch 'inode'
> > from empty b_more_io list and thus we'll corrupt memory. I think instead of
> > modifying the condition:
> > 
> > 		if (list_empty(&wb->b_more_io)) {
> > 
> > we should do:
> > 
> > -		if (progress) {
> > +		if (progress || !queued) {
> >                         spin_unlock(&wb->list_lock);
> >                         continue;
> >                 }
> > 
> > Kemeng?
> 
> Fwiw, I observed this on xfstest too the last few days and tracked it
> down to this series. Here's the splat I got in case it helps:

OK, since this is apparently causing more issues and Kemeng didn't reply
yet, here's a fix in the form of the patch. It has passed some basic
testing. Feel free to fold it into Kemeng's patch so that we don't keep
linux-next broken longer than necessary. Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--q5dy3frwjvcfpelv
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-writeback-Fix-memory-corruption-in-writeback-code.patch"

From cede4bc05f7a9a38f21b5943c11592fdb098b4f4 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Fri, 5 Apr 2024 13:57:28 +0200
Subject: [PATCH] writeback: Fix memory corruption in writeback code

Commit 167d6693deb3 ("fs/writeback: bail out if there is no more inodes
for IO and queued once") made the loop in wb_writeback() continue, even
if we didn't have any inodes in b_more_io list when we didn't queue any
inodes into b_io list yet. Conceptually this is fine however the loop in
this case takes the first inode from b_more_io list and waits for
writeback on it to complete. When b_more_io list is empty, this results
in accesses beyond the wb->b_more_io list head corrupting struct
wb_writeback and memory beyond it. Fix the problem by directly
restarting the loop in this case instead of going through waiting on
inode in b_more_io list.

Reported-by: syzbot+7b219b86935220db6dd8@syzkaller.appspotmail.com
Fixes: 167d6693deb3 ("fs/writeback: bail out if there is no more inodes for IO and queued once")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index f7ed4192d0f8..92a5b8283528 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2137,7 +2137,7 @@ static long wb_writeback(struct bdi_writeback *wb,
 		 * mean the overall work is done. So we keep looping as long
 		 * as made some progress on cleaning pages or inodes.
 		 */
-		if (progress) {
+		if (progress || !queued) {
 			spin_unlock(&wb->list_lock);
 			continue;
 		}
@@ -2145,7 +2145,7 @@ static long wb_writeback(struct bdi_writeback *wb,
 		/*
 		 * No more inodes for IO, bail
 		 */
-		if (list_empty(&wb->b_more_io) && queued) {
+		if (list_empty(&wb->b_more_io)) {
 			spin_unlock(&wb->list_lock);
 			break;
 		}
-- 
2.35.3


--q5dy3frwjvcfpelv--

