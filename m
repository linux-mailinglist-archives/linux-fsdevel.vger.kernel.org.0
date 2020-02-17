Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB96161300
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 14:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbgBQNPd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 08:15:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55373 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbgBQNPJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:15:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so17094354wmj.5;
        Mon, 17 Feb 2020 05:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=67kTUyBE7oGcc+gBY0DKM3Gkm5L+z0sRvog8FHnMFxc=;
        b=mLXxGqqskF5hafzHi3/1bYY7OGzhxnLqHzZUzgMjC3mbDdSzb3IItjW2yn9b2/PdB6
         0UVv1ksZNTbERfFlP81BsDel/AhJqEExILXOcY3yyPhmVVX+8yOVq1BmFqewOMfCYc/t
         aNa/lAk6Mbv0OLu2gI19of7grMXNOTaJtMWGuqng51IOrGC6bRPSEIjE1DezEZ4qiXpH
         f5W9uK0+2EGvNPJ9hwT2l27ObmnAmeNc8ghd/loZ7PIsXulKli6TtL6lOnplIAWvCfa8
         LRTaWLE4jkfQmW/X0nddUiujU56kk2tuXXesXtTBO4Ro0SWQwJR7vpHSy/25SWAiPAP0
         tcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=67kTUyBE7oGcc+gBY0DKM3Gkm5L+z0sRvog8FHnMFxc=;
        b=P6m0Z4Zlxtdixcp5r8oahAxNaRKf4yKoBPGyxFVlQJdkJD+aySn6Y4QRClcvtpvlVl
         3xUG8OrbcUiSmatMpwwV/veoYvAXB44T6mUh2GjjNhuJudKXfKpBNbq/0TdBxb9vE/8y
         iiQEvG2GTfOvkfAsev3PN4wVveenngWvFUkquccSQThACuFCvXAOXs7f6Zc3jkV7nttU
         7NHdT/L/rTb1hWs+g5fqcErtK84oNWOqKorckVMuCn9NVnPC4RfiMNnEqqkn2vToz3i9
         uOdsmPNKBEnfcXfwZSeL4N6ptn6sJ3kcj3rCJc0In6OSez0vvSkgot0loYuMvdOPhVDI
         Pqbw==
X-Gm-Message-State: APjAAAXu+HCpW6ANWjT8pB3AjfFrlVBKGGUeMKPqFxbMPmnj51XFnU1j
        twSom/jyNsslYvKCJQBxGHLTzjlt
X-Google-Smtp-Source: APXvYqzTFrqQqHZchrtDqmg2An2AwP48A1NIaj5XjemuRVB4w7Z/rMaZxX13rf57GupbYmRQyQY0tg==
X-Received: by 2002:a1c:2747:: with SMTP id n68mr21247791wmn.14.1581945307219;
        Mon, 17 Feb 2020 05:15:07 -0800 (PST)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id m21sm545745wmi.27.2020.02.17.05.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 05:15:06 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: [PATCH v2 00/16] Fanotify event with name info
Date:   Mon, 17 Feb 2020 15:14:39 +0200
Message-Id: <20200217131455.31107-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan,

This is v2 of the fanotify name info series.
The user requirement for the name info feature, as well as early UAPI
discussions can be found in this [1] lore thread.
The "prep" part of v1 was posted to the list [2] and includes two
minor bug fixes, but I decided not to split the submission into
two series this posting.

The patches are also available on my github branch fanotify_name [3]
along with LTP tests [4], man page draft [5] and a demo [6].

Patches 1-7 are cleanup and minor re-factoring in prep for the name
info patches.

Patches 8-9 are fixes for minor bug that I found during the work.
The referred LTP branch [4] includes improvements to ltp tests fanotify09
and fanotify15 to cover these bugs.  I did not mark those patches for
stable, because backporting is not trivial and the bugs are really minor.
For the same reason, I did not bother to provide bug fix patches that are
not dependent on the cleanup patches.

