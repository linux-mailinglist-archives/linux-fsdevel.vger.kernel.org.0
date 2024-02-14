Return-Path: <linux-fsdevel+bounces-11552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D64854A70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 14:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1A51F24A95
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 13:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7084054FAC;
	Wed, 14 Feb 2024 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QIjP+FW0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OBUSsdFQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FD053E3C;
	Wed, 14 Feb 2024 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707917018; cv=none; b=AiTGgEax5k9syfobuixqE/rDkXY5NvVqc9EGEBtUfR6LoqyIwbLSw/RBIe86KFpZ2mWRgyHp9ncYqf/akZdd8to7hRzPh/WF/8VfSSc3zZ0vr7EPPmiOAYb2EeytQzQyohc3ci6XNLmel/0jCEl+egI6GfEIYApDMadZzlv8TFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707917018; c=relaxed/simple;
	bh=sY0l/MGP0ifFOugFFWAqZ7Hx7MbEo7MwiddTrEtgeQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wndm2RlOuT47VvZYnYwB1NqV7VhuEMW/h+dvb61v9IibeuHKXtRAXy8pV6hU5xwZ64qg7aWdurfQmke0InA1og+AyS+zIjZCNkQUScvqV5BNPcFK+eGcIUoXN4OcaLCQNOkGiJLXq0D3dqEr8kk2Cdpi3frJzGoPoQQyRH7W4SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QIjP+FW0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OBUSsdFQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D31DF1F805;
	Wed, 14 Feb 2024 13:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707917015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qRJr10qi9dh6XG3cKWhF0aOO8OAegvJYwUfC6v4k4/c=;
	b=QIjP+FW0aJkhheVbf//vZhksU2INykO7/VOPppfdDhlA8ab8RELtSf6gqTd+z5hBz+cImh
	Ag2WHlhQPZ7ipV7H+3rxUDaRunemOqRJYdbe+SFp68BRkmSDMmmTuO66EPnKF235szRR0M
	6+MEPV4zNbKf6fX6JKzfxnlJ9udu5jw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707917014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qRJr10qi9dh6XG3cKWhF0aOO8OAegvJYwUfC6v4k4/c=;
	b=OBUSsdFQY6/ONFq+SLJJgV5pbl7Y3+GUbhOdsQryZFyzRxPfavV+WWownngLZMDVoUdtvl
	mMFT3Y4YdP8ZMxzDVLuXUAjuYpnODYwyabYbRa6y3dXx4Ssf6YdRjpvaSzGdhyT9F9amUo
	SYxHabq46Dmuft16HAcTuJYIQ1qgEYo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EEC513A6D;
	Wed, 14 Feb 2024 13:23:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 13hAJta+zGWQeAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 14 Feb 2024 13:23:34 +0000
Date: Wed, 14 Feb 2024 14:23:34 +0100
From: Michal Hocko <mhocko@suse.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, peterx@redhat.com, axboe@kernel.dk,
	mcgrof@kernel.org, masahiroy@kernel.org, nathan@kernel.org,
	dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev,
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com,
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
	ndesaulniers@google.com, vvvvvv@google.com,
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
Message-ID: <Zcy-1nScrEI_q0w7@tiehlicka>
References: <20240212213922.783301-1-surenb@google.com>
 <Zctfa2DvmlTYSfe8@tiehlicka>
 <CAJuCfpEsWfZnpL1vUB2C=cxRi_WxhxyvgGhUg7WdAxLEqy6oSw@mail.gmail.com>
 <9e14adec-2842-458d-8a58-af6a2d18d823@redhat.com>
 <2hphuyx2dnqsj3hnzyifp5yqn2hpgfjuhfu635dzgofr5mst27@4a5dixtcuxyi>
 <6a0f5d8b-9c67-43f6-b25e-2240171265be@redhat.com>
 <CAJuCfpEtOhzL65eMDk2W5SchcquN9hMCcbfD50a-FgtPgxh4Fw@mail.gmail.com>
 <adbb77ee-1662-4d24-bcbf-d74c29bc5083@redhat.com>
 <r6cmbcmalryodbnlkmuj2fjnausbcysmolikjguqvdwkngeztq@45lbvxjavwb3>
 <CAJuCfpF4g1jeEwHVHjQWwi5kqS-3UqjMt7GnG0Kdz5VJGyhK3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpF4g1jeEwHVHjQWwi5kqS-3UqjMt7GnG0Kdz5VJGyhK3Q@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_GT_50(0.00)[73];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[linux.dev,redhat.com,linux-foundation.org,suse.cz,cmpxchg.org,suse.de,stgolabs.net,infradead.org,oracle.com,lwn.net,manifault.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Tue 13-02-24 14:59:11, Suren Baghdasaryan wrote:
> On Tue, Feb 13, 2024 at 2:50 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Tue, Feb 13, 2024 at 11:48:41PM +0100, David Hildenbrand wrote:
[...]
> > > If you think you can easily achieve what Michal requested without all that,
> > > good.
> >
> > He requested something?
> 
> Yes, a cleaner instrumentation.

Nope, not really. You have indicated you want to target this version for the
_next_ merge window without any acks, really. If you want to go
forward with this then you should gain a support from the MM community
at least. Why? Because the whole macro layering is adding maintenance
cost for MM people.

I have expressed why I absolutely hate the additional macro layer. We
have been through similar layers of macros in other areas (not to
mention page allocator interface itself) and it has _always_ turned out
a bad idea long term. I do not see why this case should be any
different.

The whole kernel is moving to a dynamic tracing realm and now we
are going to build a statically macro based tracing infrastructure which
will need tweaking anytime real memory consumers are one layer up the
existing macro infrastructure (do not forget quite a lot of allocations
are in library functions) and/or we need to modify the allocator API
in some way. Call me unimpressed!

Now, I fully recognize that the solution doesn't really have to be
perfect in order to be useful. Hence I never NAKed it even though I really
_dislike_ the approach. I have expected you will grow the community
support over time if this is indeed the only feasible approach but that
is not reflected in the series posted here. If you find a support I will
not stand in the way.

> Unfortunately the cleanest one is not
> possible until the compiler feature is developed and deployed. And it
> still would require changes to the headers, so don't think it's worth
> delaying the feature for years.

I am pretty sure you have invested a non-trivial time into evaluating
other ways, yet your cover letter is rather modest about any details:
:  - looked at alternate hooking methods.
:    There were suggestions on alternate methods (compiler attribute,
:    trampolines), but they wouldn't have made the patchset any cleaner
:    (we still need to have different function versions for accounting vs. no
:    accounting to control at which point in a call chain the accounting
:    happens), and they would have added a dependency on toolchain
:    support.

First immediate question would be: What about page_owner? I do remember
the runtime overhead being discussed but I do not really remember any
actual numbers outside of artificial workloads. Has this been
investigated? Is our stack unwinder the problem? Etc.

Also what are the biggest obstacles to efficiently track allocations via
our tracing infrastructure? Has this been investigated? What were conclusions?
-- 
Michal Hocko
SUSE Labs

