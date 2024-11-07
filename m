Return-Path: <linux-fsdevel+bounces-33886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4C09C02D9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 11:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A10D7B212F9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 10:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB9A1EF938;
	Thu,  7 Nov 2024 10:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rWLcUu72";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="t552Yf66";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rWLcUu72";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="t552Yf66"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DD817A58F;
	Thu,  7 Nov 2024 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730976506; cv=none; b=gHswV7t8ka7pSBB2IGvMiqvVUVLRzYL40OmOBaOXe4+BXd/2JJGO16VO+aq3Q3ZAHRqYj1ZpqBNMV9PdUZ87OXxl8gqtG0XJMQ+2FHdSiRuQZ7tp/jkMOzXPHKwCcjE37tk+IZwH8KZKzwnIawPGakEsoO3DSw5qYHhTfEDmQ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730976506; c=relaxed/simple;
	bh=9O0Ayc1aEVsCrw/KWC7S0y36AOZ8qcqLeXk9SQjlwqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lb+mzEbKdDCYWctHyEsQ6JLnPZurLRpGUUlGyspfjSVVOyrT25CIit8zgTz1lvee3+c2ekoaQH4qJ7BGD55HQmxdc0qsuEX+LQRxcQRs7LxheBA3cH/PIkR8VRvA5kvKCNUn3ctk3+JpLW0W465+HDFMrSphbVqkUDKtjh/CnBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rWLcUu72; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=t552Yf66; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rWLcUu72; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=t552Yf66; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 594F31FF27;
	Thu,  7 Nov 2024 10:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730976502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6UPUFifVx/sDL8OBqGnGORkZaytvo4SMCQ920FxC64c=;
	b=rWLcUu72F5rpYh1NIvqJ9VXWI13IDxzkdFdXRJJ3cYGjXojlr/106NOxh2BQakv2+e8b7J
	7AP6yc3MbKhqsoYlpSr/M0XVwVI3eMdSPvmthRb9CBj8Dz9dA8WsvfNEuJUPH1e68eGIFu
	3J+84AVtf4qicDQxX0Rxg2jKzi6GwFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730976502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6UPUFifVx/sDL8OBqGnGORkZaytvo4SMCQ920FxC64c=;
	b=t552Yf66KnRL5CUJZ/vZuv6kKIUaWqvrRPXi0vNXd/73F5yCvIgeo+VgYpTcI1s2obnspI
	emM8VjGSJTKxsGCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rWLcUu72;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=t552Yf66
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730976502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6UPUFifVx/sDL8OBqGnGORkZaytvo4SMCQ920FxC64c=;
	b=rWLcUu72F5rpYh1NIvqJ9VXWI13IDxzkdFdXRJJ3cYGjXojlr/106NOxh2BQakv2+e8b7J
	7AP6yc3MbKhqsoYlpSr/M0XVwVI3eMdSPvmthRb9CBj8Dz9dA8WsvfNEuJUPH1e68eGIFu
	3J+84AVtf4qicDQxX0Rxg2jKzi6GwFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730976502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6UPUFifVx/sDL8OBqGnGORkZaytvo4SMCQ920FxC64c=;
	b=t552Yf66KnRL5CUJZ/vZuv6kKIUaWqvrRPXi0vNXd/73F5yCvIgeo+VgYpTcI1s2obnspI
	emM8VjGSJTKxsGCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C3881394A;
	Thu,  7 Nov 2024 10:48:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BwSXEvaaLGeREAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 07 Nov 2024 10:48:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id ECC61A0AF4; Thu,  7 Nov 2024 11:48:21 +0100 (CET)
Date: Thu, 7 Nov 2024 11:48:21 +0100
From: Jan Kara <jack@suse.cz>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org,
	mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com,
	jlayton@kernel.org, josef@toxicpanda.com
Subject: Re: [RFC bpf-next fanotify 1/5] fanotify: Introduce fanotify
 fastpath handler
Message-ID: <20241107104821.xpu45m3volgixour@quack3>
References: <20241029231244.2834368-1-song@kernel.org>
 <20241029231244.2834368-2-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029231244.2834368-2-song@kernel.org>
X-Rspamd-Queue-Id: 594F31FF27
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,meta.com,kernel.org,gmail.com,iogearbox.net,linux.dev,zeniv.linux.org.uk,suse.cz,google.com,toxicpanda.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 29-10-24 16:12:40, Song Liu wrote:
> fanotify fastpath handler enables handling fanotify events within the
> kernel, and thus saves a trip to the user space. fanotify fastpath handler
> can be useful in many use cases. For example, if a user is only interested
> in events for some files in side a directory, a fastpath handler can be
> used to filter out irrelevant events.
> 
> fanotify fastpath handler is attached to fsnotify_group. At most one
> fastpath handler can be attached to a fsnotify_group. The attach/detach
> of fastpath handlers are controlled by two new ioctls on the fanotify fds:
> FAN_IOC_ADD_FP and FAN_IOC_DEL_FP.
> 
> fanotify fastpath handler is packaged in a kernel module. In the future,
> it is also possible to package fastpath handler in a BPF program. Since
> loading modules requires CAP_SYS_ADMIN, _loading_ fanotify fastpath
> handler in kernel modules is limited to CAP_SYS_ADMIN. However,
> non-SYS_CAP_ADMIN users can _attach_ fastpath handler loaded by sys admin
> to their fanotify fds. To make fanotify fastpath handler more useful
> for non-CAP_SYS_ADMIN users, a fastpath handler can take arguments at
> attach time.

Hum, I'm not sure I'd be fine as an sysadmin to allow arbitary users to
attach arbitrary filters to their groups. I might want some filters for
priviledged programs which know what they are doing (e.g. because the
filters are expensive) and other filters may be fine for anybody. But
overall I'd think we'll soon hit requirements for permission control over
who can attach what... Somebody must have created a solution for this
already?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

