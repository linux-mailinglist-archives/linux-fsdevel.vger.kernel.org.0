Return-Path: <linux-fsdevel+bounces-69092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E11C6F10A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 14:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8B4650531C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 13:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340663612CA;
	Wed, 19 Nov 2025 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RMWOXnF/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9LYejATv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RMWOXnF/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9LYejATv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C502235F8CA
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763558835; cv=none; b=Pgzy6OiYYr2sD2ueOcfbzDDU5bqMD72LZWpi7R53WxJczuiJ/TI0Aveau1R8HSULnwJ/QXMFO5zvUITF+FqXnPWJzd3HNzet/Pn/oagmxrP0hEGw8NHrwXsLIACXLIaBsBwpsn2/iXiNCHoGXE4XQdHHz7S00y40EvNYHvP6lqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763558835; c=relaxed/simple;
	bh=atfchYGWfOCiDBgRzlxK4SjGe18cMWhMQruGelsdE74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5IVb60NR0kXnHv06qNil2QEPzbVz78N9Ay5emqbmTp96iqThDSVenVUHje2bMaThNUQ6r6W9/NvVXoH+5UYjtR8vddAPz3evQ/r1TkcEyz9D7WLKPqYUPMOZApvLaI08zL/Ii7kEAZcDLy6InihwY9KDbm+x4TzV8iuNBbekpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RMWOXnF/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9LYejATv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RMWOXnF/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9LYejATv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1DF202122F;
	Wed, 19 Nov 2025 13:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763558832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pQ44aemiqJtq0zuhYxg46Kkv6bvog9XT2UPmBVw0jms=;
	b=RMWOXnF/ZNFkgMlOeBmixrq5P+Jky/xvy/zWvHNTcg2baoZYZUB4kLAyTLQHYQLNNUxnE9
	BYPR/O6m4Q5pHJm3SRZi7hEwLL7f2LHn7gfzSMpbSgiGgt3fXJYQH/arQ+gewvWAUt4kIa
	u71FSPx6juE+l1yS8fvxYJxBijv/A9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763558832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pQ44aemiqJtq0zuhYxg46Kkv6bvog9XT2UPmBVw0jms=;
	b=9LYejATvmFovj4posftKnmnywuSGp3r7VTCOjjB+7yjVLxPMUHMF6HNd8YUzKj7pHJxX5k
	EB4N0NtjKCDF2NDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763558832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pQ44aemiqJtq0zuhYxg46Kkv6bvog9XT2UPmBVw0jms=;
	b=RMWOXnF/ZNFkgMlOeBmixrq5P+Jky/xvy/zWvHNTcg2baoZYZUB4kLAyTLQHYQLNNUxnE9
	BYPR/O6m4Q5pHJm3SRZi7hEwLL7f2LHn7gfzSMpbSgiGgt3fXJYQH/arQ+gewvWAUt4kIa
	u71FSPx6juE+l1yS8fvxYJxBijv/A9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763558832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pQ44aemiqJtq0zuhYxg46Kkv6bvog9XT2UPmBVw0jms=;
	b=9LYejATvmFovj4posftKnmnywuSGp3r7VTCOjjB+7yjVLxPMUHMF6HNd8YUzKj7pHJxX5k
	EB4N0NtjKCDF2NDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B21B3EA62;
	Wed, 19 Nov 2025 13:27:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nnHREq7FHWl4NgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 19 Nov 2025 13:27:10 +0000
Date: Wed, 19 Nov 2025 13:27:08 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Hildenbrand <david@redhat.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jann Horn <jannh@google.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v3 3/8] mm: implement sticky VMA flags
Message-ID: <4dodae73i5ganur6llvbbxcojt4uailsxs6sr5w2jr4a7tzxkf@26rmrmcdjvlz>
References: <cover.1762531708.git.lorenzo.stoakes@oracle.com>
 <1ee529ff912f71b3460d0d21bc5b32ca89d63513.1762531708.git.lorenzo.stoakes@oracle.com>
 <25cb4b6a-035b-4193-a8db-685fc4c58507@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25cb4b6a-035b-4193-a8db-685fc4c58507@sirena.org.uk>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RLikzfga1gh8n9q3k5e6mrznp7)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,lwn.net,redhat.com,suse.cz,kernel.org,google.com,suse.com,goodmis.org,efficios.com,nvidia.com,linux.alibaba.com,arm.com,linux.dev,vger.kernel.org,kvack.org,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Wed, Nov 19, 2025 at 01:16:36PM +0000, Mark Brown wrote:
> On Fri, Nov 07, 2025 at 04:11:48PM +0000, Lorenzo Stoakes wrote:
> > It is useful to be able to designate that certain flags are 'sticky', that
> > is, if two VMAs are merged one with a flag of this nature and one without,
> > the merged VMA sets this flag.
> 
> I'm seeing regressions on multiple arm64 platforms in at least the LTP
> clone302 and madvise10 selftests, both of which have bisected to one of
> the fixups to this patch.  Especially given the other tests that also
> bisected to the same place I've not investigated further.  There's a
> number of other LTP tests that started failing today including relevant
> seeming ones munlockall01, mprotect04, madvise10, mprotect03 and
> futex_cmp_requeue01 but I don't have bisects to confirm they're the same
> thing.
>

Thanks for the reports!
 
> clone302:
> 
> tst_buffers.c:57: TINFO: Test is using guarded buffers
> tst_tmpdir.c:316: TINFO: Using /tmp/LTP_clorMwMMw as tmpdir (nfs filesystem)
> tst_test.c:1953: TINFO: LTP version: 20250530
> tst_test.c:1956: TINFO: Tested kernel: 6.18.0-rc6-next-20251119 #1 SMP PREEMPT @1763523415 aarch64

next-20251119 still has the v3 version of the patchset, which is Known Bad(tm)
after a couple of buggy fixups. v4 should hopefully work properly.

-- 
Pedro

