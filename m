Return-Path: <linux-fsdevel+bounces-62113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B23B842F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 12:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C421C836A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 10:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254482C08AC;
	Thu, 18 Sep 2025 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f2C7C41y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ivPVFIeS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J9ZXhpJt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UGXuXfB1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF14D227EA8
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 10:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758192083; cv=none; b=rAAWLMhgcrgGb66LTklYk/teF1X+S67x4H2uExNypodwAxHB3/puYcGgLtgOtigDX/Sdx6KscB6Z0sY5qausdDqfELDbh1K1Z3smPmjNyoxmfA6vh4EZ5yFJv/bKNR4fQfbz1DMp8NEGINmZ6QhWxj1f31Ee/jbgHXG7bZ7HIqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758192083; c=relaxed/simple;
	bh=/ryAaRu1zsK2hhBXqXw6qylc208FGP4UEyznFLamZc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FD9+VZlCON0aO3epEZ/4wFR3W33syl7RXOMeLZxWcOvn8o5+bOYi+nKsoHIVHhjOQ4mNUhDVTwZj/XOnLCMdZ4R2VViEiIDj6UYVgY/ChPYimA2hq16hjJrGBqQKO+Awm5NS35nx+2HXEX4ezDNQ87MmvMUemKCV+a8emSa7MqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f2C7C41y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ivPVFIeS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J9ZXhpJt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UGXuXfB1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B477B336E7;
	Thu, 18 Sep 2025 10:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758192080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MLqw+cTYuI4KQmK1iyTFyxZRmHV3Ig++tUCoQTHRt6I=;
	b=f2C7C41yDGwl0u4IEePcheDl8kBxth97QhE2fCXUrvf6V4+5RfdmKfTHdbydnXiQce5G/9
	MrzrAqpExp18kNJzsnByNS95VEgtgZMJMsrSe96lIr7RKe7rnj5wzlwvu5zCFco8nfcHRR
	j9RvcBNjT2A7/9mvGK+8tUuzbC/qvVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758192080;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MLqw+cTYuI4KQmK1iyTFyxZRmHV3Ig++tUCoQTHRt6I=;
	b=ivPVFIeS2PvlTAsxQSywtKZJM2M5w6H+EfILPJzj25swmaCqQ+UJnJoIEGN8V8DI8ekjq1
	qinAK+GQSo5ISnAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=J9ZXhpJt;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UGXuXfB1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758192079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MLqw+cTYuI4KQmK1iyTFyxZRmHV3Ig++tUCoQTHRt6I=;
	b=J9ZXhpJtLzLFglt6jHPsvjOzfFJsQUG1jDCRUh6bgOt3ZzMlxON5ehiSTlOiZg73NZcGsT
	QGK/fbwAaSMkl6yJVea3poD3B81oU+hCp03Rfg1RfXWB9hm6ItzX7ruqz4KQA/hBsHrA5k
	+f2PbAZTGVK7LSX+yxWejvjRhXH04PI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758192079;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MLqw+cTYuI4KQmK1iyTFyxZRmHV3Ig++tUCoQTHRt6I=;
	b=UGXuXfB1mHDGlwI8bDeqpqea/yjcfrtmgUDHe1RGGLwa/6a4KzE1GhPERdSg4eTwXwUUif
	d+MezK01asNKyYBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DB1013A39;
	Thu, 18 Sep 2025 10:41:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v2lPIs/hy2gxcgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 18 Sep 2025 10:41:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 08891A09B1; Thu, 18 Sep 2025 12:41:19 +0200 (CEST)
Date: Thu, 18 Sep 2025 12:41:18 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jakub Kicinski <kuba@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 00/14] ns: rework reference counting
Message-ID: <mngabd3ala2dsrps5iviihl4ijpjlwea4lnzrqzoihcydinweo@bu6ewudaqksi>
References: <20250918-work-namespace-ns_ref-v1-0-1b0a98ee041e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918-work-namespace-ns_ref-v1-0-1b0a98ee041e@kernel.org>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[22];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,suse.cz,cmpxchg.org,suse.com,linutronix.de];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: B477B336E7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51

On Thu 18-09-25 12:11:45, Christian Brauner wrote:
> Stop open accesses to the reference counts and cargo-culting the same
> code in all namespace. Use a set of dedicated helpers and make the
> actual count private.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Christian Brauner (14):
>       ns: add reference count helpers
>       mnt: port to ns_ref_*() helpers
>       cgroup: port to ns_ref_*() helpers
>       ipc: port to ns_ref_*() helpers
>       pid: port to ns_ref_*() helpers
>       time: port to ns_ref_*() helpers
>       user: port to ns_ref_*() helpers
>       net-sysfs: use check_net()
>       net: use check_net()
>       ipv4: use check_net()
>       uts: port to ns_ref_*() helpers
>       net: port to ns_ref_*() helpers
>       nsfs: port to ns_ref_*() helpers
>       ns: rename to __ns_ref
> 
>  fs/mount.h                       |  2 +-
>  fs/namespace.c                   |  4 ++--
>  fs/nsfs.c                        |  2 +-
>  include/linux/cgroup_namespace.h |  4 ++--
>  include/linux/ipc_namespace.h    |  4 ++--
>  include/linux/ns_common.h        | 47 ++++++++++++++++++++++++++++++----------
>  include/linux/pid_namespace.h    |  2 +-
>  include/linux/time_namespace.h   |  4 ++--
>  include/linux/user_namespace.h   |  4 ++--
>  include/linux/uts_namespace.h    |  4 ++--
>  include/net/net_namespace.h      |  8 +++----
>  init/version-timestamp.c         |  2 +-
>  ipc/msgutil.c                    |  2 +-
>  ipc/namespace.c                  |  2 +-
>  kernel/cgroup/cgroup.c           |  2 +-
>  kernel/nscommon.c                |  2 +-
>  kernel/pid.c                     |  2 +-
>  kernel/pid_namespace.c           |  4 ++--
>  kernel/time/namespace.c          |  2 +-
>  kernel/user.c                    |  2 +-
>  kernel/user_namespace.c          |  2 +-
>  net/core/net-sysfs.c             |  6 ++---
>  net/core/net_namespace.c         |  2 +-
>  net/ipv4/inet_timewait_sock.c    |  4 ++--
>  net/ipv4/tcp_metrics.c           |  2 +-
>  25 files changed, 73 insertions(+), 48 deletions(-)
> ---
> base-commit: 3f9cc273c16f63b5d584ec4e767918765c44316b
> change-id: 20250917-work-namespace-ns_ref-357162ca7aa8
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

