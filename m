Return-Path: <linux-fsdevel+bounces-14319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F130C87B023
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F27289CD6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA7112F396;
	Wed, 13 Mar 2024 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dqu768mf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="832EQJtb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dqu768mf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="832EQJtb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71103481C2;
	Wed, 13 Mar 2024 17:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351533; cv=none; b=VJDAWA1DM09peppBmNdpOPVbrFQAaSWvvB8AnKMhFvWmgsi24ueOns6Z6FU1j8In585Mtlw5WaupCzq5U8gjQ9mNR4LLSeTIdvSVFBrZb58fwJjujZ+ZTNlY+Jq/d/aU/H8XI112LQonai8wWlkp+svc0B8j9QC1gYNvnUGYbSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351533; c=relaxed/simple;
	bh=iT2EbtIiOSs+T3XVOk0ucGQQB0rgJHFWBYQuIY3ikcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6fbck+V67qzALht4ypfs4YS6ixIh+LX07pzJ8hSu8QH4dvgmq7Uwel0wbujQLADGFHKc/mPhhX8oeKJOPSvC567IruyR0zZqtzitemmaJ4M7WuxD4p3DvPrJh1BDuwGNoSHK8THopf/yjrgGnrEUibtS7/alFEn2l/Pq0CRP7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dqu768mf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=832EQJtb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dqu768mf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=832EQJtb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3F8FD1F7DB;
	Wed, 13 Mar 2024 17:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710351524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yMHX7C1BrffE+lUVVYYRj2OqTJWgz3tHlk1+zoyfoP8=;
	b=dqu768mf5iPEPwfo/ukXFQJBMhYb31aq3rO7+/lVl4HVLt/Z5Y5qqKrJBWQGoId0fhTKWA
	6zIQO0qY/sgdLT64Xw6dzzPRUuk6K3koWpuRK5WqJ2Pt2DfVmEd0zAEsZG16nCjwG8I3cQ
	Ytb12fy/D5hwgraP2lBsDUPUraFPats=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710351524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yMHX7C1BrffE+lUVVYYRj2OqTJWgz3tHlk1+zoyfoP8=;
	b=832EQJtbK1RWV+Y9LTKVBumFeZcIhjeT0e45VbJiMaT+A1au8tMIdpvorlMJXYyqj57SzZ
	EVJ/ahR0ziHKmbAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710351524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yMHX7C1BrffE+lUVVYYRj2OqTJWgz3tHlk1+zoyfoP8=;
	b=dqu768mf5iPEPwfo/ukXFQJBMhYb31aq3rO7+/lVl4HVLt/Z5Y5qqKrJBWQGoId0fhTKWA
	6zIQO0qY/sgdLT64Xw6dzzPRUuk6K3koWpuRK5WqJ2Pt2DfVmEd0zAEsZG16nCjwG8I3cQ
	Ytb12fy/D5hwgraP2lBsDUPUraFPats=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710351524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yMHX7C1BrffE+lUVVYYRj2OqTJWgz3tHlk1+zoyfoP8=;
	b=832EQJtbK1RWV+Y9LTKVBumFeZcIhjeT0e45VbJiMaT+A1au8tMIdpvorlMJXYyqj57SzZ
	EVJ/ahR0ziHKmbAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 329761397F;
	Wed, 13 Mar 2024 17:38:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZJ1KDKTk8WXPIgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 13 Mar 2024 17:38:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C8D6FA07D9; Wed, 13 Mar 2024 18:38:43 +0100 (CET)
Date: Wed, 13 Mar 2024 18:38:43 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+4fec87c399346da35903@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, kch@nvidia.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	martin.petersen@oracle.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hfs?] INFO: task hung in hfs_mdb_commit
Message-ID: <20240313173843.bhsvylbozi3kvcit@quack3>
References: <000000000000aa9b7405f261a574@google.com>
 <0000000000007c7392061317a56f@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007c7392061317a56f@google.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dqu768mf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=832EQJtb
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.02 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.01)[46.51%];
	 SUBJECT_HAS_QUESTION(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=d05dd66e2eb2c872];
	 TAGGED_RCPT(0.00)[4fec87c399346da35903];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_HI(-3.50)[suse.cz:dkim];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -2.02
X-Rspamd-Queue-Id: 3F8FD1F7DB
X-Spam-Flag: NO

On Thu 07-03-24 12:09:01, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=126c98ea180000
> start commit:   7475e51b8796 Merge tag 'net-6.7-rc2' of git://git.kernel.o..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d05dd66e2eb2c872
> dashboard link: https://syzkaller.appspot.com/bug?extid=4fec87c399346da35903
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1286c3c0e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=121cc388e80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Makes sense.

#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

