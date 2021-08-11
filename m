Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337E63E99E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 22:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbhHKUsi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 16:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbhHKUsh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 16:48:37 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A40FC061765
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Aug 2021 13:48:13 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id t3so3897989qkg.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Aug 2021 13:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=zBlBSbAuxRUJW1lgOYptxB+0Lua2LslYZABHs/8DQw8=;
        b=eUl8wgQjb6gGJUCDXI5DKOavtrZkcpwdJMLOEArw3NWOcmgexnHPccbTvRywxHi2VF
         LZhJPBU7NvwO9SrJ88aTKEAB03QCnDNJyv0Kdl3dBd4Fzi+i+cJ5TX5/GzYCKLyQU6kn
         m9vVAUDi5C4Cqw7K/ZN13W3ZGBHOlkBOwZ/cu1OI7p7Y8whLOdJiCMrbfxoCXJTUSYrn
         NTMVuon/k5gDupO3Q2eWAdaeLdf5NE+eV49IiIYmew0R2IZEXTkfBRcN6kk+er+6YV4p
         zJ0GgFSw3GQNQrVMVI0KIDdyzSmEjomkORiaNnihPL1Ug3UJG4TbANJeRXA3NWLbNm/V
         aCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=zBlBSbAuxRUJW1lgOYptxB+0Lua2LslYZABHs/8DQw8=;
        b=L+nmITiGG1imzi9+AtRfH1O1eB93CDjI8eaZP7jHF68Qiy42AQD7Ihh0BXO4i7e5jU
         5dF4F5NrJgGanuvLrjMI8np7wzlCwFdV7fWlJKGKh2o+M8RQtaLQYypTNe1OnRUvDx9N
         5wb+U3/QqjK6+lhbS0LGQTFtz0HpZFtq0wiIRHYJITIjYzUn00fpMnGbDRfTWNsp9oMg
         wGy4bHf+ShB1o87rscDQRasKSw8+HE/wFwnsNpOuqJ17LFYxaIleM2/uiCv/RHPwT+jI
         ffwtPuzb2cB6ArvI8IcrxuuqYaeU4RBMBYFLh8jz0pEobYCgooQuQysrFLM0z02V521U
         +wgw==
X-Gm-Message-State: AOAM531h4ksHVPy4+9r/A9ece6/wyEtvEb/w5lAsXq+n2e+IBL5RRdsv
        x6V9tbNm2Ni3g26W7R7Vj/eK
X-Google-Smtp-Source: ABdhPJydL0ykzGSU3mSv7znsNMhnb+x6axRiQjqG6NUGWFR49FmN7RGZaFHzTlB9WZgH5isKA3x/lQ==
X-Received: by 2002:a37:b082:: with SMTP id z124mr964004qke.298.1628714892595;
        Wed, 11 Aug 2021 13:48:12 -0700 (PDT)
Received: from localhost (pool-96-237-52-188.bstnma.fios.verizon.net. [96.237.52.188])
        by smtp.gmail.com with ESMTPSA id k1sm159186qkj.21.2021.08.11.13.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 13:48:12 -0700 (PDT)
Subject: [RFC PATCH v2 0/9] Add LSM access controls and auditing to io_uring
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Date:   Wed, 11 Aug 2021 16:48:11 -0400
Message-ID: <162871480969.63873.9434591871437326374.stgit@olly>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Draft #2 of the patchset which brings auditing and proper LSM access
controls to the io_uring subsystem.  The original patchset was posted
in late May and can be found via lore using the link below:

https://lore.kernel.org/linux-security-module/162163367115.8379.8459012634106035341.stgit@sifl/

This draft should incorporate all of the feedback from the original
posting as well as a few smaller things I noticed while playing
further with the code.  The big change is of course the selective
auditing in the io_uring op servicing, but that has already been
discussed quite a bit in the original thread so I won't go into
detail here; the important part is that we found a way to move
forward and this draft captures that.  For those of you looking to
play with these patches, they are based on Linus' v5.14-rc5 tag and
on my test system they boot and appear to function without problem;
they pass the selinux-testsuite and audit-testsuite and I have not
noticed any regressions in the normal use of the system.  If you want
to get a copy of these patches straight from git you can use the
"working-io_uring" branch in the repo below:

