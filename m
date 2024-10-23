Return-Path: <linux-fsdevel+bounces-32684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0262E9AD5B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 22:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4471F215AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 20:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4152010FA;
	Wed, 23 Oct 2024 20:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FChnjELD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zP41KkCq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FChnjELD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zP41KkCq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156FB200C8E;
	Wed, 23 Oct 2024 20:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715995; cv=none; b=V8/Flw1cKxgO8V7YkL1npOqQu/SXMwSHmNPESL4098iTOQCkf4GylI1zuknfC4VMWvpnXb4SIk5U2Wd99XFzgYAVmXtzoRI3NXwt9yKNjROQvN/XM3zTGdtsYGQSn5pimef3TGoJkLMa4M2l2Ex2t+KFFhnAORAMKp5K+lWUb1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715995; c=relaxed/simple;
	bh=ov4azDVRaPZ2oKYDM8O9TvZytt2u/+KuICEs+PW3zKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+6VY5aNCWgFRPEUhydzGHZNVOOWolDJRg87oigjONW32QNBrnVzC7t47LOo92XbOd+aPA4KEUakG0RQ/xezvfP2t+8Hbmmmf68SnrkYy3D4Y+Dh/1PoF/O361Q3zyskuUz3mq3gIiBVI4Bgq8pae+D1ge4Pp0vuw/+c0NU0zN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FChnjELD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zP41KkCq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FChnjELD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zP41KkCq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 295CF21D9A;
	Wed, 23 Oct 2024 20:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729715992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2x44n91pzkFE6swZtLXGYQHAvHmEHeGzQyvr4Is80N0=;
	b=FChnjELDUd7QoyIstoqnZr8VJFZLF3aN5nDCK9JR8ReAs9wZqOlkphAn0o0LR9REBZABhV
	6x5V5Z9XmegJbkEaVtTnINOJwPZtOqaaxsk+HBsf/yqaTPS4cPuWrD+4WpbrmPL2FobY2G
	aKUqvIM3fsYQPHtFZzO8eV1GnEj4N2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729715992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2x44n91pzkFE6swZtLXGYQHAvHmEHeGzQyvr4Is80N0=;
	b=zP41KkCqtWsz/r03+0v2C4G61eZQZB3bgb7PlJ0RqKJ/FkVAReiKjObYz6Lhsmr2XIDFxF
	djq1JP7cMVNmH0Aw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FChnjELD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zP41KkCq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729715992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2x44n91pzkFE6swZtLXGYQHAvHmEHeGzQyvr4Is80N0=;
	b=FChnjELDUd7QoyIstoqnZr8VJFZLF3aN5nDCK9JR8ReAs9wZqOlkphAn0o0LR9REBZABhV
	6x5V5Z9XmegJbkEaVtTnINOJwPZtOqaaxsk+HBsf/yqaTPS4cPuWrD+4WpbrmPL2FobY2G
	aKUqvIM3fsYQPHtFZzO8eV1GnEj4N2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729715992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2x44n91pzkFE6swZtLXGYQHAvHmEHeGzQyvr4Is80N0=;
	b=zP41KkCqtWsz/r03+0v2C4G61eZQZB3bgb7PlJ0RqKJ/FkVAReiKjObYz6Lhsmr2XIDFxF
	djq1JP7cMVNmH0Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14FDD13AD3;
	Wed, 23 Oct 2024 20:39:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bvIdBRhfGWdefwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 23 Oct 2024 20:39:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BCECBA08A2; Wed, 23 Oct 2024 22:39:51 +0200 (CEST)
Date: Wed, 23 Oct 2024 22:39:51 +0200
From: Jan Kara <jack@suse.cz>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: v6.12-rc workqueue lockups
Message-ID: <20241023203951.unvxg2claww4s2x5@quack3>
References: <63d6ceeb-a22f-4dee-bc9d-8687ce4c7355@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63d6ceeb-a22f-4dee-bc9d-8687ce4c7355@oracle.com>
X-Rspamd-Queue-Id: 295CF21D9A
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Wed 23-10-24 11:19:24, John Garry wrote:
> Hi All,
> 
> I have been seeing lockups reliably occur on v6.12-rc1, 3, 4 and linus'
> master branch:
> 
> Message from syslogd@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 at
> Oct 22 09:07:15 ...
>  kernel:watchdog: BUG: soft lockup - CPU#12 stuck for 26s! [khugepaged:154]

BTW, can you please share logs which would contain full stacktraces that
this softlockup reports produce? The attached dmesg is just from fresh
boot...  Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

