Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACFB1C352B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 11:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgEDJAn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 05:00:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33542 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725941AbgEDJAn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 05:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588582841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Dv4N73donIrMojY0Rc7JndJhv/1XRwPtGMOgVBPbQJo=;
        b=SPxLs0u0kdD7to5wYUWRWkxYvSogEC82AsBBY0/5bJ84oSgiw6fn27sL443sOdV9JlcHFC
        x5+ye75IVOBA1tu7u8eiXPah3wJpoYV/1WFXR6sUuKD+uVm1a/wwp+Hz7mjhGYOP5Ssavi
        SvP5Gaema7KIlmhkcdErKTkg+6P+Vqo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-HgWl6a_vNw6TteokuaPNCg-1; Mon, 04 May 2020 05:00:39 -0400
X-MC-Unique: HgWl6a_vNw6TteokuaPNCg-1
Received: by mail-wm1-f69.google.com with SMTP id h184so4531408wmf.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2020 02:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dv4N73donIrMojY0Rc7JndJhv/1XRwPtGMOgVBPbQJo=;
        b=seNpEx+xyexsm3J/0izarA15sHBpghr4n9I8OlIOBcBXLfaVA2tqPdPz9ioDbsob2y
         fgXdN2lAICyrdSe2nvU4hZWLxfvIhSRTGGA/Dy/DfUF8vLmb6zSyyPWOMP6kzIJdE12I
         /12YQjGYJQkQjOWn4gu4V2OnLuucyZuCtZ5FTh74ohwiEA2qPBxHyET/zOlUgJxonTHs
         ezSehvU/fRvwRRMWvtP2sQNN3szEdEddn6umV+vDADkQRBwmxNOlclAo4rBqY0hTLKSN
         y8NUKNFOs1v0AoJwa3WxuWK9y/Rbu1qW1VjdmMkWCNhZbKnAbj8C5skaBokVooOHmxVE
         omHQ==
X-Gm-Message-State: AGi0Pua0mQy6n/YRTB1vRUxAUFD6HL087157jUh92DQ1RI/1EnPVCOxY
        g9JGuSpLHlqtFIzgnPMOv7dPgi4LewXhPLHn1xpCfWpeLlMIhKP93BCldyDRiecG541e8JtWSGd
        CoNXV1qZ4I2XuS4nLzoJawTOVKw==
X-Received: by 2002:adf:f684:: with SMTP id v4mr16358978wrp.218.1588582838429;
        Mon, 04 May 2020 02:00:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypI1UNPOL4NAo/5HKO3jwraX1b9VX8Szr5OEp68kOxu1OAJC8ogtVkMAPv4TPc/BYTexafrK/Q==
X-Received: by 2002:adf:f684:: with SMTP id v4mr16358957wrp.218.1588582838218;
        Mon, 04 May 2020 02:00:38 -0700 (PDT)
Received: from localhost.localdomain.com ([194.230.155.213])
        by smtp.gmail.com with ESMTPSA id u127sm12984720wme.8.2020.05.04.02.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 02:00:37 -0700 (PDT)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [PATCH v3 0/7] libfs: group and simplify linux fs code
Date:   Mon,  4 May 2020 11:00:25 +0200
Message-Id: <20200504090032.10367-1-eesposit@redhat.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

libfs.c has many functions that are useful to implement dentry and inode
operations, but not many at the filesystem level.  As a result, code to
create files and inodes has a lot of duplication, to the point that
tracefs has copied several hundred lines from debugfs.

The main two libfs.c functions for filesystems are simple_pin_fs and
simple_release_fs, which hide a somewhat complicated locking sequence
that is needed to serialize vfs_kern_mount and mntget.  In this series,
my aim is to add functions that create dentries and inodes of various
kinds (either anonymous inodes, or directory/file/symlink).  These
functions take the code that was duplicated across debugfs and tracefs
and move it to libfs.c.

In order to limit the number of arguments to the new functions, the
series first creates a data type that is passed to both
simple_pin_fs/simple_release_fs and the new creation functions.  The new
struct, introduced in patch 2, simply groups the "mount" and "count"
arguments to simple_pin_fs and simple_release_fs.

Patches 1-4 are preparations to introduce the new simple_fs struct and
new functions that are useful in the remainder of the series.  Patch 5
introduces the dentry and inode creation functions.  Patch 6-7 can then
adopt them in debugfs and tracefs.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>

v1->v2: rename simple_new_inode in new_inode_current_time,
more detailed explanations, put all common code in fs/libfs.c

v2->v3: remove unused debugfs_get_inode and tracefs_get_inode
functions

Emanuele Giuseppe Esposito (7):
  apparmor: just use vfs_kern_mount to make .null
  libfs: wrap simple_pin_fs/simple_release_fs arguments in a struct
  libfs: introduce new_inode_current_time
  libfs: add alloc_anon_inode wrapper
  libfs: add file creation functions
  debugfs: switch to simplefs inode creation API
  tracefs: switch to simplefs inode creation API

 drivers/gpu/drm/drm_drv.c       |  11 +-
 drivers/misc/cxl/api.c          |  13 +-
 drivers/scsi/cxlflash/ocxl_hw.c |  14 +-
 fs/binfmt_misc.c                |   9 +-
 fs/configfs/mount.c             |  10 +-
 fs/debugfs/inode.c              | 169 +++---------------
 fs/libfs.c                      | 299 ++++++++++++++++++++++++++++++--
 fs/tracefs/inode.c              | 106 ++---------
 include/linux/fs.h              |  31 +++-
 security/apparmor/apparmorfs.c  |  38 ++--
 security/inode.c                |  11 +-
 11 files changed, 399 insertions(+), 312 deletions(-)

-- 
2.25.2

