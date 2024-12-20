Return-Path: <linux-fsdevel+bounces-37930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7359F93C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 14:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1AE1646A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 13:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF66216381;
	Fri, 20 Dec 2024 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mq7ZIU5g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E83381AA;
	Fri, 20 Dec 2024 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734702815; cv=none; b=LRs+fnJeaRLCnqCQ5lV0s3LiwdiMq9ZlibvH6qA17GSJEJe5v4heFBkjvWMCxlMG2fXAG6yHBLTthT0fO25koUIgpghErvg6Ezhegu6rxqWmbxcFUcK0Y+95JMFcQk/TkRCdhKG/OM+BwEe1lVHF9Wxo+cX/7I4SlcG5/eclIbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734702815; c=relaxed/simple;
	bh=DFSGVDYefT87HHdtP9Y3WhhQXGS/c30Fv6u7sCuruT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXaAUFpzpec0hxpjuwXrTNU04o8pd7Qfi8nY9eioDa0Belqk6p9J+RC9Uc7aqkKX48on1rZ4vVX7vVeJpXyHZ2se4avJK60efCPswPruWBx7tUwtM+dCp2z+VtnrdZFas6N2Q9PWdEWck8kDPhJsMfBblEtts60EAkGcDz6JvMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mq7ZIU5g; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0gr+VNCm5uUHRbQnbS77JDGH1BZn6WFu/UOI0OxcE/0=; b=mq7ZIU5gsHW6dkP1wl4cjfE2/y
	7+luUk996tuCfk8fxhVIBGbffHK8kFih5el8f17Xpx0fqeqYgpEDWi3lEaiSwgNghIiGVTeD9vV8S
	1W4fArI/l1UUj1eeu56lZ+VrGrCOjPcxfb6VkCBrL9da0uChrb4dRUZkd9BfAyi3FAuZ8zh8OjQ2Y
	r6dLqpD/f8U2FXiLXP1HfTs0wKg7yCiPuyx2kYrYaU8pSz630rVFEQLJvhXr3WGjDZebDNZ+vr3Tg
	dTANKWeurEy89GwhJa3K9qiKgFoE6amFT3vGPvCz4CWa+truZGn7PuMRlR8xDk0BHyoi1E7q3W+8H
	blw7bVdA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tOdRV-00000000saA-2Zs0;
	Fri, 20 Dec 2024 13:53:25 +0000
Date: Fri, 20 Dec 2024 13:53:25 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Haichi Wang <wanghaichi@tju.edu.cn>
Cc: dave.hansen@linux.intel.com, brauner@kernel.org, hpa@zytor.com,
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
	tglx@linutronix.de, bp@alien8.de, linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org, luto@kernel.org, x86@kernel.org,
	mingo@redhat.com, kent.overstreet@linux.dev, jack@suse.cz,
	syzkaller@googlegroups.com
Subject: Re: Kernel bug: "general protection fault in
 bch2_btree_path_traverse_one"
Message-ID: <Z2V21UH_3FuNDoa1@casper.infradead.org>
References: <AOAA*AACIqMsH7SiGMkHgaoE.1.1734695024950.Hmail.3014218099@tju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AOAA*AACIqMsH7SiGMkHgaoE.1.1734695024950.Hmail.3014218099@tju.edu.cn>

On Fri, Dec 20, 2024 at 07:43:44PM +0800, Haichi Wang wrote:
> Dear Linux maintainers and reviewers:
> We are reporting a Linux kernel bug titled **general protection fault in bch2_btree_path_traverse_one**, discovered using a modified version of Syzkaller.

No, you aren't.  This is a terrible bug report, and you seem to have
sent several with the same defects.  First, read:

https://blog.regehr.org/archives/2037

Then, specifically to reporting a kernel bug *LOOK AT HOW OTHER PEOPLE
DO IT*.  Your email includes lots of stuff that is of no help and
doesn't include the most important thing -- the kernel logs from around
the time of the failure.

> ### Affected Files
> The affected files, as obtained from the VM log, are listed below. The corresponding maintainers were identified using `./scripts/get_maintainer.pl`:
> fs/bcachefs/btree_update_interior.c
> fs/bcachefs/alloc_foreground.c
> fs/bcachefs/btree_iter.c
> fs/bcachefs/btree_trans_commit.c
> fs/namespace.c
> arch/x86/entry/common.c
> fs/bcachefs/recovery.c
> fs/bcachefs/recovery_passes.c
> fs/bcachefs/super.c
> fs/bcachefs/fs.c
> fs/super.c

This is useless.

> ### Kernel Versions
> - **Kernel Version Tested:** v6.12-rc6:59b723cd2adbac2a34fc8e12c74ae26ae45bf230
> - **Latest Kernel Version Reproduced On:** f44d154d6e3d633d4c49a5d6a8aed0e4684ae25e

Useful

> ### Environment Details
> - **QEMU Version:** QEMU emulator version 4.2.1 (Debian 1:4.2-3ubuntu6.29)  
> - **GCC Version:** gcc (Ubuntu 11.4.0-2ubuntu1~20.04) 11.4.0  
> - **Syzkaller Version:** 2b3ef1577cde5da4fd1f7ece079731e140351177

Useful

> ### Attached Files
> We have attached the following files to assist in reproducing and diagnosing the bug:
> - **Bug Title:** `bugtitle`  
> - **Bug Report:** `report`  
> - **Machine Information:** `machineInfo`  
> - **Kernel Config:** `config`  
> - **Compiled Kernel Image:** `vmlinux`  

You didn't attach these things, but please don't.

We want the stacktrace.  Preferably passed through
scripts/decode_stacktrace.sh so we get nice symbols.


