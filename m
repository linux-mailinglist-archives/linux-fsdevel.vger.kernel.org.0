Return-Path: <linux-fsdevel+bounces-11585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06B4854F35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 17:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C1E1283612
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 16:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1464E60867;
	Wed, 14 Feb 2024 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aP6eNqCb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D951604BC;
	Wed, 14 Feb 2024 16:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929752; cv=none; b=gGg+zAVWRgws+NTYmPwWrAovxhn7j8f0KKes6Gkd/GavkUhdolVF2sv+0dc78MQCYTzMwRiXalKX2EmfQ5WxnVYXlNbKnNx8bDAFK9WkiK4igkaMOaSSyDV9jcdpCbFujXblAF/uDCY9+B+Dk4cvjw2GFaahNjQNvXvnMIdNvPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929752; c=relaxed/simple;
	bh=Z1j0awbyiMqQJioymUvLXxMTBT0EGAz3kMP8dpbtft4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Qh9x31qTahDzxkLEMayQnWXSWt+TevPz6hxOoQrQIItZMqc9r7xlbL1eI74g8OvOmZ6i7JChSdKYxlSBcEANUssaXbHFOMXIpr7GFOzJi44h4/VkwGB1KrS8IVRdEcNIVH5fnHojpQQGObcAYPflsykxYsS3F+unmt/gX2XScNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aP6eNqCb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F71C433C7;
	Wed, 14 Feb 2024 16:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1707929751;
	bh=Z1j0awbyiMqQJioymUvLXxMTBT0EGAz3kMP8dpbtft4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aP6eNqCb/UgW05i+ulED3dJ38CFlbF46c9ImepcRNWw3cqV444ebJY3dOVwDX0TpF
	 Zry6nkCkfDuDtI3bkVsahvhtqzq0e6p7PwaST0Yzxnx6S2AOkZW5cKbC+D8uj2KfhL
	 cXIdI5wkzTTOR16ASzaWYyPLnnwcg8bFmbhrKB3U=
Date: Wed, 14 Feb 2024 08:55:48 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, David Hildenbrand
 <david@redhat.com>, Michal Hocko <mhocko@suse.com>, vbabka@suse.cz,
 hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
 dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
 corbet@lwn.net, void@manifault.com, peterz@infradead.org,
 juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org,
 arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
 axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
 nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev,
 rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com,
 yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
 hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
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
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
Message-Id: <20240214085548.d3608627739269459480d86e@linux-foundation.org>
In-Reply-To: <CAJuCfpF4g1jeEwHVHjQWwi5kqS-3UqjMt7GnG0Kdz5VJGyhK3Q@mail.gmail.com>
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
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Feb 2024 14:59:11 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> > > If you think you can easily achieve what Michal requested without all that,
> > > good.
> >
> > He requested something?
> 
> Yes, a cleaner instrumentation. Unfortunately the cleanest one is not
> possible until the compiler feature is developed and deployed. And it
> still would require changes to the headers, so don't think it's worth
> delaying the feature for years.

Can we please be told much more about this compiler feature? 
Description of what it is, what it does, how it will affect this kernel
feature, etc.

Who is developing it and when can we expect it to become available?

Will we be able to migrate to it without back-compatibility concerns? 
(I think "you need quite recent gcc for memory profiling" is
reasonable).



Because: if the maintainability issues which Michel describes will be
significantly addressed with the gcc support then we're kinda reviewing
the wrong patchset.  Yes, it may be a maintenance burden initially, but
at some (yet to be revealed) time in the future, this will be addressed
with the gcc support?


