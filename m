Return-Path: <linux-fsdevel+bounces-37622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D829F483A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 11:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4835416B213
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 10:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909CA1DFE0B;
	Tue, 17 Dec 2024 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OKffFEaN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7ZSEQb9Q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OKffFEaN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7ZSEQb9Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C12B1DFDB5;
	Tue, 17 Dec 2024 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734429606; cv=none; b=YwSO1F1ZD2nZSNG64MY8Rc0imBZmhNXJJ8RiRySJTPRVa1yewRLZosmypxjnnzfVJbkK9og2muf4S+sjLGsXBRU1NM4X+EN4sqs5QaFqkA/N05yln56c5tjjoI+kSlzGrEFEvmoywMnrPipvbNsoqv4L9qyF9VfS89XfCpCDlq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734429606; c=relaxed/simple;
	bh=uzS5wppxs7/28f5he1R7iClIkFFd/mw47XRr25yP9Dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T0N/pEtKePb8jyzHGkcnNxEZHU/0Tar/7FzC4pFqBbsbLxWLyEntOgiccL1hSWWWJ5t+SAhFgVonDiW1/yC6ofKM6f9uYyjZSc4nvc9xaHsY3fsHMgJlY6w5WD+d67ehsFkGo+yskQzO9AJlPMl4aYDXr+iQnB+4AbMFG0fdai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OKffFEaN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7ZSEQb9Q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OKffFEaN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7ZSEQb9Q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7083E210F0;
	Tue, 17 Dec 2024 10:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734429602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IX72Ag/8IIGl3Wz7CEvCFtdkTS0+bzcHv2Ag32FMstU=;
	b=OKffFEaNmRra9tkiQkDgjUYALpxvCaFdWapVG5rp2VNwk99GYSL81o3I0yjkrVLBzZQn2s
	tuO6Zz4d+41b4y1yEIcX47atVTm8vwWQ8sV+SB27MtvyLTmIq3v86IceaIBwpRb5jcCvNJ
	ZLxHDA9Qdw7ESK0Bnk/hDjmtpG7cRpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734429602;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IX72Ag/8IIGl3Wz7CEvCFtdkTS0+bzcHv2Ag32FMstU=;
	b=7ZSEQb9Qs7GAsN/oCt9UPlqnJHioqzcFI5uBy7EC7Ol0mxuQhD8wHgHDTwYHBO6FYLVh0V
	PQbtxWFj3KDFu2AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734429602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IX72Ag/8IIGl3Wz7CEvCFtdkTS0+bzcHv2Ag32FMstU=;
	b=OKffFEaNmRra9tkiQkDgjUYALpxvCaFdWapVG5rp2VNwk99GYSL81o3I0yjkrVLBzZQn2s
	tuO6Zz4d+41b4y1yEIcX47atVTm8vwWQ8sV+SB27MtvyLTmIq3v86IceaIBwpRb5jcCvNJ
	ZLxHDA9Qdw7ESK0Bnk/hDjmtpG7cRpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734429602;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IX72Ag/8IIGl3Wz7CEvCFtdkTS0+bzcHv2Ag32FMstU=;
	b=7ZSEQb9Qs7GAsN/oCt9UPlqnJHioqzcFI5uBy7EC7Ol0mxuQhD8wHgHDTwYHBO6FYLVh0V
	PQbtxWFj3KDFu2AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2E8513A3C;
	Tue, 17 Dec 2024 10:00:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1CiIMaFLYWfUOQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 17 Dec 2024 10:00:01 +0000
Message-ID: <b05cb512-16f9-4249-93c2-4f2d44213f7f@suse.de>
Date: Tue, 17 Dec 2024 11:00:01 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 03/11] fs/buffer: add iteration support for
 block_read_full_folio()
To: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org, hch@lst.de,
 dave@stgolabs.net, david@fromorbit.com, djwong@kernel.org
Cc: john.g.garry@oracle.com, ritesh.list@gmail.com, kbusch@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, gost.dev@samsung.com,
 p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
References: <20241214031050.1337920-1-mcgrof@kernel.org>
 <20241214031050.1337920-4-mcgrof@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241214031050.1337920-4-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,gmail.com,kernel.org,vger.kernel.org,kvack.org,samsung.com,pankajraghav.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On 12/14/24 04:10, Luis Chamberlain wrote:
> Provide a helper to iterate on buffer heads on a folio. We do this
> as a preliminary step so to make the subsequent changes easier to
> read. Right now we use an array on stack to loop over all buffer heads
> in a folio of size MAX_BUF_PER_PAGE, however on CPUs where the system
> page size is quite larger like Hexagon with 256 KiB page size support
> this can mean the kernel can end up spewing spews stack growth
> warnings.
> 
> To be able to break this down into smaller array chunks add support for
> processing smaller array chunks of buffer heads at a time. The used
> array size is not changed yet, that will be done in a subsequent patch,
> this just adds the iterator support and logic.
> 
> While at it clarify the booleans used on bh_read_batch_async() and
> how they are only valid in consideration when we've processed all
> buffer-heads of a folio, that is when we're on the last buffer head in
> a folio:
> 
>    * bh_folio_reads
>    * unmapped
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   fs/buffer.c | 130 +++++++++++++++++++++++++++++++++++++---------------
>   1 file changed, 94 insertions(+), 36 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

