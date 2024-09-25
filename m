Return-Path: <linux-fsdevel+bounces-30040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C30DD985539
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 10:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62391C23841
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 08:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B646615575D;
	Wed, 25 Sep 2024 08:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HYlEP6mq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mZTZ3XMr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HYlEP6mq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mZTZ3XMr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A7C15820E
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 08:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727251919; cv=none; b=BOjc7MZgG005j5oCtpx9Ei/dTj4jL69UFJzZTkAPU9ObDAiOQJxZ1j+rh7079K+8e6Og6RDNrBT7Fa5nrkmwkDrXJDZGobllOBNiBg0oa5bJ+iyDg5cV0VfaOSAfQVherGOuCnmrP2OgaZVormFwe/JNgzT1FBdOE5uTBPUqvN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727251919; c=relaxed/simple;
	bh=6+tW7SqCS+D9A4AoRyV+LCGt3EJ30bfKCI77zGGqZEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuTLMXxb0Qmj+XC2xM2sCf6IDrLGeEyI7PctjmDXBoVf9KhMsf0OfDg5IsFRlTHRHpUjEYQiHeErVnA8o4/xKLfyhCocOl/ZyflngD8xhFhV5FbJ9Fp4un8rVI5tiZVWyDHC3js/bVAnKXaQhnvdkhnhyH5KSxR6M7lfNiFRRnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HYlEP6mq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mZTZ3XMr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HYlEP6mq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mZTZ3XMr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1A5E92126D;
	Wed, 25 Sep 2024 08:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727251915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6mr1QL1DpR0RFn7zrdDiDbFEMzBB5tASVf0eD8yN70g=;
	b=HYlEP6mq3uwqdX/+tG5C89rUuE74NdPvcOVN+aaKdFrPEo8W9J8FpBGGzdTUwIYM4EYefY
	Qw2msforLRGWSozEJWK5gR3V+r/eIQ/p/2dhh//OGnOANTkm9vcZ21nTarPWGOmXeav98P
	ncJVcxm71X99Bmis/Fiyv0VEL5baiVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727251915;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6mr1QL1DpR0RFn7zrdDiDbFEMzBB5tASVf0eD8yN70g=;
	b=mZTZ3XMrA4jQNRgjvDolH2AbKJSAKHsLZxsZ0hY4t+TsIR4LGzeyWveYhScLC15qHFRNck
	Y6z6axTdbofYR2Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727251915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6mr1QL1DpR0RFn7zrdDiDbFEMzBB5tASVf0eD8yN70g=;
	b=HYlEP6mq3uwqdX/+tG5C89rUuE74NdPvcOVN+aaKdFrPEo8W9J8FpBGGzdTUwIYM4EYefY
	Qw2msforLRGWSozEJWK5gR3V+r/eIQ/p/2dhh//OGnOANTkm9vcZ21nTarPWGOmXeav98P
	ncJVcxm71X99Bmis/Fiyv0VEL5baiVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727251915;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6mr1QL1DpR0RFn7zrdDiDbFEMzBB5tASVf0eD8yN70g=;
	b=mZTZ3XMrA4jQNRgjvDolH2AbKJSAKHsLZxsZ0hY4t+TsIR4LGzeyWveYhScLC15qHFRNck
	Y6z6axTdbofYR2Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F0F813A6A;
	Wed, 25 Sep 2024 08:11:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZqunA8vF82ZTewAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 25 Sep 2024 08:11:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B972DA08A7; Wed, 25 Sep 2024 10:11:46 +0200 (CEST)
Date: Wed, 25 Sep 2024 10:11:46 +0200
From: Jan Kara <jack@suse.cz>
To: Krishna Vivek Vitta <kvitta@microsoft.com>
Cc: Amir Goldstein <amir73il@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"jack@suse.cz" <jack@suse.cz>
Subject: Re: [EXTERNAL] Re: Git clone fails in p9 file system marked with
 FANOTIFY
Message-ID: <20240925081146.5gpfxo5mfmlcg4dr@quack3>
References: <SI2P153MB07182F3424619EDDD1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxiuPn4g1EBAq70XU-_5tYOXh4HqO5WF6O2YsfF9kM=qPw@mail.gmail.com>
 <SI2P153MB07187CEE4DFF8CDD925D6812D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjd2pf-KHiXdHWDZ10um=_Joy9y5_1VC34gm6Yqb-JYog@mail.gmail.com>
 <SI2P153MB0718D1D7D2F39F48E6D870C1D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <SI2P153MB07187B0BE417F6662A991584D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SI2P153MB07187B0BE417F6662A991584D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,suse.cz];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 24-09-24 12:07:51, Krishna Vivek Vitta wrote:
