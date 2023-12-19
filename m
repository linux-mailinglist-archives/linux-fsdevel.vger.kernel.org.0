Return-Path: <linux-fsdevel+bounces-6524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1EC8191DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 22:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F3291F2322A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 21:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C043D0A7;
	Tue, 19 Dec 2023 21:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JFwmCwdB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CC23C6A4
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Dec 2023 21:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 19 Dec 2023 16:02:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703019777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qsj0lc16eNSjypOaBN+kiTN4/ImC8Sqq9/KbAa5A9Yg=;
	b=JFwmCwdBloOFVe4lIBYNnTgC2AMZG71MPaUzExbNJzqvrsWsGYIUxGXAkzYcDzsw96EgZg
	MbdQdodF2adLe9nMCNIlobqZHGc7bMzrki23ghmGsP8M0gJ1qnPSolpHBOEtDzp5bJ7MZT
	yyK1rTnD+M1lgIQHh7wWIKRg+QpkeFk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, x86@kernel.org,
	tj@kernel.org, peterz@infradead.org, mathieu.desnoyers@efficios.com,
	paulmck@kernel.org, keescook@chromium.org,
	dave.hansen@linux.intel.com, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, boqun.feng@gmail.com, brauner@kernel.org
Subject: Re: [PATCH 15/50] kernel/numa.c: Move logging out of numa.h
Message-ID: <20231219210253.btvil5tychx6b6kx@moria.home.lan>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216032651.3553101-1-kent.overstreet@linux.dev>
 <20231216032651.3553101-5-kent.overstreet@linux.dev>
 <20231219163644.GA345795@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219163644.GA345795@dev-arch.thelio-3990X>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 19, 2023 at 09:36:44AM -0700, Nathan Chancellor wrote:
> On Fri, Dec 15, 2023 at 10:26:14PM -0500, Kent Overstreet wrote:
> These need EXPORT_SYMBOL_GPL() now like the architecture specific
> implementations because they are no longer inlined. My arm64 builds fail
> with:
> 
>   ERROR: modpost: "memory_add_physaddr_to_nid" [drivers/acpi/nfit/nfit.ko] undefined!
>   ERROR: modpost: "phys_to_target_node" [drivers/acpi/nfit/nfit.ko] undefined!
>   ERROR: modpost: "memory_add_physaddr_to_nid" [drivers/virtio/virtio_mem.ko] undefined!
>   ERROR: modpost: "phys_to_target_node" [drivers/dax/dax_cxl.ko] undefined!
>   ERROR: modpost: "memory_add_physaddr_to_nid" [drivers/dax/dax_cxl.ko] undefined!
>   ERROR: modpost: "phys_to_target_node" [drivers/cxl/cxl_acpi.ko] undefined!
>   ERROR: modpost: "memory_add_physaddr_to_nid" [drivers/cxl/cxl_pmem.ko] undefined!
>   ERROR: modpost: "phys_to_target_node" [drivers/cxl/cxl_pmem.ko] undefined!
>   ERROR: modpost: "memory_add_physaddr_to_nid" [drivers/hv/hv_balloon.ko] undefined!

Applied the following:


commit 7ae175e405b44b9897c04bbf177e3e08ab25710a
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Tue Dec 19 16:02:26 2023 -0500

    fixup! kernel/numa.c: Move logging out of numa.h

diff --git a/kernel/numa.c b/kernel/numa.c
index c24c72f45989..67ca6b8585c0 100644
--- a/kernel/numa.c
+++ b/kernel/numa.c
@@ -12,6 +12,7 @@ int memory_add_physaddr_to_nid(u64 start)
 			start);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
 #endif
 
 #ifndef phys_to_target_node
@@ -21,4 +22,5 @@ int phys_to_target_node(u64 start)
 			start);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(phys_to_target_node);
 #endif

