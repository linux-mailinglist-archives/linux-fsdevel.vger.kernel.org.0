Return-Path: <linux-fsdevel+bounces-63680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2CEBCA70B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 19:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4179C482B2C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 17:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1F224729C;
	Thu,  9 Oct 2025 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RG/PKOX+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CD7227EAA
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032623; cv=none; b=CntH6K6u7oK8/PbD65pesWaBTOnVVQnhf7NVwcf0bzf+FVAqviCYJl/vtB45h7SG/ByUG9YL5ir3yOAh+ATbAukQqqVLOCMRjJjv4XHkbTPC3fv96OY/W1mF6J1qrWUCHvMP8UYXVcbPzi/aBZrU5SGyIkdJM3xeWkE7G77EDPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032623; c=relaxed/simple;
	bh=Oc75qG4cTNZNs+023xxXOdGNA0OEKXltKZJtkf6SwuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EkqtTfS59iDmwKeemjC+m13wEgsIcoMxSClnFPxoDPd/ZD1redPFIlDthOz9m/1gssWNn3pTN2KJtlFR/PEuOCpMLRumFqsdl78t3IPowm0sWGswbqjctPwPYxnd7PG/lWyPnF3IADaGNs8IpNy3VjfVM2kLSeFSiseBdi25QZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RG/PKOX+; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d09881f5-0e0b-4795-99bf-cd3711ee48ab@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760032609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mQtDstGb3CyrZpeSWryCX/If0ajj/tB0us6K4GO5uRQ=;
	b=RG/PKOX+b9dsfndKPbfywbTI44gZn77HEm5El0GYZFRJnXaZ96AlO6nHjLatm2rS78+wwF
	QXtEotKWbkSVW8f8eb6U1mr+CVTjybidcHrAro4XlxeF0d1q2x5FUfS4hf/V00ZmvJzTPH
	15lOKLt9DFUAB2FtRSdtZGn7XTbUs6Q=
Date: Thu, 9 Oct 2025 10:56:33 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 19/30] liveupdate: luo_sysfs: add sysfs state
 monitoring
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, jasonmiu@google.com,
 graf@amazon.com, changyuanl@google.com, rppt@kernel.org,
 dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
 rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
 kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
 masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org,
 yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev,
 chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com,
 jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org,
 dan.j.williams@intel.com, david@redhat.com, joel.granados@kernel.org,
 rostedt@goodmis.org, anna.schumaker@oracle.com, song@kernel.org,
 zhangguopeng@kylinos.cn, linux@weissschuh.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org,
 cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com,
 Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
 aleksander.lobakin@intel.com, ira.weiny@intel.com,
 andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
 bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
 stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org,
 linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
 ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com,
 leonro@nvidia.com, witu@nvidia.com
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-20-pasha.tatashin@soleen.com>
 <a27f9f8f-dc03-441b-8aa7-7daeff6c82ae@linux.dev>
 <mafs0qzvcmje2.fsf@kernel.org>
 <CA+CK2bCx=kTVORq9dRE2h3Z4QQ-ggxanY2tDPRy13_ARhc+TqA@mail.gmail.com>
 <dc71808c-c6a4-434a-aee9-b97601814c92@linux.dev>
 <CA+CK2bBz3NvDmwUjCPiyTPH9yL6YpZ+vX=o2TkC2C7aViXO-pQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <CA+CK2bBz3NvDmwUjCPiyTPH9yL6YpZ+vX=o2TkC2C7aViXO-pQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/9/25 10:04 AM, Pasha Tatashin wrote:
> On Thu, Oct 9, 2025 at 11:35 AM Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>>
>> 在 2025/10/9 5:01, Pasha Tatashin 写道:
>>>>> Because the window of kernel live update is short, it is difficult to statistics
>>>>> how many times the kernel is live updated.
>>>>>
>>>>> Is it possible to add a variable to statistics the times that the kernel is live
>>>>> updated?
>>>> The kernel doesn't do the live update on its own. The process is driven
>>>> and sequenced by userspace. So if you want to keep statistics, you
>>>> should do it from your userspace (luod maybe?). I don't see any need for
>>>> this in the kernel.
>>>>
>>> One use case I can think of is including information in kdump or the
>>> backtrace warning/panic messages about how many times this machine has
>>> been live-updated. In the past, I've seen bugs (related to memory
>>> corruption) that occurred only after several kexecs, not on the first
>>> one. With live updates, especially while the code is being stabilized,
>>> I imagine we might have a similar situation. For that reason, it could
>>> be useful to have a count in the dmesg logs showing how many times
>>> this machine has been live-updated. While this information is also
>>> available in userspace, it would be simpler for kernel developers
>>> triaging these issues if everything were in one place.
>> I’m considering this issue from a system security perspective. After the
>> kernel is automatically updated, user-space applications are usually
>> unaware of the change. In one possible scenario, an attacker could
>> replace the kernel with a compromised version, while user-space
>> applications remain unaware of it — which poses a potential security risk.
>>
>> To mitigate this, it would be useful to expose the number of kernel
>> updates through a sysfs interface, so that we can detect whether the
>> kernel has been updated and then collect information about the new
>> kernel to check for possible security issues.
>>
>> Of course, there are other ways to detect kernel updates — for example,
>> by using ftrace to monitor functions involved in live kernel updates —
>> but such approaches tend to have a higher performance overhead. In
>> contrast, adding a simple update counter to track live kernel updates
>> would provide similar monitoring capability with minimal overhead.
> Would a print during boot, i.e. when we print that this kernel is live
> updating, we could include the number, work for you? Otherwise, we
> could export this number in a debugfs.
Since I received a notification that my previous message was not sent 
successfully, I am resending it.

IMO, it would be better to export this number via debugfs. This approach 
reduces the overhead involved in detecting a kernel live update.
If the number is printed in logs instead, the overhead would be higher 
compared to using debugfs.

Thanks a lot.

Yanjun.Zhu

>
> Pasha

