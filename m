Return-Path: <linux-fsdevel+bounces-22195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9229137BD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 07:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7307428381C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 05:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFF21DFFC;
	Sun, 23 Jun 2024 05:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqBSuFyc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250522F25;
	Sun, 23 Jun 2024 05:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719119505; cv=none; b=dPeZn2D0o6q5dbvpc0kz9s8mPrs+Y3ftR9oPYAu45XHxh3yx4ZgKxVOkSQlbKvxBTzy13UydRul24YTn8SoJcdjMBbkB1v6jaSYNeYCB4HLFegnZEdT0eI77pDP4qO5sRVQlgRapkp1ojsZ+jDYmkQwzsSXxMqZoKXPQn5W7KUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719119505; c=relaxed/simple;
	bh=htzNw0pnD+0+ZzwqDl2SNZT5W3tG1WxHotBQxd/SC38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ev6bveIKutP/iaGeNeB6y1f6Dt2NUA4yYzCNk8CE9toE4IS9AepjFgICQrSHy0qg9LOPKMCCUHk0t06Wz62/vBZe/68tkMTGVKG8MLsxohp0msHIb8UjiOD4OwHbqeacyab697G5K7yWtThzoTx/janhF+0e3aNGZtJFJCxsQzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqBSuFyc; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70661cd46d2so1120236b3a.3;
        Sat, 22 Jun 2024 22:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719119503; x=1719724303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vc2uIuxIAmkXAH9AFjEIYXjEf1K6XLpy6z58Kbt81MA=;
        b=VqBSuFyc4iQ2HsaYgHfZgZgSkZbVMPLp7Hzwibft8OHMbnO64AJbV0Sd4nV8x+kVih
         nBsm7N5JSb1TOxk9Eo37kkw4EY13Wy/4p1yRK24gxvAZjxUoeUpjlH+/X5WmAsXsrvKr
         CpUXQGS2pCqB0bFA4BWwzf3/N0YTHMNzYhiOIOk4rjH6e/VL+8ip2p2lX9U44dO7aVxd
         rWw+ota7hRvzpGSZHHz4ZkwPKbJ3QsJIsZq38U9XOLVSBacs9gF2JkvFR4LCQlLQJFRt
         3Nn/NgsPNoFwlBBwzCkVq6mG1KHsktqrarIiYDIhKcehekMFdW2V3Axx4ueU+8AbtLYW
         coSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719119503; x=1719724303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vc2uIuxIAmkXAH9AFjEIYXjEf1K6XLpy6z58Kbt81MA=;
        b=WhsZvqu7ld3EN3rSxVWzQDfYOmPHtLG8+6V8ZsANzALavwwQHIT0/vgVE2KYOecdJi
         OuFwWHSznwUMQlkAv4kGwG3UVypf340sww1HQOKzJi5/DjmkMu1F7Px+rGjUiwFXd3Nh
         uuRYlfeskY/9KGKYvGsUN/TRFRU5wo3TTbz5e4VdN+4PGxxb9cFXqZeLBPEPSvXcycBx
         PEGjvsrNT23udW5L+/OfcqtkdJWdZxW1EAFcuGLgWiQaK/k1Ov8t9pcsKmobi35PNO+2
         N39iwjGU4tTLv87BD2ST/3LjPzispCq4nB+20uT/zHvo7Kwhj3n0gMU902lhfbmazElV
         z0ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg1CPj/MmDGHzCnElg5/nytkKk664nyu0HW+ZyrsoIok+uouXwwNeR05/eZJwH4ChK9AwBZpIUlxC/KOzJAKWzV4n/IJXRLCtW32reKLjIHLkUD193mOrBBadDmBBzZY1VVP9fL/bHdLTnrQ==
X-Gm-Message-State: AOJu0YzLV82D9mseVGgMOBUG72fyU7M9Uj6DrDHsJ68zJ1vkArtzBr/o
	7UPrTdWti77VAllLenG5be1HeU7VwwBtWWQXGDonHvOAjyMTnwUi
X-Google-Smtp-Source: AGHT+IH/KifNye/PQIvBXCvWHPt3lOvzTNplvrfMh6nZIJSG8hf+uPS503IBBJF6ZwT5BP1wQYh0ig==
X-Received: by 2002:a62:b61a:0:b0:705:f139:d808 with SMTP id d2e1a72fcca58-70670bb6a5dmr1809761b3a.0.1719119503322;
        Sat, 22 Jun 2024 22:11:43 -0700 (PDT)
Received: from carrot.. (i114-180-52-104.s42.a014.ap.plala.or.jp. [114.180.52.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706512d3034sm4042844b3a.170.2024.06.22.22.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 22:11:42 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs <linux-nilfs@vger.kernel.org>,
	syzbot <syzbot+d79afb004be235636ee8@syzkaller.appspotmail.com>,
	syzkaller-bugs@googlegroups.com,
	LKML <linux-kernel@vger.kernel.org>,
	hdanton@sina.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	willy@infradead.org
Subject: [PATCH 0/3] nilfs2: fix potential issues related to reserved inodes
Date: Sun, 23 Jun 2024 14:11:32 +0900
Message-Id: <20240623051135.4180-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000fe2d22061af9206f@google.com>
References: <000000000000fe2d22061af9206f@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew, please apply this bug fix series.

This series fixes one use-after-free issue reported by syzbot, caused
by nilfs2's internal inode being exposed in the namespace on a
corrupted filesystem, and a couple of flaws that cause problems if the
starting number of non-reserved inodes written in the on-disk super
block is intentionally (or corruptly) changed from its default value.

Thanks,
Ryusuke Konishi


Ryusuke Konishi (3):
  nilfs2: fix inode number range checks
  nilfs2: add missing check for inode numbers on directory entries
  nilfs2: fix incorrect inode allocation from reserved inodes

 fs/nilfs2/alloc.c     | 19 +++++++++++++++----
 fs/nilfs2/alloc.h     |  4 ++--
 fs/nilfs2/dat.c       |  2 +-
 fs/nilfs2/dir.c       |  6 ++++++
 fs/nilfs2/ifile.c     |  7 ++-----
 fs/nilfs2/nilfs.h     | 10 ++++++++--
 fs/nilfs2/the_nilfs.c |  6 ++++++
 fs/nilfs2/the_nilfs.h |  2 +-
 8 files changed, 41 insertions(+), 15 deletions(-)

-- 
2.34.1


