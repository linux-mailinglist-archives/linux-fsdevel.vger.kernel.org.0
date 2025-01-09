Return-Path: <linux-fsdevel+bounces-38727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C34A07371
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 11:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D946018811A1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 10:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D00216381;
	Thu,  9 Jan 2025 10:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UhabqEOq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fqGqhtka";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UhabqEOq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fqGqhtka"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A992204C0D;
	Thu,  9 Jan 2025 10:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736419075; cv=none; b=DLXauAxIE3slLXzj0BSRsVJHm2ohVxFrSjXqJo+SxNw6M5mtC1CntM6BAnjPIuNmj7gc4F6K2ZcvUHxD9cyWOxhwjHI6OpkrJg4CLT3yXa2QcYLtPwMkwSSXHUNded4u8zDfbymk/5rMbsrbtxrEVSX8lM2N/hnscr8LXOTyUGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736419075; c=relaxed/simple;
	bh=7xl1sBFt2GFWC41AWFg2risMqWrJmQ862WAJ8DnWKlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFPbIPj2SU5c7cvX8DpqpfKPwFMeBUZQYyxuYEysXt1cDhiwsbg8C4Kty+iKpuEO2mRwvjce/lnTgVhI6KQHa0wyrV0jRYu5cmqtQfNTfWyf6mZ3r/TyodER0GNBEa7F9ML7HPBAa+DGYcgtOIytdFUWtjBxDasYY85f+Ky7Tbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UhabqEOq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fqGqhtka; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UhabqEOq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fqGqhtka; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 235E821114;
	Thu,  9 Jan 2025 10:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736419071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CX40sLvsmEhDLSJTaTldfvB4pJb1E1M5ld3ODr0Mkbs=;
	b=UhabqEOqWkFJt9pS2Eg7bmNobXgAaYioaBedkfwEo6llN+5M7LZttYYlHSWbWwnIK5CAv4
	uCYy6llxHAUGUOZRo2WXQ8ksSFDzmbZMGytwVMhwE0AztxyqrPRhgLGuTlQTRygCldfEhg
	HiYoojxFk1Z5q1xzu01v0zQdB2VgIQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736419071;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CX40sLvsmEhDLSJTaTldfvB4pJb1E1M5ld3ODr0Mkbs=;
	b=fqGqhtka0ItNK7M+x7GYmey/2CvecS9u9o5ZCX/Gzcn4G1CO+LTRHjXpV4N1ALoQKV4UZE
	WppUXtBqx4qV0aAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UhabqEOq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fqGqhtka
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736419071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CX40sLvsmEhDLSJTaTldfvB4pJb1E1M5ld3ODr0Mkbs=;
	b=UhabqEOqWkFJt9pS2Eg7bmNobXgAaYioaBedkfwEo6llN+5M7LZttYYlHSWbWwnIK5CAv4
	uCYy6llxHAUGUOZRo2WXQ8ksSFDzmbZMGytwVMhwE0AztxyqrPRhgLGuTlQTRygCldfEhg
	HiYoojxFk1Z5q1xzu01v0zQdB2VgIQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736419071;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CX40sLvsmEhDLSJTaTldfvB4pJb1E1M5ld3ODr0Mkbs=;
	b=fqGqhtka0ItNK7M+x7GYmey/2CvecS9u9o5ZCX/Gzcn4G1CO+LTRHjXpV4N1ALoQKV4UZE
	WppUXtBqx4qV0aAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14593139AB;
	Thu,  9 Jan 2025 10:37:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1pDtBP+mf2ewFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 09 Jan 2025 10:37:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BF005A0887; Thu,  9 Jan 2025 11:37:46 +0100 (CET)
Date: Thu, 9 Jan 2025 11:37:46 +0100
From: Jan Kara <jack@suse.cz>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kselftest@vger.kernel.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
	Andrew Melnychenko <andrew@daynix.com>, Stephen Hemminger <stephen@networkplumber.org>, 
	gur.stavi@huawei.com, devel@daynix.com
Subject: Re: [PATCH v2 2/3] tun: Pad virtio header with zero
Message-ID: <apouzqstvjjracsde2o4ky3wguw7xeerolc5mp4aty4zgnpxct@gongys63jwdw>
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-2-388d7d5a287a@daynix.com>
 <20250109023056-mutt-send-email-mst@kernel.org>
 <571a2d61-5fbe-4e49-b4d1-6bf0c7604a57@daynix.com>
 <20250109024247-mutt-send-email-mst@kernel.org>
 <6f33c048-81ad-4d15-872d-187e965e6d79@daynix.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f33c048-81ad-4d15-872d-187e965e6d79@daynix.com>
X-Rspamd-Queue-Id: 235E821114
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLxr8yp7wrfbdywxro7ki6ncu8)];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,davemloft.net,google.com,lwn.net,gmail.com,linux.alibaba.com,lists.linux-foundation.org,daynix.com,networkplumber.org,huawei.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Thu 09-01-25 18:36:52, Akihiko Odaki wrote:
> On 2025/01/09 16:43, Michael S. Tsirkin wrote:
> > On Thu, Jan 09, 2025 at 04:41:50PM +0900, Akihiko Odaki wrote:
> > > On 2025/01/09 16:31, Michael S. Tsirkin wrote:
> > > > On Thu, Jan 09, 2025 at 03:58:44PM +0900, Akihiko Odaki wrote:
> > > > > tun used to simply advance iov_iter when it needs to pad virtio header,
> > > > > which leaves the garbage in the buffer as is. This is especially
> > > > > problematic when tun starts to allow enabling the hash reporting
> > > > > feature; even if the feature is enabled, the packet may lack a hash
> > > > > value and may contain a hole in the virtio header because the packet
> > > > > arrived before the feature gets enabled or does not contain the
> > > > > header fields to be hashed. If the hole is not filled with zero, it is
> > > > > impossible to tell if the packet lacks a hash value.
> > > > > 
> > > > > In theory, a user of tun can fill the buffer with zero before calling
> > > > > read() to avoid such a problem, but leaving the garbage in the buffer is
> > > > > awkward anyway so fill the buffer in tun.
> > > > > 
> > > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > > 
> > > > But if the user did it, you have just overwritten his value,
> > > > did you not?
> > > 
> > > Yes. but that means the user expects some part of buffer is not filled after
> > > read() or recvmsg(). I'm a bit worried that not filling the buffer may break
> > > assumptions others (especially the filesystem and socket infrastructures in
> > > the kernel) may have.
> > > 
> > > If we are really confident that it will not cause problems, this behavior
> > > can be opt-in based on a flag or we can just write some documentation
> > > warning userspace programmers to initialize the buffer.
> > 
> > It's been like this for years, I'd say we wait until we know there's a problem?
> 
> Perhaps we can just leave it as is. Let me ask filesystem and networking
> people:
> 
> Is it OK to leave some part of buffer uninitialized with read_iter() or
> recvmsg()?

I think that leaving part of the IO buffer within returned IO length
uninitialized is a very bad practice and I'm not aware of any place in
filesystem area that would do that. It makes life unnecessarily harder
for userspace and also it is invitation for subtle information leaks
(depending on who allocates the buffer and who then gets to read the
results). So I think the patch makes sense.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

