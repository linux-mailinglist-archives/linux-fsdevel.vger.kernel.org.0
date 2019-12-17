Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D61941220E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 01:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfLQA7C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 19:59:02 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44222 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfLQA6s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 19:58:48 -0500
Received: by mail-io1-f66.google.com with SMTP id b10so9089221iof.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2019 16:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=WiC/tVMR8NsdCbTV/Ood/vOmHz4f4snd++QrFmS9AGU=;
        b=Em+fHxRi0S9GiNiOxsOH/NxZWK2QKDW/iJBLB2E3WezC1UpRDI3rFiRGNoHh351jFd
         hq6tCNOQE97TLgWaCC/1l5XKDDdosLf9KAISFCJaqz0xg6OZ/KamL8otukuHe+07m/1T
         MKZJTV56gyq54ZknBIn4la06vRrdqqvlbMq1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=WiC/tVMR8NsdCbTV/Ood/vOmHz4f4snd++QrFmS9AGU=;
        b=gn9gN1+HHsuCik9auChRaRN3vWhMj3FD3ZQRnyFMNRun6CwQy1f06sUDCxa5tvszt/
         ZIeUMtiZhLqevwWGTbawnozrbTl1lsX59RFdpjW1bBFWjZ0ly7khdfilOdpn3Rev7KLr
         VOT1YihDzWvKil5mqf/2iKmEwKEP1BvO6UmPSti/MHtd6kacN/XUrnyAJSglDo+DLkFV
         FpYqDrK+LASP9KaFnamUxMB2+EvwZcmh4d/fznJQiHpmGqMpdIkq8IOi2eCNk6Pvz2cH
         eaRigJGSq/B1CMmKTzwMdgCgRBUOZ+wYTLieufETNc+kjYeZZ+37QTKkVoLpfOfe7jlI
         /+6g==
X-Gm-Message-State: APjAAAV7cNHHElifvTjEPr/2jtI9DjUBiF2rGnNaEeCntTfLZEky48mn
        8qZnNhp7+h045BVLwT/IEvHlCg==
X-Google-Smtp-Source: APXvYqwT6sRXLv/Jw7cnhk1CTUzXUyCspDTW0zUOfg4w/uYtX65PErXp6pg3Db4EgPtUhZpb0tV91Q==
X-Received: by 2002:a5d:8d10:: with SMTP id p16mr1621703ioj.21.1576544327254;
        Mon, 16 Dec 2019 16:58:47 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id u29sm2890493ill.62.2019.12.16.16.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 16:58:46 -0800 (PST)
Date:   Tue, 17 Dec 2019 00:58:45 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     tycho@tycho.ws, jannh@google.com, cyphar@cyphar.com,
        christian.brauner@ubuntu.com, oleg@redhat.com, luto@amacapital.net,
        viro@zeniv.linux.org.uk, gpascutto@mozilla.com,
        ealvarez@mozilla.com, fweimer@redhat.com, jld@mozilla.com
Subject: [PATCH v3 0/4] Add pidfd getfd ioctl (Was Add ptrace get_fd request)
Message-ID: <20191217005842.GA14379@ircssh-2.c.rugged-nimbus-611.internal>
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

Changes since v2:
 * Move to ioctl on pidfd instead of ptrace function
 * Add security check before moving file descriptor

Changes since the RFC v1:
 * Introduce a new helper to fs/file.c to fetch a file descriptor from
   any process. It largely uses the code suggested by Oleg, with a few
   changes to fix locking
 * It uses an extensible options struct to supply the FD, and option.
 * I added a sample, using the code from the user-ptrace sample

Sargun Dhillon (4):
  vfs, fdtable: Add get_task_file helper
  pid: Add PIDFD_IOCTL_GETFD to fetch file descriptors from processes
  samples: split generalized user-trap code into helper file
  samples: Add example of using pidfd getfd in conjunction with user
    trap

 Documentation/ioctl/ioctl-number.rst |   1 +
 fs/file.c                            |  22 +++-
 include/linux/file.h                 |   2 +
 include/linux/pid.h                  |   1 +
 include/uapi/linux/pid.h             |  26 ++++
 kernel/fork.c                        |  72 ++++++++++
 samples/seccomp/.gitignore           |   1 +
 samples/seccomp/Makefile             |  15 ++-
 samples/seccomp/user-trap-helper.c   |  84 ++++++++++++
 samples/seccomp/user-trap-helper.h   |  13 ++
 samples/seccomp/user-trap-pidfd.c    | 190 +++++++++++++++++++++++++++
 samples/seccomp/user-trap.c          |  85 +-----------
 12 files changed, 424 insertions(+), 88 deletions(-)
 create mode 100644 include/uapi/linux/pid.h
 create mode 100644 samples/seccomp/user-trap-helper.c
 create mode 100644 samples/seccomp/user-trap-helper.h
 create mode 100644 samples/seccomp/user-trap-pidfd.c

-- 
2.20.1

