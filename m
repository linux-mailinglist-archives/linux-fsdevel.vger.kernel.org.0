Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A137125804
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 00:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfLRXxQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 18:53:16 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36826 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLRXxP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 18:53:15 -0500
Received: by mail-io1-f68.google.com with SMTP id r13so3883929ioa.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2019 15:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=7IVECIjrfiMtkwD3dgFv5MvTKmZcnbmgCiKELN0IQLI=;
        b=qUtlYaKSEy53QXVZw4miOfTGjPmf8GooOKPUqowGZf/0QoW700B55gK7OJ/RLNvOLu
         HJou0ZMGHFt94ES2OEC/uyoKIRfjbFjnUvv475uuaMZFec9/ghc/uGoAq21M/UEUvCxK
         /yOEdrWEY+DhEgF5RuQKhYzwHR/OZ4BpGKe1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7IVECIjrfiMtkwD3dgFv5MvTKmZcnbmgCiKELN0IQLI=;
        b=OSKBhK8MGaL3GmzRS3snPa/OPS15tJNlPDATmAlQxhLcZV0/26coVszj3xegKsf05J
         Gm8rDLc0tiQnhESpNUjBx/XR+Tsezq42CQDDKmCG2kTsMjREO9stRO7clWUHK84ujiTu
         TrlTtUpv4EC/pt4gCSuVwd5B7uyWltD8P/CdkYoFQwcoW1f8rZhB3zaWpOWjOIs48tPy
         fpKoDFaD6Xvb5qzEvm0i/20uH8Vqdy48N6YOhmLMUPYtLOzwjep3mT7iLmd4x7WDI66P
         nA+BVxY8n/njQVPXjvio/gYv4YIiaZhLhJgEaLPASgcddn+eWH/hLufXaA0VDsmi4YRU
         d5hw==
X-Gm-Message-State: APjAAAVbql2PauQqbDIhbkVyGXDATrVLPfbXiKgPslBxCY4x94BX3wCl
        L+tex4jKg8OIFb3BtAaZZuAQkg==
X-Google-Smtp-Source: APXvYqxNO7sED7Bgst40LG8+vMav9za6w4jomPu262pm1nXLHB4Jr+puHpJDbjlwrtKh9voF3gWGVA==
X-Received: by 2002:a6b:b581:: with SMTP id e123mr3630627iof.67.1576713194679;
        Wed, 18 Dec 2019 15:53:14 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id j79sm1162608ila.52.2019.12.18.15.53.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 15:53:14 -0800 (PST)
Date:   Wed, 18 Dec 2019 23:53:12 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     tycho@tycho.ws, jannh@google.com, cyphar@cyphar.com,
        christian.brauner@ubuntu.com, oleg@redhat.com, luto@amacapital.net,
        viro@zeniv.linux.org.uk, gpascutto@mozilla.com,
        ealvarez@mozilla.com, fweimer@redhat.com, jld@mozilla.com,
        arnd@arndb.de
Subject: [PATCH v4 0/5] Add pidfd getfd ioctl (Was Add ptrace get_fd request)
Message-ID: <20191218235310.GA17259@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset introduces a mechanism to capture file descriptors from other
processes by pidfd and ioctl. Although this can be achieved using
SCM_RIGHTS, and parasitic code injection, this offers a more
straightforward mechanism.

It has a flags mechanism that's only usable to set CLOEXEC on the fd,
but I'm thinking that it could be extended to other aspects. For example,
for sockets, one could want to scrub the cgroup information.

Changes since v3:
 * Add self-test
 * Move to ioctl passing fd directly, versus args struct
 * Shuffle around include files

Changes since v2:
 * Move to ioctl on pidfd instead of ptrace function
 * Add security check before moving file descriptor

Changes since the RFC v1:
 * Introduce a new helper to fs/file.c to fetch a file descriptor from
   any process. It largely uses the code suggested by Oleg, with a few
   changes to fix locking
 * It uses an extensible options struct to supply the FD, and option.
 * I added a sample, using the code from the user-ptrace sample

Sargun Dhillon (5):
  vfs, fdtable: Add get_task_file helper
  pid: Add PIDFD_IOCTL_GETFD to fetch file descriptors from processes
  samples: split generalized user-trap code into helper file
  samples: Add example of using pidfd getfd in conjunction with user
    trap
  test: Add test for pidfd getfd

 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |   1 +
 fs/file.c                                     |  22 +-
 include/linux/file.h                          |   2 +
 include/uapi/linux/pidfd.h                    |  10 +
 kernel/fork.c                                 |  77 ++++++
 samples/seccomp/.gitignore                    |   1 +
 samples/seccomp/Makefile                      |  15 +-
 samples/seccomp/user-trap-helper.c            |  84 +++++++
 samples/seccomp/user-trap-helper.h            |  13 +
 samples/seccomp/user-trap-pidfd.c             | 185 ++++++++++++++
 samples/seccomp/user-trap.c                   |  85 +------
 tools/testing/selftests/pidfd/.gitignore      |   1 +
 tools/testing/selftests/pidfd/Makefile        |   2 +-
 .../selftests/pidfd/pidfd_getfd_test.c        | 231 ++++++++++++++++++
 15 files changed, 641 insertions(+), 89 deletions(-)
 create mode 100644 include/uapi/linux/pidfd.h
 create mode 100644 samples/seccomp/user-trap-helper.c
 create mode 100644 samples/seccomp/user-trap-helper.h
 create mode 100644 samples/seccomp/user-trap-pidfd.c
 create mode 100644 tools/testing/selftests/pidfd/pidfd_getfd_test.c

-- 
2.20.1

