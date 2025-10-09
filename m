Return-Path: <linux-fsdevel+bounces-63700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D663BBCB2D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 01:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61FD1A6468B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 23:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166A62874F9;
	Thu,  9 Oct 2025 23:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeP1ebEf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BBE72625;
	Thu,  9 Oct 2025 23:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760051549; cv=none; b=srsmDu2axJT2VoIIj6qoIX0v2diLD008d7dc4dcIVauac0OXkIDlfnoPQQssIScCw/aZq6w9m/IvJQud7WhQca0dSZqrjKcOFUxicbEJ5OJ0emCD4x0jtxXAzIIbOFcKg9SvbQvge2KEJBpw9nhuAXlzpEKpAwNex6E0o8J2ezY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760051549; c=relaxed/simple;
	bh=Z0b3bpB7s8l8nb1j4Ch+52gcGrqY0BNRSvWR/Vc+228=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Om4jEQENNIpsKlpydI5xWJ6rMFsYrcIHxJT1mHBYidLWgUm8ZmbgCoOI/iNQc52rKtEDAS8cOxcPxVBCEQza0eje4L/Pf5mFN7/HQ6LQ64AWhnqD3sQsYh292MHsqmbQylh0o//uHWWXr5Y65b3q4YhpRzgfkkboKvjvicUj4Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeP1ebEf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CC8C4CEE7;
	Thu,  9 Oct 2025 23:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760051548;
	bh=Z0b3bpB7s8l8nb1j4Ch+52gcGrqY0BNRSvWR/Vc+228=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XeP1ebEfuiBjXqjcQeevK44aYYYNeTPG/dcoQip/pJY1CJsfvQmUvwxWR8TNIbmu3
	 z36uH+8M6e5FiMhWm56P8q3P7UXHY9OZEViMS9l9btXwcjuj8eSzNbAruipDfd6FJN
	 vlRIKwOHkFvj+jxAPSMsy204E2OiQpuXIhrtcc3RhDGIpX72Rod947g6w6DU5r9OOQ
	 bzt5gxSc9tT/qBiShwr/7Wfj1PhA14WAm1o7J5CKUeuwXBwWiPjaxeBguiDXZ1FIjN
	 TlM0rkP5+LHhf3rWxBlRA0hc51d5O4r0wAydJblwvKFjUqnzWRd3V4UMlxatBokmvw
	 kCvEfBp7JIY8g==
From: Pratyush Yadav <pratyush@kernel.org>
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  jasonmiu@google.com,  graf@amazon.com,
  changyuanl@google.com,  rppt@kernel.org,  dmatlack@google.com,
  rientjes@google.com,  corbet@lwn.net,  rdunlap@infradead.org,
  ilpo.jarvinen@linux.intel.com,  kanie@linux.alibaba.com,
  ojeda@kernel.org,  aliceryhl@google.com,  masahiroy@kernel.org,
  akpm@linux-foundation.org,  tj@kernel.org,  yoann.congal@smile.fr,
  mmaurer@google.com,  roman.gushchin@linux.dev,  chenridong@huawei.com,
  axboe@kernel.dk,  mark.rutland@arm.com,  jannh@google.com,
  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
  dan.j.williams@intel.com,  david@redhat.com,  joel.granados@kernel.org,
  rostedt@goodmis.org,  anna.schumaker@oracle.com,  song@kernel.org,
  zhangguopeng@kylinos.cn,  linux@weissschuh.net,
  linux-kernel@vger.kernel.org,  linux-doc@vger.kernel.org,
  linux-mm@kvack.org,  gregkh@linuxfoundation.org,  tglx@linutronix.de,
  mingo@redhat.com,  bp@alien8.de,  dave.hansen@linux.intel.com,
  x86@kernel.org,  hpa@zytor.com,  rafael@kernel.org,  dakr@kernel.org,
  bartosz.golaszewski@linaro.org,  cw00.choi@samsung.com,
  myungjoo.ham@samsung.com,  yesanishhere@gmail.com,
  Jonathan.Cameron@huawei.com,  quic_zijuhu@quicinc.com,
  aleksander.lobakin@intel.com,  ira.weiny@intel.com,
  andriy.shevchenko@linux.intel.com,  leon@kernel.org,  lukas@wunner.de,
  bhelgaas@google.com,  wagi@kernel.org,  djeffery@redhat.com,
  stuart.w.hayes@gmail.com,  lennart@poettering.net,  brauner@kernel.org,
  linux-api@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  saeedm@nvidia.com,  ajayachandra@nvidia.com,  jgg@nvidia.com,
  parav@nvidia.com,  leonro@nvidia.com,  witu@nvidia.com
