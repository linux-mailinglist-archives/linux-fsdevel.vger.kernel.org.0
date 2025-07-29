Return-Path: <linux-fsdevel+bounces-56222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE28CB1470A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 06:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F51C3B9D24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 04:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B29B226D17;
	Tue, 29 Jul 2025 04:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Yy9m5/aJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D92B225409;
	Tue, 29 Jul 2025 04:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753762165; cv=none; b=duYGHqXHeRck+vA0BvQIgZsAiu6vHLJ+iBfdLw9IOrNLaK/UaTTMaK0uUhOPm/oi7RzPMEYD3EDLmduclAN8Rc9ACtJ9pg+bCaJ2JgGTJ+2E7N3kOwTVVUi9AVSO3eXezxniGotThOr+CO64Vmte1S8Mb0yKwxN29sWM4d3XOZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753762165; c=relaxed/simple;
	bh=MQcuIRRSI+fhUD5roPsQOCWYo2wjitel6FaYSvPvvhc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=J26ZjhSGR75W4mtYOxam6m2lSkX1KIiIuX2sNO85j6owlAki687KmCBFs0feAsB02wUpyM53/pKCSi97Z+siF97LWNZt7vWR+BlxeEzHXEyoeABdlIXDptSg1878IV+yaC9qZOwFX4HxYg4em9TtZhhcYY1s4pyxY76k7yEhM7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Yy9m5/aJ; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1753761856; bh=MN9qYG9A3Q1uisz+RpMCGISS9SNPTgLcZHxwlFMi77s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yy9m5/aJNsAp4Mr/Mv+Vqag4vRJ59ArDnBhi/ChnSi7T7LHwLYe8NIaj+A6g+bA2+
	 6S9CFya84k5nfmkGg1+wChDEXhCAzE8GA5FDGb8hBLvbTdve1M/cwtYh5h74rgo3ii
	 2PlpUgmgZH1f+I0V8nNMdOojAsoE5+BkPhxPPCjg=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.231.14])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id E741D8F7; Tue, 29 Jul 2025 11:57:52 +0800
X-QQ-mid: xmsmtpt1753761472t5cslwxsa
Message-ID: <tencent_524B841B402545BA78BB4733689E021BA908@qq.com>
X-QQ-XMAILINFO: NTsk71aSumYvklPohUFvjIQbhvUCrlTo0i46gm/1huLtPI0sTLgb0MdlO3oThu
	 zusFyyHQmmF1SLfJ7rn7A/VDa81hiswl/VgHetN9MXvjpxFbW2tsQH8y+2nMM6J7swhwjT5ejNZa
	 ExDSCdh5dhjBS+7XtSI7pIGJhBGYLTynvdgPIzQpdvrfgqpD/KPibqkI9CPz2+DgFq3dpvvNKjgW
	 gM+HYFviO9oQN/uPSfbzWuWs12HXqgPaBrjhK4l4NlbJhNBbeVabzrfagm98zisshlG1CSSoorfR
	 Wg5t+z3Um4lRQtr1WcnJ8GTqSuSXBJZJCclNe9+HuMz6m1nRZOzD/znoLQ5MO5x6wgl56oCvsFzT
	 Ezkecw2KANuCBqD4mxYMhsfXsaCR3o8ePWT38/UB3zVLuzRti8MwNCReb7f/TTqM7CpD7GylCnKl
	 G/TI2d36UWXX5yBS1pF6lsQUFhP5mC1hGXXs0HNhLwOhyK7U2SwqniIU6oiCWSzu1Qiemy/2yhpw
	 i2vGuerx5ImrsZTiYm0BISrKA8euAHIf3kxMnTfsdSdWMPIbkBv0g+4Xma7nanyJ1RojCwz19Zkj
	 997gr9EB8sI+9KrflGvqr9s6LpABP/nyUlEyqV2bM4VWOWATldKka0iumWo2w66zCgg4b2YIhdKB
	 npeoAKArkp/FY5/PW5Gz6jrKQZbtni5J+h12iCylAChV2JU+orGuwx3KDI/HyLlbeRCbK0VCmfMJ
	 sSWTvCoblm2oc6Iw/tAbNOL3o3LrA4pSrrkhZYimHp/fa5xiRSYo88rqXl2yHXdSlLQTCb71W30x
	 AM7xxYg50as3DOYuQAxgYjzkynGKF6jR4WKz/6w3c1+qXsO+x9HNU+wU3l0UfdL4ZQVLW++YJxbC
	 B/i1qgHhePHjLn/jHxVnY3Z5kzJ3ZwKLDnXE6VzZlRgjrv5yr2pCQiSi0GaPUWFZxm1lZBCtrq1T
	 TIS9ziG4ABfFxtUZPBue1lwRTXUCdR
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: hirofumi@mail.parknet.co.jp
Cc: eadavis@qq.com,
	linkinjeon@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sj1557.seo@samsung.com,
	syzbot+d3c29ed63db6ddf8406e@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fat: Prevent the race of read/write the FAT16 and FAT32 entry
Date: Tue, 29 Jul 2025 11:57:53 +0800
X-OQ-MSGID: <20250729035752.2495729-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <874iuwxsew.fsf@mail.parknet.co.jp>
References: <874iuwxsew.fsf@mail.parknet.co.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 29 Jul 2025 00:10:31 +0900, OGAWA Hirofumi wrote:
>> The writer and reader access FAT32 entry without any lock, so the data
>> obtained by the reader is incomplete.
>>
>> Add spin lock to solve the race condition that occurs when accessing
>> FAT32 entry.
>>
>> FAT16 entry has the same issue and is handled together.
>
>What is the real issue? Counting free entries doesn't care whether EOF
>(0xffffff) or allocate (0x000068), so it should be same result on both
>case.
>
>We may want to use READ_ONCE/WRITE_ONCE though, I can't see the reason
>to add spin_lock.
Because ent32_p and ent12_p are in the same union [1], their addresses
are the same, and they both have the "read/write race condition" problem,
so I used the same method as [2] to add a spinlock to solve it.

[1]
345 struct fat_entry {
  1         int entry;
  2         union {
  3                 u8 *ent12_p[2];
  4                 __le16 *ent16_p;
  5                 __le32 *ent32_p;
  6         } u;
  7         int nr_bhs;
  8         struct buffer_head *bhs[2];
  9         struct inode *fat_inode;
 10 };

[2] 98283bb49c6c ("fat: Fix the race of read/write the FAT12 entry")

BR,
Edward


