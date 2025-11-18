Return-Path: <linux-fsdevel+bounces-68810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC077C66A36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 01:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id E8B00298E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 00:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004FD24A067;
	Tue, 18 Nov 2025 00:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="crZXrTvx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail3-164.sinamail.sina.com.cn (mail3-164.sinamail.sina.com.cn [202.108.3.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174B5243367
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 00:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763425269; cv=none; b=RSluQ7LxmB6YN/CjnLJYLRYBfvZXyz+tRM6nmEIqnWjD1PG+rBlAemTx9sABFEw+/3Pe/RT7TiUkyXY4uLIobfzrGQOfEEq0q0JoRmRTp+WFdR4DOzfyxLzVmGnfM+lVyjwGi08O+hKDfEp22tOQGnoWta/AYeJqGRtxddnhglM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763425269; c=relaxed/simple;
	bh=cigLDLXfOlacqav0/3ZTNCtSr8oX8no4GE/gF5U81j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=esVZwHLWR62kF3yf9NqS0cLrwFtdIXyYJJUEeZ6u5FuW8rNpKM6NZsXk+O+ANyaiaXm++o1WEbYLDcbMQA9M8IBZWTxyPGI30C1kwHx2qefJb/NL4Yl1knz9yhyLc6B0LcQ73AiX7jxIXM71haNM+tG9XFwEAglrsDCyef77IjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=crZXrTvx; arc=none smtp.client-ip=202.108.3.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1763425265;
	bh=vbeV1yQx3h4TC9oL7uWZ4IU2rV0I262djm/4+T9mI7I=;
	h=From:Subject:Date:Message-ID;
	b=crZXrTvx69vyQCp+BDGBD5LiqhRMHm1O9s+Dd3NKeskFVwa9X7GHKj2oT1GPQysRc
	 VLGwRZwQ0OedtgdGZ659iM3Hl4wOVH+8NBwytJEQqogdezv59Z8ei/w4xLd+zCVJzR
	 KgC65VaEHttN/7NIsZ1NbFScjH31nU1uNxiIoegU=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.57.85])
	by sina.com (10.54.253.32) with ESMTP
	id 691BBBE50000758D; Tue, 18 Nov 2025 08:20:55 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 865114457068
X-SMAIL-UIID: 0D5883C4738D49338EBDBB33A10334A2-20251118-082055-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+b4c65e7d749285a82467@syzkaller.appspotmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] general protection fault in put_ipc_ns
Date: Tue, 18 Nov 2025 08:20:39 +0800
Message-ID: <20251118002044.9391-1-hdanton@sina.com>
In-Reply-To: <691b044b.a70a0220.3124cb.009d.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Mon, 17 Nov 2025 03:17:31 -0800
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    6d7e7251d03f Add linux-next specific files for 20251113
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15e4c914580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8a6b17620801a7cb
> dashboard link: https://syzkaller.appspot.com/bug?extid=b4c65e7d749285a82467
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=154ec658580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162aeb42580000

#syz test: https://github.com/brauner/linux.git namespace-6.19

