Return-Path: <linux-fsdevel+bounces-52876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD318AE7CA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 11:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1D23ABCA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 09:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB9A29898E;
	Wed, 25 Jun 2025 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rc3VDVLg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nLuuWivq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rc3VDVLg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nLuuWivq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7567528DF36
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 09:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843121; cv=none; b=Nl268xyYsitAMU/1OYvterKgCHQOKnpvaKG6Ht4fZadtgtChG3aY7Ko2Fg/uiXbhVKf31AlZcnbq22sE8ls6uhR8CY9Kds6iImou0PI9AcGFYNgS6V4cbd29scTxbsitNWSlQmIy6YS/uh7fg6WTAwIFMCHNwavaFJ3VXebR5TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843121; c=relaxed/simple;
	bh=pGnNMMXbUfvUnMAqQyIFM2KcrRiwaKSDMDKOwOKv9n4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f2HsVRYB4Zwposlg7h/gLkMclQe/pWPjgCo6M9Bkis8LyfiZcgYnr3ExOr8mUpcjyhOrs6+ehLiiUVwWuZ0od0xD/vnSySEeeDvh1npkBSHd7EjL/7HCyuOz9pAqH6OWCoNi8uEKFkCs/NOy7rws8xC0bKY3xenWYKrfNqBWs6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rc3VDVLg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nLuuWivq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rc3VDVLg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nLuuWivq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 71C8B21175;
	Wed, 25 Jun 2025 09:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750843117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7p8V/HcjuDoXzYJew4W06L45XhBYsDDwJYVyCTKAtR8=;
	b=Rc3VDVLgmJkdVE7IY1rdd35P1l+63GkQK+HURCY02hYZtOp8gMfRtEfFUl3McII4iiHuuG
	3opGhdtf/48FGixIp6OjK7VolPLrl06fkwZmiotIW+zIxCq2YqCCSKdPaRClgph1VxFCXe
	jswurKVzsJ4cuUPqOwu4gOPo4V0EW4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750843117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7p8V/HcjuDoXzYJew4W06L45XhBYsDDwJYVyCTKAtR8=;
	b=nLuuWivqAHM/7RIZ+PbGbpWKTgudpfoifs/0i24JeJ6hLebW3FUR9O5RnwV835zXvi/+gt
	O/abH+/rNCiV7KAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Rc3VDVLg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nLuuWivq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750843117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7p8V/HcjuDoXzYJew4W06L45XhBYsDDwJYVyCTKAtR8=;
	b=Rc3VDVLgmJkdVE7IY1rdd35P1l+63GkQK+HURCY02hYZtOp8gMfRtEfFUl3McII4iiHuuG
	3opGhdtf/48FGixIp6OjK7VolPLrl06fkwZmiotIW+zIxCq2YqCCSKdPaRClgph1VxFCXe
	jswurKVzsJ4cuUPqOwu4gOPo4V0EW4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750843117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7p8V/HcjuDoXzYJew4W06L45XhBYsDDwJYVyCTKAtR8=;
	b=nLuuWivqAHM/7RIZ+PbGbpWKTgudpfoifs/0i24JeJ6hLebW3FUR9O5RnwV835zXvi/+gt
	O/abH+/rNCiV7KAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 454E913485;
	Wed, 25 Jun 2025 09:18:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id afxXEO2+W2j0LwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 25 Jun 2025 09:18:37 +0000
Message-ID: <a64404f7-9a01-4edb-b6f4-735c706abac8@suse.cz>
Date: Wed, 25 Jun 2025 11:18:37 +0200
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
To: Christian Brauner <brauner@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
 Sean Christopherson <seanjc@google.com>, Mike Rapoport <rppt@kernel.org>,
 Shivank Garg <shivankg@amd.com>, david@redhat.com,
 akpm@linux-foundation.org, paul@paul-moore.com, viro@zeniv.linux.org.uk,
 willy@infradead.org, pbonzini@redhat.com, tabba@google.com,
 afranji@google.com, ackerleytng@google.com, jack@suse.cz,
 cgzones@googlemail.com, ira.weiny@intel.com, roypat@amazon.co.uk,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <aFPuAi8tPcmsbTF4@kernel.org>
 <20250619-ablichten-korpulent-0efe2ddd0ee6@brauner>
 <aFQATWEX2h4LaQZb@kernel.org> <aFV3-sYCxyVIkdy6@google.com>
 <20250623-warmwasser-giftig-ff656fce89ad@brauner>
 <aFleB1PztbWy3GZM@infradead.org> <aFleJN_fE-RbSoFD@infradead.org>
 <c0cc4faf-42eb-4c2f-8d25-a2441a36c41b@suse.cz>
 <20250623142836.GT1613200@noisy.programming.kicks-ass.net>
 <20250624-einwickeln-geflecht-f9cc9cc67d3c@brauner>
 <20250625-blatt-lieblich-8e6896fe618b@brauner>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20250625-blatt-lieblich-8e6896fe618b@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 71C8B21175
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[googlemail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,google.com,kernel.org,amd.com,redhat.com,linux-foundation.org,paul-moore.com,zeniv.linux.org.uk,suse.cz,googlemail.com,intel.com,amazon.co.uk,vger.kernel.org,kvack.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51
X-Spam-Level: 

On 6/25/25 11:05, Christian Brauner wrote:
> On Tue, Jun 24, 2025 at 11:02:16AM +0200, Christian Brauner wrote:
> I don't understand that argument. I don't care if out-of-tree users
> abuse some symbol because:
> 
> * If they ever show up with a complaint we'll tell them to go away. 
> * If they want to be merged upstream, we'll tell them to either change
>   the code in question to not rely on the offending symbol or we decide
>   that it's ok for them to use it and allow-list them.
> 
> I do however very much care about in-tree consumers even for non-GPLd
> symbols. I want anyone who tries to use a symbol that we decided
> requires substantial arguments to be used to come to us and justify it.
> So EXPORT_*_FOR_MODULES() would certainly help with that.
> 
> The other things is that using EXPORT_SYMBOL() or even
> EXPORT_SYMBOL_GPL() sends the wrong message to other module-like
> wanna-be consumers of these functions. I'm specifically thinking about
> bpf. They more than once argued that anything exposed to modules can
> also be exposed as a bpf kfunc as the stability guarantees are
> comparable.
> 
> And it is not an insane argument. Being able to use
> EXPOR_SYMBOL_FOR_MODULES() would also allow to communicate "Hey, this
> very much just exists for the purpose of this one-off consumer that
> really can't do without it or without some other ugly hack.".
> 
> Because this is where the pain for us is: If you do large-scale
> refactorings (/me glares at Al, Christoph, and in the mirror) the worst
> case is finding out that some special-purpose helper has grown N new
> users with a bunch of them using it completely wrong and now having to
> massage core code to not break something that's technically inherently
> broken.
> 
> Out-of-tree consumers have zero relevance for all of this. For all I
> care they don't exist. It's about the maintainers ability to chop off
> the Kraken's tentacles.

Then I think you can just use EXPORT_SYMBOL_GPL_FOR_MODULES() as it is
today. It's intended for a particular in-tree module, which is by definition
going to be GPL. I doubt anyone will come complaining that you've cut off
their ability to fake the name of the in-tree module while having non-GPL
license. So I don't really see the danger of causing holy license wars
there. The _FOR_MODULES() part is restricting enough even without _GPL_.

But if we can indeed enforce in-tree-ness and drop _GPL_ from the name, it
would be cleaner IMHO.


