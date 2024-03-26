Return-Path: <linux-fsdevel+bounces-15295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726CC88BE73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 10:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45B62E2559
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 09:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B0E535AC;
	Tue, 26 Mar 2024 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="h9eY2N9b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yjlwwJYL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="h9eY2N9b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yjlwwJYL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E78482E2;
	Tue, 26 Mar 2024 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711446815; cv=none; b=C0nAVbeHiJn9h5OTWHDOlh7V2CwGxga6mWlKYZadppkPedfwIinrH7HZxAWIpi2d8cQsIdfxZhiiDKvA6O74tT8be3DMG2PZCjbOvvYSeFru/7OYMC6dDIuxjfI+tAnRCYRSB6tj48Zu2aBaWWrH+7MV6almbuf7unt7E0w9HGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711446815; c=relaxed/simple;
	bh=B0jN2JusynuaJCoStRNyGixQFYWJX7SMfvBbdJeNak8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JSIen6UnxZ/GRaz08TJlR9XOL3qVl0irP4Jffi9gs5iTrz3vrYvvUyT/HP4nhSk99SriLVYXqSC5w+xP6+WVInrNZvNOHL0Wq4EovwIgR7mQ1Iprw+lg7t3JOVQzs8drt6HQFLF+lrEXwOUt50E8mUV8HhZ++soQ13nORqdH1x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h9eY2N9b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yjlwwJYL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h9eY2N9b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yjlwwJYL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 92D99353A0;
	Tue, 26 Mar 2024 09:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711446811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oNAxwNGd3/8WTGxPOxLGhNKj6vwcQwNDS3EsMUDBFws=;
	b=h9eY2N9b+LQ9zfrI65bXwFr7TBMomZoBMtzWI8v5ZB8pSAPQFX8vq1nSdXdrb0Jbzq2S+U
	uFYEw1CNBQGTQKZEAispWo1HDHjVhiqh4S1vZrgT71S0lUTPs4Ff7O25PBWySN/sqa+bQY
	8/sRPpW2ZEAoPSX8Hr2CQXfb2QMYTMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711446811;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oNAxwNGd3/8WTGxPOxLGhNKj6vwcQwNDS3EsMUDBFws=;
	b=yjlwwJYLQwy++QvTvKs2fDkRkxZuF5xAMGkSBlyDpa/vTRaJeNtkpvBg15UcQWKEFGgSHo
	3ETMmNSYB/HXp3AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711446811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oNAxwNGd3/8WTGxPOxLGhNKj6vwcQwNDS3EsMUDBFws=;
	b=h9eY2N9b+LQ9zfrI65bXwFr7TBMomZoBMtzWI8v5ZB8pSAPQFX8vq1nSdXdrb0Jbzq2S+U
	uFYEw1CNBQGTQKZEAispWo1HDHjVhiqh4S1vZrgT71S0lUTPs4Ff7O25PBWySN/sqa+bQY
	8/sRPpW2ZEAoPSX8Hr2CQXfb2QMYTMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711446811;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oNAxwNGd3/8WTGxPOxLGhNKj6vwcQwNDS3EsMUDBFws=;
	b=yjlwwJYLQwy++QvTvKs2fDkRkxZuF5xAMGkSBlyDpa/vTRaJeNtkpvBg15UcQWKEFGgSHo
	3ETMmNSYB/HXp3AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54C82138A1;
	Tue, 26 Mar 2024 09:53:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8nOmExubAmZddwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 26 Mar 2024 09:53:31 +0000
Message-ID: <2508c03b-c26c-42ce-872d-3c5107a4d8a0@suse.de>
Date: Tue, 26 Mar 2024 10:53:30 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/11] enable bs > ps in XFS
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 gost.dev@samsung.com, chandan.babu@oracle.com, mcgrof@kernel.org,
 djwong@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 david@fromorbit.com, akpm@linux-foundation.org,
 Pankaj Raghav <p.raghav@samsung.com>
References: <20240313170253.2324812-1-kernel@pankajraghav.com>
 <ZgHOK9T2K9HKkju1@casper.infradead.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZgHOK9T2K9HKkju1@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=h9eY2N9b;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yjlwwJYL
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.90)[86.08%];
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
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -2.40
X-Rspamd-Queue-Id: 92D99353A0
X-Spam-Flag: NO

On 3/25/24 20:19, Matthew Wilcox wrote:
> On Wed, Mar 13, 2024 at 06:02:42PM +0100, Pankaj Raghav (Samsung) wrote:
>> This is the third version of the series that enables block size > page size
>> (Large Block Size) in XFS. The context and motivation can be seen in cover
>> letter of the RFC v1[1]. We also recorded a talk about this effort at LPC [3],
>> if someone would like more context on this effort.
> 
> Thank you.  This is a lot better.
> 
> I'm still trying to understand your opinion on the contents of the
> file_ra_state.  Is it supposed to be properly aligned at all times, or
> do we work with it in the terms of "desired number of pages" and then
> force it to conform to the minimum-block-size reality right at the end?
> Because you seem to be doing both at various points.

Guess what, that's what I had been pondering, too.
Each way has its benefits, I guess.

Question really is do we keep the readahead iterator in units of pages,
and convert the result, or do we modify the readahead iterator to work
on folios, and convert the inputs.

Doesn't really matter much, but we need to decide. The former is 
probably easier on the caller, and the latter is easier on the consumer.
Take your pick; I really don't mind.

But we should document the result :-)

Cheers,

Hannes


