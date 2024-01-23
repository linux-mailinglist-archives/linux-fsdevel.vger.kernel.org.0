Return-Path: <linux-fsdevel+bounces-8511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70233838794
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 07:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AC8EB2184E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 06:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D925026E;
	Tue, 23 Jan 2024 06:39:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE08524A4;
	Tue, 23 Jan 2024 06:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705991978; cv=none; b=I+jpSyVH6Hiwp3FYsFnsD85Fw6HtjQQqlwvQCKae0kH6S8Yeu/GRdX+BAllonfQ/jpo6clA1Uebn5103eKX5BXAqEy0wt2qeoEq7TWEDLadXZS/qB7ssGq540DVgj0ZQ3mnZ1bXAVYMmqyrMyFegqQjdAsUINC9z4V09FNSLb2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705991978; c=relaxed/simple;
	bh=o7h8LhDkV9Em6vHKMR8WG3LnUB3TLO86qfqho4SKvXE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QwoO61odrgcmDW2oW2YYuqlr8LMmYuGJnbQ/AHOj+uoXPngshFBM9m9r75ARZiNk+x4t0D3Mwu2G+8AnI60ijcGEp0XMieszZo8SxAW+XuMVQWbub/Uu+HoS2pAhvdXXUtCgBhOd7Bw0HRCasAFF3sp0Czfc49tHDN7i6jZpbLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rSARZ-0006oH-HC; Tue, 23 Jan 2024 07:39:33 +0100
Message-ID: <bbac350b-7a94-475e-88c9-35f6f8700af8@leemhuis.info>
Date: Tue, 23 Jan 2024 07:39:32 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] 6.6.10+ and 6.7+ kernels lock up early in init.
Content-Language: en-US, de-DE
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: Jeff Layton <jlayton@kernel.org>
Cc: stable@vger.kernel.org, Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Chuck Lever
 <chuck.lever@oracle.com>, Paul Thompson <set48035@gmail.com>,
 regressions@lists.linux.dev
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <Za9DUZoJbV0PYGN2@squish.home.loc>
 <6939adb3-c270-481f-8547-e267d642beea@leemhuis.info>
In-Reply-To: <6939adb3-c270-481f-8547-e267d642beea@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1705991976;5b94feee;
X-HE-SMSGID: 1rSARZ-0006oH-HC

[a quick follow up with an important correction from the reporter for
those I added to the list of recipients]

On 23.01.24 06:37, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 23.01.24 05:40, Paul Thompson wrote:
>>
>> 	With my longstanding configuration, kernels upto 6.6.9 work fine.
>> Kernels 6.6.1[0123] and 6.7.[01] all lock up in early (open-rc) init,
>> before even the virtual filesystems are mounted.
>>
>> 	The last thing visible on the console is the nfsclient service
>> being started and:
>>
>> Call to flock failed: Funtion not implemented. (twice)
>>
>> 	Then the machine is unresponsive, numlock doesnt toggle the keyboard led,
>> and the alt-sysrq chords appear to do nothing.
>>
>> 	The problem is solved by changing my 6.6.9 config option:
>>
>> # CONFIG_FILE_LOCKING is not set
>> to
>> CONFIG_FILE_LOCKING=y
>>
>> (This option is under File Systems > Enable POSIX file locking API)

The reporter replied out-of-thread:
https://lore.kernel.org/all/Za9TRtSjubbX0bVu@squish.home.loc/

"""
	Now I feel stupid or like Im losing it, but I went back and grepped for
the CONFIG_FILE_LOCKING in my old Configs, and it was turned on in all
but 6.6.9. So, somehow I turned that off *after I built 6.6.9? Argh. I
just built 6.6.4 with it unset and that locked up too.
	Sorry if this is just noise, though one would have hoped the failure
was less severe...
"""

>> 	I do not recall why I unset that, but it was working for I think the
>> entire 6.6 series until 6.6.10. Anyway thought I would mention it in case
>> anyone else hits it.
> 
> Thx for the report.
> 
> CCing a few people to let them known about this. Among them Jeff, who
> had a few fs patches that were backported to 6.6.10 (at the end of
> the list below).
> 
> FWIW, in case anyone wonders what went into that stable release, here
> is a slightly trimmed down list:
> 
> $ git log v6.6.9..v6.6.10 --oneline  | grep -v -e wifi -e ftrace -e kexec -e ksmb -e 'platform/'  -e tracing: -e netfilter: -e mptcp
> c9a51ebb4bac69 Linux 6.6.10
> baa88944038bbe ring-buffer: Fix wake ups when buffer_percent is set to 100
> c62b9a2daf2866 Revert "nvme-fc: fix race between error recovery and creating association"
> d16c5d215b53b3 mm/memory-failure: check the mapcount of the precise page
> 8c7da70d9ae4c1 mm/memory-failure: cast index to loff_t before shifting it
> 07550b1461d4d0 mm: migrate high-order folios in swap cache correctly
> d16eb52c176ccf mm/filemap: avoid buffered read/write race to read inconsistent data
> 09141f08fdf69a selftests: secretmem: floor the memory size to the multiple of page_size
> 2c30b8b105d690 maple_tree: do not preallocate nodes for slot stores
> b5f63f5e8a6820 block: renumber QUEUE_FLAG_HW_WC
> 183c8972b6a6f8 linux/export: Ensure natural alignment of kcrctab array
> 466e9af1550724 linux/export: Fix alignment for 64-bit ksymtab entries
> 28d6cde17f2191 virtio_ring: fix syncs DMA memory with different direction
> 9a49874443307c fs: cifs: Fix atime update check
> 23171df51f601c client: convert to new timestamp accessors
> 5b5599a7eee5e6 fs: new accessor methods for atime and mtime
> 
> Ciao, Thorsten
> 
> 

