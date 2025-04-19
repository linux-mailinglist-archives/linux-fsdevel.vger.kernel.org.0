Return-Path: <linux-fsdevel+bounces-46712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90781A942BC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Apr 2025 12:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B520C8A50C5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Apr 2025 10:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BB71C1F13;
	Sat, 19 Apr 2025 10:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QelRCDeV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28A32AE96
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Apr 2025 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745057227; cv=none; b=gMxXW8uqkxo/b7/Pnq5TYKBkOsfcrEUAGh9XCyAoRhpgg+hSkJa3myfjBmBxEG3/v935k5hslv7gXYv4XmwLB1MLmsXNQJ4rJbm8eQcF89rmqIN9ceB1G4WmDXj3fTsLBcWQqOXHv2BaokwT75SU837YZgss4JexYvhQN3NR5l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745057227; c=relaxed/simple;
	bh=GIOCTbxD+paTSS+/hoL+ivlens1bOyAbf28JiC+XfV4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XjT4xdpx6Ivc3dEyTpTf4HYyS2Q/vtrZk8b7jeNynVd2XlsJbR6x5cM4UtDvEJYLIjw1kRQQztXA1OhWhl54RIKYpO0goV+/sLFGJ4Hvi3iRStlpsCPVkmbljnanbOfsXNOBejufKV7xpd4JHNRpn7TpwKpuP1xTR6LUDnUrwuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QelRCDeV; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-acb2faa9f55so315532566b.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Apr 2025 03:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745057224; x=1745662024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mSE2AfTy8GQbcJ/486rHLA7o5dtfJ7s/hDNX1wD1EkI=;
        b=QelRCDeVUF1nz4vy24bUQuLGqOYmiDqVLiVTxnibO3L6aQ+/WiKYGmwatACBfuPyTm
         dQfPuWhMbQnDMKmE/VQtLXO5tj1BYqVY3HHGV5u1U4qOs3y7eSh+Oeyp2CaBxUtlqrDK
         RDCCuND4xa8D9qKpwqxoBOVCaRkDomgSQmJBpNGq+ipwe1v8BuZ6ygTqtcf/W0RpqUaZ
         kd2zfuWA5OvKkaPryBfA+0cp3DhiFrDKDs14BcN5+Cl9RlHS9TZ5AXPj7Ap7nquJTXJO
         rk82RewWoYQOqbhZdlRsG7htNm4HCRi37IYu9eCjsnfokSOTrfjWHBj1u3YRfd87alyw
         rLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745057224; x=1745662024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mSE2AfTy8GQbcJ/486rHLA7o5dtfJ7s/hDNX1wD1EkI=;
        b=KL74n6/LdlZbIohOhVlQrrsJbVK5YhmpDFS869GJGiejvWiQUMuCmc8+oWE6MWxuTf
         OZaTFsBsHASELilwZeZrSCGmIhYB2hMG3yIzYRHICQu1juZf27Y9AZUwBPcdYYYe+/om
         baZGbo6DRPMTZnCwzv1oj2PMqni1w4XULvi/ubnfH31x3jtz60u9CAb7gbXEC0/Tw1w5
         DKrHPDGNPZojAZAoJP680JWJk+j+vbC7RnwtOFs1I+VYWT29UjuLmklWVcG8JyKl9kQQ
         +w1JytxY7atR7McdXNhxBpgA9Uz7LNpy+1YATA7arLCSfQD0vx45X12yEx+lLKilo2xZ
         rr/g==
X-Forwarded-Encrypted: i=1; AJvYcCWHK9KG1JKrK2Wb2OA5867a8+vLJAECiZxkILQ1ihl0j8BkjD06ShuAxSWoAhFnG7A4ZMKPDAN0aUsgv3W9@vger.kernel.org
X-Gm-Message-State: AOJu0YwBM37SyjPOINvPYx9P4RO01kpVdqKescXgPIlIY2NFrixum5MA
	cmb0BPKhE76aaPC4w+jlmvpLhwu8YwZEHT5kIt/6t9Fu6LwV+19T
X-Gm-Gg: ASbGncsfFbStG7efR1n7CIiJ5WYfAucx16fzltS6m5jT0O/qE0neuHTWW1yogi95R9Q
	/W6gandzHfZW7swTsxV3KBFtmzLIUzilIQWo0AuOKyfpLiVi3B/FVavBstgt7cZJhVKGhokr6iS
	q5A2zNxqvoa35TAElg5X3YdNAtrNZMKBQ7H8AucT0QGAtnOmXVHbcYsxm0LY8trtAAZbgc6ZT+/
	6fXE2RpUoPF0p7lAWoj3UKSsAiyVAvg/fwWuV2JHTukhqLTYpq1Nzbpxh4wjWGjOuOhlUyZryaj
	mbvn4vvx93QMyLKsj8vRSDcoUwmPFitsAwcyT/tYk+ir65HXmWQL2rEJe/dbF7dwis8miG416if
	lgi4rfVEusWd7Vg68nXxRvGiUEfzICc+PKZ49g08AR+ZWkEIy
X-Google-Smtp-Source: AGHT+IExQ5r+h54y9iao2yMpNYDpKGvHmDuUdEzIdxqh7j6cqER1TSYydbOGpscCdzIh4pHpfoZqKQ==
X-Received: by 2002:a17:906:d54e:b0:ac7:31a4:d4e9 with SMTP id a640c23a62f3a-acb74ac5189mr552831766b.4.1745057223718;
        Sat, 19 Apr 2025 03:07:03 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec507c9sm245894866b.69.2025.04.19.03.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 03:07:03 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/2] User namespace aware fanotify
Date: Sat, 19 Apr 2025 12:06:55 +0200
Message-Id: <20250419100657.2654744-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jan,

This v2 is following a two years leap from the RFC path [1].
the code is based on the mntns fix patches I posted and is available
on my github [2].

Since then, Christian added support for open_by_handle_at(2)
to admin inside userns, which makes watching FS_USERNS_MOUNT
sb more useful.

And this should also be useful for Miklos' mntns mount tree watch
inside userns.

Tested sb/mount watches inside userns manually with fsnotifywatch -S
and -M with some changes to inotify-tools [3].

Ran mount-notify test manually inside userns and saw that it works
after this change.

I was going to write a variant of mount-notify selftest that clones
also a userns, but did not get to it.

Christian, Miklos,

If you guys have interest and time in this work, it would be nice if
you can help with this test variant or give me some pointers.

I can work on the test and address review comments when I get back from
vacation around rc5 time, but wanted to get this out soon for review.

Thanks,
Amir.

changes since v1:
- Split cleanup patch (Jan)
- Logic simplified a bit
- Add support for mntns marks inside userns

[1] https://lore.kernel.org/linux-fsdevel/20230416060722.1912831-1-amir73il@gmail.com/
[2] https://github.com/amir73il/linux/commits/fanotify_userns/
[3] https://github.com/amir73il/inotify-tools/commits/fanotify_userns/

Amir Goldstein (2):
  fanotify: remove redundant permission checks
  fanotify: support watching filesystems and mounts inside userns

 fs/notify/fanotify/fanotify.c      |  1 +
 fs/notify/fanotify/fanotify_user.c | 47 ++++++++++++++++++------------
 include/linux/fanotify.h           |  5 ++--
 include/linux/fsnotify_backend.h   |  1 +
 4 files changed, 32 insertions(+), 22 deletions(-)

-- 
2.34.1


