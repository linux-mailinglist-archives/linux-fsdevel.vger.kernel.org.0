Return-Path: <linux-fsdevel+bounces-55586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A41B0C182
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 12:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AD211760ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 10:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE4129B782;
	Mon, 21 Jul 2025 10:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kxMXG9kq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ICSfBX58";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kxMXG9kq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ICSfBX58"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4786F292B4B
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 10:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753094438; cv=none; b=HBWRyXaP6R30CcY/8TuZ1WlupvnjoDTojiIg5OhmLyEliYjzjtiBwfu8alf3N0GjtbfrFPj2UxD0czAtKRNAPupXZfwBVzi11HCK9okbolI7z0XqlLl0/6QILV8sjB7kG/+oyEBtEWvBzu7H66stY8aIt+JTIN9ofA/ux4qf1BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753094438; c=relaxed/simple;
	bh=HwJPqklxIi4TxHGwi2RXoqe6O4MmTclYjH3w0n8qsZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aooczFFd3LyJOnpLCGM9ZSEaNuQXKB/A/2Tqk4LbVRMELC7lZ6BfwtISU0agBnDsSp8UT64B7aIsChDP+gwNMcWPmS8jX8Vs4HLaQpueRsnMvxbWTMhdaP/sxERE4hLqajZfbP67aDpL9NfWRaHsxZCRE8PnlNZQLuBOSFNJnfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kxMXG9kq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ICSfBX58; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kxMXG9kq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ICSfBX58; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6BB362198A;
	Mon, 21 Jul 2025 10:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753094434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DGT86XjEs8yUfWXy1Dj1eOgiciVU8QCPotf/nQIicGA=;
	b=kxMXG9kqvqWuM9I/9r/hsVpe6woZ/TQRgAd+XXywmh+ERAds1E1aVPE3z71ebOTZe14d+u
	OYXNgAAzKhqzqzNlr1dVvAZjqp3fMl7uHHDk0CPvRO2Vcpo10nD0U6S4l+1inYr0brmUpS
	G3PquTDhBvTJfKgpk1t0jw2uZiBmJEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753094434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DGT86XjEs8yUfWXy1Dj1eOgiciVU8QCPotf/nQIicGA=;
	b=ICSfBX58lcEx17GB6hJdMgeICEtXc+3j0Tw2OOzMR5Ma3B1jtprylWsf0J4yWQRmocS5HU
	JqJUpGLo6x/nQKDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753094434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DGT86XjEs8yUfWXy1Dj1eOgiciVU8QCPotf/nQIicGA=;
	b=kxMXG9kqvqWuM9I/9r/hsVpe6woZ/TQRgAd+XXywmh+ERAds1E1aVPE3z71ebOTZe14d+u
	OYXNgAAzKhqzqzNlr1dVvAZjqp3fMl7uHHDk0CPvRO2Vcpo10nD0U6S4l+1inYr0brmUpS
	G3PquTDhBvTJfKgpk1t0jw2uZiBmJEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753094434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DGT86XjEs8yUfWXy1Dj1eOgiciVU8QCPotf/nQIicGA=;
	b=ICSfBX58lcEx17GB6hJdMgeICEtXc+3j0Tw2OOzMR5Ma3B1jtprylWsf0J4yWQRmocS5HU
	JqJUpGLo6x/nQKDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41897136A8;
	Mon, 21 Jul 2025 10:40:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tKaeDyIZfmhLHwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 21 Jul 2025 10:40:34 +0000
Message-ID: <24f995fe-df76-4495-b9c6-9339b6afa6be@suse.cz>
Date: Mon, 21 Jul 2025 12:40:34 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] module: Rename EXPORT_SYMBOL_GPL_FOR_MODULES to
 EXPORT_SYMBOL_FOR_MODULES
Content-Language: en-US
To: Daniel Gomez <da.gomez@kernel.org>, Daniel Gomez <da.gomez@samsung.com>,
 Matthias Maennich <maennich@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
 Peter Zijlstra <peterz@infradead.org>, David Hildenbrand <david@redhat.com>,
 Shivank Garg <shivankg@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20250715-export_modules-v3-1-11fffc67dff7@suse.cz>
 <b340eb9f-a336-461c-befe-6b09c68b731e@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <b340eb9f-a336-461c-befe-6b09c68b731e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On 7/15/25 20:58, Daniel Gomez wrote:
> On 15/07/2025 10.43, Vlastimil Babka wrote:
>> Christoph suggested that the explicit _GPL_ can be dropped from the
>> module namespace export macro, as it's intended for in-tree modules
>> only. It would be possible to restrict it technically, but it was
>> pointed out [2] that some cases of using an out-of-tree build of an
>> in-tree module with the same name are legitimate. But in that case those
>> also have to be GPL anyway so it's unnecessary to spell it out in the
>> macro name.
>> 
>> Link: https://lore.kernel.org/all/aFleJN_fE-RbSoFD@infradead.org/ [1]
>> Link: https://lore.kernel.org/all/CAK7LNATRkZHwJGpojCnvdiaoDnP%2BaeUXgdey5sb_8muzdWTMkA@mail.gmail.com/ [2]
>> Suggested-by: Christoph Hellwig <hch@infradead.org>
>> Reviewed-by: Shivank Garg <shivankg@amd.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Acked-by: Nicolas Schier <n.schier@avm.de>
>> Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
>> Reviewed-by: Christian Brauner <brauner@kernel.org>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>> Daniel, please clarify if you'll take this via module tree or Christian
>> can take it via vfs tree?
> 
> Patch 707f853d7fa3 ("module: Provide EXPORT_SYMBOL_GPL_FOR_MODULES() helper")
> from Peter was merged through Masahiro in v6.16-rc1. Since this is a related
> fix/rename/cleanup, it'd make sense for it to go through his kbuild tree as
> well. Masahiro, please let me know if you'd prefer otherwise. If not, I'll queue
> it up in the modules tree.

Maybe with no reply, you can queue it then?

Thanks,
Vlastimil

