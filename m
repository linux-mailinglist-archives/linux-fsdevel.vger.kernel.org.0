Return-Path: <linux-fsdevel+bounces-73278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0DFD1450C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 18:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70FB23168559
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 17:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C9C3793B5;
	Mon, 12 Jan 2026 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P64DBTfX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="awRxqMr0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P64DBTfX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="awRxqMr0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9730537A480
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768237502; cv=none; b=ciRfehq74TMRQVTk06z7UHT6E5l5dutB1KXqA9iKIHOcBH/91dgIFommLFRKKhcTWEZVsnuir3MjTpS45fc967FUlLUGV97Gqz6QXczeUm+ySuv+aDEg8z+CkPalVGYh50z3jqh3/DITSUwHEQrH5AAKnlEaN9Qk28aV9y8eieE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768237502; c=relaxed/simple;
	bh=kPgy+GkRbWl8K8v+3CSwgn4Fbt0J8obwjsTPR/Pi/HI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K81E0rYyDwFLVnZNlLV/arSlFKXn6Mtfwr0iFQySCOuptVbtNFcY1Kg3vvSpJiH1p8T6CNhSViAVhgLkC5y3h+CsxGpLWmOB6gSAvInyREqap4kFEgCd4zXxGyN7YywwvpPBkws0J3Imqk7dClqD2cxaFUy0IC7CMYWwKHJbHm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P64DBTfX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=awRxqMr0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P64DBTfX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=awRxqMr0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0531A5BCCA;
	Mon, 12 Jan 2026 17:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768237499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/IXu27wphLmF3IpnHNL6mk/rCkepaFM+R+4ydOLIFsE=;
	b=P64DBTfXH3WS5H8Z2my81xHmfFAfjKOx0+sTDCqvSV7S54xkWXX9v18qC8qKqEZtyOuA4B
	HKBpYXga7qxFAHxWqS0NlIsnDrNkwVBOqqvd6HZHv3QewyuRA3a9cvb55UDXm9Pjauk31d
	arHeNeu+RYxUkNH2jIkIy6m6p1goEaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768237499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/IXu27wphLmF3IpnHNL6mk/rCkepaFM+R+4ydOLIFsE=;
	b=awRxqMr0j2r4NGShEEw35590SdYgIasWSrvfpnDhzvGkqxJ4nL6dJim9qgKuoluqVyigqC
	kaVg7mmpLoi4HEDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768237499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/IXu27wphLmF3IpnHNL6mk/rCkepaFM+R+4ydOLIFsE=;
	b=P64DBTfXH3WS5H8Z2my81xHmfFAfjKOx0+sTDCqvSV7S54xkWXX9v18qC8qKqEZtyOuA4B
	HKBpYXga7qxFAHxWqS0NlIsnDrNkwVBOqqvd6HZHv3QewyuRA3a9cvb55UDXm9Pjauk31d
	arHeNeu+RYxUkNH2jIkIy6m6p1goEaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768237499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/IXu27wphLmF3IpnHNL6mk/rCkepaFM+R+4ydOLIFsE=;
	b=awRxqMr0j2r4NGShEEw35590SdYgIasWSrvfpnDhzvGkqxJ4nL6dJim9qgKuoluqVyigqC
	kaVg7mmpLoi4HEDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF7723EA63;
	Mon, 12 Jan 2026 17:04:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vSByOropZWlmAgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 12 Jan 2026 17:04:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9B747A09FC; Mon, 12 Jan 2026 18:04:50 +0100 (CET)
Date: Mon, 12 Jan 2026 18:04:50 +0100
From: Jan Kara <jack@suse.cz>
To: Matt Fleming <matt@readmodwrite.com>
Cc: Jan Kara <jack@suse.cz>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [REGRESSION] 6.12: Workqueue lockups in inode_switch_wbs_work_fn
 (suspect commit 66c14dccd810)
Message-ID: <isa6ohzad6b6l55kbdqa35r5fsp4wnifpncx3kit6m35266d7z@463ckwplt5w3>
References: <20260112111804.3773280-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260112111804.3773280-1-matt@readmodwrite.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO

Hi Matt!

On Mon 12-01-26 11:18:04, Matt Fleming wrote:
> I’m writing to report a regression we are observing in our production
> environment running kernel 6.12. We are seeing severe workqueue lockups
> that appear to be triggered by high-volume cgroup destruction. We have
> isolated the issue to 66c14dccd810 ("writeback: Avoid softlockup when
> switching many inodes").
> 
> We're seeing stalled tasks in the inode_switch_wbs workqueue. The worker
> appears to be CPU-bound within inode_switch_wbs_work_fn, leading to RCU
> stalls and eventual system lockups.

I agree we are CPU bound in inode_switch_wbs_work_fn() but I don't think we
are really hogging the CPU. The backtrace below indicates the worker just
got rescheduled in cond_resched() to give other tasks a chance to run. Is
the machine dying completely or does it eventually finish the cgroup
teardown?

> Here is a representative trace from a stalled CPU-bound worker pool:
> 
> [1437023.584832][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:
> [1437023.733923][    C0] pool 358:
> [1437023.733924][    C0] task:kworker/89:0    state:R  running task     stack:0     pid:3136989 tgid:3136989 ppid:2      task_flags:0x4208060 flags:0x00004000
> [1437023.733929][    C0] Workqueue: inode_switch_wbs inode_switch_wbs_work_fn
> [1437023.733933][    C0] Call Trace:
> [1437023.733934][    C0]  <TASK>
> [1437023.733937][    C0]  __schedule+0x4fb/0xbf0
> [1437023.733942][    C0]  __cond_resched+0x33/0x60
> [1437023.733944][    C0]  inode_switch_wbs_work_fn+0x481/0x710
> [1437023.733948][    C0]  process_one_work+0x17b/0x330
> [1437023.733950][    C0]  worker_thread+0x2ce/0x3f0
> 
> Our environment makes heavy use of cgroup-based services. When these
> services -- specifically our caching layer -- are shut down, they can
> trigger the offlining of a massive number of inodes (approx. 200k-250k+
> inodes per service).

Well, these changes were introduced because some services are switching
over 1m inodes on their exit and they were softlocking up the machine :).
So there's some commonality, just something in that setup behaves
differently from your setup. Are the inodes clean, dirty, or only with
dirty timestamps? Also since you mention 6.12 kernel but this series was
only merged in 6.18, do you carry full series ending with merge commit
9426414f0d42f?

> We have verified that reverting 66c14dccd810 completely eliminates these
> lockups in our production environment.
> 
> I am currently working on creating a synthetic reproduction case in the
> lab to replicate the inode/cgroup density required to trigger this on
> demand. In the meantime, I wanted to share these findings to see if you
> have any insights.

Yes, having the reproducer would certainly simplify debugging what exactly
is going on that your system is locking up. Because I was able to tear down
a cgroup doing switching of millions of inodes in couple of seconds without
any issue in my testing...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

