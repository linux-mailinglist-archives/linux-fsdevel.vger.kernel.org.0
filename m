Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A688D18BA9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 16:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgCSPKf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 11:10:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45205 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgCSPKf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:10:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id i9so3428852wrx.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2020 08:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=62pvwm/NTSOsd9i4sIHjNJzm54Ca860VuTVr59mMemI=;
        b=vNdlKnfYp7kTlZtaBpoBcXuxy6p+wMmtFQ2tsLsPru8VIeLem4/5RUD7tvgqQgIiEK
         xdkx9+AbZ/d5pyDepUtHfMFue8bE7xYdSWgYaxFhvPAoRBZO3Qqa1DCPX3UfoXwoWrFK
         e8eT1zVIVTOnSQ7XCtEoHIsksVolroUDTHbGmCl1hHP3rJN/SFZ56n77q2sYdbtSBeSY
         oCK5f7I5RvQNaK1AN+eZRrakgN8mooe148qdJaHdFAiSDHAUol5ZhIniD2cjpxZN/vR5
         L7a9a3asdM9CMksZgJZBZzt6tHwIEYf7VprOp8A9S5FvALNWJUESILi4EKwNibfWVqeV
         gz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=62pvwm/NTSOsd9i4sIHjNJzm54Ca860VuTVr59mMemI=;
        b=CTlwLsgI/G5SP8EHEzyCA33AkqGIC1YT57CND33aplGewFjeP3IpZX91F1AQ44FPbU
         hPkc1daaigmZn3p915jwy7Is3qdHv0rKaMJ1I3G4h4jgAgGIw38bwoJu5Z+9C4h1cX6x
         TMqZpgMo1FJ7Wyx1AYKctXQI82ZsjLW5Ty+C7bIufih1brokzI0nJdG6T+KiU9SLxTyn
         8TL99s9bAi4p5to15k9ZW8eiyGBemo290XkrknXRgr04QPHkh0GR3RqAHl3T89Vqje1D
         2aRe5XN8imDIT1yupnuBQbkNo/cK35aYtXKX04GZp6u1ajf/QVzHDBv8N8j+mWgNO6Ju
         4SYg==
X-Gm-Message-State: ANhLgQ3TCYqsqIgCc/DghEga2PfAjlftY3vE9O/jKCIrRDW3XyY62l+/
        UdPOQxKkzbZTujc0s/4ghq3wKZAP
X-Google-Smtp-Source: ADFU+vtiZif/5I0eRfGr/vTVBaWbdwcbXhBjWSuhobwDujaim4puVRBCOHuwxrWk/89JZ5H7jIJ0eQ==
X-Received: by 2002:adf:b31d:: with SMTP id j29mr3143086wrd.218.1584630633798;
        Thu, 19 Mar 2020 08:10:33 -0700 (PDT)
Received: from localhost.localdomain ([141.226.9.174])
        by smtp.gmail.com with ESMTPSA id t193sm3716959wmt.14.2020.03.19.08.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 08:10:31 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 00/14] fanotify directory modify event
Date:   Thu, 19 Mar 2020 17:10:08 +0200
Message-Id: <20200319151022.31456-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan,

This v3 posting is a trimmed down version of v2 name info patches [1].
It includes the prep/fix patches and the patches to add support for
the new FAN_DIR_MODIFY event, but leaves out the FAN_REPORT_NAME
patches. I will re-post those as a later time.

The v3 patches are available on my github branch fanotify_dir_modify [2].
Same branch names for LTP tests [3], man page draft [6] and a demo [7].
The fanotify_name branches in those github trees include the additional
FAN_REPORT_NAME related changes.

Main changes since v2:
- Split fanotify_path_event fanotify_fid_event and fanotify_name_event
- Drop the FAN_REPORT_NAME patches

[1] https://lore.kernel.org/linux-fsdevel/20200217131455.31107-1-amir73il@gmail.com/
[2] https://github.com/amir73il/linux/commits/fanotify_dir_modify
[3] https://github.com/amir73il/ltp/commits/fanotify_dir_modify
[4] https://github.com/amir73il/man-pages/commits/fanotify_dir_modify
[5] https://github.com/amir73il/inotify-tools/commits/fanotify_dir_modify

Amir Goldstein (14):
  fsnotify: tidy up FS_ and FAN_ constants
  fsnotify: factor helpers fsnotify_dentry() and fsnotify_file()
  fsnotify: funnel all dirent events through fsnotify_name()
  fsnotify: use helpers to access data by data_type
  fsnotify: simplify arguments passing to fsnotify_parent()
  fsnotify: pass dentry instead of inode for events possible on child
  fsnotify: replace inode pointer with an object id
  fanotify: merge duplicate events on parent and child
  fanotify: fix merging marks masks with FAN_ONDIR
  fanotify: divorce fanotify_path_event and fanotify_fid_event
  fanotify: send FAN_DIR_MODIFY event flavor with dir inode and name
  fanotify: prepare to report both parent and child fid's
  fanotify: record name info for FAN_DIR_MODIFY event
  fanotify: report name info for FAN_DIR_MODIFY event

 fs/notify/fanotify/fanotify.c        | 304 ++++++++++++++++++++-------
 fs/notify/fanotify/fanotify.h        | 172 +++++++++------
 fs/notify/fanotify/fanotify_user.c   | 171 ++++++++++-----
 fs/notify/fsnotify.c                 |  22 +-
 fs/notify/inotify/inotify_fsnotify.c |  12 +-
 fs/notify/inotify/inotify_user.c     |   2 +-
 include/linux/fanotify.h             |   3 +-
 include/linux/fsnotify.h             | 138 +++++-------
 include/linux/fsnotify_backend.h     |  87 ++++++--
 include/uapi/linux/fanotify.h        |   6 +-
 kernel/audit_fsnotify.c              |  13 +-
 kernel/audit_watch.c                 |  16 +-
 12 files changed, 610 insertions(+), 336 deletions(-)

-- 
2.17.1

