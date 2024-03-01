Return-Path: <linux-fsdevel+bounces-13322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2428B86E6D9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 18:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4633B1C22B29
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 17:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4CC125CB;
	Fri,  1 Mar 2024 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aNj5NV/2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="brc49zDQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E6cyCfal";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tSXpszqa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E891021112;
	Fri,  1 Mar 2024 17:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312948; cv=none; b=MJki/03KoyCKgmYW+ZI98clmqCMsfZo9saGzVdg8z6lMaf7YGK2duGWr02d/uVLdLDDhJRsoCbgZgE/uYDmRbtyIGzm+M27RBAmcwlbMgm1EtE2w5kPGOohTE48GJofdWUyHOI1dvZHtusgpLlO2MZqUlqKkbkI450Nj11rU4Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312948; c=relaxed/simple;
	bh=BXAWhqT1NINKyMulHYOUhy26KyU4FBqgT5+WH6Vgf3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uelvWw8ghzgom5KQ2UO0TvE06fDpaK48LBzr1vpVjwd1BBLBHRuEEKGEQrxucYAOTLKMOxf/8BlcHbf9pQV0diuXIXyG6JJikJcdCbwA+R+3K1oGJ24gmXPiMD6Wt0JjRob+FTxmp4H576WfLxZqMrRmY6EbqKzSJrE92gDmjPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aNj5NV/2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=brc49zDQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E6cyCfal; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tSXpszqa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D4BD6207BD;
	Fri,  1 Mar 2024 17:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709312945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=689mBZGhGQUfWa8VF+TWtCsA1pVDyrfLSy6HHpUKbGs=;
	b=aNj5NV/2TsPNIpp8peTlN/rk60soZcwTTwHMHYm22eZKR4dADVXjXf/gFFIKnTFBvjvmJT
	VwQQujjq3MA1r6XqfDzv9LDpYViUh0EWMD3mIhsnxWFqUVFA0Cl0ronQWmIlfkxkqMIMDj
	xg0iwDlG0j0P4b5Ywlgg0jMUSdRAPdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709312945;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=689mBZGhGQUfWa8VF+TWtCsA1pVDyrfLSy6HHpUKbGs=;
	b=brc49zDQKjpgLipit4Y8pHygcJqL5kAQR9JM04C/sWU2OmaiAGI5b87ucuFykmt29+V2Ob
	KEUE665ntsyjVCDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709312944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=689mBZGhGQUfWa8VF+TWtCsA1pVDyrfLSy6HHpUKbGs=;
	b=E6cyCfalcoZAdEfZBxgq3fb7aPh6ewpF1uWo6JIlJ3MIW47kewWeWifp5RC0WTaY37vxab
	G27etjBjoPx4z6nkhJUKmw0GoZDVsnyS3FUEOs253kBjZOjv9ESKNCbtfShNcnhh3TXbI6
	wXhnaCbmHxctUnmnbMi8xcWcPngFeNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709312944;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=689mBZGhGQUfWa8VF+TWtCsA1pVDyrfLSy6HHpUKbGs=;
	b=tSXpszqaRek2+cn4bE7MJMw7xTwFXq/QrVhkEQeWw3MpdC/xOYRawc76CrCIbgn+t/SykM
	U75PYk69pF9GYaAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99D0813A59;
	Fri,  1 Mar 2024 17:09:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CEgAI68L4mVwGQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 01 Mar 2024 17:09:03 +0000
Message-ID: <260e8b4a-429f-4b63-bb13-0161dcf7a61e@suse.de>
Date: Fri, 1 Mar 2024 18:09:03 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] fs: Allow fine-grained control of folio sizes
Content-Language: en-US
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc: djwong@kernel.org, mcgrof@kernel.org, linux-mm@kvack.org,
 david@fromorbit.com, akpm@linux-foundation.org, gost.dev@samsung.com,
 linux-kernel@vger.kernel.org, chandan.babu@oracle.com, willy@infradead.org,
 Pankaj Raghav <p.raghav@samsung.com>
References: <20240301164444.3799288-1-kernel@pankajraghav.com>
 <20240301164444.3799288-3-kernel@pankajraghav.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240301164444.3799288-3-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=E6cyCfal;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tSXpszqa
X-Spamd-Result: default: False [-1.52 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.22)[89.38%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D4BD6207BD
X-Spam-Level: 
X-Spam-Score: -1.52
X-Spam-Flag: NO

On 3/1/24 17:44, Pankaj Raghav (Samsung) wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Some filesystems want to be able to ensure that folios that are added to
> the page cache are at least a certain size.
> Add mapping_set_folio_min_order() to allow this level of control.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Co-developed-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   include/linux/pagemap.h | 100 ++++++++++++++++++++++++++++++++--------
>   1 file changed, 80 insertions(+), 20 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


