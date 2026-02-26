Return-Path: <linux-fsdevel+bounces-78502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF9WHtVaoGm3igQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:38:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFCE1A7B60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B110430F2250
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AAC3D6470;
	Thu, 26 Feb 2026 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lhHyLkXX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wZklsiWW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lhHyLkXX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wZklsiWW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4D23D6475
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772115549; cv=none; b=kPAJzh3XTVLlLuzXPy5j+BDI1uPDcoQah0mUPyug6lRLQy20a8ZIazs9nU/Ol5fJMf2a8EmZOdwkSqE9FBGka5WyANj9YamLT+r1WOtMd1dJMKYK0iMwuG3LUMQRessQG4BiZDYFEHD4Dr3NC3LP+ZPFoDP4e3HRHTG1BJcYgq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772115549; c=relaxed/simple;
	bh=odV80GJtq0mUHGhjvkQKoV2oxNxteHCidYJb/iPhJvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLHU5lAZogCdoT0YacWXyLPzXTfeEjhB1mqWQAyhJVdk3Ot2ITd5XN61yQtEflmATbDQAE5PyFR10t+YDp9otVTeI+KrFeP/Zl53n4qJxGqo1/mY9u1XG48dtb46qD3WY5UoV+CwUwdznYgo9KnJZiMAWolzF97CgfW7nJJEB1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lhHyLkXX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wZklsiWW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lhHyLkXX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wZklsiWW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3ABE83F8B5;
	Thu, 26 Feb 2026 14:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772115546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2uG/loOzTdMLJ0wlLRCp/zIvxQSU407W5RWykMyDcWc=;
	b=lhHyLkXXlPnfPXiAdePNd0Lm4Ih3UW3RjPqXrj5XXn5HEFae1GsVqGRnITccjsr4fOZmF4
	j0Ht/6Vp2o/tWQ7Fg1st+YXTqVT7Z1vD0M7NYPH5p5V9XlPgZ8Rq3c556sgGyMr1x8EWXd
	W8Iu7X2N+vm1trLnxZjLm+jPYe1hMAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772115546;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2uG/loOzTdMLJ0wlLRCp/zIvxQSU407W5RWykMyDcWc=;
	b=wZklsiWWmnIkI/vz0pwmLKflEayo9HqbOPbxcGRS9pasbZQoPwx4KokCWOo7KksLO7GyEj
	jwrBEETJEFiU/DDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772115546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2uG/loOzTdMLJ0wlLRCp/zIvxQSU407W5RWykMyDcWc=;
	b=lhHyLkXXlPnfPXiAdePNd0Lm4Ih3UW3RjPqXrj5XXn5HEFae1GsVqGRnITccjsr4fOZmF4
	j0Ht/6Vp2o/tWQ7Fg1st+YXTqVT7Z1vD0M7NYPH5p5V9XlPgZ8Rq3c556sgGyMr1x8EWXd
	W8Iu7X2N+vm1trLnxZjLm+jPYe1hMAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772115546;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2uG/loOzTdMLJ0wlLRCp/zIvxQSU407W5RWykMyDcWc=;
	b=wZklsiWWmnIkI/vz0pwmLKflEayo9HqbOPbxcGRS9pasbZQoPwx4KokCWOo7KksLO7GyEj
	jwrBEETJEFiU/DDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 304A93EA62;
	Thu, 26 Feb 2026 14:19:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KqTDC1pWoGnpEAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Feb 2026 14:19:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E5C9BA0A27; Thu, 26 Feb 2026 15:19:05 +0100 (CET)
Date: Thu, 26 Feb 2026 15:19:05 +0100
From: Jan Kara <jack@suse.cz>
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] fanotify: avid some premature LSM checks
Message-ID: <hein42plwi3lhonfdvox7a267ycy3o6677ciofirpfy6vh6atz@xkltgcdlncpg>
References: <20260216150625.793013-1-omosnace@redhat.com>
 <yk2qcux2ee7afr24xw6p7wp4t3islu64ttfsrheac2zwr6odnw@kmagnqbldb3f>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yk2qcux2ee7afr24xw6p7wp4t3islu64ttfsrheac2zwr6odnw@kmagnqbldb3f>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-78502-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7AFCE1A7B60
X-Rspamd-Action: no action

On Tue 17-02-26 12:09:34, Jan Kara wrote:
> On Mon 16-02-26 16:06:23, Ondrej Mosnacek wrote:
> > Restructure some of the validity and security checks in
> > fs/notify/fanotify/fanotify_user.c to avoid generating LSM access
> > denials in the audit log where hey shouldn't be.
> > 
> > Ondrej Mosnacek (2):
> >   fanotify: avoid/silence premature LSM capability checks
> >   fanotify: call fanotify_events_supported() before path_permission()
> >     and security_path_notify()
> > 
> >  fs/notify/fanotify/fanotify_user.c | 50 ++++++++++++++----------------
> >  1 file changed, 23 insertions(+), 27 deletions(-)
> 
> The series looks good to me as well. Thanks! I'll commit the series to my
> tree once the merge window closes and fixup the comment formatting on
> commit. No need to resend.

Pushed the series to my tree now.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

