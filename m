Return-Path: <linux-fsdevel+bounces-75746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +O07EAIyemlo4gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:57:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B719AA4CFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 031A43018C03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 15:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988BF308F2E;
	Wed, 28 Jan 2026 15:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z5g8en+G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z2XN42P5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z5g8en+G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z2XN42P5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047EC2F261C
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615438; cv=none; b=T3ed5jrc1j0kgFFwL1QKDraHF2hQ7ALDrj2jlcFeqy1doWRk81bfefrt/krdaxuusCAhVp4qALG/2augWS7GiZ10yWSA1q7PB5Ac8ftILY9qmmEJv4WxdRTFdSfYdZQwf7lz0+KahNFch/SgVQ5xGAetaFjOwFC94IK6N551VYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615438; c=relaxed/simple;
	bh=iyQen4kHMeY5R1IIq2Dm1TwMlZ5OjkcGXrt3gs801qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccHd7piKa0DDqWw0jaS3D98T4uWaucUleegqSHorHK7XRm0gGESKSSzK4zBHYWdkCCjgmcOhj/osmC8+ygln2+Yuvx9X/Uz8CFMF5tgAAfBgB2itRomW8jcGpKvEFU8od+aRkDf2TKkP9rfJ8cjO9GgerKJRUSiiDRttKm9TfPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z5g8en+G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z2XN42P5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z5g8en+G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z2XN42P5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 624FF5BCCA;
	Wed, 28 Jan 2026 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769615426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W5xl2haCUI0hSbDXGPGJjYXdaOWzaQKGtYWRQOCdGmk=;
	b=z5g8en+G05pnMaNrzzDCXnf1qOdMVROErfW2cjLmhjMwUBS3nqT7MqPjMQ1soQOw95TLTo
	Xuu1CJXJHDc4ykhi5dXEd8DlyHOU/VPbnkfrQyMvP403e5vyhMNr2RE5XHX5nWp9NGKcPU
	HO4Eh1la/o/z3buNY93rhoQIoFEkvdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769615426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W5xl2haCUI0hSbDXGPGJjYXdaOWzaQKGtYWRQOCdGmk=;
	b=z2XN42P5bGin/nEWebti+qMt69kcoJ1HxWoyBX5Ra2kIqBIQTO0F8xPzWqOas0ufx5A+2R
	jhMG61Ostvk8GKAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=z5g8en+G;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=z2XN42P5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769615426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W5xl2haCUI0hSbDXGPGJjYXdaOWzaQKGtYWRQOCdGmk=;
	b=z5g8en+G05pnMaNrzzDCXnf1qOdMVROErfW2cjLmhjMwUBS3nqT7MqPjMQ1soQOw95TLTo
	Xuu1CJXJHDc4ykhi5dXEd8DlyHOU/VPbnkfrQyMvP403e5vyhMNr2RE5XHX5nWp9NGKcPU
	HO4Eh1la/o/z3buNY93rhoQIoFEkvdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769615426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W5xl2haCUI0hSbDXGPGJjYXdaOWzaQKGtYWRQOCdGmk=;
	b=z2XN42P5bGin/nEWebti+qMt69kcoJ1HxWoyBX5Ra2kIqBIQTO0F8xPzWqOas0ufx5A+2R
	jhMG61Ostvk8GKAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E04173EA61;
	Wed, 28 Jan 2026 15:50:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k2B9MzwwemlHUQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 28 Jan 2026 15:50:20 +0000
Date: Wed, 28 Jan 2026 15:50:19 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Yury Norov <ynorov@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Christian Koenig <christian.koenig@amd.com>, 
	Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>, 
	Matthew Brost <matthew.brost@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Benjamin LaHaise <bcrl@kvack.org>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, Tony Luck <tony.luck@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Dave Martin <Dave.Martin@arm.com>, 
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>, 
	Carlos Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Jann Horn <jannh@google.com>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-erofs@lists.ozlabs.org, 
	linux-ext4@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev, 
	devel@lists.orangefs.org, linux-xfs@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 00/13] mm: add bitmap VMA flag helpers and convert all
 mmap_prepare to use them
