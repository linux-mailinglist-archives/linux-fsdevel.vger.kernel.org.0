Return-Path: <linux-fsdevel+bounces-67554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2501C43376
	for <lists+linux-fsdevel@lfdr.de>; Sat, 08 Nov 2025 19:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E363AAFAB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Nov 2025 18:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E5F281341;
	Sat,  8 Nov 2025 18:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="u/TU0L1S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E58224AFA;
	Sat,  8 Nov 2025 18:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762627018; cv=none; b=QZKD9Wvf/yy7u2MZy9aXTpDkxI5Ayc9RdRbQ2MKr4BN5AYeMR3a5QP6Zrj7Be3WrIL6DS4adVv6HlaRgAMBHjBzeZpVivyV6poaCswd4yedwtWUDICnM02jFDLxIfVhzHo1Ywbe9SkDD6SuRf4f+5IszpUMatGAMKbrdE9FnBPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762627018; c=relaxed/simple;
	bh=oc4FD2p7G8kSBSZo9gfGH4up/tQYQo2yArK0ExY2vhY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ckKR3wMYZwRSh2OzMPrHSA0+HeYk5+im8C/L/qERnNCg37PefB8+ZaWVB8i3RZl4lY4vGhXrPj2ZzBJA7+gmXQqzAxTofGuGPh+uDoZckqEIxZhG0wOfDNYfiA+ARsutyVd44atTL+G0IB4bBEk2z0lNNg3vk7KNZ1vN5MH+4l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=u/TU0L1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1045C4CEFB;
	Sat,  8 Nov 2025 18:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762627017;
	bh=oc4FD2p7G8kSBSZo9gfGH4up/tQYQo2yArK0ExY2vhY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u/TU0L1SolBld/Qum5lsMKpZbK303fBFh+JGMRdIeDfMOvxbOvd+sj7Fet4RquTqo
	 cr0T/Q6PmBtaHDm/a/2DhALFhxViIEeD3BFEO87SZoNwY5zk2o5w/WMRME4x92bMaD
	 UalR+stCBKRCmBJBbBCrq0f0nnaqV6uMag1h8qeI=
Date: Sat, 8 Nov 2025 10:36:55 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
 rppt@kernel.org, dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
 rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
 kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
 masahiroy@kernel.org, tj@kernel.org, yoann.congal@smile.fr,
 mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
 axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
 vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com,
 david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org,
 anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
 linux@weissschuh.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org,
 cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com,
 Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
 aleksander.lobakin@intel.com, ira.weiny@intel.com,
 andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
 bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
 stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
 brauner@kernel.org, linux-api@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, ajayachandra@nvidia.com,
 jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, witu@nvidia.com,
 hughd@google.com, skhawaja@google.com, chrisl@kernel.org
Subject: Re: [PATCH v5 00/22] Live Update Orchestrator
Message-Id: <20251108103655.1c89f05222ba06e24ddc3cc3@linux-foundation.org>
In-Reply-To: <CA+CK2bCakoNEHk-fgjpnHpo5jtBoXvnzdeJHQOOBBFM8yo-4zQ@mail.gmail.com>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
	<20251107143310.8b03e72c8f9998ff4c02a0d0@linux-foundation.org>
	<CA+CK2bCakoNEHk-fgjpnHpo5jtBoXvnzdeJHQOOBBFM8yo-4zQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 8 Nov 2025 13:13:32 -0500 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:

> On Fri, Nov 7, 2025 at 5:33 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Fri,  7 Nov 2025 16:02:58 -0500 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> >
> > > This series introduces the Live Update Orchestrator, a kernel subsystem
> > > designed to facilitate live kernel updates using a kexec-based reboot.
> >
> > I added this to mm.git's mm-nonmm-stable branch for some linux-next
> > exposure.  The usual Cc's were suppressed because there would have been
> > so many of them.
> 
> Thank you!
> 

No prob.

It's unfortunate that one has to take unexpected steps (disable
CONFIG_DEFERRED_STRUCT_PAGE_INIT) just to compile test this.

It's a general thing.  I'm increasingly unhappy about how poor
allmodconfig coverage is, so I'm starting to maintain a custom .config
to give improved coverage.

