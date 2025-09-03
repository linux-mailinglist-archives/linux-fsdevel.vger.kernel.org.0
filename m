Return-Path: <linux-fsdevel+bounces-60155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5DCB42334
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 16:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DFE2170F96
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 14:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BE030EF71;
	Wed,  3 Sep 2025 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+S1d8QQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D232F0C7A;
	Wed,  3 Sep 2025 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908647; cv=none; b=s8LsmpXKZMrtqOTh35Q7D1Vp729xYLP7BWinLNTn8sc5B0BQ2I7LlMEdxTSU80KQYXk+kFgA0s79g8AxTL8JhO45S0t9ddf89a0UDUqJndnOTkABAMiihbF+ym0LKPZzZ5ykqUyjHFER9zqKGnUpmgRkoCvUYCYrO3SSYelhOes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908647; c=relaxed/simple;
	bh=IJP0VbHKnRlpLO/dj+/Ia2ILTC5O+iulYtBS4Wmtc7Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eff2LAuaroLEU7fUi2chULqXChKhHvhX2IU2oRihsfHCyc2qy+RBcAPLF5trfxxnAPAnWC/MNpu4SvRU8lGnoVwGyelkmqfnu4gjYx03AOah7/vmPcEIBuAWbqqkTv0XY/3c5J/h00sg4JTchEvEzhDS3Ly3LbdPI34eKr9ywbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+S1d8QQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4255EC4CEE7;
	Wed,  3 Sep 2025 14:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756908647;
	bh=IJP0VbHKnRlpLO/dj+/Ia2ILTC5O+iulYtBS4Wmtc7Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=R+S1d8QQ8JTOfieL00HXOZ34YoFUz7OL6PI6NmTox55mOQ5P2beuQkiHTw89xKvw3
	 insOk7uKvWRNaeS2vTdE9Ht/CnQJzkKF7GSUV/9EH30J6MBbhwocfVgD71iA7LqCnt
	 zqGDip6cF961mvzPUx6VluNXvCkxwekBrmumpiQS1Wblng3j0PvIFUjnebzWKb0g7R
	 V4bkzKiUCPcrAIysTs2EMlCHah6rOsjnKvu10SpEX2QyWrKKe+3tUV7u4ej/phtqKG
	 dYcayDouOvM9hUHm/g775ZgYpyBRWvfvMV7HVpKIckFauorE4h/2sjZVbRh4vbTHER
	 6qYwmLFOmThTw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  jasonmiu@google.com,  graf@amazon.com,
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
  saeedm@nvidia.com,  ajayachandra@nvidia.com,  parav@nvidia.com,
  leonro@nvidia.com,  witu@nvidia.com
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
In-Reply-To: <20250902134846.GN186519@nvidia.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
	<20250807014442.3829950-30-pasha.tatashin@soleen.com>
	<20250826162019.GD2130239@nvidia.com> <mafs0bjo0yffo.fsf@kernel.org>
	<20250828124320.GB7333@nvidia.com> <mafs0h5xmw12a.fsf@kernel.org>
	<20250902134846.GN186519@nvidia.com>
Date: Wed, 03 Sep 2025 16:10:37 +0200
Message-ID: <mafs0v7lzvd7m.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Jason,

On Tue, Sep 02 2025, Jason Gunthorpe wrote:

> On Mon, Sep 01, 2025 at 07:10:53PM +0200, Pratyush Yadav wrote:
>> Building kvalloc on top of this becomes trivial.
>> 
>> [0] https://git.kernel.org/pub/scm/linux/kernel/git/pratyush/linux.git/commit/?h=kho-array&id=cf4c04c1e9ac854e3297018ad6dada17c54a59af
>
> This isn't really an array, it is a non-seekable serialization of
> key/values with some optimization for consecutive keys. IMHO it is

Sure, an array is not the best name for the thing. Call it whatever,
maybe a "sparse collection of pointers". But I hope you get the idea.

> most useful if you don't know the size of the thing you want to
> serialize in advance since it has a nice dynamic append.
>
> But if you do know the size, I think it makes more sense just to do a
> preserving vmalloc and write out a linear array..

I think there are two separate parts here. One is the data format and
the other is the data builder.

The format itself is quite simple. It is a linked list of discontiguous
pages that holds a set of pointers. We use that idea already for the
preserved pages bitmap. Mike's vmalloc preservation patches also use the
same idea, just with a small variation.

The builder part (ka_iter in my patches) is an abstraction on top to
build the data structure. I designed it with the nice dynamic append
property since it seemed like a nice and convenient design, but we can
have it define the size statically as well. The underlying data format
won't change.

>
> So, it could be useful, but I wouldn't use it for memfd, the vmalloc
> approach is better and we shouldn't optimize for sparsness which
> should never happen.

I disagree. I think we are re-inventing the same data format with minor
variations. I think we should define extensible fundamental data formats
first, and then use those as the building blocks for the rest of our
serialization logic.

I think KHO array does exactly that. It provides the fundamental
serialization for a collection of pointers, and other serialization use
cases can then build on top of it. For example, the preservation bitmaps
can get rid of their linked list logic and just use KHO array to hold
and retrieve its bitmaps. It will make the serialization simpler.
Similar argument for vmalloc preservation.

I also don't get why you think sparseness "should never happen". For
memfd for example, you say in one of your other emails that "And again
in real systems we expect memfd to be fully populated too." Which
systems and use cases do you have in mind? Why do you think people won't
want a sparse memfd?

And finally, from a data format perspective, the sparseness only adds a
small bit of complexity (the startpos for each kho_array_page).
Everything else is practically the same as a continuous array.

All in all, I think KHO array is going to prove useful and will make
serialization for subsystems easier. I think sparseness will also prove
useful but it is not a hill I want to die on. I am fine with starting
with a non-sparse array if people really insist. But I do think we
should go with KHO array as a base instead of re-inventing the linked
list of pages again and again.

>
>> > The versioning should be first class, not hidden away as some emergent
>> > property of registering multiple serializers or something like that.
>> 
>> That makes sense. How about some simple changes to the LUO interfaces to
>> make the version more prominent:
>> 
>> 	int (*prepare)(struct liveupdate_file_handler *handler,
>> 		       struct file *file, u64 *data, char **compatible);
>
> Yeah, something more integrated with the ops is better.
>
> You could list the supported versions in the ops itself
>
>   const char **supported_deserialize_versions;
>
> And let the luo framework find the right versions.
>
> But for prepare I would expect an inbetween object:
>
> 	int (*prepare)(struct liveupdate_file_handler *handler,
> 	    	       struct luo_object *obj, struct file *file);
>
> And then you'd do function calls on 'obj' to store 'data' per version.

What do you mean by "data per version"? I think there should be only one
version of the serialized object. Multiple versions of the same thing
will get ugly real quick.

Other than that, I think this could work well. I am guessing luo_object
stores the version and gives us a way to query it on the other side. I
think if we are letting LUO manage supported versions, it should be
richer than just a list of strings. I think it should include a ops
structure for deserializing each version. That would encapsulate the
versioning more cleanly.

-- 
Regards,
Pratyush Yadav

