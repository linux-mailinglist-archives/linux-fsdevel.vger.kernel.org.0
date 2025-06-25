Return-Path: <linux-fsdevel+bounces-52854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EED7AE7956
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 10:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9565F1BC6271
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 08:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F72C20B81D;
	Wed, 25 Jun 2025 08:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LNtjtFve";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GYfHfzp4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LNtjtFve";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GYfHfzp4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193021C27
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 08:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750838547; cv=none; b=aIA6lia5Ef5gFDx4sSWPgdRCf5tgA3bkUSU47B2euoYeOmeqgrfTZ1gjEaIWY+EP1SANX0YXhZRKvqTmoyG1iH9aKbUANbuXnZocwvJY3I3QFzsixLPUjLNA/APD2AO7xlEbBc6R/Rr6XsZ/9o00FURJNaBGinE01LsBPQCmTBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750838547; c=relaxed/simple;
	bh=6C2AkZiqgd2PjEN9Dm9SREXxuPu6FUeexI9ox8vePJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S0nSoTO/cLKIT9F1vKaW13x46KiY80sNCVaGOuwJ8Y4dArX3FqJncsoKl7TFF5GbttpHi0TWjwXG1WF05iBeUA8RZT4Hl0yh0I1et+NPgnRmJ8cICPTWLii+hN1K6enL0OCAcYMrppeV2Y0MB9gtjcl3kSiopgWi/W+TrkULOWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LNtjtFve; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GYfHfzp4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LNtjtFve; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GYfHfzp4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5A89821175;
	Wed, 25 Jun 2025 08:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750838544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DrvSwNdc81zvrML++2yKpFy57j7rZ8Jo3PIz7pXVsKM=;
	b=LNtjtFve4EAX4VLkjkuECIDnRZx+AE7ok5VYfl3q2rjrMOHh2z6AEKfm+FuA1RDKvD1YRZ
	PoOwuxHgqbhPsXcJL+Am5Pv/hS/vSzPEgszIM1c26Hrmb7Py+5+hrn8EH+E1bOLM+Dh+ar
	sdq0q88BW/gZxyqvwwSKdulKEKQMtEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750838544;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DrvSwNdc81zvrML++2yKpFy57j7rZ8Jo3PIz7pXVsKM=;
	b=GYfHfzp43BZxq+QsvjasY0OR3usK3pRwsSiH3WlMquA5/4EhOaAxwWzV1B9ZNDVMzmtaZv
	5l6CiULxfiA7xTCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750838544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DrvSwNdc81zvrML++2yKpFy57j7rZ8Jo3PIz7pXVsKM=;
	b=LNtjtFve4EAX4VLkjkuECIDnRZx+AE7ok5VYfl3q2rjrMOHh2z6AEKfm+FuA1RDKvD1YRZ
	PoOwuxHgqbhPsXcJL+Am5Pv/hS/vSzPEgszIM1c26Hrmb7Py+5+hrn8EH+E1bOLM+Dh+ar
	sdq0q88BW/gZxyqvwwSKdulKEKQMtEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750838544;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DrvSwNdc81zvrML++2yKpFy57j7rZ8Jo3PIz7pXVsKM=;
	b=GYfHfzp43BZxq+QsvjasY0OR3usK3pRwsSiH3WlMquA5/4EhOaAxwWzV1B9ZNDVMzmtaZv
	5l6CiULxfiA7xTCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 331D913301;
	Wed, 25 Jun 2025 08:02:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TEQiDBCtW2h2FQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 25 Jun 2025 08:02:24 +0000
Message-ID: <e5d11288-ef0c-4a82-b117-6d12d2357964@suse.cz>
Date: Wed, 25 Jun 2025 10:02:23 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: export anon_inode_make_secure_inode() and fix
 secretmem LSM bypass
To: Peter Zijlstra <peterz@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
 Christian Brauner <brauner@kernel.org>,
 Sean Christopherson <seanjc@google.com>, Mike Rapoport <rppt@kernel.org>,
 Shivank Garg <shivankg@amd.com>, david@redhat.com,
 akpm@linux-foundation.org, paul@paul-moore.com, viro@zeniv.linux.org.uk,
 willy@infradead.org, pbonzini@redhat.com, tabba@google.com,
 afranji@google.com, ackerleytng@google.com, jack@suse.cz,
 cgzones@googlemail.com, ira.weiny@intel.com, roypat@amazon.co.uk,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <da5316a7-eee3-4c96-83dd-78ae9f3e0117@suse.cz>
 <20250619-fixpunkt-querfeldein-53eb22d0135f@brauner>
 <aFPuAi8tPcmsbTF4@kernel.org>
 <20250619-ablichten-korpulent-0efe2ddd0ee6@brauner>
 <aFQATWEX2h4LaQZb@kernel.org> <aFV3-sYCxyVIkdy6@google.com>
 <20250623-warmwasser-giftig-ff656fce89ad@brauner>
 <aFleB1PztbWy3GZM@infradead.org> <aFleJN_fE-RbSoFD@infradead.org>
 <c0cc4faf-42eb-4c2f-8d25-a2441a36c41b@suse.cz>
 <20250623142836.GT1613200@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20250623142836.GT1613200@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[googlemail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,kernel.org,google.com,amd.com,redhat.com,linux-foundation.org,paul-moore.com,zeniv.linux.org.uk,suse.cz,googlemail.com,intel.com,amazon.co.uk,vger.kernel.org,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid]
X-Spam-Level: 

On 6/23/25 16:28, Peter Zijlstra wrote:
> On Mon, Jun 23, 2025 at 04:21:15PM +0200, Vlastimil Babka wrote:
>> On 6/23/25 16:01, Christoph Hellwig wrote:
>> > On Mon, Jun 23, 2025 at 07:00:39AM -0700, Christoph Hellwig wrote:
>> >> On Mon, Jun 23, 2025 at 12:16:27PM +0200, Christian Brauner wrote:
>> >> > I'm more than happy to switch a bunch of our exports so that we only
>> >> > allow them for specific modules. But for that we also need
>> >> > EXPOR_SYMBOL_FOR_MODULES() so we can switch our non-gpl versions.
>> >> 
>> >> Huh?  Any export for a specific in-tree module (or set thereof) is
>> >> by definition internals and an _GPL export if perfectly fine and
>> >> expected.
>> 
>> Peterz tells me EXPORT_SYMBOL_GPL_FOR_MODULES() is not limited to in-tree
>> modules, so external module with GPL and matching name can import.
>> 
>> But if we're targetting in-tree stuff like kvm, we don't need to provide a
>> non-GPL variant I think?
> 
> So the purpose was to limit specific symbols to known in-tree module
> users (hence GPL only).
> 
> Eg. KVM; x86 exports a fair amount of low level stuff just because KVM.
> Nobody else should be touching those symbols.
> 
> If you have a pile of symbols for !GPL / out-of-tree consumers, it
> doesn't really make sense to limit the export to a named set of modules,
> does it?
> 
> So yes, nothing limits things to in-tree modules per-se. The
> infrastructure only really cares about module names (and implicitly
> trusts the OS to not overwrite existing kernel modules etc.). So you
> could add an out-of-tree module name to the list (or have an out-of-free
> module have a name that matches a glob; "kvm-vmware" would match "kvm-*"
> for example).
> 
> But that is very much beyond the intention of things.

So AFAIK we have a way to recognize out of tree modules when loading, as
there's a taint just for that. Then the same mechanism could perhaps just
refuse loading them if they use any _FOR_MODULES() export, regardless of
name? Then the _GPL_ part would become implicit and redundant and we could
drop it as Christoph suggested?




