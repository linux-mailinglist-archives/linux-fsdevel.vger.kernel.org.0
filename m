Return-Path: <linux-fsdevel+bounces-12262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A25A85DA06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 14:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 223DC281EC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 13:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FAD7E795;
	Wed, 21 Feb 2024 13:24:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010F377A03;
	Wed, 21 Feb 2024 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521878; cv=none; b=HJMf4ud2APrl9phXI67yP6dXxszslsG2KYI8FTzKw7pWQqTJBqNsSOAGJl9yCsDRkvYoKag0CYMs5lxjad7zyFLgbPJWWEhpeMEsdT4D22/DEvy+OO3CCRJdI8vcSrM04VT1c9HT8HfDC1DUhvvAEGI0rdTSOsLz89qI8GXjiXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521878; c=relaxed/simple;
	bh=KrK7iNq4+GifJCxvrxb6wK+cw9XXTFp9UkvXE9nlj2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mjUwELkP4XNUbeDxIOFWSIQq75GbvZ6iq86MNK12kT9dJSjJPO8tyP98s0ReiOviQp7XBbhNu9LUbD45NQu3SbKRHwhJdij1EJ+pD4JmpvjHDhwrUyf2YAA62rIrND/AtjgHhYoB9tsjXHQm2KCGcguxOFnVc4Vxljr9fD7BLO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 41LDLFIf072277;
	Wed, 21 Feb 2024 22:21:15 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Wed, 21 Feb 2024 22:21:15 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 41LDL68M072234
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 21 Feb 2024 22:21:14 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c5bd4224-8c97-4854-a0d6-253fcd8bd92b@I-love.SAKURA.ne.jp>
Date: Wed, 21 Feb 2024 22:21:04 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 31/35] lib: add memory allocations report in show_mem()
To: Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
        Kent Overstreet <kent.overstreet@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>, Michal Hocko <mhocko@suse.com>,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net,
        void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com, axboe@kernel.dk,
        mcgrof@kernel.org, masahiroy@kernel.org, nathan@kernel.org,
        dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev,
        rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com,
        yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
        hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, bristot@redhat.com,
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
References: <Zc3X8XlnrZmh2mgN@tiehlicka>
 <CAJuCfpHc2ee_V6SGAc_31O_ikjGGNivhdSG+2XNcc9vVmzO-9g@mail.gmail.com>
 <Zc4_i_ED6qjGDmhR@tiehlicka>
 <CAJuCfpHq3N0h6dGieHxD6Au+qs=iKAifFrHAMxTsHTcDrOwSQA@mail.gmail.com>
 <ruxvgrm3scv7zfjzbq22on7tj2fjouydzk33k7m2kukm2n6uuw@meusbsciwuut>
 <320cd134-b767-4f29-869b-d219793ba8a1@suse.cz>
 <efxe67vo32epvmyzplmpd344nw2wf37azicpfhvkt3zz4aujm3@n27pl5j5zahj>
 <20240215180742.34470209@gandalf.local.home>
 <20240215181648.67170ed5@gandalf.local.home>
 <20240215182729.659f3f1c@gandalf.local.home>
 <mi5zw42r6c2yfg7fr2pfhfff6hudwizybwydosmdiwsml7vqna@a5iu6ksb2ltk>
 <CAJuCfpEARb8t8pc8WVZYB=yPk6G_kYGmJTMOdgiMHaYYKW3fUA@mail.gmail.com>
 <e017b7bc-d747-46e6-a89d-4ce558ed79b0@suse.cz>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <e017b7bc-d747-46e6-a89d-4ce558ed79b0@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/02/21 3:27, Vlastimil Babka wrote:
> I'm sure more such scenarios exist, Cc: Tetsuo who I recall was an expert on
> this topic.

"[PATCH v3 10/35] lib: code tagging framework" says that codetag_lock_module_list()
calls down_read() (i.e. sleeping operation), and
"[PATCH v3 31/35] lib: add memory allocations report in show_mem()" says that
__show_mem() calls alloc_tags_show_mem_report() after kmalloc(GFP_ATOMIC) (i.e.
non-sleeping operation) but alloc_tags_show_mem_report() calls down_read() via
codetag_lock_module_list() !?

If __show_mem() might be called from atomic context (e.g. kmalloc(GFP_ATOMIC)),
this will be a sleep in atomic bug.
If __show_mem() might be called while semaphore is held for write,
this will be a read-lock after write-lock deadlock bug.

Not the matter of whether to allocate buffer statically or dynamically.
Please don't hold a lock when trying to report memory usage.


