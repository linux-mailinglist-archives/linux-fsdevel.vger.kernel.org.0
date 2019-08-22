Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 318EA99F0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 20:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388934AbfHVSkW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 14:40:22 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35070 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730867AbfHVSkW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 14:40:22 -0400
Received: by mail-pl1-f195.google.com with SMTP id gn20so3950760plb.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2019 11:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=l3f7J9dLXFEkkPEpHoZfCHDBojT5vl2BXru+bCQWM9k=;
        b=ex7I0HZM1XZ6nwcwJqKZFzWwvGvKmcP9p6rxpsVI/+xYBxClCbtueXcVx0JxcT5oID
         JXpkwA/Bhug+LEiV8vtZANPVM3IxNyQ+W/6m3o6LQa+FPXzahsdNpQXLz2q9/iBg5cf9
         Q81XzJ2UHw+Xu2lkdOP+AvS2qPMEACeupEn/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l3f7J9dLXFEkkPEpHoZfCHDBojT5vl2BXru+bCQWM9k=;
        b=l3KH7N9YZgEaM1Q0PlD/6a+k1WpuwBAJybdwFCEiIAwJzyN3GkzW8bLNDmqUbnAX41
         f6G4Yt0vgTVPSjEqaHgLqniYELaKEPSdK8G0T8gQcuQgC2nBbFBLseLmbkRc/d/V9ULk
         WRMc5lHw6yR2X5LsW5Jti8djAjyrVBfO4jpt0NtXOPsG4gSZsmzyJwuDpOoqW5i+vkxd
         e8qSAu0CgI4YDD5i8NxUT3wjyduMIsqN0ycfjaqthjGO5JpexprBCvw44ua+kaeSzJrq
         TUu06lw1RaT8daOxfc+6x3+fDGbpCSUmD3C0m0MZ1F2+drJbGmmph5zPNomfERBkkKvm
         sQsQ==
X-Gm-Message-State: APjAAAWHg9YWFpHNeFFFYOO8wLARM6C3BgaRm5JMxgO6okB3agEPjlZo
        4V8Zho7/QLkoRvBbOiYNDdixQA==
X-Google-Smtp-Source: APXvYqxPQ9aH3jF39LKTjf20cbeWadPkB+uuUPl7/RjqxCo7ecZeQNFkTtcAcpXBrjBObejQFr9TmQ==
X-Received: by 2002:a17:902:a8:: with SMTP id a37mr226321pla.316.1566499220955;
        Thu, 22 Aug 2019 11:40:20 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id z19sm51056pgv.35.2019.08.22.11.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 11:40:20 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v2 0/2] firmware: selftest for request_firmware_into_buf
Date:   Thu, 22 Aug 2019 11:40:03 -0700
Message-Id: <20190822184005.901-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series adds kernel selftest of request_firmware_into_buf.
The API was added to the kernel previously untested.

Changes from v1:
- Dropped demonstration patch for a race condition discovered
while testing request_firmare_into_buf.
The new test exposes a kernel opps with the firmware fallback mechanism that may
be fixed separate from these tests.
- minor whitespace formatting in patch
- added Ack's
- added "s" in commit message (changed selftest: to selftests:)

Scott Branden (2):
  test_firmware: add support for request_firmware_into_buf
  selftests: firmware: Add request_firmware_into_buf tests

 lib/test_firmware.c                           | 50 +++++++++++++++-
 .../selftests/firmware/fw_filesystem.sh       | 57 ++++++++++++++++++-
 tools/testing/selftests/firmware/fw_lib.sh    | 11 ++++
 3 files changed, 114 insertions(+), 4 deletions(-)

-- 
2.17.1

