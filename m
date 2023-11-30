Return-Path: <linux-fsdevel+bounces-4466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8F17FF9CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 19:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E321C2048F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3305A0E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUzIEV9X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836BCE6
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 09:23:42 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54b89582efeso1391180a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 09:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701365021; x=1701969821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zAiTLeok3pWR7bJEa2gXBR7B6+4Qbh/sFxK+I+6xlP0=;
        b=MUzIEV9X3PfMFI71eus457OsqVuKvArPnjc8j11FxneZ59lcuerf+W+cOei9E+rNGp
         w1OJMa1GgxgTuMk0m/QyRB5L/PYQZ1HeQE37bSyY0qlVjcXqqcgFfR5PC8G1DfcdgyfH
         ntj0JPZ601hzim4rKuCh4ofo/lUJqMDOXnddWTZoLsUglNnUT280pduwYNuayu/H33V4
         /BEV5+vvhLmATcoR/0QvaeWEhHQu22n5/xwc2Xn6DcJK9tJAwp7LnM5mZ22DDCincxE7
         ss83lCq/G6C1SwYdL/4STfnkXrpzbnjwms/IBbj5xomGfpZUOMl6RTOnDZFO40bljzm0
         eDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701365021; x=1701969821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zAiTLeok3pWR7bJEa2gXBR7B6+4Qbh/sFxK+I+6xlP0=;
        b=AmgIC2K49UoO8nLs96ULqdCuaEdwXKUWDZSqtVR5Fj0EcHvvhK/XN7rWA7Dp12UEyr
         1ZaL3jFFtNIW6BGy6urCZL1bm6xuvbbVGWSdCaOIL0J6hFo60Um1KP0cvlF2ZghsMcIh
         ydPzt/kj7DFeQkZ+bcucLB/TbNPUgkOJSXDu8Z9T3k8cDBOLouVQL/Ey35C7kwraLC/t
         wdeAEqrxd7EOYVY2QjasTiBILwnvy4ysNMljLNL4aBhaNFps0iq/rjQzbjFzWUHAZYJz
         0EVyOEZ2mmv4rdemcubIbG3AAJKbJ4l9z/6otEd/PIMTKF68Yr2vAGtF+21hoRGDWvU0
         wtkQ==
X-Gm-Message-State: AOJu0Ywp/2vbS+G0w4+wEUIc66BNP9+i0ReRgahHh71N2ZW+X1GfQTX5
	o0RuCZMF0bOjvqCXfg91Y85ILXUM3LE=
X-Google-Smtp-Source: AGHT+IF56aiFpFX6Bl+VusbEZKcstBuYimd2tF5+7ZC/M2RiXjXYCEZaqNX74o9RMKQwXiiQjaWV4g==
X-Received: by 2002:a19:9153:0:b0:507:a04c:76e8 with SMTP id y19-20020a199153000000b00507a04c76e8mr18802lfj.46.1701363385003;
        Thu, 30 Nov 2023 08:56:25 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c511200b004064e3b94afsm6204241wms.4.2023.11.30.08.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 08:56:24 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/2] Support fanotify FAN_REPORT_FID on all filesystems
Date: Thu, 30 Nov 2023 18:56:17 +0200
Message-Id: <20231130165619.3386452-1-amir73il@gmail.com>
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
The LTP tests excersize the new code by running tests that did not run
before on ntfs-3g fuse filesystem and skipping the test cases with mount
and sb marks.

I've also tested fsnotifywait --recursive on fuse and on btrfs subvol.
It works as expected - if tree travesal crosses filesystem or subvol
boundary, setting the subdir mark fails with -EXDEV.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20231107-vfs-fsid-5037e344d215@brauner/
[2] https://github.com/amir73il/ltp/commits/fanotify_fsid
[3] https://github.com/amir73il/man-pages/commits/fanotify_fsid

Changes since v1:
- Add missing fsnotify_put_mark()
- Improve readablity of fanotify_test_fsid()
- Rename fanotify_check_mark_fsid() => fanotify_set_mark_fsid()
- Remove fanotify_mark_fsid() wrapper

Amir Goldstein (2):
  fanotify: store fsid in mark instead of in connector
  fanotify: allow "weak" fsid when watching a single filesystem

 fs/notify/fanotify/fanotify.c      |  34 ++------
 fs/notify/fanotify/fanotify.h      |  16 ++++
 fs/notify/fanotify/fanotify_user.c | 124 ++++++++++++++++++++++++-----
 fs/notify/mark.c                   |  52 ++----------
 include/linux/fsnotify_backend.h   |  14 ++--
 5 files changed, 140 insertions(+), 100 deletions(-)

-- 
2.34.1


