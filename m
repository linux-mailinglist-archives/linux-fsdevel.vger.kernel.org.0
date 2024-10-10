Return-Path: <linux-fsdevel+bounces-31608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD10998DF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 19:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67C1283C31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 17:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5FB19AD8C;
	Thu, 10 Oct 2024 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R13bEh8f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wKjtNr5L";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R13bEh8f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wKjtNr5L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC71194082;
	Thu, 10 Oct 2024 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728579851; cv=none; b=JRzAJlrW3DHxez/hLjmDUsq2qs3UaziuolhariaOLr038VBktFyxIk5xOm0T99fUiOf5f1XMI6Ud9HVZyu1yqW7QIbEh9eXGIMHWN3NT1uU3+y1HyYzXYP3havfxnKCFq9t6UZZYAU0gMqsKod/CmXounKgPjHio14Us0qkKJIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728579851; c=relaxed/simple;
	bh=N5kkopy6+sy/N4pf9F62M56jQ4wMtx57nNY4mDpEIAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9TXQPRRxmMaAwwHqdDorx+tKARs5jlkG+8Q6U3ish7vUTvOwOHZ04IPgLWQ6QydQh02C2/yc5Ui4hK6ZI4yvnR9fr1v4Sidxed4S9nuB7hPa2A/870yDxu8QVdHZF9Yvb+sa1Sjnu90lq1SWow7H1z/Ts7DJj8kms5Fm+1H8Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R13bEh8f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wKjtNr5L; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R13bEh8f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wKjtNr5L; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 702901F7EE;
	Thu, 10 Oct 2024 17:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728579846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ks2nA91ED5J6DgSnjm5yk0DBGzEhu1zjCwZL/gz6+l0=;
	b=R13bEh8fcXjhhQO8mqnsVfhPw/0/ehRfCOnB+aaMO52Us7zBLYjaUAC96+lnKvylIJG7J6
	xxDDSjj2P2LC4dtjsMuDScn4g2m+LMH6E2K+sf4H8tY0YyvwMQBE+Rvxl2QDlMlse5+krt
	LOps5zVH87PDHINklLgXxXyCDp2s43o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728579846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ks2nA91ED5J6DgSnjm5yk0DBGzEhu1zjCwZL/gz6+l0=;
	b=wKjtNr5LsWe9lbPS0XjIQlkg0DWouxbEdJdwwfLEpsqPGvngUtlQ7AOgAJjBKNXxDbCfxf
	4h8mw8bom970/8Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=R13bEh8f;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wKjtNr5L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728579846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ks2nA91ED5J6DgSnjm5yk0DBGzEhu1zjCwZL/gz6+l0=;
	b=R13bEh8fcXjhhQO8mqnsVfhPw/0/ehRfCOnB+aaMO52Us7zBLYjaUAC96+lnKvylIJG7J6
	xxDDSjj2P2LC4dtjsMuDScn4g2m+LMH6E2K+sf4H8tY0YyvwMQBE+Rvxl2QDlMlse5+krt
	LOps5zVH87PDHINklLgXxXyCDp2s43o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728579846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ks2nA91ED5J6DgSnjm5yk0DBGzEhu1zjCwZL/gz6+l0=;
	b=wKjtNr5LsWe9lbPS0XjIQlkg0DWouxbEdJdwwfLEpsqPGvngUtlQ7AOgAJjBKNXxDbCfxf
	4h8mw8bom970/8Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6420E13A6E;
	Thu, 10 Oct 2024 17:04:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tphqGAYJCGd/GQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 10 Oct 2024 17:04:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 08155A08A2; Thu, 10 Oct 2024 19:04:06 +0200 (CEST)
Date: Thu, 10 Oct 2024 19:04:05 +0200
From: Jan Kara <jack@suse.cz>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Ye Bin <yebin@huaweicloud.com>,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	yebin10@huawei.com, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH 2/3] sysctl: add support for drop_caches for individual
 filesystem
Message-ID: <20241010170405.m5l4wutd4csj3v6d@quack3>
References: <20241010112543.1609648-1-yebin@huaweicloud.com>
 <20241010112543.1609648-3-yebin@huaweicloud.com>
 <20241010121607.54ttcmdfmh7ywho7@quack3>
 <5A1217C0-A778-4A9A-B9D8-5F0401DC1013@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A1217C0-A778-4A9A-B9D8-5F0401DC1013@redhat.com>
X-Rspamd-Queue-Id: 702901F7EE
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,huawei.com:email,suse.com:email];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 10-10-24 09:35:46, Benjamin Coddington wrote:
> On 10 Oct 2024, at 8:16, Jan Kara wrote:
> 
> > On Thu 10-10-24 19:25:42, Ye Bin wrote:
> >> From: Ye Bin <yebin10@huawei.com>
> >>
> >> In order to better analyze the issue of file system uninstallation caused
> >> by kernel module opening files, it is necessary to perform dentry recycling
> >
> > I don't quite understand the use case you mention here. Can you explain it
> > a bit more (that being said I've needed dropping caches for a particular sb
> > myself a few times for debugging purposes so I generally agree it is a
> > useful feature).
> >
> >> on a single file system. But now, apart from global dentry recycling, it is
> >> not supported to do dentry recycling on a single file system separately.
> >> This feature has usage scenarios in problem localization scenarios.At the
> >> same time, it also provides users with a slightly fine-grained
> >> pagecache/entry recycling mechanism.
> >> This patch supports the recycling of pagecache/entry for individual file
> >> systems.
> >>
> >> Signed-off-by: Ye Bin <yebin10@huawei.com>
> >> ---
> >>  fs/drop_caches.c   | 43 +++++++++++++++++++++++++++++++++++++++++++
> >>  include/linux/mm.h |  2 ++
> >>  kernel/sysctl.c    |  9 +++++++++
> >>  3 files changed, 54 insertions(+)
> >>
> >> diff --git a/fs/drop_caches.c b/fs/drop_caches.c
> >> index d45ef541d848..99d412cf3e52 100644
> >> --- a/fs/drop_caches.c
> >> +++ b/fs/drop_caches.c
> >> @@ -77,3 +77,46 @@ int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
> >>  	}
> >>  	return 0;
> >>  }
> >> +
> >> +int drop_fs_caches_sysctl_handler(const struct ctl_table *table, int write,
> >> +				  void *buffer, size_t *length, loff_t *ppos)
> >> +{
> >> +	unsigned int major, minor;
> >> +	unsigned int ctl;
> >> +	struct super_block *sb;
> >> +	static int stfu;
> >> +
> >> +	if (!write)
> >> +		return 0;
> >> +
> >> +	if (sscanf(buffer, "%u:%u:%u", &major, &minor, &ctl) != 3)
> >> +		return -EINVAL;
> >
> > I think specifying bdev major & minor number is not a great interface these
> > days. In particular for filesystems which are not bdev based such as NFS. I
> > think specifying path to some file/dir in the filesystem is nicer and you
> > can easily resolve that to sb here as well.
> 
> Slight disagreement here since NFS uses set_anon_super() and major:minor
> will work fine with it.

OK, fair point, anon bdev numbers can be used. But filesystems using
get_tree_nodev() would still be problematic.

> I'd prefer it actually since it avoids this
> interface having to do a pathwalk and make decisions about what's mounted
> where and in what namespace.

I don't understand the problem here. We'd do user_path_at(AT_FDCWD, ...,
&path) and then take path.mnt->mnt_sb. That doesn't look terribly
complicated to me. Plus it naturally deals with issues like namespacing
etc. although they are not a huge issue here because the functionality
should be restricted to CAP_SYS_ADMIN anyway.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

