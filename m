Return-Path: <linux-fsdevel+bounces-17815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5588B27E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 20:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92B69B224C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 18:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3625414F109;
	Thu, 25 Apr 2024 18:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UGlgywoo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AXiPXVWu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UGlgywoo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AXiPXVWu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA9C14EC41;
	Thu, 25 Apr 2024 18:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714068563; cv=none; b=lJiW5N9SKKlvN6qGGpGZLVX9sCzJRoOn+e9H4fXwoI4Tg22OTGpklYAjYltF9ZcPxmQJ0l5pQwfmhF6iNxp6nkz+76eExkkWwYy0z1OrqECMQ3OSTYJtKbTZYcuyZE90bqJRDgrrU1Lu9/pgh6xm2E2XuXOqqSqPDRbq2F4T704=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714068563; c=relaxed/simple;
	bh=yXvKLKmIqLWNvOzaNLbgdP2/i1gAcTBGQURPG36mRuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gz6V0TWKocD+tnWbI4wCsmcKpGQoB3KtbQvQZuDXNnieATuJfargnbY4jdza660AAlyVXOgyik++85MB1wE/0Bo/M5IDnBli0swqV/GSeMMjhwwNg84ep0Zprs6VFPgO3SVJvrbOfwZV0fgk+clkvYi3kCcM4UF2HiIYeQQPnco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UGlgywoo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AXiPXVWu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UGlgywoo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AXiPXVWu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B0AB45C31F;
	Thu, 25 Apr 2024 18:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714068559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rJjo3xNZICJD137GxpNVfwLznPUTtrqUIQ1GMRoLYwQ=;
	b=UGlgywoof7ZGa3BWHTOMxMqSuT9gZkXPUHrIfe3ctPsJ5EF5fp6vUv+fBBM2BTVCw3Z7By
	J7+Sow3wPBOOuq/WE8EDxrYDf1wTRABm7SJ987gwoqUfL4+eItdUKu/dlDJflWtmxwaKfM
	vEgGc1BPU09MidataNygQnHMnMYETs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714068559;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rJjo3xNZICJD137GxpNVfwLznPUTtrqUIQ1GMRoLYwQ=;
	b=AXiPXVWuv/o2g8Str6W/QApEBuZ7mWESK9hW/aeRboCgERqLpNhNE+/MC1BUA3wY20kV51
	yi6CoT3n99JSPKAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UGlgywoo;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AXiPXVWu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714068559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rJjo3xNZICJD137GxpNVfwLznPUTtrqUIQ1GMRoLYwQ=;
	b=UGlgywoof7ZGa3BWHTOMxMqSuT9gZkXPUHrIfe3ctPsJ5EF5fp6vUv+fBBM2BTVCw3Z7By
	J7+Sow3wPBOOuq/WE8EDxrYDf1wTRABm7SJ987gwoqUfL4+eItdUKu/dlDJflWtmxwaKfM
	vEgGc1BPU09MidataNygQnHMnMYETs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714068559;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rJjo3xNZICJD137GxpNVfwLznPUTtrqUIQ1GMRoLYwQ=;
	b=AXiPXVWuv/o2g8Str6W/QApEBuZ7mWESK9hW/aeRboCgERqLpNhNE+/MC1BUA3wY20kV51
	yi6CoT3n99JSPKAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC15A13991;
	Thu, 25 Apr 2024 18:09:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Yk7tAz+cKmYHPgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 25 Apr 2024 18:09:03 +0000
Message-ID: <4db94c9f-c170-4679-b570-520eb40d6062@suse.de>
Date: Thu, 25 Apr 2024 20:07:48 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] fs: Allow fine-grained control of folio sizes
Content-Language: en-US
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, willy@infradead.org,
 djwong@kernel.org, brauner@kernel.org, david@fromorbit.com,
 chandan.babu@oracle.com, akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-xfs@vger.kernel.org, mcgrof@kernel.org,
 gost.dev@samsung.com, p.raghav@samsung.com
References: <20240425113746.335530-1-kernel@pankajraghav.com>
 <20240425113746.335530-3-kernel@pankajraghav.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240425113746.335530-3-kernel@pankajraghav.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,infradead.org:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B0AB45C31F
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -5.50

On 4/25/24 13:37, Pankaj Raghav (Samsung) wrote:
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
>   include/linux/pagemap.h | 116 +++++++++++++++++++++++++++++++++-------
>   1 file changed, 96 insertions(+), 20 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


