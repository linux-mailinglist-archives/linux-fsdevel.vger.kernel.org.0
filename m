Return-Path: <linux-fsdevel+bounces-61713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4F5B59299
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 11:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73D8323552
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 09:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2066A2882B8;
	Tue, 16 Sep 2025 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K65Bx6sn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s+q/lPMQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K65Bx6sn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s+q/lPMQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D125828A3F8
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 09:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758015952; cv=none; b=soPXRRZa/EkCNLCoe7kR+ZYECZNBmMwN6FLWuWqWnxDTjGsY0D5YLJgZGHmG7JgD3aZSsBpxGJJb76lhCpz+eAoz6nhe7cfo3XjV4tDHSHMR8oJ31aBUAM0ncuFxuk8UjIxbcq1KmznTyINja55TrW89joM5qAqyWqn5gdENxqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758015952; c=relaxed/simple;
	bh=lWnSe1pV0Ful5u/fWF13PXLlDM6P7YcSgGp/5IvU0sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZL2XnMOL1d/2Y3FDYCwRThpWEBOVv5uPJ44LoCzuTFlXNu/6/ewLOJmjcUOIm78wCK5JES7WxUr5E/SKmoBOgnxqbOqmjIX0paRkrodDlBBAU+rRMa5Mo7Q6c1IkEFHSwpNFP2bULdzKgyRQDYm/+Dg/2sWFRLZpTAHJO29RAM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K65Bx6sn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s+q/lPMQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K65Bx6sn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s+q/lPMQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0F0EB229B4;
	Tue, 16 Sep 2025 09:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758015949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5oCU9M02aU9Dmr9fi7iWYb6ulEbsfk24rHf2PZ4f6ns=;
	b=K65Bx6snDj8aGtx3uk0hpU3UuFWQxNh+kSu5kW/d2PmF+YMm4doF3EzSukzv8G9tmKlzZp
	kS5nzKgodqpGpgFJSnAWtM0G+vKj5jkmuZ7Ie9X27H4PQMZajeY8Hr6dxA+h64/0+rDYZf
	9dTXxaLMPUEikbSt/5CA1b4wThkhBS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758015949;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5oCU9M02aU9Dmr9fi7iWYb6ulEbsfk24rHf2PZ4f6ns=;
	b=s+q/lPMQNDvYqbcNUv9cxVllj/4LZhw7lsUjq9p3o5Wdr3t8BlyJ2hTD5O0Nj+LW6Loki3
	doMwA+VJdxT/bvBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=K65Bx6sn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="s+q/lPMQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758015949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5oCU9M02aU9Dmr9fi7iWYb6ulEbsfk24rHf2PZ4f6ns=;
	b=K65Bx6snDj8aGtx3uk0hpU3UuFWQxNh+kSu5kW/d2PmF+YMm4doF3EzSukzv8G9tmKlzZp
	kS5nzKgodqpGpgFJSnAWtM0G+vKj5jkmuZ7Ie9X27H4PQMZajeY8Hr6dxA+h64/0+rDYZf
	9dTXxaLMPUEikbSt/5CA1b4wThkhBS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758015949;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5oCU9M02aU9Dmr9fi7iWYb6ulEbsfk24rHf2PZ4f6ns=;
	b=s+q/lPMQNDvYqbcNUv9cxVllj/4LZhw7lsUjq9p3o5Wdr3t8BlyJ2hTD5O0Nj+LW6Loki3
	doMwA+VJdxT/bvBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7BEC139CB;
	Tue, 16 Sep 2025 09:45:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HvRYMcoxyWgWPwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 16 Sep 2025 09:45:46 +0000
Date: Tue, 16 Sep 2025 10:45:45 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org, 
	lorenzo.stoakes@oracle.com, david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	kernel-team@android.com, android-mm@google.com, stable@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/7] mm: fix off-by-one error in VMA count limit checks
Message-ID: <ekawpt644ur6grvw5a6mqxzssyxxjo5mcfzxxe7vkjevge4yze@36zxeivutuk5>
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-2-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915163838.631445-2-kaleshsingh@google.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 0F0EB229B4
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[35];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[to_ip_from(RLg31yqq1xypujqsbh8raoa6zf)];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email]
X-Spam-Score: -4.01

On Mon, Sep 15, 2025 at 09:36:32AM -0700, Kalesh Singh wrote:
> The VMA count limit check in do_mmap() and do_brk_flags() uses a
> strict inequality (>), which allows a process's VMA count to exceed
> the configured sysctl_max_map_count limit by one.
> 
> A process with mm->map_count == sysctl_max_map_count will incorrectly
> pass this check and then exceed the limit upon allocation of a new VMA
> when its map_count is incremented.
> 
> Other VMA allocation paths, such as split_vma(), already use the
> correct, inclusive (>=) comparison.
> 
> Fix this bug by changing the comparison to be inclusive in do_mmap()
> and do_brk_flags(), bringing them in line with the correct behavior
> of other allocation paths.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: <stable@vger.kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

Looks good, thanks!

-- 
Pedro

