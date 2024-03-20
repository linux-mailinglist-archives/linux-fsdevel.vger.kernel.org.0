Return-Path: <linux-fsdevel+bounces-14916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E28F488177E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 19:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 147DDB23453
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 18:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6C185633;
	Wed, 20 Mar 2024 18:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xT6kbLQs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eoey5pTD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xT6kbLQs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eoey5pTD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C6685282
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 18:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710960485; cv=none; b=quApC1lfL25+MsGet2hParaL1Z96wdMUKdwCP8E7slqznL2ROtBa2mxNwIoVYADksYd0fRMiqLLMkD7SU7+gbg1Bgjw5xn9Hdf8P+l56SmqeIVb2YfZFJX3SgCFNp39LzP8Sfma726yA2Xb6rG2XUpvetDmDDRvSKYDd792NTOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710960485; c=relaxed/simple;
	bh=kT+d2DscrUyLwuK+uYu8yV4ngnv9KT85I+YhxL6h54s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPl0qCOOM9Atgbba329L49tpxd1NMiNCr+fAMag5jIdj2GQhBq7fVBqI44wAokHTrz/RqI742QSPboxoUQig7ZAtNFRgn8Imp3vJ1W2WNXHiC5tiWg6MPu+IVs6BuBEk9931c9WylAaW/M1jvOjDxWwm9tIWnJ2pkeYLCtuboy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xT6kbLQs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eoey5pTD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xT6kbLQs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eoey5pTD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2C2FC5C17D;
	Wed, 20 Mar 2024 18:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710960482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FAfb8JiCgjwf7Wx15wKutMK9k8c4fMfmPM4F7ML4T6k=;
	b=xT6kbLQsb/oUUyyFlW+JXkY3YY3CEIBRZmwvAId0fkmV8qd98tzYwwlftd2dWW/r/eVImQ
	um6NyMQTGBegvuaNlyFlr8Vp3+GLeXXoUteglGIC7cGupMZ+LefDLGhhPxGpZ49qoA/1Mx
	B1aJOySPuEox+TeEX2A2uVmP2guxle0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710960482;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FAfb8JiCgjwf7Wx15wKutMK9k8c4fMfmPM4F7ML4T6k=;
	b=eoey5pTDs0JRsVpGTzPwSnQcIgCJ6MM6URqNjHBxtw6Q7fSwIif3IOIjRuVt3+NZeoWrWY
	SdDkI6rca45U9UDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710960482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FAfb8JiCgjwf7Wx15wKutMK9k8c4fMfmPM4F7ML4T6k=;
	b=xT6kbLQsb/oUUyyFlW+JXkY3YY3CEIBRZmwvAId0fkmV8qd98tzYwwlftd2dWW/r/eVImQ
	um6NyMQTGBegvuaNlyFlr8Vp3+GLeXXoUteglGIC7cGupMZ+LefDLGhhPxGpZ49qoA/1Mx
	B1aJOySPuEox+TeEX2A2uVmP2guxle0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710960482;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FAfb8JiCgjwf7Wx15wKutMK9k8c4fMfmPM4F7ML4T6k=;
	b=eoey5pTDs0JRsVpGTzPwSnQcIgCJ6MM6URqNjHBxtw6Q7fSwIif3IOIjRuVt3+NZeoWrWY
	SdDkI6rca45U9UDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01B55136D6;
	Wed, 20 Mar 2024 18:48:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PYVgO2Ev+2WMFgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 20 Mar 2024 18:48:01 +0000
Message-ID: <73533d54-2b92-4794-818e-753aaea887f9@suse.cz>
Date: Wed, 20 Mar 2024 19:48:01 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: NeilBrown <neilb@suse.de>, Kent Overstreet <kent.overstreet@linux.dev>,
 Dave Chinner <david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>,
 Amir Goldstein <amir73il@gmail.com>, paulmck@kernel.org,
 lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
 <Zd-LljY351NCrrCP@casper.infradead.org>
 <170925937840.24797.2167230750547152404@noble.neil.brown.name>
 <ZeFtrzN34cLhjjHK@dread.disaster.area>
 <pv2chxwnrufut6wecm47q2z7222tzdl3gi6s5wgvmk3b2gq3n5@d23qr5odwyxl>
 <170933687972.24797.18406852925615624495@noble.neil.brown.name>
 <xbjw7mn57qik3ica2k6o7ykt7twryod6rt3uvu73w6xahrrrql@iaplvz7t5tgv>
 <170950594802.24797.17587526251920021411@noble.neil.brown.name>
 <a7862cf1-1ed2-4c2c-8a27-f9d950ff4da5@suse.cz>
 <aaea1147-f015-423b-8a42-21fc18930c8f@moroto.mountain>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <aaea1147-f015-423b-8a42-21fc18930c8f@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.42
X-Spamd-Result: default: False [-1.42 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-0.13)[67.77%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[suse.de,linux.dev,fromorbit.com,infradead.org,gmail.com,kernel.org,lists.linux-foundation.org,kvack.org,vger.kernel.org,suse.cz];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On 3/20/24 19:32, Dan Carpenter wrote:
> On Tue, Mar 12, 2024 at 03:46:32PM +0100, Vlastimil Babka wrote:
>> But if we change it to effectively mean GFP_NOFAIL (for non-costly
>> allocations), there should be a manageable number of places to change to a
>> variant that allows failure.
> 
> What does that even mean if GFP_NOFAIL can fail for "costly" allocations?
> I thought GFP_NOFAIL couldn't fail at all...

Yeah, the suggestion was that GFP_KERNEL would act as GFP_NOFAIL but only
for non-costly allocations. Anything marked GFP_NOFAIL would still be fully
nofail.

> Unfortunately, it's common that when we can't decide on a sane limit for
> something people just say "let the user decide based on how much memory
> they have".  I have added some integer overflow checks which allow the
> user to allocate up to UINT_MAX bytes so I know this code is out
> there.  We can't just s/GFP_KERNEL/GFP_NOFAIL/.

Maybe we could start producing warnings for costly GFP_KERNEL allocations to
get them converted away faster. Anything that's user-controlled most likely
shouldn't be GFP_KERNEL.

> From a static analysis perspective it would be nice if the callers
> explicitly marked which allocations can fail and which can't.

As I suggested, it would be nice not to wait until everything is explicitly
marked one way or another. I get the comparison with BKL, but also the
kernel got much larger since the BKL times?

Good point that it's not ideal if the size is unknown. Maybe the tools could
be used to point out places where the size cannot be determined, so those
should be converted first?

Also tools cound warn about attempts to handle failure to point out places
where it should be removed?

> regards,
> dan carpenter
> 


