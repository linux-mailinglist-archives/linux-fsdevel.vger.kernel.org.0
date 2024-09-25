Return-Path: <linux-fsdevel+bounces-30064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8AA98594C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 13:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B00C61C20FD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 11:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F324D19E989;
	Wed, 25 Sep 2024 11:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rjDAUP8w";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="296P/npR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rjDAUP8w";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="296P/npR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D43719DFAB
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 11:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264318; cv=none; b=ETmXvAxjM87xXeBCFrt0jmGWqC5y73SG8H/qw1I+9J5oayOieKD4/utcJD0sySS1zrCzADzbgeys7D+k+oQhW1F6TPs6PG5AXL1sxqO62s7kvypyZT7ZuQt5EozMLiSRmoh+2yV1nxcjqRbarJdFZUADj8LHIX/DPtkFY5R2zTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264318; c=relaxed/simple;
	bh=PE6nKTXhgHxTDs5N4SS0Vh9SBcMqQD2/GFEtB+w3lPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aer5/Yh0lYEMeF7IRtBuyugqSukYhIhXcfe8Ep+XmVLoq4f8UUOITgI5AbTgnKDouWSwwQLt8QaraU4MZL/I5CSYbVKQCH/HTnV8kNp5t1GKWfvs8lConCVw0xaR1Ewqmd7wQEh4uiuXFxezWpRy5Mxrx4yxEF5ynNPPGpdhJsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rjDAUP8w; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=296P/npR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rjDAUP8w; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=296P/npR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 930FF1F450;
	Wed, 25 Sep 2024 11:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727264314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ag/38XRNvmoyn/TOBeLjQRUMlwr0F6jACn3zVBgjBG8=;
	b=rjDAUP8wng27+e6Ymr9KZTGcossd4L8tmuPtoaBs7bFDnHFCx0L01ycUjjYCb6dzgHZvJN
	RceRpAdOZO3HiuNJs4aSWU6hN+Fzeqkh6TjqZ+MF5+6uTxPnFWOUc53KxzWv3aHpfmC7dT
	FIt1BlWn7M8ov+aFOvs84NSn2yGcX+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727264314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ag/38XRNvmoyn/TOBeLjQRUMlwr0F6jACn3zVBgjBG8=;
	b=296P/npRv1gsc81qKOmUZZxcMjcddm2qIyWlxCvIsD6QrJ4jIA1Z0R4RX9xjNsp37AT+/N
	qCFsPtb6BVQ8XjCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rjDAUP8w;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="296P/npR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727264314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ag/38XRNvmoyn/TOBeLjQRUMlwr0F6jACn3zVBgjBG8=;
	b=rjDAUP8wng27+e6Ymr9KZTGcossd4L8tmuPtoaBs7bFDnHFCx0L01ycUjjYCb6dzgHZvJN
	RceRpAdOZO3HiuNJs4aSWU6hN+Fzeqkh6TjqZ+MF5+6uTxPnFWOUc53KxzWv3aHpfmC7dT
	FIt1BlWn7M8ov+aFOvs84NSn2yGcX+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727264314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ag/38XRNvmoyn/TOBeLjQRUMlwr0F6jACn3zVBgjBG8=;
	b=296P/npRv1gsc81qKOmUZZxcMjcddm2qIyWlxCvIsD6QrJ4jIA1Z0R4RX9xjNsp37AT+/N
	qCFsPtb6BVQ8XjCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7836913A6A;
	Wed, 25 Sep 2024 11:38:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ghv9HDr282Z8OwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 25 Sep 2024 11:38:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1A6A5A089B; Wed, 25 Sep 2024 13:38:34 +0200 (CEST)
Date: Wed, 25 Sep 2024 13:38:34 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Krishna Vivek Vitta <kvitta@microsoft.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>, v9fs@lists.linux.dev
Subject: Re: [EXTERNAL] Re: Git clone fails in p9 file system marked with
 FANOTIFY
Message-ID: <20240925113834.eywqa4zslz6b6dag@quack3>
References: <SI2P153MB07182F3424619EDDD1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxiuPn4g1EBAq70XU-_5tYOXh4HqO5WF6O2YsfF9kM=qPw@mail.gmail.com>
 <SI2P153MB07187CEE4DFF8CDD925D6812D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjd2pf-KHiXdHWDZ10um=_Joy9y5_1VC34gm6Yqb-JYog@mail.gmail.com>
 <SI2P153MB0718D1D7D2F39F48E6D870C1D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <SI2P153MB07187B0BE417F6662A991584D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <20240925081146.5gpfxo5mfmlcg4dr@quack3>
 <20240925081808.lzu6ukr6pr2553tf@quack3>
 <CAOQ4uxji2ENLXB2CeUmt72YhKv_wV8=L=JhnfYTh0RTunyTQXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxji2ENLXB2CeUmt72YhKv_wV8=L=JhnfYTh0RTunyTQXw@mail.gmail.com>
X-Rspamd-Queue-Id: 930FF1F450
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[Adding 9p guys to CC]

