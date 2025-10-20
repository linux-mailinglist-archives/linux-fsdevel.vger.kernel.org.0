Return-Path: <linux-fsdevel+bounces-64713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9605ABF1E73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 16:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56529421A98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 14:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CD11DE4C2;
	Mon, 20 Oct 2025 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hIN+hw5U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PGvErf38";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wf3MIGlK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aF7gSwkG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F7B148832
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760971520; cv=none; b=dwudGBOnpmV6Zrfo15J0wzySHv7i2Ph62+w9QRGIbZ5bDR2jvwzmVYvgGN3t+jib3F4+mfz0YfzCdEyznENbUrUAud4y8D+pBFLJc0jRk+UpRBNEJb85DNIXzoSSG/Zx12Zhig7YwQ+cQgvno/iRTJjssOxgcpEHWJKay/xh55g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760971520; c=relaxed/simple;
	bh=uPjzAGd0a9HS8zV6Omrr6pLQmcHggE369SJlHnb/hDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZy6BpWTLgXkApRILXHtVPWAasGwAiuQzl3XP3eWBD7dgMJngUvYb2iXlQc8qNH4Ps/G9y0X652zMSmOiy1/VD84KAJW03nt4LDoyqccxuIg7KqOSKqj6zk8I5Hl5CGmX+KXppqZW4pUbQJXWN2RlEJnoN91aZdPKTEjmXGx/vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hIN+hw5U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PGvErf38; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wf3MIGlK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aF7gSwkG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DFB631F385;
	Mon, 20 Oct 2025 14:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760971513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uPjzAGd0a9HS8zV6Omrr6pLQmcHggE369SJlHnb/hDA=;
	b=hIN+hw5U5J5eSZdRlWSpYcNfQd8ddptSmB/0qQVjR/hEoUiE9kqfu9i1r1XDgqy0tQ/Eoz
	3zhQYuhc0YB++e7QbTv9ioiKP9ZCgzSGHEjX6aB9Z0BxIhzTs4RKPLl5mZe4rWJsfJQIWO
	q2qUiL3daXrPhgCFoM73MRDGAsVYPvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760971513;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uPjzAGd0a9HS8zV6Omrr6pLQmcHggE369SJlHnb/hDA=;
	b=PGvErf38E2RSTnxvHl6TT9SwqvOat+XfjLgSB04MRNQaOT5OZ+fu6miMUHoEoRQKbw2fkC
	u88duyjOjRifzsDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wf3MIGlK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aF7gSwkG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760971508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uPjzAGd0a9HS8zV6Omrr6pLQmcHggE369SJlHnb/hDA=;
	b=wf3MIGlK9UG/Pc4kKtSJaTOw3KcUU+U9EVGP0IvsRfqF4EZW7MbZbqxCraJ+49Yd8t8wnR
	k9HbNJUEOOtqgUcwB5/pWcOdZqMMYSvwGbGYSJDtLObqwhJjwzJ9AJZwnAWBv1Dy1Pneqh
	kJHxBSPTN+K1kmab+9Rvh3tolXuRQv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760971508;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uPjzAGd0a9HS8zV6Omrr6pLQmcHggE369SJlHnb/hDA=;
	b=aF7gSwkGn+4J5+pd5CnDwLiqjF6uEK7XL5SkUYHDWAAm9QEb6kqD46q4YmKau1/VaHUjdS
	PprJ7VUTkKb3VsAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D8F213A8E;
	Mon, 20 Oct 2025 14:45:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5ZK4DfRK9mghMwAAD6G6ig
	(envelope-from <ematsumiya@suse.de>); Mon, 20 Oct 2025 14:45:08 +0000
Date: Mon, 20 Oct 2025 11:45:02 -0300
From: Enzo Matsumiya <ematsumiya@suse.de>
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Fix TCP_Server_Info::credits to be signed
Message-ID: <p6vfujqnba3rxuifaouccuuhonhyupsu554cdnlx45fvboggku@5h7gaicp4opp>
References: <vmbhu5djhw2fovzwpa6dptuthwocmjc5oh6vsi4aolodstmqix@4jv64tzfe3qp>
 <1006942.1760950016@warthog.procyon.org.uk>
 <1158747.1760969306@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1158747.1760969306@warthog.procyon.org.uk>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: DFB631F385
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.01

On 10/20, David Howells wrote:
>Enzo Matsumiya <ematsumiya@suse.de> wrote:
>
>> Both semantically and technically, credits shouldn't go negative.
>> Shouldn't those other fields/functions become unsigned instead?
>
>That's really a question for Steve, but it makes it easier to handle
>underflow

But if there's an overflow somewhere the math should be checked instead
(I never seen it happen though).

> and I'm guessing that the maximum credits isn't likely to exceed
>2G.

Yes, it's capped at 60-65k (depends on the function...)
So yes, an unsigned short would be fine.


Cheers,

Enzo

