Return-Path: <linux-fsdevel+bounces-21517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88890904EB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 11:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27BD82831F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 09:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464EA16D4D7;
	Wed, 12 Jun 2024 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gQtDCGDJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aZ700U5H";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gQtDCGDJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aZ700U5H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327A712B89;
	Wed, 12 Jun 2024 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718182908; cv=none; b=iXEqnYZ7hvQMBh3fanBKSjgAa07UKWPEPFj+/XIJxijMVgMEAfhJMGbvclG4sPoeTqysleZul+ruHMOMIsn7ymmb6e/y6b/Mc6H9rwwaxwv/zvChkwcEx4kpy7g/VWQ22xA0j5Kd7z1e3pbTmbeD7h7MOBG8gZagDugrkzg3nDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718182908; c=relaxed/simple;
	bh=zW95mcY2lDdEt8aWX+3ZUEKduxRjMlZj8PPfH50hswI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sCOD4tKTO4OfM9Zt53m/UCRn4gP5NBvWIbLCmX6Y7T7xKy61o4RVNSVpMZGmJir0CGPFV0KW3ylglOVuaunNZ6XTTm+D9lnKlhkd/wCQJPNDJJBixXLBimwsLwyv5hdfQH7Rl+dAvdLezB9PoGoXo/IDJbDav0ECQBw7A7s7gwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gQtDCGDJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aZ700U5H; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gQtDCGDJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aZ700U5H; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 101A9341E0;
	Wed, 12 Jun 2024 09:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718182905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qX8ubfxWYSG+t5h+vmgwN8Y/8N1fgeclkZq1Y7PRvL8=;
	b=gQtDCGDJ91AEpjFra2kEv+E9IdE+uEMdGDBZhYRKgfhToFVLhSnfY0Cc7hTXQsWcar9nVP
	BXP42YAnFHYDAUqhV0/SELJ/9tWQZRVbLkZc/ILomJvUQEGQ2fd1ecpg3ktm5vwGD6Wzlc
	OxsNr8B9v4KxEKkGRk9iUSGp4tzUQuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718182905;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qX8ubfxWYSG+t5h+vmgwN8Y/8N1fgeclkZq1Y7PRvL8=;
	b=aZ700U5Hv6FRrHXSSqAKdtx8YKmbjderymirydAJB3UnIZnrKPdVGZWSEZ+dvCMljc3H1M
	CErCY/xApYgePKDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718182905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qX8ubfxWYSG+t5h+vmgwN8Y/8N1fgeclkZq1Y7PRvL8=;
	b=gQtDCGDJ91AEpjFra2kEv+E9IdE+uEMdGDBZhYRKgfhToFVLhSnfY0Cc7hTXQsWcar9nVP
	BXP42YAnFHYDAUqhV0/SELJ/9tWQZRVbLkZc/ILomJvUQEGQ2fd1ecpg3ktm5vwGD6Wzlc
	OxsNr8B9v4KxEKkGRk9iUSGp4tzUQuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718182905;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qX8ubfxWYSG+t5h+vmgwN8Y/8N1fgeclkZq1Y7PRvL8=;
	b=aZ700U5Hv6FRrHXSSqAKdtx8YKmbjderymirydAJB3UnIZnrKPdVGZWSEZ+dvCMljc3H1M
	CErCY/xApYgePKDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D15B2137DF;
	Wed, 12 Jun 2024 09:01:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9EKnMvhjaWZqZgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 12 Jun 2024 09:01:44 +0000
Message-ID: <407624c7-5edc-4940-bf71-4134207b1458@suse.de>
Date: Wed, 12 Jun 2024 11:01:44 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/11] filemap: allocate mapping_min_order folios in
 the page cache
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, david@fromorbit.com,
 djwong@kernel.org, chandan.babu@oracle.com, brauner@kernel.org,
 akpm@linux-foundation.org, willy@infradead.org
Cc: mcgrof@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 yang@os.amperecomputing.com, Zi Yan <zi.yan@sent.com>,
 linux-xfs@vger.kernel.org, p.raghav@samsung.com,
 linux-fsdevel@vger.kernel.org, hch@lst.de, gost.dev@samsung.com,
 cl@os.amperecomputing.com, john.g.garry@oracle.com
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-4-kernel@pankajraghav.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240607145902.1137853-4-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[sent.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kvack.org,vger.kernel.org,os.amperecomputing.com,sent.com,samsung.com,lst.de,oracle.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 

On 6/7/24 16:58, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
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
> Co-developed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   include/linux/pagemap.h | 20 ++++++++++++++++++++
>   mm/filemap.c            | 26 ++++++++++++++++++--------
>   2 files changed, 38 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


