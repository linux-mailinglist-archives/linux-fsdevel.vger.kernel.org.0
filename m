Return-Path: <linux-fsdevel+bounces-54808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA567B03794
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 09:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893D23B8CBC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 07:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820CA230BC3;
	Mon, 14 Jul 2025 07:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B45H+o2d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bIIJaQsF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a0b9zZBX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aAl4sERf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C545522FAF8
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 07:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752476985; cv=none; b=Ms0yWSgZHqLF/Kwxhr2im3z5kyfKbmFAIsfkdjTWz/x1aw8B7yqLhEAyrf0XRSLzaNpXR6eOmPoMqa13QK3n6te/yic5HMt89Idz8fcE4zFacJDAmOIgYs4g+S9dcJ76x4WkH7octSbm82qSHDWB7dcNW3X9FDQPF/ibdaH7spo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752476985; c=relaxed/simple;
	bh=ehiJGRMp02AIO8z2cJ0eoOGCKNObyvEOvni2x0THx1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lC9+nGn7yFjHA6UTionHFjGHgGLduHfzEDiB9TdGDWCRO3/cdUY66ScSse/kdMZat5NysbYHCUL6w0TDev/tZW3EhUaSmG8vlssEnum+y6geBNckKFIMhAjKXFUJpStT4nT0UcOj2LUx2i0gGQBwRMDVTwZBYyxD/lb8LKPFHWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B45H+o2d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bIIJaQsF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a0b9zZBX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aAl4sERf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B29612118D;
	Mon, 14 Jul 2025 07:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752476982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G2qA91gO6tcAaQVJpknYZYn5HNXpIJ5Jl9tGtCwshMU=;
	b=B45H+o2dArwfpWQVw6f8KwhITXmgUUfld6sm0XCePHhEanZqKUaynj7zuU4uSX5Jec7b45
	polvJPSwsGaa+9I5jbTDJD0d8hXct9bIi2UQNkNbzmjxvhLOjz1wiWzSYcDOx/b/wZmAVu
	Bg3FNd1QEb0Zt1pa72AcfHw8HsYh42U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752476982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G2qA91gO6tcAaQVJpknYZYn5HNXpIJ5Jl9tGtCwshMU=;
	b=bIIJaQsFVhYA5PtUI14DXQ90MyAz5IlSJetvVU6svzab1tvF5e3+bYcHwwKMkXNjxEAWAU
	JOA4DKk9jTv8LHDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752476980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G2qA91gO6tcAaQVJpknYZYn5HNXpIJ5Jl9tGtCwshMU=;
	b=a0b9zZBXUyXDVSKGdsLvzTJaR1HooezpI6e87kx1DOO8/KtDOJY8lypC1keEgOsnZJYxAl
	gyioNPZcpDy16jxI461iH4KWS8xx0McbO+L5pIG+0hBcLcyJqySDKIjjV1yRNyWeiGWqwH
	2SPKs06woC6Ey6MDEj3HcZ4kDyK+Bqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752476980;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G2qA91gO6tcAaQVJpknYZYn5HNXpIJ5Jl9tGtCwshMU=;
	b=aAl4sERfiHATIupx8nDix0OXGGT4Z38OK6MOjKwlBwWm5WERIIwttitCCHbBsPV7RO4BMq
	9rcEUCHyRF+oh+Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8639E138A1;
	Mon, 14 Jul 2025 07:09:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oUtwIDStdGgNFAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 14 Jul 2025 07:09:40 +0000
Message-ID: <678290fe-f171-4680-82bd-fa50e5fde7a4@suse.cz>
Date: Mon, 14 Jul 2025 09:09:40 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] module: Rename EXPORT_SYMBOL_GPL_FOR_MODULES to
 EXPORT_SYMBOL_FOR_MODULES
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Daniel Gomez <da.gomez@kernel.org>
Cc: Matthias Maennich <maennich@google.com>, Jonathan Corbet
 <corbet@lwn.net>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
 Daniel Gomez <da.gomez@samsung.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Christoph Hellwig <hch@infradead.org>, Peter Zijlstra
 <peterz@infradead.org>, David Hildenbrand <david@redhat.com>,
 Shivank Garg <shivankg@amd.com>, "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20250711-export_modules-v2-1-b59b6fad413a@suse.cz>
 <b9b74600-4467-4c76-aa41-0a36b1cce1f4@kernel.org>
 <2025071355-debunk-sprang-e1ad@gregkh>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <2025071355-debunk-sprang-e1ad@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On 7/13/25 10:31, Greg Kroah-Hartman wrote:
> On Sat, Jul 12, 2025 at 08:26:17PM +0200, Daniel Gomez wrote:
>> On 11/07/2025 16.05, Vlastimil Babka wrote:
>> > Changes in v2:
>> > - drop the patch to restrict module namespace export for in-tree modules
>> > - fix a pre-existing documentation typo (Nicolas Schier)
>> > - Link to v1: https://patch.msgid.link/20250708-export_modules-v1-0-fbf7a282d23f@suse.cz
>> > ---
>> >  Documentation/core-api/symbol-namespaces.rst | 8 ++++----
>> >  fs/anon_inodes.c                             | 2 +-
>> >  include/linux/export.h                       | 2 +-
>> >  3 files changed, 6 insertions(+), 6 deletions(-)
>> > 
>> > diff --git a/Documentation/core-api/symbol-namespaces.rst b/Documentation/core-api/symbol-namespaces.rst
>> > index 32fc73dc5529e8844c2ce2580987155bcd13cd09..6f7f4f47d43cdeb3b5008c795d254ca2661d39a6 100644
>> > --- a/Documentation/core-api/symbol-namespaces.rst
>> > +++ b/Documentation/core-api/symbol-namespaces.rst
>> > @@ -76,8 +76,8 @@ A second option to define the default namespace is directly in the compilation
>> >  within the corresponding compilation unit before the #include for
>> >  <linux/export.h>. Typically it's placed before the first #include statement.
>> >  
>> > -Using the EXPORT_SYMBOL_GPL_FOR_MODULES() macro
>> > ------------------------------------------------
>> > +Using the EXPORT_SYMBOL_FOR_MODULES() macro
>> > +-------------------------------------------
>> >  
>> >  Symbols exported using this macro are put into a module namespace. This
>> >  namespace cannot be imported.
>> 
>> The new naming makes sense, but it breaks the pattern with _GPL suffix:
>> 
>> * EXPORT_SYMBOL(sym)
>> * EXPORT_SYMBOL_GPL(sym)
>> * EXPORT_SYMBOL_NS(sym, ns)
>> * EXPORT_SYMBOL_NS_GPL(sym, ns)
>> * EXPORT_SYMBOL_FOR_MODULES(sym, mods)
>> 
>> So I think when reading this one may forget about the _obvious_ reason. That's
>> why I think clarifying that in the documentation would be great. Something like:
>> 
>> Symbols exported using this macro are put into a module namespace. This
>> namespace cannot be imported. And it's implicitly GPL-only as it's only intended
>> for in-tree modules.
> 
> s/implicitly/explicitly/

From the point of the macro name,
it was explicit with "EXPORT_SYMBOL_GPL_FOR_MODULES()"
it's implicit with "EXPORT_SYMBOL_FOR_MODULES()"

> thanks,
> 
> greg k-h


