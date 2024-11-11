Return-Path: <linux-fsdevel+bounces-34239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275DA9C405D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 15:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AADC1C2106C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 14:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE41E19E99E;
	Mon, 11 Nov 2024 14:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ln9fse8M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5NxOqGTg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ln9fse8M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5NxOqGTg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6455915A85A;
	Mon, 11 Nov 2024 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334170; cv=none; b=auJ4Jy+bj6etaLKQsdwNGtVdnlZoyGpCEyg2OSjwWDEKxPHkcwkGs8BP+fqcQsyIHrkaPWsrZYAXTFBiU+36A8o9enIVXZAwMMqKc2zH6slRcXvm5szFLyT3zwmq74cgcbaMgCPbJwAiyg0MlHwKqXBFOgrFCaqsmgKybXiW5+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334170; c=relaxed/simple;
	bh=+Kqj0wUzn8ov779XVt7eb/3ht2dGP3T5U3kcawmJ53o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drQlCTTYSoPnLkqvWptuKr9rTdjVn7/xmWDZHmXrNH4lghXPMD4yMDyB5Meli0N976WT/rUdosoaKz2SORz+GYqJD1irHJWki8aN5x6t5+IJR+HqozL8MZ2GezxEE5i8s4XviF1dXdsY20l40wNdoJcx4ygbFJIS426krRpp+a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ln9fse8M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5NxOqGTg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ln9fse8M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5NxOqGTg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7CA572197F;
	Mon, 11 Nov 2024 14:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731334165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V0Pt73YJ20dEht5wZaXQwgMJ6DvPqwUd8ZGZK+GzCfs=;
	b=Ln9fse8MOtn6aKCAzKFL5y9BX2pdajZLwEKjiphBuCvIC3GC8PzFlI89+xLmeAJOLQ+/ev
	JYr6h6TODHWC1cc4U/mhbeD9smnq+1Ajd4vmO1Ndpim8nebAHU87BCsSFjxm4cjzXHorkT
	bTA9FMCODOmU+hfQpDvo2enfd6NStXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731334165;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V0Pt73YJ20dEht5wZaXQwgMJ6DvPqwUd8ZGZK+GzCfs=;
	b=5NxOqGTglxzhTvvAbh0Gw8f9+YPJ9v8AphAFvytsLuCVti0FbYfD+9k2o7jtclQLTTNPf0
	TSwKjRrncg1DJeAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Ln9fse8M;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5NxOqGTg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731334165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V0Pt73YJ20dEht5wZaXQwgMJ6DvPqwUd8ZGZK+GzCfs=;
	b=Ln9fse8MOtn6aKCAzKFL5y9BX2pdajZLwEKjiphBuCvIC3GC8PzFlI89+xLmeAJOLQ+/ev
	JYr6h6TODHWC1cc4U/mhbeD9smnq+1Ajd4vmO1Ndpim8nebAHU87BCsSFjxm4cjzXHorkT
	bTA9FMCODOmU+hfQpDvo2enfd6NStXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731334165;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V0Pt73YJ20dEht5wZaXQwgMJ6DvPqwUd8ZGZK+GzCfs=;
	b=5NxOqGTglxzhTvvAbh0Gw8f9+YPJ9v8AphAFvytsLuCVti0FbYfD+9k2o7jtclQLTTNPf0
	TSwKjRrncg1DJeAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C6E113301;
	Mon, 11 Nov 2024 14:09:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PkqDGhUQMmdWYQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 11 Nov 2024 14:09:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1CFC1A0986; Mon, 11 Nov 2024 15:09:25 +0100 (CET)
Date: Mon, 11 Nov 2024 15:09:25 +0100
From: Jan Kara <jack@suse.cz>
To: Song Liu <songliubraving@meta.com>
Cc: Jan Kara <jack@suse.cz>, Song Liu <song@kernel.org>,
	bpf <bpf@vger.kernel.org>,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Team <kernel-team@meta.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"repnop@google.com" <repnop@google.com>,
	"jlayton@kernel.org" <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [RFC bpf-next fanotify 1/5] fanotify: Introduce fanotify
 fastpath handler
Message-ID: <20241111140925.ykmdp3oywuw2ut5p@quack3>
References: <20241029231244.2834368-1-song@kernel.org>
 <20241029231244.2834368-2-song@kernel.org>
 <20241107104821.xpu45m3volgixour@quack3>
 <AE6EEE9B-B84F-4097-859B-B4509F2B6AF8@fb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AE6EEE9B-B84F-4097-859B-B4509F2B6AF8@fb.com>
X-Rspamd-Queue-Id: 7CA572197F
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,vger.kernel.org,meta.com,gmail.com,iogearbox.net,linux.dev,zeniv.linux.org.uk,google.com,toxicpanda.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Thu 07-11-24 19:13:23, Song Liu wrote:
> > On Nov 7, 2024, at 2:48 AM, Jan Kara <jack@suse.cz> wrote:
> > On Tue 29-10-24 16:12:40, Song Liu wrote:
> >> fanotify fastpath handler enables handling fanotify events within the
> >> kernel, and thus saves a trip to the user space. fanotify fastpath handler
> >> can be useful in many use cases. For example, if a user is only interested
> >> in events for some files in side a directory, a fastpath handler can be
> >> used to filter out irrelevant events.
> >> 
> >> fanotify fastpath handler is attached to fsnotify_group. At most one
> >> fastpath handler can be attached to a fsnotify_group. The attach/detach
> >> of fastpath handlers are controlled by two new ioctls on the fanotify fds:
> >> FAN_IOC_ADD_FP and FAN_IOC_DEL_FP.
> >> 
> >> fanotify fastpath handler is packaged in a kernel module. In the future,
> >> it is also possible to package fastpath handler in a BPF program. Since
> >> loading modules requires CAP_SYS_ADMIN, _loading_ fanotify fastpath
> >> handler in kernel modules is limited to CAP_SYS_ADMIN. However,
> >> non-SYS_CAP_ADMIN users can _attach_ fastpath handler loaded by sys admin
> >> to their fanotify fds. To make fanotify fastpath handler more useful
> >> for non-CAP_SYS_ADMIN users, a fastpath handler can take arguments at
> >> attach time.
> > 
> > Hum, I'm not sure I'd be fine as an sysadmin to allow arbitary users to
> > attach arbitrary filters to their groups. I might want some filters for
> > priviledged programs which know what they are doing (e.g. because the
> > filters are expensive) and other filters may be fine for anybody. But
> > overall I'd think we'll soon hit requirements for permission control over
> > who can attach what... Somebody must have created a solution for this
> > already?
> 
> I have "flags" in fanotify_fastpath_ops. In an earlier version of my 
> local code, I actually have "SYS_ADMIN_ONLY" flag that specifies some
> filters are only available to users with CAP_SYS_ADMIN. I removed this 
> flag later before sending the first RFC for simplicity. 
> 
> The model here (fast path loaded in kernel modules) is similar to 
> different TCP congestion control algorithms. Regular user can choose 
> which algorithm to use for each TCP connection. This model is 
> straightforward because the kernel modules are global. With BPF, we 
> have the option not to add the fast path to a global list, so that 
> whoever loads the fast path can attach it to specific group (I didn't
> include this model in the RFC).
> 
> For the first version, I think a SYS_ADMIN_ONLY flag would be good
> enough?

Yes, initially that should be enough.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

