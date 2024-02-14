Return-Path: <linux-fsdevel+bounces-11559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D3A854BD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 15:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA2B1F218A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 14:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE1A5B21C;
	Wed, 14 Feb 2024 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="G/fg/fXE";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="G/fg/fXE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A9A5A7A1;
	Wed, 14 Feb 2024 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707921998; cv=none; b=KQETrUM356GJ2vQ4poPqlxNI+Dvae8ZHloc0sbA4BQmOTKjnWAZnQLWRTwlTB1t4o4Yg+ER1YA1iwe0jC1k04Mfgj7uNr0ncaM6hHjk/gceqc3qg5Pvpj7aNDAAb4PU2qa7LgEXN3kpEG3qGmxkVraJYAOy3EXf7CgUymV1Ttmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707921998; c=relaxed/simple;
	bh=rn+ZMoLKcmq4pEsTZ8FfVyz+GcEVWfCdy4jk0Bj7Vas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXERSHB6uegeowSjpX1dgwEIpPBH1XWEuc3ex94HAxlGZTK4gkS/9aPjG7sT3uyxgHx/hHKL3qJE4m61z4iBju3dHLSCrZ3zgl6K/Kfi1Rbj5uPOlM0j4YrCZSBsGptuTw9nuKddg0QPWccuuhzpCMfIllD7296epUEQdBGXlAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=G/fg/fXE; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=G/fg/fXE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AABE1220CA;
	Wed, 14 Feb 2024 14:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707921994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L7XYt0NyV1LLmmYXD5SRXg7RDztZSN4xXat2vk9BckU=;
	b=G/fg/fXE/BxmwJaDpB5G6+sbfW69+fMUQ0OzLitvcmHEv1Ds8G+GL4LdouO/fwIfpKsqYP
	K1h5IhLHPiF9QIXH9zu5TsmsC3q6YrtzaT+6raFWjZBU+43wC0WrFSHBXIgYFSN3RNg2dN
	Cy4YpNtjfnssPK+JWHc4gG9YwWLpq0E=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707921994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L7XYt0NyV1LLmmYXD5SRXg7RDztZSN4xXat2vk9BckU=;
	b=G/fg/fXE/BxmwJaDpB5G6+sbfW69+fMUQ0OzLitvcmHEv1Ds8G+GL4LdouO/fwIfpKsqYP
	K1h5IhLHPiF9QIXH9zu5TsmsC3q6YrtzaT+6raFWjZBU+43wC0WrFSHBXIgYFSN3RNg2dN
	Cy4YpNtjfnssPK+JWHc4gG9YwWLpq0E=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C19613A72;
	Wed, 14 Feb 2024 14:46:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Hbm4GUrSzGUzGAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 14 Feb 2024 14:46:34 +0000
Date: Wed, 14 Feb 2024 15:46:33 +0100
From: Michal Hocko <mhocko@suse.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	kent.overstreet@linux.dev, vbabka@suse.cz, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, peterx@redhat.com, david@redhat.com,
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com,
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
	elver@google.com, dvyukov@google.com, shakeelb@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
Message-ID: <ZczSSZOWMlqfvDg8@tiehlicka>
References: <20240212213922.783301-1-surenb@google.com>
 <20240214062020.GA989328@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214062020.GA989328@cmpxchg.org>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="G/fg/fXE"
X-Spamd-Result: default: False [-0.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 BAYES_HAM(-0.00)[26.79%];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_GT_50(0.00)[73];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[google.com,linux-foundation.org,linux.dev,suse.cz,suse.de,stgolabs.net,infradead.org,oracle.com,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RCVD_IN_DNSWL_HI(-1.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.31
X-Rspamd-Queue-Id: AABE1220CA
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Wed 14-02-24 01:20:20, Johannes Weiner wrote:
[...]
> I agree we should discuss how the annotations are implemented on a
> technical basis, but my take is that we need something like this.

I do not think there is any disagreement on usefulness of a better
memory allocation tracking. At least for me the primary problem is the
implementation. At LFSMM last year we have heard that existing tracing
infrastructure hasn't really been explored much. Cover letter doesn't
really talk much about those alternatives so it is really hard to
evaluate whether the proposed solution is indeed our best way to
approach this.

> In a codebase of our size, I don't think the allocator should be
> handing out memory without some basic implied tracking of where it's
> going. It's a liability for production environments, and it can hide
> bad memory management decisions in drivers and other subsystems for a
> very long time.

Fully agreed! It is quite common to see oom reports with a large portion
of memory unaccounted and this really presents additional cost on the
debugging side.

-- 
Michal Hocko
SUSE Labs

