Return-Path: <linux-fsdevel+bounces-18497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 501CC8B98E0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 12:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD1628539C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 10:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBC35D8E4;
	Thu,  2 May 2024 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XG2/C8is";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1w5dX4mr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XG2/C8is";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1w5dX4mr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198D3481B4;
	Thu,  2 May 2024 10:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714646029; cv=none; b=b/sOZH8yI//Ct9sFjnNFPs8+FS/4ZFNgrHvV3RuD1Up7NBgdjDMwV4PN1+F7P0ldQymDeMnC+ZEhuay7ttD/QlXYACP+E5VyJzrFS1el28Mnme02M27Avq7PVVWxBJde1sTmmk5Jse5ChFTk7pnX1J/UwQwpGjweL24Swmr/vog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714646029; c=relaxed/simple;
	bh=EQQ99YE7OxJ6vOQGM7fUFPYPqfcuzIEmwb1JAZWHaGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAEC2rB/8q0DTW+WlZ8pFVYiOxEuNSZ0ENlnFEhcwXoFp5EwEDpBWspWjm1gVPLYuZn6Rb4V+GbrL8iJ1jq+kTY/cAdNfPyc9Q502t/XIE9Tu9eZyFnPzL1I+Jh1wZyYU5epj/BarQdXLZjz0p2OJiUUvm+qi8K1H1ETTHEfnFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XG2/C8is; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1w5dX4mr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XG2/C8is; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1w5dX4mr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 62C9D351FB;
	Thu,  2 May 2024 10:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714646026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MrT7ys5O03eVstXNY3hNHVI99bxMNGAg8kCVM0pzqZA=;
	b=XG2/C8isIOS9e2s/hKolz7lDDao1uYkFE6YPq3ewQY3z3BpZNOaQ9j2iEGgY4au2ebplNt
	asLC9y4StKnTAJT30z8PpRzLMdOwRoHhgUXlloLR41UmHsgwJC6UShalYYGsnO+qP8u1Gh
	kmdhOWPD5re8oe3c/eFf4EeJruy9DWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714646026;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MrT7ys5O03eVstXNY3hNHVI99bxMNGAg8kCVM0pzqZA=;
	b=1w5dX4mr09CtJmjmIXVzf43YZ9+flNo6dh/R6KkBSyGJyGEpHgQR8mdDT8VTw7TF7FRB2r
	kOK1KV2r80gQy9Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714646026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MrT7ys5O03eVstXNY3hNHVI99bxMNGAg8kCVM0pzqZA=;
	b=XG2/C8isIOS9e2s/hKolz7lDDao1uYkFE6YPq3ewQY3z3BpZNOaQ9j2iEGgY4au2ebplNt
	asLC9y4StKnTAJT30z8PpRzLMdOwRoHhgUXlloLR41UmHsgwJC6UShalYYGsnO+qP8u1Gh
	kmdhOWPD5re8oe3c/eFf4EeJruy9DWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714646026;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MrT7ys5O03eVstXNY3hNHVI99bxMNGAg8kCVM0pzqZA=;
	b=1w5dX4mr09CtJmjmIXVzf43YZ9+flNo6dh/R6KkBSyGJyGEpHgQR8mdDT8VTw7TF7FRB2r
	kOK1KV2r80gQy9Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 466F51386E;
	Thu,  2 May 2024 10:33:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TSHqEApsM2aBEQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 02 May 2024 10:33:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D0288A06D4; Thu,  2 May 2024 12:33:41 +0200 (CEST)
Date: Thu, 2 May 2024 12:33:41 +0200
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+dd43bd0f7474512edc47@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, jack@suse.cz, libaokun1@huawei.com,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	nathan@kernel.org, ndesaulniers@google.com, ritesh.list@gmail.com,
	syzkaller-bugs@googlegroups.com, trix@redhat.com, tytso@mit.edu
Subject: Re: [syzbot] [ext4?] WARNING in mb_cache_destroy
Message-ID: <20240502103341.t53u6ya7ujbzkkxo@quack3>
References: <00000000000072c6ba06174b30b7@google.com>
 <0000000000003bf5be061751ae70@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000003bf5be061751ae70@google.com>
X-Spam-Flag: NO
X-Spam-Score: -2.02
X-Spam-Level: 
X-Spamd-Result: default: False [-2.02 / 50.00];
	BAYES_HAM(-2.72)[98.79%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[dd43bd0f7474512edc47];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[dilger.ca,suse.cz,huawei.com,vger.kernel.org,lists.linux.dev,kernel.org,google.com,gmail.com,googlegroups.com,redhat.com,mit.edu];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SUBJECT_HAS_QUESTION(0.00)[]

On Tue 30-04-24 08:04:03, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 67d7d8ad99beccd9fe92d585b87f1760dc9018e3
> Author: Baokun Li <libaokun1@huawei.com>
> Date:   Thu Jun 16 02:13:56 2022 +0000
> 
>     ext4: fix use-after-free in ext4_xattr_set_entry

So I'm not sure the bisect is correct since the change is looking harmless.
But it is sufficiently related that there indeed may be some relationship.
Anyway, the kernel log has:

[   44.932900][ T1063] EXT4-fs warning (device loop0): ext4_evict_inode:297: xattr delete (err -12)
[   44.943316][ T1063] EXT4-fs (loop0): unmounting filesystem.
[   44.949531][ T1063] ------------[ cut here ]------------
[   44.955050][ T1063] WARNING: CPU: 0 PID: 1063 at fs/mbcache.c:409 mb_cache_destroy+0xda/0x110

So ext4_xattr_delete_inode() called when removing inode has failed with
ENOMEM and later mb_cache_destroy() was eventually complaining about having
mbcache entry with increased refcount. So likely some error cleanup path is
forgetting to drop mbcache entry reference somewhere but at this point I
cannot find where. We'll likely need to play with the reproducer to debug
that. Baokun, any chance for looking into this?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

