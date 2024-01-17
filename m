Return-Path: <linux-fsdevel+bounces-8186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8336830B81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 17:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40A41C21D5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 16:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6DC224FE;
	Wed, 17 Jan 2024 16:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GxsyIPxx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tMwDJmWk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GxsyIPxx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tMwDJmWk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CF7224E0;
	Wed, 17 Jan 2024 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705510365; cv=none; b=p8ATTfkTaEHzQQ0MBhCxD36be1QcZbfaEBygGtF6P/XpUEczfR4eoJRHQ6X3hnYYig5+Eb69BeDyj2+9F3o775sviUeErXCTC2KpdGAUZN1VYYr+IjFFLlziztxlwJ1GoGtuNTXQkPf5/peinpxuWB6+QqjjVLigZjFasiS6OpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705510365; c=relaxed/simple;
	bh=x22Mnt67RNj9CaKFLIrBnXU44g0M0k6O6l7VCQ0NDZM=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Level:X-Spamd-Bar:
	 X-Rspamd-Server:X-Spamd-Result:X-Spam-Score:X-Rspamd-Queue-Id:
	 X-Spam-Flag; b=fLjDaAz9cY5kkAdCJYl2PFPclzukdCaXt2LTHi4qc/TtdYqfZg0wIY+mo8rRPCkWHJ1QNMWUWVWbkdWwmavkuqJGACBo7r9XMgk2t/Ba6DxvkIFQCGvMG9vqK0m3oYCmJ8dVl1VzfIlmr/HTNgKhEoqiMuQfx974Z7GD9f5T+QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GxsyIPxx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tMwDJmWk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GxsyIPxx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tMwDJmWk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4BEFC220AC;
	Wed, 17 Jan 2024 16:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705510361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=avKGzzfN5L25MCcY0RbJmizwPR6BzqtjMZvktJGxcVw=;
	b=GxsyIPxxYDZEVdX0yYfTLl48htdFF2JQQfoTj0U25GGecYyDwHn0Z54+DTAojTusEmW8dW
	XgMiVoPulKX1elkwGRCXgeTt2LDEDyHiW/70hqG/gmeZCaNeOjV0Lj3A1z8OXlv/1IQvhf
	TeY93LX+KRCR9BkXcSIlrdGr1GStoyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705510361;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=avKGzzfN5L25MCcY0RbJmizwPR6BzqtjMZvktJGxcVw=;
	b=tMwDJmWk41Qy95Y1OYWgvise0p/Eig7LnV5oeW1IoJ7yla2f4EhZVSeGFPhGv+ZvwQyyrV
	pMoaZIDHnkXlkiAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705510361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=avKGzzfN5L25MCcY0RbJmizwPR6BzqtjMZvktJGxcVw=;
	b=GxsyIPxxYDZEVdX0yYfTLl48htdFF2JQQfoTj0U25GGecYyDwHn0Z54+DTAojTusEmW8dW
	XgMiVoPulKX1elkwGRCXgeTt2LDEDyHiW/70hqG/gmeZCaNeOjV0Lj3A1z8OXlv/1IQvhf
	TeY93LX+KRCR9BkXcSIlrdGr1GStoyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705510361;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=avKGzzfN5L25MCcY0RbJmizwPR6BzqtjMZvktJGxcVw=;
	b=tMwDJmWk41Qy95Y1OYWgvise0p/Eig7LnV5oeW1IoJ7yla2f4EhZVSeGFPhGv+ZvwQyyrV
	pMoaZIDHnkXlkiAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CCDD13800;
	Wed, 17 Jan 2024 16:52:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iEQYDtkFqGXTNAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Jan 2024 16:52:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D7476A0803; Wed, 17 Jan 2024 17:52:36 +0100 (CET)
Date: Wed, 17 Jan 2024 17:52:36 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+3abaeed5039cc1c49c7c@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [reiserfs?] possible deadlock in chown_common
Message-ID: <20240117165236.kcmlvjedoae6yd76@quack3>
References: <0000000000006308a805eaa57d87@google.com>
 <000000000000b5b973060f269eb3@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000b5b973060f269eb3@google.com>
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GxsyIPxx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tMwDJmWk
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.45 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 BAYES_HAM(-0.04)[57.65%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=9df203be43a870b5];
	 TAGGED_RCPT(0.00)[3abaeed5039cc1c49c7c];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: 1.45
X-Rspamd-Queue-Id: 4BEFC220AC
X-Spam-Flag: NO

On Wed 17-01-24 08:20:06, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ecbc83e80000
> start commit:   2bca25eaeba6 Merge tag 'spi-v6.1' of git://git.kernel.org/..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9df203be43a870b5
> dashboard link: https://syzkaller.appspot.com/bug?extid=3abaeed5039cc1c49c7c
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1539e7b8880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c6cb32880000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Makes sense:

#syz fix: fs: Block writes to mounted block devices

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

