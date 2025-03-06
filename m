Return-Path: <linux-fsdevel+bounces-43365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE642A54E8D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 16:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18CD01895A7D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 15:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA66720A5D3;
	Thu,  6 Mar 2025 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BJn6iahd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="REMHNr7j";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KfCjqL6z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5PETCIc6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CF817C224
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Mar 2025 15:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273582; cv=none; b=Ew6XyGecw0aK1Aa0q8NHZsuvhowI8IuY1/I4T5W13qDB8BNiFgSUwqsNn1mkBqpY6zmAmD+DYvbO99p/0sT0KMycyQ3t1wbNKxD00Gng7xtyvkGPdL2AiB2WQbeSgWa03tgwXVaRtvTTwe8P4sK0C8sKg7DYVGmXA58Ckd32PF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273582; c=relaxed/simple;
	bh=lTsaNbEL7PPZK0ZEMpQFiHYhojh9KBHVSDzA0Dqu3WY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X24o6xHOS1o2SPLL6RzddDCM4lnANlMpk1V0g+w2nS0ttIkC7TiNKWsMrHVl9X/aupW1MeQPRe4x9+i2mrMwctFY4lLwCz6mvovq1L9q6DS3tGBep3zVZ7khDX4b/WZfqyYs+UaG3jNOkh3GSqMD0OavKPTxtRy2y/NpqNR8NgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BJn6iahd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=REMHNr7j; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KfCjqL6z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5PETCIc6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3479B211B5;
	Thu,  6 Mar 2025 15:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741273575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mB1oMD8PvQtMu2/nphy4C9Bht+f/qS2hF6Qv21atn9A=;
	b=BJn6iahdMWw3giBoFYeRzZqWxIYVqdrsXewUi/FeXURY7hvC87k/0OQd65GRMfTyFp+owF
	p1GqJvVw3JgW17Kx3TWIeRd95Ay7jyHw2w04pxmJWtn3sWQ6husoaF9evKIX95yjviB3w+
	GY7eq2KBOnPLGcOESuyXIZiizoEpBXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741273575;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mB1oMD8PvQtMu2/nphy4C9Bht+f/qS2hF6Qv21atn9A=;
	b=REMHNr7jZvsB2FqS5bmeUjGziTOyaKmVPVQzp/rdn+PEpRHqA1mZ75tlZ2krMw7svg8IZ0
	hdvkX0vMAjHdmOAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KfCjqL6z;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5PETCIc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741273574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mB1oMD8PvQtMu2/nphy4C9Bht+f/qS2hF6Qv21atn9A=;
	b=KfCjqL6zYZbEmJvy4xTp3vwPRtOofMMeYzeooMulSNXZNaEsH1XYb2AYVPDVVNQ/Ft54pK
	HlQfJ20YdJe0QJOEEnRJcB3Qa/uEPlWpX3qNNBkxCtyIEMNRwatFIhjzpl7x/2bm0XpZSU
	Ghyz71dGGZKRdv+UeMI6tA0jtts9u6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741273574;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mB1oMD8PvQtMu2/nphy4C9Bht+f/qS2hF6Qv21atn9A=;
	b=5PETCIc636uk8Hy1RvV0q/IgUqI1ZBcehiialye7CbjnyT/2N2/p+aCDFyzZdlYDZ3brwv
	pAENCuQDlbzAFQDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2206713A61;
	Thu,  6 Mar 2025 15:06:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QE1JCOa5yWcNDgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 06 Mar 2025 15:06:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C9737A087F; Thu,  6 Mar 2025 16:06:05 +0100 (CET)
Date: Thu, 6 Mar 2025 16:06:05 +0100
From: Jan Kara <jack@suse.cz>
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>, 
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	Linux Kernel Audit Mailing List <audit@vger.kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Eric Paris <eparis@parisplace.org>, Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v1 1/2] audit: record fanotify event regardless of
 presence of rules
Message-ID: <aksoenimnsvk4jhxw663spln3pow5x6dys4lbtlfxqtwzwtvs4@yk5ef2tq26l2>
References: <cover.1741210251.git.rgb@redhat.com>
 <3c2679cb9df8a110e1e21b7f387b77ddfaacc289.1741210251.git.rgb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c2679cb9df8a110e1e21b7f387b77ddfaacc289.1741210251.git.rgb@redhat.com>
X-Rspamd-Queue-Id: 3479B211B5
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
	TO_DN_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[10];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FREEMAIL_CC(0.00)[lists.linux-audit.osci.io,vger.kernel.org,paul-moore.com,parisplace.org,redhat.com,suse.cz,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 05-03-25 16:33:19, Richard Guy Briggs wrote:
> When no audit rules are in place, fanotify event results are
> unconditionally dropped due to an explicit check for the existence of
> any audit rules.  Given this is a report from another security
> sub-system, allow it to be recorded regardless of the existence of any
> audit rules.
> 
> To test, install and run the fapolicyd daemon with default config.  Then
> as an unprivileged user, create and run a very simple binary that should
> be denied.  Then check for an event with
> 	ausearch -m FANOTIFY -ts recent
> 
> Link: https://issues.redhat.com/browse/RHEL-1367
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>

I don't know enough about security modules to tell whether this is what
admins want or not so that's up to you but:

> -static inline void audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
> -{
> -	if (!audit_dummy_context())
> -		__audit_fanotify(response, friar);
> -}
> -

I think this is going to break compilation with !CONFIG_AUDITSYSCALL &&
CONFIG_FANOTIFY?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

