Return-Path: <linux-fsdevel+bounces-4468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD277FF9CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 19:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FF8D1C2048F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B965917D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeZt2ivh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F6E131
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 09:34:38 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9e1021dbd28so175281866b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 09:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701365677; x=1701970477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zAiTLeok3pWR7bJEa2gXBR7B6+4Qbh/sFxK+I+6xlP0=;
        b=OeZt2ivhJmnWM/+TAoAp0MrF0jNEmTFRlxiBAsampF2/jcFo3UIkkPw8axRNvba+VG
         qAF9TiB12tqQATOE+dvp96+5lSZoopgaUUpA/0MaLIytD+PgMqiuU7tSFxaU8ANcmQgF
         c1F0XWRmOvPJZRVcZhsu0Bcnmli0HeYGPnr+HwcqqaK3+KM7es0UyUhvgs6m1hGcDBNd
         YSLKus0RmdMFpoRGsronz/m55DP3v85sI8ZTlBDwq4TRJ4SHXEljsPFz6lB2soAQ3k7N
         vmhGSwLyLexk1Fro1/upU4riF8ZbEwE47YKHk26yWdHSQNlobsWzEtSLup9ThS4HAHvB
         OVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701365677; x=1701970477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zAiTLeok3pWR7bJEa2gXBR7B6+4Qbh/sFxK+I+6xlP0=;
        b=gtVi0dLEkxzZ0JqKsd4uGiins/xarlXdxPznIeaL4f91ulhgcSZkLGLGnQH04ZTwp7
         ZBeZTvbmBiifV4CQa77qfUgM9YyN73fs7XLb68XOzgJgKa3VtCLGOk9uo32m9L8XZpEM
         amzDRmtoD4vaYSI7/CkojkbwFER0EBdwgJfJYHnYYENJmYLXck/ouEOxUhHtssbC45/e
         t8XeUOkJdfQ4VnY5J6g1EUKARqUVRq7cCgzFKyUBKTPlRbjRP7Tm6ypKOnXFG7fKRxIm
         dMc/3eWaSEoaMdPhA9bQgI2GZ7qEEdfBW3dDEfCSlLMVmDfi2Nm3NX5VSQO7nmUZEH7/
         g69w==
X-Gm-Message-State: AOJu0Yz3W1nwKzH+pZ5W8mQJ7tcte3S0n0S/eK615fjAHbPiLahNkiFc
	CMhypVyPuMG9m5KZdAa9p8t5UOhr8Ls=
X-Google-Smtp-Source: AGHT+IHXOMmGcOnCiagsqIi+UXKO6NqkBKGB86qgP9SPvNuxeEdEcklT5tgnv0s2eCcejt2KlOmXCA==
X-Received: by 2002:a05:600c:444d:b0:40b:5464:b241 with SMTP id v13-20020a05600c444d00b0040b5464b241mr24421wmn.4.1701364632211;
        Thu, 30 Nov 2023 09:17:12 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id s15-20020a05600c384f00b0040b35195e54sm2631833wmr.5.2023.11.30.09.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:17:11 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH REPOST v2 0/2] Support fanotify FAN_REPORT_FID on all filesystems
Date: Thu, 30 Nov 2023 19:17:05 +0200
Message-Id: <20231130171707.3387792-1-amir73il@gmail.com>
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


