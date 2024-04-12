Return-Path: <linux-fsdevel+bounces-16809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 449608A31C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 17:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D804E1F24742
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 15:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB0D1474D9;
	Fri, 12 Apr 2024 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="idVPleDK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z2aFTdgp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="idVPleDK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z2aFTdgp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16B87580A
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934278; cv=none; b=jNZ0l2VFUeAhHwN1aoRUwLJvPkJMussBTgUU/hf0WWevkHH/z+R3aPS5S+1RwM9gxXq+z7d6ur2HgapeoBA6VD6ieC7q2Z0yPvsiReskQq8JKiBgoTcngUjDhBoZVkt0HCsk80/Zitb2/zpDYgRbnqAmJ9ZXxoLnWjYRsiaJWPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934278; c=relaxed/simple;
	bh=zYBVqTKfq+1MogARxC05jhbVxWLuS8sOaHIyQAfwjPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqJaE3fA/Rphs3Zvx05WwG1lFoDOyZCEUfkFZI4VwFDp+RJwVViR3DniStkMuV2i3r//pPNBxs5Tb5oA+fScK3Ku1EKNkqdWEXR9FH0r/rjhAGSHLcqtkex6PwSeMPYoIecTyNO+5xxAzGjFzwPBiGd+eEMxYNrOpCYREfczboY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=idVPleDK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z2aFTdgp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=idVPleDK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z2aFTdgp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1057B383D5;
	Fri, 12 Apr 2024 15:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712934273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hVNMsNyA9PVRoUtXJetJJKHKtLZbHkxz6VQTgln4Sg=;
	b=idVPleDK4tHiOH4KWes89evLQb70n1rWE8u60beyYqfj5gg9NCRCYdMMVZkPuCVirTvEyU
	Pxizy+xebD4YuHJ3eOhPdKaSQRwot071S0Ezfn9Q01oVM7gDTAnw5lECStDdbQfySeC/QK
	zOUDf9dQ38FlazP6D6YBojcw+92QSwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712934273;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hVNMsNyA9PVRoUtXJetJJKHKtLZbHkxz6VQTgln4Sg=;
	b=z2aFTdgpGW5elC1TOnk9T0X7YKBQovfCBqd3ygf4z30Sjl+1c2j5hRMCstRmlQS7CzApZ8
	CuHZ2MJDjNX8HZAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712934273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hVNMsNyA9PVRoUtXJetJJKHKtLZbHkxz6VQTgln4Sg=;
	b=idVPleDK4tHiOH4KWes89evLQb70n1rWE8u60beyYqfj5gg9NCRCYdMMVZkPuCVirTvEyU
	Pxizy+xebD4YuHJ3eOhPdKaSQRwot071S0Ezfn9Q01oVM7gDTAnw5lECStDdbQfySeC/QK
	zOUDf9dQ38FlazP6D6YBojcw+92QSwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712934273;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hVNMsNyA9PVRoUtXJetJJKHKtLZbHkxz6VQTgln4Sg=;
	b=z2aFTdgpGW5elC1TOnk9T0X7YKBQovfCBqd3ygf4z30Sjl+1c2j5hRMCstRmlQS7CzApZ8
	CuHZ2MJDjNX8HZAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 020E71368B;
	Fri, 12 Apr 2024 15:04:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BWx7AIFNGWbLfQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 12 Apr 2024 15:04:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6E6EAA071E; Fri, 12 Apr 2024 17:04:32 +0200 (CEST)
Date: Fri, 12 Apr 2024 17:04:32 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, kernel test robot <oliver.sang@intel.com>,
	oe-lkp@lists.linux.dev, lkp@intel.com,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-fsdevel@vger.kernel.org, ying.huang@intel.com,
	feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linux-next:master] [fsnotify] a5e57b4d37:
 stress-ng.full.ops_per_sec -17.3% regression
