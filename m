Return-Path: <linux-fsdevel+bounces-34613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AD79C6C60
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 11:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07FBBB2BC0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 09:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F531F9EB9;
	Wed, 13 Nov 2024 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0TlU+W/4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qHOpp8cS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0TlU+W/4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qHOpp8cS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E6A178CC8;
	Wed, 13 Nov 2024 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491874; cv=none; b=Ix3APeh5uj35ikKWdD21GYBId9NTCFF6y6hmnBoTppDCzhw8T4DVk/qRHBN6mYc1cXqwWqJYWXE2ypc1KCe7JxjxAGIfcAO8V+JpnoHmzEFEsVI8oSWK4VGzVwZh260R2+EpU6ZSB7jh8vrBTWen3TK/REuJ3rgCGlHx+IyTtGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491874; c=relaxed/simple;
	bh=kQ1r8ALWrJiDrxw1bG1sUUWrenlEhGmWu6Sw9cNfr3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dCkTKtZk2B4GbQ9ihLmR6e8u1HA5N4tyk9T5Bf0r0Hq31JhOffyXrRh3wN8vWLro9VLjw1xSlTmU1Htputtmy8pw9JhB3aaiYhnWm30o+pk3cMACWNkpAZqd/RP8soCtissgk2M0HklmQqvv6XurJoIc5PekzSrjoZOc1YdxMNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0TlU+W/4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qHOpp8cS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0TlU+W/4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qHOpp8cS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 91407211D6;
	Wed, 13 Nov 2024 09:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731491871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hV5b2CTqSgF2h+VoSWAvQ30MrQovnUdkQI+o+QMCBVY=;
	b=0TlU+W/4bUYp+OByx7+NiiisHCjUfndCfhqSJhZQkJMLn0OUU9WqxgPH1o0/98eMuTxTCQ
	PGpTGnWdh/dPIueFN2n3YKtSvaSlVdJJ8LwlgBWVGNztaYIg93OnGp55u1YFDIiR/9i0gM
	9rtxEcqbiAQ4jb5nk9gHm7Gj5acoXHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731491871;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hV5b2CTqSgF2h+VoSWAvQ30MrQovnUdkQI+o+QMCBVY=;
	b=qHOpp8cSsFXAQyLcVqoXHnxXQtAA/EmyUipW5697pZVksMUNMxCNsDFOamF8lbCm1dM05/
	Yg/jvVRe78G4TXCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731491871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hV5b2CTqSgF2h+VoSWAvQ30MrQovnUdkQI+o+QMCBVY=;
	b=0TlU+W/4bUYp+OByx7+NiiisHCjUfndCfhqSJhZQkJMLn0OUU9WqxgPH1o0/98eMuTxTCQ
	PGpTGnWdh/dPIueFN2n3YKtSvaSlVdJJ8LwlgBWVGNztaYIg93OnGp55u1YFDIiR/9i0gM
	9rtxEcqbiAQ4jb5nk9gHm7Gj5acoXHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731491871;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hV5b2CTqSgF2h+VoSWAvQ30MrQovnUdkQI+o+QMCBVY=;
	b=qHOpp8cSsFXAQyLcVqoXHnxXQtAA/EmyUipW5697pZVksMUNMxCNsDFOamF8lbCm1dM05/
	Yg/jvVRe78G4TXCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67A6813A6E;
	Wed, 13 Nov 2024 09:57:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CF3dGB94NGfzGQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 13 Nov 2024 09:57:51 +0000
Message-ID: <3d9b08b2-b130-49a5-b69f-5b51b27848af@suse.de>
Date: Wed, 13 Nov 2024 10:57:51 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 7/8] nvme: remove superfluous block size check
To: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org, hch@lst.de,
 david@fromorbit.com, djwong@kernel.org
Cc: john.g.garry@oracle.com, ritesh.list@gmail.com, kbusch@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, gost.dev@samsung.com,
 p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
References: <20241113094727.1497722-1-mcgrof@kernel.org>
 <20241113094727.1497722-8-mcgrof@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241113094727.1497722-8-mcgrof@kernel.org>
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
> The block layer already validates proper block sizes with
> blk_validate_block_size() for us so we can remove this now
> superfluous check.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   drivers/nvme/host/core.c | 10 ----------
>   1 file changed, 10 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

