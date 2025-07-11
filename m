Return-Path: <linux-fsdevel+bounces-54667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7170B020E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 17:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18EE817BB9D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 15:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2642ED873;
	Fri, 11 Jul 2025 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pEueceIG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="38Jty+TG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IQtdmBtB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XbLkk3jN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E726D2ED16F
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752249106; cv=none; b=gdxGIljTnAP/xR57VzePkpqGtqxCoq+MjTjtZ/2pXq/9rifWf+kaVJI2hQ5h0tnCoqtG9A4kF+E5xkZkGyPZ4SCRJtKjYverGoC/y7NfoLh/MViCcqmlHKVvZOC9TzNcRl9vbc2xJEM6Tnv6bwjEAGLNajGggXBCCfC+TnkNBtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752249106; c=relaxed/simple;
	bh=hjdU8xGKmuo1OneDdsWZYVBI2CXht7Qf6/e4iAfdXzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJry048C8eZwuQmO6S12TfBNSZClKGxPWt8LcIJTPaK5T7vL4FjG8DcWjfq0UxqHQxQUxGVnKgPCIKNatd+kfhQvgeYpAIeNJbZOsN3W/1cRyqOPDcvO83MvqnD/JeI/uCn6wmfg/FT0YzIZhfWkNMC67Hx4jBMzu6D40ipPJwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pEueceIG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=38Jty+TG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IQtdmBtB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XbLkk3jN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CABE81F46E;
	Fri, 11 Jul 2025 15:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752249103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=acjDWv/whgFgzS+zf85UQQJgYzekdYngZZ0xHb1TGMQ=;
	b=pEueceIG+LLUmAwSxlIlS6KbZhaS67CQbYCZogV8JanGa+RYKhpT3lzlswxF9SDuC5hKaZ
	NnEOC7aYZYJpPXdH5TSQB4agBEKZAWYPCS+SB9oTV/DlqMCwJtHzuqL93od1q1YHsZT2A7
	bTKUtnHO2mzXVtUcuJ9YGnRgqQKb6+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752249103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=acjDWv/whgFgzS+zf85UQQJgYzekdYngZZ0xHb1TGMQ=;
	b=38Jty+TG1JuYxbB2Vp6UbgTDsALnJTb6OLmrEVdCqFbsE7wUBp3ZTpwN/kf6921MTcctP2
	S71o7BD+p3EJTfBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752249101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=acjDWv/whgFgzS+zf85UQQJgYzekdYngZZ0xHb1TGMQ=;
	b=IQtdmBtBpuTb8gTGIr1PEBZiRqKa68ggXQ1R0JB4iqhvBVSLstP5kBlxmF4oYLajKEOtNE
	dVVoGRZkDDZ1pZDhW9DMuIPih9kjT+y1+hBVa6zFo7Ha2CYRnyk/gLuWKhmlESWFDAWb7u
	JzD0FqxESsGnlTAuj2/ZioFNzETtq9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752249101;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=acjDWv/whgFgzS+zf85UQQJgYzekdYngZZ0xHb1TGMQ=;
	b=XbLkk3jN1smLgn+ygPtdZM1S9M+ZL3n3uA1dbOiM/shXrm4SyXjDS53vAzg0WS9QnRoD5V
	XQOaJ9p7Hi8giiDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 937D41388B;
	Fri, 11 Jul 2025 15:51:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vZb8Iw0zcWj0bQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 11 Jul 2025 15:51:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EA490A099A; Fri, 11 Jul 2025 17:51:40 +0200 (CEST)
Date: Fri, 11 Jul 2025 17:51:40 +0200
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+01ef7a8da81a975e1ccd@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, anna.luese@v-bien.de, brauner@kernel.org, 
	jack@suse.cz, jfs-discussion@lists.sourceforge.net, libaokun1@huawei.com, 
	linkinjeon@kernel.org, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, p.raghav@samsung.com, shaggy@kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [syzbot] [ext4?] WARNING in bdev_getblk
Message-ID: <gbzywhurs75yyg2uckcbi7qp7g4cx6tybridb4spts43jxj6gw@66ab5zymisgc>
References: <686a8143.a00a0220.c7b3.005b.GAE@google.com>
 <68710315.a00a0220.26a83e.004a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68710315.a00a0220.26a83e.004a.GAE@google.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=8396fd456733c122];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	URIBL_BLOCKED(0.00)[appspotmail.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,syzkaller.appspot.com:url,samsung.com:email,goo.gl:url];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,appspotmail.com:email,imap1.dmz-prg2.suse.org:helo,goo.gl:url,samsung.com:email,syzkaller.appspot.com:url];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[01ef7a8da81a975e1ccd];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -1.30

On Fri 11-07-25 05:27:01, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 77eb64439ad52d8afb57bb4dae24a2743c68f50d
> Author: Pankaj Raghav <p.raghav@samsung.com>
> Date:   Thu Jun 26 11:32:23 2025 +0000
> 
>     fs/buffer: remove the min and max limit checks in __getblk_slow()
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127d8d82580000
> start commit:   835244aba90d Add linux-next specific files for 20250709
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=117d8d82580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=167d8d82580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8396fd456733c122
> dashboard link: https://syzkaller.appspot.com/bug?extid=01ef7a8da81a975e1ccd
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115c40f0580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11856a8c580000
> 
> Reported-by: syzbot+01ef7a8da81a975e1ccd@syzkaller.appspotmail.com
> Fixes: 77eb64439ad5 ("fs/buffer: remove the min and max limit checks in __getblk_slow()")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Ah, I see what's going on here. The reproducer mounts ext4 filesystem and
sets block size on loop0 loop device to 32k using LOOP_SET_BLOCK_SIZE. Now
because there are multiple reproducer running using various loop devices it
can happen that we're setting blocksize during mount which obviously
confuses the filesystem (and makes sb mismatch the bdev block size). It is
really not a good idea to allow setting block size (or capacity for that
matter) underneath an exclusive opener. The ioctl should have required
exclusive open from the start but now it's too late to change that so we
need to perform a similar dance with bd_prepare_to_claim() as in
loop_configure() to grab temporary exclusive access... Sigh.

Anyway, the commit 77eb64439ad5 is just a victim that switched KERN_ERR
messages in the log to WARN_ON so syzbot started to notice this breakage.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

