Return-Path: <linux-fsdevel+bounces-54264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D8FAFCDCD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 16:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55567162778
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 14:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACAD2DEA98;
	Tue,  8 Jul 2025 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfwsoFJs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB8813957E
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985409; cv=none; b=HSLFb7k6V+Ml7n0tW4iHKVOkvoYoB5Gv4i5QclAAHnKhZ3ulR8mawMAoFFA4i5YX/+Erd5GZQ1LCK3zICuLGtID9DpTmrtWAdgdsjXbKWN4bGQi3w8m7cid9S2cpux/yBSlwkr274bB61PXuXsPb8qpn2d6O70OuAExvsnSI72E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985409; c=relaxed/simple;
	bh=AkQyG3gG9KfAFGqEYJu0o/6Iq2snADOYTmejdFYnKhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YcYGp53FVNxc3X8Y3EkseWf5ZE9ySERdOQbLV1PyGVupytJej1253q8RUms59Os6D1szmSZxZhm48HsAv4lv7kcNwqBeTMy1HJIHArh7roMhy6ybUqOH9as8rNKTN0IE+b/fGXQniZs7ztNezk9KaHBLqGdIptnMJtKVxg5oh3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfwsoFJs; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60c93c23b08so8705444a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jul 2025 07:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751985407; x=1752590207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kfYa+MIvBstRB4pWjBQinCREMpT2aEAHSxncmyRtqYs=;
        b=SfwsoFJszYfEi1PkosPaH6sp2t6GNibWH4MDPSlLPMKaQ4xGmYKnPJc60JaH9y1mAE
         Ym8teOEA/5Ro3N2gSz0syxxP9u3rJiVjHPauRkOnfn86ZZKOQy3envWW+KLbX3jETgUP
         nx7xvEJ5wM3+08Pbq9X6FF7w2zAn2KLze1eS5oOaWNk6/scKJ8DDnHDd5DKAGxH41dLr
         VyleYI0FJxwqyttvGRn00/aRJ2XjNT2f+j5ejoUMDtgSUSuxnrQj+F9DFt0GQ9N5FqgJ
         dgJN+B6/a6leFnzFa6eWXGrzXEIVaHtd+6lwdLPl/LXOYLbO0LTD6ceDtxL+LrSSJNlZ
         j1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751985407; x=1752590207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kfYa+MIvBstRB4pWjBQinCREMpT2aEAHSxncmyRtqYs=;
        b=sDVfEsqym6BZPOLhp4tBEFqTwKRlFzDoKqIy5BJgG0HYkSI9Xd0mSlBXsOfljmoOwH
         eQHnOpgWNj1j/GYumVJSzlz7BDcMKYHe9twrlyih6xf8KttZQZJVFHFkwoBZxTU2vJRj
         i/AocO8eK1OHDUxHR8LD88FjEQONgcvfVsEzWZUjxg8Wc0QVT/AHlTxpTEW8564TNplu
         HEV+8CVRAcprlEi3kAuZoUorJyY3CkfJARkTg4kmEg/uhj2hWjfp8mMHHRfDIkc0HuxQ
         osls4glfOzGcTVfFJ96JZtCKLfACoqQb0L481w7t3gw9dKutiL0a2xjKdxoj6pipHbgr
         2+Ew==
X-Forwarded-Encrypted: i=1; AJvYcCW11zdvG2REatv8brj/DHJbHljuJYQQfR+Kj4Ij4uXSTyKl7Witk5G4mIRsspYau6PcYpJg479ol2Scx/3l@vger.kernel.org
X-Gm-Message-State: AOJu0YxfZlBuNshs0bj3Hpema9JpItgIAGWACfjkgHg+JTAkVgHbibw2
	AhclRege7qZuljqqTIjSG6tg0k2wmgL/9XvVGGWwTGAuomn6Q6wWpdf3
X-Gm-Gg: ASbGncvCEMJVWvLG67wQkMF9JdLagwIrQ7mAYTtRhixAtCy4Mk1HXwnM3Vw+Tpm1RPi
	Q8wPtb/AaOzvuwyWHRt23l+m4mtx8NdsW0NlN8UA1CH0eDF3RvhSeeX+vRmmZW1RY7hcyeIYojA
	3YbP7hPHb1524kXh3OXiVeUpVSwuOVseFrDINj50k+/Ienp8v6SD0oIwY8tkhOFLXClgSoAcUHv
	DY0p96abiEokBmB320S5pcY0jK/rqoIz5+U0r4XubtZ4JeZHGP+jKU1BYwUsrrYE70kDqadDPH2
	wzwU2jKCq2uY3eJ9KMmjLArteaXY69tsEIGqJqLxM3/x043ckmMGyclIMl8JkrsjfSlhs9KvK/3
	WhB1Nxh4u3gS+9aQXQ380P8PmHi9z/F24c79T+KreuemCfxSfsRRb
X-Google-Smtp-Source: AGHT+IFCYBTnW+gQjlINzUF5Tz0/iqz7/Vc87sTyhWC+MYk+OdUOzAknUPozquW4OLwHJnUdcgf96g==
X-Received: by 2002:a05:6402:13d1:b0:604:df97:7c2 with SMTP id 4fb4d7f45d1cf-60fd2fb036fmr13909297a12.2.1751985406233;
        Tue, 08 Jul 2025 07:36:46 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fca696574sm7393068a12.28.2025.07.08.07.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 07:36:45 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/2] More fsnotify hook optimizations
Date: Tue,  8 Jul 2025 16:36:39 +0200
Message-ID: <20250708143641.418603-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jan,

Following v2 addresses your review comments on v1 [1].

Changes since v1:
- Raname macro to FMODE_NOTIFY_ACCESS_PERM()
- Remove unneeded and unused event set macros

[1] https://lore.kernel.org/linux-fsdevel/20250707170704.303772-1-amir73il@gmail.com/

Amir Goldstein (2):
  fsnotify: merge file_set_fsnotify_mode_from_watchers() with open perm
    hook
  fsnotify: optimize FMODE_NONOTIFY_PERM for the common cases

 fs/file_table.c          |  2 +-
 fs/notify/fsnotify.c     | 87 ++++++++++++++++++++++++----------------
 fs/open.c                |  6 +--
 include/linux/fs.h       | 12 +++---
 include/linux/fsnotify.h | 35 +++-------------
 5 files changed, 68 insertions(+), 74 deletions(-)

-- 
2.43.0


