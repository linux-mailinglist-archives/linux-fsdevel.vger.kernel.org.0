Return-Path: <linux-fsdevel+bounces-9820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC658453A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80DD1B294EE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 09:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD24715B976;
	Thu,  1 Feb 2024 09:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r+/j3u7G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jK2sjdPz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r+/j3u7G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jK2sjdPz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A159B15B11D;
	Thu,  1 Feb 2024 09:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706779108; cv=none; b=EGqfVGeQdFPr/7wALmmPeh4qRvPSw5PBg1jKXWsbd/aLyGExln4ycCq1KeBe8aLGpsq9oMB8J7vBSb+NLouUiV4vVGa64I2BLKay/y1mAahZwL/BL9mxOcdApEWFPslAiXtR+foVbhqM5R5FME5gqoxb3QUVBVO3D2OdylTYbnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706779108; c=relaxed/simple;
	bh=sh56VmbZjgCgtQLhnGvOJhwkTWdus+n0lPyfuAk31KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fta46xeOywjPxr3Bo8iTUnlQPRmVkkyi6aCKRNa2GY+b/32HXcb4jGZUWx89JqM7Evqm+uayCgxPf2rFuOhIoCmFkU6yr1Bw/S1mTl+sgimNpbPg5t01lbq3VRe7GZ1Kxtm8YWpVZTtD/8U19Gh6Aoe2YmO2HUrnvbITHfXwFZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r+/j3u7G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jK2sjdPz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r+/j3u7G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jK2sjdPz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9310D1FB94;
	Thu,  1 Feb 2024 09:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706779104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zxXi/fOaMgCDFHXrPY+RQgE8sSdBP+ESghM8RbqJyJI=;
	b=r+/j3u7GdyDVTtLA782A2TcNcvVZsQBBXbNxhS1vGQ5fZm/ENNlGmmaCoZMRFjhQqUeWdj
	ChKJVt9rQmGKpKVJcPd97+JSdkOQWcc7BMfrpPxbtHoIU3lhLiDU9obujxe4ODbWRVdBq0
	SebmrCPQ1eP6a/OzE9YoZ+FhK2SH6Hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706779104;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zxXi/fOaMgCDFHXrPY+RQgE8sSdBP+ESghM8RbqJyJI=;
	b=jK2sjdPzWLqVSArvaC2rvz/uMdFLG33ySQa+U2Rn5qmugHH2b1/CRmBMPArm0dVCxo7uEm
	oOnbBirY2UhM/jDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706779104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zxXi/fOaMgCDFHXrPY+RQgE8sSdBP+ESghM8RbqJyJI=;
	b=r+/j3u7GdyDVTtLA782A2TcNcvVZsQBBXbNxhS1vGQ5fZm/ENNlGmmaCoZMRFjhQqUeWdj
	ChKJVt9rQmGKpKVJcPd97+JSdkOQWcc7BMfrpPxbtHoIU3lhLiDU9obujxe4ODbWRVdBq0
	SebmrCPQ1eP6a/OzE9YoZ+FhK2SH6Hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706779104;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zxXi/fOaMgCDFHXrPY+RQgE8sSdBP+ESghM8RbqJyJI=;
	b=jK2sjdPzWLqVSArvaC2rvz/uMdFLG33ySQa+U2Rn5qmugHH2b1/CRmBMPArm0dVCxo7uEm
	oOnbBirY2UhM/jDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8234A13594;
	Thu,  1 Feb 2024 09:18:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Zsp/H+Bhu2XGTwAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 09:18:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3A3A3A0809; Thu,  1 Feb 2024 10:18:24 +0100 (CET)
Date: Thu, 1 Feb 2024 10:18:24 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+db6caad9ebd2c8022b41@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, axboe@kernel.dk, brauner@kernel.org,
	jack@suse.cz, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	nogikh@google.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in
 ext4_convert_inline_data_nolock
Message-ID: <20240201091824.xat4nseembst5qoj@quack3>
References: <000000000000b62cdb05f7dfab8b@google.com>
 <0000000000009e002e06104da983@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000009e002e06104da983@google.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=9c35b3803e5ad668];
	 TAGGED_RCPT(0.00)[db6caad9ebd2c8022b41];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.10

On Thu 01-02-24 00:20:04, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1606d4ffe80000
> start commit:   3a93e40326c8 Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9c35b3803e5ad668
> dashboard link: https://syzkaller.appspot.com/bug?extid=db6caad9ebd2c8022b41
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a2cd05c80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=158e1f29c80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Yep, the reproducer seems to mess with the loop device itself.
 
#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