On Wed 25-09-24 12:51:38, Amir Goldstein wrote:
> On Wed, Sep 25, 2024 at 10:18 AM Jan Kara <jack@suse.cz> wrote:
> > On Wed 25-09-24 10:11:46, Jan Kara wrote:
> > > On Tue 24-09-24 12:07:51, Krishna Vivek Vitta wrote:
> > > > Please ignore the last line.
> > > > Git clone operation is failing with fanotify example code as well.
> > > >
> > > > root@MININT-S244RA7:/mnt/c/Users/kvitta/Desktop/MDE binaries/GitCloneIssue# ./fanotify_ex /mnt/c
> > > > Press enter key to terminate.
> > > > root@MININT-S244RA7:/mnt/c/Users/kvitta/Desktop/MDE binaries/GitCloneIssue# ./fanotify_ex /mnt/c
> > > > Press enter key to terminate.
> > > > Listening for events.
> > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/info/exclude
> > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/info/exclude
> > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-applypatch.sample
> > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-applypatch.sample
> > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/applypatch-msg.sample
> > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/applypatch-msg.sample
> > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/commit-msg.sample
> > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/commit-msg.sample
> > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-push.sample
> > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-push.sample
> > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-merge-commit.sample
> > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-merge-commit.sample
> > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-commit.sample
> > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-commit.sample
> > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/post-update.sample
> > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/post-update.sample
> > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/push-to-checkout.sample
> > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/push-to-checkout.sample
> > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/fsmonitor-watchman.sample
> > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/fsmonitor-watchman.sample
> > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/update.sample
> > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/update.sample
> > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-rebase.sample
> > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-rebase.sample
> > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-receive.sample
> > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-receive.sample
> > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/prepare-commit-msg.sample
> > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/prepare-commit-msg.sample
> > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/description
> > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/description
> > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/HEAD.lock
> > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/HEAD.lock
> > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config.lock
> > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/config.lock
> > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config.lock
> > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config
> > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config
> > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/config
> > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config.lock
> > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config
> > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config
> > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/config
> > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config.lock
> > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config
> > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config
> > > > FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/config
> > > > FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/tNbqjiA
> > > > read: No such file or directory
> > > > root@MININT-S244RA7:/mnt/c/Users/kvitta/Desktop/MDE binaries/GitCloneIssue#
> > >
> > > OK, so it appears that dentry_open() is failing with ENOENT when we try to
> > > open the file descriptor to return with the event. This is indeed
> > > unexpected from the filesystem.
> 
> How did you conclude that is what is happening?
> Were you able to reproduce, because I did not.

No, I didn't reproduce. But checking the source of the reproducer the
message "read: No such file or directory" means fanotify_read() has
returned -ENOENT and within fanotify there's no way how that could happen.
So the only possible explanation is that dentry_open() returns it.

> > > On the other hand we already do silently
> > > fixup similar EOPENSTALE error that can come from NFS so perhaps we should
> > > be fixing ENOENT similarly? What do you thing Amir?
> >
> 
> But we never return this error to the caller for a non-permission event,
> so what am I missing?

Umm. If dentry_open() fails, we return the error from copy_event_to_user()
without copying anything. Then fanotify_read() does:

		ret = copy_event_to_user(group, event, buf, count);
		...
                if (!fanotify_is_perm_event(event->mask)) {
                        fsnotify_destroy_event(group, &event->fse);
			// unused event destroyed
                } else {
		...
		}
                if (ret < 0)
                        break;	// read loop aborted
		...
	}
	...
	if (start != buf && ret != -EFAULT)
                ret = buf - start;
        return ret;

So the error *is* IMO returned to userspace if this was the first event.

> > But what is still unclear to me is how this failure to generate fanotify
> > event relates to git clone failing. Perhaps the dentry references fanotify
> > holds in the notification queue confuse 9p and it returns those ENOENT
> > errors?
> 
> My guess is that ENOENT for openat(2)/newfstatat(2) is from this code
> in fid_out label in:
> v9fs_vfs_getattr() => v9fs_fid_lookup() =>
> v9fs_fid_lookup_with_uid()
> 
>                 if (d_unhashed(dentry)) {
>                         spin_unlock(&dentry->d_lock);
>                         p9_fid_put(fid);
>                         fid = ERR_PTR(-ENOENT);
>                 } else {
>                         __add_fid(dentry, fid);
> 
> So fanotify contributes a deferred reference on the dentry,
> and that can somehow lead to operating on a stale unhashed dentry?
> Not exactly sure how to piece that all together.

For example d_delete() will only unhash the deleted dentry if it does not
hold the last reference to it (which it would not due to fanotify holding
reference). So presumably 9p could return this error if we delivered event
for an already deleted dentry. That would explain the fanotify side of
things. But not really the git clone failure.

> This seems like a problem that requires p9 developers to look at it.
> fanotify mark has an indirect effect on this use case IMO.

I agree, this looks more like a problem with 9p that gets exposed by
fanotify. Guys, Krishna is seeing git-clone failure on 9p filesystem when
fanotify events are generated for the filesystem. We suspect additional
dentry references from generated fanotify events somehow upset something
inside 9p so it returns -ENOENT errors sometimes (see previous email in
this thread for strace output).

Krishna, you've mentioned you are using the kernel from WSL
(https://github.com/microsoft/WSL2-Linux-Kernel/). Is it possible to
reproduce the failure with 9p from a standard Linux kernel?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

