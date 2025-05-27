Return-Path: <linux-fsdevel+bounces-49919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFA2AC51D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 17:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCA4B1BA237C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 15:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A7C27A476;
	Tue, 27 May 2025 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b="CmjWgyAH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C52527A450
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748358954; cv=none; b=ZYsTbgAlQCLcxjRjeZImmEqeOYb4MOoZRRKv8KGdaSLpfhUpNDOXVp1S9njLihMuhqszSEY8yoxseH7/29KFBGsn+M01A0/ilvwcXHxZz301a+TNU+4h9dT2r0YhlXS3OrsWBznyzPcpyDsGj8v2VzSXZ+lxNdRo49u+D7RwupM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748358954; c=relaxed/simple;
	bh=vGDj5pABXAeCFpkMFGgn4hs7g7EIfL7sGyp3CAf/2Qk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Agfuj3Pg0sRVPsvRSN0qQ5VeZcI+M/+yVtv/ZlWrR4BIjeSSiNEjD6kHXzwQuZCubMjzaKyYwb0dr80iePP2cIZDjWsCsiGOrypzmihKl+HrhnfFohFv3eGHZ+D8bMsmIEmi2I2CDzW4NifYeMs8hA7xw5IbytnmcE2ZypoFVRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b=CmjWgyAH; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-22e033a3a07so32604205ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 08:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20230601.gappssmtp.com; s=20230601; t=1748358952; x=1748963752; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rIugmyoGw3zvHwV1fRPYYpiTTTl+jifl2H0lpvLCKbU=;
        b=CmjWgyAHB8x7LGcJ9IwTZxYLd4F+5/sdXPy4y3djrYyQubwBqMvUplgHGrSLdw3eLa
         /tDYOvGv0n20vwMdhFZ04MDBo0Yf9m5qWy83Y4KlabaBSKErakWHvoKbTrlhCTjCBn5/
         2hhtEMQ3VfexYwcVlWPkcAs+IxwqsKzljvuhzrxryQgwimB30vJnwCWSq7zngVLfryDN
         pi5WAYGoA1wNezefAsqNs3AL4Pwk7MvZmTH/uSTPKuLrVx+5VU56CederIjrLyI1X408
         6XJTEodrv4HLv8a09VrpzOmBEthUCwcb/WU+4A0nozaM18sR5WNMRu+ioj5dDQ78v6Nx
         KKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748358952; x=1748963752;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rIugmyoGw3zvHwV1fRPYYpiTTTl+jifl2H0lpvLCKbU=;
        b=CRIsqzO5IhENGjbgHxcuBe9U41Jo0Qg7zazL0ymbbI+glRaruRZ8rwfL0UzRseNk9O
         nUEe+ad3ltj2XhZcEtIZzbnCjyEpEAuyl5sie0xzRzuM5/jG6Q4JJwcpiyWI2eDwlTtN
         uFxeKf8abcvnA2nFKnGe3PbsgG01LuVJJmmE2nmWXuQiJPw1PZ7vt5C9XsaP/tpQracg
         cf/TUrMk/7Vjz26ZL+K25QvVWiBk1SGZncBltq5ZHEyPwsvPS4stFSmxBhAMDy3QbyVL
         vB3mW4GkZOACN3pSQjvBKNNO4rz7EH+V0nAbuturaOXVtxz2fxSGG55gAbxosDJCQPpB
         MuRw==
X-Forwarded-Encrypted: i=1; AJvYcCVoKPPrPFfkXpzp37IW5sK5mswoyvFrpheYFlC25juDE4lygTwtNx+QqRZNHo25oPSU6RBBDR5k92071Qnd@vger.kernel.org
X-Gm-Message-State: AOJu0YyhK9tz72C8maUKepJkfAOaqcXcvZw4a7OA6rdqBP1H2HUnIGmd
	xHbphDWXIDMsFAzf5e2jMO18uNqy8MPox/IKlNV9QhtPq1kexmaqp9lxlSinlbDDBdL2e/S47Nd
	nQhm6WSQl7qOvXaKMcpv6RjnvCKGNm1lF4DKbm+yj+xJ2lqyOuFwa5AotGfg=
X-Gm-Gg: ASbGnct5L2Wh0RyRjKW05wcSptBzfP1k1jJvh1cHj7PRv4gmS26Bo9wSWySqrXqEG26
	ASSRGwGvC31LWDX0xwcFboO3l9+t3STxZLsaTzTHj2FyWePUyVYWmBgalgOkGtKmW282eREuq+L
	DiMYv4eVduaVIhb5RSdSV04hR20VaLzrYE+5p74FwP4jtL
X-Google-Smtp-Source: AGHT+IE/X3GdhsEW/x7VRoddhEu8kUlhQGXmgugA0xMq/n9VpZpJUYQtM6x+NWDLoXpt/qb758ukryChuZ2FRnQ+o38=
X-Received: by 2002:a17:90b:1997:b0:311:a54d:8492 with SMTP id
 98e67ed59e1d1-311a54d8584mr4071283a91.6.1748358951358; Tue, 27 May 2025
 08:15:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mike Marshall <hubcap@omnibond.com>
Date: Tue, 27 May 2025 11:15:40 -0400
X-Gm-Features: AX0GCFunyy3IXy04Uz8jd2XWSCwp-t6PJ3qY1jPqdzz8bIRRsa1gruXZqiylZjQ
Message-ID: <CAOg9mSSpgg2sKS18K3qZym+sKDY+xvwHP0S-V6T6GNgUUWJBbQ@mail.gmail.com>
Subject: [GIT PULL] orangefs pull request for 6.16
To: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, devel@lists.orangefs.org, 
	Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"

  Linux 6.15-rc6 (2025-05-11 14:54:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
tags/for-linus-6.16-ofs1

for you to fetch changes up to 4dc784e92d4fcf22ae785ee5a7918458f11b06c0:

  orangefs: Convert to use the new mount API (2025-05-14 18:04:45 -0400)

----------------------------------------------------------------
orangefs: Convert to use the new mount API

Code from Eric Sandeen at redhat that converts orangefs over to the new
mount API.

----------------------------------------------------------------
Eric Sandeen (1):
      orangefs: Convert to use the new mount API

 fs/orangefs/orangefs-kernel.h |   8 +-
 fs/orangefs/orangefs-mod.c    |   3 +-
 fs/orangefs/super.c           | 189 +++++++++++++++++++++---------------------
 3 files changed, 102 insertions(+), 98 deletions(-)

