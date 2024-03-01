Return-Path: <linux-fsdevel+bounces-13321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5466186E6D1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 18:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C231F222C2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 17:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15DA8495;
	Fri,  1 Mar 2024 17:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MBK5sIsS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vwK5ViTl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MBK5sIsS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vwK5ViTl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07A47468;
	Fri,  1 Mar 2024 17:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312891; cv=none; b=nVGkXCj//yqK9KiLG3kE8Qh1b8Nrv6WiiY4YRPOfncJVZVbgvnM+IMB4AEmTXwv1TT26Oej3SXwb6WGp/E+Vwd/6DDNcqvPgnZYkT/9Ug5kbw6AiSFgNVw3EIroVfyo75V8Tfgvx9wgeWXHJthZg8mV59QS8liKWBdI7u3DJkcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312891; c=relaxed/simple;
	bh=w0uFf7UE97zt2wdqPoLkH+UX7mNIxYfpHO1pyRyDbyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BdsK0A2YXREGL1nPVDV8nBew8VFVD6Zv3ruU4g+PBu2rTeH2KJJ8kudOjnNszoggRQv3CskzhhkmLDqwWfq5+XdhUt7SYRibK9CW5lmOQUuXfHMHUF8ykaEjzqKw0whqWccS266L7/qY7ji8jqtaVM2lJlO3j1Qxd1E0AqnLbso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MBK5sIsS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vwK5ViTl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MBK5sIsS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vwK5ViTl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C041133D2E;
	Fri,  1 Mar 2024 17:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709312887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RqJGuSNtEKivYtKHzuQHc54bH1ErddF8H5FukziJrvY=;
	b=MBK5sIsSId/tyrKP+kU3ieWRHT/L04VfkV/+b/kW3+75gNUaXMlbZnG9aflnFcOdGi/hFB
	s2zEv0uZgHLZVGM5NcskABpjAo3Jq0fL4SSBSWqfeap6xhee/z2erhzJo8n6dPa25bWs3P
	01tmrt/7Da0hD2BV1556vS3lz4gK37A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709312887;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RqJGuSNtEKivYtKHzuQHc54bH1ErddF8H5FukziJrvY=;
	b=vwK5ViTlttLYWkeoRlfCISz9XtLVUYHzTzXugQbfvnv4s0dbCU8plBXOftlTpm1Pht7gRe
	l1CIDNn7krPIJYBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709312887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RqJGuSNtEKivYtKHzuQHc54bH1ErddF8H5FukziJrvY=;
	b=MBK5sIsSId/tyrKP+kU3ieWRHT/L04VfkV/+b/kW3+75gNUaXMlbZnG9aflnFcOdGi/hFB
	s2zEv0uZgHLZVGM5NcskABpjAo3Jq0fL4SSBSWqfeap6xhee/z2erhzJo8n6dPa25bWs3P
	01tmrt/7Da0hD2BV1556vS3lz4gK37A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709312887;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RqJGuSNtEKivYtKHzuQHc54bH1ErddF8H5FukziJrvY=;
	b=vwK5ViTlttLYWkeoRlfCISz9XtLVUYHzTzXugQbfvnv4s0dbCU8plBXOftlTpm1Pht7gRe
	l1CIDNn7krPIJYBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A285613A59;
	Fri,  1 Mar 2024 17:08:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g35fI3YL4mVwGQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 01 Mar 2024 17:08:06 +0000
Message-ID: <1e789901-82a2-40db-b818-cc1c5b6e9ea5@suse.de>
Date: Fri, 1 Mar 2024 18:08:05 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] mm: Support order-1 folios in the page cache
Content-Language: en-US
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc: djwong@kernel.org, mcgrof@kernel.org, linux-mm@kvack.org,
 david@fromorbit.com, akpm@linux-foundation.org, gost.dev@samsung.com,
 linux-kernel@vger.kernel.org, chandan.babu@oracle.com, willy@infradead.org
References: <20240301164444.3799288-1-kernel@pankajraghav.com>
 <20240301164444.3799288-2-kernel@pankajraghav.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240301164444.3799288-2-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MBK5sIsS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vwK5ViTl
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.54 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.04)[59.09%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -1.54
X-Rspamd-Queue-Id: C041133D2E
X-Spam-Flag: NO

On 3/1/24 17:44, Pankaj Raghav (Samsung) wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Folios of order 1 have no space to store the deferred list.  This is
> not a problem for the page cache as file-backed folios are never
> placed on the deferred list.  All we need to do is prevent the core
> MM from touching the deferred list for order 1 folios and remove the
> code which prevented us from allocating order 1 folios.
> 
> Link: https://lore.kernel.org/linux-mm/90344ea7-4eec-47ee-5996-0c22f42d6a6a@google.com/
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   include/linux/huge_mm.h |  7 +++++--
>   mm/filemap.c            |  2 --
>   mm/huge_memory.c        | 23 ++++++++++++++++++-----
>   mm/internal.h           |  4 +---
>   mm/readahead.c          |  3 ---
>   5 files changed, 24 insertions(+), 15 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