Subject: Re: [PATCH v3 19/30] liveupdate: luo_sysfs: add sysfs state monitoring
In-Reply-To: <d09881f5-0e0b-4795-99bf-cd3711ee48ab@linux.dev> (Yanjun Zhu's
	message of "Thu, 9 Oct 2025 10:56:33 -0700")
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
	<20250807014442.3829950-20-pasha.tatashin@soleen.com>
	<a27f9f8f-dc03-441b-8aa7-7daeff6c82ae@linux.dev>
	<mafs0qzvcmje2.fsf@kernel.org>
	<CA+CK2bCx=kTVORq9dRE2h3Z4QQ-ggxanY2tDPRy13_ARhc+TqA@mail.gmail.com>
	<dc71808c-c6a4-434a-aee9-b97601814c92@linux.dev>
	<CA+CK2bBz3NvDmwUjCPiyTPH9yL6YpZ+vX=o2TkC2C7aViXO-pQ@mail.gmail.com>
	<d09881f5-0e0b-4795-99bf-cd3711ee48ab@linux.dev>
Date: Fri, 10 Oct 2025 01:12:18 +0200
Message-ID: <mafs0ecrbmzzh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09 2025, Yanjun.Zhu wrote:

> On 10/9/25 10:04 AM, Pasha Tatashin wrote:
>> On Thu, Oct 9, 2025 at 11:35=E2=80=AFAM Zhu Yanjun <yanjun.zhu@linux.dev=
> wrote:
>>>
>>> =E5=9C=A8 2025/10/9 5:01, Pasha Tatashin =E5=86=99=E9=81=93:
>>>>>> Because the window of kernel live update is short, it is difficult t=
o statistics
>>>>>> how many times the kernel is live updated.
>>>>>>
>>>>>> Is it possible to add a variable to statistics the times that the ke=
rnel is live
>>>>>> updated?
>>>>> The kernel doesn't do the live update on its own. The process is driv=
en
>>>>> and sequenced by userspace. So if you want to keep statistics, you
>>>>> should do it from your userspace (luod maybe?). I don't see any need =
for
>>>>> this in the kernel.
>>>>>
>>>> One use case I can think of is including information in kdump or the
>>>> backtrace warning/panic messages about how many times this machine has
>>>> been live-updated. In the past, I've seen bugs (related to memory
>>>> corruption) that occurred only after several kexecs, not on the first
>>>> one. With live updates, especially while the code is being stabilized,
>>>> I imagine we might have a similar situation. For that reason, it could
>>>> be useful to have a count in the dmesg logs showing how many times
>>>> this machine has been live-updated. While this information is also
>>>> available in userspace, it would be simpler for kernel developers
>>>> triaging these issues if everything were in one place.

Hmm, good point.

>>> I=E2=80=99m considering this issue from a system security perspective. =
After the
>>> kernel is automatically updated, user-space applications are usually
>>> unaware of the change. In one possible scenario, an attacker could
>>> replace the kernel with a compromised version, while user-space
>>> applications remain unaware of it =E2=80=94 which poses a potential sec=
urity risk.

Wouldn't signing be the way to avoid that? Because if the kernel is
compromised then it can very well fake the reboot count as well.

>>>
>>> To mitigate this, it would be useful to expose the number of kernel
>>> updates through a sysfs interface, so that we can detect whether the
>>> kernel has been updated and then collect information about the new
>>> kernel to check for possible security issues.
>>>
>>> Of course, there are other ways to detect kernel updates =E2=80=94 for =
example,
>>> by using ftrace to monitor functions involved in live kernel updates =
=E2=80=94
>>> but such approaches tend to have a higher performance overhead. In
>>> contrast, adding a simple update counter to track live kernel updates
>>> would provide similar monitoring capability with minimal overhead.
>> Would a print during boot, i.e. when we print that this kernel is live
>> updating, we could include the number, work for you? Otherwise, we
>> could export this number in a debugfs.
> Since I received a notification that my previous message was not sent
> successfully, I am resending it.
>
> IMO, it would be better to export this number via debugfs. This approach =
reduces
> the overhead involved in detecting a kernel live update.
> If the number is printed in logs instead, the overhead would be higher co=
mpared
> to using debugfs.

Yeah, debugfs sounds fine. No ABI at least.

--=20
Regards,
Pratyush Yadav

