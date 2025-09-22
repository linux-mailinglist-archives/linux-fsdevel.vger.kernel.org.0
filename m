Return-Path: <linux-fsdevel+bounces-62404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E96FB916E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 15:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FE1C2A30B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 13:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C2B30E832;
	Mon, 22 Sep 2025 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lonrv9Gi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VGwEqm3G";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="02pT3B3Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qZhL7xuj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE85F30DD1D
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548234; cv=none; b=HQ7WyX0i20CeZKETAk7qYsRYP57HlHACammEfpXZwc0yWhxwv0BGIV25a7TdwYsq3VCqgnJ0SQ7Hbcjcrv3A3K0MZDhNG8tDI+C8davWC/y7z/Sms2yEg2ZAfJZLfva4tsJrTgvWeFa772wmVRmIT7n1TNWgBuTRHY27hZb3bdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548234; c=relaxed/simple;
	bh=PRnL3UI5prYxcevnQGbJxE2F+LhRx0YrzCwUWz2ChlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfxzSx7RFFc4o2ZeLJWagOkCyFpm42dujjlPtArmdXUfZFy/Dy71YA9g5FaqVq7JSNofv07oddt5z9RocAeau/xgGk1d6jMHgWuxLRIRX4XKm402jaoSlcbZpMX+zKRaQmN/t66Fr56djg2PveHULPk86k/YAlBdg9jg2MoVNk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lonrv9Gi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VGwEqm3G; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=02pT3B3Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qZhL7xuj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EC60A216E2;
	Mon, 22 Sep 2025 13:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758548231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFydlF0huAfGEfcgCyTMMZ7Fjv7KiBk5yCHa4SxOuiA=;
	b=lonrv9Gi3OUBpb0r1k6R2TAEZqM9fQSNvfm/EUwmPDvBvk7DV3G/XQ1x+xpWL0KXD1pQUH
	CIX71daSYYZqKVr4qIPJ3UMDo7IIjh68LzLYEb13/u64ehnsPWHyckdp3/KoWo17K9btzj
	l77Q288gw6bQD8xvmVFQLH93CsR7E2I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758548231;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFydlF0huAfGEfcgCyTMMZ7Fjv7KiBk5yCHa4SxOuiA=;
	b=VGwEqm3GEUZCyU5Io1qwDk0D+Fd/E9EP/KFXROwYOtrg79pNfvh3KJUMfnIeLtFemo+28E
	Wno58FJNMxOxevCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=02pT3B3Q;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qZhL7xuj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758548230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFydlF0huAfGEfcgCyTMMZ7Fjv7KiBk5yCHa4SxOuiA=;
	b=02pT3B3QWzLtzDjRB94o867ud19kAibBTbHXzBxC/vzeYQgChikuzycvbCB4IlvmulRiy5
	VnPmSg9xOLa9p3Z1GxwkKmEOZ2nkh5ZYU9f/bYJ0d6S5ql0bq1nkL26re+UrMaDa9siyvZ
	2vr9dEWB4YeOAGlU0182TtdZ03yow6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758548230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFydlF0huAfGEfcgCyTMMZ7Fjv7KiBk5yCHa4SxOuiA=;
	b=qZhL7xuj2KSWF/VK1/bs/0FenfievnqKcJn79LqXhEqohw2SzUN6/LmV0V6P8JKu/brVni
	bA1rEs4/KF/kD9Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE8D413A63;
	Mon, 22 Sep 2025 13:37:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cxpNNgZR0WjefAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Sep 2025 13:37:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A3F46A07C4; Mon, 22 Sep 2025 15:37:06 +0200 (CEST)
Date: Mon, 22 Sep 2025 15:37:06 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Aleksa Sarai <cyphar@cyphar.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Jakub Kicinski <kuba@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/3] cgroup: add missing ns_common include
Message-ID: <lpdznqhnqy3kzeezhr5l6x42a7okr2e6ou6kh5rmlszokzoc6l@h63hnj5h3hew>
References: <20250922-work-namespace-ns_common-fixes-v1-0-3c26aeb30831@kernel.org>
 <20250922-work-namespace-ns_common-fixes-v1-1-3c26aeb30831@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922-work-namespace-ns_common-fixes-v1-1-3c26aeb30831@kernel.org>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: EC60A216E2
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,suse.cz,cmpxchg.org,suse.com,linutronix.de];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim,suse.cz:email]
X-Spam-Score: -4.01

On Mon 22-09-25 14:42:35, Christian Brauner wrote:
> Add the missing include of the ns_common header.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/cgroup_namespace.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/cgroup_namespace.h b/include/linux/cgroup_namespace.h
> index b7dbf4d623d2..81ccbdee425b 100644
> --- a/include/linux/cgroup_namespace.h
> +++ b/include/linux/cgroup_namespace.h
> @@ -2,6 +2,8 @@
>  #ifndef _LINUX_CGROUP_NAMESPACE_H
>  #define _LINUX_CGROUP_NAMESPACE_H
>  
> +#include <linux/ns_common.h>
> +
>  struct cgroup_namespace {
>  	struct ns_common	ns;
>  	struct user_namespace	*user_ns;
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

