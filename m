Return-Path: <linux-fsdevel+bounces-44937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD46A6E9B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 07:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4353AB854
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 06:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6DF20468D;
	Tue, 25 Mar 2025 06:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yWw076pz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eE53qwTu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yWw076pz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eE53qwTu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09BEA93D
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 06:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742884947; cv=none; b=fqFZOP/qnHccCQel9+MhFVu0aCjffBtt9o/V9yewTAIqav1vCkN7eMqXK9/+bN9ZDLWXLHdgotCsXLp69jwIKW0jWS8xUL+mkyF4FGzsNSdDhkn9FKzsVrGewofKwWLP6peXLZsfC3U0vE8uV+UrNdtuafLeE+afuq7XNod7BhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742884947; c=relaxed/simple;
	bh=HumAS1jvRZ4ha6GWl14Y+g2ezuCC0Aw6+B4VeiTuRqo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZLKTQQsj8xIz1BUbeevSBKwc4tsyA+AjIe6doDefiE4EcABaRVeNnyky30I5wyVNasS5YRUMXi8B3WrevlM6TaDUwp3rqd6tBAnZwCo8LIZ5XkoKQTtj+S7k0C4pvn2kp3oaKnz/yLBXnVFh61shUY4EzCaYlJ6FgNGVuRS4zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yWw076pz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eE53qwTu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yWw076pz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eE53qwTu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0D52E21179;
	Tue, 25 Mar 2025 06:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742884938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXwI8dfCcwC4g4BUCUZgxrLvKM1Snxm0aSv7x3EVfic=;
	b=yWw076pzQgxu1rGu3pGJJiK3uS1kUhcN0l+dxjgUXioApt3CGt4OJC1QLS93un/klqhnEs
	JWbazHfYw6pJ5hb0ry6bHXjTRTP1foaj0d/PgZEo5WwE6eqigkf0qrtQri0tBUQL0NUdYW
	IEVJouBBZtEzPu8zvMqRGegMsq5SykM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742884938;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXwI8dfCcwC4g4BUCUZgxrLvKM1Snxm0aSv7x3EVfic=;
	b=eE53qwTufrzx0xlgjcug5ixl2lqozCkcSQRofYhV86v39ssDlyDNjwCgb6J67LElRT/swu
	J2dcwtzHEwMw7lDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742884938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXwI8dfCcwC4g4BUCUZgxrLvKM1Snxm0aSv7x3EVfic=;
	b=yWw076pzQgxu1rGu3pGJJiK3uS1kUhcN0l+dxjgUXioApt3CGt4OJC1QLS93un/klqhnEs
	JWbazHfYw6pJ5hb0ry6bHXjTRTP1foaj0d/PgZEo5WwE6eqigkf0qrtQri0tBUQL0NUdYW
	IEVJouBBZtEzPu8zvMqRGegMsq5SykM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742884938;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXwI8dfCcwC4g4BUCUZgxrLvKM1Snxm0aSv7x3EVfic=;
	b=eE53qwTufrzx0xlgjcug5ixl2lqozCkcSQRofYhV86v39ssDlyDNjwCgb6J67LElRT/swu
	J2dcwtzHEwMw7lDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2657B13957;
	Tue, 25 Mar 2025 06:42:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hUDwMkVQ4md/fAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 25 Mar 2025 06:42:13 +0000
Date: Tue, 25 Mar 2025 17:42:03 +1100
From: David Disseldorp <ddiss@suse.de>
To: julian.stecklina@cyberus-technology.de
Cc: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Gao
 Xiang <xiang@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v2 1/9] initrd: remove ASCII spinner
Message-ID: <20250325174203.67398632.ddiss@suse.de>
In-Reply-To: <20250322-initrd-erofs-v2-1-d66ee4a2c756@cyberus-technology.de>
References: <20250322-initrd-erofs-v2-0-d66ee4a2c756@cyberus-technology.de>
	<20250322-initrd-erofs-v2-1-d66ee4a2c756@cyberus-technology.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

> From: Julian Stecklina <julian.stecklina@cyberus-technology.de>
> 
> Writing the ASCII spinner probably costs more cycles than copying the
> block of data on some output devices if you output to serial and in
> all other cases it rotates at lightspeed in 2025.
> 
> Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
> ---
>  init/do_mounts_rd.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
> index ac021ae6e6fa78c7b7828a78ab2fa3af3611bef3..473f4f9417e157118b9a6e582607435484d53d63 100644

Looks good.
Reviewed-by: David Disseldorp <ddiss@suse.de>

Will wait for v3 before looking at the rest of the series.

