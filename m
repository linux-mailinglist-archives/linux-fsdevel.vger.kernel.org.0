Return-Path: <linux-fsdevel+bounces-23181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DFC9281C0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 08:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072A81C22403
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 06:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D6414389F;
	Fri,  5 Jul 2024 06:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Go5sj04F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pJvs4FWV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xImNMRwl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JDzDTsdd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEFE13C909;
	Fri,  5 Jul 2024 06:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720160103; cv=none; b=BBFHp1QW32sW9vGopyfjH7IoA4Poofoab9+E8W+mu3CJA5NjdE86jEH5xDtdVbFL603fMjWEkKKaIMGfONLcKhM6at5CxYikCD8ZKhyEPhRSixcdwDpp4fMY1bYmT7fwbMmFnOUqsLXWRBn333suwUrDeukoSLhGL7/pGbcDiRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720160103; c=relaxed/simple;
	bh=jPR2JjDMNfCATNoOd2r4Sll4jrYq4wIustIOFyUqzA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LIJzQ7I0aN5x0vD/w6wK99dcGBWTOSmGbVBun1PMsa0Qlia6TqnOjyvDi4WkUqJ3/kuZ0ubVHES5wtmah/RT4eMvwx0X0NH2cCuqjv5BvC5eMarMU42OPrk3ZSwO4qbbi2XWWGDAndVE1Y0scQrkaR6cH/Qi5nuJdUZCUezsABQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Go5sj04F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pJvs4FWV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xImNMRwl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JDzDTsdd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BE2DA1F7E2;
	Fri,  5 Jul 2024 06:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720160100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KKKwDM99yHwrFJ4TWN0+ebIfjwuCQsHJVHVl1aMGz+w=;
	b=Go5sj04FniVBY8pReFosHfdGNt0tJY/05WEWhhGISGY/9QLTMCrAlksUnZk94jOFIvLgaV
	MwJB6VXm3CM8IsNcCG+63VEE3YTNua8/3YNPoBX88JxIoi4JXx3Ad0DAH9r/3SDVu7V6jm
	xTnv4UWKukfjfWhjbzR5NIGYlGmrI3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720160100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KKKwDM99yHwrFJ4TWN0+ebIfjwuCQsHJVHVl1aMGz+w=;
	b=pJvs4FWVfFzNpCwuVLANVCiW7x+8fb4wF2WOLrd5rHzDBQUpoNHIGmwI7oeTser3S9It0y
	UnnpAFlDtVwaqUBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xImNMRwl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JDzDTsdd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720160099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KKKwDM99yHwrFJ4TWN0+ebIfjwuCQsHJVHVl1aMGz+w=;
	b=xImNMRwlFRhcIOmUHyxv8kFpjUtEPuEStUOVPVRncG+LL7JfPge/SMWNa/N4R2xjo0SET+
	QZ6IzkrMAgfskNiOUHt/+VidPWUywMuZvWcwOtdQlHcG41BFP8hjKiVI9obDTDkvVEGJr/
	A56IyTun5g2PDBRbEq2ORYR2O61/G7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720160099;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KKKwDM99yHwrFJ4TWN0+ebIfjwuCQsHJVHVl1aMGz+w=;
	b=JDzDTsddavshDpmDdbJUGB67L8yDTKnZZbgiTw5KaNADHgdQN2P3dxIOOH1BI+CG8pgsEU
	YqOJhmJIPka/vLBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF5C713974;
	Fri,  5 Jul 2024 06:14:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TNLcN2KPh2a1FQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 05 Jul 2024 06:14:58 +0000
Message-ID: <da1d2eea-b7b1-467c-84e0-623d4ec3af55@suse.de>
Date: Fri, 5 Jul 2024 08:14:57 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/10] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, willy@infradead.org,
 chandan.babu@oracle.com, djwong@kernel.org, brauner@kernel.org,
 akpm@linux-foundation.org, yang@os.amperecomputing.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, john.g.garry@oracle.com,
 linux-fsdevel@vger.kernel.org, p.raghav@samsung.com, mcgrof@kernel.org,
 gost.dev@samsung.com, cl@os.amperecomputing.com, linux-xfs@vger.kernel.org,
 hch@lst.de, Zi Yan <ziy@nvidia.com>
