Return-Path: <linux-fsdevel+bounces-12095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979E385B3C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 08:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC94F1C2230C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 07:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E8E5A4E2;
	Tue, 20 Feb 2024 07:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2ZP2VMC6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yZBmTjiY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2ZP2VMC6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yZBmTjiY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8113E5A11D;
	Tue, 20 Feb 2024 07:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708413413; cv=none; b=u5BZWhwxNklYOg/GOtlnPnuWBYWFH0pWSssNIuLjlT0rIijMccfRK7eBNStHaqaIE5+dwfEXSqgzUySHF0O6d+Yq92QHYzaV4v+nJ7W0m0d+RRc1YpdFP13aEkQmQdIVVPU30OQuErRJu+sBmQQi7gJABmwR3d8mOQySpupPJDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708413413; c=relaxed/simple;
	bh=sVEvf81HYL71592XjYLXKdVLfIgi4fW83G+GimHMgu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o6nZJFdhPt+ZfRc8NOa0Hg88l+tZA7qs/gIKeqPBbJMR6TqkIjHOFPdzjbSi3T4DD8pRT5QB03oDVlfhkYO9095kDAFwqi0s4UHp4gFRCaeNuAgOlbfWXbMQH4ina9vu1d3SPCWE7fMerjLtDPa70zMsuCmDzux4xJtq9bsdAkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2ZP2VMC6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yZBmTjiY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2ZP2VMC6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yZBmTjiY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 335122203C;
	Tue, 20 Feb 2024 07:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708413409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mRahtuQSFMxt05TGxYHbI48NSmxiy73yXCx+h0UNDqg=;
	b=2ZP2VMC6DM1eu/RhehDHocjEQiLkCkLr4elj8T43K1MbOVsvwtXgmu4qm/wUJNXejvvR1i
	EMRmls/ryG0ZwiXXwcxJN8Yw5BChSCPnHHhm2zWN5bzvU0W2fOdBxfvnWR0Qp98QQbKZai
	R4iVacnIqXx8DLu16oTtnv8ZgLJIdLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708413409;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mRahtuQSFMxt05TGxYHbI48NSmxiy73yXCx+h0UNDqg=;
	b=yZBmTjiY3bD9EYX0Pm7MQzWKCke58cJGugOtYVp3LfJ2fYt+kfzoSQ97B0l0VWnQV9bZTy
	8w1TBNsXbk6niEAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708413409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mRahtuQSFMxt05TGxYHbI48NSmxiy73yXCx+h0UNDqg=;
	b=2ZP2VMC6DM1eu/RhehDHocjEQiLkCkLr4elj8T43K1MbOVsvwtXgmu4qm/wUJNXejvvR1i
	EMRmls/ryG0ZwiXXwcxJN8Yw5BChSCPnHHhm2zWN5bzvU0W2fOdBxfvnWR0Qp98QQbKZai
	R4iVacnIqXx8DLu16oTtnv8ZgLJIdLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708413409;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mRahtuQSFMxt05TGxYHbI48NSmxiy73yXCx+h0UNDqg=;
	b=yZBmTjiY3bD9EYX0Pm7MQzWKCke58cJGugOtYVp3LfJ2fYt+kfzoSQ97B0l0VWnQV9bZTy
	8w1TBNsXbk6niEAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29582134E4;
	Tue, 20 Feb 2024 07:16:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A8MCCOBR1GUmRAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 20 Feb 2024 07:16:48 +0000
Message-ID: <427e3fdb-5be2-4ff3-9bad-a21c49d0aab4@suse.de>
Date: Tue, 20 Feb 2024 08:16:46 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Reclaiming & documenting page flags
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 bpf@vger.kernel.org
References: <Zbcn-P4QKgBhyxdO@casper.infradead.org>
 <Zb9pZTmyb0lPMQs8@kernel.org> <ZcACya-MJr_fNRSH@casper.infradead.org>
 <ZcOnEGyr6y3jei68@kernel.org> <ZdO2eABfGoPNnR07@casper.infradead.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZdO2eABfGoPNnR07@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=2ZP2VMC6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yZBmTjiY
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -4.50
X-Rspamd-Queue-Id: 335122203C
X-Spam-Flag: NO

On 2/19/24 21:13, Matthew Wilcox wrote:
> On Wed, Feb 07, 2024 at 05:51:44PM +0200, Mike Rapoport wrote:
>> On Sun, Feb 04, 2024 at 09:34:01PM +0000, Matthew Wilcox wrote:
>>> I'm doing my best to write documentation as I go.  I think we're a bit
>>> better off than we were last year.  Do we have scripts to tell us which
>>> public functions (ie EXPORT_SYMBOL and static inline functions in header
>>> files) have kernel-doc?  And could we run them against kernels from, say,
>>> April 2023, 2022, 2021, 2020, 2019 (and in two months against April 2024)
>>> and see how we're doing in terms of percentage undocumented functions?
>>
>> We didn't have such script, but it was easy to compare "grep
>> EXPORT_SYMBOL\|static inline" with ".. c:function" in kernel-doc.
>> We do improve slowly, but we are still below 50% with kernel-doc for
>> EXPORT_SYMBOL functions and slightly above 10% for static inlines.
> 
> Thanks for doing this!  Data is good ;-)
> 
> I just came across an interesting example of a function which I believe
> should NOT have kernel-doc.  But it should have documentation for why it
> doesn't have kernel-doc!  Any thoughts about how we might accomplish that?
> 
> The example is filemap_range_has_writeback().  It's EXPORT_SYMBOL_GPL()
> and it's a helper function for filemap_range_needs_writeback().
> filemap_range_needs_writeback() has kernel-doc, but nobody should be
> calling filemap_range_has_writeback() directly, so it shouldn't even
> exist in the htmldocs.  But we should have a comment on it saying
> "Use filemap_range_needs_writeback(), don't use this", in case anyone
> discovers it.  And the existance of that comment should be enough to
> tell our tools to not flag this as a function that needs kernel-doc.
> 
> 
Or, indeed, coming up with a method of signalling "this is an internal
function for a specific need, don't use otherwise".

EXPORT_SYMBOL_INTERNAL?

I would love to have it; it would solve _so_ many problems we're having
wrt kABI...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


