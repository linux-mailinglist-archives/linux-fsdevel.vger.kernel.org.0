Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE16436703
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 17:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhJUQBV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 12:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbhJUQBP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:01:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A03C061227;
        Thu, 21 Oct 2021 08:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=vItdLvEiFjviD+SV6mIoiZ4YNRut0CdBi1c0GEuWLDI=; b=ZEJniZTa6jGkz8b5+DXM+bbRRC
        gfSXFgko3ENU/0/pDmowb7TlixONjRmMTjPqKXmsvMVIgMyj8vn0sZU7cCjxKvKuTRenusLzYJUj/
        j0KfqYxNCwlMN0E+e1HNVUb2BpVuAT8VqEJ7OY1XP64xAL56auYz74dsb9YlaidZSQZmlJ8wM9Rrg
        KxgViddrVlSh+317MkM9QBwy8rMhUXpqGMAfKwH969FBkwBgrsSbfT/el3ufK8NiHbM99X7oxDajg
        moz2A3W0zUl6PH34ovkA8SknhzYxKvl06ug2EgSA9nzw/RQxW6SIpTLGKnabaFNI5b8GKnQRRfmLK
        1xHnwTzg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdaSq-008GLs-8q; Thu, 21 Oct 2021 15:58:44 +0000
From:   "Luis R. Rodriguez" <mcgrof@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     bp@suse.de, akpm@linux-foundation.org, josh@joshtriplett.org,
        rishabhb@codeaurora.org, kubakici@wp.pl, maco@android.com,
        david.brown@linaro.org, bjorn.andersson@linaro.org,
        linux-wireless@vger.kernel.org, keescook@chromium.org,
        shuah@kernel.org, mfuzzey@parkeon.com, zohar@linux.vnet.ibm.com,
        dhowells@redhat.com, pali.rohar@gmail.com, tiwai@suse.de,
        arend.vanspriel@broadcom.com, zajec5@gmail.com, nbroeking@me.com,
        broonie@kernel.org, dmitry.torokhov@gmail.com, dwmw2@infradead.org,
        torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
        jewalt@lgsinnovations.com, cantabile.desu@gmail.com, ast@fb.com,
        andresx7@gmail.com, dan.rue@linaro.org, brendanhiggins@google.com,
        yzaikin@google.com, sfr@canb.auug.org.au, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 00/10] firmware_loader: built-in API and make x86 use it
Date:   Thu, 21 Oct 2021 08:58:33 -0700
Message-Id: <20211021155843.1969401-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

Changes in this v2:

 o drops two patches which Greg has already merged
 o drop one patch which added the new kconfig symbol FW_LOADER_BUILTIN
   which Greg didn't like, and so instead we rely only on the FW_LOADER
   symbol. If anyone cringes during review because of this, just keep in mind,
   *this* is *why* I added the symbol in the first patch series.

I've ran the firmware selftests test and found no issues. I have also
let 0 day grind on this and it found no issues. This is all based on
linux-next next-20211020, I have a branch 20211020-firmware-builtin
which has these changes in case anyone wants this in a git tree [0].

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20211020-firmware-builtin

Borislav Petkov (1):
  x86/microcode: Use the firmware_loader built-in API

Luis Chamberlain (9):
  firmware_loader: formalize built-in firmware API
  firmware_loader: remove old DECLARE_BUILTIN_FIRMWARE()
  firmware_loader: move struct builtin_fw to the only place used
  vmlinux.lds.h: wrap built-in firmware support under FW_LOADER
  x86/build: Tuck away built-in firmware under FW_LOADER
  firmware_loader: rename EXTRA_FIRMWARE and EXTRA_FIRMWARE_DIR
  firmware_loader: move builtin build helper to shared library
  test_firmware: move a few test knobs out to its library
  test_firmware: add support for testing built-in firmware

 .../driver-api/firmware/built-in-fw.rst       |   6 +-
 Documentation/x86/microcode.rst               |   8 +-
 arch/x86/Kconfig                              |   4 +-
 arch/x86/include/asm/microcode.h              |   3 -
 arch/x86/kernel/cpu/microcode/amd.c           |  14 ++-
 arch/x86/kernel/cpu/microcode/core.c          |  17 ---
 arch/x86/kernel/cpu/microcode/intel.c         |   9 +-
 arch/x86/tools/relocs.c                       |   2 +
 drivers/base/firmware_loader/Kconfig          |  29 +++--
 drivers/base/firmware_loader/Makefile         |   1 +
 drivers/base/firmware_loader/builtin/Makefile |  43 ++-----
 .../base/firmware_loader/builtin/lib.Makefile |  32 ++++++
 drivers/base/firmware_loader/builtin/main.c   | 106 ++++++++++++++++++
 drivers/base/firmware_loader/firmware.h       |  17 +++
 drivers/base/firmware_loader/main.c           |  78 +------------
 .../firmware_loader/test-builtin/.gitignore   |   3 +
 .../firmware_loader/test-builtin/Makefile     |  18 +++
 drivers/staging/media/av7110/Kconfig          |   4 +-
 include/asm-generic/vmlinux.lds.h             |  20 ++--
 include/linux/firmware.h                      |  30 +++--
 lib/Kconfig.debug                             |  33 ++++++
 lib/test_firmware.c                           |  52 ++++++++-
 .../testing/selftests/firmware/fw_builtin.sh  |  69 ++++++++++++
 .../selftests/firmware/fw_filesystem.sh       |  16 ---
 tools/testing/selftests/firmware/fw_lib.sh    |  24 ++++
 .../selftests/firmware/fw_run_tests.sh        |   2 +
 26 files changed, 441 insertions(+), 199 deletions(-)
 create mode 100644 drivers/base/firmware_loader/builtin/lib.Makefile
 create mode 100644 drivers/base/firmware_loader/builtin/main.c
 create mode 100644 drivers/base/firmware_loader/test-builtin/.gitignore
 create mode 100644 drivers/base/firmware_loader/test-builtin/Makefile
 create mode 100755 tools/testing/selftests/firmware/fw_builtin.sh

-- 
2.30.2

