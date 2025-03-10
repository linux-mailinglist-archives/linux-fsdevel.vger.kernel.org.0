Return-Path: <linux-fsdevel+bounces-43601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 055BBA59514
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 13:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BC12188E3EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 12:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F4722A1CB;
	Mon, 10 Mar 2025 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kE4XX5pJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qfSFEpj/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kE4XX5pJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qfSFEpj/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ED7227B9E
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741611011; cv=none; b=UQlyDNMP91p4DyR/WfYgAc0wISTNcOF6QyLs/EmjAYWHI459aRTsGkQ+6/WbkcIBkceTjM5xUNWpA4msmeUu58TcV7uS6GbfAz0QCRfwm3YyXepqLK1v0ssQOHlc09MGgFFKMJzmQflraJU/jqWF0LPKkFAj0HaW+bfNo//rTE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741611011; c=relaxed/simple;
	bh=uv2LeiwmSYk9JHNO8vrIiEMLTWXzeIqUg/+DKvcaji8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfAMYZWb3PULytP/WVqh79EZK6jRWdDN/Pw7eaKkXEZ5wjtTMe6GguEqxgkH+y9PYVQ9HCSGkErZI7jQBx64M9C81axXE7lytxEin6KV4E2xX/J8inBswQ5qNuKv61WjQB1JafkW9YwhG262cO0+LRGcu+mIFNtYs4EGgxiQbmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kE4XX5pJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qfSFEpj/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kE4XX5pJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qfSFEpj/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2303E1F393;
	Mon, 10 Mar 2025 12:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741611008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gsAsdkpgjRb4gj83QOMLe2Bt8iVlfyUjr31sGYQjwPw=;
	b=kE4XX5pJxoi1Xy54sdt7BBUMgpxxVMW+cYG+Z4eFyo90QWzbLeMWZi0w4/h0zXrNY5pIcb
	w3XbJhmzlI1VZBKDj/Q8bZNgAs7LE3dgWlYyY/pWGtrt6E3/PwuQOy6KW8fjG1WpX1v9YQ
	Ury2Z5cyhtVOLDja5bxAC5Lx1bJj0uI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741611008;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gsAsdkpgjRb4gj83QOMLe2Bt8iVlfyUjr31sGYQjwPw=;
	b=qfSFEpj/S/OaLmKthv92R3t35Vq4v6md62glGFwVEcYaFrfSJzgbxyMYxNQCMW0v8I/7pO
	vI37S0idBzo5F7Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741611008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gsAsdkpgjRb4gj83QOMLe2Bt8iVlfyUjr31sGYQjwPw=;
	b=kE4XX5pJxoi1Xy54sdt7BBUMgpxxVMW+cYG+Z4eFyo90QWzbLeMWZi0w4/h0zXrNY5pIcb
	w3XbJhmzlI1VZBKDj/Q8bZNgAs7LE3dgWlYyY/pWGtrt6E3/PwuQOy6KW8fjG1WpX1v9YQ
	Ury2Z5cyhtVOLDja5bxAC5Lx1bJj0uI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741611008;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gsAsdkpgjRb4gj83QOMLe2Bt8iVlfyUjr31sGYQjwPw=;
	b=qfSFEpj/S/OaLmKthv92R3t35Vq4v6md62glGFwVEcYaFrfSJzgbxyMYxNQCMW0v8I/7pO
	vI37S0idBzo5F7Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1886D139E7;
	Mon, 10 Mar 2025 12:50:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gtT2BQDgzmeHFwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 10 Mar 2025 12:50:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CB332A0912; Mon, 10 Mar 2025 13:50:03 +0100 (CET)
Date: Mon, 10 Mar 2025 13:50:03 +0100
From: Jan Kara <jack@suse.cz>
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Jan Kara <jack@suse.cz>, 
	Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>, LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org, Linux Kernel Audit Mailing List <audit@vger.kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>, 
	Steve Grubb <sgrubb@redhat.com>, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v1 1/2] audit: record fanotify event regardless of
 presence of rules
