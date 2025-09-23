Return-Path: <linux-fsdevel+bounces-62509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E78B4B95F88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 15:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747F23A4A2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 13:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B85324B31;
	Tue, 23 Sep 2025 13:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMzSrmpP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EA5339A8;
	Tue, 23 Sep 2025 13:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758633229; cv=none; b=txlqL1sjG+YZhJSf4nV9z4Obo41uiONowuFuRBWLOG3tBI0iEGGsc91B9Vmtqq42tpHAWfZPUhL+cHBy828JxhUPpXrV5t01CHNhW+u2pUVTaqcLZQX4Q7AUCgxKwH9ZlMMP7zUHGd+88FMNNseO8KHTGO5XBndZPqwWaL4B7p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758633229; c=relaxed/simple;
	bh=h3D9xtbROxNSb9Gijb8GsRs1BUgX1Qfy/IJ4YGECVdo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mYTwflHgnXVyaC6dwcMtzHijmUAo6d4W6lv9fiYalTSwIPViTUmsAG6AWAlsNVSa/o7pVt7woOW4yD93LT4NiFGxUx0mWfEef0l88QVo434dy1AHRe3s/dyIzcOMEi8GnvNF/yFgY1IO0vDlc4DWOCNi16A9Tutfv8DPW8vNZCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMzSrmpP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE3FC4CEF5;
	Tue, 23 Sep 2025 13:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758633229;
	bh=h3D9xtbROxNSb9Gijb8GsRs1BUgX1Qfy/IJ4YGECVdo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oMzSrmpPP/PZ4MdZMnfT6nG+/zBR7nn6g4tNnGPoailLJCzHkLsoyL30vp2ur1OAe
	 EycvqkFLaoVGg4yXwf3Wtfknm3B+XyCYkscA//AR42PLBwLn9pgexqrCmAXYWHg/Iw
	 H4g3S8fTTcMXihhCLXObOJ1DaQfxHLWyGCGANTs8ARSYE9CZKaenjyK3DCcPmMORyH
	 iVD2FcM37OTUlRno11vUbxH0btrUd/4HR+12ckF9hFXqUvuZNBJzOLV4wVY0nSSvE4
	 ftvgaY/8Z5DZc9cL58e1XsahlgGD+qnui47PHZggyP/6oaZZDQLpk3oYdNe/iMQRu3
	 LiDgzMSCbyraw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  jasonmiu@google.com,
  graf@amazon.com,  changyuanl@google.com,  rppt@kernel.org,
  dmatlack@google.com,  rientjes@google.com,  corbet@lwn.net,
  rdunlap@infradead.org,  ilpo.jarvinen@linux.intel.com,
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
Subject: Re: [PATCH v3 17/30] liveupdate: luo_files: luo_ioctl: Unregister
 all FDs on device close
In-Reply-To: <CA+CK2bD_-xwwUBnF4TBCBuX33uL6+V_1nN=0Q8_NXwhubTc8yA@mail.gmail.com>
	(Pasha Tatashin's message of "Mon, 22 Sep 2025 17:23:11 -0400")
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
	<20250807014442.3829950-18-pasha.tatashin@soleen.com>
	<mafs07byoye0q.fsf@kernel.org>
	<CA+CK2bD_-xwwUBnF4TBCBuX33uL6+V_1nN=0Q8_NXwhubTc8yA@mail.gmail.com>
Date: Tue, 23 Sep 2025 15:13:38 +0200
Message-ID: <mafs0v7l9l3b1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22 2025, Pasha Tatashin wrote:

> On Wed, Aug 27, 2025 at 11:34=E2=80=AFAM Pratyush Yadav <pratyush@kernel.=
org> wrote:
>>
>> Hi Pasha,
>>
>> On Thu, Aug 07 2025, Pasha Tatashin wrote:
>>
>> > Currently, a file descriptor registered for preservation via the remai=
ns
>> > globally registered with LUO until it is explicitly unregistered. This
>> > creates a potential for resource leaks into the next kernel if the
>> > userspace agent crashes or exits without proper cleanup before a live
>> > update is fully initiated.
>> >
>> > This patch ties the lifetime of FD preservation requests to the lifeti=
me
>> > of the open file descriptor for /dev/liveupdate, creating an implicit
>> > "session".
>> >
>> > When the /dev/liveupdate file descriptor is closed (either explicitly
>> > via close() or implicitly on process exit/crash), the .release
>> > handler, luo_release(), is now called. This handler invokes the new
>> > function luo_unregister_all_files(), which iterates through all FDs
>> > that were preserved through that session and unregisters them.
>>
>> Why special case files here? Shouldn't you undo all the serialization
>> done for all the subsystems?
>
> Good point, subsystems should also be cancelled, and system should be
> brought back to normal state. However, with session support, we will
> be dropping only FDs that belong to a specific session when its FD is
> closed, or all FDs+subsystems when closing /dev/liveupdate.

Yeah, that makes sense.

[...]

--=20
Regards,
Pratyush Yadav

