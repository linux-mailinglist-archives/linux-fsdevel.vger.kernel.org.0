Return-Path: <linux-fsdevel+bounces-13680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDB5872EB8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 07:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B492855E2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 06:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889D31BDDB;
	Wed,  6 Mar 2024 06:16:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2482E1BDCF
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 06:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709705796; cv=none; b=FmM6cmbncm7YOtaVolaLFKj35hWWc2hWrLnKBXYhn1buFk8LKxxrI3DXHxEOA3wJsm5048LqczvmFVExNdfy4HXGGnN4isEOwlTOjHXdk3SjSBhAIbucveqk0Idxcrwa6MvB0ZzAw/SL7dCway/4qw+oPfGWF/n5gjXIYRNTTak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709705796; c=relaxed/simple;
	bh=l47ouKNP0igEWsbz7oOYX4il4wC7fxvpczOytLXwBJ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o/okGoWpBGIXZsfC0AeEe/iRH00lT91a6QmWoGeV8b5XEzOAH00+b1JjVChgfxYI02syDBbCdaE8r5LPZJtLLFCBFKGcrkMr4A4EpoCsPqs3PFfu1jPxuHBlTF2KOWDNwsbQ+oVCt7amIXwTU6vxZko3YXj72sBHOx8Q8wq2/ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1709705784-1eb14e2b8301870001-kl68QG
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id u4PGJLB8FEma0314 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 06 Mar 2024 14:16:24 +0800 (CST)
X-Barracuda-Envelope-From: JonasZhou-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXBJMBX02.zhaoxin.com (10.29.252.6) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Mar
 2024 14:16:24 +0800
Received: from zjh-VirtualBox.zhaoxin.com (10.28.66.66) by
 ZXBJMBX02.zhaoxin.com (10.29.252.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 6 Mar 2024 14:16:23 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
From: JonasZhou <JonasZhou-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.6
To: <david@fromorbit.com>
CC: <CobeChen@zhaoxin.com>, <JonasZhou@zhaoxin.com>, <LouisQi@zhaoxin.com>,
	<brauner@kernel.org>, <jack@suse.cz>, <jonaszhou-oc@zhaoxin.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<viro@zeniv.linux.org.uk>, <willy@infradead.org>
Subject: Re: [PATCH] fs/address_space: move i_mmap_rwsem to mitigate a false sharing with i_mmap.
Date: Wed, 6 Mar 2024 14:16:22 +0800
X-ASG-Orig-Subj: Re: [PATCH] fs/address_space: move i_mmap_rwsem to mitigate a false sharing with i_mmap.
Message-ID: <20240306061622.113920-1-JonasZhou-oc@zhaoxin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZcFsJvUOVMc8e0yO@dread.disaster.area>
References: <ZcFsJvUOVMc8e0yO@dread.disaster.area>
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
X-Barracuda-Start-Time: 1709705784
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1316
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.121729
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

> On Mon, Feb 05, 2024 at 02:22:29PM +0800, JonasZhou wrote:
> 
> As I expected, your test is exercising the contention case rather
> than the single, uncontended case. As such, your patch is simply
> optimising the structure layout for the contended case at the
> expense of an extra cacheline miss in the uncontended case.
> 
> I'm not an mm expert, so I don't know which case we should optimise
> for.
> 
> However, the existing code is not obviously wrong, it's just that
> your micro-benchmark exercises the pathological worst case for the
> optimisation choices made for this structure. Whether the contention
> case is worth optimising is the first decision that needs to be
> made, then people can decide if hacking minor optimisations into the
> code is better than reworking the locking and/or algorithm to avoid
> the contention altogether is a better direction...

According to https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?qt=grep&q=unixbench, 
many people use Unixbench and submit optimization patches to Linux based 
on its scores. So this is not my micro-benchmark exercises.

When multiple processes open the same file, such as multiple processes 
opening libc.so, there will be contention.

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

