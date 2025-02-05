Return-Path: <linux-fsdevel+bounces-40938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982F3A2962A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 17:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3651698A4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 16:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B1F1DAC95;
	Wed,  5 Feb 2025 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NlyeIlie";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w0D9bsN3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NlyeIlie";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w0D9bsN3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEECC149C7B;
	Wed,  5 Feb 2025 16:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738772571; cv=none; b=UNT/EJ6otDGGjraQ6FZDMzQ+iuDlBULKNC7ptlFsMZgCn2NywbE968YXNdkMLDlQCw626gj/4IHt++x6IPPO38wROd2HGinAZ5PS1gx8xWhKjS2SuJRi5PcimHiqXt/O6eSxV8Jf8TTBTWT+Uwtz/+SkMpTcpl1oPN0pJhmyxlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738772571; c=relaxed/simple;
	bh=9zhWYVb4Km8Z9iAZLi/06ouR3Xmii85bJZ0dlL5aJZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QcNgO8WPh6tXuoWBj1D78jX+ZhoUYHTzLjjoGtGsvyp78TqmnKshuDiTregyshAiH8c3aUr/oPDKSvTFxuiXfqZgcS3kac8nHfWCgoERhFY1UL1uXk4HEex1GEZvsFGda5In+orS6fZxWbAkKiDW/0kdZDE/b7qlX2wlDUwRJQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NlyeIlie; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w0D9bsN3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NlyeIlie; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w0D9bsN3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F35A11F7D0;
	Wed,  5 Feb 2025 16:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738772568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W/PHZfJGXEJCwO2dsYXIfWE3RrvRzWPKdAp7DcUJxQQ=;
	b=NlyeIlieMQryK18Ud1UnidQEZ/EGOS7TLNr8RFTPwar32cJQSfgEQ8aAcMMtyMXHwgwTzK
	7SewcjZyBXpd19Ua0vGcbMtIzA/h57zkGVPhXeF5YBxJEODxWu98g04nKw4o+WKPh/6Tts
	SgU+TB2nnJMgGaQv+99UClmRhmYSbwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738772568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W/PHZfJGXEJCwO2dsYXIfWE3RrvRzWPKdAp7DcUJxQQ=;
	b=w0D9bsN3drjgKq6sN6UyZ1okakMldAzzI2YQEfd8hD/Vw0HsjTrdR/PH/z99b+oIaX0Rlf
	GStPskKMWbjjVwBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NlyeIlie;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=w0D9bsN3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738772568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W/PHZfJGXEJCwO2dsYXIfWE3RrvRzWPKdAp7DcUJxQQ=;
	b=NlyeIlieMQryK18Ud1UnidQEZ/EGOS7TLNr8RFTPwar32cJQSfgEQ8aAcMMtyMXHwgwTzK
	7SewcjZyBXpd19Ua0vGcbMtIzA/h57zkGVPhXeF5YBxJEODxWu98g04nKw4o+WKPh/6Tts
	SgU+TB2nnJMgGaQv+99UClmRhmYSbwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738772568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W/PHZfJGXEJCwO2dsYXIfWE3RrvRzWPKdAp7DcUJxQQ=;
	b=w0D9bsN3drjgKq6sN6UyZ1okakMldAzzI2YQEfd8hD/Vw0HsjTrdR/PH/z99b+oIaX0Rlf
	GStPskKMWbjjVwBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8947E13694;
	Wed,  5 Feb 2025 16:22:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SY8QIFeQo2f5NAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 05 Feb 2025 16:22:47 +0000
Message-ID: <9644cd31-1254-4384-b108-94e74629bd90@suse.de>
Date: Wed, 5 Feb 2025 17:22:47 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] bdev: use bdev_io_min() for statx block size
To: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org,
 dave@stgolabs.net, david@fromorbit.com, djwong@kernel.org, kbusch@kernel.org
Cc: john.g.garry@oracle.com, hch@lst.de, ritesh.list@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, gost.dev@samsung.com,
 p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
References: <20250204231209.429356-1-mcgrof@kernel.org>
 <20250204231209.429356-9-mcgrof@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250204231209.429356-9-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F35A11F7D0
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[oracle.com,lst.de,gmail.com,vger.kernel.org,kvack.org,samsung.com,pankajraghav.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 2/5/25 00:12, Luis Chamberlain wrote:
> You can use lsblk to query for a block device block device block size:
> 
> lsblk -o MIN-IO /dev/nvme0n1
> MIN-IO
>   4096
> 
> The min-io is the minimum IO the block device prefers for optimal
> performance. In turn we map this to the block device block size.
> The current block size exposed even for block devices with an
> LBA format of 16k is 4k. Likewise devices which support 4k LBA format
> but have a larger Indirection Unit of 16k have an exposed block size
> of 4k.
> 
> This incurs read-modify-writes on direct IO against devices with a
> min-io larger than the page size. To fix this, use the block device
> min io, which is the minimal optimal IO the device prefers.
> 
> With this we now get:
> 
> lsblk -o MIN-IO /dev/nvme0n1
> MIN-IO
>   16384
> 
> And so userspace gets the appropriate information it needs for optimal
> performance. This is verified with blkalgn against mkfs against a
> device with LBA format of 4k but an NPWG of 16k (min io size)
> 
> mkfs.xfs -f -b size=16k  /dev/nvme3n1
> blkalgn -d nvme3n1 --ops Write
> 
>       Block size          : count     distribution
>           0 -> 1          : 0        |                                        |
>           2 -> 3          : 0        |                                        |
>           4 -> 7          : 0        |                                        |
>           8 -> 15         : 0        |                                        |
>          16 -> 31         : 0        |                                        |
>          32 -> 63         : 0        |                                        |
>          64 -> 127        : 0        |                                        |
>         128 -> 255        : 0        |                                        |
>         256 -> 511        : 0        |                                        |
>         512 -> 1023       : 0        |                                        |
>        1024 -> 2047       : 0        |                                        |
>        2048 -> 4095       : 0        |                                        |
>        4096 -> 8191       : 0        |                                        |
>        8192 -> 16383      : 0        |                                        |
>       16384 -> 32767      : 66       |****************************************|
>       32768 -> 65535      : 0        |                                        |
>       65536 -> 131071     : 0        |                                        |
>      131072 -> 262143     : 2        |*                                       |
> Block size: 14 - 66
> Block size: 17 - 2
> 
>       Algn size           : count     distribution
>           0 -> 1          : 0        |                                        |
>           2 -> 3          : 0        |                                        |
>           4 -> 7          : 0        |                                        |
>           8 -> 15         : 0        |                                        |
>          16 -> 31         : 0        |                                        |
>          32 -> 63         : 0        |                                        |
>          64 -> 127        : 0        |                                        |
>         128 -> 255        : 0        |                                        |
>         256 -> 511        : 0        |                                        |
>         512 -> 1023       : 0        |                                        |
>        1024 -> 2047       : 0        |                                        |
>        2048 -> 4095       : 0        |                                        |
>        4096 -> 8191       : 0        |                                        |
>        8192 -> 16383      : 0        |                                        |
>       16384 -> 32767      : 66       |****************************************|
>       32768 -> 65535      : 0        |                                        |
>       65536 -> 131071     : 0        |                                        |
>      131072 -> 262143     : 2        |*                                       |
> Algn size: 14 - 66
> Algn size: 17 - 2
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   block/bdev.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