Patches 10-13 implement the new event type FAN_DIR_MODIFY per your
suggestion, which includes the directory fid and entry name info.

Patches 14-15 implement the FAN_REPORT_NAME init flag for reporting
name info on path type events.

Patch 16 is a "bonus" patch that implements an unprivileged fanotify
watch.  It is not proposed for merging at this time, but is provided
in order to demonstrate how name info reporting is applicable for an
unprivileged watcher, should we decide to implement the feature.
LTP tests, man page draft for unprivileged fanotify written by Matthew
Bobrowski are available on fanotify_unpriv branches in respective trees.

The inotify demo branch [6] includes a script test_demo.sh whose
output [7] can be seen here below.  The demo generates filesystem
events including file and directory renames, sleeps 2 seconds and
then reads the events from the queue and generates a report on
changes in the filesystem.

At event report time, the watcher uses open_by_handle_at(2) to report
up-to-date paths for parent dirs.  The last name element in the path
is reported as it was recorded at event time, but the watcher uses
fstatat(2) to check whether the reported entry is negative or positive.
Negative entry paths are annotated with "(deleted)" postfix.

The idea is that file change monitors will use this information to
query the content of modified directories and file and update a
secondary data structure or take other actions.

The demo scripts can run as root and non-root user.  When run as
non-root user, if the bonus FAN_UNPRIVILEGED patch is applied, it
demonstrates the unprivileged fanotify recursive watcher and produces
the exact same report information as the privileged filesystem watcher.

Thanks,
Amir.

Changes since v1:
- A few more cleanup patches
- Drop the abstract take_name_snapshot() vfs interface change
- Do not obfuscate event type for path type events
- Deal with the corner cases of event on root and disconnected dentry
- Bonus FAN_UNPRIVILEGED patch

[1] https://lore.kernel.org/linux-fsdevel/CADKPpc2RuncyN+ZONkwBqtW7iBb5ep_3yQN7PKe7ASn8DpNvBw@mail.gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/20200114151655.29473-1-amir73il@gmail.com/
[3] https://github.com/amir73il/linux/commits/fanotify_name
[4] https://github.com/amir73il/ltp/commits/fanotify_name
[5] https://github.com/amir73il/man-pages/commits/fanotify_name
[6] https://github.com/amir73il/inotify-tools/commits/fanotify_name
[7] Demo run of inotifywatch race free monitor
==============================================
~# ./test_demo.sh /vdf
+ WD=/vdf
+ cd /vdf
+ rm -rf a
+ mkdir -p a/b/c/d/e/f/g/
+ touch a/b/c/0 a/b/c/1 a/b/c/d/e/f/g/0
+ id -u
+ [ 0 = 0 ]
+ MODE=--global
+ EVENTS=-e dir_modify  -e modify -e attrib  -e close_write
+ sleep 1
+ inotifywatch --global -e dir_modify -e modify -e attrib -e
close_write --timeout -2 /vdf
Establishing filesystem global watch...
Finished establishing watches, now collecting statistics.
Sleeping for 2 seconds...
+
+ t=Create files and dirs...
+ touch a/0 a/1 a/2 a/3
+ mkdir a/dir0 a/dir1 a/dir2
+
+ t=Rename files and dirs...
+ mv a/0 a/3
+ mv a/dir0 a/dir3
+
+ t=Delete files and dirs...
+ rm a/1
+ rmdir a/dir1
+
+ t=Modify files and dirs...
+ chmod +x a/b/c/d
+ echo
+
+ t=Move files and dirs...
+ mv a/b/c/1 a/b/c/d/e/f/g/1
+ mv a/b/c/d/e/f/g a/b/c/d/e/G
+
[fid=fd50.0.2007403;name='0'] /vdf/a/0 (deleted)
[fid=fd50.0.2007403;name='1'] /vdf/a/1 (deleted)
[fid=fd50.0.2007403;name='2'] /vdf/a/2
[fid=fd50.0.2007403;name='3'] /vdf/a/3
[fid=fd50.0.2007403;name='dir0'] /vdf/a/dir0 (deleted)
[fid=fd50.0.2007403;name='dir1'] /vdf/a/dir1 (deleted)
[fid=fd50.0.2007403;name='dir2'] /vdf/a/dir2
[fid=fd50.0.2007403;name='dir3'] /vdf/a/dir3
[fid=fd50.0.86;name='d'] /vdf/a/b/c/d
[fid=fd50.0.86;name='0'] /vdf/a/b/c/0
[fid=fd50.0.86;name='1'] /vdf/a/b/c/1 (deleted)
[fid=fd50.0.87;name='1'] /vdf/a/b/c/d/e/G/1
[fid=fd50.0.3000083;name='g'] /vdf/a/b/c/d/e/f/g (deleted)
[fid=fd50.0.2007404;name='G'] /vdf/a/b/c/d/e/G
total  modify  attrib  close_write  dir_modify  filename
3      0       1       1            2           /vdf/a/0 (deleted)
3      0       1       1            2           /vdf/a/1 (deleted)
3      0       1       1            2           /vdf/a/3
2      0       1       1            1           /vdf/a/2
2      0       0       0            2           /vdf/a/dir0 (deleted)
2      0       0       0            2           /vdf/a/dir1 (deleted)
1      0       0       0            1           /vdf/a/dir2
1      0       0       0            1           /vdf/a/dir3
1      0       1       0            0           /vdf/a/b/c/d
1      1       0       1            0           /vdf/a/b/c/0
1      0       0       0            1           /vdf/a/b/c/1 (deleted)
1      0       0       0            1           /vdf/a/b/c/d/e/G/1
1      0       0       0            1           /vdf/a/b/c/d/e/f/g (deleted)
1      0       0       0            1           /vdf/a/b/c/d/e/G
==============================================

