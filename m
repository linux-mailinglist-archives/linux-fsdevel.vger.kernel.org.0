Return-Path: <linux-fsdevel+bounces-43444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C96B1A56AE3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 15:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 929E93AA71B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 14:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34D121C9EA;
	Fri,  7 Mar 2025 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u2bxbasN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UPZOzrsy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u2bxbasN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UPZOzrsy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73147192D68
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 14:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741359182; cv=none; b=ZTWkARHUd3yTFYiqkMp+SLAbw3iCD6ONMKS9q8Im63Sfm6MhtsFZ0KmWgEV9+/s1xcAw+SihyWI98qYeZxxDgfgXdgxmliA96Mm6l+eCjIQ+gs9P96S8N5UuYg5W7yTnY+2a59JiVDnVBYN97OpWmo1WRd+LCQLnx3W2Zi3SlFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741359182; c=relaxed/simple;
	bh=qU+VfyYXwmKMWMDbkLHUItkYOPu1I84ijbbgQdEIubs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7FfMdcbT60LILsSVLH2M3+T9X6alNmxmDrYv/j6+euoAPULNU9JZw1gI2Q4QBjSWZ46CmpT5sCiUjMxgmVXajri/USTDH9zwjj8EJSH2Mz3lfTq1m/Aai3K7DbB5XBVnFRSWJR7tVeU3afu+4IV+cvcUyJBCAss3Kv7kz4bGn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u2bxbasN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UPZOzrsy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u2bxbasN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UPZOzrsy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6EC0321184;
	Fri,  7 Mar 2025 14:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741359178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jPWvXYPnJ7Y6KzwiEJ9cDFOBL04knKlm29X0NRAGEZQ=;
	b=u2bxbasNmAxvzEVRkno+U5TtSq+Eb+8aaSlEptJ2GHxcyGQ5wQss1nq/xo36a/FMywpK2u
	kLqYuXP3NblG0OP3DPjVlhzVj5ynDpPEJLnURtHqm+ApIj5FVKAR+BkLq0OGAK/cB0okEZ
	A4QG28AiXsS0Ry9ZfsFyJ1anpWBBRgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741359178;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jPWvXYPnJ7Y6KzwiEJ9cDFOBL04knKlm29X0NRAGEZQ=;
	b=UPZOzrsyfcj/WQ+Rp80iCUI0RZjiqVLBk4iyHPcJqaddA7wbvZH4Ru01U7F9SAmZPeQO8F
	GSjddpvjF90V0TBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=u2bxbasN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UPZOzrsy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741359178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jPWvXYPnJ7Y6KzwiEJ9cDFOBL04knKlm29X0NRAGEZQ=;
	b=u2bxbasNmAxvzEVRkno+U5TtSq+Eb+8aaSlEptJ2GHxcyGQ5wQss1nq/xo36a/FMywpK2u
	kLqYuXP3NblG0OP3DPjVlhzVj5ynDpPEJLnURtHqm+ApIj5FVKAR+BkLq0OGAK/cB0okEZ
	A4QG28AiXsS0Ry9ZfsFyJ1anpWBBRgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741359178;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jPWvXYPnJ7Y6KzwiEJ9cDFOBL04knKlm29X0NRAGEZQ=;
	b=UPZOzrsyfcj/WQ+Rp80iCUI0RZjiqVLBk4iyHPcJqaddA7wbvZH4Ru01U7F9SAmZPeQO8F
	GSjddpvjF90V0TBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66A4413939;
	Fri,  7 Mar 2025 14:52:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 51MMGUoIy2f0MwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 07 Mar 2025 14:52:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 23421A089C; Fri,  7 Mar 2025 15:52:58 +0100 (CET)
Date: Fri, 7 Mar 2025 15:52:58 +0100
From: Jan Kara <jack@suse.cz>
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Jan Kara <jack@suse.cz>, 
	Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>, LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org, Linux Kernel Audit Mailing List <audit@vger.kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>, 
	Steve Grubb <sgrubb@redhat.com>, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v1 1/2] audit: record fanotify event regardless of
 presence of rules
Message-ID: <jhvf3n4fnzsnj7opxooqblmpnuhvqhcg366y47p5u44dg4tm3i@snmc3msdcoiv>
References: <cover.1741210251.git.rgb@redhat.com>
 <3c2679cb9df8a110e1e21b7f387b77ddfaacc289.1741210251.git.rgb@redhat.com>
 <aksoenimnsvk4jhxw663spln3pow5x6dys4lbtlfxqtwzwtvs4@yk5ef2tq26l2>
 <Z8pH97tbwt7OGj2o@madcap2.tricolour.ca>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8pH97tbwt7OGj2o@madcap2.tricolour.ca>
X-Rspamd-Queue-Id: 6EC0321184
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[10];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FREEMAIL_CC(0.00)[suse.cz,lists.linux-audit.osci.io,vger.kernel.org,paul-moore.com,parisplace.org,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 06-03-25 20:12:23, Richard Guy Briggs wrote:
> On 2025-03-06 16:06, Jan Kara wrote:
> > On Wed 05-03-25 16:33:19, Richard Guy Briggs wrote:
> > > When no audit rules are in place, fanotify event results are
> > > unconditionally dropped due to an explicit check for the existence of
> > > any audit rules.  Given this is a report from another security
> > > sub-system, allow it to be recorded regardless of the existence of any
> > > audit rules.
> > > 
> > > To test, install and run the fapolicyd daemon with default config.  Then
> > > as an unprivileged user, create and run a very simple binary that should
> > > be denied.  Then check for an event with
> > > 	ausearch -m FANOTIFY -ts recent
> > > 
> > > Link: https://issues.redhat.com/browse/RHEL-1367
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > 
> > I don't know enough about security modules to tell whether this is what
> > admins want or not so that's up to you but:
> > 
> > > -static inline void audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
> > > -{
> > > -	if (!audit_dummy_context())
> > > -		__audit_fanotify(response, friar);
> > > -}
> > > -
> > 
> > I think this is going to break compilation with !CONFIG_AUDITSYSCALL &&
> > CONFIG_FANOTIFY?
> 
> Why would that break it?  The part of the patch you (prematurely)
> deleted takes care of that.

So I'm failing to see how it takes care of that when with
!CONFIG_AUDITSYSCALL kernel/auditsc.c does not get compiled into the kernel.
So what does provide the implementation of audit_fanotify() in that case?
I think you need to provide empty audit_fanotify() inline wrapper for that
case...

								Honza

> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 0050ef288ab3..d0c6f23503a1 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -418,7 +418,7 @@ extern void __audit_log_capset(const struct cred *new, const struct cred *old);
>  extern void __audit_mmap_fd(int fd, int flags);
>  extern void __audit_openat2_how(struct open_how *how);
>  extern void __audit_log_kern_module(char *name);
> -extern void __audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar);
> +extern void audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar);
>  extern void __audit_tk_injoffset(struct timespec64 offset);
>  extern void __audit_ntp_log(const struct audit_ntp_data *ad);
>  extern void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
> 
> > 								Honza
> > -- 
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
> 
> - RGB
> 
> --
> Richard Guy Briggs <rgb@redhat.com>
> Sr. S/W Engineer, Kernel Security, Base Operating Systems
> Remote, Ottawa, Red Hat Canada
> Upstream IRC: SunRaycer
> Voice: +1.613.860 2354 SMS: +1.613.518.6570
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

