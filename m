Return-Path: <linux-fsdevel+bounces-14642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB0487DF42
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 19:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76A7D1F20585
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 18:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BDA1DA4E;
	Sun, 17 Mar 2024 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyF+xnQd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F88208AF
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710700925; cv=none; b=B3PigEOjYJUX0JaKIUbDmhyDki1MPqJpFicrFOdPJtZmBZgHlpL+Isp8hN4gTLX3uhzHPJjVg7eH+wyATSE7w7SNcFGbMoM2qPi8rtYv0kS5OYJconPAoB26x6x6HUuo1MhjiHz9n1hlxpMLV0XdxRjqroXxQA9u4u3YSMTRlHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710700925; c=relaxed/simple;
	bh=/gPhAtT+wf2gWtTbaFYXw20gSkNqPksYxmKnpybCLSM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ww93kOefyZ8iAAd4+m8eUWR0Y2NLNtQD4h4ZGcxjog2bjSFU/6yog0yBxYsaddMnUkjfO1v7F0q+wwq+D0tf0dpvPfMfRRe/nkUr5w75cVd08D5Aj++R6boybVF1drsdEFvh5/zaghurX93lx9jykJuiVhBM3SUSgfFvpevDArg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyF+xnQd; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41409fd8b6bso6790365e9.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 11:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710700921; x=1711305721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FEEjbH4DM3VKYRnVYIrBePiosQy4XKXpWv4jz0rQtSM=;
        b=lyF+xnQdme3WcVJSTgefVnoAz19E0lm65vec1fZx49GWN6Ar4l7glHNLhEMRsmqY6x
         7/0HpgroEWSaaGaT8SEqyzERBDj29J/uT9u42Bx56ifiMGbfIDldnX0LurpIxNkaYmGN
         tSZAdoEOdnLzr26LXEHSbgwpC7cU9tMCuFbXuG4H6Li3WLShKeO21UwGYkEEOl8DaHyk
         4HNOS0jUNCguIDwII/o2SdTTsxb+bzKzyzbiuJ6tOOQDFo7fFGUFXlhHCI1ATIQoBUd+
         iYAa6Ly71ktDPw0fw0EtvcgjP4W7ru88HHGQLPBfk9CXGxVvHw9KrHkrH/hviF7iyUAZ
         dbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710700921; x=1711305721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FEEjbH4DM3VKYRnVYIrBePiosQy4XKXpWv4jz0rQtSM=;
        b=lL1Lbjrg//rvuHo2bKyfLaZcQ9DIeS3Hfzyb+uWn41wgZs0NWjkQnJw0I0B2jxLJvF
         XoWdOn0F8Ms7FY6dUNH2Ua5HvR6MqWcfTB0BO7Y0qpZ2vsiwWuCmEgjhmSSY/dN2O0FN
         GmEzi892zc4mII12W28tM9md98l1KGbp95XCJx2MreAD0C+mddhcvclK/Xvx/oAiFlzx
         G4tdcss9rjVIW4+jPOGUQpG+CRKnl0i2mEFPtiKWuG+k09KbGDtAUIgtnNh5Bi7WhqjJ
         /lSGF+9CcLSC17sX2H2kiUw+XXR6jBmQk/KBDnxwl0lY+5u9Fl+OWozpYJqnxvZ36OBB
         ZVig==
X-Forwarded-Encrypted: i=1; AJvYcCU9CFwdytD9NlQjIdWQv3QxqYWbGVgeyjTN8xyECgO57yQEfqJCHXYZUYiwAHdzl40q262VEybPCS0GMNsEg4qy2pFWGFD/fN2WzW00fg==
X-Gm-Message-State: AOJu0Yw0bz7iVz3ybAcuZd68VIId8umByHaQWRtucHiUbuFDhLMzIFtm
	uDJtReiUb0Z+HOrSY2RPkUWO0Mc6DPP6WgEEpFoLbs0efF02qyMb
X-Google-Smtp-Source: AGHT+IGFMHjducl0D/h3Kb45WSA839Y1iWQm8nMXLBLs55C0hm5Rn2VBG4m9DkAuXhP64dSnxcQcXA==
X-Received: by 2002:a05:600c:1d0e:b0:413:3941:d9ae with SMTP id l14-20020a05600c1d0e00b004133941d9aemr6791328wms.31.1710700921451;
        Sun, 17 Mar 2024 11:42:01 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan (85-250-214-4.bb.netvision.net.il. [85.250.214.4])
        by smtp.gmail.com with ESMTPSA id bk28-20020a0560001d9c00b0033e22a7b3f8sm3070716wrb.75.2024.03.17.11.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 11:42:01 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH 00/10] Further reduce overhead of fsnotify permission hooks
Date: Sun, 17 Mar 2024 20:41:44 +0200
Message-Id: <20240317184154.1200192-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jan,

Commit 082fd1ea1f98 ("fsnotify: optimize the case of no parent watcher")
has reduced the CPU overhead of fsnotify hooks, but we can further
reduce the overhead of permission event hooks, by avoiding the call to
fsnotify() and fsnotify_parent() altogether when there are no permission
event watchers on the sb.

The main motivation for this work was to avoid the overhead that was
reported by kernel test robot on the patch that adds the upcoming
per-content event hooks (i.e. FS_PRE_ACCESS/FS_PRE_MODIFY).

Kernel test robot has confirmed that with this series, the addition of
pre-conent fsnotify hooks does not result in any regression [1].
Kernet test robot has also reported performance improvements in some
workloads compared to upstream on an earlier version of this series, but
still waiting for the final results.

For now, as you requested, I am posting this series for review.

Thanks,
Amir.

[1] https://lore.kernel.org/all/Zc7KmlQ1cYVrPMQ+@xsang-OptiPlex-9020/
[2] https://lore.kernel.org/all/202403141505.807a722b-oliver.sang@intel.com/

Amir Goldstein (10):
  fsnotify: rename fsnotify_{get,put}_sb_connectors()
  fsnotify: create helpers to get sb and connp from object
  fsnotify: create a wrapper fsnotify_find_inode_mark()
  fanotify: merge two checks regarding add of ignore mark
  fsnotify: pass object pointer and type to fsnotify mark helpers
  fsnotify: create helper fsnotify_update_sb_watchers()
  fsnotify: lazy attach fsnotify_sb_info state to sb
  fsnotify: move s_fsnotify_connectors into fsnotify_sb_info
  fsnotify: use an enum for group priority constants
  fsnotify: optimize the case of no permission event watchers

 fs/nfsd/filecache.c                |   4 +-
 fs/notify/dnotify/dnotify.c        |   4 +-
 fs/notify/fanotify/fanotify_user.c | 141 +++++++----------------
 fs/notify/fsnotify.c               |  23 +++-
 fs/notify/fsnotify.h               |  38 +++++--
 fs/notify/inotify/inotify_user.c   |   2 +-
 fs/notify/mark.c                   | 173 ++++++++++++++++++++++-------
 include/linux/fs.h                 |  14 +--
 include/linux/fsnotify.h           |  21 +++-
 include/linux/fsnotify_backend.h   |  93 +++++++++++-----
 kernel/audit_tree.c                |   2 +-
 kernel/audit_watch.c               |   2 +-
 12 files changed, 314 insertions(+), 203 deletions(-)

-- 
2.34.1


