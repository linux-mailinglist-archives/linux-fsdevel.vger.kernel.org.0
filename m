Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7730A73BA79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jun 2023 16:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjFWOoJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jun 2023 10:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjFWOnv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:43:51 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38838184
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jun 2023 07:43:36 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-570553a18deso9829597b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jun 2023 07:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687531415; x=1690123415;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cAAFffNo5n7JO9asv2/EjTz77Q8bdKCTYdHhFz9jqbk=;
        b=w8OUSYv2sPOqw/SZj4Fu0+C7CcU5elCykdgSTzKDfTFcj6I/Q3AGnnyOxpWaCiUZPG
         UaH+k2FGrnNmj83RBIyeD5V05QNYvNIWyHFwYN0TWh2Bo3xR5+CgGesmgFxwkagAa4mK
         mokpUzC3BZuDkW/SzpoEHI5cKtFPLHG2jB1M98Lbktmh6CDycQb7TAhaZgOyAWrGcZLw
         kM9pJQrvJHOlogB2AI+yPWJfLkwihq4qBUu4ZBxt8tco/nDJF9ArQlPzqkomdPeVGQm/
         ieoW3/k39a77M91v/227CXLlV7LfCi+AW2w5aSlDw7t3w2yl9TUkirjyo9sLIRvke4mj
         dLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687531415; x=1690123415;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAAFffNo5n7JO9asv2/EjTz77Q8bdKCTYdHhFz9jqbk=;
        b=Gpcr9A+AP5Gpu2iZ+BovfFhv6Ee7lEgS3DqSLeyT2ZW6TSwRqBG4i3k2bs3//IS2t0
         Fef6vHyLlLQLcE/HzukxZSP7ThUREGLivWbABzMqhxrG37dLDKeY5Sg2TYqYbuFiYsEk
         kRK/VbyeoO4lZ3RYN8CcGxUJjMwVy+SyylFHgtRkr7R2U7ekGK3+AqU5Ci9H754KRjAX
         1yuFljqDfiCYOJuirr3rCSSL6pi4ls6KiBse4i9r0mGRNZYFOEeNRnbOt2AmmGzBVLh/
         9eGIGTanlYmq52ttgZ8r/ZXifA55T83jTPGku1gztWtOc4G2kSu4Hgzx9FSwReTUZgRc
         +C0w==
X-Gm-Message-State: AC+VfDyVWiK9J8soVmTWEvG64EXVR2/6ZBxjYx5cA84DFuj2URjpxMLU
        4IzBz1VJSxleN79/LHgGelfeIfSaliY=
X-Google-Smtp-Source: ACHHUZ6jIe8yLLFFywqjCie14gjNnE2bQMF+pAbJG96LJQF0Z6Re5SaQWD+3ax1Xz9vy5tCXqS8mC5uAAYQ=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:8b55:dee0:6991:c318])
 (user=gnoack job=sendgmr) by 2002:a81:ac42:0:b0:56d:ca1:cd6c with SMTP id
 z2-20020a81ac42000000b0056d0ca1cd6cmr5524779ywj.2.1687531415477; Fri, 23 Jun
 2023 07:43:35 -0700 (PDT)
Date:   Fri, 23 Jun 2023 16:43:23 +0200
Message-Id: <20230623144329.136541-1-gnoack@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 0/6] Landlock: ioctl support
From:   "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To:     linux-security-module@vger.kernel.org,
        "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc:     Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-fsdevel@vger.kernel.org,
        "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

These patches add simple ioctl(2) support to Landlock.

Objective
~~~~~~~~~

Make ioctl(2) requests restrictable with Landlock,
in a way that is useful for real-world applications.

Proposed approach
~~~~~~~~~~~~~~~~~

Introduce the LANDLOCK_ACCESS_FS_IOCTL right, which restricts the use
of ioctl(2) on file descriptors.

