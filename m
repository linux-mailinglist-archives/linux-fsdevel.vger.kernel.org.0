Return-Path: <linux-fsdevel+bounces-58782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D5FB3171E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25FE1B04709
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 12:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF752FC023;
	Fri, 22 Aug 2025 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="I77P1uKU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8972B2FB608;
	Fri, 22 Aug 2025 12:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864345; cv=none; b=UiKYw7hnzgTccnVQfxLldiPfIviya6ccsaxcRj6ZUrU0KdEbb6bubiv3ZKVdvyqVidpafF0CM3PNo2L4k1/l/KWxm5mAcw8VncbkR6G0CYxg+9/D6Ovv2QkvSqw9krEOJYjjyMQ83Wf8r4sB6UVHx1OqeHkm/MB+A7rLpDgItJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864345; c=relaxed/simple;
	bh=NXecumbx6Sfl6rCCGMzLn/SDJTV7Pg6hzMJP0TOSLjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uxh5eq97dKYZTJkyByWsXMNKhkmN3KoF9tyyYeQQsMmWwJbFZBGr4JEYqL/yNsVeiZT8bpxroVu6W72SrI8ciI07hLHz/gRptJeE/8bm0tObb1SAQZppp8vRIPxn3BV15SksogkMOcNr3msjuqI+K+rOhU3QCHN0oZRRy3v3IVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=I77P1uKU; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/sjXBtj1MOzw/AdZxeUjWL1KE7gNgPG1VCq31ysNWqM=; b=I77P1uKUeWLsabWoudzQTPby7H
	3I7AFVwd4agPdtzptBCL4RkqscYDOJdDiy1tSDcKZxzWplHulsHNgu6RFrKaMpCKzqZX6KUQ+YEoV
	d6VMpuehLAsJ3UWSzv79R2uqym63+DVN+2zgOYqp4PRJFRkjYGwDk7651LHm8rNlQCMD3b2VRZz3Q
	PrLzmNWi0iJVguvflNR5j+mGWUbQn1Mqrx37UuuYMq3DBTiiCgCbTsWX6Wn3qmhx3+8WFWwGC9R5F
	2xdnEe6nAQAdMO6OUiyMs5flaPyxsFMMTizHEGM/Xb8asUBQVtqNggtLasYWq6hUDaNAhOZzoR0Co
	/bNNZ1Mg==;
Received: from [223.233.71.242] (helo=[192.168.1.8])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1upQWL-0005V1-MJ; Fri, 22 Aug 2025 14:05:25 +0200
Message-ID: <3dd2e56c-667c-63cd-2103-44265b34c45c@igalia.com>
Date: Fri, 22 Aug 2025 17:35:17 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v8 4/5] treewide: Switch memcpy() users of 'task->comm' to
 a more safer implementation
To: Steven Rostedt <rostedt@goodmis.org>, Bhupesh <bhupesh@igalia.com>
Cc: akpm@linux-foundation.org, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
 laoar.shao@gmail.com, pmladek@suse.com, mathieu.desnoyers@efficios.com,
 arnaldo.melo@gmail.com, alexei.starovoitov@gmail.com,
 andrii.nakryiko@gmail.com, mirq-linux@rere.qmqm.pl, peterz@infradead.org,
 willy@infradead.org, david@redhat.com, viro@zeniv.linux.org.uk,
 keescook@chromium.org, ebiederm@xmission.com, brauner@kernel.org,
 jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, linux-trace-kernel@vger.kernel.org,
 kees@kernel.org, torvalds@linux-foundation.org
References: <20250821102152.323367-1-bhupesh@igalia.com>
 <20250821102152.323367-5-bhupesh@igalia.com>
 <20250821124319.07843e17@gandalf.local.home>
Content-Language: en-US
From: Bhupesh Sharma <bhsharma@igalia.com>
In-Reply-To: <20250821124319.07843e17@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/21/25 10:13 PM, Steven Rostedt wrote:
> On Thu, 21 Aug 2025 15:51:51 +0530
> Bhupesh <bhupesh@igalia.com> wrote:
>
>> +static __always_inline void
>> +	__cstr_array_copy(char *dst, const char *src,
>> +			  __kernel_size_t size)
>> +{
>> +	memcpy(dst, src, size);
>> +	dst[size] = 0;
> Shouldn't this be: dst[size - 1] = 0;
>
> ?
>
> Perhaps also add:
>
> 	BUILD_BUG_ON(size == 0);
>
>
Ok, will add this in v9.

Thanks.

