Return-Path: <linux-fsdevel+bounces-1271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC027D8C10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 01:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C251C20FD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 23:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2413FB0A;
	Thu, 26 Oct 2023 23:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Eb1gIXVa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RqNiSkrn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0043E01E;
	Thu, 26 Oct 2023 23:05:53 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0CB1AB;
	Thu, 26 Oct 2023 16:05:51 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1698361548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=301JXjESu5nnVpLjEelVyjL0FjP4Jn3OGJNIUK28IQU=;
	b=Eb1gIXVaXmAnj6Vz5I5vcFWzDPXOSmvemJ25H8m6l0iIfUCVbejjE5Y7/gMXNjhx38wFSY
	RJVefBKehaEbHZC0xz/csfH7mbPsNSfYiCauGm2dkY44hd+k+9U6KMD5ojDdWRkeQJsrx/
	OV5SFLjgRLZOJiENHih/gRvsbWHp/OChDTcIMU2L2YOCFQ+alGJLgavDwv76UXYnm4FUqt
	mexY2UyN7A2yUcVKqUOOjL5oBsfz83nAndyc/X3E1zmQtBIV0PTUFh30pySJK6spbDflP8
	y3bd6T8hJ4kPQd3jB2y/dX8ppdTvZDmpjnDFyPySE+c/jTPIO1DJJA2RSkx7MQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1698361548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=301JXjESu5nnVpLjEelVyjL0FjP4Jn3OGJNIUK28IQU=;
	b=RqNiSkrnkwZTXyqqspVxXRlYFLHhxLB+hajtQnaflb0qL/La0rOh7/J5t3jx5IjGn+PrXi
	2bcUxpuqUgAyUpDA==
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
 vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
 mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
 liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
 peterz@infradead.org, juri.lelli@redhat.com, ldufour@linux.ibm.com,
 catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
 david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
 masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
 muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
 pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
 dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
 keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com,
 gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
 penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
 glider@google.com, elver@google.com, dvyukov@google.com,
 shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
 rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
 kernel-team@android.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 28/39] timekeeping: Fix a circular include dependency
In-Reply-To: <CAJuCfpH1pG513-FUE_28MfJ7xbX=9O-auYUjkxKLmtve_6rRAw@mail.gmail.com>
References: <20231024134637.3120277-1-surenb@google.com>
 <20231024134637.3120277-29-surenb@google.com> <87h6me620j.ffs@tglx>
 <CAJuCfpH1pG513-FUE_28MfJ7xbX=9O-auYUjkxKLmtve_6rRAw@mail.gmail.com>
Date: Fri, 27 Oct 2023 01:05:48 +0200
Message-ID: <87jzr93rxv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26 2023 at 18:33, Suren Baghdasaryan wrote:
> On Wed, Oct 25, 2023 at 5:33=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> > This avoids a circular header dependency in an upcoming patch by only
>> > making hrtimer.h depend on percpu-defs.h
>>
>> What's the actual dependency problem?
>
> Sorry for the delay.
> When we instrument per-cpu allocations in [1] we need to include
> sched.h in percpu.h to be able to use alloc_tag_save(). sched.h

Including sched.h in percpu.h is fundamentally wrong as sched.h is the
initial place of all header recursions.

There is a reason why a lot of funtionalitiy has been split out of
sched.h into seperate headers over time in order to avoid that.

Thanks,

        tglx

