Return-Path: <linux-fsdevel+bounces-48753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA2EAB3970
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 15:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AFD917F5B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 13:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A1A2951BA;
	Mon, 12 May 2025 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rqlqwpxY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TVLRb/iM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MeYp35Dy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6tBEbYPw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E35265632
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 13:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747057057; cv=none; b=mdSV2JGLH2ORdxOl907SjVps8PymoNDD04NpPu/eaObEhuE85QLaMuXloklc7JA7ARbb7xFMiRrMRje5LApSkd/ukMMmcQJFHqcNVbirwrmwUMYAt6tzzr+RdF1PYyADnKaeOvJ6ZuvBC+NPIPWMOR69taxpEPvZlThOXlGa0wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747057057; c=relaxed/simple;
	bh=VjaFsJKrEN9Uqf2591BKI2pEMYemOjP3DnnZ2fcUpug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L/H6LbaXFbDk+t/2IqLzi1uRNmz6bTkm6ITF4sWy/xGEPzuApwXiANg7leERUMKAaOPUPM6pyfSj5y8kHZWLBpKuhB793EmiJefctGHI2rV5HFsIJwGUHOrfveUR8KnsCrn5+YQovZSkskq7ETF14wmC1aJuq+l6zzMNShWVtVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rqlqwpxY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TVLRb/iM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MeYp35Dy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6tBEbYPw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D2DF921180;
	Mon, 12 May 2025 13:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747057054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JROcxVkua+4AIgLxyA/F6RSaVGE9I8Kot2UvFgn8FMY=;
	b=rqlqwpxY/5Yqv1eWbuwp99XqS+kfuJvDV+GqO21Cy3zjvJJyI3s4mcFqkXjj6aaMNEpR4v
	dhhGcQ1FlkTtYrG/lrF9ldxB6pki5aMyMzQgR1yLoNyrNf8LAyigAsZ3FNXJ/i7BEszfEd
	ne/FroC5nlH+paObG/qn3Qpa5aol2Ok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747057054;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JROcxVkua+4AIgLxyA/F6RSaVGE9I8Kot2UvFgn8FMY=;
	b=TVLRb/iM7Z60T426PPm8ySXDc22+ebXwEhmLphOjXy1GZnGZmbLOMPSzbY6u0D31Zdxj7b
	kxfaMCh0FV4uF4Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747057053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JROcxVkua+4AIgLxyA/F6RSaVGE9I8Kot2UvFgn8FMY=;
	b=MeYp35Dy3PGxhehnvRbdcqcXJMzNk2XpvU6G6F2I6apnekFkBmngzb0yLZh1Xt1A2dGC7A
	VcgGeyNIDPBm88jAk4OvIeQk3OH56Ot67PenQKPLspKHilNS5Doo1NXJVKpE7oyrOThb6A
	XlNXS7dZq4uJdRrfbBC3H2Wik97oSww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747057053;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JROcxVkua+4AIgLxyA/F6RSaVGE9I8Kot2UvFgn8FMY=;
	b=6tBEbYPw5EsNjfo81Wq8VZBWh5iOShS5f4xTq4o9tgjz2Q2ikIWwxn6tGZFKAgAfrU4D+O
	msmgGevynHj7CiCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACC9A137D2;
	Mon, 12 May 2025 13:37:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id svnWKZ35IWiqKwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 12 May 2025 13:37:33 +0000
Message-ID: <bddc6930-fd82-489b-b1fd-03949822f53d@suse.cz>
Date: Mon, 12 May 2025 15:37:33 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mm: introduce new .mmap_prepare() file callback
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>
References: <cover.1746792520.git.lorenzo.stoakes@oracle.com>
 <adb36a7c4affd7393b2fc4b54cc5cfe211e41f71.1746792520.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <adb36a7c4affd7393b2fc4b54cc5cfe211e41f71.1746792520.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid]

On 5/9/25 14:13, Lorenzo Stoakes wrote:
> Provide a means by which drivers can specify which fields of those
> permitted to be changed should be altered to prior to mmap()'ing a
> range (which may either result from a merge or from mapping an entirely new
> VMA).
> 
> Doing so is substantially safer than the existing .mmap() calback which
> provides unrestricted access to the part-constructed VMA and permits
> drivers and file systems to do 'creative' things which makes it hard to
> reason about the state of the VMA after the function returns.
> 
> The existing .mmap() callback's freedom has caused a great deal of issues,
> especially in error handling, as unwinding the mmap() state has proven to
> be non-trivial and caused significant issues in the past, for instance
> those addressed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
> error path behaviour").
> 
> It also necessitates a second attempt at merge once the .mmap() callback
> has completed, which has caused issues in the past, is awkward, adds
> overhead and is difficult to reason about.
> 
> The .mmap_prepare() callback eliminates this requirement, as we can update
> fields prior to even attempting the first merge. It is safer, as we heavily
> restrict what can actually be modified, and being invoked very early in the
> mmap() process, error handling can be performed safely with very little
> unwinding of state required.
> 
> The .mmap_prepare() and deprecated .mmap() callbacks are mutually
> exclusive, so we permit only one to be invoked at a time.
> 
> Update vma userland test stubs to account for changes.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


