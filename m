Return-Path: <linux-fsdevel+bounces-76938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JPFOu5ujGlmngAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 12:58:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5259124052
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 12:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3143E3017F9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 11:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4929D3168F5;
	Wed, 11 Feb 2026 11:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DJn80o38";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p57vAmPA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DAD30C606;
	Wed, 11 Feb 2026 11:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770811109; cv=none; b=OeloPdDnBlVE2SF191yObnGuk5mqT2mdgvzeLyomIRndQfMHUXto0Nkws8MLv3FQoFAza4YhjCL+aDizUCHT5Fs6T3saxk7E8C+EAzqD8Yu7PE99QxChwNnraWGOXg0gEohVz4F72eDw328AhCcH25kznw46EzoKFqBCquWdFj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770811109; c=relaxed/simple;
	bh=zr3MiutzhWaZjG4hDTVgD0xZJccWstD8tcmqGo++ZpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7cBhlUi1d9C2FSlGmw41LGQMZfAYPegg5/hr8B4QYfoFuqwvGLgKptrQK7kLhtRnBRiDpp4NnuzSIqAx7CvitlB3BKPAVTwmqzRPl67DVl3PPR1kWIGOD/jseEeoezIEhktvv+1443EfVrUvx84umj832bJnaiJJfxykW4P+Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DJn80o38; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p57vAmPA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Feb 2026 12:58:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770811107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=401OE8SAJcURYtUs2WuI0jXB1BL2uOQgKfCJza+V2mE=;
	b=DJn80o382/xqN2eyGM3D+jFIQMWpP43a1JACdOfNJeSkOjTYziG+HsVpBJJQkJbAqZaOiT
	MTtuQ4vbTvpWM1vqxELc1zgfrRaNxMJunOOLozgqTxGhlm5lwPJzW4LkHv5vSdKAdsVeh3
	pMHKbSEwDcgNqk1LbgmQjpoQcxsn7kioBQtY/YsGfWdrMg0UNQnsuIatbETqMXzxYOXvnO
	k8Ef6MN5uTOHMlPnepc6EuY+tcNy8rfBp6iX95RiBFS4ckm2IeHpQVFqnkqas4oE62v4SW
	fU3qW6hvmTNVHg1E89+R+adFq6I5CxTUdP4qYhiNnOnrlM6EIQ3/FHiYrxi9wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770811107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=401OE8SAJcURYtUs2WuI0jXB1BL2uOQgKfCJza+V2mE=;
	b=p57vAmPAp83gMS8x5VUkXVCWGuo6Q17M+UAIpRXv0YYau23eYBT4wVT8id4ewF1gtn1VSk
	G0OeHsuyK+d/5RDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org, surenb@google.com, shakeel.butt@linux.dev,
	syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com,
	syzbot+237b5b985b78c1da9600@syzkaller.appspotmail.com,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] procfs: Prevent double mmput() in do_procmap_query()
Message-ID: <20260211115825.MLF4L4Jq@linutronix.de>
References: <20260129215340.3742283-1-andrii@kernel.org>
 <87qzqsa1br.ffs@tglx>
 <CAEf4BzZHktcrxO0_PnMer-oEsAm++R4VZKj-gCmft-mVi58P8g@mail.gmail.com>
 <87ikc49unc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ikc49unc.ffs@tglx>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76938-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux-foundation.org,kvack.org,vger.kernel.org,google.com,linux.dev,syzkaller.appspotmail.com,infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel,4e70c8e0a2017b432f7a,237b5b985b78c1da9600];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim,linutronix.de:email,appspotmail.com:email]
X-Rspamd-Queue-Id: A5259124052
X-Rspamd-Action: no action

On 2026-02-10 22:05:27 [+0100], Thomas Gleixner wrote:
> A recent fix moved the build ID evaluation past the mmput() of the success
> path but kept the error goto unchanged, which ends up in doing another
> quert_vma_teardown() and another mmput().
> 
> Change the goto so it jumps past the mmput() and only puts the file and
> the buffer.
> 
> Fixes: b5cbacd7f86f ("procfs: avoid fetching build ID while holding VMA lock")
> Reported-by: syzbot+237b5b985b78c1da9600@syzkaller.appspotmail.com
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Closes: https://lore.kernel.org/698aaf3c.050a0220.3b3015.0088.GAE@google.com/T/#u

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