We attach the LANDLOCK_ACCESS_FS_IOCTL right to opened file
descriptors, as we already do for LANDLOCK_ACCESS_FS_TRUNCATE.

I believe that this approach works for the majority of use cases, and
offers a good trade-off between Landlock API and implementation
complexity and flexibility when the feature is used.

Current limitations
~~~~~~~~~~~~~~~~~~~

With this patch set, ioctl(2) requests can *not* be filtered based on
file type, device number (dev_t) or on the ioctl(2) request number.

On the initial RFC patch set [1], we have reached consensus to start
with this simpler coarse-grained approach, and build additional ioctl
restriction capabilities on top in subsequent steps.

[1] https://lore.kernel.org/linux-security-module/d4f1395c-d2d4-1860-3a02-2=
a0c023dd761@digikod.net/

Notable implications of this approach
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* Existing inherited file descriptors stay unaffected
  when a program enables Landlock.

  This means in particular that in common scenarios,
  the terminal's ioctls (ioctl_tty(2)) continue to work.

* ioctl(2) continues to be available for file descriptors acquired
  through means other than open(2).  Example: Network sockets,
  memfd_create(2), file descriptors that are already open before the
  Landlock ruleset is enabled.

Examples
~~~~~~~~

Starting a sandboxed shell from $HOME with samples/landlock/sandboxer:

  LL_FS_RO=3D/ LL_FS_RW=3D. ./sandboxer /bin/bash

The LANDLOCK_ACCESS_FS_IOCTL right is part of the "read-write" rights
here, so we expect that newly opened files outside of $HOME don't work
with ioctl(2).

  * "stty" works: It probes terminal properties

  * "stty </dev/tty" fails: /dev/tty can be reopened, but the ioctl is
    denied.

  * "eject" fails: ioctls to use CD-ROM drive are denied.

  * "ls /dev" works: It uses ioctl to get the terminal size for
    columnar layout

  * The text editors "vim" and "mg" work.  (GNU Emacs fails because it
    attempts to reopen /dev/tty.)

Related Work
~~~~~~~~~~~~

OpenBSD's pledge(2) [2] restricts ioctl(2) independent of the file
descriptor which is used.  The implementers maintain multiple
allow-lists of predefined ioctl(2) operations required for different
application domains such as "audio", "bpf", "tty" and "inet".

OpenBSD does not guarantee ABI backwards compatibility to the same
extent as Linux does, so it's easier for them to update these lists in
later versions.  It might not be a feasible approach for Linux though.

[2] https://man.openbsd.org/OpenBSD-7.3/pledge.2

Changes
~~~~~~~

V2:
 * rebased on mic-next
 * added documentation
 * exercise ioctl in the memfd test
 * test: Use layout0 for the test

---

V1: https://lore.kernel.org/linux-security-module/20230502171755.9788-1-gno=
ack3000@gmail.com/

G=C3=BCnther Noack (6):
  landlock: Increment Landlock ABI version to 4
  landlock: Add LANDLOCK_ACCESS_FS_IOCTL access right
  selftests/landlock: Test ioctl support
  selftests/landlock: Test ioctl with memfds
  samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL
  landlock: Document ioctl support

 Documentation/userspace-api/landlock.rst     | 52 ++++++++-----
 include/uapi/linux/landlock.h                | 19 +++--
 samples/landlock/sandboxer.c                 | 12 ++-
 security/landlock/fs.c                       | 21 +++++-
 security/landlock/limits.h                   |  2 +-
 security/landlock/syscalls.c                 |  2 +-
 tools/testing/selftests/landlock/base_test.c |  2 +-
 tools/testing/selftests/landlock/fs_test.c   | 77 ++++++++++++++++++--
 8 files changed, 149 insertions(+), 38 deletions(-)


base-commit: 35ca4239929737bdc021ee923f97ebe7aff8fcc4
--=20
2.41.0.162.gfafddb0af9-goog

