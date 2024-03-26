Return-Path: <linux-fsdevel+bounces-15292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 818FC88BE2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 10:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A51B81C244A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 09:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4EC73524;
	Tue, 26 Mar 2024 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZbIU7G5D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a0eJdvzO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZbIU7G5D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a0eJdvzO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284D471723;
	Tue, 26 Mar 2024 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711445950; cv=none; b=chMBBIlNlwcgqbH/ILsY5syZJH8+pSPOF3aoCpkkDtY90APNQE1eywiqyL7J5sakf4ePppDz/2oQJIOun+vI6eXIZ19TGEt41dN/oHtlvOmkKfSjWEvRiS6uCyZzz0dOCg65p/u6PtsC24e5qntsb7obn/BucVf/ppQuxWkN3KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711445950; c=relaxed/simple;
	bh=LIcVoQTdCH6pdWydpKG+x/1RlQHFfp9f/AqkxkYf85g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUtKYYhAPKCSRq9/ocsSZ1CmzS6LZ6Q/KU69A4PUlvFZByLxSXyZKVLjFNsFO3kkZaZOHZNipim0q3EP+IklJy82a1CHhGZ7bfZYp9Lr4yVaIgsKAXwc+Q/toSx4aQ87NB54vT0py4IBcHi1tswQlS2ne77BfJ5qL4Tc5J2N3II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZbIU7G5D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a0eJdvzO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZbIU7G5D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a0eJdvzO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F31485D3D7;
	Tue, 26 Mar 2024 09:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711445943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kGl36ZnVCOBSUYs46//SH0vHjzvfLhWPNt9V5YwfBJE=;
	b=ZbIU7G5DkSH+jpZAFdb+J2b0NX74xsnNDpOY1ITDpfwH4Bom+dmZlmUihPYQhqYaG3gt2C
	hcjA/Ko4BvCTVTFS8bxlYEPvbL7ukootV7TjUPVG8ZbHtpG9nDe8n7w7TtpNcedHFpuzeE
	maTDQMbsyjlVmrGkoLdHQcP5sgMYyK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711445943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kGl36ZnVCOBSUYs46//SH0vHjzvfLhWPNt9V5YwfBJE=;
	b=a0eJdvzOIyEJSe9rsEYCU6FGOTEjDMObliszcUoPG1w9ANsSUmhK2+hgDcueK2UTQC+asC
	0+wSYiwa0SNXwBAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711445943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kGl36ZnVCOBSUYs46//SH0vHjzvfLhWPNt9V5YwfBJE=;
	b=ZbIU7G5DkSH+jpZAFdb+J2b0NX74xsnNDpOY1ITDpfwH4Bom+dmZlmUihPYQhqYaG3gt2C
	hcjA/Ko4BvCTVTFS8bxlYEPvbL7ukootV7TjUPVG8ZbHtpG9nDe8n7w7TtpNcedHFpuzeE
	maTDQMbsyjlVmrGkoLdHQcP5sgMYyK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711445943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kGl36ZnVCOBSUYs46//SH0vHjzvfLhWPNt9V5YwfBJE=;
	b=a0eJdvzOIyEJSe9rsEYCU6FGOTEjDMObliszcUoPG1w9ANsSUmhK2+hgDcueK2UTQC+asC
	0+wSYiwa0SNXwBAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AEF96138A1;
	Tue, 26 Mar 2024 09:39:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EEwMKbaXAmZpcgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 26 Mar 2024 09:39:02 +0000
Message-ID: <7217df4e-470b-46ab-a4fc-1d4681256885@suse.de>
Date: Tue, 26 Mar 2024 10:39:02 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/11] readahead: rework loop in
 page_cache_ra_unbounded()
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 gost.dev@samsung.com, chandan.babu@oracle.com, mcgrof@kernel.org,
 djwong@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 david@fromorbit.com, akpm@linux-foundation.org,
 Pankaj Raghav <p.raghav@samsung.com>
References: <20240313170253.2324812-1-kernel@pankajraghav.com>
 <20240313170253.2324812-5-kernel@pankajraghav.com>
 <ZgHFPZ9tNLLjKZpz@casper.infradead.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZgHFPZ9tNLLjKZpz@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZbIU7G5D;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=a0eJdvzO
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.78 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.28)[96.64%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -3.78
X-Rspamd-Queue-Id: F31485D3D7
X-Spam-Flag: NO

On 3/25/24 19:41, Matthew Wilcox wrote:
> On Wed, Mar 13, 2024 at 06:02:46PM +0100, Pankaj Raghav (Samsung) wrote:
>> @@ -239,8 +239,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>>   			 * not worth getting one just for that.
>>   			 */
>>   			read_pages(ractl);
>> -			ractl->_index++;
>> -			i = ractl->_index + ractl->_nr_pages - index - 1;
>> +			ractl->_index += folio_nr_pages(folio);
>> +			i = ractl->_index + ractl->_nr_pages - index;
>>   			continue;
>>   		}
>>   
>> @@ -252,13 +252,14 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>>   			folio_put(folio);
>>   			read_pages(ractl);
>>   			ractl->_index++;
>> -			i = ractl->_index + ractl->_nr_pages - index - 1;
>> +			i = ractl->_index + ractl->_nr_pages - index;
>>   			continue;
>>   		}
> 
> You changed index++ in the first hunk, but not the second hunk.  Is that
> intentional?

Hmm. Looks you are right; it should be modified, too.
Will be fixing it up.

Cheers,

Hannes


