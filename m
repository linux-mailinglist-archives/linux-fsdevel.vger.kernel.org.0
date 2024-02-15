Return-Path: <linux-fsdevel+bounces-11662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75849855E15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 10:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82191C2235C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 09:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E511759E;
	Thu, 15 Feb 2024 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QYK6fvyf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fmVenrIi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cMxG2Vfz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HYcnQUJL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DAB1754B;
	Thu, 15 Feb 2024 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989367; cv=none; b=WEsW8Az8w3sNnk2laDcbxy09hKqMxIjDNV8M+CBrRT3L/uZhb3EC0SufHTOA+uzTC+kNNTBPbIPCD+sRy9cKlLiOpOmI/3k/cqmL0mMzjK46EzaIdPBb0uC9Glh/ALITq4xrOTZChMLyMyYDwadH59Gi3Z8IWOGpj71qkUUc3nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989367; c=relaxed/simple;
	bh=/exuT892yOK1N1guXc3OsoKr9LK+jTRDu2lWpYFNjhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtyKPDY5mo1ui4Wlk1/6fXqaC2+9M2NuJdiKaXuEwgaYKji200AdxY3Xnmsmj7yABWlQ3XbcZGbYyYApAtf5+gCthpPbC+22aXMR2gvRM5xwIIL0/q6UjlZAoLIcxPeERAAOBHG5vxaaV6iCoy9gow+NTJrsCwTrd2MX1VoCHnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QYK6fvyf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fmVenrIi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cMxG2Vfz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HYcnQUJL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 882B51F86A;
	Thu, 15 Feb 2024 09:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707989362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=72QS9/lrF7iXWA6VYnEuxqTo5hTI7fpOxce+IhmZ+Qo=;
	b=QYK6fvyfQQBFSqlQYuFowhnm8wHztcq4khe7DXm1jR3azQDfws119Gh37qngbJdEX6MtPV
	AueEGREHk5sCdYvNizPujg1KChuiR4EL6L3Nh+zvRkQu0PbI8F+NDX1YJe+guuH82HrjYZ
	ym9F3K1sTmztOvDtYen7GZ2NW53Zuyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707989362;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=72QS9/lrF7iXWA6VYnEuxqTo5hTI7fpOxce+IhmZ+Qo=;
	b=fmVenrIisO6ZAP4y60jmTDRR4iMV/5I6Zk0LwRlct/xEz9OBKw9W8H0aercMOC4XDweANm
	qA1ja2afH7KNG+DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707989361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=72QS9/lrF7iXWA6VYnEuxqTo5hTI7fpOxce+IhmZ+Qo=;
	b=cMxG2VfzlfAXkXxUSgyyh8mRQM4Tp/YORUTFMmJkGvnVafPyMU5zN1Qvr+mU7pH/0P67Nq
	a/NfQ6FOmCGlbPTHF4H0t9T4/MHYGJAzHl7YS6lLvtq/6aD7H098O5Lya44RmdlWesAtVe
	ovE1MlqbF9tbvuWLGInMhicu56nVRAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707989361;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=72QS9/lrF7iXWA6VYnEuxqTo5hTI7fpOxce+IhmZ+Qo=;
	b=HYcnQUJLCG5BtjLEWp7zeh3a1OXZhYKhmzr6gmL2QijOzFgosPnGrHPwlCCLxaq17/hjMY
	JOKycRf41KEzNKAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CD47139EF;
	Thu, 15 Feb 2024 09:29:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ulluHnHZzWVgZwAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 15 Feb 2024 09:29:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2BE0FA0809; Thu, 15 Feb 2024 10:29:13 +0100 (CET)
Date: Thu, 15 Feb 2024 10:29:13 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+927b0cd57b86eedb4193@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	paul@paul-moore.com, reiserfs-devel@vger.kernel.org,
	roberto.sassu@huawei.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [reiserfs?] kernel BUG in entry_points_to_object
Message-ID: <20240215092913.xarcfzieo4k7ksnr@quack3>
References: <0000000000005c72b5060abf946a@google.com>
 <0000000000000b0fcc061162ec09@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000000b0fcc061162ec09@google.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [2.89 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.01)[48.15%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=52c9552def2a0fdd];
	 TAGGED_RCPT(0.00)[927b0cd57b86eedb4193];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,syzkaller.appspot.com:url,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Level: **
X-Spam-Score: 2.89
X-Spam-Flag: NO

On Wed 14-02-24 19:07:04, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12e6241c180000
> start commit:   98b1cc82c4af Linux 6.7-rc2
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=52c9552def2a0fdd
> dashboard link: https://syzkaller.appspot.com/bug?extid=927b0cd57b86eedb4193
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101b9214e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12fb7214e80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

No working repro so let's close:
 
#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

