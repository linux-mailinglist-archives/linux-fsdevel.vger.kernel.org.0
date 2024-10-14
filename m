Return-Path: <linux-fsdevel+bounces-31881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F81699C8C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 13:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1BF1F20FC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 11:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9CC15E5D4;
	Mon, 14 Oct 2024 11:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ODIwSEM9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="j6lZTgVc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ODIwSEM9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="j6lZTgVc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E0C153BED;
	Mon, 14 Oct 2024 11:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728905053; cv=none; b=QePigl3SL9Q8PwDicH0rRuKaTfAdlLXo/0R4YvBHBqkGEtwNzpJ9J1y/N2N47rehH4JseRo61iFpPrueHAHm6wshSE2cRDwwnr+YTj2Im/1l6qRotn1ctMDVX09fGc2ObmKmoN6VDdxFCLRwMwbPMlphNjnKEsTGfExpfIQz99A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728905053; c=relaxed/simple;
	bh=On7z+z0xlAx1Au7qeHzAiTOIxa/+fU28ylKaXB0m3E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbJ5SEr+YakPd4Q4XCj9U6oj/rc5Dt17EhL4xJzW+PTBLzdk1aRrDHaMpMWa67tr5lbCTUvitF9PFndc8CTmc5os52BE6ruPZLnePJar5NMM6crEH5YLklfkCOkbLYmDqwcwbbv8Zen5RWGS+975fx8O7BXhzIfjV5OS7syTO5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ODIwSEM9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=j6lZTgVc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ODIwSEM9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=j6lZTgVc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6C24A1FB91;
	Mon, 14 Oct 2024 11:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728905049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMnytouJs0/lKHqI+kq1mVU5YSiaKvf/nCGCdLOi3Rk=;
	b=ODIwSEM9Xorq6nFBsNx2Xy+TBdVgu3KLUIN4eLrvnE7j9K62VVLQOhlWGPtRdwai8rYTLb
	BoZ6e/4KgSvUkhu2LLRi0ZIMR/kYJASH822eD3iag6akleXhNTf5644zXo/RyVBKC6V5SD
	x7VkNr/sNT1VcWY0Da0jZroAGldSPEQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728905049;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMnytouJs0/lKHqI+kq1mVU5YSiaKvf/nCGCdLOi3Rk=;
	b=j6lZTgVceb8gtwnHK/S3JIx2clkv9NDCWn07ly7b+UUm44qWAL3KzpbFNgdkOslrietf8x
	qhXXFn4V7oq51IAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ODIwSEM9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=j6lZTgVc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728905049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMnytouJs0/lKHqI+kq1mVU5YSiaKvf/nCGCdLOi3Rk=;
	b=ODIwSEM9Xorq6nFBsNx2Xy+TBdVgu3KLUIN4eLrvnE7j9K62VVLQOhlWGPtRdwai8rYTLb
	BoZ6e/4KgSvUkhu2LLRi0ZIMR/kYJASH822eD3iag6akleXhNTf5644zXo/RyVBKC6V5SD
	x7VkNr/sNT1VcWY0Da0jZroAGldSPEQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728905049;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMnytouJs0/lKHqI+kq1mVU5YSiaKvf/nCGCdLOi3Rk=;
	b=j6lZTgVceb8gtwnHK/S3JIx2clkv9NDCWn07ly7b+UUm44qWAL3KzpbFNgdkOslrietf8x
	qhXXFn4V7oq51IAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 615FB13A51;
	Mon, 14 Oct 2024 11:24:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jQHAF1n/DGcwLQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Oct 2024 11:24:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1E034A0896; Mon, 14 Oct 2024 13:24:09 +0200 (CEST)
Date: Mon, 14 Oct 2024 13:24:09 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, brauner@kernel.org,
	Benjamin Coddington <bcodding@redhat.com>,
	Ye Bin <yebin@huaweicloud.com>, viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	yebin10@huawei.com, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH 2/3] sysctl: add support for drop_caches for individual
 filesystem
Message-ID: <20241014112409.y77ftn3jqc7smxfp@quack3>
References: <20241010112543.1609648-1-yebin@huaweicloud.com>
 <20241010112543.1609648-3-yebin@huaweicloud.com>
 <20241010121607.54ttcmdfmh7ywho7@quack3>
 <5A1217C0-A778-4A9A-B9D8-5F0401DC1013@redhat.com>
 <20241010170405.m5l4wutd4csj3v6d@quack3>
 <CAOQ4uxiR9ssLb8b6WBFhYJpDrSEvMfALx12w3sOzjB8qe_7t_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiR9ssLb8b6WBFhYJpDrSEvMfALx12w3sOzjB8qe_7t_g@mail.gmail.com>
