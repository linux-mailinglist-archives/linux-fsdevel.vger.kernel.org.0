Return-Path: <linux-fsdevel+bounces-48456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE22AAF52B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 10:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C8F3B27FE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 08:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543702222DD;
	Thu,  8 May 2025 08:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jryb730/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F4D21D596;
	Thu,  8 May 2025 08:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746691717; cv=none; b=bZ+c93YfNvDZBvz2W/Mnp5TkTNhs4ziuXTrjcJDOZxG6gEcCGx1YCAic2paF7BjLS9u09X9z8OPsIr4NPYUAhSu3jok4Hij47/ztR0KrJPCN0qtgj62aEGDrjKtVjSgxfT3NxzY7USDnim/MXH3FnMyJPMKCcY0cOmz2tDH0Kc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746691717; c=relaxed/simple;
	bh=/O0T5gj+l3SiG8/jOeA1XTgLwp+ic/gfHfsw9rQ2A78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qyqYExtLmJlx0/qjuAWQOML0POMnQOpoBG/ofw4atBwOCAJgTACiGgPAUfreHiil7L33RMbwRkJ1hO37k7D9ymtmOANvcoGpQsmbfdRNIPoCF+xrs4pgCwpIzmBZKdTGRB0Mb93h6baJ5GiG8R9L9KJSBg8mRpeBVTIfdID7dFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=jryb730/; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5LiG6Zuwrq9CMULY5+p0T63SktsHI9fzOPt2+pi9YiU=; b=jryb730/yRHkyy3N0TAzZsGYt0
	CFzbHqWvzqB7bvj7NbQfo5bIe/9bE0UysKCrJZDhFqhj55taSjrR+AyXnFFi9wCdEEqzwc4+e8HnY
	9Jl6zuFiHs7PgZUac9AbcnZDxylpAmtstdqx4sgYgFPNOKkbSkyVegegUid5vO8vtK1BmxvsWzi+F
	nZY84ndyoN4j1BzTOalkqueg1IPAeefuv4QD3fxIpggcFRm2wiYqT5CmNLS4e/VSIjvVZnBtDJ5X3
	HYtusZgOIWKj/7XID/fEQl88m3Gark+/Xj6KeID1mogTaN++I5ejbwm1PnVXQrC6wFcyMvPdWyrEm
	7cLr9omg==;
Received: from [223.233.71.203] (helo=[192.168.1.12])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uCwEk-005681-4c; Thu, 08 May 2025 10:08:22 +0200
Message-ID: <751a4217-a506-ecf9-ac9f-1733c7c7c8d9@igalia.com>
Date: Thu, 8 May 2025 13:38:11 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 3/3] exec: Add support for 64 byte 'tsk->real_comm'
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>
Cc: Bhupesh <bhupesh@igalia.com>, akpm@linux-foundation.org,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
 laoar.shao@gmail.com, mathieu.desnoyers@efficios.com,
 arnaldo.melo@gmail.com, alexei.starovoitov@gmail.com,
 andrii.nakryiko@gmail.com, mirq-linux@rere.qmqm.pl, peterz@infradead.org,
 willy@infradead.org, david@redhat.com, viro@zeniv.linux.org.uk,
 keescook@chromium.org, ebiederm@xmission.com, brauner@kernel.org,
 jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
References: <20250507110444.963779-1-bhupesh@igalia.com>
 <20250507110444.963779-4-bhupesh@igalia.com>
 <aBtYDGOAVbLHeTHF@pathway.suse.cz>
 <20250507132302.4aed1cf0@gandalf.local.home>
From: Bhupesh Sharma <bhsharma@igalia.com>
In-Reply-To: <20250507132302.4aed1cf0@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/7/25 10:53 PM, Steven Rostedt wrote:
> On Wed, 7 May 2025 14:54:36 +0200
> Petr Mladek <pmladek@suse.com> wrote:
>
>>> To fix the same, Linus suggested in [1] that we can add the
>>> following union inside 'task_struct':
>>>         union {
>>>                 char    comm[TASK_COMM_LEN];
>>>                 char    real_comm[REAL_TASK_COMM_LEN];
>>>         };
>> Nit: IMHO, the prefix "real_" is misleading. The buffer size is still
>>        limited and the name might be shrinked. I would suggest
> Agreed.
>
>>        something like:
>>
>> 	char    comm_ext[TASK_COMM_EXT_LEN];
>> or
>> 	char    comm_64[TASK_COMM_64_LEN]
> I prefer "comm_ext" as I don't think we want to hard code the actual size.
> Who knows, in the future we may extend it again!
>

Ok, let me use 'comm_64' instead in v4.

Thanks for the review.

Regards,
Bhupesh

