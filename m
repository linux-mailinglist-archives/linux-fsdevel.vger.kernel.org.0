Return-Path: <linux-fsdevel+bounces-12166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 927FC85C292
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 18:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C582870BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 17:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6060779F0;
	Tue, 20 Feb 2024 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aQPLcI4/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aQPLcI4/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1E976C82;
	Tue, 20 Feb 2024 17:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708449890; cv=none; b=Il2W840uKasOt0PHrDDttI672612nuxmKIrhYRmmnhHIbHUf3pQEqgIJYwf1jSh3o91LZD3qJ/45IooyMXz1kEiWObJ9qwBfEg57iMIPq3PfpcAKpCi+yoZIdm3wkvqMMOCVYx8ddagNJb0LFp6O80+hKbcoMawKezR0uPTPB3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708449890; c=relaxed/simple;
	bh=DYjAtTcdrA+3yesjLjiOa6zarg7f3lq4MltEqsSmWOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1RnTKwei0iOn9c4NrPwy6ba6aROFBSrJVRIVHClybyvesuLQHTMxUIHjmr6YcqZSA1BhELpJTjYCjxcEh4TpkatRSgVzmdR4TcsyU5QntN987UTZVQYf7P2xf6pXaTM8Gfmg816So72EmSSBERyBaQJJ6wtAzDDWsEKSMHM47E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aQPLcI4/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aQPLcI4/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A8C5B1F8B8;
	Tue, 20 Feb 2024 17:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708449886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t4AkBXTli0JY+7cZt6wPmw2DkCGDriEpGC9jORxnoKQ=;
	b=aQPLcI4/9mO6h+uCLy+F3vNbFo6yXpPd/kXfM+5ZnJNsPgONEm+fGYam9wlNYQvJimo99P
	+SAr8KwfOoVjHcH0ALF1D1eYEDiZ9wAyVZwxfrVBPLbxVh+WaqgnBEfqD0DDgVJrYF6lMD
	BFjx8NjxiaAUF0F1u10keYk1Bn26A3E=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708449886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t4AkBXTli0JY+7cZt6wPmw2DkCGDriEpGC9jORxnoKQ=;
	b=aQPLcI4/9mO6h+uCLy+F3vNbFo6yXpPd/kXfM+5ZnJNsPgONEm+fGYam9wlNYQvJimo99P
	+SAr8KwfOoVjHcH0ALF1D1eYEDiZ9wAyVZwxfrVBPLbxVh+WaqgnBEfqD0DDgVJrYF6lMD
	BFjx8NjxiaAUF0F1u10keYk1Bn26A3E=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A510134E4;
	Tue, 20 Feb 2024 17:24:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A2RRHV7g1GXZYwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 20 Feb 2024 17:24:46 +0000
Date: Tue, 20 Feb 2024 18:24:41 +0100
From: Michal Hocko <mhocko@suse.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
	corbet@lwn.net, void@manifault.com, peterz@infradead.org,
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org,
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
	masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org,
	tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
	paulmck@kernel.org, pasha.tatashin@soleen.com,
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
	ndesaulniers@google.com, vvvvvv@google.com,
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com,
	cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
	42.hyeyoo@gmail.com, glider@google.com, elver@google.com,
	dvyukov@google.com, shakeelb@google.com, songmuchun@bytedance.com,
	jbaron@akamai.com, rientjes@google.com, minchan@google.com,
	kaleshsingh@google.com, kernel-team@android.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v3 31/35] lib: add memory allocations report in show_mem()
Message-ID: <ZdTgWb7eNtF4hLw2@tiehlicka>
References: <ruxvgrm3scv7zfjzbq22on7tj2fjouydzk33k7m2kukm2n6uuw@meusbsciwuut>
 <320cd134-b767-4f29-869b-d219793ba8a1@suse.cz>
 <efxe67vo32epvmyzplmpd344nw2wf37azicpfhvkt3zz4aujm3@n27pl5j5zahj>
 <20240215180742.34470209@gandalf.local.home>
 <20240215181648.67170ed5@gandalf.local.home>
 <20240215182729.659f3f1c@gandalf.local.home>
 <mi5zw42r6c2yfg7fr2pfhfff6hudwizybwydosmdiwsml7vqna@a5iu6ksb2ltk>
 <CAJuCfpEARb8t8pc8WVZYB=yPk6G_kYGmJTMOdgiMHaYYKW3fUA@mail.gmail.com>
 <ZdTSAWwNng9rmKtg@tiehlicka>
 <qnpkravlw4d5zic4djpku6ffghargekkohsolrnus3bvwipa7g@lfbucg3r4zbz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qnpkravlw4d5zic4djpku6ffghargekkohsolrnus3bvwipa7g@lfbucg3r4zbz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.00)[14.10%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_GT_50(0.00)[73];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[google.com,goodmis.org,suse.cz,linux-foundation.org,cmpxchg.org,linux.dev,suse.de,stgolabs.net,infradead.org,oracle.com,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

On Tue 20-02-24 12:18:49, Kent Overstreet wrote:
> On Tue, Feb 20, 2024 at 05:23:29PM +0100, Michal Hocko wrote:
> > On Mon 19-02-24 09:17:36, Suren Baghdasaryan wrote:
> > [...]
> > > For now I think with Vlastimil's __GFP_NOWARN suggestion the code
> > > becomes safe and the only risk is to lose this report. If we get cases
> > > with reports missing this data, we can easily change to reserved
> > > memory.
> > 
> > This is not just about missing part of the oom report. This is annoying
> > but not earth shattering. Eating into very small reserves (that might be
> > the only usable memory while the system is struggling in OOM situation)
> > could cause functional problems that would be non trivial to test for.
> > All that for debugging purposes is just lame. If you want to reuse the code
> > for a different purpose then abstract it and allocate the buffer when you
> > can afford that and use preallocated on when in OOM situation.
> > 
> > We have always went extra mile to avoid potentially disruptive
> > operations from the oom handling code and I do not see any good reason
> > to diverge from that principle.
> 
> Michal, I gave you the logic between dedicated reserves and system
> reserves. Please stop repeating these vague what-ifs.

Your argument makes little sense and it seems that it is impossible to
explain that to you. I gave up on discussing this further with you.

Consider NAK to any additional allocation from oom path unless you can
give very _solid_ arguments this is absolutely necessary. "It's gona be
fine and work most of the time" is not a solid argument.
-- 
Michal Hocko
SUSE Labs

