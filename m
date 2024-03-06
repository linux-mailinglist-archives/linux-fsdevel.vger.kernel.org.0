Return-Path: <linux-fsdevel+bounces-13776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B11D2873CDE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 18:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50AF31F24162
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 17:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A0760912;
	Wed,  6 Mar 2024 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XOtjBIP0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vs7Gi6T0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XOtjBIP0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vs7Gi6T0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1383A60250;
	Wed,  6 Mar 2024 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709744697; cv=none; b=mKlBiNSeF76rHCjIqbUAVZJeupVrmjjDdOrzYWO80zXqBGN8iZurJ6SiPQxrCT22AbVBEwenxygmNvdupjo8JuTorql/gig8lOg80iVs8o2SNxgKIV8ZnSrc9k1gcVxYqrWnJaYtMjmLQSmJSW08E76U0D6KEP8BnkKU501DFf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709744697; c=relaxed/simple;
	bh=XLrlDpOXHe7T4pCX8rTTxilVvdwj055vNn3mEfO3djY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBq22JcY/PDDC4R1pk4oiihgoJOdByMoNHlcupiPN5vk4z7E3SQL1FRytMwAQrefrSVeirzeMsmfzKW+IWaxSwJ1fRDVea3QpEd/9/5z25ktzQ7p4b056aVoUMNPQO096pfsOfK8SMG3zBrbch/OrlmBq8I06GCP387Uks7FL74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XOtjBIP0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vs7Gi6T0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XOtjBIP0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vs7Gi6T0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 647254582;
	Wed,  6 Mar 2024 17:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709744687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x4KelZJu8ci6w5fIk5guYKW0tSpTyxQbHEFdWP4uuNE=;
	b=XOtjBIP0LFUAhmFY7hOQyaL2PC4cxJpjdnYaw4suysaIMz/x+ReJF73NPV8FAZqdX3l95E
	eHXBulSx4BxrtXd/MoSPc633//Nfz8OzKPFmVd8wCmJ72G9nZY8OOYDUwnIPyPWXWe5H5O
	BV5ml76ELYVL4LA2SCoEXWU1A76VNA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709744687;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x4KelZJu8ci6w5fIk5guYKW0tSpTyxQbHEFdWP4uuNE=;
	b=Vs7Gi6T0iPGgZGqfF0IGL7EQhkPHlbZmHnEz2SFGsAXygMFxhJ/zFg0SRhpkgDmXPQjUj2
	qN9fPkPwj3uho5BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709744687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x4KelZJu8ci6w5fIk5guYKW0tSpTyxQbHEFdWP4uuNE=;
	b=XOtjBIP0LFUAhmFY7hOQyaL2PC4cxJpjdnYaw4suysaIMz/x+ReJF73NPV8FAZqdX3l95E
	eHXBulSx4BxrtXd/MoSPc633//Nfz8OzKPFmVd8wCmJ72G9nZY8OOYDUwnIPyPWXWe5H5O
	BV5ml76ELYVL4LA2SCoEXWU1A76VNA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709744687;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x4KelZJu8ci6w5fIk5guYKW0tSpTyxQbHEFdWP4uuNE=;
	b=Vs7Gi6T0iPGgZGqfF0IGL7EQhkPHlbZmHnEz2SFGsAXygMFxhJ/zFg0SRhpkgDmXPQjUj2
	qN9fPkPwj3uho5BQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 56ED71377D;
	Wed,  6 Mar 2024 17:04:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id z7HyFC+i6GUDEgAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 06 Mar 2024 17:04:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 01A40A0803; Wed,  6 Mar 2024 18:04:46 +0100 (CET)
Date: Wed, 6 Mar 2024 18:04:46 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+46073c22edd7f242c028@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, jack@suse.com, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [udf?] KASAN: use-after-free Read in udf_finalize_lvid
Message-ID: <20240306170446.ohmpxz3r24t4wry7@quack3>
References: <00000000000084090905fe7d22bb@google.com>
 <000000000000f279ea0612dc62cd@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f279ea0612dc62cd@google.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [2.82 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.08)[63.96%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=e1e118a9228c45d7];
	 TAGGED_RCPT(0.00)[46073c22edd7f242c028];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Level: **
X-Spam-Score: 2.82
X-Spam-Flag: NO

On Mon 04-03-24 13:27:02, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1495d341180000
> start commit:   861deac3b092 Linux 6.7-rc7
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e118a9228c45d7
> dashboard link: https://syzkaller.appspot.com/bug?extid=46073c22edd7f242c028
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a44d79e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130b99e9e80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Looks good.

#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

