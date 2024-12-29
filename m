Return-Path: <linux-fsdevel+bounces-38248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F5D9FE08B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 21:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E455F3A1907
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 20:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5934719885F;
	Sun, 29 Dec 2024 20:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jW4j7Ikb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C622594A6
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 20:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735505913; cv=none; b=q+UDVtiGxwH6NgXdLUIMgyF/bNjQ8Br9VyeiBB4xASLurNj1rMbD8bBQpQa3/pO6LWs7iyz3CSjEyCJhHVJay1SLmTLMnfeLFAh75zbxHMO9BT8KVUnZgvpZ4YTZwKD0nSOU/NJTPtLVOOlk2C78TSWabPNibTCmdhUq7kUIo8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735505913; c=relaxed/simple;
	bh=4mtTHX1vNe91JS1LzTjKwF/S5omY8Bak/1sgx+d1awE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBlYSaXzgzr8ACb5ILT7Wt5deL1TPvuvX4hl8W+VU9Tb1C7rBDZjIvItKYXO0Kjsiij/dHRR8/IQdtiCB5T/IxjZm7TBDVKnZ/8yaUqyKaUKWwP4t3r94/YE01/gZ+l05Mh2YvzSLoWWgdLc9RPJd18gsG/5p69p62ExouHNdbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jW4j7Ikb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=U7iK6Bhl/nR+kB1+zntgx6ikSup4mmXyPVeivY518jA=; b=jW4j7Ikb9DMcdNil2/4L0hA9JY
	+1As/oMAAvA2ENIDiAWAL0/hFNDSNuzBEvBwD8eQ7JrYVBo1C6+oc4f8Jrpy8j+UlmKskgvBQSLly
	mXRSnNYlYY637VCJc/crsD2onEpUQrPvjVcFG36o42/vuMDEQMXVkOTdUirmjSIilcigmJuz8PzTw
	1IAwhXaJAzOMXcFq4h9lbGcE8rxfpcJ+XlyOedKnsHYm/r2vu8sCzxg/LF999KeeCXHzIkI/Y3klm
	sHZO4XXz+Akk3dRQDpGmqkP1bM1DYzsY4rODFL87ohHYIAVwXEdNv6nHEkW6dmbz6Kl1FgcR/obW/
	6pPWB3Rg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tS0Mn-0000000DZgm-05Lx;
	Sun, 29 Dec 2024 20:58:29 +0000
Date: Sun, 29 Dec 2024 20:58:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: Re: [PATCHES][RFC][CFT] debugfs cleanups
Message-ID: <20241229205828.GC1977892@ZenIV>
References: <20241229080948.GY1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241229080948.GY1977892@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Dec 29, 2024 at 08:09:48AM +0000, Al Viro wrote:

> 	All of that could be avoided if we augmented debugfs inodes with
> a couple of pointers - no more stashing crap in ->d_fsdata, etc.
> And it's really not hard to do.  The series below attempts to untangle
> that mess; it can be found in
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.debugfs
> 
> 	It's very lightly tested; review and more testing would be
> very welcome.

BTW, looking through debugfs-related stuff...

arch/x86/kernel/cpu/resctrl/pseudo_lock.c:pseudo_lock_measure_trigger()
	debugfs_file_get()/debugfs_file_put() pair inside, even though the
	only use of that sucker is ->write() of file_operations fed
	to debugfs_create_file().  In other words, it's going to be
	called only by full_proxy_write(), which already has such a pair
	around that...
drivers/base/regmap/regmap-debugfs.c:regmap_cache_{only,bypass}_write_file()
	ditto
drivers/gpu/drm/xlnx/zynqmp_dp.c:zynqmp_dp_{pattern,custom}_write()
	ditto
drivers/gpu/drm/xlnx/zynqmp_dp.c:zynqmp_dp_{pattern,custom}_read()
	similar, except that it's ->read() rather than ->write()
drivers/infiniband/hw/hfi1/debugfs.c:hfi1_seq_read()
	ditto, AFAICS.  Verifying that is not pleasant (use of ## in
	that forest of macros is seriously grep-hostile), but...
drivers/infiniband/hw/hfi1/debugfs.c:hfi1_seq_lseek()
	same story for ->llseek()
drivers/infiniband/hw/hfi1/fault.c:fault_opcodes_{read,write}()
	same story
drivers/thermal/testing/command.c:tt_command_write()
	same, but debugfs_file_put() is apparently lost.
	Attempt to rmmod that sucker ought to deadlock if there had
	been a call of that...
sound/soc/sof/ipc4-mtrace.c:sof_ipc4_mtrace_dfs_open()
	->open() calling debugfs_file_get(), with matching debugfs_file_put()
	only in ->release().  Again, that's debugfs_create_file() fodder -
	with nothing to trigger removal in sight.  Fortunately, since had
	that been triggerable from userland, you could get a nice deadlock
	by opening that file and triggering removal...
sound/soc/sof/sof-client-ipc-flood-test.c:sof_ipc_flood_dfs_open()
	same, except that here removal *is* triggerable.  Do rmmod with
	e.g. stdin redirected from that file and you are screwed.
sound/soc/sof/sof-client-ipc-kernel-injector.c:sof_msg_inject_dfs_open()
	same, complete with deadlock on rmmod...
sound/soc/sof/sof-client-ipc-msg-injector.c:sof_msg_inject_dfs_open()
	... and here as well.


As far as I can see, there's not a single legitimate caller of
debugfs_file_{get,put}() outside of fs/debugfs/file.c.  Is there any
reason to keep that stuff non-static, let alone exported?

