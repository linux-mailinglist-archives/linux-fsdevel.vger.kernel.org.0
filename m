Return-Path: <linux-fsdevel+bounces-68448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 736B5C5C716
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 11:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7106535A2E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 10:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1378E30AAC2;
	Fri, 14 Nov 2025 10:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="lRNPsC+8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail3-164.sinamail.sina.com.cn (mail3-164.sinamail.sina.com.cn [202.108.3.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E652FB095
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 10:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763114480; cv=none; b=royvsOXGhrvoxhNX/RMNi1xjvH3nkF53PA3hebrPqMLOiCITCJXw8xXYBPCzUmoz0PVqU5BoW5lWGqbwRGy2EUBcJ9Ffzz6nWlgPcKpLLxijayAOlA59L95NXHsoiTa+yVush7xQHgpoC28kzDLMrSqeYHF9jJUCkQ4HyyM1s74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763114480; c=relaxed/simple;
	bh=O/9CNivIpNTIOSRrxgzeErucux+xenOPFAqg5h1XSH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tu1Ibq2cDN4oMKMD8ywfXrHdefGWipvrqEUIWCGMDv1JoMlct84gpSz8/R5V5ei6vPaf0hyIgWK7rnHH7DDg7wUIC5Ww4idz6W+rPvTnPrlIeS2Yf2THLDgAs4hEhImigZImEx2CROAFB83hkuGl3a4037yzs84oY5r23JyLNIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=lRNPsC+8; arc=none smtp.client-ip=202.108.3.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1763114476;
	bh=EbJ6JYS3tT26cFPjSQHnaaR47knUQ8ZV5EwhAV3uuco=;
	h=From:Subject:Date:Message-ID;
	b=lRNPsC+8vh8QHZf+dDfV8oHbOseJXRzStrfrgveMtWVKLhy/JDTke4dMX5VjeCJYg
	 Aypw8/gbIC96joHsgGQwuIyJYFYETNEDrNuJBDaeSGYf92dLLzs7yWLm89r1GPUC0m
	 BQH+oT63W20jN4QY1LcW+0Hbz/3qFDOlg7tFfpdA=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.57.85])
	by sina.com (10.54.253.32) with ESMTP
	id 6916FDBC00000A3A; Fri, 14 Nov 2025 18:00:30 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9639224456650
X-SMAIL-UIID: 80B3F8E0F02C4A7FAD795D92F12DE6E2-20251114-180030-1
From: Hillf Danton <hdanton@sina.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com
Subject: Re: [PATCH 0/8] ns: fixes for namespace iteration and active reference counting
Date: Fri, 14 Nov 2025 18:00:18 +0800
Message-ID: <20251114100019.9259-1-hdanton@sina.com>
In-Reply-To: <20251110-elastisch-endeffekt-747abc5a614a@brauner>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 10 Nov 2025 09:41:56 +0100 Christian Brauner wrote:
> On Mon, Nov 10, 2025 at 06:55:26AM +0800, Hillf Danton wrote:
> > FYI namespace-6.19.fixes failed to survive the syzbot test [1].
> > 
> > [1] Subject: Re: [syzbot] [lsm?] WARNING in put_cred_rcu
> > https://lore.kernel.org/lkml/690eedba.a70a0220.22f260.0075.GAE@google.com/
> 
> This used a stale branch that existed for testing:
> 
> Tested on:
> 
> commit:         00f5a3b5 DO NOT MERGE - This is purely for testing a b..
>
FYI namespace-6.19 failed to survive syzbot test [2].

[2] Subject: Re: [syzbot] [kernel?] general protection fault in put_pid_ns
https://lore.kernel.org/lkml/691658dd.a70a0220.3124cb.0033.GAE@google.com/

