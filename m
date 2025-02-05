Return-Path: <linux-fsdevel+bounces-40937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1383A29626
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 17:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C67233A875E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 16:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227871D932F;
	Wed,  5 Feb 2025 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ye4bvq3F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CZlv4m+P";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="erTbmeJ4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="smB5rklY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51D01ADC7C;
	Wed,  5 Feb 2025 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738772505; cv=none; b=tl6gejsyO9v7TP4dM8tGNA/3WqtdEj3xc3lSS8lNSocdLb6YAK4Q+DLWFkYpNChujBHmcGI5GR2RuI/axe9NixhBNBVjV7OhdbqW0TiHHGiHt/51oZtHulQr25VZbk/Sy9Hkkt2D0j70th2dIriEo6I9ya72W7efVNAGZ4WyRSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738772505; c=relaxed/simple;
	bh=vWp/Bx8cWYhdkLf5mTOoJyzpx1c7pjdtAMoYJY0R01c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bJN3uLMpn8Y0HoSS11Zs27b9UdFHEHlLAY0GxY2FdVnbxwm13r4K022drobQKT2F35mfpN55cfCf/0LKpZZJYpri1mOC27GsBt9VYP1ySLbIA1J31qFMsRI/5Qd5S2ATGsd1+5OWlEYylbWKqIPeW6d4iTYfavHwAmc4GUxvz+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ye4bvq3F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CZlv4m+P; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=erTbmeJ4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=smB5rklY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EF6A321272;
	Wed,  5 Feb 2025 16:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738772502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LZKRf4hu1TJKUdqYoGP0lYzz9Yt524wyOBLfb9oRtc0=;
	b=ye4bvq3Fc/UN8bacw7zzcPmetMjGrEAtmppQH5Iwe8vSdUr05eMj7ry1O6eRhUYPbp2Op+
	cpkXEUWK52QGSpgxPIZtwnZ6q9wDIV85R8VDwly15rReWl1bmEKkqlIuX/09rITW4IDnNb
	41PlwLt6iR/mYpWhb+3YW6WeShPgRAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738772502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LZKRf4hu1TJKUdqYoGP0lYzz9Yt524wyOBLfb9oRtc0=;
	b=CZlv4m+PMRjzfSXjf41smRJj1t0Zn+uFgoerrwuI36MhKBtt+fRSRloDpb1VRYn+3SvMpd
	EubQzC90gGQjiIDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=erTbmeJ4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=smB5rklY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738772501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LZKRf4hu1TJKUdqYoGP0lYzz9Yt524wyOBLfb9oRtc0=;
	b=erTbmeJ4dZ7QfitwTFMH3fGvIctMVder1w4ffNEGSgB87lnqvAjaUkAYDe6+dBahSOlgGw
	jBuaACNSfAwB4vM8ffCvP85lJ0WPYy1Yx41YY64hn9nLxOH02RNGjgpnkWpvDn0rHdI3qv
	gBYLYg8ZcjNU/827MMf8VQQLBEV02Mw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738772501;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LZKRf4hu1TJKUdqYoGP0lYzz9Yt524wyOBLfb9oRtc0=;
	b=smB5rklYOPvLmMZfF5kukqq+1YmiSdKTBoYFmgC4ofJcwcxWiVPCJzAFvpUDUVT8TVCI/d
	Z/wUr7SHSNHb4ZBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65AAE13694;
	Wed,  5 Feb 2025 16:21:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2f6VFxWQo2eqNAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 05 Feb 2025 16:21:41 +0000
Message-ID: <6e1b9506-15a9-4328-9e39-fc2f06992bfc@suse.de>
Date: Wed, 5 Feb 2025 17:21:41 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] fs/buffer fs/mpage: remove large folio restriction
To: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org,
 dave@stgolabs.net, david@fromorbit.com, djwong@kernel.org, kbusch@kernel.org
Cc: john.g.garry@oracle.com, hch@lst.de, ritesh.list@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, gost.dev@samsung.com,
 p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
References: <20250204231209.429356-1-mcgrof@kernel.org>
 <20250204231209.429356-6-mcgrof@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250204231209.429356-6-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EF6A321272
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,lst.de,gmail.com,vger.kernel.org,kvack.org,samsung.com,pankajraghav.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 2/5/25 00:12, Luis Chamberlain wrote:
> Now that buffer-heads has been converted over to support large folios
> we can remove the built-in VM_BUG_ON_FOLIO() checks which prevents
> their use.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   fs/buffer.c | 2 --
>   fs/mpage.c  | 3 ---
>   2 files changed, 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

