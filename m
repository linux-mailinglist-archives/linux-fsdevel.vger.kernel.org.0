Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9823F40FF1D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 20:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344306AbhIQSYH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 14:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhIQSYG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 14:24:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DADC061757;
        Fri, 17 Sep 2021 11:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=4bQo5XXQSgN6eO5cUMGH1bS2NQ993+cG2D9qNC4TbPk=; b=z0MZai6HkL9APtqMptXhF0Kr7z
        WO6Ilfzz6LyaBeplCsWkG3xdbtIM/PQN0EBDybfmLvfXTqH0XIUF/95RGbV98Gj6LJiKBhC8nfEIC
        9McoqoSG+CBcSO0YpOy92w0lOg7fPxQI4u+h/6h7j/mRrbUsvFDf9MPEtrVuOwB9TXrk75EY0lw/0
        pXKIUq2j3zNbcUOCkonmM5hn65EOZcEQUO8I+PxNQh7220UBQn+TmoqN/9UM3liFF4bD002dCF9k6
        a0ul9oFm23MTyAfaUqHHW/ECGaUSqHZIVvprVZgruLQ1iBc995RtLD5SKuLlBXSdv03NN4RAe7jhW
        wlcFUOIg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRIVH-00Ep5O-U4; Fri, 17 Sep 2021 18:22:27 +0000
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
Subject: [PATCH 00/14] firmware_loader: built-in API and make x86 use it
Date:   Fri, 17 Sep 2021 11:22:12 -0700
Message-Id: <20210917182226.3532898-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

A while ago I noted to Boris how we could likely do away the odd
direct use of the firmware sections on x86 and instead have it use
the API directly. This indeed was possible but it required quite
a bit of spring cleaning as well and on its way I spotted a small
fix.

This goes with a new series of tests against built-in firmware as well.
Boris has confirmed this also does work for the x86 microcode loader.
0day is happy with the build results. You can find these changes on my
git tree branch 20210916-firmware-builtin-v2 [0].

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20210916-firmware-builtin-v2

Borislav Petkov (1):
  x86/microcode: Use the firmware_loader built-in API

Luis Chamberlain (13):
  firmware_loader: fix pre-allocated buf built-in firmware use
  firmware_loader: split built-in firmware call
  firmware_loader: add a sanity check for firmware_request_builtin()
  firmware_loader: add built-in firmware kconfig entry
  firmware_loader: formalize built-in firmware API
  firmware_loader: remove old DECLARE_BUILTIN_FIRMWARE()
  firmware_loader: move struct builtin_fw to the only place used
  vmlinux.lds.h: wrap built-in firmware support under its kconfig symbol
  x86/build: Tuck away built-in firmware under its kconfig symbol
  firmware_loader: rename EXTRA_FIRMWARE and EXTRA_FIRMWARE_DIR
  firmware_loader: move builtin build helper to shared library
  test_firmware: move a few test knobs out to its library
  test_firmware: add support for testing built-in firmware

 .../driver-api/firmware/built-in-fw.rst       |   8 +-
 Documentation/x86/microcode.rst               |   9 +-
 arch/x86/Kconfig                              |   4 +-
 arch/x86/include/asm/microcode.h              |   3 -
 arch/x86/kernel/cpu/microcode/amd.c           |  14 ++-
 arch/x86/kernel/cpu/microcode/core.c          |  17 ---
 arch/x86/kernel/cpu/microcode/intel.c         |   9 +-
 arch/x86/tools/relocs.c                       |   2 +
 drivers/base/firmware_loader/Kconfig          |  39 ++++---
 drivers/base/firmware_loader/Makefile         |   4 +-
 drivers/base/firmware_loader/builtin/Makefile |  43 ++------
 .../base/firmware_loader/builtin/lib.Makefile |  32 ++++++
 drivers/base/firmware_loader/builtin/main.c   | 101 ++++++++++++++++++
 drivers/base/firmware_loader/firmware.h       |  17 +++
 drivers/base/firmware_loader/main.c           |  65 +----------
 .../firmware_loader/test-builtin/.gitignore   |   3 +
 .../firmware_loader/test-builtin/Makefile     |  18 ++++
 drivers/staging/media/av7110/Kconfig          |   4 +-
 include/asm-generic/vmlinux.lds.h             |  20 ++--
 include/linux/firmware.h                      |  26 ++---
 lib/Kconfig.debug                             |  34 ++++++
 lib/test_firmware.c                           |  52 ++++++++-
 .../testing/selftests/firmware/fw_builtin.sh  |  69 ++++++++++++
 .../selftests/firmware/fw_filesystem.sh       |  16 ---
 tools/testing/selftests/firmware/fw_lib.sh    |  24 +++++
 .../selftests/firmware/fw_run_tests.sh        |   2 +
 26 files changed, 447 insertions(+), 188 deletions(-)
 create mode 100644 drivers/base/firmware_loader/builtin/lib.Makefile
 create mode 100644 drivers/base/firmware_loader/builtin/main.c
 create mode 100644 drivers/base/firmware_loader/test-builtin/.gitignore
 create mode 100644 drivers/base/firmware_loader/test-builtin/Makefile
 create mode 100755 tools/testing/selftests/firmware/fw_builtin.sh

-- 
2.30.2

