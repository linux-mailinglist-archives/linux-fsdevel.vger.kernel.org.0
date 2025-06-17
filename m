Return-Path: <linux-fsdevel+bounces-51871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5D7ADC762
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 12:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1C617A53AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 10:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E6C2C0323;
	Tue, 17 Jun 2025 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PkOD4Q7p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ozWp7ZwC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PkOD4Q7p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ozWp7ZwC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41602293B53
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 10:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750154507; cv=none; b=gkDguhjc0yHDLCa7sq7W0eXh3n16U0N5I/KH2qmQgdtH1BP17VMlRyVVdpaj5snSGKkWtzXflJQs/nO+8Mxp2kJ2Ex4vb2GjH64mUz0h+/TL5khbSmQ2FslouBoNoyTNudi4xyWJX2ccX+F78kePPmAlWAqRGZyR/cThMAYM4No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750154507; c=relaxed/simple;
	bh=A2LC6GqsevpUwEIgXIpzinCx/FD1mSRECcK3/Nn4/jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9QsfB1OzpVOr5qFBDthU/ML4GqwfYZxsHJf7MWBj/GeJbz/3rzQ9RUnqV2syGPgUftp4Hi7db+nct55UF+2g+gtryZOrApsnwaEwKPbeuWLZX8GDMKR+N/1lYPKd5Xzaln+MmdDgakppzZi5BLeU44kd6NphQVo19MdcG7wAWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PkOD4Q7p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ozWp7ZwC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PkOD4Q7p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ozWp7ZwC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 922E92116E;
	Tue, 17 Jun 2025 10:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750154504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/0/c1jRHbOOi2fD77j9U000fp9UwHVTeX+y2pfe4OJw=;
	b=PkOD4Q7pAl2e21eYnf7PHxPL85v7MJYetKYkBy/x3pDChAUKJSah4YhZT2Un0pvcPlKPPx
	VH0c8qCJc+b2aK5OwTEqDajSjlcyMxtOsYQ0zVtcRGDr29AFKQg4EHYlMt46yk7vyrEJJ+
	8tk9kXgkiT2rnuypxW9RqAxVJ/Z0tco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750154504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/0/c1jRHbOOi2fD77j9U000fp9UwHVTeX+y2pfe4OJw=;
	b=ozWp7ZwCxbEuiBaqap36yKTS4pWdKFkGb9xWtrYHqtLqmTH+iuyyzjq5r+522wG6TbGh6/
	9aiHJDpyNfhvuyDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750154504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/0/c1jRHbOOi2fD77j9U000fp9UwHVTeX+y2pfe4OJw=;
	b=PkOD4Q7pAl2e21eYnf7PHxPL85v7MJYetKYkBy/x3pDChAUKJSah4YhZT2Un0pvcPlKPPx
	VH0c8qCJc+b2aK5OwTEqDajSjlcyMxtOsYQ0zVtcRGDr29AFKQg4EHYlMt46yk7vyrEJJ+
	8tk9kXgkiT2rnuypxW9RqAxVJ/Z0tco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750154504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/0/c1jRHbOOi2fD77j9U000fp9UwHVTeX+y2pfe4OJw=;
	b=ozWp7ZwCxbEuiBaqap36yKTS4pWdKFkGb9xWtrYHqtLqmTH+iuyyzjq5r+522wG6TbGh6/
	9aiHJDpyNfhvuyDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8571A13A69;
	Tue, 17 Jun 2025 10:01:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zriMIAg9UWifFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 17 Jun 2025 10:01:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3A074A29F0; Tue, 17 Jun 2025 12:01:44 +0200 (CEST)
Date: Tue, 17 Jun 2025 12:01:44 +0200
From: Jan Kara <jack@suse.cz>
To: Junxuan Liao <ljx@cs.wisc.edu>
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 1/1] docs/vfs: update references to i_mutex to i_rwsem
Message-ID: <zrxbf3nzuyhv2xt6xof7fn2bodthwiib7sooeknt2cdsivdpiv@qezwyhi3shgo>
References: <666eabb6-6607-47f4-985a-0d25c764b172@cs.wisc.edu>
 <fd087bc3-879f-4444-b4ad-601a3632d138@cs.wisc.edu>
 <fduatokkcmrhtndxbmkcarycto5su7gb7jfkcb53gvzflj5o5a@itnis2jwtdt6>
 <f3eb815b-8c47-4001-b6e6-ec47ae10b288@cs.wisc.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3eb815b-8c47-4001-b6e6-ec47ae10b288@cs.wisc.edu>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Mon 16-06-25 11:21:17, Junxuan Liao wrote:
> 
> 
> On 6/16/25 5:10 AM, Jan Kara wrote:
> > Otherwise the changes look good to me.
> 
> Thanks! Just for clarification, is the __d_move comment accurate? i.e.
> Does it assume the two i_rwsem's are locked in shared mode?

Currently, both i_rwsems are expected to be held exclusively in this case.
Generally anything modifying directory contents must be holding i_rwsem of
that directory exclusively. However note that this is subject to change at
least in some cases with the work Neil Brown is doing [1].

								Honza

[1] https://lore.kernel.org/linux-fsdevel/20250609075950.159417-1-neil@brown.name/
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