> Please ignore the last line.
> Git clone operation is failing with fanotify example code as well.
> 
> root@MININT-S244RA7:/mnt/c/Users/kvitta/Desktop/MDE binaries/GitCloneIssue# ./fanotify_ex /mnt/c
> Press enter key to terminate.
> root@MININT-S244RA7:/mnt/c/Users/kvitta/Desktop/MDE binaries/GitCloneIssue# ./fanotify_ex /mnt/c
> Press enter key to terminate.
> Listening for events.
> FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/info/exclude
> FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/info/exclude
> FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-applypatch.sample
> FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-applypatch.sample
> FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/applypatch-msg.sample
> FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/applypatch-msg.sample
> FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/commit-msg.sample
> FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/commit-msg.sample
> FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-push.sample
> FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-push.sample
> FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-merge-commit.sample
> FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-merge-commit.sample
> FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-commit.sample
> FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-commit.sample
> FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/post-update.sample
> FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/post-update.sample
> FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/push-to-checkout.sample
> FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/push-to-checkout.sample
> FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/fsmonitor-watchman.sample
> FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/fsmonitor-watchman.sample
> FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/update.sample
> FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/update.sample
> FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-rebase.sample
> FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-rebase.sample
> FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-receive.sample
> FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/pre-receive.sample
> FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/hooks/prepare-commit-msg.sample
> FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/hooks/prepare-commit-msg.sample
> FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/description
> FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/description
> FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/HEAD.lock
> FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/HEAD.lock
> FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config.lock
> FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/config.lock
> FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config.lock
> FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config
> FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config
> FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/config
> FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config.lock
> FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config
> FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config
> FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/config
> FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config.lock
> FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config
> FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/config
> FAN_CLOSE_WRITE: File /mnt/c/Users/kvitta/gtest/.git/config
> FAN_OPEN_PERM: File /mnt/c/Users/kvitta/gtest/.git/tNbqjiA
> read: No such file or directory
> root@MININT-S244RA7:/mnt/c/Users/kvitta/Desktop/MDE binaries/GitCloneIssue#

OK, so it appears that dentry_open() is failing with ENOENT when we try to
open the file descriptor to return with the event. This is indeed
unexpected from the filesystem. On the other hand we already do silently
fixup similar EOPENSTALE error that can come from NFS so perhaps we should
be fixing ENOENT similarly? What do you thing Amir?

								Honza

> -----Original Message-----
> From: Krishna Vivek Vitta
> Sent: Tuesday, September 24, 2024 5:30 PM
> To: Amir Goldstein <amir73il@gmail.com>
> Cc: linux-fsdevel@vger.kernel.org; jack@suse.cz
> Subject: RE: [EXTERNAL] Re: Git clone fails in p9 file system marked with FANOTIFY
> 
> Yes, we are testing in WSL environment. On removing the mount mark, git clone succeeds.
> We are using the releases from: https://github.com/microsoft/WSL2-Linux-Kernel/releases
> 
> Did u get to try git clone operation on 9p mount on your setup ? May I know the kernel version ?
> 
> Can you share the commands of how you created a 9p mount on your test box ?
> 
> Please find the code for rename(attached), execute and share the result in 9p mount of ur setup.
> 
> I have tested the fanotify example. It is working in WSL environment. Infact even, in the example code, I have marked only with FAN_CLOSE_WRITE mask. This event handler is recognizing the event and printing it.
> 
> 
> Thank you,
> Krishna Vivek
> 
> -----Original Message-----
> From: Amir Goldstein <amir73il@gmail.com>
> Sent: Tuesday, September 24, 2024 2:27 PM
> To: Krishna Vivek Vitta <kvitta@microsoft.com>
> Cc: linux-fsdevel@vger.kernel.org; jack@suse.cz
> Subject: Re: [EXTERNAL] Re: Git clone fails in p9 file system marked with FANOTIFY
> 
> On Tue, Sep 24, 2024 at 7:25 AM Krishna Vivek Vitta <kvitta@microsoft.com> wrote:
> >
> > Hi Amir
> >
> > Thanks for the reply.
> >
> > We have another image with kernel version: 6.6.36.3. git clone operation fails there as well. Do we need to still try with 5.15.154 kernel version ?
> 
> No need.
> 
> >
> > Currently, we are marking the mount points with mask(FAN_CLOSE_WRITE) to handle only close_write events. Do we need to add any other flag in mask and check ?
> 
> No need.
> 
> >
> > Following is the mount entry in /proc/mounts file:
> > C:\134 /mnt/c 9p
> > rw,noatime,aname=drvfs;path=C:\;uid=0;gid=0;symlinkroot=/mnt/,cache=5,
> > access=client,msize=65536,trans=fd,rfd=4,wfd=4 0 0
> 
> I don't know this symlinkroot feature.
> It looks like a WSL2 feature (?) and my guess is that the failure might be related.
> Not sure how fanotify mount mark affects this, maybe because the close_write events open the file for reporting the event, but maybe you should try to ask your question also the WSL2 kernel maintainers.
> 
> I have tried to reproduce your test case on the 9p mount on my test box:
> v_tmp on /vtmp type 9p (rw,relatime,access=client,msize=262144,trans=virtio)
> 
> with fanotify examples program:
> https://manpages.debian.org/unstable/manpages/fanotify.7.en.html#Example_program:_fanotify_example.c
> 
> and could not reproduce the issue with plain:
> echo 123 > x && mv x y && cat y
> 
> >
> > Attached is the strace for failed git clone operation(line: 419, 420).
> 
> All the failures are ENOENT, which is why I suspect maybe related to the symlinkroot thing.
> 
> > Even I wrote a small program to invoke rename, followed with open.
> > The open fails immediately and succeeds after 3-4 iterations.
> > This exercise was performed on p9 file system marked with fanotify.
> 
> Please share your reproducer program.
> The difference could be in the details.
> Can you test in a 9p mount without those WSL options?
> Can you test on upstream or LTS kernel?
> Can you test with the fanotify example?
> 
> >
> > Am not reporting this as regression. We havent checked this behavior before.
> >
> 
> Ok. patience, we will try to get to the bottom of this.
> 
> Thanks,
> Amir.
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

