Return-Path: <linux-fsdevel+bounces-45327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB61A76415
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 12:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B42A3A2919
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 10:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E221DFDB8;
	Mon, 31 Mar 2025 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ly+t2ecv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8mNmAeGq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ISFrtwC1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GVP2JhAn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C7F1DC991
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 10:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743416589; cv=none; b=jmF5PIXAXbCa2yw3GQum9UgQlojfddGG59CYMfp5nL8owFu5b+4l2qmd6PJQ9JS8j6JRpEygQ5L+FNQyi9o/TNpHeA4FMHYCHXoxOj9LrceSWrD0wyk2oXgPvXAoM/bswp5vLGjOzEm/NaKHZ9u4qfkaYsdbLR7U05OkIRpuCcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743416589; c=relaxed/simple;
	bh=l8PvKRcSsLN4ao3W7HdWxJP12qa4qZ5iZVTm3CWuWV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ma/1PxbqCAkPcMxREf7uN8vKUAnR4TRRKulZm9N+vu65tQQAGn6pZGAVWD+KKXKik1lJ5shAVy9iArjD0bi4DVzdl/xPkPQe3oWyLPSyHlI27ByheQnY6c95ozTGoOree5VFG6KSpBLUq9kkFSqvZmfGD4aMGoPTv79LWzhPAzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ly+t2ecv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8mNmAeGq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ISFrtwC1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GVP2JhAn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4CA6D211EA;
	Mon, 31 Mar 2025 10:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743416586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y/EhlsjlzL8xhWkkTno252qvfZYol3zYDVGlp4BRXx4=;
	b=ly+t2ecvY3w/u2NomZsJiCaK9fgzBHdINxz5jBLdcBn/Gd0dtUM5wHV4tCBGYT9qduqxze
	1RQuVAAbuX6UFn1BUHgU8TBI/JGoQfjNHI3Z8Fwz5K7PSWZiJp6XZGWmA7PDOkSg4lhkGQ
	YQph1LbReNPYDzgHlVID72Cb4j4G8NY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743416586;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y/EhlsjlzL8xhWkkTno252qvfZYol3zYDVGlp4BRXx4=;
	b=8mNmAeGqV4Dd55uJegs8sV+3gm6ETneiHtRPVXiGZqbPOkBv25W1iT91YC16IaKG95vE6Q
	b0iLbIHJRkeEFZCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743416585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y/EhlsjlzL8xhWkkTno252qvfZYol3zYDVGlp4BRXx4=;
	b=ISFrtwC16oWaWRjg3iau593opZshgp00YBzwPnEXfxfUBqShX6NU1h/X93JeYjdCHg56sA
	PiWyiEawQX+y2BDxu+BrE8fhhQrSmzMIaYubg4QNcvU48blX/FtNSyPX9oHvKqFv2opOGk
	EkgBWp0wVoi44bDEHdbP6eWJbqm5Yf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743416585;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y/EhlsjlzL8xhWkkTno252qvfZYol3zYDVGlp4BRXx4=;
	b=GVP2JhAnWYh2g/84zhoeOoEEvSXYBJmKuOI/GvcOFy1aG/X3cmxMoIOixpK5P0uXTkVg6x
	Ps1zCctcYkX0zoDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 406DD139A1;
	Mon, 31 Mar 2025 10:23:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5RSwDwlt6meGYwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 31 Mar 2025 10:23:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E61E1A08D2; Mon, 31 Mar 2025 12:23:04 +0200 (CEST)
Date: Mon, 31 Mar 2025 12:23:04 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	linux-kernel@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, rafael@kernel.org, 
	djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH v2 6/6] super: add filesystem freezing helpers for
 suspend and hibernate
Message-ID: <k2xbbfnkklbndjbrrnp5lpyrajp3uuw4oxe6xksbtskb2p4myy@o4ypfbabhuu5>
References: <20250329-work-freeze-v2-0-a47af37ecc3d@kernel.org>
 <20250329-work-freeze-v2-6-a47af37ecc3d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250329-work-freeze-v2-6-a47af37ecc3d@kernel.org>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.cz,hansenpartnership.com,kernel.org,infradead.org,fromorbit.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat 29-03-25 09:42:19, Christian Brauner wrote:
> Allow the power subsystem to support filesystem freeze for
> suspend and hibernate.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

One comment below. Otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> +void filesystems_thaw(bool hibernate)
> +{
> +	__iterate_supers(filesystems_thaw_callback, NULL,
> +			 SUPER_ITER_UNLOCKED | SUPER_ITER_REVERSE);
> +}

I think we should thaw in normal superblock order, not in reverse one? To
thaw the bottommost filesystem first? The filesystem thaw callback can
write to the underlying device and this could cause deadlocks...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

