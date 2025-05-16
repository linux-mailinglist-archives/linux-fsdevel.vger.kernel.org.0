Return-Path: <linux-fsdevel+bounces-49298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5CAABA3C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 21:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E031B3BDA74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 19:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662532690C8;
	Fri, 16 May 2025 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLsZvENs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB661CEAC2
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747423701; cv=none; b=cmiI5pQvRh3txsNuz8rbrrElNqToGiDn0ixTghtlQTGHNu2P+Wq3GIOKUAfgjLcTW8kGcqWCzuWGhva3FgjMADVLyK9CF7XuF3+fy1ZqHAI8/kjUN85+Ah3HGeeSrT7PqGFOmLC9boSatY3VOh8hfDn2BksSaSYVsn742DCAud4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747423701; c=relaxed/simple;
	bh=LPa3Tt4NjkW+4ZfcyDlaTebJ6coCRDVXLLUb9iHBDKw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=klSzDvdQ5tGwA2KcX9YIENWJ8ViSUMp3hP7qI5Q98Y8zWd4M4cGGhteA/8gDhMJp9sacZ9lpr5VDN4P9a3YevPZ72OiZ7FosMQkWqFXVBu2adZJuLZHCnQ8atqUu6P40Emx7fhGRuqSj1q2THB6UAgjqW7OuF7sCRXaoi4usEIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLsZvENs; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad1d1f57a01so408271066b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 12:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747423698; x=1748028498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fk9bCh7V4IRZwyThRfexETrVYkJeA61wSjkUevtKAV4=;
        b=eLsZvENsBvHyDOi5ToCdTAksrqSy7idj5CHTPA/sx9afBE9zcyT1ihPcmaUyH0QaAS
         RHAZ+3Zy/Z49ULbUlKIQRGLaZvZa08bfa75QMf8VlWsXkad8Y1/DG7m0Uz++Ii1Doof/
         XjsqyHRyZJ7F5NbxZ3z+rJWO4wsua0Ki36T/Sax65NE1VM6+qb3qo5HXz3fitOiieC1c
         jiL0AQEpr3i1EF5Eem0H2LY7Tc7Y9IEXCI0OuUTd/x9t1wbmU6FhAPkNYFxOtKMAgaY6
         5VpQyC+N3ueFSdRWd4FuJeptjpK6eVJnK5Tb84E7XbmRi/RP2XS95gowsL+YGikr6gfB
         KY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747423698; x=1748028498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fk9bCh7V4IRZwyThRfexETrVYkJeA61wSjkUevtKAV4=;
        b=qSMq/g9Euoh1WvF1O/TO7IuCnPGJagATt8nQG82bl80IY6mkRHXrwcH1GvEmlsf//j
         yKTzpQPtCBqQGtBFxJHxQ1jG1F6Q49P+WTE4QFWdnYQMBcpiM0mgIWl1uv0iWPbvAKrZ
         eDdhcKxKwR26xljiSrzB1+3aQEw12CongowrjcRLSCPyCQW6q7tHocmb1vpsxhwK6lrN
         5jZZkHksA8XCZap45kAZpoX+1ASd8/nh4LAUE1GjTK0aqtE98XianCUzn7l5UgoKSALb
         YT12mLwHhfpHouGLDATi+q2loMmNUrOPXb31eJI4mSMqJfm0xGHDVdoOTQBVWPXoZ9+6
         gCvA==
X-Forwarded-Encrypted: i=1; AJvYcCXKZL/PT2qO2cd22RvyfaeJYGOsec4Zku+8R95KuLI5a8Ux/x5fDIU4aWLML+xPVJwjsFKHR3oDYeAWTMsk@vger.kernel.org
X-Gm-Message-State: AOJu0YyJhrQYG4dx3LRc8E7qMZD9bziGBtpmcEz52gRuxZ87nVAzNH9O
	14QYGxt2iypJOYmhUO5//z2+xFmr/sjxvUKW9K1tzcbI8ax5Tml6fyhq7U0mHXaJNC4=
