Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CB87B2A75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 05:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjI2DYm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 23:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjI2DYl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 23:24:41 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABE61A1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 20:24:37 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c4194f769fso102694035ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 20:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695957877; x=1696562677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DZpy/gLfnuMsQ3zYwfMZFr7l/UudGqfvJfNYCKkC6BA=;
        b=OjoTLLKT2BLmAAwOCFmylxZWmrd8SbraEqzMVMu3orKXWJYB8mjAuosRLOmD+TC7Bz
         gTfm+1xA0YRedGX5bo4NUJdIq4ndJ82qIhixDAUh/u86sYdd057zDna4w4uR8QNZAQy7
         G4xgnn+D3W9igApDT5au+08XUNb1n1kMzAES0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695957877; x=1696562677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DZpy/gLfnuMsQ3zYwfMZFr7l/UudGqfvJfNYCKkC6BA=;
        b=e6lOZbiiTrNxVJ0u7PmBtpKhoMZw1JKg/981jvc9fb+ttQbcFi2+U1DdY9BMgM983s
         MN4joWJvQqRUIDOZvN7P4+dDtkwsIHVUf1PRxK0zmQ5JqqSPYW2fueRUKOAmFuBP6Spy
         aZsxEGib9tnMAFB6Ox6A1FLeAWkA1CAyH0v6Eo+lEqMpXxIFJRflQkPjcoebROFGQ0rr
         VURPWHtitvV+OZmXMrIF6FLkEdVn/X5KcTt1zG90Lzf7okGOPytFX30viP1osXl6zBGz
         um8HzprcqJLYbcMNLDTou5sI6YZn9NaOB8wVQhoxrCBFSYseJL7lEHOzkxxaUy7oYv33
         bG/Q==
X-Gm-Message-State: AOJu0Ywyffzx72p0gKzF06KxVdyqBq12ImKVJrffzMBXGPpfvJAfY9Q/
        l5etykPx+ZSy2CAPMz5+2nCAjw==
X-Google-Smtp-Source: AGHT+IG9cnWbn0hVG+1LR+a11ImsezJeyyFe0SBw+gyrL4qhOuJ5PkqXrWcVlge8k9fcAkF9UBo6zA==
X-Received: by 2002:a17:903:1cf:b0:1b8:94e9:e7b0 with SMTP id e15-20020a17090301cf00b001b894e9e7b0mr3606862plh.9.1695957877031;
        Thu, 28 Sep 2023 20:24:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iw12-20020a170903044c00b001bf574dd1fesm6250537plb.141.2023.09.28.20.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 20:24:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Sebastian Ott <sebott@redhat.com>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: [PATCH v4 0/6] binfmt_elf: Support segments with 0 filesz and misaligned starts
Date:   Thu, 28 Sep 2023 20:24:28 -0700
Message-Id: <20230929031716.it.155-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1382; i=keescook@chromium.org;
 h=from:subject:message-id; bh=uV4AJsRv4n/gB4mSOC9KIOnGOAI8uNiU0zUGBP7t1x8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlFkNxLv+WtDGXS3EGA7QG2806nd9yzM662vbJz
 Z/QF9lP7jqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRZDcQAKCRCJcvTf3G3A
 Jl1KD/4w77J7PmG0TdHjUB7lH4ZlBX43xi8xD755lb9vhHxLRTtI3hqQ+JvyAc97r4JGaph3Jk3
 +kKf02DqkcBcEm0W7oeO0JKZtqIfM8XEHkHQ9/pE8mKfalwC5DCFnIJbNcsdxr9SSwhz0POUO3E
 QaUEJZjccKFkHTwDKLd3XRvNdDZ3jll5HxQfWEKXvyjNCHVTG5jgC+GQB8d+RSZPwp1CGvEWqN5
 4GDF1tB2l1DHa4lX6yI8qPhawqRzZuJFTO3SSse+E2IPkgfkt6VfJ8cWyqDd6AMALfIOl3hIq7E
 u0hVjNyK8WcQSmSzMHbrAHi1hVxdRRZzfKJw49k9mbc3zUKx2iTEbJRitqjEQOXaE9xDtpENZ8z
 ACRF8mJ3ewqtPtv5N3XhiB9SiOUGIBaWR5qCcgL989zLDhLf7IdBgj6pCpz+35BH+8Jx3ioPlse
 tvWvLx1KjocOYMQWqde+FJQsJokrG/P2gt8jKDPp96b16uQlble+qU64f0zUbbTRQXjRaGP9JE6
 lUxI28L4rZ/qPL2gFq6pMGTT2offlDs6i1y5OBptudXqWdphur4s1n/ctL4RlT89tTT81h/qPgm
 T2AB0n5jBX6DQm4Ji0DI78f0/MRN0aAbjeLYg7EiWO86oDL4JmXSqgzGwkWXgxhXTqngX8Gnzoc
 dw/DwpD vMJ3XKAQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This is the continuation of the work Eric started for handling
"p_memsz > p_filesz" in arbitrary segments (rather than just the last,
BSS, segment). I've added the suggested changes:

 - drop unused "elf_bss" variable
 - refactor load_elf_interp() to use elf_load()
 - refactor load_elf_library() to use elf_load()
 - report padzero() errors when PROT_WRITE is present
 - drop vm_brk()

Thanks!

-Kees

v4:
 - refactor load_elf_library() too
 - don't refactor padzero(), just test in the only remaining caller
 - drop now-unused vm_brk()
v3: https://lore.kernel.org/all/20230927033634.make.602-kees@kernel.org
v2: https://lore.kernel.org/lkml/87sf71f123.fsf@email.froward.int.ebiederm.org
v1: https://lore.kernel.org/lkml/87jzsemmsd.fsf_-_@email.froward.int.ebiederm.org

Eric W. Biederman (1):
  binfmt_elf: Support segments with 0 filesz and misaligned starts

Kees Cook (5):
  binfmt_elf: elf_bss no longer used by load_elf_binary()
  binfmt_elf: Use elf_load() for interpreter
  binfmt_elf: Use elf_load() for library
  binfmt_elf: Only report padzero() errors when PROT_WRITE
  mm: Remove unused vm_brk()

 fs/binfmt_elf.c    | 214 ++++++++++++++++-----------------------------
 include/linux/mm.h |   3 +-
 mm/mmap.c          |   6 --
 mm/nommu.c         |   5 --
 4 files changed, 76 insertions(+), 152 deletions(-)

-- 
2.34.1