Message-ID: <qra7odz5uj2yf3vogzmbsbgzfumfxu3xjkm7wvhghnwqxcow4i@jp6yd57qjutb>
References: <cover.1741210251.git.rgb@redhat.com>
 <3c2679cb9df8a110e1e21b7f387b77ddfaacc289.1741210251.git.rgb@redhat.com>
 <aksoenimnsvk4jhxw663spln3pow5x6dys4lbtlfxqtwzwtvs4@yk5ef2tq26l2>
 <Z8pH97tbwt7OGj2o@madcap2.tricolour.ca>
 <jhvf3n4fnzsnj7opxooqblmpnuhvqhcg366y47p5u44dg4tm3i@snmc3msdcoiv>
 <Z8tGyiUzX6p+2vpp@madcap2.tricolour.ca>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8tGyiUzX6p+2vpp@madcap2.tricolour.ca>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,lists.linux-audit.osci.io,vger.kernel.org,paul-moore.com,parisplace.org,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 07-03-25 14:19:38, Richard Guy Briggs wrote:
> On 2025-03-07 15:52, Jan Kara wrote:
> > On Thu 06-03-25 20:12:23, Richard Guy Briggs wrote:
> > > On 2025-03-06 16:06, Jan Kara wrote:
> > > > On Wed 05-03-25 16:33:19, Richard Guy Briggs wrote:
> > > > > When no audit rules are in place, fanotify event results are
> > > > > unconditionally dropped due to an explicit check for the existence of
> > > > > any audit rules.  Given this is a report from another security
> > > > > sub-system, allow it to be recorded regardless of the existence of any
> > > > > audit rules.
> > > > > 
> > > > > To test, install and run the fapolicyd daemon with default config.  Then
> > > > > as an unprivileged user, create and run a very simple binary that should
> > > > > be denied.  Then check for an event with
> > > > > 	ausearch -m FANOTIFY -ts recent
> > > > > 
> > > > > Link: https://issues.redhat.com/browse/RHEL-1367
> > > > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > > 
> > > > I don't know enough about security modules to tell whether this is what
> > > > admins want or not so that's up to you but:
> > > > 
> > > > > -static inline void audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
> > > > > -{
> > > > > -	if (!audit_dummy_context())
> > > > > -		__audit_fanotify(response, friar);
> > > > > -}
> > > > > -
> > > > 
> > > > I think this is going to break compilation with !CONFIG_AUDITSYSCALL &&
> > > > CONFIG_FANOTIFY?
> > > 
> > > Why would that break it?  The part of the patch you (prematurely)
> > > deleted takes care of that.
> > 
> > So I'm failing to see how it takes care of that when with
> > !CONFIG_AUDITSYSCALL kernel/auditsc.c does not get compiled into the kernel.
> > So what does provide the implementation of audit_fanotify() in that case?
> > I think you need to provide empty audit_fanotify() inline wrapper for that
> > case...
> 
> I'm sorry, I responded too quickly without thinking about your question,
> my mistake.  It isn't the prototype that was changed in the
> CONFIG_SYSCALL case that is relevant in that case.
> 
> There was already in existance in the !CONFIG_AUDITSYSCALL case the
> inline wrapper to do that job:
> 
> 	static inline void audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
> 	{ }
> 
> Did I understand correctly this time and does this answer your question?

Yes, thanks for explanation and sorry for not noticing the second
audit_fanotify() implementation. Somehow I've hasted to a conclusion (based
on customs of parts of kernel I maintain ;)) that you rely on
audit_dummy_context() being constant 0 for !CONFIG_AUDITSYSCALL and thus
__audit_fanotify() call getting compiled out (which would not be the case
after your changes).

Anyway, for the patch feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

> But you do cause me to notice the case that these notifications will be
> dropped when CONFIG_AUDIT && !CONFIG_AUDITSYSCALL.

Glad my blindness helped something ;)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