git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git

Beyond the existing test suite tests mentioned above, I've cobbled
together some very basic, very crude tests to exercise some of the
things I care about from a LSM/audit perspective.  These tests are
pretty awful (I'm not kidding), but they might be helpful for the
other LSM/audit developers who want to test things:

https://drop.paul-moore.com/90.kUgq

There are currently two tests: 'iouring.2' and 'iouring.3';
'iouring.1' was lost in a misguided and overzealous 'rm' command.
The first test is standalone and basically tests the SQPOLL
functionality while the second tests sharing io_urings across process
boundaries and the credential/personality sharing mechanism.  The
console output of both tests isn't particularly useful, the more
interesting bits are in the audit and LSM specific logs.  The
'iouring.2' command requires no special arguments to run but the
'iouring.3' test is split into a "server" and "client"; the server
should be run without argument:

  % ./iouring.3s
  >>> server started, pid = 11678
  >>> memfd created, fd = 3
  >>> io_uring created; fd = 5, creds = 1

... while the client should be run with two arguments: the first is
the PID of the server process, the second is the "memfd" fd number:

  % ./iouring.3c 11678 3
  >>> client started, server_pid = 11678 server_memfd = 3
  >>> io_urings = 5 (server) / 5 (client)
  >>> io_uring ops using creds = 1
  >>> async op result: 36
  >>> async op result: 36
  >>> async op result: 36
  >>> async op result: 36
  >>> START file contents
  What is this life if, full of care,
  we have no time to stand and stare.
  >>> END file contents

The tests were hacked together from various sources online,
attribution and links to additional info can be found in the test
sources, but I expect these tests to die a fiery death in the not
to distant future as I work to add some proper tests to the SELinux
and audit test suites.

As I believe these patches should spend a full -rcX cycle in
linux-next, my current plan is to continue to solicit feedback on
these patches while they undergo additional testing (next up is
verification of the audit filter code for io_uring).  Assuming no
critical issues are found on the mailing lists or during testing, I
will post a proper patchset later with the idea of merging it into
selinux/next after the upcoming merge window closes.

Any comments, feedback, etc. are welcome.

---

Casey Schaufler (1):
      Smack: Brutalist io_uring support with debug

Paul Moore (8):
      audit: prepare audit_context for use in calling contexts beyond
             syscalls
      audit,io_uring,io-wq: add some basic audit support to io_uring
      audit: dev/test patch to force io_uring auditing
      audit: add filtering for io_uring records
      fs: add anon_inode_getfile_secure() similar to
          anon_inode_getfd_secure()
      io_uring: convert io_uring to the secure anon inode interface
      lsm,io_uring: add LSM hooks to io_uring
      selinux: add support for the io_uring access controls


 fs/anon_inodes.c                    |  29 ++
 fs/io-wq.c                          |   4 +
 fs/io_uring.c                       |  69 +++-
 include/linux/anon_inodes.h         |   4 +
 include/linux/audit.h               |  26 ++
 include/linux/lsm_hook_defs.h       |   5 +
 include/linux/lsm_hooks.h           |  13 +
 include/linux/security.h            |  16 +
 include/uapi/linux/audit.h          |   4 +-
 kernel/audit.h                      |   7 +-
 kernel/audit_tree.c                 |   3 +-
 kernel/audit_watch.c                |   3 +-
 kernel/auditfilter.c                |  15 +-
 kernel/auditsc.c                    | 483 +++++++++++++++++++-----
 security/security.c                 |  12 +
 security/selinux/hooks.c            |  34 ++
 security/selinux/include/classmap.h |   2 +
 security/smack/smack_lsm.c          |  64 ++++
 18 files changed, 678 insertions(+), 115 deletions(-)
