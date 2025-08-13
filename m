Return-Path: <linux-fsdevel+bounces-57683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B0BB2472A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 12:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B69517C775
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 10:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A792F2909;
	Wed, 13 Aug 2025 10:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HCmlWVyZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB842EFDA9;
	Wed, 13 Aug 2025 10:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755080853; cv=none; b=POvuFkW+yh4h99seeeB0DKomsBHNqHApJDKsCm3mzWHeozzDV8t95iIltTXn8ZAY2Knrb1kAxSHNg5MoTmxWf+X12+/BaIoiPAtvgZbE7/1/ZGf3Px8mAFcIVIOkq5XfTLZl/bkDtvEQUbOb+Gqz4/25q/Vic6VENc4EsYK43kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755080853; c=relaxed/simple;
	bh=raAUt700aF4iEiVGZZ0EI59rwZJovsb5RsBpfTUdZ+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bcvac8dcr1m8E1pfrMemGrUIu4sRQQB8sAfp/6vKBRavN4se0XgUnseso6TqxUheWUzPwTOn7eBFJQCuttHq7psJGkEadPptv34UpU4yac6+B+vBZzJlq/UqDGKT6oQkBHmeZv6gggPaUMiCCWfUwammZ6IbEhYebkSaJXqxdtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=HCmlWVyZ; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gYwoVXG6EVtDNB7BQEDc+4ji6UVSTCEFJFvpf+ftEnk=; b=HCmlWVyZpwxvhNFdFqNNQ1MltH
	tzABBEfLYpc9Z9qWBJh1OgVAO9NfXYc9RUKHPbVQcDbgjfxUeGjIc+gLalwrT0cICox6QAd+0AAJj
	W419et1dlc7204Vkn3KBNChVJGqHaErmA1/acfm+Q8ZXv3qGtLy1uD0jplLJqg2xAcUY1Skt61mK7
	Wu382QfV2GCUkSm7ikgYakGa771LzswGReNsFAuf8bsCFK+1TZ78hHBk5aMakoWa15EphPruqzssP
	CKEJAIcrh0JWCeAnACZV73MgzabyydXmM8NL2zPDk9mI/Wac8wrfGNNnfLSrtJvhalc2IYDJpxAha
	h3NB4vIg==;
Received: from [223.233.74.188] (helo=[192.168.1.12])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1um8hZ-00Dchg-7i; Wed, 13 Aug 2025 12:27:25 +0200
Message-ID: <b6e63336-aa39-dcf3-3f7c-ac90dea127b7@igalia.com>
Date: Wed, 13 Aug 2025 15:57:17 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v7 3/4] treewide: Replace 'get_task_comm()' with
 'strscpy_pad()'
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Bhupesh <bhupesh@igalia.com>
Cc: akpm@linux-foundation.org, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
 laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
 alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
 mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org,
 david@redhat.com, viro@zeniv.linux.org.uk, keescook@chromium.org,
 ebiederm@xmission.com, brauner@kernel.org, jack@suse.cz, mingo@redhat.com,
 juri.lelli@redhat.com, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, linux-trace-kernel@vger.kernel.org, kees@kernel.org,
 torvalds@linux-foundation.org
References: <20250811064609.918593-1-bhupesh@igalia.com>
 <20250811064609.918593-4-bhupesh@igalia.com>
 <aJoGvv5TEfl1liSm@black.igk.intel.com>
From: Bhupesh Sharma <bhsharma@igalia.com>
In-Reply-To: <aJoGvv5TEfl1liSm@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/11/25 8:35 PM, Andy Shevchenko wrote:
> On Mon, Aug 11, 2025 at 12:16:08PM +0530, Bhupesh wrote:
>> As Linus mentioned in [1], we should get rid of 'get_task_comm()'
>> entirely and replace it with 'strscpy_pad()' implementation.
>>
>> 'strscpy_pad()' will already make sure comm is NUL-terminated, so
>> we won't need the explicit final byte termination done in
>> 'get_task_comm()'.
>>
>> The relevant 'get_task_comm()' users were identified using the
>> following search pattern:
>>   $ git grep 'get_task_comm*'
>> [1]. https://lore.kernel.org/all/CAHk-=wi5c=_-FBGo_88CowJd_F-Gi6Ud9d=TALm65ReN7YjrMw@mail.gmail.com/
>>
>> Signed-off-by: Bhupesh <bhupesh@igalia.com>
> Make that a Link tag?
>
>    Link: https://lore.kernel.org/all/CAHk-=wi5c=_-FBGo_88CowJd_F-Gi6Ud9d=TALm65ReN7YjrMw@mail.gmail.com/ #1
>    Signed-off-by: Bhupesh <bhupesh@igalia.com>
>

Sure, will include it in next version. Waiting for further reviews on 
this v7.

Thanks.

