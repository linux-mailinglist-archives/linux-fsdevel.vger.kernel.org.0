Return-Path: <linux-fsdevel+bounces-28507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 921B896B654
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 11:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F6F287F95
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 09:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41151CCECB;
	Wed,  4 Sep 2024 09:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z+++KBV6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dIp/U31u";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z+++KBV6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dIp/U31u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD7E1CC8AD;
	Wed,  4 Sep 2024 09:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441557; cv=none; b=TX/xeLQUMPIGZQ1MHKsR5LaB7JrfEKg+X2zKrY8dd+5U9ddDm28ZAtsqw7Npb2+mVfEzcip0qQBpvwGN01HyYxMW/psPUH/qPLKje/fYK7unRYkL8jESxzjS3Ljh+B/4MVkHTeiG1n2kgZOSdLWo5bmoFeHDGwVvXO3ff+HthiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441557; c=relaxed/simple;
	bh=rYhibeLToLXao14siX2jw/NrLhl3ubJwHIS7KjZoSAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hODfrYWOq9He4XKtUSuWts5SnBPR6mnch6uMUbj2e5kdO33vwu5sf9Ef8wfYV5ucuFMdmuKRcA/ex+Uh1pJH4gUWrCCiuKSWIGJw5soLrJkYpw4bhqdeWuwBfWoaiGseihn39zQY5zt/RHQcLjBc2iQhQODcGDi7Rqj9M5TZVww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z+++KBV6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dIp/U31u; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z+++KBV6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dIp/U31u; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 92602219FF;
	Wed,  4 Sep 2024 09:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725441553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+X4CE5OLGkYKJigdScpNImAF/U5YbkQWvOcK47dWD28=;
	b=Z+++KBV6oe73P/joFHjRfqqh4k6JMx/N8SOWkWyK9jL5GWhQMDSsr4mhZdvwuU0RtK7UFF
	lwDFYFWrezFgxtQrOnOXg6522NQgU4FJECHq8YXTPjcyg34uniKqN07z39uXYVGOkkqZ8X
	Od08T8NDOhFKZJ2FojmP95oxJXHy5OM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725441553;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+X4CE5OLGkYKJigdScpNImAF/U5YbkQWvOcK47dWD28=;
	b=dIp/U31u/wEjs3Es1kWHBKqwqFHyoNzaQSmvzOqhYbMYNMvLNeWAzSfWLsx5mKAdiO3GPT
	yKMVQohw3gfzukBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725441553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+X4CE5OLGkYKJigdScpNImAF/U5YbkQWvOcK47dWD28=;
	b=Z+++KBV6oe73P/joFHjRfqqh4k6JMx/N8SOWkWyK9jL5GWhQMDSsr4mhZdvwuU0RtK7UFF
	lwDFYFWrezFgxtQrOnOXg6522NQgU4FJECHq8YXTPjcyg34uniKqN07z39uXYVGOkkqZ8X
	Od08T8NDOhFKZJ2FojmP95oxJXHy5OM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725441553;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+X4CE5OLGkYKJigdScpNImAF/U5YbkQWvOcK47dWD28=;
	b=dIp/U31u/wEjs3Es1kWHBKqwqFHyoNzaQSmvzOqhYbMYNMvLNeWAzSfWLsx5mKAdiO3GPT
	yKMVQohw3gfzukBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 84CB0139E2;
	Wed,  4 Sep 2024 09:19:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YsyDHxEm2GbXEgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Sep 2024 09:19:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0397BA0962; Wed,  4 Sep 2024 11:19:12 +0200 (CEST)
Date: Wed, 4 Sep 2024 11:19:12 +0200
From: Jan Kara <jack@suse.cz>
To: Jon Kohler <jon@nutanix.com>
Cc: "paulmck@kernel.org" <paulmck@kernel.org>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
	"josh@joshtriplett.org" <josh@joshtriplett.org>,
	"jack@suse.cz" <jack@suse.cz>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: SRCU hung task on 5.10.y on synchronize_srcu(&fsnotify_mark_srcu)
Message-ID: <20240904091912.orpkwemgpsgcongo@quack3>
References: <1E829024-48BF-4647-A1DD-AC7E8BFA0FA2@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1E829024-48BF-4647-A1DD-AC7E8BFA0FA2@nutanix.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,joshtriplett.org,suse.cz];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 27-08-24 20:01:27, Jon Kohler wrote:
> Hey Paul, Lai, Josh, and the RCU list and Jan/FS list -
> Reaching out about a tricky hung task issue that I'm running into. I've
> got a virtualized Linux guest on top of a KVM based platform, running
> a 5.10.y based kernel. The issue we're running into is a hung task that
> *only* happens on shutdown/reboot of this particular VM once every 
> 20-50 times.
> 
> The signature of the hung task is always similar to the output below,
> where we appear to hang on the call to 
>     synchronize_srcu(&fsnotify_mark_srcu)
> in fsnotify_connector_destroy_workfn / fsnotify_mark_destroy_workfn,
> where two kernel threads are both calling synchronize_srcu, then
> scheduling out in wait_for_completion, and completely going out to
> lunch for over 4 minutes. This then triggers the hung task timeout and
> things blow up.

Well, the most obvious reason for this would be that some process is
hanging somewhere with fsnotify_mark_srcu held. When this happens, can you
trigger sysrq-w in the VM and send here its output?

> We are running audit=1 for this system and are using an el8 based
> userspace.
> 
> I've flipped through the fs/notify code base for both 5.10 as well as
> upstream mainline to see if something jumped off the page, and I
> haven't yet spotted any particular suspect code from the caller side.
> 
> This hang appears to come up at the very end of the shutdown/reboot
> process, seemingly after the system starts to unwind through initrd.
> 
> What I'm working on now is adding some instrumentation to the dracut
> shutdown initrd scripts to see if I can how far we get down that path
> before the system fails to make forward progress, which may give some
> hints. TBD on that. I've also enabled lockdep with CONFIG_PROVE_RCU and
> a plethora of DEBUG options [2], and didn't get anything interesting.
> To be clear, we haven't seen lockdep spit out any complaints as of yet.

The fact that lockdep doesn't report anything is interesting but then
lockdep doesn't track everything. In particular I think SRCU itself isn't
tracked by lockdep.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