Message-ID: <wqtf6zwf72i5mmq4jxzea5lg7nziinqrm7eyou6n76ticah4py@ju4i4mndzsr2>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
 <aXjDaN4pwEyyBy-I@yury>
 <5f764622-fd45-4c49-8ecb-7dc4d1fa48d6@lucifer.local>
 <aXkv7DSUbdY-RD5d@yury>
 <c7452c5f-e42f-4595-8680-bd1d5726be38@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7452c5f-e42f-4595-8680-bd1d5726be38@lucifer.local>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,linux-foundation.org,kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_FROM(0.00)[bounces-75746-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pfalcato@suse.de,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[94];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B719AA4CFF
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 09:33:44AM +0000, Lorenzo Stoakes wrote:
> On Tue, Jan 27, 2026 at 04:36:44PM -0500, Yury Norov wrote:
> > On Tue, Jan 27, 2026 at 02:40:03PM +0000, Lorenzo Stoakes wrote:
> > > On Tue, Jan 27, 2026 at 08:53:44AM -0500, Yury Norov wrote:
> > > > On Thu, Jan 22, 2026 at 04:06:09PM +0000, Lorenzo Stoakes wrote:
> >
> > ...
> >
> > > > Even if you expect adding more flags, u128 would double your capacity,
> > > > and people will still be able to use language-supported operation on
> > > > the bits in flag. Which looks simpler to me...
> > >
> > > u128 isn't supported on all architectures, VMA flags have to have absolutely
> >
> > What about big integers?
> >
> >         typedef unsigned _BitInt(VMA_FLAGS_COUNT) vma_flags_t
> 
> There is no use of _BitInt anywhere in the kernel. That seems to be a
> C23-only feature with limited compiler support that we simply couldn't use
> yet.
> 
> https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2025/p3639r0.html tells
> me that it's supported in clang 16+ and gcc 14+.
> 
> We cannot put such a restriction on compilers in the kernel, obviously.
> 
> >
> > > We want to be able to arbitrarily extend this as we please in the future. So
> > > using u64 wouldn't buy us _anything_ except getting the 32-bit kernels in line.
> >
> > So enabling 32-bit arches is a big deal, even if it's a temporary
> > solution. Again, how many flags in your opinion are blocked because of
> > 32-bit integer limitation? How soon 64-bit capacity will get fully
> > used?
> 
> In my opinion? I'm not sure where my opinion comes into this? There are 43 VMA
> flags and 32-bits available in 32-bit kernels.
> 
> As I said to you before Yury, when adding new flags you have to add a whole
> load of mess of #ifdef CONFIG_64BIT ... #endif etc. around things that have
> nothing to do with 64-bit vs 32-bit architecture as a result.
> 
> It's a mess, we've run out.
> 
> Also something that might not have occurred to you - there is a chilling
> effect of limited VMA flag availability - the bar to adding flags is
> higher, and features that might have used VMA flags but need general kernel
> support (incl. 32-bit) have to find other ways to store state like this.
> 

For the record, I fully agree with all of the points you made. I don't think
it makes sense to hold this change back waiting for a feature that right
now is relatively unobtainable (also IIRC the ABI around _BitInt was a bit
unstable and confusing in general, I don't know if that changed).

The goals are to:
1) get more than sizeof(unsigned long) * 8 flags so we don't have to uglify
and gatekeep things behind 64-bit. Also letting us use VMA flags more freely.
2) not cause any performance/codegen regression

Yes, the current patchset (and the current state of things too) uglifies
things a bit, but it also provides things like type safety which are sorely
needed here. And which 128-bit integers, or N-bit integers would not provide.

And if any of the above suddenly become available to us in the future, it
will be trivial to change because the VMA flags types will be fully
encapsulated with proper accessors.

Or perhaps we'll rewrite it all in rust by the end of the decade and this is
all a moot point, who knows ;)

-- 
Pedro

