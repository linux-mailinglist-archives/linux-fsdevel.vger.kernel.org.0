Return-Path: <linux-fsdevel+bounces-21104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF188FE6C4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 14:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27F991C24876
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 12:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2E2195B0B;
	Thu,  6 Jun 2024 12:46:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9E519581F
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jun 2024 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717677972; cv=none; b=eueIZFixvM0hVOAxpqnBBov8948PsVuB8rM4XpoRDOCGGswyQYpxacabxkHHetWpEm991r2eL/V7gRVvPzWFszzhsL0b76hqmT8XjcWsfqjsN1efrG1ot/NEKtAiMGVOFL6z/Rc+hWLBpd9iKbF2cCjmZMpmRWpeusDSnxmZ5S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717677972; c=relaxed/simple;
	bh=bmqX1ycZ0DnvWeyUuZQzKPrA5YHot5kDUi8pM45nS00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ksPm0a3lS9h7MDK2ePuwGpCo2dwB5kmcOycwgN7avURRHStGhweHpO/xKbtvaDIi/creUXCdlQfQZIz5q4UvPTo0kzPxOEehlo1lzXpSNbDlKmHCqE25AmK2FtGw9wOkseaWc9tCekxoxbufLRPKUwe3+ztPbwBJl1766DcvVxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FA9E2F4;
	Thu,  6 Jun 2024 05:46:34 -0700 (PDT)
Received: from [10.1.29.193] (R90XJLFY.arm.com [10.1.29.193])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A22463F64C;
	Thu,  6 Jun 2024 05:46:08 -0700 (PDT)
Message-ID: <f8586f0c-f62c-4d92-8747-0ba20a03f681@arm.com>
Date: Thu, 6 Jun 2024 13:45:05 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: don't block i_writecount during exec
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 david@fromorbit.com, hch@lst.de, Josef Bacik <josef@toxicpanda.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, amir73il@gmail.com,
 Mark Brown <broonie@kernel.org>, Naresh Kamboju <naresh.kamboju@linaro.org>
References: <20240531-beheben-panzerglas-5ba2472a3330@brauner>
 <20240531-vfs-i_writecount-v1-1-a17bea7ee36b@kernel.org>
Content-Language: en-US
From: Aishwarya TCV <aishwarya.tcv@arm.com>
In-Reply-To: <20240531-vfs-i_writecount-v1-1-a17bea7ee36b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 31/05/2024 14:01, Christian Brauner wrote:
> Back in 2021 we already discussed removing deny_write_access() for
> 
> executables. Back then I was hesistant because I thought that this might
> 
> cause issues in userspace. But even back then I had started taking some
> 
> notes on what could potentially depend on this and I didn't come up with
> 
> a lot so I've changed my mind and I would like to try this.
> 
> 
> 

Hi Christian,

LTP test "execve04" is failing when run against
next-master(next-20240606) kernel with Arm64 on JUNO in our CI.

A bisect identified 244ebddd34a0ab7b1ef865811864136873f4b67c as the
first bad commit. Bisected it on the tag "next-20240604" at repo
"https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git".

This works fine on Linux version 6.10-rc2

Failure log
------------
tst_test.c:1690: TINFO: LTP version: 20230929
tst_test.c:1574: TINFO: Timeout per run is 0h 01m 30s
execve_child.c:27: TFAIL: execve_child shouldn't be executed
tst_test.c:1622: TINFO: Killed the leftover descendant processes

Summary:
passed   0
failed   1
broken   0
skipped  0
warnings 0

Bisect log:
----------
git bisect start
# good: [c3f38fa61af77b49866b006939479069cd451173] Linux 6.10-rc2
git bisect good c3f38fa61af77b49866b006939479069cd451173
# bad: [d97496ca23a2d4ee80b7302849404859d9058bcd] Add linux-next
specific files for 20240604
git bisect bad d97496ca23a2d4ee80b7302849404859d9058bcd
# bad: [f89ceec12d7134c9be89f880655b72e36dd3c681] Merge branch
'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
git bisect bad f89ceec12d7134c9be89f880655b72e36dd3c681
# good: [a933c8b54a9ea9bb6b10d168351638933c40b487] Merge branch
'for-next' of
git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git
git bisect good a933c8b54a9ea9bb6b10d168351638933c40b487
# bad: [2d893301453cefb11116f6095a791b8013bbc3e9] Merge branch
'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
git bisect bad 2d893301453cefb11116f6095a791b8013bbc3e9
# good: [a6a2e13e3bc64365c70b52d42b5d3a674152d5cd] Merge branch
'nfsd-next' of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
git bisect good a6a2e13e3bc64365c70b52d42b5d3a674152d5cd
# bad: [e4c1aa3f74bcc90cff6cf8ea575e222066f5be7b] Merge branch 'fs-next'
of linux-next
git bisect bad e4c1aa3f74bcc90cff6cf8ea575e222066f5be7b
# good: [37007c875042e5f5fc65087ea7d67ca388412875] Merge branch
'renesas-clk' of
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git
git bisect good 37007c875042e5f5fc65087ea7d67ca388412875
# bad: [4247aca2219daab5ea6aeebc3d27d32ad56d2472] Merge branch
'vfs.module.description' into vfs.all
git bisect bad 4247aca2219daab5ea6aeebc3d27d32ad56d2472
# bad: [68efe7d9f3055ee986c51178e76061bdad782ff9] Merge branch
'vfs.xattr' into vfs.all
git bisect bad 68efe7d9f3055ee986c51178e76061bdad782ff9
# good: [1f9ccdf69c9ffb9a9084cc6e1a47c5030cebed26] readdir: Add missing
quote in macro comment
git bisect good 1f9ccdf69c9ffb9a9084cc6e1a47c5030cebed26
# bad: [03950a7a6f1a511a372bc46cd4fddd2df7e37a62] Merge branch
'vfs.misc' into vfs.all
git bisect bad 03950a7a6f1a511a372bc46cd4fddd2df7e37a62
# bad: [f113ef08b6bde5f4c74eb4d66f7ca52e09305bb0] tmpfs: don't interrupt
fallocate with EINTR
git bisect bad f113ef08b6bde5f4c74eb4d66f7ca52e09305bb0
# bad: [244ebddd34a0ab7b1ef865811864136873f4b67c] fs: don't block
i_writecount during exec
git bisect bad 244ebddd34a0ab7b1ef865811864136873f4b67c
# first bad commit: [244ebddd34a0ab7b1ef865811864136873f4b67c] fs: don't
block i_writecount during exec

Thanks,
Aishwarya

