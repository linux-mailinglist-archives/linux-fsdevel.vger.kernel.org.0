Return-Path: <linux-fsdevel+bounces-52592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCE1AE46E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 16:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D974D4A2847
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA34146A66;
	Mon, 23 Jun 2025 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ti7U4Cey";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9W3oUpek";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ti7U4Cey";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9W3oUpek"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C5E824A3
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688478; cv=none; b=dAmBazjELO4R018FuNDbCd8EG/QXJAYEomzfSucFCz5/vNogYy5uYPEDv9w1zGrD3nFlB9xOjF5kpFXDT9UKcst1/RD24LfiSx3lp7vqbracqKtml5URL7KmKsazMLK22fze80hNugz9EU2re9xhpbcWKKto5CN5vTSpYJjsVsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688478; c=relaxed/simple;
	bh=1+xrqG1doYoMdeLpYgHkd59wbjPw5xIupDkrzcGDae8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EgbTjjGtPnM+Ud6DmN6PYiFdd+3oQL8GYbHksg5hUZxRNkYxvO4gonWnUQQdxUupDVsPF+9wPHPOUDwEuVTYoagWM8pv1Lr3ux33062sr7ZKUhjppKxJOvFwA/DuwWV2q2iAzH9zhVtU33R5EPZsnmfcV4gKd4PgLOt5NE+WYss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ti7U4Cey; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9W3oUpek; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ti7U4Cey; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9W3oUpek; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 692761F385;
	Mon, 23 Jun 2025 14:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750688475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EaVkjdtu0qR0IvdgczsHHLG6kVAAB8KCiwHmzhdF6O8=;
	b=ti7U4Cey6hRWObguyi7fDF5i/rQBJuOUaUQDdFnrcC4u30qK3nEwkuz6qJ3hK1ESJ/eTLs
	mL5df+ivwZq0uThGSWF2wMUhRqvNa710DnBocEENfTNujhmu6KLAQSxwiHshV3FITZVqpf
	8ghc0fFKAomv3dU9+YuZpPtA00LGp6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750688475;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EaVkjdtu0qR0IvdgczsHHLG6kVAAB8KCiwHmzhdF6O8=;
	b=9W3oUpekOiapVDhAFy755BezeIWYOW2nqGVbXhh6UuVE+FLquyu67NSiudhQV8TmUZkQIb
	qmd00T1PvOd4MGBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ti7U4Cey;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9W3oUpek
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750688475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EaVkjdtu0qR0IvdgczsHHLG6kVAAB8KCiwHmzhdF6O8=;
	b=ti7U4Cey6hRWObguyi7fDF5i/rQBJuOUaUQDdFnrcC4u30qK3nEwkuz6qJ3hK1ESJ/eTLs
	mL5df+ivwZq0uThGSWF2wMUhRqvNa710DnBocEENfTNujhmu6KLAQSxwiHshV3FITZVqpf
	8ghc0fFKAomv3dU9+YuZpPtA00LGp6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750688475;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EaVkjdtu0qR0IvdgczsHHLG6kVAAB8KCiwHmzhdF6O8=;
	b=9W3oUpekOiapVDhAFy755BezeIWYOW2nqGVbXhh6UuVE+FLquyu67NSiudhQV8TmUZkQIb
	qmd00T1PvOd4MGBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D5ED13485;
	Mon, 23 Jun 2025 14:21:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KnuaDttiWWgEYwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 23 Jun 2025 14:21:15 +0000
Message-ID: <c0cc4faf-42eb-4c2f-8d25-a2441a36c41b@suse.cz>
Date: Mon, 23 Jun 2025 16:21:15 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: export anon_inode_make_secure_inode() and fix
 secretmem LSM bypass
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>,
 Christian Brauner <brauner@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Mike Rapoport <rppt@kernel.org>,
 Shivank Garg <shivankg@amd.com>, david@redhat.com,
 akpm@linux-foundation.org, paul@paul-moore.com, viro@zeniv.linux.org.uk,
 willy@infradead.org, pbonzini@redhat.com, tabba@google.com,
 afranji@google.com, ackerleytng@google.com, jack@suse.cz,
 cgzones@googlemail.com, ira.weiny@intel.com, roypat@amazon.co.uk,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>
References: <20250619073136.506022-2-shivankg@amd.com>
 <da5316a7-eee3-4c96-83dd-78ae9f3e0117@suse.cz>
 <20250619-fixpunkt-querfeldein-53eb22d0135f@brauner>
 <aFPuAi8tPcmsbTF4@kernel.org>
 <20250619-ablichten-korpulent-0efe2ddd0ee6@brauner>
 <aFQATWEX2h4LaQZb@kernel.org> <aFV3-sYCxyVIkdy6@google.com>
 <20250623-warmwasser-giftig-ff656fce89ad@brauner>
 <aFleB1PztbWy3GZM@infradead.org> <aFleJN_fE-RbSoFD@infradead.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <aFleJN_fE-RbSoFD@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 692761F385
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[googlemail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,amd.com,redhat.com,linux-foundation.org,paul-moore.com,zeniv.linux.org.uk,infradead.org,suse.cz,googlemail.com,intel.com,amazon.co.uk,vger.kernel.org,kvack.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid]
X-Spam-Score: -4.51
X-Spam-Level: 

On 6/23/25 16:01, Christoph Hellwig wrote:
> On Mon, Jun 23, 2025 at 07:00:39AM -0700, Christoph Hellwig wrote:
>> On Mon, Jun 23, 2025 at 12:16:27PM +0200, Christian Brauner wrote:
>> > I'm more than happy to switch a bunch of our exports so that we only
>> > allow them for specific modules. But for that we also need
>> > EXPOR_SYMBOL_FOR_MODULES() so we can switch our non-gpl versions.
>> 
>> Huh?  Any export for a specific in-tree module (or set thereof) is
>> by definition internals and an _GPL export if perfectly fine and
>> expected.

Peterz tells me EXPORT_SYMBOL_GPL_FOR_MODULES() is not limited to in-tree
modules, so external module with GPL and matching name can import.

But if we're targetting in-tree stuff like kvm, we don't need to provide a
non-GPL variant I think?

> .. the only thing we should do is to drop the pointless _GPL in the
> name entirely.

I'd agree if it was indeed limited to in-tree modules.

