Return-Path: <linux-fsdevel+bounces-20787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A79048D7BB7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 08:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D9E52828E4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 06:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C164F4AEF2;
	Mon,  3 Jun 2024 06:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qokBEjEY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vKuCjHtU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qokBEjEY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vKuCjHtU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D809433AF;
	Mon,  3 Jun 2024 06:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717396747; cv=none; b=OfUOwt8u0QZYHEZTYYJv+rEEdIIwJP6zCzTYj3tPTDf+R0BatTF8wZVjkvdJR0uG4w8460XKh+XAXPLuKUUji+qHoFF1KeeVkq413Ne1S380zRIyyZ7rzMuimpXE56HAX+MJ5BHreSVAz197OQZ2SJbBwNzX0Cgm4FgdZXDKxAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717396747; c=relaxed/simple;
	bh=ZT6dL4d//FjLhDkxode/yAzXBWXhRnvKcaaQGukyPg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1CQFZMkBKhBvwVuUK+aBTAgeGYrjw/6ize7b5QqM+4toAbavp+HyeHi0Zb8gmxKR2j75SF0JR4Q17QSqT39A+rKFCdZoUINhOljJM3wg6NMy4VZWznZOueddDGmqq035xH30BocuQ9Jxb5b7abTu7oLFjbPW1V1pY9aIJHwdbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qokBEjEY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vKuCjHtU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qokBEjEY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vKuCjHtU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9CAED20015;
	Mon,  3 Jun 2024 06:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717396743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/WIwD4qTfaup/BG/pV6m14+Ga7Rz6PNCOD3C8SNn1Q=;
	b=qokBEjEYAu2dP8hhiCZwvB2NmNhle2NdDioW32fu6uoeHAyHZiUaIk0VV0naz7tZMu45Y1
	22mhF4+92OhTw0cT1vVy4kzlXp/8yiJtgIETvpvRf7Gd/e67k+cv1LI+AH4ytalrOikmZh
	TlHkdtfsFv3KS03kOhn26Av40pj6AF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717396743;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/WIwD4qTfaup/BG/pV6m14+Ga7Rz6PNCOD3C8SNn1Q=;
	b=vKuCjHtUAbnxImGJDqqugwXRevbB+wGspEGC4XkzKQKq1Wg21bgN4BNYAlzMkr+RkTag06
	ZBH8RRwXiSStY2CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717396743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/WIwD4qTfaup/BG/pV6m14+Ga7Rz6PNCOD3C8SNn1Q=;
	b=qokBEjEYAu2dP8hhiCZwvB2NmNhle2NdDioW32fu6uoeHAyHZiUaIk0VV0naz7tZMu45Y1
	22mhF4+92OhTw0cT1vVy4kzlXp/8yiJtgIETvpvRf7Gd/e67k+cv1LI+AH4ytalrOikmZh
	TlHkdtfsFv3KS03kOhn26Av40pj6AF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717396743;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/WIwD4qTfaup/BG/pV6m14+Ga7Rz6PNCOD3C8SNn1Q=;
	b=vKuCjHtUAbnxImGJDqqugwXRevbB+wGspEGC4XkzKQKq1Wg21bgN4BNYAlzMkr+RkTag06
	ZBH8RRwXiSStY2CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D339313A93;
	Mon,  3 Jun 2024 06:39:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jkATMQZlXWZrSwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 03 Jun 2024 06:39:02 +0000
Message-ID: <c209f283-5078-4969-a69f-bd6b4fd49274@suse.de>
Date: Mon, 3 Jun 2024 08:39:02 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/11] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Content-Language: en-US
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, david@fromorbit.com,
 chandan.babu@oracle.com, akpm@linux-foundation.org, brauner@kernel.org,
 willy@infradead.org, djwong@kernel.org
Cc: linux-kernel@vger.kernel.org, john.g.garry@oracle.com,
 gost.dev@samsung.com, yang@os.amperecomputing.com, p.raghav@samsung.com,
 cl@os.amperecomputing.com, linux-xfs@vger.kernel.org, hch@lst.de,
 mcgrof@kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20240529134509.120826-1-kernel@pankajraghav.com>
 <20240529134509.120826-8-kernel@pankajraghav.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240529134509.120826-8-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,samsung.com:email,suse.de:email]

On 5/29/24 15:45, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> iomap_dio_zero() will pad a fs block with zeroes if the direct IO size
> < fs block size. iomap_dio_zero() has an implicit assumption that fs block
> size < page_size. This is true for most filesystems at the moment.
> 
> If the block size > page size, this will send the contents of the page
> next to zero page(as len > PAGE_SIZE) to the underlying block device,
> causing FS corruption.
> 
> iomap is a generic infrastructure and it should not make any assumptions
> about the fs block size and the page size of the system.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
> 
> After disucssing a bit in LSFMM about this, it was clear that using a
> PMD sized zero folio might not be a good idea[0], especially in platforms
> with 64k base page size, the huge zero folio can be as high as
> 512M just for zeroing small block sizes in the direct IO path.
> 
> The idea to use iomap_init to allocate 64k zero buffer was suggested by
> Dave Chinner as it gives decent tradeoff between memory usage and efficiency.
> 
> This is a good enough solution for now as moving beyond 64k block size
> in XFS might take a while. We can work on a more generic solution in the
> future to offer different sized zero folio that can go beyond 64k.
> 
> [0] https://lore.kernel.org/linux-fsdevel/ZkdcAsENj2mBHh91@casper.infradead.org/
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