References: <20240704112320.82104-1-kernel@pankajraghav.com>
 <20240704112320.82104-7-kernel@pankajraghav.com>
 <2c09ebbd-1704-46e3-a453-b4cd07940325@suse.de>
 <ZoceivBuLIcylaxk@dread.disaster.area>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZoceivBuLIcylaxk@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BE2DA1F7E2
X-Spam-Score: -4.50
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,samsung.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On 7/5/24 00:13, Dave Chinner wrote:
> On Thu, Jul 04, 2024 at 05:37:32PM +0200, Hannes Reinecke wrote:
>> On 7/4/24 13:23, Pankaj Raghav (Samsung) wrote:
>>> From: Pankaj Raghav <p.raghav@samsung.com>
>>>
>>> iomap_dio_zero() will pad a fs block with zeroes if the direct IO size
>>> < fs block size. iomap_dio_zero() has an implicit assumption that fs block
>>> size < page_size. This is true for most filesystems at the moment.
>>>
>>> If the block size > page size, this will send the contents of the page
>>> next to zero page(as len > PAGE_SIZE) to the underlying block device,
>>> causing FS corruption.
>>>
>>> iomap is a generic infrastructure and it should not make any assumptions
>>> about the fs block size and the page size of the system.
>>>
>>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>>> ---
>>>    fs/iomap/buffered-io.c |  4 ++--
>>>    fs/iomap/direct-io.c   | 45 ++++++++++++++++++++++++++++++++++++------
>>>    2 files changed, 41 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>>> index f420c53d86acc..d745f718bcde8 100644
>>> --- a/fs/iomap/buffered-io.c
>>> +++ b/fs/iomap/buffered-io.c
>>> @@ -2007,10 +2007,10 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
>>>    }
>>>    EXPORT_SYMBOL_GPL(iomap_writepages);
>>> -static int __init iomap_init(void)
>>> +static int __init iomap_buffered_init(void)
>>>    {
>>>    	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
>>>    			   offsetof(struct iomap_ioend, io_bio),
>>>    			   BIOSET_NEED_BVECS);
>>>    }
>>> -fs_initcall(iomap_init);
>>> +fs_initcall(iomap_buffered_init);
>>> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
>>> index f3b43d223a46e..c02b266bba525 100644
>>> --- a/fs/iomap/direct-io.c
>>> +++ b/fs/iomap/direct-io.c
>>> @@ -11,6 +11,7 @@
>>>    #include <linux/iomap.h>
>>>    #include <linux/backing-dev.h>
>>>    #include <linux/uio.h>
>>> +#include <linux/set_memory.h>
>>>    #include <linux/task_io_accounting_ops.h>
>>>    #include "trace.h"
>>> @@ -27,6 +28,13 @@
>>>    #define IOMAP_DIO_WRITE		(1U << 30)
>>>    #define IOMAP_DIO_DIRTY		(1U << 31)
>>> +/*
>>> + * Used for sub block zeroing in iomap_dio_zero()
>>> + */
>>> +#define IOMAP_ZERO_PAGE_SIZE (SZ_64K)
>>> +#define IOMAP_ZERO_PAGE_ORDER (get_order(IOMAP_ZERO_PAGE_SIZE))
>>> +static struct page *zero_page;
>>> +
>>
>> There are other users of ZERO_PAGE, most notably in fs/direct-io.c and
>> block/blk-lib.c. Any chance to make this available to them?
> 
> Please, no.
> 
> We need to stop feature creeping this patchset and bring it to a
> close. If changing code entirely unrelated to this patchset is
> desired, please do it as a separate independent set of patches.
> 
Agree; it was a suggestion only.

Pankaj, you can add my:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


