Return-Path: <linux-fsdevel+bounces-63626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C98BC76CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 07:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21FB19E4FBA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 05:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552D225EFB6;
	Thu,  9 Oct 2025 05:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EO/xg1I5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9094120330;
	Thu,  9 Oct 2025 05:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759987238; cv=none; b=DhnTaqZczqnAmpPCK3CWqSvWSmCYE7haFv/VL54YozGX1+2owWka//eBMdIQEbqdCzYM4LaLaltsNDuL3/AwCYZVZfBN77qvs9WJDL+sriThDykh5HroUtU6WU2mjY55abK0pTbyDkzG4UE/vPaAZURNGu5QmHCJWdbJBbXwlx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759987238; c=relaxed/simple;
	bh=OgkTj9432fZmlNS0UH+uhZjP/yq09nzN3kBXCzSELF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9O3nt3GV8qHqek00ILD2rOGn0WQB5Yg1mCxfvCgcBsQ3qO2X3s15Tq6R7J9taN0PuYz2C90IS28fR8b6qvlafOSXClaQKFulzrZMdULpr+4tLxjU9FzGEZr+j2QF+w/6NdekauS80SnaY4GPEquY/a2hCrtSge21QxiIu/TnG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EO/xg1I5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBDDC4CEE7;
	Thu,  9 Oct 2025 05:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759987238;
	bh=OgkTj9432fZmlNS0UH+uhZjP/yq09nzN3kBXCzSELF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EO/xg1I5JxJ6Gng6yPKjQlyZ9RssCFhDlylg693XLeMCae87nGqGQdAPxdnk8nFqp
	 tGbZ2uEepHWq8ACteVrpxj3i53VzsVaJrIn5BN4RwNbKOGlLS4fHBgH090sMdPb0K2
	 5VclVGHelHJoTEyjNpjKhoyN0Eu+X/Xlw7KJlSIQ=
Date: Thu, 9 Oct 2025 07:20:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "yanjun.zhu" <yanjun.zhu@linux.dev>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, pratyush@kernel.org,
	jasonmiu@google.com, graf@amazon.com, changyuanl@google.com,
	rppt@kernel.org, dmatlack@google.com, rientjes@google.com,
	corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
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
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com,
	leonro@nvidia.com, witu@nvidia.com
Subject: Re: [PATCH v3 19/30] liveupdate: luo_sysfs: add sysfs state
 monitoring
Message-ID: <2025100953-plug-acting-9530@gregkh>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-20-pasha.tatashin@soleen.com>
 <a27f9f8f-dc03-441b-8aa7-7daeff6c82ae@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a27f9f8f-dc03-441b-8aa7-7daeff6c82ae@linux.dev>

On Wed, Oct 08, 2025 at 06:07:00PM -0700, yanjun.zhu wrote:
> > +#define LUO_DIR_NAME	"liveupdate"
> > +
> > +void luo_sysfs_notify(void)
> > +{
> > +	if (luo_sysfs_initialized)
> > +		sysfs_notify(kernel_kobj, LUO_DIR_NAME, "state");
> > +}
> > +
> > +/* Show the current live update state */
> > +static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
> > +			  char *buf)
> > +{
> > +	return sysfs_emit(buf, "%s\n", luo_current_state_str());
> 
> Because the window of kernel live update is short, it is difficult to
> statistics how many times the kernel is live updated.
> 
> Is it possible to add a variable to statistics the times that the kernel is
> live updated?
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
> Then exporting this value through /proc or /sys so that user space can check
> it:
> 
> static ssize_t klu_counter_show(struct kobject *kobj, struct kobj_attribute
> *attr, char *buf)
> {
>     return sprintf(buf, "%d\n", atomic_read(&klu_counter));
> }

But the value can change right after you read it, so how do you "know"
it is up to date?

What exactly do you want to do with this type of information?  What are
you going to do with that information?

thanks,

greg k-h

