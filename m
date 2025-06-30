Return-Path: <linux-fsdevel+bounces-53367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B64AEE171
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 16:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11DE162DE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 14:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED25428BABC;
	Mon, 30 Jun 2025 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VZg5sQIn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PSvrM6h9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TOgBsRxz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b3Bn/zDC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEB728B7E4
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295021; cv=none; b=Ge0e0u3OnbkOb3VuNI/kR2ZuJhLDDio0+lMt+Xi8rYsbYn/3hJHWYlWoyYo2zUr917kvOLQEaJpue2dUM0pchP7+fIhP/afRggmWmgK223IUj2do2wUpVQKweTMJ/WZqlzEdHbzfo+kD6zOubATCV9xH6Zm72PL4CpkZQuk5Tas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295021; c=relaxed/simple;
	bh=+dAEpZRo91pdtfmhAPV3SqRQOarpalJEp2oxNxmfTKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9uIeBZHNMqmEaq6QcWQHGX0HbkNvywTns/KeoAkgSgc8SK68hbVkaD5xKN0u/EIrYs5zMBMb6zD2NEVuk11JkcFWzz2gOapgmOnFc5pg4CIeXRWwNH1rRd+TtYOXRRITUCzvbft0m7W48PbKo34wVrjH/hTfMd9ifuTXGtv9Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VZg5sQIn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PSvrM6h9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TOgBsRxz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b3Bn/zDC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E1BA21F445;
	Mon, 30 Jun 2025 14:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751295018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ByqbtTrSC6loQv9Cpy/f+s5HphMW01W4ieH1Q0Bz0M=;
	b=VZg5sQInvscZEurP8SHsRrJbgCQpuOnFL1EAHlV424McFH6S/D2mT5jD6N4/KeEuebRS8n
	Eptqse9Bks4Tc7+q7AXnfkK0WPVoG2xoNBSrhk08g54JUyBiUPA1rsQdHTMbqHkaGaT/em
	UOrpYmZ1rp8ALFwbnq6TRalxeXXXzWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751295018;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ByqbtTrSC6loQv9Cpy/f+s5HphMW01W4ieH1Q0Bz0M=;
	b=PSvrM6h9OvBfYRpcYtPMKvWvFbiITLj1IAs8XOHvvfayIzhXr+z8NXjJkFUjn9WSZH4n96
	jKpdixxAb2IcjTAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751295017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ByqbtTrSC6loQv9Cpy/f+s5HphMW01W4ieH1Q0Bz0M=;
	b=TOgBsRxzy/L11fQJXQLqvEXFh+HnLmGviMcpIhfZYF3lrHnu5MgngtflMxtWWnNc7KKuQY
	V7Z4XwCtrkaJsKRXRjhmfSP/8c5FD2Rk77ZxuuvclDikkQK+u1eOalRmqQZihWWk25rZI5
	6ET/dP0sEA+0KwJtQE/nE8yG5ko701Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751295017;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ByqbtTrSC6loQv9Cpy/f+s5HphMW01W4ieH1Q0Bz0M=;
	b=b3Bn/zDCaCOBeJrR24or5+HQo/PWqDUaHFvygO/6UERcGZAxx3GjHUr7nKkC34VypB3pMv
	KGjPjlIKNRTdhtCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5D5B1399F;
	Mon, 30 Jun 2025 14:50:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id caIvNCmkYmi3dwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 30 Jun 2025 14:50:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5FFFDA0A31; Mon, 30 Jun 2025 16:50:09 +0200 (CEST)
Date: Mon, 30 Jun 2025 16:50:09 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, jack@suse.cz, 
	josef@toxicpanda.com, lesha@meta.com, linux-fsdevel@vger.kernel.org, sargun@meta.com
Subject: Re: [PATCH] fanotify: introduce unique event identifier
Message-ID: <tq2wacm3zv34ijao4grcf2l6sqni6rnflarrfgcvutxbdyj5c3@33osrlevefq3>
References: <CAOQ4uxivt3h80Vzt_Udc1+uYDPr_5HU=E6SB53WXqpuqmo5zEQ@mail.gmail.com>
 <20250629062247.1758376-1-ibrahimjirdeh@meta.com>
 <CAOQ4uxjiSepuQE-oorRFmVmVwOieteh8Nb2pfe5jjV2ud3MMWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjiSepuQE-oorRFmVmVwOieteh8Nb2pfe5jjV2ud3MMWQ@mail.gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

Hi!

I agree expanding fanotify_event_metadata painful. After all that's the
reason why we've invented the additional info records in the first place :).
So I agree with putting the id either in a separate info record or overload
something in fanotify_event_metadata.

On Sun 29-06-25 08:50:05, Amir Goldstein wrote:
> I may have mentioned this before, but I'll bring it up again.
> If we want to overload event->fd with response id I would consider
> allocating response_id with idr_alloc_cyclic() that starts at 256
> and then set event->fd = -response_id.
> We want to skip the range -1..-255 because it is used to report
> fd open errors with FAN_REPORT_FD_ERROR.

I kind of like this. It looks elegant. The only reason I'm hesitating is
that as you mentioned with persistent notifications we'll likely need
64-bit type for identifying event. But OTOH requirements there are unclear
and I can imagine even userspace assigning the ID. In the worst case we
could add info record for this persistent event id. So ok, let's do it as
you suggest.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

