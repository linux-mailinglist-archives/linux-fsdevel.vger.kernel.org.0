Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C0F2DD2E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 15:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgLQOVV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 09:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbgLQOVU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 09:21:20 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA912C0617A7
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 06:20:29 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id qw4so38049875ejb.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 06:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=s2io9byrVSQg39u9kY1sFTMQIOzVrXTXCf/O9WPWFOA=;
        b=RD62ChU+OJDF7UVtIVsJlfZGn25fGNj6obtVAVtbOfS2rSy0yE6P+pQA9jFQ/hMihx
         AQFvzcRCMpzHb5H2uFgcBZkSOfB02SaM9rPWUt+ugNEML91QwzkZ440MrnUrlX1dtd6d
         mACbQBbnpf5r+rUU5+ytGiLypwDX6Mliyj+TU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=s2io9byrVSQg39u9kY1sFTMQIOzVrXTXCf/O9WPWFOA=;
        b=FDQ2GGMNFqBkQgiReI4VKZXZvq1Hn+7PF5YGltBnNUofsOoPew2UCmmizOfqPg7//j
         SAlUWrhQwaWNwgJPhj8pfXaK5Q2icNM5N3KcWj9fWzVP7lXGGcDUMztI1v+35VDSXDHx
         DiMijP8W2j6SUStWz73VduBuw6ElN+JshXwMs5q9AzQ+MsLtWIKtU5jLb8g6OcHtVe/D
         oqMbpe+ujsPZ52xDSZSFMiKgh17EM6nVlQPSk3uLdjfWF22567Z7oXOWOqV026J4v/+K
         0WBkPt82QSHnaj1y8Hk7zhYMzSmU+iOpi92NcZRbuF0qwx3lnQPlnBL+p4iMqlD8c0ZQ
         ipiA==
X-Gm-Message-State: AOAM531Uhjh1kAZ/vcx7nZdlzQDIY9uxmK6GBNRarKStJWrArhX3TjEK
        7HhoXQgaxyl5DOQqCSvz/VtKmpgCIgP48q4s
X-Google-Smtp-Source: ABdhPJwYacqRq/f7MIh1/3pz0PfUQwyDeoMerwcxyS4emF6UV4Lid3Xf+1Hk5tGsH6lIIlmX0qnYXw==
X-Received: by 2002:a17:906:9345:: with SMTP id p5mr24446195ejw.40.1608214828591;
        Thu, 17 Dec 2020 06:20:28 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id n4sm24486697edt.46.2020.12.17.06.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 06:20:27 -0800 (PST)
Date:   Thu, 17 Dec 2020 15:20:25 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [GIT PULL] overlayfs update for 5.11
Message-ID: <20201217142025.GB1236412@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-5.11

 - Allow unprivileged mounting in a user namespace.

   For quite some time the security model of overlayfs has been that
   operations on underlying layers shall be performed with the privileges
   of the mounting task.

   This way an unprvileged user cannot gain privileges by the act of
   mounting an overlayfs instance.  A full audit of all function calls made
   by the overlayfs code has been performed to see whether they conform to
   this model, and this branch contains some fixes in this regard.

 - Support running on copied filesystem images by optionally disabling UUID
   verification.

 - Bug fixes as well as documentation updates.

I was hoping to get feedback from Eric Biederman on the unprivileged
mounting feature, but even without that I feel quite good about enabling it
at this point.  It's a trivial patch at the head of this branch, so
skipping it now or reverting later would also be options.

Thanks,
Miklos

---
Chengguang Xu (1):
      ovl: fix incorrect extent info in metacopy case

Kevin Locke (2):
      ovl: warn about orphan metacopy
      ovl: document lower modification caveats

Miklos Szeredi (12):
      ovl: doc clarification
      ovl: expand warning in ovl_d_real()
      vfs: move cap_convert_nscap() call into vfs_setxattr()
      vfs: verify source area in vfs_dedupe_file_range_one()
      ovl: check privs before decoding file handle
      ovl: make ioctl() safe
      ovl: simplify file splice
      ovl: user xattr
      ovl: do not fail when setting origin xattr
      ovl: do not fail because of O_NOATIME
      ovl: do not get metacopy for userxattr
      ovl: unprivieged mounts

Pavel Tikhomirov (2):
      ovl: propagate ovl_fs to ovl_decode_real_fh and ovl_encode_real_fh
      ovl: introduce new "uuid=off" option for inodes index feature

---
 Documentation/filesystems/overlayfs.rst |  36 ++++++--
 fs/overlayfs/copy_up.c                  |  28 ++++---
 fs/overlayfs/export.c                   |  10 ++-
 fs/overlayfs/file.c                     | 144 +++++---------------------------
 fs/overlayfs/inode.c                    |  14 +++-
 fs/overlayfs/namei.c                    |  28 ++++---
 fs/overlayfs/overlayfs.h                |  22 +++--
 fs/overlayfs/ovl_entry.h                |   2 +
 fs/overlayfs/super.c                    |  95 ++++++++++++++++++---
 fs/overlayfs/util.c                     |  18 +++-
 fs/remap_range.c                        |  10 ++-
 fs/xattr.c                              |  17 ++--
 include/linux/capability.h              |   2 +-
 security/commoncap.c                    |   3 +-
 14 files changed, 233 insertions(+), 196 deletions(-)
