Return-Path: <linux-fsdevel+bounces-3120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F245E7F01F0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Nov 2023 19:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA96280EAD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Nov 2023 18:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69651BDF8;
	Sat, 18 Nov 2023 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ni9dHnXK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95DDE6
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Nov 2023 10:30:24 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40859dee28cso5680335e9.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Nov 2023 10:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700332223; x=1700937023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fVlAaYFLLFzz6IBuZHk+XxLpW//AoR5zQjtzoPmZAgY=;
        b=Ni9dHnXKcKe6ERw4LBY4fExS6Ub+DJHUW8Vs5Y2sbaVFxhM+VZnxc5HbJ3g3ZBcgEA
         16bcNv5fo5A8P65Kfm2YftoRPYpUDTaDCUSxAJRQsJXVUvIbcjuW4I6gbOWiBYEk3oTD
         yFvxn3nSVCRivCSxF7xVIBs22yQKqL6TRV29wOhsbJFGu/Rgu/kzh0mCMBn0aXXPguUK
         gsmWoSa59slF/tdJ1O1fdfMKimfR8grI/X0/EQa/sjcC3I2427aBtoTa61e8Q85dFAVu
         cc+eXdXh7ejPVUiyH7wKpWdI6A6jRgx58+rF0I2BedToyBdUVTQQb8QDyue8arSXT5UI
         gBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700332223; x=1700937023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fVlAaYFLLFzz6IBuZHk+XxLpW//AoR5zQjtzoPmZAgY=;
        b=YpS2Tdig1beUUM+M8HxWk3uxS1KgEfp9d+OChw1EUhZW2HrRbkkx8cYH9S0sx84XbL
         qZMI483hJnx4kaBO++i90RZjwT+etLqCaBsCQjrekJUjlZMFHk0wGy97VtfTCYXwW3pK
         AaAcaOITXz5eCmEylpCBnJFmR4fWLu+AWasCEs02xjHMUN0wRmzwmJZ8savcLNCmoVOf
         09YN680g0fYfA4mnLb8TsJ8j4PSBj1bOkjn7hwdSr7HcYQrNR39O1eTDQ+XQ1R5Ps4uv
         FN0OhuL4MqekeMZHXdyJt3pwgUl+RX73eJBlBh/NJwId542VOqRbqOL1TjxOWiGwVgsL
         CQeA==
X-Gm-Message-State: AOJu0Yx6TD408wYNsgIWsw8p4Bv101CSusB9NKTC5OY4Q9NfAunW7WU1
	NzyF/sT0m53AvpzDC4hRJY8=
X-Google-Smtp-Source: AGHT+IF8VG2zFHoU/460SElzOloBHr6SLcSwxRJmJ4vvK9MzjhoDbSI9YUw+E6aLax/k2h+C5ZhDEQ==
X-Received: by 2002:a05:600c:3c8e:b0:408:3918:1bc1 with SMTP id bg14-20020a05600c3c8e00b0040839181bc1mr2385420wmb.8.1700332223045;
        Sat, 18 Nov 2023 10:30:23 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id bg6-20020a05600c3c8600b004090ca6d785sm7373327wmb.2.2023.11.18.10.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 10:30:22 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] Support fanotify FAN_REPORT_FID on all filesystems
Date: Sat, 18 Nov 2023 20:30:16 +0200
Message-Id: <20231118183018.2069899-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jan,

In the vfs fanotify update for v6.7-rc1 [1], we considerably increased
the amount of filesystems that can setup inode marks with FAN_REPORT_FID:
- NFS export is no longer required for setting up inode marks
- All the simple fs gained a non-zero fsid

This leaves the following in-tree filesystems where inode marks with
FAN_REPORT_FID cannot be set:
- nfs, fuse, afs, coda (zero fsid)
- btrfs non-root subvol (fsid not a unique identifier of sb)

This patch set takes care of these remaining cases, by allowing inode
marks, as long as all inode marks in the group are contained to the same
filesystem and same fsid (i.e. subvol).

I've written some basic sanity tests [2] and a man-page update draft [3].

I've also tested fsnotifywait --recursive on fuse and on btrfs subvol.
It works as expected - if tree travesal crosses filesystem or subvol
boundary, setting the subdir mark fails with -EXDEV.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20231107-vfs-fsid-5037e344d215@brauner/
[2] https://github.com/amir73il/ltp/commits/fanotify_fsid
[3] https://github.com/amir73il/man-pages/commits/fanotify_fsid

Amir Goldstein (2):
  fanotify: store fsid in mark instead of in connector
  fanotify: allow "weak" fsid when watching a single filesystem

 fs/notify/fanotify/fanotify.c      |  34 +++------
 fs/notify/fanotify/fanotify.h      |  21 ++++++
 fs/notify/fanotify/fanotify_user.c | 111 ++++++++++++++++++++++++-----
 fs/notify/mark.c                   |  52 +++-----------
 include/linux/fsnotify_backend.h   |  14 ++--
 5 files changed, 135 insertions(+), 97 deletions(-)

-- 
2.34.1


