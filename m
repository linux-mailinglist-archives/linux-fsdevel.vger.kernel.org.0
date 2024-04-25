Return-Path: <linux-fsdevel+bounces-17819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F7C8B28C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 21:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2016F1C2100D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 19:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D216152527;
	Thu, 25 Apr 2024 19:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0YexNYzM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R0862Li9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0YexNYzM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R0862Li9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13E4154C05;
	Thu, 25 Apr 2024 19:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071991; cv=none; b=gEj3nHqfa9RnyMhDMvbPn9vphud4l1fgYCBukpN/iaoVWMp2owndGkHlRT/NEfNeHNpGj0WhjPsBecnAbAcjrVDB59C+at007ZcC+EqBAZlpiZnQ4HqVtnDk6XXiyH8oUcYBKzypkwTDgO/8mgGfMEluNaAB8XsidAbLVWdNsy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071991; c=relaxed/simple;
	bh=a3lLnxu3JOvALBsreyZ04GoYTvweQeyY7ZXDvG8whxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lIyuMbRIPUnwToQNtLGq2MrtZBvObExGZxIZdbh1ybbWak/RHXpEHQ0PLBGskmA/KETIDQBcMrS1Uu+YRhe7kZXnC5pYgVLg6R0Y+U/zy5BFtKOQzxwdtQRhK1LpGMQcf98L87J67yiqNKCr9lhF+9wlfsNwPyBJLgoSrcyvZfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0YexNYzM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R0862Li9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0YexNYzM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R0862Li9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0B09B5C463;
	Thu, 25 Apr 2024 19:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714071988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rUU8UU5PmZ6BAV0nPdW+zP5OGRgEga5RTqlWW2DOGPQ=;
	b=0YexNYzMdVdVK6KmKFtKlW0tW5Dh0SMn5zGqEWv9/O6wOTW/qJyf5eGl0BHjvfhrvN2mlw
	8B/oGzzvET4QEmByIUz7L9ZDs3NgB/IhQtfycV1vcw9V/4lXPZ5DoLddMDQBb2unCEZTax
	Yt4qEaenWnwFjJCcYmbP4Q9iVZ2mb6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714071988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rUU8UU5PmZ6BAV0nPdW+zP5OGRgEga5RTqlWW2DOGPQ=;
	b=R0862Li9JnV/Bdzls9zTqffI4a7o2VCOTXah+q+zMjt8x0nyv7sbZr97W2bvhGPK3baLZY
	MFonjPwCihMBqACw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0YexNYzM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=R0862Li9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714071988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rUU8UU5PmZ6BAV0nPdW+zP5OGRgEga5RTqlWW2DOGPQ=;
	b=0YexNYzMdVdVK6KmKFtKlW0tW5Dh0SMn5zGqEWv9/O6wOTW/qJyf5eGl0BHjvfhrvN2mlw
	8B/oGzzvET4QEmByIUz7L9ZDs3NgB/IhQtfycV1vcw9V/4lXPZ5DoLddMDQBb2unCEZTax
	Yt4qEaenWnwFjJCcYmbP4Q9iVZ2mb6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714071988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rUU8UU5PmZ6BAV0nPdW+zP5OGRgEga5RTqlWW2DOGPQ=;
	b=R0862Li9JnV/Bdzls9zTqffI4a7o2VCOTXah+q+zMjt8x0nyv7sbZr97W2bvhGPK3baLZY
	MFonjPwCihMBqACw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB16D1393C;
	Thu, 25 Apr 2024 19:05:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aaj6EompKmYATAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 25 Apr 2024 19:05:45 +0000
Message-ID: <cef0b2db-adea-47f4-b1d8-af5de2316dbe@suse.de>
Date: Thu, 25 Apr 2024 21:04:36 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/11] filemap: allocate mapping_min_order folios in
 the page cache
Content-Language: en-US
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, willy@infradead.org,
 djwong@kernel.org, brauner@kernel.org, david@fromorbit.com,
 chandan.babu@oracle.com, akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-xfs@vger.kernel.org, mcgrof@kernel.org,
 gost.dev@samsung.com, p.raghav@samsung.com
References: <20240425113746.335530-1-kernel@pankajraghav.com>
 <20240425113746.335530-4-kernel@pankajraghav.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240425113746.335530-4-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-5.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0B09B5C463
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -5.50

On 4/25/24 13:37, Pankaj Raghav (Samsung) wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> filemap_create_folio() and do_read_cache_folio() were always allocating
> folio of order 0. __filemap_get_folio was trying to allocate higher
> order folios when fgp_flags had higher order hint set but it will default
> to order 0 folio if higher order memory allocation fails.
> 
> Supporting mapping_min_order implies that we guarantee each folio in the
> page cache has at least an order of mapping_min_order. When adding new
> folios to the page cache we must also ensure the index used is aligned to
> the mapping_min_order as the page cache requires the index to be aligned
> to the order of the folio.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Co-developed-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   mm/filemap.c | 24 +++++++++++++++++-------
>   1 file changed, 17 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


