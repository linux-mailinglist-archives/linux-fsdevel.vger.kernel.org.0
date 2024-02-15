Return-Path: <linux-fsdevel+bounces-11706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E6D856443
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 14:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4171DB2C653
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 13:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6308412FF9C;
	Thu, 15 Feb 2024 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BFnvSgDo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+LD7b1lB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BFnvSgDo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+LD7b1lB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CDE12E1C7;
	Thu, 15 Feb 2024 13:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003285; cv=none; b=Tjq0MNSacRXxu7iXwuu19XJFT0MU/k6ySqj0rQ0JLLi5EYUOJiDPN/1WVbaCoO2ktDHmcAxmXyGorKKODr8hJ05WAanTAB90rLISKtbqqvu4HH5hB5YKBVPBAI+vuyTJ8P7eunam2mQP2Mt7YngiqMizr8n7VTNpI7LQ6Ye78ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003285; c=relaxed/simple;
	bh=BSWnMB/tyIIHifk7sXF2NKDatOLCFfN+5bwJjTs/U+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiP5eTD2QpFSZQ51Nw5fu5NzYzC2USpvUuZhjHso7kdxi3UinjLoue8IYkB1EP9Ij4kX0vGvEiAay4pWq1omO/Ezj4AdABU3AYvlXqjZ1i8mYxsaIptytLCgYZhB6QRmCxb38FGdwt4KFvDxduIKsbz37+Vw3QzCa4BKAxyAcgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BFnvSgDo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+LD7b1lB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BFnvSgDo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+LD7b1lB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4F0381F8A4;
	Thu, 15 Feb 2024 13:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708003280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xm0Tb8e8noxuVf8MCl9TTXqq20dalcFNRaBn9WsQ6rs=;
	b=BFnvSgDo7Q2HACJulBf+Ey8iBoUsKoC4LDtDilbW21o2MQsbuhq1hK9+Wp4NpfwyDDLW0S
	nY3P7Otb0pnNQMJPm9pUFkvY5uMPqVtQCFBBUM51zxaMj1VMy1TrBwQGMH+cZBrLaodyFu
	rA+jnCfR+e+XFt3Fq3oPMoRR+nlA8b0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708003280;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xm0Tb8e8noxuVf8MCl9TTXqq20dalcFNRaBn9WsQ6rs=;
	b=+LD7b1lBuqfbsRedQhmt6VxGkigvNNAaq3lQEOnBrW6eRsgdEF4frThpDPW6Vh29uso6a0
	vf8U4Ux1Oid68ZBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708003280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xm0Tb8e8noxuVf8MCl9TTXqq20dalcFNRaBn9WsQ6rs=;
	b=BFnvSgDo7Q2HACJulBf+Ey8iBoUsKoC4LDtDilbW21o2MQsbuhq1hK9+Wp4NpfwyDDLW0S
	nY3P7Otb0pnNQMJPm9pUFkvY5uMPqVtQCFBBUM51zxaMj1VMy1TrBwQGMH+cZBrLaodyFu
	rA+jnCfR+e+XFt3Fq3oPMoRR+nlA8b0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708003280;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xm0Tb8e8noxuVf8MCl9TTXqq20dalcFNRaBn9WsQ6rs=;
	b=+LD7b1lBuqfbsRedQhmt6VxGkigvNNAaq3lQEOnBrW6eRsgdEF4frThpDPW6Vh29uso6a0
	vf8U4Ux1Oid68ZBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 42E48139D0;
	Thu, 15 Feb 2024 13:21:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id umJRENAPzmXlGAAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 15 Feb 2024 13:21:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EC959A0809; Thu, 15 Feb 2024 14:21:19 +0100 (CET)
Date: Thu, 15 Feb 2024 14:21:19 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+3f6ef04b7cf85153b528@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz,
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [reiserfs?] BUG: unable to handle kernel paging request
 in reiserfs_readdir_inode
Message-ID: <20240215132119.gtxttrj3jsft2hwe@quack3>
References: <000000000000a3818b05f18916e0@google.com>
 <00000000000018f2c806116ae6d3@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000018f2c806116ae6d3@google.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [2.87 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.03)[55.33%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=9688428cfef5e8d5];
	 TAGGED_RCPT(0.00)[3f6ef04b7cf85153b528];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Level: **
X-Spam-Score: 2.87
X-Spam-Flag: NO

On Thu 15-02-24 04:38:04, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ffd320180000
> start commit:   534293368afa Merge tag 'kbuild-fixes-v6.3' of git://git.ke..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9688428cfef5e8d5
> dashboard link: https://syzkaller.appspot.com/bug?extid=3f6ef04b7cf85153b528
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138d82bac80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1123fed2c80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Frankly I don't see the reproducer doing anything suspicious but since we
have no reproducer and this is reiserfs:

#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

