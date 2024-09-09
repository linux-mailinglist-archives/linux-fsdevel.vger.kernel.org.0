Return-Path: <linux-fsdevel+bounces-28937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1592B971701
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 13:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B1F1F23148
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 11:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3980E1B3B2B;
	Mon,  9 Sep 2024 11:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ngcmSO97";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a8a+uzad";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ngcmSO97";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a8a+uzad"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FD81B3B06;
	Mon,  9 Sep 2024 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725881744; cv=none; b=VfQ7qS2pB00j1kKPADdKxlfR+8a1d4Bkjk+nFMoqMAvS1mqDk37iSzxd7jC7sj1sLlGv3WCgF0n1c24eAajLDNo0SAmWvqdDtPi6MsguoXDPK3WgJgJh7ytFvW3kF4Hz+EHmMwfcYjQH2ke235n7a6w87s1rH2sKaoPj1pGn0Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725881744; c=relaxed/simple;
	bh=GVISnP9UsFGbHZp50x0yE7hLzn+QhRqglpi7z7+GiGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3+1wo4DLbvt1zBa4BPZcZVRjin1hy6IeXutMLpGis8bYsPyrxd/uwa1SE3cP9vFWD+UMrTQvjdVGiXbRTQFtUjINwHVUlEmzzAXxDb06N8d893Mb9j/yv4sn12RlSNCXBXbvHRBwSQubJM9NbsfTS1p+YmzQOnBeh8soMyLRXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ngcmSO97; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a8a+uzad; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ngcmSO97; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a8a+uzad; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B7ABC219A4;
	Mon,  9 Sep 2024 11:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725881739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ButvdY7F6OPDCmhDFHthu8UyYiCQIjhdHWQ6fSxT09o=;
	b=ngcmSO97UnLy/4Z5EokpKnCNF6cNyvDYZ/JY78r+cRNrQ6/7abY1sRjF/C3/zqYvwdHrcp
	Yi/KOwoZoCQ3wgVHjdoUkatOvdcgNIbH/KgmaiUq5s+zBWuFoSEYHVBBUgHk/smX1YbzVN
	8C9w5sciF4wfphyf4GtdK4FbU5T14Bg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725881739;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ButvdY7F6OPDCmhDFHthu8UyYiCQIjhdHWQ6fSxT09o=;
	b=a8a+uzadRsQzgg7k4+X1mzHv6UXsgPLlNeO+t9GYimVEQU7r1fV44UuBD08HylWdh6hhqh
	AAJLnNqzyVGJpYDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ngcmSO97;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=a8a+uzad
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725881739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ButvdY7F6OPDCmhDFHthu8UyYiCQIjhdHWQ6fSxT09o=;
	b=ngcmSO97UnLy/4Z5EokpKnCNF6cNyvDYZ/JY78r+cRNrQ6/7abY1sRjF/C3/zqYvwdHrcp
	Yi/KOwoZoCQ3wgVHjdoUkatOvdcgNIbH/KgmaiUq5s+zBWuFoSEYHVBBUgHk/smX1YbzVN
	8C9w5sciF4wfphyf4GtdK4FbU5T14Bg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725881739;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ButvdY7F6OPDCmhDFHthu8UyYiCQIjhdHWQ6fSxT09o=;
	b=a8a+uzadRsQzgg7k4+X1mzHv6UXsgPLlNeO+t9GYimVEQU7r1fV44UuBD08HylWdh6hhqh
	AAJLnNqzyVGJpYDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC69813312;
	Mon,  9 Sep 2024 11:35:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ekISKovd3mZJNAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Sep 2024 11:35:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5BB49A095F; Mon,  9 Sep 2024 13:35:35 +0200 (CEST)
Date: Mon, 9 Sep 2024 13:35:35 +0200
From: Jan Kara <jack@suse.cz>
To: Paul Moore <paul@paul-moore.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	selinux@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: linux-next commit 0855feef5235 ("fsnotify: introduce pre-content
 permission event")
Message-ID: <20240909113535.vomill5z4v5q47rm@quack3>
References: <CAHC9VhQvbKsSSfGzUGo3e8ov6p-re_Xn_cEbPK0YJ9VhZXP_Bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQvbKsSSfGzUGo3e8ov6p-re_Xn_cEbPK0YJ9VhZXP_Bg@mail.gmail.com>
X-Rspamd-Queue-Id: B7ABC219A4
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[toxicpanda.com,gmail.com,suse.cz,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

Hi Paul!

On Fri 06-09-24 10:42:39, Paul Moore wrote:
> When you are making changes that impact a LSM, or the LSM framework
> itself, especially if they change the permissions/access-controls in
> any way, please make sure you CC the relevant mailing lists.  If you
> are unsure which lists you should CC, please consult MAINTAINERS or
> use the ./scripts/get_maintainer.pl tool.

Well, it didn't occur to me you'd be interested in these changes but you're
right that we've added the new event to a bitmask in
security/selinux/hooks.c so strictly speaking I should have notified you.
I'm sorry for the omission.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

