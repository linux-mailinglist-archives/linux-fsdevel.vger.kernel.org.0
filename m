Return-Path: <linux-fsdevel+bounces-36779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A80D99E9420
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 13:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A4D284B7B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 12:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A7612D758;
	Mon,  9 Dec 2024 12:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a8alBplm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aVkAywdg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s7b6X5lY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NZm6wN/j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C268215F6F;
	Mon,  9 Dec 2024 12:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747505; cv=none; b=kbPfNfg7p23HhB6llqCrrY1a9zxdzndfF3hTU+z53h2BGjsf3aO/2toMCafuLapQsZDyHWTQ/skbSqayLQMybf6auohMblKtusaDP6e4kund0m18cdeVDFYqLBB+fBP4KZZJT4SXd0APeWVpDe+OCmOdKc0n7hqkfiFiZJWxysg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747505; c=relaxed/simple;
	bh=ooBiUSoyWrRGklS/Q6R1w9MNMsU4BMtP8Crmur7pA1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qgtn2GNHLNBAIRj2FUpQw5Gzy9h4vUGIK6bw7SFJKgpLCSj8fD7Fu7zSL0lquZn4eA98IF6klxRiJvJpC6evKJ8ud+h7VEByPZo0X1DGh2fL2/H6qoXGcZ1FNs5OEHDAZ/CzE7PWvFvtmA7rRVGhPamWZp3EUbwArTdxlroZDWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a8alBplm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aVkAywdg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s7b6X5lY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NZm6wN/j; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 74C9721187;
	Mon,  9 Dec 2024 12:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733747499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eWEHuKiBS+G2Q7jP9q4X0yWXbPoQTpw0Vark8slFW3s=;
	b=a8alBplmbSs3zbTzX8eZZNimO8rdDKocg8U/ZftHrhulaQJVyGokgXqScAOUXO+cMtMRgQ
	055DhSkux+RfeDOtF5KSHlzfwln95/DTLuR0z0pgTUcSJNsH5/MdvTZoNdbs2pvjCWTsZC
	H5C/EytcKhuG3BxN+2uN1VbFa05nIHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733747499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eWEHuKiBS+G2Q7jP9q4X0yWXbPoQTpw0Vark8slFW3s=;
	b=aVkAywdgczZXpN8VrWfC5Y068pRahTvITxTFm+mdW0pIv4jsu1vMmgxzPQ9dFVcBo8X1oE
	E7Afeeb8vTzWfGCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733747498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eWEHuKiBS+G2Q7jP9q4X0yWXbPoQTpw0Vark8slFW3s=;
	b=s7b6X5lYdWJBir4zFbcEFhbjweSj8Hii8ii09WJ+iDy4oOq6Zda1PtqtWWVyylnLsSynC5
	fO/KFZVitPaIW1J30cNch96iySR8wmJw5mv8ZlUBf+HK8lRjq/Q0+r8h4+uZdRqE+QrtF8
	tvaxW2OcvVij8pUF6SXzvjp3wC1+eVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733747498;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eWEHuKiBS+G2Q7jP9q4X0yWXbPoQTpw0Vark8slFW3s=;
	b=NZm6wN/j7V9DiBem0D+yRqMnHKdoei5QTRGKQmokOFa/RPCjRqpWlHzEQv/oBUc7gpte44
	tLoNk8XF0tKvqfCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F66E138D2;
	Mon,  9 Dec 2024 12:31:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9TVCFyrjVmcoWgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Dec 2024 12:31:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0597DA0B0C; Mon,  9 Dec 2024 13:31:38 +0100 (CET)
Date: Mon, 9 Dec 2024 13:31:37 +0100
From: Jan Kara <jack@suse.cz>
To: Klara Modin <klarasmodin@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, jack@suse.cz, amir73il@gmail.com,
	brauner@kernel.org, torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk, linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v8 16/19] fsnotify: generate pre-content permission event
 on page fault
Message-ID: <20241209123137.o6bzwr35kumi2ksv@quack3>
References: <cover.1731684329.git.josef@toxicpanda.com>
 <aa56c50ce81b1fd18d7f5d71dd2dfced5eba9687.1731684329.git.josef@toxicpanda.com>
 <5d0cd660-251c-423a-8828-5b836a5130f9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d0cd660-251c-423a-8828-5b836a5130f9@gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[toxicpanda.com,fb.com,vger.kernel.org,suse.cz,gmail.com,kernel.org,linux-foundation.org,zeniv.linux.org.uk,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

Hello!

On Sun 08-12-24 17:58:42, Klara Modin wrote:
> On 2024-11-15 16:30, Josef Bacik wrote:
> > FS_PRE_ACCESS or FS_PRE_MODIFY will be generated on page fault depending
> > on the faulting method.
> > 
> > This pre-content event is meant to be used by hierarchical storage
> > managers that want to fill in the file content on first read access.
> > 
> > Export a simple helper that file systems that have their own ->fault()
> > will use, and have a more complicated helper to be do fancy things with
> > in filemap_fault.
> > 
> 
> This patch (0790303ec869d0fd658a548551972b51ced7390c in next-20241206)
> interacts poorly with some programs which hang and are stuck at 100 % sys
> cpu usage (examples of programs are logrotate and atop with root
> privileges).
> 
> I also retested the new version on Jan Kara's for_next branch and it behaves
> the same way.

Thanks for report! What is your kernel config please? I've just fixed a
bug reported by [1] which manifested in the same way with
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=n.

Can you perhaps test with my for_next branch I've just pushed out? Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

