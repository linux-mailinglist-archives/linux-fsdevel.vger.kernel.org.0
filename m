Return-Path: <linux-fsdevel+bounces-75263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKhmBsxZc2nruwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 12:21:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 687EC74F17
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 12:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C98C9304CD3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 11:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C5830E0F8;
	Fri, 23 Jan 2026 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lpJGmwJt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1wo3OAh5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r7AsIaTc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G9s2arQK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF6E7261D
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 11:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769167162; cv=none; b=sIUyoViBXD2UTabjUl0uW5dbXh99rVCVTwTfSI80qPKMQ4mzWBUi3bif3L11JTA1mY1AGLfMCXhetpZ+Qdm+TfG0oHOSbVGEY5xfWpx/8Rqdk2duY1UhWFBAkg4hrIFCqqRbhgBfbueSjZGiDYFEe7wxp3KCZs5ZOYDvylSTyWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769167162; c=relaxed/simple;
	bh=YfmV3+rIucKatwcZZUD+4JpMZ1/gGngwPECb52EvEH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0fyeSscKJFffiHPQefvLjFcrwqu0seFh5qMxrYMmNZxzm+3Fj3qs18q8ZZMTfhBNrTmTriWnU3lXQaOMyF+scAL2wopcFdPyaAxaMgek5ckmQS6S0dgrmCX8GIibltIU4cgKsamWLZsRr7yIjR6Hhd3d33mHayW3+j5fP2F9qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lpJGmwJt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1wo3OAh5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r7AsIaTc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G9s2arQK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E9DEF5BCCC;
	Fri, 23 Jan 2026 11:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769167159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Nl1ZVcWCVu0NvtZx3KvDr9lFBs+T2O4Sl94nkq2vrc=;
	b=lpJGmwJtpC5l1xtfzxRYFqBaGfWZUPmiDW6eXI1prtYOEljIu+MNuRMG1CELx40m+BbK2J
	K7G0bU8sUjHvporNrFbEPIWw+C1BNe+RPKrh+cYc5lr6CVhptVtSG4DMtSXaiumEon205Z
	U2R7o/Uuxh35ompZYdJXqqlqIGrFx8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769167159;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Nl1ZVcWCVu0NvtZx3KvDr9lFBs+T2O4Sl94nkq2vrc=;
	b=1wo3OAh5MNDxpxVdwgKPfITBM9HfoPHHvsaZzOvp6GVhlanXR80dDUH0Ze/JqOV9Nzw4Y7
	v56tUkFnZgLSB5Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769167158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Nl1ZVcWCVu0NvtZx3KvDr9lFBs+T2O4Sl94nkq2vrc=;
	b=r7AsIaTcyXBesy1Zcz0riUsTI2oNiGpKw1R8zItASuE/yftPElLBOLbSxOpNPoVXApk4jO
	Z7TWRPUitQN+NI/SA7eIz8ug0SIDnBQDg6i//8N9k1RwBapqGyOetCKli/KtFQpoq5E8mo
	UtM863RrE/fo7h9gnjvxkcnWeh3m4Zs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769167158;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Nl1ZVcWCVu0NvtZx3KvDr9lFBs+T2O4Sl94nkq2vrc=;
	b=G9s2arQKUwOae16Y7gOHxCHF3TufplVQcxGEafEnv5XfGwRxzODP0TcCKDt7wbSTu3snyr
	vPE6QFGnhdE8LEAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D62051395E;
	Fri, 23 Jan 2026 11:19:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t3lBNDZZc2kDaAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 23 Jan 2026 11:19:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 96D97A0A1B; Fri, 23 Jan 2026 12:19:18 +0100 (CET)
Date: Fri, 23 Jan 2026 12:19:18 +0100
From: Jan Kara <jack@suse.cz>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, yuanql9@chinatelecom.cn
Subject: Re: [PATCH] fs/file: optimize FD allocation complexity with 3-level
 summary bitmap
Message-ID: <53tznvyksgax5523tgnxk5hi5psi5qz4rvfsmywvv2pqjrb3hd@shlvji3mviy4>
References: <20260122170345.157803-1-realwujing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122170345.157803-1-realwujing@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75263-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.cz:dkim,chinatelecom.cn:email];
	DMARC_NA(0.00)[suse.cz];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 687EC74F17
X-Rspamd-Action: no action

On Thu 22-01-26 12:03:45, Qiliang Yuan wrote:
> Current FD allocation performs a two-level bitmap search (open_fds and
> full_fds_bits). This results in O(N/64) complexity when searching for a
> free FD, as the kernel needs to scan the first-level summary bitmap.
> 
> For processes with very large FD limits (e.g., millions of sockets),
> scanning even the level 1 summary bitmap can become a bottleneck during
> high-frequency allocation.
> 
> This patch introduces a third level of summary bitmap (full_fds_bits_l2),
> where each bit represents whether a 64-word chunk (4096 FDs) in open_fds
> is fully allocated. This reduces the search complexity to O(N/4096),
> making FD allocation significantly more scalable for high-concurrency
> workloads.
> 
> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>

Thanks for the patch! I tend to agree with Mateusz that performance numbers
(of some realistic load) for this are needed - not only for your case of
application with huge number of fds but also for tasks with lower number of
fds. Because you are adding another memory (and cacheline) load in the fd
allocation path also for the applications that are happy with the current
2-level allocation scheme. And that is actually a vast majority of
applications... And yes, the additional load does matter as for example
commit 0c40bf47cf2 ("fs/file.c: add fast path in find_next_fd()") provided
measurable improvements when avoiding it.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

