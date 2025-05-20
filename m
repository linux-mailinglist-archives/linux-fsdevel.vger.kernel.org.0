Return-Path: <linux-fsdevel+bounces-49532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F79FABDFA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 17:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FB5516B943
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 15:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4811B40BF5;
	Tue, 20 May 2025 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b="CqofL0eQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97474242D89
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 15:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747756389; cv=none; b=MK3zuwEyirqpgfrnYtwWHM+F96IOnSpijXjSAUYPkLVBHCGJpqGk6n2axRg8ajg7/qRtxMdkOOLletRSI2fPXewexpUA6touoVbLyUnCwGggO9GMJhsCDR5dpx/tS5wuTIVtbRMC2breNKXNA8cuW9EjstNtLxy5y/2J4qh6RC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747756389; c=relaxed/simple;
	bh=8gjQNVIy6w6vD2czbuvav3DLIklHq1vaF0DRVXISh+E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=OtXj2CheE+/FoJ4H4LHXFyvXCpndgx6s4n3IRI38CEerXwSFtfHiYmePXBpZSVH65dczlldjk+y9LbTiBrtSvdAqoPV/Rt49K0J+x7BYJkWUVPDi81+Sj+C2EX8/rvd4P6gMJe+/TNSqnx5Vj/9x7XQBneNymxUHzQyucpXWk7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b=CqofL0eQ; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso5540209b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 08:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20230601.gappssmtp.com; s=20230601; t=1747756387; x=1748361187; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bXMRndVqJ6YbEU8PV90w5eWyznhaN960cxNJaXiRdDs=;
        b=CqofL0eQCHmVKDexX2WTviIr3znRxqjMCi0fOUN/CAvRj8Ou9SPOD2fHRmsY8mKMFO
         ex0ihP0VkNdGYDAHl3g+GZCkaZYJfqVoqKu0euVHDOxp6ij8DzG6SKOzNNojkESFdnQH
         KCgvKRxvTo3YLrs9OHB+9XRS+dVqcqAaK/PuBCeMEjAgSuJWDDBK2TJg0Ob9F7DWEmvP
         UXnDWa8S3hXpOfemKKOkIEwvYvn259L493nddIWE1egGCZlkppiVd4NRoDT9N3vwMmcc
         vAJSUYiJpeJTxVa5JarLMS6VmjJv5p6+cL8cEFG0SNBqpyr9L9ItWjb8cOSTR5ZeVYJ5
         N4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747756387; x=1748361187;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bXMRndVqJ6YbEU8PV90w5eWyznhaN960cxNJaXiRdDs=;
        b=GCbf8Za0fYgktauzl8VLe9b0YRwjFyPd2SyEcoZyXlKf0DNBqucp8P7j/Jmz2aXcTo
         ddU3CeTtYMrvV6yXH+9aAm749zg6oVevv1OyYx4IMtB4+nCGW31qAtRr9PDpYYSdT+ak
         zktciBd19aEXoG79/tZLCclFmi4VlbXaCTTIXpvQdel9IHyzN9ybyNr9pHvfrmyvlONe
         TgidXbblc1+NhrHKw1uVtMHyBmVDcJ4Ej2TzHtYRa6aEk3dWXos+yXyu4BFfzH72Swj1
         CXf70Xb92ejCGrAlatWF25NZ3EmbZ2R23/f99B8oVs8ezalj9yNHm4Ydx+DKRA3deF3G
         2ZHA==
X-Forwarded-Encrypted: i=1; AJvYcCUkLL5u0VK9cSq80uPKHk+o3Hxm5Aa3iIMnfuP1qOiuDpY28/cbUpExSM5XH8tut/pbkBDLppWhnN2i3Vw3@vger.kernel.org
X-Gm-Message-State: AOJu0YzwKVZc3DJAahIano4Upf7lTvye05Nz3amSLrdV6/XCpMTtsxOy
	+7z53J0VP2k7vM7E7M96aUbJsEvMB/I9fgNoeoiRJJny6w7+oN/D1ND5qs05ceIfqlth8hZ5ABV
	5t0uljmsmKBoTBnlswrBodeJNiiAGlUd2nAYR1hnVHqlwsDU7HhpuiHlO1LU=
X-Gm-Gg: ASbGncsn4qAXO9eAmdk8Q88tf6zDauGakXJMsqgFV8bKtZjUSpP+cULKqX+PUZg9D7u
	iQ9KzHiXFl9KSaotozMlV9IvXbjNmC7S3gaLgEBjxJ0EoIPRbQOP3819gZyhsseFucfZ6AifI0P
	2p5XaCX/CWSzieC1xUrxZCqwsVCqQ0xjl1gRUTOo3oGO//
X-Google-Smtp-Source: AGHT+IG+1qHgyfrAodz7VJowm7ljcCkBVBxOFi+oVdDBo3ZtOkqeyZ+27os/hLyojHtm71Vg+3b5ozueEmkIl8I32yA=
X-Received: by 2002:a17:90b:57e8:b0:30a:255c:9d10 with SMTP id
 98e67ed59e1d1-30e830e87f6mr25156331a91.8.1747756386745; Tue, 20 May 2025
 08:53:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mike Marshall <hubcap@omnibond.com>
Date: Tue, 20 May 2025 11:52:55 -0400
X-Gm-Features: AX0GCFvx2tmSAdBOuo-XQIrT6aTb0JpKFJFgUu_Q3Mca_Liok8QoRihtbNLCCAs
Message-ID: <CAOg9mSTe1vJLaw=ftzB7LsSEVqWj-5HEznERtWUh=CuBN7yKMg@mail.gmail.com>
Subject: [GIT PULL] fix for orangefs counting code
To: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Mike Marshall <hubcap@omnibond.com>, 
	devel@lists.orangefs.org
Content-Type: text/plain; charset="UTF-8"

The following changes since commit 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3:

  Linux 6.15-rc6 (2025-05-11 14:54:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
tags/for-linus-6.15-ofs2

for you to fetch changes up to 219bf6edd7efcea9eca53c44c8dc3d1c6437f8b8:

  orangefs: adjust counting code to recover from 665575cf (2025-05-20
11:07:00 -0400)

----------------------------------------------------------------
Hello Linus.

A 6.14-rc7 commit (665575cf) broke orangefs for 6.14. I have a patch,
and it has been in linux-next for several days, but if I wait until
the merge window to ask for it to be pulled, orangefs will be broken
in 6.15 too.

I hope you can pull this patch during 6.15-rc7.

Thanks...

Mike Marshall

----------------------------------------------------------------
Mike Marshall (1):
      orangefs: adjust counting code to recover from 665575cf

 fs/orangefs/inode.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