X-Gm-Gg: ASbGncu1BWkoBo5CC+0jgR2mUl/HYUX5ThGkgds/B6dK0HuOsJSXoHp5xGx7O+Lq8k0
	+rL2grZKnZHC2M7g82ksbfh6+I7GZ8xLOpxbC61rdDrsviAM5CZGBXuFxbWm8vaYs1h08kEgXIM
	yyFgZcp2SFpTGNSNkQdtPk9DZsaAD/hTB6PdckJl5ECRCczBQR+QSvnYLXt4Hg1Sdj3szuAqz8F
	mU9l9mWafPURDiLjeoylc+uyOtnlrwcZH6e2fOUbgaPN47K+FLvLxYNECf6b4yNMrz9R6NTeF29
	2pokNmeItv2YECqZr806O256EdgG9uNaX+NiAJhlITTYk941Z/9+FxJhAh+Q+FhVxyQoUjAYLXQ
	kCuCN5Rfpzso/vP2jeftwdbmBO3r7ql/6lnWXWIhe5Wzz70Ns
X-Google-Smtp-Source: AGHT+IHbipcWChW0/wjAKth5ZrRjHOwioHEWLQYJcgRV7kPzpkr+83KeFslVz/s1CciGwsqFAqdabg==
X-Received: by 2002:a17:907:72c3:b0:ad4:e114:581a with SMTP id a640c23a62f3a-ad52d5395b9mr446393866b.35.1747423687103;
        Fri, 16 May 2025 12:28:07 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d4466e2sm201075066b.93.2025.05.16.12.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 12:28:06 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 0/2] User namespace aware fanotify
Date: Fri, 16 May 2025 21:28:01 +0200
Message-Id: <20250516192803.838659-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jan,

Considering that the review discussion on v2 [1] did not yet converge
and considering that the merge window is very close, I realized
there is a way that we can simplify the controversial part.

There are two main use cases to allow setting marks inside user ns:

1. Christian added support for open_by_handle_at(2) to admin inside
   userns, which makes watching FS_USERNS_MOUNT sb more useful.
2. The mount events added by Miklos would be very useful also inside
   userns.

The rule for watching mntns inside user ns is pretty obvious and so
is the rule for watching an sb inside user ns.

The complexity discussed in review of v2 revolved around the more
complicated rules for watching fs events on a specific mount inside
users ns.

My realization is that watching fs events on a mount inside user ns
is a less intersting use case and it is much easier to apply the same
obvious rules as for watching an sb inside user ns and discuss
relaxing them later if there is any interesting use case for that.

mntns watch inside user ns was tested with the mount-notify_test_ns
selftest [2]. sb/mount watches inside user ns were tested manually
with fsnotifywatch -S and -M with some changes to inotify-tools [3].

Thanks,
Amir.

Changes since v2:
- selftest merged to Christian's tree
- Change mount mark to require capable sb user ns
- Remove incorrect reference to FS_USERNS_MOUNT in comments (Miklos)
- Avoid unneeded type casting to mntns (Miklos)

Changes since v1:
- Split cleanup patch (Jan)
- Logic simplified a bit
- Add support for mntns marks inside userns

[1] https://lore.kernel.org/linux-fsdevel/20250419100657.2654744-1-amir73il@gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/20250509133240.529330-1-amir73il@gmail.com/
[3] https://github.com/amir73il/inotify-tools/commits/fanotify_userns/

Amir Goldstein (2):
  fanotify: remove redundant permission checks
  fanotify: support watching filesystems and mounts inside userns

 fs/notify/fanotify/fanotify.c      |  1 +
 fs/notify/fanotify/fanotify_user.c | 50 +++++++++++++++++-------------
 include/linux/fanotify.h           |  5 ++-
 include/linux/fsnotify_backend.h   |  1 +
 4 files changed, 33 insertions(+), 24 deletions(-)

-- 
2.34.1


