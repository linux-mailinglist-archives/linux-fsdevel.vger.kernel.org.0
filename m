Return-Path: <linux-fsdevel+bounces-63653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2C1BC8AC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 13:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A88C4F3E28
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 11:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B9C2EC0AF;
	Thu,  9 Oct 2025 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+CqYBXr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A212EBDFB;
	Thu,  9 Oct 2025 10:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760007520; cv=none; b=X95hR4nxqFCBhnG9gPjOxAmBWB5UPNbCSdeIHKqS0JcGcTpMLGKwKRSLvEphNv7r6qV4VbhUxacdn8Ey0ujO7SSBnAN+zd+lZW1KKfuHB/HJ9rfwYLivx2u9TsgXGcAm6FfV+/Ujofzcm76gqaquDzVZ2COGGpiNvjpy1kfedYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760007520; c=relaxed/simple;
	bh=7Nur+XSIKNjaZ4TARG/0OtkaTqABK5qON+LE3aEY7Aw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VEqsc0BPEb46kiUqkeB5UPb0jy8kL//FNLgYPcymNTCW9PSYBKQEFjJ0PL0E2J6S/qhXTwmkGeQEGBuMMTBVqVRr9jx2DE9sBsEeDaXFhOtQO5nObqrqw49aIk8RIJjoE3S9xVF9i+4+tFNVxXSJqgtUjL5jWOKu/+R32RmF2hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+CqYBXr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566A8C4CEE7;
	Thu,  9 Oct 2025 10:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760007519;
	bh=7Nur+XSIKNjaZ4TARG/0OtkaTqABK5qON+LE3aEY7Aw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=C+CqYBXrsPK4Hf77dWS8x2tr3n47VJ1gWIZgOIq2eKyhyo1+cmTV2J60K5aYhgHDw
	 3CEeKuIGW8qjA4K3QhBrWjuQoCMP5w8o3T0QjK+eWq+UGDWtZHgRCIHoxuEGrNX+Bj
	 pIlpM8NA+mb7eJTo8mf/Bdjf0HLnSrm9//Wt0xWRbT6Le7m6gzZdQW3NX53MK/u9sv
	 S10U8ahIcGBuVvRGwnutN4BYzYg3r7AgVyWHlcPpwLme5rmkzmzbHl5bzEpdZQvZ2N
	 XQNhDqGAJ3Mjyg0LPTV3FINr6FIiDNji1zltNhGX/uBPh8CxPtU2d4qxRFTeaHmIkF
	 cN5qN9D2zj3Gw==
From: Pratyush Yadav <pratyush@kernel.org>
To: "yanjun.zhu" <yanjun.zhu@linux.dev>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  pratyush@kernel.org,
  jasonmiu@google.com,  graf@amazon.com,  changyuanl@google.com,
  rppt@kernel.org,  dmatlack@google.com,  rientjes@google.com,
  corbet@lwn.net,  rdunlap@infradead.org,  ilpo.jarvinen@linux.intel.com,
  kanie@linux.alibaba.com,  ojeda@kernel.org,  aliceryhl@google.com,
  masahiroy@kernel.org,  akpm@linux-foundation.org,  tj@kernel.org,
  yoann.congal@smile.fr,  mmaurer@google.com,  roman.gushchin@linux.dev,
  chenridong@huawei.com,  axboe@kernel.dk,  mark.rutland@arm.com,
  jannh@google.com,  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
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
In-Reply-To: <a27f9f8f-dc03-441b-8aa7-7daeff6c82ae@linux.dev> (yanjun zhu's
	message of "Wed, 8 Oct 2025 18:07:00 -0700")
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
	<20250807014442.3829950-20-pasha.tatashin@soleen.com>
	<a27f9f8f-dc03-441b-8aa7-7daeff6c82ae@linux.dev>
Date: Thu, 09 Oct 2025 12:58:29 +0200
Message-ID: <mafs0qzvcmje2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 08 2025, yanjun.zhu wrote:

> On 8/6/25 6:44 PM, Pasha Tatashin wrote:
>> Introduce a sysfs interface for the Live Update Orchestrator
>> under /sys/kernel/liveupdate/. This interface provides a way for
>> userspace tools and scripts to monitor the current state of the LUO
>> state machine.
>> The main feature is a read-only file, state, which displays the
>> current LUO state as a string ("normal", "prepared", "frozen",
>> "updated"). The interface uses sysfs_notify to allow userspace
>> listeners (e.g., via poll) to be efficiently notified of state changes.
>> ABI documentation for this new sysfs interface is added in
>> Documentation/ABI/testing/sysfs-kernel-liveupdate.
>> This read-only sysfs interface complements the main ioctl interface
>> provided by /dev/liveupdate, which handles LUO control operations and
>> resource management.
>> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
[...]
>> +#include <linux/kobject.h>
>> +#include <linux/liveupdate.h>
>> +#include <linux/sysfs.h>
>> +#include "luo_internal.h"
>> +
>> +static bool luo_sysfs_initialized;
>> +
>> +#define LUO_DIR_NAME	"liveupdate"
>> +
>> +void luo_sysfs_notify(void)
>> +{
>> +	if (luo_sysfs_initialized)
>> +		sysfs_notify(kernel_kobj, LUO_DIR_NAME, "state");
>> +}
>> +
>> +/* Show the current live update state */
>> +static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
>> +			  char *buf)
>> +{
>> +	return sysfs_emit(buf, "%s\n", luo_current_state_str());
>
> Because the window of kernel live update is short, it is difficult to statistics
> how many times the kernel is live updated.
>
> Is it possible to add a variable to statistics the times that the kernel is live
> updated?

The kernel doesn't do the live update on its own. The process is driven
and sequenced by userspace. So if you want to keep statistics, you
should do it from your userspace (luod maybe?). I don't see any need for
this in the kernel.

>
> For example, define a global variable of type atomic_t or u64 in the core
> module:
>
> #include <linux/atomic.h>
>
> static atomic_t klu_counter = ATOMIC_INIT(0);
>
>
> Every time a live update completes successfully, increment the counter:
>
> atomic_inc(&klu_counter);
>
> Then exporting this value through /proc or /sys so that user space can check it:
>
> static ssize_t klu_counter_show(struct kobject *kobj, struct kobj_attribute
> *attr, char *buf)
> {
>     return sprintf(buf, "%d\n", atomic_read(&klu_counter));
> }
>
> Yanjun.Zhu
[...]

-- 
Regards,
Pratyush Yadav

