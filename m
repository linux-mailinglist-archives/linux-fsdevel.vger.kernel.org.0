Return-Path: <linux-fsdevel+bounces-8509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2294C8386CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 06:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE05D1F246E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 05:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7824414;
	Tue, 23 Jan 2024 05:37:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F665384;
	Tue, 23 Jan 2024 05:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705988231; cv=none; b=fwYgjIIbBdZ+WHv8r0e/aokVAyHRdMwPQLVqFiBJrzrBMZUHqCvd+awAEGotx7v2j1LtzinalUdsRjrGrLw3hzzfMgp4NkQZLwgNicr0gHeDOvKmoJi6p0H09MZEiO3//vI4B0dvOlcbKtJTJTwWRDhrkxL4o9rRHbOe1sAbRto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705988231; c=relaxed/simple;
	bh=5MIGP5WxOnDNLJOe4yuzlmi71dpv7yl6EHub6JKmjL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=buGugCMNRvruxnaj0B/D/i/w0I5RJ/KOjgFKrngbgijj0ZxTWmIuuvZ35m8QnlbhwvPVrIfzpqMxeO0GMmGxB5u9ksGE+OAAzarcgzamRZDJ9PvZQvfx40OE64FtgnAP9JJRHuVIrKz2xb4S9M2K7xffk3jbdfKE9OIMRxYUGdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rS9T3-00069e-70; Tue, 23 Jan 2024 06:37:01 +0100
Message-ID: <6939adb3-c270-481f-8547-e267d642beea@leemhuis.info>
Date: Tue, 23 Jan 2024 06:37:00 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] 6.6.10+ and 6.7+ kernels lock up early in init.
Content-Language: en-US, de-DE
To: Jeff Layton <jlayton@kernel.org>
Cc: stable@vger.kernel.org, Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Chuck Lever
 <chuck.lever@oracle.com>, Paul Thompson <set48035@gmail.com>,
 regressions@lists.linux.dev
References: <Za9DUZoJbV0PYGN2@squish.home.loc>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <Za9DUZoJbV0PYGN2@squish.home.loc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1705988230;4b2650a3;
X-HE-SMSGID: 1rS9T3-00069e-70

On 23.01.24 05:40, Paul Thompson wrote:
> 
> 	With my longstanding configuration, kernels upto 6.6.9 work fine.
> Kernels 6.6.1[0123] and 6.7.[01] all lock up in early (open-rc) init,
> before even the virtual filesystems are mounted.
> 
> 	The last thing visible on the console is the nfsclient service
> being started and:
> 
> Call to flock failed: Funtion not implemented. (twice)
> 
> 	Then the machine is unresponsive, numlock doesnt toggle the keyboard led,
> and the alt-sysrq chords appear to do nothing.
> 
> 	The problem is solved by changing my 6.6.9 config option:
> 
> # CONFIG_FILE_LOCKING is not set
> to
> CONFIG_FILE_LOCKING=y
> 
> (This option is under File Systems > Enable POSIX file locking API)
> 
> 	I do not recall why I unset that, but it was working for I think the
> entire 6.6 series until 6.6.10. Anyway thought I would mention it in case
> anyone else hits it.

Thx for the report.

CCing a few people to let them known about this. Among them Jeff, who
had a few fs patches that were backported to 6.6.10 (at the end of
the list below).

FWIW, in case anyone wonders what went into that stable release, here
is a slightly trimmed down list:

$ git log v6.6.9..v6.6.10 --oneline  | grep -v -e wifi -e ftrace -e kexec -e ksmb -e 'platform/'  -e tracing: -e netfilter: -e mptcp
c9a51ebb4bac69 Linux 6.6.10
baa88944038bbe ring-buffer: Fix wake ups when buffer_percent is set to 100
c62b9a2daf2866 Revert "nvme-fc: fix race between error recovery and creating association"
d16c5d215b53b3 mm/memory-failure: check the mapcount of the precise page
8c7da70d9ae4c1 mm/memory-failure: cast index to loff_t before shifting it
07550b1461d4d0 mm: migrate high-order folios in swap cache correctly
d16eb52c176ccf mm/filemap: avoid buffered read/write race to read inconsistent data
09141f08fdf69a selftests: secretmem: floor the memory size to the multiple of page_size
2c30b8b105d690 maple_tree: do not preallocate nodes for slot stores
b5f63f5e8a6820 block: renumber QUEUE_FLAG_HW_WC
183c8972b6a6f8 linux/export: Ensure natural alignment of kcrctab array
466e9af1550724 linux/export: Fix alignment for 64-bit ksymtab entries
28d6cde17f2191 virtio_ring: fix syncs DMA memory with different direction
9a49874443307c fs: cifs: Fix atime update check
23171df51f601c client: convert to new timestamp accessors
5b5599a7eee5e6 fs: new accessor methods for atime and mtime

Ciao, Thorsten

