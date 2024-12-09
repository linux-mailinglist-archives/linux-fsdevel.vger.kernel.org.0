Return-Path: <linux-fsdevel+bounces-36780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444CF9E9455
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 13:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562922808EC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 12:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D5622F3BF;
	Mon,  9 Dec 2024 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oC0LAQkN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mLAsF/WF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oC0LAQkN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mLAsF/WF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5C322F3AB;
	Mon,  9 Dec 2024 12:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747654; cv=none; b=UVqj+bhnlsnMPIbNuFlD4zdxgbPvc8ph50iCFbg6i7nUvpqRDHIujkO/ImO30c+KvuehLgjNnTrDJD8WfKgQEfpV5IZhCXSdVQlXFbP8bqyU4Pvsb0bUsUdI7yPfzVXXhTO0IuRXz2xb9WA61McxAJ3s/N6UW7CBbLTgf7Sm/RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747654; c=relaxed/simple;
	bh=1F9vG7EuviCbqG0VhQROX4GQPE0EnbitMrPyGmiN5bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lASMm8+aXPpIV38/lc9pImoQDsI+3Ig2QRAg/drluNQRZgFrQ+s+GO44PeXhxSiCo7HURGCaE3YVdkw4e9A3AnLFJowNKD7ACtQlPTWg1qsILGQ6d0QT36I18j5Q1wGJj9UUbpF/LiVC7WLCOteB5Opd9a6xrza+G1+a1JjuFCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oC0LAQkN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mLAsF/WF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oC0LAQkN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mLAsF/WF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6CA0B1F750;
	Mon,  9 Dec 2024 12:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733747650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yKoMGTX0WH9xW3MOYPJ5M3HH8tgbjYOUEmDPYl8gkcc=;
	b=oC0LAQkNcKA8FIXw+Nt4BP+7vVCXwQ32sRJ+1zf5O0uCg5SYNcwLpaC3S7WX2VkKk/7m9h
	qvDt/jPLPgSUbYbDslwQHD+Ga2HFU53eq1TG31K+L8W8TPmCDi81wmhnUbadJNVkhBYPk8
	BoFK5qR5dPtYV407P1XXs3FXIV6kPxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733747650;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yKoMGTX0WH9xW3MOYPJ5M3HH8tgbjYOUEmDPYl8gkcc=;
	b=mLAsF/WF628ILUGDb0pOPpJ4u5cl/a3XQJkH6wYIFkqdA1dpK5nUsx+e0Y3+SIbKd+AP06
	PH+7JMKjGWzBz3Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733747650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yKoMGTX0WH9xW3MOYPJ5M3HH8tgbjYOUEmDPYl8gkcc=;
	b=oC0LAQkNcKA8FIXw+Nt4BP+7vVCXwQ32sRJ+1zf5O0uCg5SYNcwLpaC3S7WX2VkKk/7m9h
	qvDt/jPLPgSUbYbDslwQHD+Ga2HFU53eq1TG31K+L8W8TPmCDi81wmhnUbadJNVkhBYPk8
	BoFK5qR5dPtYV407P1XXs3FXIV6kPxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733747650;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yKoMGTX0WH9xW3MOYPJ5M3HH8tgbjYOUEmDPYl8gkcc=;
	b=mLAsF/WF628ILUGDb0pOPpJ4u5cl/a3XQJkH6wYIFkqdA1dpK5nUsx+e0Y3+SIbKd+AP06
	PH+7JMKjGWzBz3Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 600F2138A5;
	Mon,  9 Dec 2024 12:34:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id foVlF8LjVmcPWwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Dec 2024 12:34:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E859CA0B0C; Mon,  9 Dec 2024 13:34:05 +0100 (CET)
Date: Mon, 9 Dec 2024 13:34:05 +0100
From: Jan Kara <jack@suse.cz>
To: "Aithal, Srikanth" <sraithal@amd.com>
Cc: Klara Modin <klarasmodin@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org,
	torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-ext4@vger.kernel.org,
	Linux-Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH v8 16/19] fsnotify: generate pre-content permission event
 on page fault
Message-ID: <20241209123405.n7rwqtblqgy5p3bw@quack3>
References: <cover.1731684329.git.josef@toxicpanda.com>
 <aa56c50ce81b1fd18d7f5d71dd2dfced5eba9687.1731684329.git.josef@toxicpanda.com>
 <5d0cd660-251c-423a-8828-5b836a5130f9@gmail.com>
 <e9f65f75-7f0c-423f-9fd4-b29dd006852b@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9f65f75-7f0c-423f-9fd4-b29dd006852b@amd.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,toxicpanda.com,fb.com,vger.kernel.org,suse.cz,kernel.org,linux-foundation.org,zeniv.linux.org.uk,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Mon 09-12-24 16:15:32, Aithal, Srikanth wrote:
> On 12/8/2024 10:28 PM, Klara Modin wrote:
> > Hi,
> > 
> > On 2024-11-15 16:30, Josef Bacik wrote:
> > > FS_PRE_ACCESS or FS_PRE_MODIFY will be generated on page fault depending
> > > on the faulting method.
> > > 
> > > This pre-content event is meant to be used by hierarchical storage
> > > managers that want to fill in the file content on first read access.
> > > 
> > > Export a simple helper that file systems that have their own ->fault()
> > > will use, and have a more complicated helper to be do fancy things with
> > > in filemap_fault.
> > > 
> > 
> > This patch (0790303ec869d0fd658a548551972b51ced7390c in next-20241206)
> > interacts poorly with some programs which hang and are stuck at 100 %
> > sys cpu usage (examples of programs are logrotate and atop with root
> > privileges).
> > 
> > I also retested the new version on Jan Kara's for_next branch and it
> > behaves the same way.
> 
> From linux-next20241206 onward we started hitting issues where KVM guests
> running kernel > next20241206 on AMD platforms fails to shutdown, hangs
> forever with below errors:

Thanks for report! This was discussed in [1] and I've just pushed out a
branch which has this bug fixed.

[1] https://lore.kernel.org/all/20241208152520.3559-1-spasswolf@web.de

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

