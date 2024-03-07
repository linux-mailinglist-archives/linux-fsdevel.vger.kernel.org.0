Return-Path: <linux-fsdevel+bounces-13839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA868747A8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 06:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B921B22488
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 05:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D3B1BC40;
	Thu,  7 Mar 2024 05:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P91vmZfn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3031A7484;
	Thu,  7 Mar 2024 05:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709789814; cv=none; b=AtsTU0cx+9ZVbVm5b+3OjtqOGrkTPwurboIPODy8xWicJtjC9mrv92dw42+Vjfl622kgCdTbFBGLg3AhZXptoaOZ9PwLIfxGG3LYFJtQE68ZpMCtzS76BFej2Rf7U+iQ0KTDQJUfLfkXHbW3Fl7scK6GapX6Howhsj9AimR8c0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709789814; c=relaxed/simple;
	bh=TD8msV2zeyBaMuMv7cfRWPrwWrXio8E6N0eM4m/ZpZU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Aus/ix8Cll7iBFBKZXgC6sl2hqPdzP0I0UZLhWRNjl1aGkS5ZZ4SOo4BxISNsK4MDTbq+UmsmDbV96O7iSTSpdzk49zoaLAU7fbap1PG8/Sa492HoR4X6UvTfH3XFJ6/5TzUyA0l4eEROWnnFmNk8fd8zpAkV/Wh3BFo8S6YbVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P91vmZfn; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d3fb16f1a9so16603261fa.0;
        Wed, 06 Mar 2024 21:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709789811; x=1710394611; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GIrvpzBTukWFdsGEEJPsX9FRjzXiM/mO16C/Fo07irw=;
        b=P91vmZfnVlziU8oDsakrAELZ2lJ1dyBkHB4zqO6rcjjpcd/2FJs2Ve34d/vIXn2YPC
         mnCrO6PCYxGS+K2x7K9pBzRcNZiLtg3kuOUy0+JOZcJRGapLr1yYJ4tjCssD30dZIT3v
         Th/HpFChSo05gJA1GunLpuLA3XUX0dXlNuxqqL1uegpYDfuq7hD5jgMd/mYb2HeYGvdi
         LyzElMRdJIg563102cwhg/lYQ2SDn1faVNDIHXTrGJlgIJ94XkaAOyhRioYgWdfn74F/
         JBVwFMcF0TDGDrvvn9LntMxtkC/A+Cw0zsBdeYmR07l58lQ58gMAEZiHl29wQIZ+p+Ny
         yahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709789811; x=1710394611;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GIrvpzBTukWFdsGEEJPsX9FRjzXiM/mO16C/Fo07irw=;
        b=drkyq53tUK7gDPFTovyMnCJYZGd2VjtT55xLgSGdESse0jYMFUZInQ5KiUMcURV6Dl
         ZJekH4cdD++GWFc0W0Pa00eCdx/tf2VrjL7Jyg5jGZnswpB+M9KdrknF8e1Cbo8eItH8
         USE/PXiP6L5iM1jh1A0Z3kXjhR6lzDuQxHnVlmxWKe1oNAUrOYxWYQLvXjeV87BBOGiF
         TmmdhO5bgivpzJOFWKHYHnbCFNQLVkp+YfG6zd6/ahBaOrtzTGYIX3c965zytAnP+ats
         P3aMpNyo0s77THlRUR9sVnOf0fJDsgQipdUbKyps8AYixiVOzLO8mJj2eawerbvaE93c
         lEeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUslLt8gKgehIhny9D6uyrRXdZRPnvnNnryrnw7qOZNsRxDOF4nwPsZne3WHHMO83oCA6raSkx0J2JlLUbiSOX6BWy00MMFI7j+N16sg==
X-Gm-Message-State: AOJu0YyrPzxn55N9dxSHIdH6PpMCXgjaO+dQMQcquKu1IiGqp8Zwj7KA
	jb2KcAipya+KDgz0zV+2wAPUhqcbNXb6nl9L5pWO5C5dnWStdii/mD9Tb2gJZPDavyldeNk6R8F
	D6WiuRHNDNDIYyEGWAXT1J/iyU4OsnahyO0I=
X-Google-Smtp-Source: AGHT+IGERnrC50EnykrFQjVM4vn6b1mtVwkcZVLvrVDE4u7GblPYyzsRtKs2PMhLIzAy2o7G0qix8B/sTze0/8spuKo=
X-Received: by 2002:a2e:9915:0:b0:2d3:3999:bba9 with SMTP id
 v21-20020a2e9915000000b002d33999bba9mr117741lji.21.1709789810782; Wed, 06 Mar
 2024 21:36:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Wed, 6 Mar 2024 23:36:39 -0600
Message-ID: <CAH2r5mutAn2G3eC7yRByF5YeCMokzo=Br0AdVRrre0AqRRmTEQ@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] statx attributes
To: lsf-pc <lsf-pc@lists.linux-foundation.org>
Cc: CIFS <linux-cifs@vger.kernel.org>, 
	samba-technical <samba-technical@lists.samba.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Following up on a discussion a few years ago about missing STATX
attributes, I noticed a case recently where some tools on other OS
have an option to skip offline files (e.g. the Windows equivalent of
grep, "findstr", and some Mac tools also seem to do this).

This reminded me that there are a few additional STATX attribute flags
that could be helpful beyond the 8 that are currently defined (e.g.
STATX_ATTR_COMPRESSED, STATX_ATTR_ENCRYPTED, STATX_ATTR_NO_DUMP,
STATX_ATTR_VERITY) and that it be worthwhile revisiting which
additional STATX attribute flags would be most useful.

"offline" could be helpful for fuse and cifs.ko and probably multiple
fs to be able to report, but there are likely other examples that
could help various filesystems.
-- 
Thanks,

Steve

