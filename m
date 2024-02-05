Return-Path: <linux-fsdevel+bounces-10242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0783C8493D7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 07:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADA0E1F239F6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 06:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD18A10A2E;
	Mon,  5 Feb 2024 06:22:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4875A10A1B
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 06:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707114156; cv=none; b=iqnWENH9CQ488JfnDPqOvvCe1F/9px7zgsb+MQkCcPvaHGI2tswxjfi3+RVr9NMVpr6r3j3kjNyaB0ik5dHc2UmpHXBmPyu1pKu2HypHZEIvoEumP5cotNliDLmeU6RuykVK4JtJkRqBdNEC8npXNnylLOcOrf0YkNOIhOSz4t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707114156; c=relaxed/simple;
	bh=USqSHqPIICC1A9hscVo9/pVYn2vuRJ3swTLiPLXsL6E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c0BZ9ZT6Wc82ptyFxoRqt5ycwanyKXA9UMrcxxQ41zKvFq8DUYNbzYrbat0uCc2r2j9zKe4EisCVpTlXREspLTPixfTB8WDICnl9CaTBUjWCg5vJ0t79gHSYf+JNJnO35RSgxe5T/2bDDzZiSWVAU3X3JeU77uYxvEKkU4+euDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1707114150-1eb14e0c7c36c90001-kl68QG
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id 9Nu8n3yqRaz08sIo (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 05 Feb 2024 14:22:30 +0800 (CST)
X-Barracuda-Envelope-From: JonasZhou-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXBJMBX02.zhaoxin.com (10.29.252.6) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 5 Feb
 2024 14:22:30 +0800
Received: from silvia-OptiPlex-3010.zhaoxin.com (10.29.8.47) by
 ZXBJMBX02.zhaoxin.com (10.29.252.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 5 Feb 2024 14:22:29 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
From: JonasZhou <jonaszhou-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.6
To: <willy@infradead.org>
CC: <CobeChen@zhaoxin.com>, <JonasZhou-oc@zhaoxin.com>,
	<JonasZhou@zhaoxin.com>, <LouisQi@zhaoxin.com>, <brauner@kernel.org>,
	<jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs/address_space: move i_mmap_rwsem to mitigate a false sharing with i_mmap.
Date: Mon, 5 Feb 2024 14:22:29 +0800
X-ASG-Orig-Subj: Re: [PATCH] fs/address_space: move i_mmap_rwsem to mitigate a false sharing with i_mmap.
Message-ID: <20240205062229.5283-1-jonaszhou-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Zb1DVNGaorZCDS7R@casper.infradead.org>
References: <Zb1DVNGaorZCDS7R@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX02.zhaoxin.com (10.29.252.6)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1707114150
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 3250
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.120405
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

> On Fri, Feb 02, 2024 at 03:03:51PM +0000, Matthew Wilcox wrote:
> > On Fri, Feb 02, 2024 at 05:34:07PM +0800, JonasZhou-oc wrote:
> > > In the struct address_space, there is a 32-byte gap between i_mmap
> > > and i_mmap_rwsem. Due to the alignment of struct address_space
> > > variables to 8 bytes, in certain situations, i_mmap and
> > > i_mmap_rwsem may end up in the same CACHE line.
> > > 
> > > While running Unixbench/execl, we observe high false sharing issues
> > > when accessing i_mmap against i_mmap_rwsem. We move i_mmap_rwsem
> > > after i_private_list, ensuring a 64-byte gap between i_mmap and
> > > i_mmap_rwsem.
> > 
> > I'm confused.  i_mmap_rwsem protects i_mmap.  Usually you want the lock
> > and the thing it's protecting in the same cacheline.  Why is that not
> > the case here?
>
> We actually had this seven months ago:
>
> https://lore.kernel.org/all/20230628105624.150352-1-lipeng.zhu@intel.com/
>
> Unfortunately, no argumentation was forthcoming about *why* this was
> the right approach.  All we got was a different patch and an assertion
> that it still improved performance.
>
> We need to understand what's going on!  Please don't do the same thing
> as the other submitter and just assert that it does.

When running UnixBench/execl, each execl process repeatedly performs 
i_mmap_lock_write -> vma_interval_tree_remove/insert -> 
i_mmap_unlock_write. As indicated below, when i_mmap and i_mmap_rwsem 
are in the same CACHE Line, there will be more HITM.

Func0: i_mmap_lock_write
Func1: vma_interval_tree_remove/insert
Func2: i_mmap_unlock_write
In the same CACHE Line
Process A | Process B | Process C | Process D | CACHE Line state 
----------+-----------+-----------+-----------+-----------------
Func0     |           |           |           | I->M
          | Func0     |           |           | HITM M->S
Func1     |           |           |           | may change to M
          |           | Func0     |           | HITM M->S
Func2     |           |           |           | S->M
          |           |           | Func0     | HITM M->S

In different CACHE Lines
Process A | Process B | Process C | Process D | CACHE Line state 
----------+-----------+-----------+-----------+-----------------
Func0     |           |           |           | I->M
          | Func0     |           |           | HITM M->S
Func1     |           |           |           | 
          |           | Func0     |           | S->S
Func2     |           |           |           | S->M
          |           |           | Func0     | HITM M->S

The same issue will occur in Unixbench/shell because the shell 
launches a lot of shell commands, loads executable files and dynamic 
libraries into memory, execute, and exit.

Yes, his commit has been merged into the Linux kernel, but there 
is an issue. After moving i_mmap_rwsem below flags, there is a 
32-byte gap between i_mmap_rwsem and i_mmap. However, the struct 
address_space is aligned to sizeof(long), which is 8 on the x86-64 
architecture. As a result, i_mmap_rwsem and i_mmap may be placed on 
the same CACHE Line, causing a false sharing problem. This issue has 
been observed using the perf c2c tool.

