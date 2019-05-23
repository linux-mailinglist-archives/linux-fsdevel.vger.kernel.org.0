Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A38C27494
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 04:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbfEWCv0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 22:51:26 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:37153 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfEWCv0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 22:51:26 -0400
Received: by mail-pg1-f179.google.com with SMTP id n27so2307661pgm.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2019 19:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=eelYOl+auCZwPeaiF2iZqxUedYahMzn49UDx8OOb2N8=;
        b=BrT/LmvVnhqjaKLk/W1wvw0WfcNXPvWG0i0rFsiMvmJpNRkOSM5XIMzQrTEyryQqNg
         RS8iiVSCimgKdPtY9di7vvJXbDUGY8aW4/uDwh9dw6FgZaxXDgrOXbV2BJW4Pv52ZS0A
         eRK1jYeKKSnZhbMeqtbVAPScLf/iDf23GCJdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eelYOl+auCZwPeaiF2iZqxUedYahMzn49UDx8OOb2N8=;
        b=CXuBFL9fvZKStCCquLQjqFIREtmBLHB8S5imrdbnQ4Hp5Q9403Dkri1ufN3D6U/3xe
         KLC8bMUjjy57qRczcPRxy8eZEdpfw/cO1nofifMv/pCSpeDbAT2k9OGuj2pP0LL76n/e
         pqQEX7z/ItXAliI12WEqotBmWH/o67h1T8lRPjjL8efbwiK+AyA1FaeYQtWLc8qu4jlk
         Agke9+1HrMy7Wh9VVJFyxxpNXoRB6SI8RlhdAwlGBslF71PeQjw+5hAinOGSU3p63dl7
         iySs1Hl1YsbzyGhCi/So2zC6h6UZ3QLyAS1s8UeBNg9t/W/kx7+hLr1r8GBk9+/SgfBz
         0sOQ==
X-Gm-Message-State: APjAAAVIe4A29qQzPR3nILgf5bsf8X2Lh2TEVWi4tv93QP9HrYZbtrVA
        VH5AzjSDPQDcwnmcsW6o7Jss2w==
X-Google-Smtp-Source: APXvYqyryGsGQdDT/y24ZM5GRt90QMDl4IIoLoKgwlwT7BtX21xYS/KWrf+aebtyaSorYCB4oWXgrQ==
X-Received: by 2002:a65:52c3:: with SMTP id z3mr41505682pgp.56.1558579885890;
        Wed, 22 May 2019 19:51:25 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id q19sm42812174pff.96.2019.05.22.19.51.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 19:51:24 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH 0/3] fs: add partial file read support
Date:   Wed, 22 May 2019 19:51:10 -0700
Message-Id: <20190523025113.4605-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series adds partial file read support to the kernel via
kernel_pread_file functions.  request_firmware_into_buf function
enhanced to allow partial file read support and single qcom driver
using existing function updated.
Change to core kernel file support allows new drivers to read partial
file to memory as necessary in memory constrained systems.

Scott Branden (3):
  fs: introduce kernel_pread_file* support
  firmware: add offset to request_firmware_into_buf
  soc: qcom: mdt_loader: add offset to request_firmware_into_buf

 drivers/base/firmware_loader/firmware.h |  5 ++
 drivers/base/firmware_loader/main.c     | 49 +++++++++++-----
 drivers/soc/qcom/mdt_loader.c           |  7 ++-
 fs/exec.c                               | 77 +++++++++++++++++++------
 include/linux/firmware.h                |  8 ++-
 include/linux/fs.h                      | 15 +++++
 6 files changed, 125 insertions(+), 36 deletions(-)

-- 
2.17.1

