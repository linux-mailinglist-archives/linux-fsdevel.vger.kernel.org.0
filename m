Return-Path: <linux-fsdevel+bounces-11828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A649B85780E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 09:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CE391F219A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 08:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752E11CA8C;
	Fri, 16 Feb 2024 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yA/4iNTU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OKTSAEdQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MsHa2qgD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4HijluMb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CF01C6BC;
	Fri, 16 Feb 2024 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708073449; cv=none; b=LLP90U4AQvRvN7ugOxa1btqHgEpN/G4/myA+Ls6aXBgHbqHYfJzZ7zmvyvu0EZ+HY7XPXvZSIPapQr30mT9Gu1dzrwNzUsdMqo8nDjIyqzm4G5ZcyNPBDC4JltqFXhCX6s75UVqL/rjZNaTUTUk2WGin/6w2TaafK+g1yV3Ub8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708073449; c=relaxed/simple;
	bh=yGT4FHDQGazhdbI/CEPDEVMPDIKAQ4DhuZOaL/hilGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTy7UNLwSTqkNPhAyZBrJlqHhR2X/wPEeo8gNMWAqW4al79U3HxKu2avENQLJZOj0BkX3P1d63E3jGpDWC3qZgF0WEwcCxdH0BzqOiJi0QPGrpLm+B9Xfms8vyX9/U84HkQC/rkyUt7T32fnghIMgFRqG5x8oVACpx1xTdt2ZOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yA/4iNTU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OKTSAEdQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MsHa2qgD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4HijluMb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EB4E021F7E;
	Fri, 16 Feb 2024 08:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708073446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LvS88A1JZEeIqJIhe88zQYazuSktyNUKiwnG9k26ga0=;
	b=yA/4iNTUqEHccnKB1z66YL2dzLg6sK1GL094zaEuj86ov+1DS8px+e7N+FD+6UOoxL+hET
	a6lfnD8rSL+k5Kpa/+qQilTpVUcCW+apQ7/X8hCA0bvGBSjhiTKKM5kFasWyPCKhwvXLte
	963wM1MWXhSKnZKJcQC8iHq8r4lfbFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708073446;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LvS88A1JZEeIqJIhe88zQYazuSktyNUKiwnG9k26ga0=;
	b=OKTSAEdQiQOE8QGbehxaksfU4xFFfvbOGD6CVt9rRI12E/+Xejag/fOBwE1jxEW+sGHhKg
	icATO2U/0LamPeCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708073443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LvS88A1JZEeIqJIhe88zQYazuSktyNUKiwnG9k26ga0=;
	b=MsHa2qgDMGrpba+EungtRB3gKcd1mAeCYnHbKWGZYMw/SQvw9DiqUo9EErZ8M7sMcyP6RG
	RK6h/aPqWH9WJi4p9mZ0TqgjpGee9KRFe7uPaqgah31OZo6pY5y4FPhnqmVR6Vv6bGKkTT
	CAp5/x4fPl5c6RGeBvw0LRnpDPAKPcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708073443;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LvS88A1JZEeIqJIhe88zQYazuSktyNUKiwnG9k26ga0=;
	b=4HijluMb7Xd7CSzHohZEysAuvCcSdzvrC8J0c602jaX9pjeHwcb45OdKVf3sUKTqTBIdpa
	zRznxQnOpK6ORGAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FF7E1398D;
	Fri, 16 Feb 2024 08:50:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Na8jF+Mhz2WqYwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 16 Feb 2024 08:50:43 +0000
Message-ID: <af9eab14-367b-4832-8b78-66ca7e6ab328@suse.cz>
Date: Fri, 16 Feb 2024 09:50:43 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/35] lib: add allocation tagging support for memory
 allocation profiling
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Suren Baghdasaryan <surenb@google.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, akpm@linux-foundation.org,
 kent.overstreet@linux.dev, mhocko@suse.com, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
 willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net,
 void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
 catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
 peterx@redhat.com, david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
 masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
 muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
 pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
 dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
 ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org,
 ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
 iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
 elver@google.com, dvyukov@google.com, shakeelb@google.com,
 songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
 minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
 cgroups@vger.kernel.org
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-14-surenb@google.com>
 <202402121433.5CC66F34B@keescook>
 <CAJuCfpGU+UhtcWxk7M3diSiz-b7H64_7NMBaKS5dxVdbYWvQqA@mail.gmail.com>
 <20240213222859.GE6184@frogsfrogsfrogs>
 <CAJuCfpGHrCXoK828KkmahJzsO7tJsz=7fKehhkWOT8rj-xsAmA@mail.gmail.com>
 <202402131436.2CA91AE@keescook>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <202402131436.2CA91AE@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MsHa2qgD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4HijluMb
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.00 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 MID_RHS_MATCH_FROM(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_GT_50(0.00)[74];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,linux.dev,suse.com,cmpxchg.org,suse.de,stgolabs.net,infradead.org,oracle.com,lwn.net,manifault.com,redhat.com,arm.com,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,google.com,gmail.com,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -3.00
X-Rspamd-Queue-Id: EB4E021F7E
X-Spam-Flag: NO

On 2/13/24 23:38, Kees Cook wrote:
> On Tue, Feb 13, 2024 at 02:35:29PM -0800, Suren Baghdasaryan wrote:
>> On Tue, Feb 13, 2024 at 2:29 PM Darrick J. Wong <djwong@kernel.org> wrote:
>> >
>> > On Mon, Feb 12, 2024 at 05:01:19PM -0800, Suren Baghdasaryan wrote:
>> > > On Mon, Feb 12, 2024 at 2:40 PM Kees Cook <keescook@chromium.org> wrote:
>> > > >
>> > > > On Mon, Feb 12, 2024 at 01:38:59PM -0800, Suren Baghdasaryan wrote:
>> > > > > Introduce CONFIG_MEM_ALLOC_PROFILING which provides definitions to easily
>> > > > > instrument memory allocators. It registers an "alloc_tags" codetag type
>> > > > > with /proc/allocinfo interface to output allocation tag information when
>> > > >
>> > > > Please don't add anything new to the top-level /proc directory. This
>> > > > should likely live in /sys.
>> > >
>> > > Ack. I'll find a more appropriate place for it then.
>> > > It just seemed like such generic information which would belong next
>> > > to meminfo/zoneinfo and such...
>> >
>> > Save yourself a cycle of "rework the whole fs interface only to have
>> > someone else tell you no" and put it in debugfs, not sysfs.  Wrangling
>> > with debugfs is easier than all the macro-happy sysfs stuff; you don't
>> > have to integrate with the "device" model; and there is no 'one value
>> > per file' rule.
>> 
>> Thanks for the input. This file used to be in debugfs but reviewers
>> felt it belonged in /proc if it's to be used in production
>> environments. Some distros (like Android) disable debugfs in
>> production.
> 
> FWIW, I agree debugfs is not right. If others feel it's right in /proc,
> I certainly won't NAK -- it's just been that we've traditionally been
> trying to avoid continuing to pollute the top-level /proc and instead
> associate new things with something in /sys.

Sysfs is really a "one value per file" thing though. /proc might be ok for a
single overview file.

