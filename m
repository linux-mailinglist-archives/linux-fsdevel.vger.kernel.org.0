Return-Path: <linux-fsdevel+bounces-38577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B41FEA04378
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 15:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96A21885812
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 14:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC421F2C20;
	Tue,  7 Jan 2025 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bQTsU90d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B1A1F238F
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jan 2025 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261783; cv=none; b=Sm/HcrbTqpZUynWKVhtirYz602sAmIV+3Qhb4xBZ77vzsHca2heGNDUsz8SjztMFf1CV1xzDfFuexNbcrPvqZDoRbV7sQtGCqaeJUAxtpzREB9iMdsrDGWhR2p4Eqo703alLMqO14eYNZ/u/wE+KfzgSapkipAJ5A2yLEwR5938=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261783; c=relaxed/simple;
	bh=eL/GDRInGF+I0i9Sj0cwngnsZF2oD250l8ncdYPW4Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2YCSLYiWdnxjwK//J6Prr9ZlCc3LP4Ibsp4WKPpjhedxhqKqo/JUhJ5Bf/39tZj6DQZCGMma+3i1eKyVZf+veZIoiBdorfIExF4dwlHKs1laZAtwD9pDbiX8H19DKlWyx1ZteDgCMkWgVXhQtIg+v/EJvabNSWBfQhxfR4CHvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bQTsU90d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9EEC4CED6;
	Tue,  7 Jan 2025 14:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736261782;
	bh=eL/GDRInGF+I0i9Sj0cwngnsZF2oD250l8ncdYPW4Lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bQTsU90db9Z6337SGKK2qe0DqW+cgDoo7qShfTWpR9AqXwtbLWkVyTkgFn9uiihwf
	 ZELv0SnfWHwpOFMjscZUuwrfTSuaY9Gvi0o3oGJhQT8GlJdr9aOT5NZOjOs5TgnjFL
	 meX6NGM0kvqqswooiI5ebbu7W14EEn0s/cuK91Cg=
Date: Tue, 7 Jan 2025 15:56:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCHES][RFC][CFT] debugfs cleanups
Message-ID: <2025010715-afterlife-labrador-02f7@gregkh>
References: <20241229080948.GY1977892@ZenIV>
 <20241229205828.GC1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241229205828.GC1977892@ZenIV>

On Sun, Dec 29, 2024 at 08:58:28PM +0000, Al Viro wrote:
> On Sun, Dec 29, 2024 at 08:09:48AM +0000, Al Viro wrote:
> 
> > 	All of that could be avoided if we augmented debugfs inodes with
> > a couple of pointers - no more stashing crap in ->d_fsdata, etc.
> > And it's really not hard to do.  The series below attempts to untangle
> > that mess; it can be found in
> > git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.debugfs
> > 
> > 	It's very lightly tested; review and more testing would be
> > very welcome.
> 
> BTW, looking through debugfs-related stuff...
> 
> arch/x86/kernel/cpu/resctrl/pseudo_lock.c:pseudo_lock_measure_trigger()
> 	debugfs_file_get()/debugfs_file_put() pair inside, even though the
> 	only use of that sucker is ->write() of file_operations fed
> 	to debugfs_create_file().  In other words, it's going to be
> 	called only by full_proxy_write(), which already has such a pair
> 	around that...
> drivers/base/regmap/regmap-debugfs.c:regmap_cache_{only,bypass}_write_file()
> 	ditto
> drivers/gpu/drm/xlnx/zynqmp_dp.c:zynqmp_dp_{pattern,custom}_write()
> 	ditto
> drivers/gpu/drm/xlnx/zynqmp_dp.c:zynqmp_dp_{pattern,custom}_read()
> 	similar, except that it's ->read() rather than ->write()
> drivers/infiniband/hw/hfi1/debugfs.c:hfi1_seq_read()
> 	ditto, AFAICS.  Verifying that is not pleasant (use of ## in
> 	that forest of macros is seriously grep-hostile), but...
> drivers/infiniband/hw/hfi1/debugfs.c:hfi1_seq_lseek()
> 	same story for ->llseek()
> drivers/infiniband/hw/hfi1/fault.c:fault_opcodes_{read,write}()
> 	same story
> drivers/thermal/testing/command.c:tt_command_write()
> 	same, but debugfs_file_put() is apparently lost.
> 	Attempt to rmmod that sucker ought to deadlock if there had
> 	been a call of that...
> sound/soc/sof/ipc4-mtrace.c:sof_ipc4_mtrace_dfs_open()
> 	->open() calling debugfs_file_get(), with matching debugfs_file_put()
> 	only in ->release().  Again, that's debugfs_create_file() fodder -
> 	with nothing to trigger removal in sight.  Fortunately, since had
> 	that been triggerable from userland, you could get a nice deadlock
> 	by opening that file and triggering removal...
> sound/soc/sof/sof-client-ipc-flood-test.c:sof_ipc_flood_dfs_open()
> 	same, except that here removal *is* triggerable.  Do rmmod with
> 	e.g. stdin redirected from that file and you are screwed.
> sound/soc/sof/sof-client-ipc-kernel-injector.c:sof_msg_inject_dfs_open()
> 	same, complete with deadlock on rmmod...
> sound/soc/sof/sof-client-ipc-msg-injector.c:sof_msg_inject_dfs_open()
> 	... and here as well.
> 
> 
> As far as I can see, there's not a single legitimate caller of
> debugfs_file_{get,put}() outside of fs/debugfs/file.c.  Is there any
> reason to keep that stuff non-static, let alone exported?

Nope, not at all!

