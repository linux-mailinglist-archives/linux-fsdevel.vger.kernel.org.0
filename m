Return-Path: <linux-fsdevel+bounces-11410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C3D85395B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 19:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6A71C270BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 18:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D56F60866;
	Tue, 13 Feb 2024 18:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HElHxNGr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/uCALGm7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HElHxNGr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/uCALGm7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1535FF03;
	Tue, 13 Feb 2024 18:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707847308; cv=none; b=iuJh4T34k6h2hl9vuU5QMzseHwz6DGqJkPMXRBzRTKrT5bBRsUy5z1jDzn0XK8WegfUaA87nL+lsh0UWq7GWjrYw12DRutk9iUDOiGK2LDMGuzxP9dzvD8poUPjK2MrDBY4mmSCQe8PpIDV0aZrSJA0yuBLGVkRa+LCBqopm6q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707847308; c=relaxed/simple;
	bh=ziUL0vpBFrvYvuGsMd8ENnQh9dC1bxGQCRxrlqGxYjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXnL/XhaKybL7PD+zm7smcUDEAtvtDVtHisoIm1Q0gUnsxkCwBNIUIrOuV905UyAiV2NdJoC9PScWCLemBv9RpHcZLfOO81VNgstRW6l3+3Hngzuo7RtZ4iO8jQalSmp2k6P5ULNxOc+vEgWKfWoxwROAZx3/ZL51wLo3aJXjxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HElHxNGr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/uCALGm7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HElHxNGr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/uCALGm7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0983D22169;
	Tue, 13 Feb 2024 18:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707847305;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UwNvlIUgI+gWzspCh3VgD1U9XMRfUMoaMGUgItxdUCA=;
	b=HElHxNGrG+W8jP40M9xHF9Qqoe92KHxZJi2sNeu91zcxTTlOGTVC0uGmxjU+qogCnNb3Br
	/z6VRAsbkVXr+QrAmCROIvWKeyd3pMEW+3vuHRCg+QiTuvalE25Bop7C7Bxkxce+Z5ZkFC
	DDMsTO5sqv1G1saYfK0nrmsIMVnswaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707847305;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UwNvlIUgI+gWzspCh3VgD1U9XMRfUMoaMGUgItxdUCA=;
	b=/uCALGm7ZBHJWmOaYcSTEKXLUk/P1NOxLSymC60ijWqtm36H+ThlN1arQfIUMBWTyLPyUC
	rBBg2MCzTfGA0wAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707847305;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UwNvlIUgI+gWzspCh3VgD1U9XMRfUMoaMGUgItxdUCA=;
	b=HElHxNGrG+W8jP40M9xHF9Qqoe92KHxZJi2sNeu91zcxTTlOGTVC0uGmxjU+qogCnNb3Br
	/z6VRAsbkVXr+QrAmCROIvWKeyd3pMEW+3vuHRCg+QiTuvalE25Bop7C7Bxkxce+Z5ZkFC
	DDMsTO5sqv1G1saYfK0nrmsIMVnswaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707847305;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UwNvlIUgI+gWzspCh3VgD1U9XMRfUMoaMGUgItxdUCA=;
	b=/uCALGm7ZBHJWmOaYcSTEKXLUk/P1NOxLSymC60ijWqtm36H+ThlN1arQfIUMBWTyLPyUC
	rBBg2MCzTfGA0wAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DDA951329E;
	Tue, 13 Feb 2024 18:01:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id UMXuNYiuy2UXIAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 13 Feb 2024 18:01:44 +0000
Date: Tue, 13 Feb 2024 19:01:11 +0100
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+5fd11a1f057a67a03a1b@syzkaller.appspotmail.com>
Cc: anand.jain@oracle.com, brauner@kernel.org, clm@fb.com, dsterba@suse.com,
	johannes.thumshirn@wdc.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_create_pending_block_groups
Message-ID: <20240213180111.GE355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0000000000000faabc05ee84f596@google.com>
 <000000000000a545940611434746@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a545940611434746@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [2.70 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4];
	 TAGGED_RCPT(0.00)[5fd11a1f057a67a03a1b];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-0.00)[43.12%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Level: **
X-Spam-Score: 2.70
X-Spam-Flag: NO

On Tue, Feb 13, 2024 at 05:22:02AM -0800, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit a1912f712188291f9d7d434fba155461f1ebef66
> Author: Josef Bacik <josef@toxicpanda.com>
> Date:   Wed Nov 22 17:17:55 2023 +0000
> 
>     btrfs: remove code for inode_cache and recovery mount options

This does not look like a fix, it's an unrelated change, the reported
problem probably depends on timing.

> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=113ba042180000
> start commit:   a4d7d7011219 Merge tag 'spi-fix-v6.4-rc5' of git://git.ker..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
> dashboard link: https://syzkaller.appspot.com/bug?extid=5fd11a1f057a67a03a1b

The log says that there's an attempt do
"balance: start -f -susage=6,vrange=0..9223372036854775809"

which looks suspicious but should be otherwise harmless, the range is
only considered. What is possible problem is that it's for the system
block group:

nfo (device loop0): balance: start -f -susage=6,vrange=0..9223372036854775809
------------[ cut here ]------------
BTRFS: Transaction aborted (error -28)
WARNING: CPU: 0 PID: 5028 at fs/btrfs/block-group.c:2686 btrfs_create_pending_block_groups+0x10b7/0x1220 fs/btrfs/block-group.c:2686
Modules linked in:
CPU: 0 PID: 5028 Comm: syz-executor115 Not tainted 6.6.0-syzkaller-00207-g14ab6d425e80 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:btrfs_create_pending_block_groups+0x10b7/0x1220 fs/btrfs/block-group.c:2686

