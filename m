Return-Path: <linux-fsdevel+bounces-57684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB26B24735
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 12:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666D5566112
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 10:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B602F49E2;
	Wed, 13 Aug 2025 10:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZtsMR+me"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3402F3C25;
	Wed, 13 Aug 2025 10:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081012; cv=none; b=J5iGhQ36LCRIZhjSBm7kdxTwuw+qigJhzz7pKb63111l3pyYmgsGiYEcfTtRYEmSI+g7dGArRhj9nRr16x/B+7EaEXtUVOVzwCPb/jFnOwkq4B88LMMmsfkAhnJeqPqbvR7F4P1QlA1qZfUbnopuRtQNjFl6EtTVT9R30srGOn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081012; c=relaxed/simple;
	bh=b7k9zkPsDFsR6IW4Hha0aMRTPkafbCDebxekHdDEUhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HIuarLBYKXmrn+5Es+/huIEj2DFqbEa0CaWXYVM1ROBbJlgap1FxsHzjAWFdsIkaya/5eJeLUVHNCEA9ZdUG+FrPYi9WpyNI3G2aJURvlrR361d/axAMsoz/ckyY0Rq+QXKEdanMj+0NSmVCOL2N6CyeLbewCHCAxBuSnWPre08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ZtsMR+me; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lL2N3rzy3idztlSr2gXwrwvq9ilpXSh4BwMyKlX4iZ4=; b=ZtsMR+mehPPuVmA9EzTZAgr71b
	zRk/vrnpKSBIzuvdThdiipz3zee+0BL3gGCnjOOu87QWnyvxy/iebh6J9ZsNgEn+qfDDS2kJdDJlu
	BdqlJhOVLps4vcTMQY8edpo8xKKOjG9SNTLhgrNq8S3dtry03dNL6LOkgUVRFkyjXdBtNHNvntsKU
	olWbzqN+CLvtBxsLHUKArciwfJxO0HB7qYzayqQNsr4oTtmIcr2PEcVWRDy3rc8Q+KDoexLCnx8Qj
	PvHw8l0BWnVQuaqo8vH3ZhDcPZpGzq/9OMZU5wJYncVMGYlXi/p6zOH2TwqDsvdg2r89xY8fwXayi
	P358ykDA==;
Received: from [223.233.74.188] (helo=[192.168.1.12])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1um8k7-00Dcki-KG; Wed, 13 Aug 2025 12:30:03 +0200
Message-ID: <6af1a8b5-1c10-06b1-a368-a685a7e21e15@igalia.com>
Date: Wed, 13 Aug 2025 15:59:55 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v7 2/4] include: Set tsk->comm length to 64 bytes
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
 <20250811064609.918593-3-bhupesh@igalia.com>
 <aJoHzTKO9xw2CANn@black.igk.intel.com>
From: Bhupesh Sharma <bhsharma@igalia.com>
In-Reply-To: <aJoHzTKO9xw2CANn@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/11/25 8:40 PM, Andy Shevchenko wrote:
> On Mon, Aug 11, 2025 at 12:16:07PM +0530, Bhupesh wrote:
>> Historically due to the 16-byte length of TASK_COMM_LEN, the
>> users of 'tsk->comm' are restricted to use a fixed-size target
>> buffer also of TASK_COMM_LEN for 'memcpy()' like use-cases.
>>
>> To fix the same, we now use a 64-byte TASK_COMM_EXT_LEN and
>> set the comm element inside 'task_struct' to the same length:
>>         struct task_struct {
>> 	       .....
>>                 char    comm[TASK_COMM_EXT_LEN];
>> 	       .....
>>         };
>>
>>         where TASK_COMM_EXT_LEN is 64-bytes.
>>
>> Note, that the existing users have not been modified to migrate to
>> 'TASK_COMM_EXT_LEN', in case they have hard-coded expectations of
>> dealing with only a 'TASK_COMM_LEN' long 'tsk->comm'.
> ...
>
>> -	BUILD_BUG_ON(sizeof(from) != TASK_COMM_LEN);	\
>> +	BUILD_BUG_ON(sizeof(from) < TASK_COMM_LEN);	\
> Wondering if we may convert this to static_assert().
> (rather in a separate patch)

That's a fair suggestion. If others don't have an objection to the 
suggested change, I can club it in v8 along with any other requested 
changes.

Thanks.

