Return-Path: <linux-fsdevel+bounces-11125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFFB8517BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 16:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28D31283171
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 15:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B909C3C493;
	Mon, 12 Feb 2024 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X5naKi5g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wvaAtq9g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833861DFD9;
	Mon, 12 Feb 2024 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751005; cv=none; b=AzrgTtK71O9YRdcVUfPQFFnOpjcahObwyhW06TqlKb1ReCR75bxFiBgNLKK6mVe95Fy60KmBK/fFC9Ljdb0LNAe2uLkcmB4FhvhJSmL3D8iCySebt5cP2OQSIkL93jMtLNFG3tTgr30jD5fHPO1930EJsFy1GG4kb7j6RIr6i74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751005; c=relaxed/simple;
	bh=3chvmobw0WIhPXp502BMUquxmX0WkgFAgr4Y5a+BiK4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E12dH9Twj5lcQMU9sGIbIdvXe/rO7jxaQ3uGY3fyrMxW2/8CM5aXvZ5/SVnW1pWcHc+a6vCuxJskKY2FxaoezZNSxJWbW76EOVvosdPFpF3Hiqtps8RGGJXP2y91mRMlV+o6kq/V157GS2ZC7SwzOoMio2SgjCzO2aBMFqQkQt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X5naKi5g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wvaAtq9g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707751001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C0+9xXf1xmlpe5oi4tOOoKsJ9pZFh5ERW9flQIZRs88=;
	b=X5naKi5gLpvZkYPThLTAQgcrOgmy7YnG179d5g9Zp0omwvh7aQLVvP0+Rlpn18mGTFxMVS
	jb2OZM69peAkDCL3yF1jhi9jdM6PGkhHzdqiyNkma8rajbUwpx+HZjDXUlKVpumyENxaZ2
	LPo4BLCgiNACH4nQjgU9UuW+MEmyXZH1whNpAhisf6WmczXagVYIkUzTeheK86QtZWf9U6
	3XJjiQDuJAWk7KCjGTytUpoi1cc/0Ph1Fc7WGqbAhlZSwzb/k+buVyjqd2knVFJJqEtp9Y
	Fj381DdX3HHi1MwyJ1buO9ZUt/ECWBEkvtQedGK44DUkGfRizsz9fRj14/9l8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707751001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C0+9xXf1xmlpe5oi4tOOoKsJ9pZFh5ERW9flQIZRs88=;
	b=wvaAtq9gXWu+gOMPiuUPNIHogxDOFBTHTovmSRErtvucLMRbKc+sW6mcVW7KPtOAn9Jr0c
	FJrzz2lzCTOfMLBw==
To: Byungchul Park <byungchul@sk.com>
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
 linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
 linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
 will@kernel.org, rostedt@goodmis.org, joel@joelfernandes.org,
 sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com,
 johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
 willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
 gregkh@linuxfoundation.org, kernel-team@lge.com, linux-mm@kvack.org,
 akpm@linux-foundation.org, mhocko@kernel.org, minchan@kernel.org,
 hannes@cmpxchg.org, vdavydov.dev@gmail.com, sj@kernel.org,
 jglisse@redhat.com, dennis@kernel.org, cl@linux.com, penberg@kernel.org,
 rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
 linux-block@vger.kernel.org, josef@toxicpanda.com,
 linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 jlayton@kernel.org, dan.j.williams@intel.com, hch@infradead.org,
 djwong@kernel.org, dri-devel@lists.freedesktop.org,
 rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
 hamohammed.sa@gmail.com, 42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
 gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
 boqun.feng@gmail.com, longman@redhat.com, hdanton@sina.com,
 her0gyugyu@gmail.com
Subject: Re: [PATCH v11 14/26] locking/lockdep, cpu/hotplus: Use a weaker
 annotation in AP thread
In-Reply-To: <20240130025836.GA49173@system.software.com>
References: <20240124115938.80132-1-byungchul@sk.com>
 <20240124115938.80132-15-byungchul@sk.com> <87il3ggfz9.ffs@tglx>
 <20240130025836.GA49173@system.software.com>
Date: Mon, 12 Feb 2024 16:16:41 +0100
Message-ID: <871q9hlnl2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 30 2024 at 11:58, Byungchul Park wrote:
> On Fri, Jan 26, 2024 at 06:30:02PM +0100, Thomas Gleixner wrote:
>> On Wed, Jan 24 2024 at 20:59, Byungchul Park wrote:
>> 
>> Why is lockdep in the subsystem prefix here? You are changing the CPU
>> hotplug (not hotplus) code, right?
>> 
>> > cb92173d1f0 ("locking/lockdep, cpu/hotplug: Annotate AP thread") was
>> > introduced to make lockdep_assert_cpus_held() work in AP thread.
>> >
>> > However, the annotation is too strong for that purpose. We don't have to
>> > use more than try lock annotation for that.
>> 
>> This lacks a proper explanation why this is too strong.
>> 
>> > Furthermore, now that Dept was introduced, false positive alarms was
>> > reported by that. Replaced it with try lock annotation.
>> 
>> I still have zero idea what this is about.
>
> 1. can track PG_locked that is a potential deadlock trigger.
>
>    https://lore.kernel.org/lkml/1674268856-31807-1-git-send-email-byungchul.park@lge.com/

Sure, but that wants to be explicitely explained in the changelog and
not with a link. 'Now that Dept was introduced ...' is not an
explanation.

Thanks,

        tglx



