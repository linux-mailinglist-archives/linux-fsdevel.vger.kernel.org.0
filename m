Return-Path: <linux-fsdevel+bounces-56618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D44B19BC2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 08:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F40FC1894785
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 06:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AEA235341;
	Mon,  4 Aug 2025 06:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HCeo3dK7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D2yOJ4Ff";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HCeo3dK7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D2yOJ4Ff"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84627230BD5
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Aug 2025 06:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754290479; cv=none; b=RHiaIcE2FuMMwE2ULpiBLxALAjXmx3O7PQ/IS6RcRkbSb++S0cxky1mDw/6DXZBmocOF+LcD6oSXQP1AP69VvCbTj0WN8F47QmuuDE9Afetm2UaM+hJyUMD5FVP9MnAOAMVqgftmY7Q+5TMr3gU9a+r74wtnDPJpdwXqGK3aXB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754290479; c=relaxed/simple;
	bh=TnfmeiNOw/1JKS3awEhbIw4eiRpptN/6dM6jl5VYUaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jmK7a9VvTJ8qGuhZAm08ah3mQVCBpzUcfIE5vIwlnoIDNeacEwioYHMs6YlzcS2bMqT/MRjfMMcLa5Iy4UFgnjdGGM0x2o1rfRx8kav5orE/kb16MeK+Vq786s4GK8Rx43+dxbSIa/9bSzC23Qr1MqKM+ZkTjMyCky9+VonrFIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HCeo3dK7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=D2yOJ4Ff; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HCeo3dK7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=D2yOJ4Ff; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B868A219A2;
	Mon,  4 Aug 2025 06:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754290475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4G9Kq2espEQqv8OsFH5L43G04+i/vBmGmcw+idzChZY=;
	b=HCeo3dK7QrxawIOj9NAbuTBh6yIeAm2RQchn67Q0ibx7fZPUWlHTQRqapLI/FfXzJUSMpm
	J8LG+uisZcm+OrsP6qHFvx7+oG4IGXANwkmUtQ7MMul5oHjriHvpnxzUHh1Xq3O/MbaZpy
	NjDQMRbQNuX94WC0UamoRNG2VBdKnEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754290475;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4G9Kq2espEQqv8OsFH5L43G04+i/vBmGmcw+idzChZY=;
	b=D2yOJ4FfWWw1hl4J64QgAGdDJ+OAi4cHwiFZOLhpM2K0QFRZ603AQQYzFWCMp4TMi+OPGx
	g+cPrKGDcJzOY1Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HCeo3dK7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=D2yOJ4Ff
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754290475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4G9Kq2espEQqv8OsFH5L43G04+i/vBmGmcw+idzChZY=;
	b=HCeo3dK7QrxawIOj9NAbuTBh6yIeAm2RQchn67Q0ibx7fZPUWlHTQRqapLI/FfXzJUSMpm
	J8LG+uisZcm+OrsP6qHFvx7+oG4IGXANwkmUtQ7MMul5oHjriHvpnxzUHh1Xq3O/MbaZpy
	NjDQMRbQNuX94WC0UamoRNG2VBdKnEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754290475;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4G9Kq2espEQqv8OsFH5L43G04+i/vBmGmcw+idzChZY=;
	b=D2yOJ4FfWWw1hl4J64QgAGdDJ+OAi4cHwiFZOLhpM2K0QFRZ603AQQYzFWCMp4TMi+OPGx
	g+cPrKGDcJzOY1Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E827133D1;
	Mon,  4 Aug 2025 06:54:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RQsSFStZkGjDTwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 04 Aug 2025 06:54:35 +0000
Message-ID: <cf845a0e-b8ae-4eef-b6ac-377790771735@suse.de>
Date: Mon, 4 Aug 2025 08:54:34 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] block: check for valid bio while splitting
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk, brauner@kernel.org,
 Keith Busch <kbusch@kernel.org>
References: <20250801234736.1913170-1-kbusch@meta.com>
 <20250801234736.1913170-2-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250801234736.1913170-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: B868A219A2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 8/2/25 01:47, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> We're already iterating every segment, so check alignment for a valid
> IO at the same time. We had depended on these constraints were already
> checked prior to splitting, but let's put more responsibility here since
> splitting iterates each segment before dispatching to the driver anyway.
> This way, upper layers don't need to concern themselves with it.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   block/blk-merge.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