Amir Goldstein (16):
  fsnotify: tidy up FS_ and FAN_ constants
  fsnotify: factor helpers fsnotify_dentry() and fsnotify_file()
  fsnotify: funnel all dirent events through fsnotify_name()
  fsnotify: use helpers to access data by data_type
  fsnotify: simplify arguments passing to fsnotify_parent()
  fsnotify: pass dentry instead of inode for events possible on child
  fsnotify: replace inode pointer with tag
  fanotify: merge duplicate events on parent and child
  fanotify: fix merging marks masks with FAN_ONDIR
  fanotify: send FAN_DIR_MODIFY event flavor with dir inode and name
  fanotify: prepare to encode both parent and child fid's
  fanotify: record name info for FAN_DIR_MODIFY event
  fanotify: report name info for FAN_DIR_MODIFY event
  fanotify: report parent fid + name with FAN_REPORT_NAME
  fanotify: refine rules for when name is reported
  fanotify: support limited functionality for unprivileged users

 fs/notify/fanotify/fanotify.c        | 231 +++++++++++++++++++++------
 fs/notify/fanotify/fanotify.h        | 111 ++++++++++---
 fs/notify/fanotify/fanotify_user.c   | 182 +++++++++++++++++----
 fs/notify/fsnotify.c                 |  22 +--
 fs/notify/inotify/inotify_fsnotify.c |  10 +-
 include/linux/fanotify.h             |  21 ++-
 include/linux/fsnotify.h             | 135 +++++++---------
 include/linux/fsnotify_backend.h     |  87 +++++++---
 include/uapi/linux/fanotify.h        |  11 +-
 kernel/audit_fsnotify.c              |  13 +-
 kernel/audit_watch.c                 |  16 +-
 11 files changed, 584 insertions(+), 255 deletions(-)


base-commit: 11a48a5a18c63fd7621bb050228cebf13566e4d8
-- 
2.17.1

