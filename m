Return-Path: <linux-fsdevel+bounces-62227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F6CB896E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 14:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA9D3AF458
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 12:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35F031079C;
	Fri, 19 Sep 2025 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="W2rZmp6x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from r3-17.sinamail.sina.com.cn (r3-17.sinamail.sina.com.cn [202.108.3.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B163101DC
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 12:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284590; cv=none; b=EQ/cwx0a26PVlozTlO3hL5cVfGrRzsbQmu3uUVrgU/V4KSgf3BqAJ++rlOn0n91e+9tJxFjwFHotqJvqp3C9ZCvAM7CU66HyrvQ6ZU7a7ridPvONTA1lBcCEFyIlsKMFI8YT5SX3T+iITzADc9MLJna4dlF/Qb0MmVdeYhRh8cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284590; c=relaxed/simple;
	bh=KIJ8hSpUPj5yJOYsOOvoMAboQbBE3gvNf+eNVgk4gUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGH2Jf7cqgRVxdHUvzoC9L9s0OuhUm2JEMgvgN7PDdrYrzSFG7g9haKRJeBc20HsjEA5TgzsnJ3VT0D+/Algvt/yBOJyctP5mbjlRmL+MOnCzwBN1E30EVp3q/6YdqU2dsgRR39Yj8JNEJlJbGgW/GYGcGK0EHazdxFYe/1daaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=W2rZmp6x; arc=none smtp.client-ip=202.108.3.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1758284586;
	bh=MwuO3s4MxolpqYas14pKeShCxVq/OriEAKTj9BTUoq0=;
	h=From:Subject:Date:Message-ID;
	b=W2rZmp6xioCesSVbicqcQbBGrsCx6n4rV4IXl6bD30xfbhkKuLp4PV6ehkQYfWAd0
	 uN0w6PhYDWOBx/yKF/w/zz5T3saKxl5WBjEt5XOtYpu8SsKBcL/sdSZNXGe+ZAkqyj
	 QWoZ3JnwaaFVR0/JNeG0ZkZubWSAzC2QJUoFOHv8=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68CD4B24000036A3; Fri, 19 Sep 2025 20:23:02 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6774046291924
X-SMAIL-UIID: 1808608B694D4BA88487F3520188493C-20250919-202302-1
From: Hillf Danton <hdanton@sina.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: syzbot <syzbot+3815dce0acab6c55984e@syzkaller.appspotmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	dhowells@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	pc@manguebit.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] INFO: task hung in vfs_utimes (3)
Date: Fri, 19 Sep 2025 20:22:52 +0800
Message-ID: <20250919122253.7178-1-hdanton@sina.com>
In-Reply-To: <20250919064800.GA20476@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 19 Sep 2025 08:48:00 +0200 Oleg Nesterov wrote:
> Dominique,
> 
> according to
> 
> 	https://lore.kernel.org/all/20250919021852.7157-1-hdanton@sina.com/
> 	https://lore.kernel.org/all/68ccc372.050a0220.28a605.0016.GAE@google.com/
> 
> this is yet another issue seems to be fixed by
> 
> 	[PATCH] 9p/trans_fd: p9_fd_request: kick rx thread if EPOLLIN
> 	https://lore.kernel.org/all/20250819161013.GB11345@redhat.com/
> 
> are you going to apply it?
> 
> Hillf, thanks a lot!
> 
Happy to test your fix.

Hillf Danton

> Oleg.