Message-ID: <20240412150432.4tt3w26fsfifwx5k@quack3>
References: <202404101624.85684be8-oliver.sang@intel.com>
 <CAOQ4uxgFAPMsD03cyez+6rMjRsX=aTo_+d2kuGG9eUwwa6P-zA@mail.gmail.com>
 <20240411115408.266zydqiwalko5k3@quack3>
 <CAOQ4uxj_KnD3uZPTt6HR3sRynsHOxqH4YcyJG5pb-12dWQNDQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj_KnD3uZPTt6HR3sRynsHOxqH4YcyJG5pb-12dWQNDQw@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,intel.com:email]

On Thu 11-04-24 19:22:29, Amir Goldstein wrote:
> On Thu, Apr 11, 2024 at 2:54 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 11-04-24 12:23:34, Amir Goldstein wrote:
> > > On Thu, Apr 11, 2024 at 4:42 AM kernel test robot <oliver.sang@intel.com> wrote:
> > > > for "[amir73il:fsnotify-sbconn] [fsnotify]  629f30e073: unixbench.throughput 5.8% improvement"
> > > > (https://lore.kernel.org/all/202403141505.807a722b-oliver.sang@intel.com/)
> > > > you requested us to test unixbench for this commit on different branches and we
> > > > observed consistent performance improvement.
> > > >
> > > > now we noticed this commit is merged into linux-next/master, we still
> > > > observed similar unixbench improvement, however, we also captured a
> > > > stress-ng regression now. below details FYI.
> > > >
> > > > Hello,
> > > >
> > > > kernel test robot noticed a -17.3% regression of stress-ng.full.ops_per_sec on:
> > > >
> > > >
> > > > commit: a5e57b4d370c6d320e5bfb0c919fe00aee29e039 ("fsnotify: optimize the case of no permission event watchers")
> > >
> > > Odd. This commit does add an extra fsnotify_sb_has_priority_watchers()
> > > inline check for reads and writes, but the inline helper
> > > fsnotify_sb_has_watchers()
> > > already exists in fsnotify_parent() and it already accesses fsnotify_sb_info.
> > >
> > > It seems like stress-ng.full does read/write/mmap operations on /dev/full,
> > > so the fsnotify_sb_info object would be that of devtmpfs.
> > >
> > > I think that the permission events on special files are not very relevant,
> > > but I am not sure.
> > >
> > > Jan, any ideas?
> >
> > So I'm not 100% sure but this load simply seems to run 'stress-ng' with all
> > the syscalls it is able to exercise (one per CPU if I'm right). Hum...
> > looking at perf numbers I've noticed changes like:
> >
> >       0.43 ą  3%      -0.2        0.21 ą  5%  perf-profile.self.cycles-pp.__fsnotify_parent
> >       0.00            +2.8        2.79 ą  5%  perf-profile.self.cycles-pp.fsnotify_open_perm
> >
> > or
> >
> >       1.77 ą 12%      +1.9        3.64 ą  8%  perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_read.__x64_sys_pread64.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       1.71 ą 15%      +1.9        3.64 ą  9%  perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       0.00            +2.8        2.79 ą  5%  perf-profile.calltrace.cycles-pp.fsnotify_open_perm.do_dentry_open.do_open.path_openat.do_filp_open
> >
> > So the savings in __fsnotify_parent() don't really outweight the costs in
> > fsnotify_file()... I can see stress-ng exercises also inotify so maybe
> > there's some contention on the counters which is causing the regression now
> > that we have more of them?
> >
> > BTW, I'm not sure how you've arrived at the conclusing the test is using
> > /dev/full. For all I can tell the e.g. the stress-mmap test is using a file
> > in a subdir of CWD.
> >
> 
> Oh, I just saw the file stress-full.c in stress-ng and wrongly assumed that
> test stress-ng.full refers to this code.
>
> Where do I find the code for this test?

Ah, now that I've investigated the LKP details again, you're indeed right.
repro-script shows how stress-ng is run and when I do that with cloned
stress-ng repository, it is the test using /dev/full.

So with that I'm not sure why patch adds so much cost to fsnotify_file()...


								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

