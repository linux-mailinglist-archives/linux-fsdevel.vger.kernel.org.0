Return-Path: <linux-fsdevel+bounces-55560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB70B0BE20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 09:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284FD18977B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 07:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257492853EE;
	Mon, 21 Jul 2025 07:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="aGlaKLem"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57C127FD76;
	Mon, 21 Jul 2025 07:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753084390; cv=none; b=qYn2tWdw/DgjRNwIuTT6xfnxBI5S6eb0CHNnHHiMDi45m8LOca9rjNhMPOb6ZD/NNbE6VRP9HPN40OdSyKMqkEk49bhMR8FpznV3tAWFhf4Zlx3RfEaUyV+zejUJpVqhJ/spGYBvJv+IlJImGrGaDfw+auU6D1tHFP1pdEps3ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753084390; c=relaxed/simple;
	bh=6taZzycaUnmHgAcgE9pvQL2MRMhKwSli5kcHkJ69U6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bf1Q3GSLa9BYTAVPldX20iiw0YIjcLW8QidGcMpXiUgBuomOmEGQPDsiKN6cUim3zpN7qeHR6f4lsCQZc3l3HzFdjfJzOZGqcsAOAIJ7AV1J5+sT8FVd+yxsis55rp/ahML3X6GWFb0ODxeF2RMszfJ1JvtJ9GM5P753wAkUXII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=aGlaKLem; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6taZzycaUnmHgAcgE9pvQL2MRMhKwSli5kcHkJ69U6g=; b=aGlaKLem6J+XfYUM9Fc5fbVt+/
	UAoJiuIIlJG4wXgEBf+dXbaqOxifwsCMXZ7LIAvzykycbIqinXszaA9AOm89V7OlkQLtwygpjL4ju
	4C91B8gB6cqeMmsa+lPd9B3pdeaEYqTg33b3gR1dimXsRR2DLa9x77qMIU/oKnrMLxzd3pJFWAyHx
	k43YLwydDIUHuo9Yqc7GhrH+csHkLdxtuV0TvzEHufzNZrgazTveW/0oreUtP0+wchRDtET7v3YdK
	2FfTVRlVHhdCIJex/P2TLm5QNAnndXXa3xo6FPNorA6lL4ErDGCTJdbYCk07uKW/WueAC87vogO4a
	ODUhYsPw==;
Received: from [223.233.69.100] (helo=[192.168.1.12])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1udlKU-001cLF-Jl; Mon, 21 Jul 2025 09:52:58 +0200
Message-ID: <46d2007d-7318-ba57-7908-12c144cdd17a@igalia.com>
Date: Mon, 21 Jul 2025 13:22:49 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 3/3] treewide: Switch from tsk->comm to tsk->comm_str
 which is 64 bytes long
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Bhupesh <bhupesh@igalia.com>, akpm@linux-foundation.org,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
 laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
 alexei.starovoitov@gmail.com, mirq-linux@rere.qmqm.pl, peterz@infradead.org,
 willy@infradead.org, david@redhat.com, viro@zeniv.linux.org.uk,
 keescook@chromium.org, ebiederm@xmission.com, brauner@kernel.org,
 jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, linux-trace-kernel@vger.kernel.org,
 kees@kernel.org
References: <20250716123916.511889-1-bhupesh@igalia.com>
 <20250716123916.511889-4-bhupesh@igalia.com>
 <CAEf4BzaGRz6A1wzBa2ZyQWY_4AvUHvLgBF36iCxc9wJJ1ppH0g@mail.gmail.com>
 <c6a0b682-a1a5-f19c-acf5-5b08abf80a24@igalia.com>
 <CAEf4BzaJiCLH8nwWa5eM4D+n1nyCn3X-v0+W4-CwLg7hB2Wthg@mail.gmail.com>
 <CAHk-=whCDEuSH7w=zQBpGkustvis26O=_6cEdjwCanz=ig8=4g@mail.gmail.com>
From: Bhupesh Sharma <bhsharma@igalia.com>
In-Reply-To: <CAHk-=whCDEuSH7w=zQBpGkustvis26O=_6cEdjwCanz=ig8=4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

On 7/18/25 12:05 AM, Linus Torvalds wrote:
> On Wed, 16 Jul 2025 at 13:47, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>> But given how frequently task->comm is referenced (pretty much any
>> profiler or tracer will capture this), it's just the widespread nature
>> of accessing task->comm in BPF programs/scripts that will cause a lot
>> of adaptation churn. And given the reason for renaming was to catch
>> missing cases during refactoring, my ask was to do this renaming
>> locally, validate all kernel code was modified, and then switch the
>> field name back to "comm" (which you already did, so the remaining
>> part would be just to rename comm_str back to comm).
> Yes. Please.
>
> Renaming the field is a great way to have the compiler scream loudly
> of any missed cases, but keep it local (without committing it), and
> rename it back after checking everything.
>
>

Sure, I will send v6 with the above suggested change.

Thanks.

