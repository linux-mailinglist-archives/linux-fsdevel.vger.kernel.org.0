Return-Path: <linux-fsdevel+bounces-63264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C4FBB342C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D78543D8B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292722F1FDD;
	Thu,  2 Oct 2025 08:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TqfCzb3x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IarRZo5E";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TqfCzb3x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IarRZo5E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA08E2F1FC1
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 08:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759393196; cv=none; b=okwh/9NfbDddWvzXc/SfxC+yKqUl+VWbsqS2DVrW6zWWmT6uW6tk2LMERIuLCimTrfM3wrkcx7TJ/uPlKZfF1NhTESsdGny77EQO3kiK70WlTkXshbjIeg3f88gyTYov0jSgsNiM3UT4ZMoTMp1hHqAJ7QPwm+stnw9fKgZZGfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759393196; c=relaxed/simple;
	bh=S+aCkm6yG2Btn3fL69jj1tlpwurqMhvUmEE3mORoj1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8h0GfzHyjXdzsvAPwqdRduqoM3NY9L2ZnYLTA43++Prwpd+b/07AjwUSdLRdN/wJ6IQHzKqqKRGy5YPLv1sYSFfH7mUugu56WEP0GY59jFBJcSzlbCX2kMhxxT+o4Ynaq1OvAVD9Q1tcCaVaDUw1BjHAdu06IyAp4Kk/MF/bnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TqfCzb3x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IarRZo5E; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TqfCzb3x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IarRZo5E; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B02DF1F8D4;
	Thu,  2 Oct 2025 08:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759393192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2/LbKpJXex3eAogkvshZEWozp2J1FFOZdR/dpOaaQTU=;
	b=TqfCzb3x6wTFGBd7fIj+wxzJ0+NGq5PiqHPs1ZwoMz8tY5M4OcC+LTdNMs2dCzW9iExEut
	xkOumHCCyx1Uy+n7X0WjoF8K8y+UUFajpqnX2LQSQIpQm12zcF3XJPATgqjTuHw5tKKIV2
	FnghvUT9a2TSnlFeDypK2XOw6RzFGVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759393192;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2/LbKpJXex3eAogkvshZEWozp2J1FFOZdR/dpOaaQTU=;
	b=IarRZo5EUg+zWoMMCc314rWCj0Y/I5++ugQyJtmzeIg+w7tsioXPqO1Pqj4wdl8QhZ6eIX
	kn0iUKQqRyXj1NAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759393192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2/LbKpJXex3eAogkvshZEWozp2J1FFOZdR/dpOaaQTU=;
	b=TqfCzb3x6wTFGBd7fIj+wxzJ0+NGq5PiqHPs1ZwoMz8tY5M4OcC+LTdNMs2dCzW9iExEut
	xkOumHCCyx1Uy+n7X0WjoF8K8y+UUFajpqnX2LQSQIpQm12zcF3XJPATgqjTuHw5tKKIV2
	FnghvUT9a2TSnlFeDypK2XOw6RzFGVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759393192;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2/LbKpJXex3eAogkvshZEWozp2J1FFOZdR/dpOaaQTU=;
	b=IarRZo5EUg+zWoMMCc314rWCj0Y/I5++ugQyJtmzeIg+w7tsioXPqO1Pqj4wdl8QhZ6eIX
	kn0iUKQqRyXj1NAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A410A13990;
	Thu,  2 Oct 2025 08:19:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dIgMKKg13miQUwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 02 Oct 2025 08:19:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B281BA0A56; Thu,  2 Oct 2025 10:19:46 +0200 (CEST)
Date: Thu, 2 Oct 2025 10:19:46 +0200
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+e0f8855a87443d6a2413@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] WARNING in copy_mnt_ns
Message-ID: <siwzfsrwodz2zfxqmub4yrfcadmnygdoc7a5imvtr3eicgzlsn@2ipfsri5p7ui>
References: <68dd8c99.a00a0220.102ee.0061.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dvp74spf6ooxd5tb"
Content-Disposition: inline
In-Reply-To: <68dd8c99.a00a0220.102ee.0061.GAE@google.com>
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=8f1ac8502efee0ee];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[e0f8855a87443d6a2413];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	SUBJECT_HAS_QUESTION(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	HAS_ATTACHMENT(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -1.30


--dvp74spf6ooxd5tb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed 01-10-25 13:18:33, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    50c19e20ed2e Merge tag 'nolibc-20250928-for-6.18-1' of git..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=126f605b980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8f1ac8502efee0ee
> dashboard link: https://syzkaller.appspot.com/bug?extid=e0f8855a87443d6a2413
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1374b858580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15602092580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/5fb1f87b20e9/disk-50c19e20.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/aebfd0341e80/vmlinux-50c19e20.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/11452a5eed6c/bzImage-50c19e20.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e0f8855a87443d6a2413@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> ida_free called for id=1019 which is not allocated.

Please try attached patch:

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--dvp74spf6ooxd5tb
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-ns-Fix-mnt-ns-ida-handling-in-copy_mnt_ns.patch"

From 5cbdc1dd457f85fdbaa8f5840feeffee41f9aaae Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Thu, 2 Oct 2025 10:15:06 +0200
Subject: [PATCH] ns: Fix mnt ns ida handling in copy_mnt_ns()

Commit be5f21d3985f ("ns: add ns_common_free()") modified error cleanup
and started to free wrong inode number from the ida. Fix it.

Reported-by: syzbot+e0f8855a87443d6a2413@syzkaller.appspotmail.com
Fixes: be5f21d3985f ("ns: add ns_common_free()")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index dc01b14c58cd..1ba97d745019 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4165,7 +4165,7 @@ struct mnt_namespace *copy_mnt_ns(u64 flags, struct mnt_namespace *ns,
 	new = copy_tree(old, old->mnt.mnt_root, copy_flags);
 	if (IS_ERR(new)) {
 		namespace_unlock();
-		ns_common_free(ns);
+		ns_common_free(new_ns);
 		dec_mnt_namespaces(new_ns->ucounts);
 		mnt_ns_release(new_ns);
 		return ERR_CAST(new);
-- 
2.51.0


--dvp74spf6ooxd5tb--

