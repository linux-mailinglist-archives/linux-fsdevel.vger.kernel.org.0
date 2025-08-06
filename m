Return-Path: <linux-fsdevel+bounces-56817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5A0B1C03F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 08:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4940E184D9A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 06:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142C52045B7;
	Wed,  6 Aug 2025 06:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0U1DHySk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GO3KlR1z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0U1DHySk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GO3KlR1z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF2A201266
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 06:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754460437; cv=none; b=frtse5ZEwcE8zKf5a3QQw0nKrojqYbKVdb3yaBhlqKvoGsBq/7bOtiuBww/R/0nUfios7xkIsGL79YQ/y1NBy5i6PTGUx5Wftmvw53xYMZl0+mD1KRLha9nyeossF7JQobWrprlj3g2/XkSejr4pu8D7Qw2V9Bz6bAdbS1sqKI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754460437; c=relaxed/simple;
	bh=8FM1EW4+OjDn0CelmZBE4xOT3kETrikWAt5HFq8PaSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DI1yBA5z+rVyl7QsnBDWfxnwaI9QATTe5Nq4FXoePYAV2saTtVrhU1CLF0tmtfbdewgWnyWasdfTV68CpKJsIFOIZQ/pxlzC6nBk6qLAnwfx/Z+6IdIumLPumbynNbaADtq8TGlqU40DbgcykJrX+cxT11U+wyOKqRfhgxHrl40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0U1DHySk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GO3KlR1z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0U1DHySk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GO3KlR1z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B7F75211E6;
	Wed,  6 Aug 2025 06:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754460433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fafvwWupgiSIXxWpWicWhcdkUYgQ0t7ETx/aETt8RBo=;
	b=0U1DHySkvFph7mD+YvdYZYgu88LzripYg+gCzq17nMMQLNjG9JPqiVe3Zzg1bC7GHrStkZ
	uxFVtCWRiSd70xS1Igvp1DUNt4hGgcTzdqXMDasjcnyAYWUeRUGJRiXJ3sGMDnatyWabFL
	8fgESrwGUnoRughe5C3ko3bbozveZBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754460433;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fafvwWupgiSIXxWpWicWhcdkUYgQ0t7ETx/aETt8RBo=;
	b=GO3KlR1zrwJ0o1upg2hQQYMCwgKwRc7qjfjk5wn4EzfBCXW8Z2NkefHOLfKn0mTyOzbpJL
	7hdyoskys9yokxBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0U1DHySk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GO3KlR1z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754460433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fafvwWupgiSIXxWpWicWhcdkUYgQ0t7ETx/aETt8RBo=;
	b=0U1DHySkvFph7mD+YvdYZYgu88LzripYg+gCzq17nMMQLNjG9JPqiVe3Zzg1bC7GHrStkZ
	uxFVtCWRiSd70xS1Igvp1DUNt4hGgcTzdqXMDasjcnyAYWUeRUGJRiXJ3sGMDnatyWabFL
	8fgESrwGUnoRughe5C3ko3bbozveZBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754460433;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fafvwWupgiSIXxWpWicWhcdkUYgQ0t7ETx/aETt8RBo=;
	b=GO3KlR1zrwJ0o1upg2hQQYMCwgKwRc7qjfjk5wn4EzfBCXW8Z2NkefHOLfKn0mTyOzbpJL
	7hdyoskys9yokxBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EDBE13AB5;
	Wed,  6 Aug 2025 06:07:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HdmcFBHxkmhdXAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 06 Aug 2025 06:07:13 +0000
Message-ID: <2446484c-aed6-4e47-8140-8794cdab05ba@suse.de>
Date: Wed, 6 Aug 2025 08:07:12 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/7] block: align the bio after building it
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk, brauner@kernel.org,
 Keith Busch <kbusch@kernel.org>
References: <20250805141123.332298-1-kbusch@meta.com>
 <20250805141123.332298-3-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250805141123.332298-3-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: B7F75211E6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 8/5/25 16:11, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Instead of ensuring each vector is block size aligned while constructing
> the bio, just ensure the entire size is aligned after it's built. This
> makes it more flexible to accepting device valid io vectors that would
> otherwise get rejected by alignment checks.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   block/bio.c | 60 +++++++++++++++++++++++++++++++++++------------------
>   1 file changed, 40 insertions(+), 20 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

