Return-Path: <linux-fsdevel+bounces-56622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EA9B19BD7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 08:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A81189867A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 06:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABE9235045;
	Mon,  4 Aug 2025 06:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1OeUnbRP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RX7Q2XWP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1OeUnbRP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RX7Q2XWP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8267F23372C
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Aug 2025 06:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754290728; cv=none; b=VmZlhnEoUGwoqlPl8JJq145qoeHZpChdyeoqUyT/zGUUE1Ik74E+RuTB4d6fTk9HnbB4tWbpoTZTMla/cYk8Kxdawa66JM7lqL4nMhbcS1AXZrSJ6h8pvwRdSmO1dMu0yKOh07KfddJvwJIkWujt/lw36azmG75svl5jXWYT1Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754290728; c=relaxed/simple;
	bh=5y1x2aDUNvECnPaxmPB++TOu3OVNzGY4Qh51g26l6VI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yksdsuv/5mxI8K5cchXYSF7UPQDlHggZ/ML3Sj98wjCRIOOJcLOAoVililPhrVdHBQns4cBIyVpogJzO12aclHm6pZZUkwIy5qJ1wBckiHswaziOub/YvNkKv1HrmCl40wpeQttkCuYQR2gmxOLo34jVXi7AVKBtilECo/X1Ir8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1OeUnbRP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RX7Q2XWP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1OeUnbRP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RX7Q2XWP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C66801F387;
	Mon,  4 Aug 2025 06:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754290724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1VdSXN5CTvWh9eCYxYGq6Le8A7T8+jX+UqzQdoGN3wQ=;
	b=1OeUnbRPitk8hO9Iy5Axk0JyzcyUfERooiMg8lg5MhISSPROXhOVCifDKtnhP3Gh9yb/3B
	GPgsYxlnM0qeEAlnh5X7BslBTrn4GeVaORYsKVLql8GeJ4sAGew6MvrP1/p59HhRRYGBhs
	yNhlrluEtn3a7e4GFoPiYleGfyBSjG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754290724;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1VdSXN5CTvWh9eCYxYGq6Le8A7T8+jX+UqzQdoGN3wQ=;
	b=RX7Q2XWPSlhiFRsA0jMlPweDbTLEDdsJRlOPDyKhGsoS1GiQvkMicLXEFX73KiAofXFxHp
	rXa5T8OpH8xKlUCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754290724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1VdSXN5CTvWh9eCYxYGq6Le8A7T8+jX+UqzQdoGN3wQ=;
	b=1OeUnbRPitk8hO9Iy5Axk0JyzcyUfERooiMg8lg5MhISSPROXhOVCifDKtnhP3Gh9yb/3B
	GPgsYxlnM0qeEAlnh5X7BslBTrn4GeVaORYsKVLql8GeJ4sAGew6MvrP1/p59HhRRYGBhs
	yNhlrluEtn3a7e4GFoPiYleGfyBSjG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754290724;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1VdSXN5CTvWh9eCYxYGq6Le8A7T8+jX+UqzQdoGN3wQ=;
	b=RX7Q2XWPSlhiFRsA0jMlPweDbTLEDdsJRlOPDyKhGsoS1GiQvkMicLXEFX73KiAofXFxHp
	rXa5T8OpH8xKlUCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62FF0133D1;
	Mon,  4 Aug 2025 06:58:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NkkgFiRakGj9UAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 04 Aug 2025 06:58:44 +0000
Message-ID: <857e1e8f-99c9-4780-96c5-68cdfbdcd310@suse.de>
Date: Mon, 4 Aug 2025 08:58:44 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] blk-integrity: use simpler alignment check
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk, brauner@kernel.org,
 Keith Busch <kbusch@kernel.org>
References: <20250801234736.1913170-1-kbusch@meta.com>
 <20250801234736.1913170-7-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250801234736.1913170-7-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 8/2/25 01:47, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> We're checking length and addresses against the same alignment value, so
> use the more simple iterator check.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   block/bio-integrity.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

