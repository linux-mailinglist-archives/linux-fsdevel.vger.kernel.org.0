Return-Path: <linux-fsdevel+bounces-11121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF4A851566
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 14:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC0F1C21F36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 13:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C19487AE;
	Mon, 12 Feb 2024 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JV5M+8N3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FXCO5PZP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YzrNMfys";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="irtSpajX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB27482EF;
	Mon, 12 Feb 2024 13:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744475; cv=none; b=nboA3cxdib1H05rXZjnDwrjp6BCjFIlfKjEdO7l7HWXwWZyMMy7W5xjogIK417MFH4G8UGKaVEMu4eGpk/yGRM7bL2dPIGgZ3F+RlLdLDMmDGlHox/FVd4L4MZCId9iajT1FUoWJKRcW48P3DI17q6lLtv5cV+mpcrsGLyLBDX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744475; c=relaxed/simple;
	bh=1ImefdOCwrVgz56hT7Y64257mZm8nGbJ3VUF1kUzBaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwSo1JOtkr1JvfYpLCJoqqiEozzSOld6aD/czsBJQ+xxHUeP5MoeAJdBtVne3c1/7ZuJAJ3RG4czAiket/6ehHbMA0wWLVjcX+JQufv5nHMFggBfrQGigSZJt5M8+7lIIUrzIDWHFVIG/j4aRtwduijleV8R0HTYr63Rtyi4sdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JV5M+8N3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FXCO5PZP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YzrNMfys; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=irtSpajX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9C2F021C0B;
	Mon, 12 Feb 2024 13:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707744471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GcGxk04m8hFykgyIB3yQRqSxLOpInpc3Xkjr947sSME=;
	b=JV5M+8N3Nb0MUdVl2J6ySXJ7s3Lbj6x1UDY8njgPYd9DPdygIsHkcmoaU+t+ubUTr+fbET
	HVe9dyvi/lmWLmlNfz/XtoeUl4PKeW+v4khR8xVSeREbtIf9dwNLkhFIGwB5D+3xWZfnpf
	Zwcd5DbUFsLTtPLYZyv/7CVcbQ50P98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707744471;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GcGxk04m8hFykgyIB3yQRqSxLOpInpc3Xkjr947sSME=;
	b=FXCO5PZPzg5RlgXiVjJ6p/9Ft4XjHeMkgJHrAAZAUZAtJq3QGFU2quwNKdekm0oHwJeWP7
	Qz5wFBsV2HK254Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707744470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GcGxk04m8hFykgyIB3yQRqSxLOpInpc3Xkjr947sSME=;
	b=YzrNMfysBd3te+pjqw2qzX0ISn0uhZwHhIXNlEDJ6dWcJdexzeiPVMo8v1EpqVMUxQ+HdA
	IbcHzAmttKWcEnpPUJtvmQJlQRi2KWfA6VQFRxRGv/x1Z6GqQkHudD8c0o0rqS/v7KY8kO
	8y8gnAm2KHlGw3L4LoKFnlT+Y8PnTUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707744470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GcGxk04m8hFykgyIB3yQRqSxLOpInpc3Xkjr947sSME=;
	b=irtSpajXd8WOccZq2icmX7DBNVzIugQSVmocmlSmh3YklzdsNjEVjtGj3Tc9cyyAQ2uRyn
	ODedpq/pWT0fKkCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F0F113212;
	Mon, 12 Feb 2024 13:27:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id NqXqItYcymUqNAAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 12 Feb 2024 13:27:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3B86FA0809; Mon, 12 Feb 2024 14:27:46 +0100 (CET)
Date: Mon, 12 Feb 2024 14:27:46 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+6e5f2db05775244c73b7@syzkaller.appspotmail.com>
Cc: achender@linux.vnet.ibm.com, achender@us.ibm.com,
	adilger.kernel@dilger.ca, alex@clusterfs.com, axboe@kernel.dk,
	brauner@kernel.org, jack@suse.cz, kernel@collabora.com,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, tytso@mit.edu,
	usama.anjum@collabora.com
Subject: Re: [syzbot] [ext4?] KASAN: out-of-bounds Read in
 ext4_ext_remove_space
Message-ID: <20240212132746.syu7dhttk7xsyhzp@quack3>
References: <0000000000001655710600710dd0@google.com>
 <000000000000690cfd06111b7ee6@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000690cfd06111b7ee6@google.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YzrNMfys;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=irtSpajX
X-Spamd-Result: default: False [2.66 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=1e3d5175079af5a4];
	 TAGGED_RCPT(0.00)[6e5f2db05775244c73b7];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-0.03)[56.60%];
	 R_RATELIMIT(0.00)[to_ip_from(RLxsdx31usy44znxyfiimhbrcp)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[16];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,syzkaller.appspot.com:url,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 2.66
X-Rspamd-Queue-Id: 9C2F021C0B
X-Spam-Level: **
X-Spam-Flag: NO
X-Spamd-Bar: ++

On Sun 11-02-24 05:54:02, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1764f648180000
> start commit:   e6fda526d9db Merge tag 'arm64-fixes' of git://git.kernel.o..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1e3d5175079af5a4
> dashboard link: https://syzkaller.appspot.com/bug?extid=6e5f2db05775244c73b7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a56679a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d76b5da80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Yes, the reproducer seems to be corrupting the image:
 
#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

