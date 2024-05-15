Return-Path: <linux-fsdevel+bounces-19546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB858C6AEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 18:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 378DC1F23D9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 16:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1953BBD8;
	Wed, 15 May 2024 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o92+f7mA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2+TaicOt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o92+f7mA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2+TaicOt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1A6383BF;
	Wed, 15 May 2024 16:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715791773; cv=none; b=JBYt74AjJss0ReGdqtZFTEczrI+vMBrm6N2rqg//LZqreOx7qpIbSYrxv8To1R8me86wBRKxCUtLFMYbaQTjz3aG/XACB8i/8gHK7melMZpmgGQMpRVP+wbq8OQD2ePnMuVBkC8qA0i3xBGRW090rm/j3oyJd4OuripgsntPf+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715791773; c=relaxed/simple;
	bh=fm9VAj8EaEKZcY3tvfl8GYykevYPgjEACx/bMZTiIc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEA9B+NhqFC6EZTgf0DZvzx+NMGvw8ETc6B2HdmqtpaWk+WYvRAojJMR/FaERt45NlcLhAAtbvE0wiw4wmxixSBgMjuJfY0MgQjVpNuVj0SJvVJSkmk8tG6fb3I0S4dLbZy7YJnjDHVCGvFXFZZJd1Z6TovTf1Gu5rJUCGnsmt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o92+f7mA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2+TaicOt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o92+f7mA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2+TaicOt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 464852092F;
	Wed, 15 May 2024 16:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715791769;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eDOvU1PkWgvaPjHx1N6ucmoxhi0xTaWIZBUPI0kbRgE=;
	b=o92+f7mAUu7YGwjGQs4PPSpxg/xNvyJCy5hO16jIUeq5vHtlCzBXvpokdgkMTxRiJm6WEA
	MkpaZkZlMlG8ymYwb8d8fB7GOrR7w8zLeBZTB44fxNM2CHH19Sl+fTRa3kO9ldrjM01WQ1
	Dkam2wqoJ1f60cGF4Erl08rbgQcsaYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715791769;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eDOvU1PkWgvaPjHx1N6ucmoxhi0xTaWIZBUPI0kbRgE=;
	b=2+TaicOtLG/C5QeYfZxQcDMyhTPhiIdRsj7jU3YQNo+DhUzKGdklN5Yz7tj/eBS1th43MM
	03sHIjb7VvK7I1CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=o92+f7mA;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2+TaicOt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715791769;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eDOvU1PkWgvaPjHx1N6ucmoxhi0xTaWIZBUPI0kbRgE=;
	b=o92+f7mAUu7YGwjGQs4PPSpxg/xNvyJCy5hO16jIUeq5vHtlCzBXvpokdgkMTxRiJm6WEA
	MkpaZkZlMlG8ymYwb8d8fB7GOrR7w8zLeBZTB44fxNM2CHH19Sl+fTRa3kO9ldrjM01WQ1
	Dkam2wqoJ1f60cGF4Erl08rbgQcsaYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715791769;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eDOvU1PkWgvaPjHx1N6ucmoxhi0xTaWIZBUPI0kbRgE=;
	b=2+TaicOtLG/C5QeYfZxQcDMyhTPhiIdRsj7jU3YQNo+DhUzKGdklN5Yz7tj/eBS1th43MM
	03sHIjb7VvK7I1CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36CDA136A8;
	Wed, 15 May 2024 16:49:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fNw3DZnnRGZFEgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 15 May 2024 16:49:29 +0000
Date: Wed, 15 May 2024 18:49:27 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+623a623cfed57f422be1@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_get_root_ref
Message-ID: <20240515164927.GT4449@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <000000000000f673a1061202f630@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f673a1061202f630@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: *
X-Spamd-Result: default: False [1.06 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=caa42dd2796e3ac1];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	BAYES_HAM(-0.23)[72.42%];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[623a623cfed57f422be1];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: 1.06
X-Spamd-Bar: +
X-Rspamd-Queue-Id: 464852092F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Thu, Feb 22, 2024 at 06:03:22PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c02197fc9076 Merge tag 'powerpc-6.8-3' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16765b8a180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=caa42dd2796e3ac1
> dashboard link: https://syzkaller.appspot.com/bug?extid=623a623cfed57f422be1
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/7b2a3f729cc3/disk-c02197fc.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b4f10e6eb1ca/vmlinux-c02197fc.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8488781d739e/bzImage-c02197fc.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+623a623cfed57f422be1@syzkaller.appspotmail.com

#syz fix: btrfs: fix double free of anonymous device after snapshot creation failure

