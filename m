Return-Path: <linux-fsdevel+bounces-22113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AECDD9126AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 15:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F8B289150
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 13:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93D2155C9B;
	Fri, 21 Jun 2024 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T5iKPGsh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/Dq6fTzn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T5iKPGsh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/Dq6fTzn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4551586CB;
	Fri, 21 Jun 2024 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718976490; cv=none; b=P5VXHB309NUPVWp4aUsVrh20+oF0JB/bwpdr3OGXNl1nLehz6guEp/ypFrrpF8cpdVoyQOA2A39wi29NdZPQ9jThFa+I+0sA8Gtr6Vmf3k/SD1Ql+hYriyncuvI5NSFhJFabJ7LltCE6FJe7zvVRegEfVY7kc8ZM0ahsLWgKSc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718976490; c=relaxed/simple;
	bh=9sUiGG1pdsYhTI5e99Pry3JMsbAJCkFt5Cx5Twn+El0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvZ9F29Utsmo26U8TdbyHrtkqwYpBOHqn93dm7dPu2EPlGZFxTj6EhcSsj7rKSBuu1GOEEyt+NMaasFyIQ9L4iKFneaFWGmIXnQOO0biK4JKIyFvDbgVJqhQx853diZqbc2ChCyMkco6YC7F6llYUvkeXYZAPAfUlpvblzyoBBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T5iKPGsh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/Dq6fTzn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T5iKPGsh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/Dq6fTzn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 31326210F0;
	Fri, 21 Jun 2024 13:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718976486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJCuq+h5u3aPiWrkexa1qYa0vicdpzfh6UYJP9LV0a4=;
	b=T5iKPGshDECy3ig2kF+G9FsBsOQ2KN6xZjXV+C3GxzI4s5wJTv5Yz4zlIIZZrc5iBmPwQt
	DY12WSbrERDETH3qye3KLnfKQJmjqA103giLa5q93YvB06Yd+fvxSIfHJx/3ZA2qxNi8Xn
	BJilSOrydVDXT4uG+ArcYegO3PY7yRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718976486;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJCuq+h5u3aPiWrkexa1qYa0vicdpzfh6UYJP9LV0a4=;
	b=/Dq6fTzniVTfsGx5mdV1MQh1MJcoZa+vH0uXFNbRwXRbnS4vbhZVGyFzkSxOPdlaI2hVYf
	TOZ0fuH3RNglGRDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=T5iKPGsh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/Dq6fTzn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718976486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJCuq+h5u3aPiWrkexa1qYa0vicdpzfh6UYJP9LV0a4=;
	b=T5iKPGshDECy3ig2kF+G9FsBsOQ2KN6xZjXV+C3GxzI4s5wJTv5Yz4zlIIZZrc5iBmPwQt
	DY12WSbrERDETH3qye3KLnfKQJmjqA103giLa5q93YvB06Yd+fvxSIfHJx/3ZA2qxNi8Xn
	BJilSOrydVDXT4uG+ArcYegO3PY7yRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718976486;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJCuq+h5u3aPiWrkexa1qYa0vicdpzfh6UYJP9LV0a4=;
	b=/Dq6fTzniVTfsGx5mdV1MQh1MJcoZa+vH0uXFNbRwXRbnS4vbhZVGyFzkSxOPdlaI2hVYf
	TOZ0fuH3RNglGRDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E875E13AAA;
	Fri, 21 Jun 2024 13:28:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0y/EN+V/dWZ4FAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 21 Jun 2024 13:28:05 +0000
