Return-Path: <linux-fsdevel+bounces-34614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AFC9C6C38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 10:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B9D1F2277C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 09:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646E01F8189;
	Wed, 13 Nov 2024 09:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Bb8esX97";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ziKQf3u8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Bb8esX97";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ziKQf3u8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4981270810;
	Wed, 13 Nov 2024 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491950; cv=none; b=A0StwdGTeixAbObkUwV4cihL4Nf2NipZIFhkz7XZ+7hdqOmPrUb7ItJRE57pnjyhpuqQF/sx1yhikif7RSLwQPV6oGscsmMqWL0A4mQZBXNmgd/U5poVb7i9lX5b4SHiKDEtMumDp8z4w9i6d+XuP574/XAbd2mMmv03NXviJv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491950; c=relaxed/simple;
	bh=wlwWQyqgfigOHFnC0igPH4x4lNhtgTSCJVyarREClJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eEUevhnoT/UxKbicL/GSJ5e026MGMR+C6gGXA5FF1jvD23w4dwamGgdK3w8KBK1+PwxVQp8/jQLYf3rfxKazr5Rdn1tjEApqOBPhaUeg5XUqKEOW4Q8P8GvH73SKfQrYfmDjmFfVmpSDULDnyR1H2ZjiEJDFfTqm6LBkmaF95eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Bb8esX97; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ziKQf3u8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Bb8esX97; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ziKQf3u8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6A9C3211D6;
	Wed, 13 Nov 2024 09:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731491947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qpEmq55StDkj8VQx4RwABnWj7GLEWSpaSNtQkbHJD6w=;
	b=Bb8esX97JwuIMX2YJlCS7CVormU5IIcXtw2nPEF5ErtlCSRBCIgp5mOjTfJJk8DFnX0rhj
	G9JR0YYFoik3WjwKjkpHUnCC6vyLSSfbapiDDfLCfP3QoVFt7If86nPNK3Jw5y6ZmzlOt9
	vO7WBGeOHBO02sHxELOWQWqJmGM++5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731491947;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qpEmq55StDkj8VQx4RwABnWj7GLEWSpaSNtQkbHJD6w=;
	b=ziKQf3u87aHHgnbkE6avHiQcSBD6yzrrucdKFYag9bmcIUVI858+75cA3MEZdtXzHFRXLf
	MhYlH1d0DQP6NBDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731491947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qpEmq55StDkj8VQx4RwABnWj7GLEWSpaSNtQkbHJD6w=;
	b=Bb8esX97JwuIMX2YJlCS7CVormU5IIcXtw2nPEF5ErtlCSRBCIgp5mOjTfJJk8DFnX0rhj
	G9JR0YYFoik3WjwKjkpHUnCC6vyLSSfbapiDDfLCfP3QoVFt7If86nPNK3Jw5y6ZmzlOt9
	vO7WBGeOHBO02sHxELOWQWqJmGM++5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731491947;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qpEmq55StDkj8VQx4RwABnWj7GLEWSpaSNtQkbHJD6w=;
	b=ziKQf3u87aHHgnbkE6avHiQcSBD6yzrrucdKFYag9bmcIUVI858+75cA3MEZdtXzHFRXLf
	MhYlH1d0DQP6NBDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AD6613A6E;
	Wed, 13 Nov 2024 09:59:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tZ5AAmt4NGd3GgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 13 Nov 2024 09:59:07 +0000
Message-ID: <25631870-851f-44bd-b214-8d7d451cb8a5@suse.de>
Date: Wed, 13 Nov 2024 10:59:06 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 8/8] bdev: use bdev_io_min() for statx block size
To: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org, hch@lst.de,
 david@fromorbit.com, djwong@kernel.org
Cc: john.g.garry@oracle.com, ritesh.list@gmail.com, kbusch@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, gost.dev@samsung.com,
 p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
References: <20241113094727.1497722-1-mcgrof@kernel.org>
 <20241113094727.1497722-9-mcgrof@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241113094727.1497722-9-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,gmail.com,kernel.org,vger.kernel.org,kvack.org,samsung.com,pankajraghav.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On 11/13/24 10:47, Luis Chamberlain wrote:
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
>   block/bdev.c | 1 +
>   fs/stat.c    | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

