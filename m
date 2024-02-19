Return-Path: <linux-fsdevel+bounces-12004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D902085A3F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 13:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E66F8B238DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 12:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D198731A93;
	Mon, 19 Feb 2024 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vz/b3y+W";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UvmK2WYN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dJBbbMw6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rx0TOfk1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710BF2E847;
	Mon, 19 Feb 2024 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708347368; cv=none; b=a6U6PuISXgAVfYZyGVQtPoMNHcMavmO6TDn302BPPPPbPYSR+9yXUqxzkO14U3+lCKQ+HZ3s93P9e/BMWUJjqgaMG7oIJKNGCEQ1/8SLcSExEMYUkjEqhjE2PEtyaB2bvXI89RLVkrJGDqijwEXFyrH8aY22sbZKU1m4fNJ3lb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708347368; c=relaxed/simple;
	bh=1xMUyCp7MByC4pxmGHlkXU0SqaRPNqUQxypzPEEGZTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjK0DNteR+JFxVMG1tUk28og76XG948z+4PqJT64oqm+DD9VOpw77NCg0JcLuphx9jviYkjl0N+zvhgQaF5zQYtiVMhmEqK2gSCWr1yUE5Nl7xvRYo9fV8R9OGSTdolIKI8+izgq/gY74KCu1oLI6vFU50YeVaDZ2DTdxdGctlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vz/b3y+W; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UvmK2WYN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dJBbbMw6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rx0TOfk1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A385B1F7F7;
	Mon, 19 Feb 2024 12:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708347364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TWRdspdcX3pYQWfNbt9wzvKxEQREQ1wZYPUI0lwbR2o=;
	b=Vz/b3y+Wis0IDsEdSmDxJ3aRR3Zin6jo/maOrkKPkZj1Q/1REQuE+san0w//NOGMxzE5et
	MFePVK0vOWNbxzufnHqyU+NqmIWWc6Ve3dsPEcjx5XvBgPdPFedYF0oxABiod0hRN3orvT
	dY07EKNYQCrTyOiuZdM0MKow9/F4c1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708347364;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TWRdspdcX3pYQWfNbt9wzvKxEQREQ1wZYPUI0lwbR2o=;
	b=UvmK2WYNhvzljgDn657vqNCu4O5jODq4IzP5sIIcXiBqncQeVCnDg1EYSlFVIB7qQ0Lwr/
	MjEU3Hkf/Y2G4RCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708347362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TWRdspdcX3pYQWfNbt9wzvKxEQREQ1wZYPUI0lwbR2o=;
	b=dJBbbMw649OgT1w3qsyvKW7FWn2KkHKOvMsaRti5xE6lEg7FhW34huv5CbBQZ8HSrIQdb+
	JvDiIs8nFLO5pvYexmnxyyPsERkgWR7qMnIFozVUflsb7FqLiLAprDpmG8dxED30rjjRQv
	ZOeZtJqMM+AoFPh0lruNvzFJOsVQm8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708347362;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TWRdspdcX3pYQWfNbt9wzvKxEQREQ1wZYPUI0lwbR2o=;
	b=rx0TOfk1P728XPAdp67rvDcPpemYH2UXp/ybsqyEDScOPyWIdbdqUoZZ9waagM7ytA+1uW
	3N5OhMQWyK2i9YCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 93DB2139C6;
	Mon, 19 Feb 2024 12:56:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id zoIRJOJP02VOfQAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 19 Feb 2024 12:56:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3D7F7A0806; Mon, 19 Feb 2024 13:56:02 +0100 (CET)
Date: Mon, 19 Feb 2024 13:56:02 +0100
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+427fed3295e9a7e887f2@syzkaller.appspotmail.com>
Cc: agruenba@redhat.com, axboe@kernel.dk, brauner@kernel.org,
	cluster-devel@redhat.com, elver@google.com, gfs2@lists.linux.dev,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, nogikh@google.com,
	peterz@infradead.org, rpeterso@redhat.com,
	syzkaller-bugs@googlegroups.com, valentin.schneider@arm.com
Subject: Re: [syzbot] [gfs2?] general protection fault in gfs2_dump_glock (2)
Message-ID: <20240219125602.mytnw647csn777bc@quack3>
References: <00000000000050a49105f63ed997@google.com>
 <00000000000077ce280611bace5b@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000077ce280611bace5b@google.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [2.89 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.01)[45.13%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=5eadbf0d3c2ece89];
	 TAGGED_RCPT(0.00)[427fed3295e9a7e887f2];
	 MIME_GOOD(-0.10)[text/plain];
	 R_RATELIMIT(0.00)[to_ip_from(RLf9gkbf6uh3yspgf5h4jyjkwo)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,syzkaller.appspot.com:url,suse.cz:email];
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

On Mon 19-02-24 03:58:05, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
> 
>     fs: Block writes to mounted block devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14238a3c180000
> start commit:   58390c8ce1bd Merge tag 'iommu-updates-v6.4' of git://git.k..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5eadbf0d3c2ece89
> dashboard link: https://syzkaller.appspot.com/bug?extid=427fed3295e9a7e887f2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172bead8280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d01d08280000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: fs: Block writes to mounted block devices

I don't see anything that suspicious in the reproducers but there's no
working reproducer anymore. So I'm leaving this upto gfs2 maintainers to
decide.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

