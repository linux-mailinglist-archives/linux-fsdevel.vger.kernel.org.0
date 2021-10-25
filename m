Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49FF843A441
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 22:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbhJYUUA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 16:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236071AbhJYUTy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:19:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A52C09F4E7;
        Mon, 25 Oct 2021 12:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=+iCZ2++zZJAIt8nlerUjZDKIjOPDDBBUJDYJ0Dugqdw=; b=5DmDlWh4ZcsaTU1anGrdA+pMiT
        FCfuYpwxBHTTZXQ2M+jSr/Gb7y7s+WYZ961bkRnDevcjTeRIhd6pDH/q8iFWAqPdWgBhxYLNuBW9F
        CnuIPveaI/Y1iobCgYfi/KyBj1fqQsFJU/CuW3mT3khbDyTBR4hxHmtmr2ogc98rE5JIam3zNOdx5
        qNc544N5WFzd2Hm19ELzRqGKGfhik1Q9TlRG3S9RldcHIV/NQS7jrbO6G9bj8lLUlCCPsbwwd0sOO
        3W1MNqWkOHsAdDDMoAi21sKkZ1p+Zrh9HsEb4zy9VQmG5K9DTovpE30aSrG4WY9X1b1yGwNomzG3W
        AjT6V1Ng==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mf5zM-00HUbd-T4; Mon, 25 Oct 2021 19:50:32 +0000
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
Subject: [PATCH v4 0/4] firmware_loader: built-in API and make x86 use it
Date:   Mon, 25 Oct 2021 12:50:27 -0700
Message-Id: <20211025195031.4169165-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The only change on this v4 is to fix a kconfig dependency
(EXTRA_FIRMWARE != "") which I missed to address on the v3 series.

Luis Chamberlain (4):
  firmware_loader: rename EXTRA_FIRMWARE and EXTRA_FIRMWARE_DIR
  firmware_loader: move builtin build helper to shared library
  test_firmware: move a few test knobs out to its library
  test_firmware: add support for testing built-in firmware

 .../driver-api/firmware/built-in-fw.rst       |  6 +-
 Documentation/x86/microcode.rst               |  8 +--
 arch/x86/Kconfig                              |  4 +-
 drivers/base/firmware_loader/Kconfig          | 31 ++++++---
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
 16 files changed, 270 insertions(+), 74 deletions(-)
 create mode 100644 drivers/base/firmware_loader/builtin/lib.Makefile
 create mode 100644 drivers/base/firmware_loader/test-builtin/.gitignore
 create mode 100644 drivers/base/firmware_loader/test-builtin/Makefile
 create mode 100755 tools/testing/selftests/firmware/fw_builtin.sh

-- 
2.30.2

