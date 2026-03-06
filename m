Return-Path: <linux-fsdevel+bounces-79571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JyhOk8vqmmLMwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 02:35:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 602AF21A438
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 02:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3985E3023D9C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 01:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E2831618C;
	Fri,  6 Mar 2026 01:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnAvm6H/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F31C288B1
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 01:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772760900; cv=none; b=g72SPRETTVulnnpmCcI8T7r4Z/K4ZWVbBlGGaZTIJRLAuTebfOjoWeQqXgy6F99bt0sxdQbEB9CgxWW8Vd9jwz5izDQu7VECRPDvvUniC/FHPotf8OIyhQ5kD7TWMMumATZ3m9SrL3tWrg6JqBqf3INd+W1UxFIjPpaB0JfNJh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772760900; c=relaxed/simple;
	bh=n7wt7hIpUgkpLh7qrcxUyR5cI+SSH/bMqKvGx1mkwaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lD7zreHHg2RUzblBkSyMhXkQjV9YU2dEUY7ESyFp39GJz/GLb+CMo+D3MPug8baX/+fyml8x1YLPSD4mJ6N79bSN+oonOIiDNfOD5c8/MEZY08LKZK/JuUxJkUdzPIBpjLXEato3OVL3B9e15eZDLjtI9owWPjAo9lCzTSmAcWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnAvm6H/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6952C116C6;
	Fri,  6 Mar 2026 01:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772760900;
	bh=n7wt7hIpUgkpLh7qrcxUyR5cI+SSH/bMqKvGx1mkwaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rnAvm6H/9/6nQ31YB8F3dc7VDZGZ5nT/rU/nIj9F1XGAoZcC29eiEWk3ZXprLatwK
	 +BMvmVA4CocRRnQtFkjxyahsXYCWz75T57OOQkTBY5xz6LlKm2OTgCm3UtcK6ks1fG
	 4N/h+T2foaHhxy58VSlDOxWlogJgVfkIC1CxSe7c55WNltuF2iO+ouFVqCRtVvNlDd
	 shZOq6GYUT2PKMLZ/AZP8RxCNaOPR7A7pm27TmbhbMmYYh6EJSI3tA0eleVziBiRLR
	 wetP+37/4k9r7N3mbAZgYw1YOrV9Lm5lfTMqLeCrqMt+AU60znV25dM5m7GrAGH3Ie
	 3PPW5rIi5X5tA==
From: SeongJae Park <sj@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add mm-related procfs files to MM sections
Date: Thu,  5 Mar 2026 17:34:52 -0800
Message-ID: <20260306013453.90906-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305-maintainers-proc-v1-1-d6d09b3db3b6@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 602AF21A438
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79571-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux-mm.org:url]
X-Rspamd-Action: no action

On Thu, 05 Mar 2026 09:26:29 +0100 "Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:

> Some procfs files are very much related to memory management so let's
> have MAINTAINERS reflect that.
> 
> Add fs/proc/meminfo.c to MEMORY MANAGEMENT - CORE.
> 
> Add fs/proc/task_[no]mmu.c to MEMORY MAPPING.
> 
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

I have a few trivial comments below.  Regardless of those,

Acked-by: SeongJae Park <sj@kernel.org>

> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3553554019e8..39987895bcfc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16683,6 +16683,7 @@ F:	include/linux/ptdump.h
>  F:	include/linux/vmpressure.h
>  F:	include/linux/vmstat.h
>  F:	include/trace/events/zone_lock.h
> +F:	fs/proc/meminfo.c

Should we sort files alphabetically, and hence put this before 'include/...' ?

I see a few other MAINTAINERS sections including 'MEMORY MANGEMENT -
USERFAULTFD' are doing so.  I have no strong opinion, though.

>  F:	kernel/fork.c
>  F:	mm/Kconfig
>  F:	mm/debug.c
> @@ -16998,6 +16999,8 @@ S:	Maintained
>  W:	http://www.linux-mm.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>  F:	include/trace/events/mmap.h
> +F:	fs/proc/task_mmu.c
> +F:	fs/proc/task_nommu.c

Ditto.


Thanks,
SJ

[...]