X-Rspamd-Queue-Id: 6C24A1FB91
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 11-10-24 13:44:57, Amir Goldstein wrote:
> On Thu, Oct 10, 2024 at 7:04 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 10-10-24 09:35:46, Benjamin Coddington wrote:
> > > On 10 Oct 2024, at 8:16, Jan Kara wrote:
> > >
> > > > On Thu 10-10-24 19:25:42, Ye Bin wrote:
> > > >> From: Ye Bin <yebin10@huawei.com>
> > > >>
> > > >> In order to better analyze the issue of file system uninstallation caused
> > > >> by kernel module opening files, it is necessary to perform dentry recycling
> > > >
> > > > I don't quite understand the use case you mention here. Can you explain it
> > > > a bit more (that being said I've needed dropping caches for a particular sb
> > > > myself a few times for debugging purposes so I generally agree it is a
> > > > useful feature).
> > > >
> > > >> on a single file system. But now, apart from global dentry recycling, it is
> > > >> not supported to do dentry recycling on a single file system separately.
> > > >> This feature has usage scenarios in problem localization scenarios.At the
> > > >> same time, it also provides users with a slightly fine-grained
> > > >> pagecache/entry recycling mechanism.
> > > >> This patch supports the recycling of pagecache/entry for individual file
> > > >> systems.
> > > >>
> > > >> Signed-off-by: Ye Bin <yebin10@huawei.com>
> > > >> ---
> > > >>  fs/drop_caches.c   | 43 +++++++++++++++++++++++++++++++++++++++++++
> > > >>  include/linux/mm.h |  2 ++
> > > >>  kernel/sysctl.c    |  9 +++++++++
> > > >>  3 files changed, 54 insertions(+)
> > > >>
> > > >> diff --git a/fs/drop_caches.c b/fs/drop_caches.c
> > > >> index d45ef541d848..99d412cf3e52 100644
> > > >> --- a/fs/drop_caches.c
> > > >> +++ b/fs/drop_caches.c
> > > >> @@ -77,3 +77,46 @@ int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
> > > >>    }
> > > >>    return 0;
> > > >>  }
> > > >> +
> > > >> +int drop_fs_caches_sysctl_handler(const struct ctl_table *table, int write,
> > > >> +                            void *buffer, size_t *length, loff_t *ppos)
> > > >> +{
> > > >> +  unsigned int major, minor;
> > > >> +  unsigned int ctl;
> > > >> +  struct super_block *sb;
> > > >> +  static int stfu;
> > > >> +
> > > >> +  if (!write)
> > > >> +          return 0;
> > > >> +
> > > >> +  if (sscanf(buffer, "%u:%u:%u", &major, &minor, &ctl) != 3)
> > > >> +          return -EINVAL;
> > > >
> > > > I think specifying bdev major & minor number is not a great interface these
> > > > days. In particular for filesystems which are not bdev based such as NFS. I
> > > > think specifying path to some file/dir in the filesystem is nicer and you
> > > > can easily resolve that to sb here as well.
> > >
> > > Slight disagreement here since NFS uses set_anon_super() and major:minor
> > > will work fine with it.
> >
> > OK, fair point, anon bdev numbers can be used. But filesystems using
> > get_tree_nodev() would still be problematic.
> >
> > > I'd prefer it actually since it avoids this
> > > interface having to do a pathwalk and make decisions about what's mounted
> > > where and in what namespace.
> >
> > I don't understand the problem here. We'd do user_path_at(AT_FDCWD, ...,
> > &path) and then take path.mnt->mnt_sb. That doesn't look terribly
> > complicated to me. Plus it naturally deals with issues like namespacing
> > etc. although they are not a huge issue here because the functionality
> > should be restricted to CAP_SYS_ADMIN anyway.
> >
> 
> Both looking up bdev and looking up path from write() can make syzbot
> and lockdep very upset:
> https://lore.kernel.org/linux-fsdevel/00000000000098f75506153551a1@google.com/

OK, thanks for the reference.

> I thought Christian had a proposal for dropping cache per-sb API via
> fadvise() or something?
> 
> Why use sysfs API for this and not fd to reference an sb?

I guess because the original drop_caches is in the sysfs. But yes, in
principle we could use fd pointing to the filesystem for this. I'm just not
sure fadvise(2) is really the right syscall for this because it is
currently all about page cache of a file and this call should shrink also
the dcache / icache. But ioctl() (not sure if this debug-mostly
functionality is worth a syscall) implemented in VFS would certainly be
possible and perhaps nicer than sysfs interface.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

