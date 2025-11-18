Return-Path: <linux-fsdevel+bounces-69007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E8CC6B2D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 19:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74D994E117E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 18:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED02D35FF5D;
	Tue, 18 Nov 2025 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrGIWm9L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F0A262815;
	Tue, 18 Nov 2025 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489879; cv=none; b=YnA4gQUo9a2TjMVOdEq+VVvYvmeoR35DpjYMmFYX+dbLLbJWx4GNfZqpMC7dyURwXHN4oDi4DiaH8GsqeXgM98x1rcE1dLlTvpoHKOAwjPT469YBuKBZ3KUDjqDPuS8yY/ToZ/K0PnhFeU6ZphpHok1U8r9fG9qeSyd2x7He2Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489879; c=relaxed/simple;
	bh=MuaIcliWFm+wXQbyLOy+ePW5Z5hGnw7S19zVdOoRU9Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DUzhC5DxdUdb8GE+R1c3Fl5F4GkfCaLXTi7HphXKSK78d71YhvJboEycRK6+3akJN5QOgoYRGmCY+7JYoMSTXlGhHOJBGbCJltexDGg9ct4Ka3GW+Ovrj6yB2FZtDrV1n9yyR4l7sl+HmTMuDgLvDUCf78zrfqCTz4PoxdS4xEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrGIWm9L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F00C4CEFB;
	Tue, 18 Nov 2025 18:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763489876;
	bh=MuaIcliWFm+wXQbyLOy+ePW5Z5hGnw7S19zVdOoRU9Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MrGIWm9LWqZsfMs7ulgLTqd+vSnlbOrkGvCLSVQRDuELbIodah+F4M3f3FTCxDsYn
	 ubnteG6atXRRKp8sze6lQ6WYH+8u9RRxKmACuQIsUF/fNgOgsfrvg6HbHIadYL33zl
	 toHmEIuMukisjBAK6rWuEqeWX+hlpLLONOpACy4sSOUgXkzAModu7TG7oFE4qTZkaD
	 QjNS5JBnayMhMagSvhPUUG5/NOt4b0LbXnn8v67kdCBH+QUpOE0zhUWa2zlaT7cUHq
	 JvgpcxfLJiIEoAkXjzZaCmSMloZQu8GTaTAAgOXhJgT4nRevn5hDsdQFhJgF1pvmif
	 wFptWQwi5kylw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  David Matlack
 <dmatlack@google.com>,  jasonmiu@google.com,  graf@amazon.com,
  rppt@kernel.org,  rientjes@google.com,  corbet@lwn.net,
  rdunlap@infradead.org,  ilpo.jarvinen@linux.intel.com,
  kanie@linux.alibaba.com,  ojeda@kernel.org,  aliceryhl@google.com,
  masahiroy@kernel.org,  akpm@linux-foundation.org,  tj@kernel.org,
  yoann.congal@smile.fr,  mmaurer@google.com,  roman.gushchin@linux.dev,
  chenridong@huawei.com,  axboe@kernel.dk,  mark.rutland@arm.com,
  jannh@google.com,  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
  dan.j.williams@intel.com,  david@redhat.com,  joel.granados@kernel.org,
  rostedt@goodmis.org,  anna.schumaker@oracle.com,  song@kernel.org,
  linux@weissschuh.net,  linux-kernel@vger.kernel.org,
  linux-doc@vger.kernel.org,  linux-mm@kvack.org,
  gregkh@linuxfoundation.org,  tglx@linutronix.de,  mingo@redhat.com,
  bp@alien8.de,  dave.hansen@linux.intel.com,  x86@kernel.org,
  hpa@zytor.com,  rafael@kernel.org,  dakr@kernel.org,
  bartosz.golaszewski@linaro.org,  cw00.choi@samsung.com,
  myungjoo.ham@samsung.com,  yesanishhere@gmail.com,
  Jonathan.Cameron@huawei.com,  quic_zijuhu@quicinc.com,
  aleksander.lobakin@intel.com,  ira.weiny@intel.com,
  andriy.shevchenko@linux.intel.com,  leon@kernel.org,  lukas@wunner.de,
  bhelgaas@google.com,  wagi@kernel.org,  djeffery@redhat.com,
  stuart.w.hayes@gmail.com,  lennart@poettering.net,  brauner@kernel.org,
  linux-api@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  saeedm@nvidia.com,  ajayachandra@nvidia.com,  jgg@nvidia.com,
  parav@nvidia.com,  leonro@nvidia.com,  witu@nvidia.com,
  hughd@google.com,  skhawaja@google.com,  chrisl@kernel.org
Subject: Re: [PATCH v6 06/20] liveupdate: luo_file: implement file systems
 callbacks
In-Reply-To: <CA+CK2bAqisSdZ7gSBd7=hGd1VbLHX5WXfBazR=rO8BOVCRx3pg@mail.gmail.com>
	(Pasha Tatashin's message of "Tue, 18 Nov 2025 12:58:20 -0500")
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
	<20251115233409.768044-7-pasha.tatashin@soleen.com>
	<aRyvG308oNRVzuN7@google.com> <mafs05xb744pb.fsf@kernel.org>
	<CA+CK2bAqisSdZ7gSBd7=hGd1VbLHX5WXfBazR=rO8BOVCRx3pg@mail.gmail.com>
Date: Tue, 18 Nov 2025 19:17:42 +0100
Message-ID: <mafs01plv433t.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18 2025, Pasha Tatashin wrote:

> On Tue, Nov 18, 2025 at 12:43=E2=80=AFPM Pratyush Yadav <pratyush@kernel.=
org> wrote:
>>
>> On Tue, Nov 18 2025, David Matlack wrote:
>>
>> > On 2025-11-15 06:33 PM, Pasha Tatashin wrote:
>> >> This patch implements the core mechanism for managing preserved
>> >> files throughout the live update lifecycle. It provides the logic to
>> >> invoke the file handler callbacks (preserve, unpreserve, freeze,
>> >> unfreeze, retrieve, and finish) at the appropriate stages.
>> >>
>> >> During the reboot phase, luo_file_freeze() serializes the final
>> >> metadata for each file (handler compatible string, token, and data
>> >> handle) into a memory region preserved by KHO. In the new kernel,
>> >> luo_file_deserialize() reconstructs the in-memory file list from this
>> >> data, preparing the session for retrieval.
>> >>
>> >> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> >
>> >> +int liveupdate_register_file_handler(struct liveupdate_file_handler =
*h);
>> >
>> > Should there be a way to unregister a file handler?
>> >
>> > If VFIO is built as module then I think it  would need to be able to
>> > unregister its file handler when the module is unloaded to avoid leaki=
ng
>> > pointers to its text in LUO.
>
> I actually had full unregister functionality in v4 and earlier, but I
> dropped it from this series to minimize the footprint and get the core
> infrastructure landed first.
>
> For now, safety is guaranteed because
> liveupdate_register_file_handler() and liveupdate_register_flb() take
> a module reference. This effectively pins any module that registers
> with LUO, meaning those driver modules cannot be unloaded or upgraded
> dynamically, they can only be updated via Live Update or full reboot.

What if liveupdate_register_flb() fails? It would need to unregister its
file handler too, since the file handler can't really work without its
FLB. Shouldn't happen in practice, but still LUO clients need a way to
handle this failure.

[...]

--=20
Regards,
Pratyush Yadav

