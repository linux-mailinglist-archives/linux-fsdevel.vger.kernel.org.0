Return-Path: <linux-fsdevel+bounces-46073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD3DA8239C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 13:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC35D3A8AF3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 11:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2011B25E445;
	Wed,  9 Apr 2025 11:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="c7FFw26W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EED625DCE9;
	Wed,  9 Apr 2025 11:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744198283; cv=none; b=fLOOWmC4H1qaYc38LL2DMaqxIgkjhktl0w6h/y7rp10j7ky0nelGoDcZkHoj3gU8iZtTJKGakch9nrj9J1x//NhxwWWBtZokFY1urBZEdKRAkpsMbYNNTPHSWgwJkZwVa79j4m675Bczpw/BXOyTDoHdNGUF5thfAZ4v9umgdDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744198283; c=relaxed/simple;
	bh=FLV91CEpQSeUuhyrf6X7Y7S8BnEVeMNhFp42arzdGXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AaLzr1q3DDJeywLw1dG2tyLwRE/3G7pjr7jr/j03RJcJuh10TW03M0zBXCA1TMf6LppRlgjxoHZSKoDwQhU51pc8UCQuwPg5LLFrTioYUJrCL+nbhvTrrn/Y0+lMJCUnHrbXYzuKiReAWBPxN4WFnGh3tr8nqYlPjqsXrYqeTt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=c7FFw26W; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FLV91CEpQSeUuhyrf6X7Y7S8BnEVeMNhFp42arzdGXU=; b=c7FFw26WRc/QcDvoT6DswQt2BF
	pjsKo96k8Jhg6DT1jL3A3zD7qVhGe56ZplefRjSMaFlWqNTwbLQVraOPY49tPDM7zeU44PESHMfKG
	a59aze3NrikVXGDVi4+CrVzjqoWsgU7OGjCTRVcdk+VPwWVwA2UAXDKxq+vFcWmOs+DIFo2q9r+XK
	eSrJ8D+dW0Tfh3UD5XamwRVfJSKNz+CMdWCkDyNXcf+MTE3Pd05g6qYN9pQ5F3vzXTtd3ySDlnBFa
	8wcaYPrekUWunloaKUrUeOwDomnHCLi0UXfRP2Lt/LbuaND8CCQeZBvZMZG77BT7guBdM/HYNq1Hs
	NvbHA9ww==;
Received: from [223.233.71.56] (helo=[192.168.1.12])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1u2TeA-00E4Ri-Pl; Wed, 09 Apr 2025 13:31:11 +0200
Message-ID: <35b4fe2a-606c-f25c-0d5c-1abb6e7b3003@igalia.com>
Date: Wed, 9 Apr 2025 17:01:05 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/3] exec: Dynamically allocate memory to store task's
 full name
Content-Language: en-US
To: Kees Cook <kees@kernel.org>
Cc: Bhupesh <bhupesh@igalia.com>, akpm@linux-foundation.org,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
 laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
 alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
 mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org,
 david@redhat.com, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
 brauner@kernel.org, jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
References: <20250331121820.455916-1-bhupesh@igalia.com>
 <20250331121820.455916-2-bhupesh@igalia.com>
 <202504030924.50896AD12@keescook>
 <3202d24e-b155-ab0a-86cd-0a3204ec52dd@igalia.com>
 <202504041023.A21FA17DDC@keescook>
From: Bhupesh Sharma <bhsharma@igalia.com>
In-Reply-To: <202504041023.A21FA17DDC@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kees,

Sorry for the delay - I was out for a couple of days.

On 4/4/25 10:54 PM, Kees Cook wrote:
> On Fri, Apr 04, 2025 at 12:18:56PM +0530, Bhupesh Sharma wrote:
>> In another review for this series, Yafang mentioned the following cleanup +
>> approach suggested by Linus (see [0]).
>> Also I have summarized my understanding on the basis of the suggestions
>> Linus shared and the accompanying background threads (please see [1]).
>>
>> Kindly share your views on the same, so that I can change the implementation
>> in v3 series accordingly.
> In thinking about this a little more I think we can't universally change
> all the APIs to use the new full_name since it is a pointer, which may
> be getting changed out from under readers if a setter changes it. So
> this may need some careful redesign, likely with RCU. hmm.
>

Thinking more about this, Linus mentioned in [0]:

'Since user space can randomly change their names anyway, using locking
was always wrong for readers (for writers it probably does make sense
to have some lock'

So, if we go with the union approach, probably we can do with just a writer-lock, whereas if we go with a task->full_name like pointer one, we would probably need a rcu lock.

Please let me know your comments.

[0]. https://lore.kernel.org/all/CAHk-=wivfrF0_zvf+oj6==Sh=-npJooP8chLPEfaFV0oNYTTBA@mail.gmail.com/


