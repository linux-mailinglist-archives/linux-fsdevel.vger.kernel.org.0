Return-Path: <linux-fsdevel+bounces-21518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 211E0904EBB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 11:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B445B251D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 09:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DE616D9BA;
	Wed, 12 Jun 2024 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Rj67ICHG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xkGj66aV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Rj67ICHG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xkGj66aV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524301649DB;
	Wed, 12 Jun 2024 09:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718182942; cv=none; b=MHXJCasfJVqutqcvKBzfa3+k+VMmQ2nsoPVFF7izI891q5F1E6seKGH4R3/WS19yEnX/p2BdsKyznaC2qA3TF6Sl7wXPPwmyLQce4mLCD+xM4smeOiOV/7BxnDuj3ctS5BUPUpVl0A/te4e0MycYPdGaGvp82op+qiNmx2EZaGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718182942; c=relaxed/simple;
	bh=ibRKaobz/UZqwGXKbA61Jc6xXyGO1MvILukPLB6kjm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l3C6vioQMKBI1TeFIK5itlo58j8euY0G9EUZtbF/o+841yCC495WHJ9nhT0/tywNKTEOQEXzmvhD4lEZdUqWgEJuz4DNxaHHufNAZuSgv2aj7DLcEPgVc7TV9sAd08vvHmRo8IRcf+Wffgiy0+6KAsZAT0O7AKmnqgyXz9swDus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Rj67ICHG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xkGj66aV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Rj67ICHG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xkGj66aV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9CF56341E4;
	Wed, 12 Jun 2024 09:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718182939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QgnupSr7JN0O/SnxpxC6VKWoGAn2LYNz0M7AGvgMP+8=;
	b=Rj67ICHGQtiLmUwvEtdOPuvwEXeqGL9zSJVspfXfvf/t6yLtLiBbiaBsz5DdqLdWK3ZgMU
	8CLYGd9vGYx4HT/i1cdVptHQmK761cnmTjEsAjxASkI+2P8wMBJX8dFhSwgMqfPCjirR+t
	CLwKtid0C8IuL/ogkOtI1kKXaZHjFrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718182939;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QgnupSr7JN0O/SnxpxC6VKWoGAn2LYNz0M7AGvgMP+8=;
	b=xkGj66aV2iNTyFZRAodcfIWjwWUp2Lfshajv+4qTqjt2LuPuUsfO0AGGrZhe76Cp1WjtQk
	JTaUbdoUAepaW+AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Rj67ICHG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xkGj66aV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718182939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QgnupSr7JN0O/SnxpxC6VKWoGAn2LYNz0M7AGvgMP+8=;
	b=Rj67ICHGQtiLmUwvEtdOPuvwEXeqGL9zSJVspfXfvf/t6yLtLiBbiaBsz5DdqLdWK3ZgMU
	8CLYGd9vGYx4HT/i1cdVptHQmK761cnmTjEsAjxASkI+2P8wMBJX8dFhSwgMqfPCjirR+t
	CLwKtid0C8IuL/ogkOtI1kKXaZHjFrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718182939;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QgnupSr7JN0O/SnxpxC6VKWoGAn2LYNz0M7AGvgMP+8=;
	b=xkGj66aV2iNTyFZRAodcfIWjwWUp2Lfshajv+4qTqjt2LuPuUsfO0AGGrZhe76Cp1WjtQk
	JTaUbdoUAepaW+AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 657C0137DF;
	Wed, 12 Jun 2024 09:02:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L20dGBtkaWaVZgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 12 Jun 2024 09:02:19 +0000
Message-ID: <5a6335a6-80b8-4874-b526-a88269f8879f@suse.de>
Date: Wed, 12 Jun 2024 11:02:19 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/11] mm: split a folio in minimum folio order chunks
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, david@fromorbit.com,
 djwong@kernel.org, chandan.babu@oracle.com, brauner@kernel.org,
 akpm@linux-foundation.org, willy@infradead.org
Cc: mcgrof@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 yang@os.amperecomputing.com, Zi Yan <zi.yan@sent.com>,
 linux-xfs@vger.kernel.org, p.raghav@samsung.com,
 linux-fsdevel@vger.kernel.org, hch@lst.de, gost.dev@samsung.com,
 cl@os.amperecomputing.com, john.g.garry@oracle.com
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-6-kernel@pankajraghav.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240607145902.1137853-6-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[sent.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kvack.org,vger.kernel.org,os.amperecomputing.com,sent.com,samsung.com,lst.de,oracle.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9CF56341E4
X-Spam-Flag: NO
X-Spam-Score: -4.50
X-Spam-Level: 

On 6/7/24 16:58, Pankaj Raghav (Samsung) wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> split_folio() and split_folio_to_list() assume order 0, to support
> minorder for non-anonymous folios, we must expand these to check the
> folio mapping order and use that.
> 
> Set new_order to be at least minimum folio order if it is set in
> split_huge_page_to_list() so that we can maintain minimum folio order
> requirement in the page cache.
> 
> Update the debugfs write files used for testing to ensure the order
> is respected as well. We simply enforce the min order when a file
> mapping is used.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   include/linux/huge_mm.h | 14 ++++++++---
>   mm/huge_memory.c        | 55 ++++++++++++++++++++++++++++++++++++++---
>   2 files changed, 61 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


