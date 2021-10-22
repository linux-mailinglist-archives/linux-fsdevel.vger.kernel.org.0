Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34799437C28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 19:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbhJVRn1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 13:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbhJVRnS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 13:43:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45BBC061767;
        Fri, 22 Oct 2021 10:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=PQGAwwzDcqi+LKyXyVffXbDs6+KXex5wyQmEkA3rIH0=; b=L4Pu77xwTOghWTcVCGeepll+LU
        czfhr8Wb0hVc099/PZtjAOTZkTTy3fRGToOSrBu5VghMn3CusPxkk1wdeHw6bZYJic6j9lVDgVQ1F
        uqMVO9bv5J8bPpjiX6jbwlCVpXs3BWbdJzQGzNXQLfTm+F4Mp8YAZRxXIxVi4LmDNVANR0o6fWEWO
        ZEZ498Jh59PF0v3AVZ9ELmDhHQrCr8NhYDSipy9xY996rh2nbIgzRNDIidzQqlrWxi8MDSumf/wZ1
        TGJmeKearPm7rrwG2bldSpI6efqIPXWu0baodiWj1S5a0JCdBGC5MX7Jd0zcVdbKj8qXXbOw2hKUt
        YHt2oXoQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdyX6-00BeR4-Kf; Fri, 22 Oct 2021 17:40:44 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
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
        andresx7@gmail.com, brendanhiggins@google.com, yzaikin@google.com,
        sfr@canb.auug.org.au, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v3 0/4] firmware_loader: built-in API and make x86 use it
Date:   Fri, 22 Oct 2021 10:40:37 -0700
Message-Id: <20211022174041.2776969-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This v3 addresses the last remaining patches from my v2, the only change
is fixing the patch "firmware_loader: built-in API and make x86 use it"
where I left an old CONFIG_FW_LOADER_BUILTIN symbol in the
documentation.

Luis Chamberlain (4):
  firmware_loader: rename EXTRA_FIRMWARE and EXTRA_FIRMWARE_DIR
  firmware_loader: move builtin build helper to shared library
  test_firmware: move a few test knobs out to its library
  test_firmware: add support for testing built-in firmware

 .../driver-api/firmware/built-in-fw.rst       |  6 +-
 Documentation/x86/microcode.rst               |  8 +--
 arch/x86/Kconfig                              |  4 +-
 drivers/base/firmware_loader/Kconfig          | 29 +++++---
 drivers/base/firmware_loader/Makefile         |  1 +
 drivers/base/firmware_loader/builtin/Makefile | 41 ++---------
 .../base/firmware_loader/builtin/lib.Makefile | 32 +++++++++
 .../firmware_loader/test-builtin/.gitignore   |  3 +
 .../firmware_loader/test-builtin/Makefile     | 18 +++++
 drivers/staging/media/av7110/Kconfig          |  4 +-
 lib/Kconfig.debug                             | 33 +++++++++
 lib/test_firmware.c                           | 52 +++++++++++++-
 .../testing/selftests/firmware/fw_builtin.sh  | 69 +++++++++++++++++++
 .../selftests/firmware/fw_filesystem.sh       | 16 -----
 tools/testing/selftests/firmware/fw_lib.sh    | 24 +++++++
 .../selftests/firmware/fw_run_tests.sh        |  2 +
 16 files changed, 269 insertions(+), 73 deletions(-)
 create mode 100644 drivers/base/firmware_loader/builtin/lib.Makefile
 create mode 100644 drivers/base/firmware_loader/test-builtin/.gitignore
 create mode 100644 drivers/base/firmware_loader/test-builtin/Makefile
 create mode 100755 tools/testing/selftests/firmware/fw_builtin.sh

-- 
2.30.2

