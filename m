Return-Path: <linux-fsdevel+bounces-63725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1910FBCBCC1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 08:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C613ADD69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 06:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3960F258ED1;
	Fri, 10 Oct 2025 06:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E/E4XC0O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DE53F9D2;
	Fri, 10 Oct 2025 06:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760078384; cv=none; b=fv6Jnl+0kaWscsArrCKGVbAWCLUo4WpjQpvS42/tsj4iKjQ5Jeqv6bCbG0fjGhfv5FKQxKaF2RB9AsVRAW5lncbiy60wGRUQTmecNuDVweQRkch3HVUruj/z0HPtASeausbybMRmXAk2p7CToUPxbro/uyERZdbMo5rasNgE538=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760078384; c=relaxed/simple;
	bh=f275Z6QBP1oJ7FjNXnqjQQ3arZ+vlTTlgIAxDsW1u1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaWM611kfuOMYM1UfwSj4gHXqRD50WAioEOnItgWpqqfX8MAXIIrazsJomMqGhzTjq64iT1rI4Qv9Qj7LzaeOZ2XDXrUCW84pbRaV+z4DDpXftO3E2UyleIK6Gl+2h/TxfRKcnrVSmyseqpKINfy8BaQa1c+HXA/rf4fvu5KAqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E/E4XC0O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC42C4CEF1;
	Fri, 10 Oct 2025 06:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760078383;
	bh=f275Z6QBP1oJ7FjNXnqjQQ3arZ+vlTTlgIAxDsW1u1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E/E4XC0OPvNpqewhJaQ4nGbxL62esjMmVSltK67IIVcxdGmwf16INSfid2uo26dGR
	 963ucB1qo46+2lEPEd8aGn9IMZVMQdo+3Nh0mpr8weqS34CQPv1YYWugKh2Yv1Gp4g
	 sL2c6uu2EtJaHZ8tcsdSndMcHFBEBMyTE7XCuZh8=
Date: Fri, 10 Oct 2025 08:39:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: "Yanjun.Zhu" <yanjun.zhu@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, jasonmiu@google.com,
	graf@amazon.com, changyuanl@google.com, rppt@kernel.org,
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org,
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev,
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com,
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com,
	leonro@nvidia.com, witu@nvidia.com
Subject: Re: [PATCH v3 19/30] liveupdate: luo_sysfs: add sysfs state
 monitoring
Message-ID: <2025101001-sandpit-setup-7424@gregkh>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-20-pasha.tatashin@soleen.com>
 <a27f9f8f-dc03-441b-8aa7-7daeff6c82ae@linux.dev>
 <mafs0qzvcmje2.fsf@kernel.org>
 <CA+CK2bCx=kTVORq9dRE2h3Z4QQ-ggxanY2tDPRy13_ARhc+TqA@mail.gmail.com>
 <dc71808c-c6a4-434a-aee9-b97601814c92@linux.dev>
 <CA+CK2bBz3NvDmwUjCPiyTPH9yL6YpZ+vX=o2TkC2C7aViXO-pQ@mail.gmail.com>
 <d09881f5-0e0b-4795-99bf-cd3711ee48ab@linux.dev>
 <mafs0ecrbmzzh.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mafs0ecrbmzzh.fsf@kernel.org>

On Fri, Oct 10, 2025 at 01:12:18AM +0200, Pratyush Yadav wrote:
> On Thu, Oct 09 2025, Yanjun.Zhu wrote:
> 
> > On 10/9/25 10:04 AM, Pasha Tatashin wrote:
> >> On Thu, Oct 9, 2025 at 11:35 AM Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
> >>>
> >>> 在 2025/10/9 5:01, Pasha Tatashin 写道:
> >>>>>> Because the window of kernel live update is short, it is difficult to statistics
> >>>>>> how many times the kernel is live updated.
> >>>>>>
> >>>>>> Is it possible to add a variable to statistics the times that the kernel is live
> >>>>>> updated?
> >>>>> The kernel doesn't do the live update on its own. The process is driven
> >>>>> and sequenced by userspace. So if you want to keep statistics, you
> >>>>> should do it from your userspace (luod maybe?). I don't see any need for
> >>>>> this in the kernel.
> >>>>>
> >>>> One use case I can think of is including information in kdump or the
> >>>> backtrace warning/panic messages about how many times this machine has
> >>>> been live-updated. In the past, I've seen bugs (related to memory
> >>>> corruption) that occurred only after several kexecs, not on the first
> >>>> one. With live updates, especially while the code is being stabilized,
> >>>> I imagine we might have a similar situation. For that reason, it could
> >>>> be useful to have a count in the dmesg logs showing how many times
> >>>> this machine has been live-updated. While this information is also
> >>>> available in userspace, it would be simpler for kernel developers
> >>>> triaging these issues if everything were in one place.
> 
> Hmm, good point.
> 
> >>> I’m considering this issue from a system security perspective. After the
> >>> kernel is automatically updated, user-space applications are usually
> >>> unaware of the change. In one possible scenario, an attacker could
> >>> replace the kernel with a compromised version, while user-space
> >>> applications remain unaware of it — which poses a potential security risk.
> 
> Wouldn't signing be the way to avoid that? Because if the kernel is
> compromised then it can very well fake the reboot count as well.
> 
> >>>
> >>> To mitigate this, it would be useful to expose the number of kernel
> >>> updates through a sysfs interface, so that we can detect whether the
> >>> kernel has been updated and then collect information about the new
> >>> kernel to check for possible security issues.
> >>>
> >>> Of course, there are other ways to detect kernel updates — for example,
> >>> by using ftrace to monitor functions involved in live kernel updates —
> >>> but such approaches tend to have a higher performance overhead. In
> >>> contrast, adding a simple update counter to track live kernel updates
> >>> would provide similar monitoring capability with minimal overhead.
> >> Would a print during boot, i.e. when we print that this kernel is live
> >> updating, we could include the number, work for you? Otherwise, we
> >> could export this number in a debugfs.
> > Since I received a notification that my previous message was not sent
> > successfully, I am resending it.
> >
> > IMO, it would be better to export this number via debugfs. This approach reduces
> > the overhead involved in detecting a kernel live update.
> > If the number is printed in logs instead, the overhead would be higher compared
> > to using debugfs.
> 
> Yeah, debugfs sounds fine. No ABI at least.

Do not provide any functionality in debugfs that userspace relies on at
all, as odds are, it will not be able to be accessed by most/all of
userspace on many systems.  It is for debugging only.

thanks,

greg k-h