Message-ID: <a5b472de-6918-4bcc-b33f-9d9f43f83e92@suse.de>
Date: Fri, 21 Jun 2024 15:28:05 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/11] readahead: allocate folios with
 mapping_min_order in readahead
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Matthew Wilcox <willy@infradead.org>, david@fromorbit.com,
 djwong@kernel.org, chandan.babu@oracle.com, brauner@kernel.org,
 akpm@linux-foundation.org, mcgrof@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
 Zi Yan <zi.yan@sent.com>, linux-xfs@vger.kernel.org, p.raghav@samsung.com,
 linux-fsdevel@vger.kernel.org, hch@lst.de, gost.dev@samsung.com,
 cl@os.amperecomputing.com, john.g.garry@oracle.com
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-5-kernel@pankajraghav.com>
 <ZmnuCQriFLdHKHkK@casper.infradead.org>
 <20240614092602.jc5qeoxy24xj6kl7@quentin>
 <ZnAs6lyMuHyk2wxI@casper.infradead.org>
 <20240617160420.ifwlqsm5yth4g7eo@quentin>
 <ZnBf5wXMOBWNl52x@casper.infradead.org>
 <20240617163931.wvxgqdxdbwsbqtrx@quentin>
 <ac136000-1ae0-4cab-9858-abb68ff53b66@suse.de>
 <20240621121903.xbw4j2ijy4k32owv@quentin>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240621121903.xbw4j2ijy4k32owv@quentin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[sent.com];
	FREEMAIL_CC(0.00)[infradead.org,fromorbit.com,kernel.org,oracle.com,linux-foundation.org,kvack.org,vger.kernel.org,os.amperecomputing.com,sent.com,samsung.com,lst.de];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 31326210F0
X-Spam-Flag: NO
X-Spam-Score: -6.50
X-Spam-Level: 

On 6/21/24 14:19, Pankaj Raghav (Samsung) wrote:
> On Tue, Jun 18, 2024 at 08:56:53AM +0200, Hannes Reinecke wrote:
>> On 6/17/24 18:39, Pankaj Raghav (Samsung) wrote:
>>> On Mon, Jun 17, 2024 at 05:10:15PM +0100, Matthew Wilcox wrote:
>>>> On Mon, Jun 17, 2024 at 04:04:20PM +0000, Pankaj Raghav (Samsung) wrote:
>>>>> On Mon, Jun 17, 2024 at 01:32:42PM +0100, Matthew Wilcox wrote:
>>>>> So the following can still be there from Hannes patch as we have a
>>>>> stable reference:
>>>>>
>>>>>    		ractl->_workingset |= folio_test_workingset(folio);
>>>>> -		ractl->_nr_pages++;
>>>>> +		ractl->_nr_pages += folio_nr_pages(folio);
>>>>> +		i += folio_nr_pages(folio);
>>>>>    	}
>>>>
>>>> We _can_, but we just allocated it, so we know what size it is already.
>>> Yes.
>>>
>>>> I'm starting to feel that Hannes' patch should be combined with this
>>>> one.
>>>
>>> Fine by me. @Hannes, is that ok with you?
>>
>> Sure. I was about to re-send my patchset anyway, so feel free to wrap it in.
> Is it ok if I add your Co-developed and Signed-off tag?
> This is what I have combining your patch with mine and making willy's
> changes:
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 389cd802da63..f56da953c130 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -247,9 +247,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>                  struct folio *folio = xa_load(&mapping->i_pages, index + i);
>                  int ret;
>   
> -
>                  if (folio && !xa_is_value(folio)) {
> -                       long nr_pages = folio_nr_pages(folio);
>                          /*
>                           * Page already present?  Kick off the current batch
>                           * of contiguous pages before continuing with the
> @@ -259,18 +257,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>                           * not worth getting one just for that.
>                           */
>                          read_pages(ractl);
> -
> -                       /*
> -                        * Move the ractl->_index by at least min_pages
> -                        * if the folio got truncated to respect the
> -                        * alignment constraint in the page cache.
> -                        *
> -                        */
> -                       if (mapping != folio->mapping)
> -                               nr_pages = min_nrpages;
> -
> -                       VM_BUG_ON_FOLIO(nr_pages < min_nrpages, folio);
> -                       ractl->_index += nr_pages;
> +                       ractl->_index += min_nrpages;
>                          i = ractl->_index + ractl->_nr_pages - index;
>                          continue;
>                  }
> @@ -293,8 +280,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>                  if (i == mark)
>                          folio_set_readahead(folio);
>                  ractl->_workingset |= folio_test_workingset(folio);
> -               ractl->_nr_pages += folio_nr_pages(folio);
> -               i += folio_nr_pages(folio);
> +               ractl->_nr_pages += min_nrpages;
> +               i += min_nrpages;
>          }
>   
>          /*
> 
Yes, that looks fine.
Go.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


