Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1A71CFE8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 21:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgELTnJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 15:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELTnJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 15:43:09 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8C9C061A0C
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 12:43:09 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id u11so15478571iow.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 12:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pbleye/tcK1271rZA5Esc6+UJ+CAeRD5kNKc6nTEvCM=;
        b=hgWwoDIuKQrPHvpd9vLJmSCo/BP1E7oj+ZV1RVrMJ5fHVPk0RWubYI8cOU+XZuaQb3
         6RZdoAFgWjKDU/G6vOFiDZlblDPxZM7fyi0h9Qn5bogfcGcCxEXvyvxfd6Gle2aD71nE
         6n6FvGwme4j81i5XsD4F16we04NDcPjPT3cl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pbleye/tcK1271rZA5Esc6+UJ+CAeRD5kNKc6nTEvCM=;
        b=ZtsOX25f2402fhtC4jWIVmY3eXGuKmz2x8zq8q9o9VDX1jge/l9HDlA3oOgc2dlGgW
         gf2bLJtuj5mu9UrNQtU9FRUnmP2W8b75WMgK/KDu96l03bCcna9AYZc4JXzie7HsZWBc
         xVsnVCzDaS7W06KjE+Qc9nVOuWYC4rV2aBE+KT7CMcXGCw2T80H+WCkmICJTvBFmcwSy
         3vEA13OE0tf/NkTgOg1k/J/wC7bIAHkwCrCXlstPEsXydM3qpqgZTM5+3CC3en9A72XE
         iyOAIiSRkBsNkpQtTZDPSlSO8SVjJ96bOh+9edejWsVjxmURcLGy9AR7fBV+Rl6pDqf7
         thhw==
X-Gm-Message-State: AGi0PubTEWG4eI1xLrce8e6xxLE0o2cWsTSuYpnRFlw/I8yKFA/h4Us6
        SYnS58IHEICZoWw3v/4iFNhaLQ==
X-Google-Smtp-Source: APiQypLU+z6PjgsLK15waPZJZlD3EpwMHYfleT6Sjp5XNU88pf4SIqHkEeBpDSGsRQmSdBq4ZcjuSA==
X-Received: by 2002:a6b:e517:: with SMTP id y23mr816204ioc.60.1589312588662;
        Tue, 12 May 2020 12:43:08 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f5sm6177781iok.4.2020.05.12.12.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 12:43:08 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     viro@zeniv.linux.org.uk, axboe@kernel.dk, zohar@linux.vnet.ibm.com,
        mcgrof@kernel.org, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] fs: avoid fdput() after failed fdget()
Date:   Tue, 12 May 2020 13:43:03 -0600
Message-Id: <cover.1589311577.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While debugging an unrelated problem, I noticed these two cases fdput()
is called after failed fdget() while reviewing at all the fdget() and
fdput() paths in the kernel.

Changes since v1:
Patch 1:
  Changed to address review comments to refine the code for improved
  readability in addition to the change to avoid fdput() on failed
  fdget()
Patch 2:
  No change to v1. Including it in the series to keep the patches
  together.

Shuah Khan (2):
  fs: avoid fdput() after failed fdget() in ksys_sync_file_range()
  fs: avoid fdput() after failed fdget() in kernel_read_file_from_fd()

 fs/exec.c |  2 +-
 fs/sync.c | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.25.1

