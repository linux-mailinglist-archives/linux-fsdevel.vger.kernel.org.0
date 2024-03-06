Return-Path: <linux-fsdevel+bounces-13753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF2787362E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 13:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558C51F250B8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 12:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E337780044;
	Wed,  6 Mar 2024 12:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z5+YjsTm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CKWaYYgO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z5+YjsTm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CKWaYYgO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1F280020;
	Wed,  6 Mar 2024 12:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709727719; cv=none; b=Eo7dP3AnWvXnJCmSvL0Wl+4y05wUASexnupKw8RdvyjWFfz/renMNJMO1hBlLEh95+e+rQ55CIartce0QU1jAaOA0DREy0QCHiXTjyR2cKISB5C8R8mb00oRUUgJZfHqO3CeyNCwAhjSx/AwM5GAgLIx9CmO3mpV5aNOhjLvOzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709727719; c=relaxed/simple;
	bh=TJC1FWTDVH1fS+pEMIatbsyV4hbiOT6t4ESjbRmuabk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIaST7sj5k3auitJSbkABBXG26XwoLUdc+Oz9mdFMh5oFoP/AIdnl32KgrvMqp6kcSNLBAB0QZgat8W1duzhyRavYdw2S7bnpGOWjnWJLza1VlOdFTa5vtEoph9XpWprg/AiKcPCgeciVs+shPrwB7ERk47gGC5tUte988z5Pyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z5+YjsTm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CKWaYYgO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z5+YjsTm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CKWaYYgO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B95173F5D7;
	Wed,  6 Mar 2024 12:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709727715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wUdrt2veIdLubgIpffUH6xTNcOrVJbvGxnIjN06WxzU=;
	b=Z5+YjsTmzsb1ka+SE5O92dqDnc+F66QMOHQAuPrGOvMQdehmIabEu/YwkU7p3Rj4xZWNAS
	eqmsUhPanbbBLK4yuG7NFTtVVCLZB03SFlDYCncyU6qvv+qJXsiSGaXCOnDlp9Ko/dTUU2
	Q2dgikpgklNbEzQb/uKntUd0C9abgkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709727715;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wUdrt2veIdLubgIpffUH6xTNcOrVJbvGxnIjN06WxzU=;
	b=CKWaYYgO3W/0+VGFyG+OoCAMvSVEk8lwaVO/zi4eGa6+YA6MZPowMXJs3dVDlcGZAGwfqw
	lt2PS4gDzaQMHqBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709727715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wUdrt2veIdLubgIpffUH6xTNcOrVJbvGxnIjN06WxzU=;
	b=Z5+YjsTmzsb1ka+SE5O92dqDnc+F66QMOHQAuPrGOvMQdehmIabEu/YwkU7p3Rj4xZWNAS
	eqmsUhPanbbBLK4yuG7NFTtVVCLZB03SFlDYCncyU6qvv+qJXsiSGaXCOnDlp9Ko/dTUU2
	Q2dgikpgklNbEzQb/uKntUd0C9abgkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709727715;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wUdrt2veIdLubgIpffUH6xTNcOrVJbvGxnIjN06WxzU=;
	b=CKWaYYgO3W/0+VGFyG+OoCAMvSVEk8lwaVO/zi4eGa6+YA6MZPowMXJs3dVDlcGZAGwfqw
	lt2PS4gDzaQMHqBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id ABD231377D;
	Wed,  6 Mar 2024 12:21:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 243uKeNf6GXWTAAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 06 Mar 2024 12:21:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 574E3A0803; Wed,  6 Mar 2024 13:21:55 +0100 (CET)
Date: Wed, 6 Mar 2024 13:21:55 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com>
Cc: almaz.alexandrovich@paragon-software.com, anton@tuxera.com,
	axboe@kernel.dk, brauner@kernel.org, ghandatmanas@gmail.com,
	gregkh@linuxfoundation.org, jack@suse.cz, linkinjeon@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
	lkp@intel.com, llvm@lists.linux.dev, ntfs3@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, syzkaller-bugs@googlegroups.com,
	syzkaller@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] UBSAN: shift-out-of-bounds in ntfs_iget
Message-ID: <20240306122155.yr6lse3yyaduo2db@quack3>
References: <0000000000000424f205fcf9a132@google.com>
 <000000000000c5b2ae0612ef94a9@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000c5b2ae0612ef94a9@google.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: *
X-Spam-Score: 1.58
X-Spamd-Result: default: False [1.58 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.12)[66.97%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=162cf2103e4a7453];
	 TAGGED_RCPT(0.00)[4768a8f039aa677897d0];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLz5osb6fwsyu4f48yakq7oq33)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[19];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[paragon-software.com,tuxera.com,kernel.dk,kernel.org,gmail.com,linuxfoundation.org,suse.cz,vger.kernel.org,lists.linuxfoundation.org,lists.sourceforge.net,intel.com,lists.linux.dev,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO

On Tue 05-03-24 12:21:02, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12be09f2180000
> start commit:   afead42fdfca Merge tag 'perf-tools-fixes-for-v6.4-2-2023-0..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=162cf2103e4a7453
> dashboard link: https://syzkaller.appspot.com/bug?extid=4768a8f039aa677897d0
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12da9bbd280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174e8115280000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
 
The reproducer is just mounting the fs so I'm not sure what's happening
there. But since there's no working repro and this is ntfs3:

#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

