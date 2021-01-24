Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036CB301E39
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Jan 2021 19:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbhAXSmv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Jan 2021 13:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbhAXSmt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Jan 2021 13:42:49 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71DAC061573;
        Sun, 24 Jan 2021 10:42:08 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ke15so14814897ejc.12;
        Sun, 24 Jan 2021 10:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W+JrCBsCsPTl6k7mNOkqzbJk1+UN8xbWUBx1eSyEtDs=;
        b=hbw8BlgW+Ct3Bxn/x0gbkALVc1KsoL4rBhzA4mwCeM2VuWfruCw7rIktlxO/J8frZy
         pSLVg9lssIJlmtP+qvc+a7+aqFYyHJdoD/OIiv1nG7zFVp9ZMzEiVXqUhTXcZni1jssG
         zlMhNM/9bcDlAhtCAaa3RkfVtV6WdAJUQ7Z7xQjNMffrpjRzWljdWvlezYhKahSu2Sdu
         7+50589H/fjgHUUHOI/knzaWnYKj3b8FYInOIX1MOQA7GO+A9kpu6a8aRL1YVeMsnHme
         NWxJ0lQ0UUllW0nyCTtvkd/D6+vHdOAw792V1Se2kfZBP3E8IUrWxzc4inmNxw8dyirk
         J1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W+JrCBsCsPTl6k7mNOkqzbJk1+UN8xbWUBx1eSyEtDs=;
        b=s0hiJkbZSbeqsY2BFkxvCzlcrfHrnz2K5sNXtYs6CCqxEEKYbzTzAJVVpeRLKsMLoD
         FN/2pZOj43ak1XjNN/K0yhfGlq6s1xVY93UkIqw3Vpn+uf/S+xeDb7DFJDJAyDPhWvt/
         bX7E5hmkJssDF6EoStQoSxdAcV7OK+wo1vM6t+dH1zTkzpGNEy4Pa1wezuK6/n6OU7ct
         4JsNdLcvDpQVQD9EQxRkezTThztGeSEhEgDB0xu9+S67q25RBxDD/rgTows8lk59vqsl
         K3qiLpqjYYQgL5Wmmi6oFJ1raup10in0dBexgCo12w8ptzpqqxIaPMx+FPXOPR8K1UB+
         ulxQ==
X-Gm-Message-State: AOAM53319dEywdBOKa6d5pDTU6X/V7BAmNfuptO5FKzOWV3XkB51er5i
        +93ZNP5nPHLF18f0BHYjMKNX8cD0pos=
X-Google-Smtp-Source: ABdhPJywZfVzgUMih3nNMYLdBzhLmwmHCvpx5+4UPoo6FmrqJvAdTKlTUgn9xmhEq7z1RvAlHmY3yQ==
X-Received: by 2002:a17:906:6087:: with SMTP id t7mr106276ejj.90.1611513727474;
        Sun, 24 Jan 2021 10:42:07 -0800 (PST)
Received: from localhost.localdomain ([31.210.181.203])
        by smtp.gmail.com with ESMTPSA id t9sm7260266ejc.51.2021.01.24.10.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 10:42:06 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [RFC][PATCH 0/2] unprivileged fanotify listener
Date:   Sun, 24 Jan 2021 20:42:02 +0200
Message-Id: <20210124184204.899729-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan,

These patches try to implement the minimal set and least controversial
functionality that we can allow for unprivileged users as a starting
point.

I tried to be as conservative as I can with the system limits, but
I wasn't sure how to handle the per group marks limit, so I left both
per group and per user limits which looks quite confusing.

I tested unprivileged listener with Matthew's LTP tests [1].
I do not have test for the sysfs tunables yet, but I verified that
existing LTP tests fail when lowering each of the tunables to 1 and
pass after setting them back up.

I think that the sysfs tunables can be considered even without the
unprivileged listener.

Thanks,
Amir.

[1] https://github.com/amir73il/ltp/commits/fanotify_unpriv

Amir Goldstein (2):
  fanotify: configurable limits via sysfs
  fanotify: support limited functionality for unprivileged users

 fs/notify/fanotify/fanotify.c      |  14 ++-
 fs/notify/fanotify/fanotify_user.c | 155 +++++++++++++++++++++++++----
 fs/notify/fdinfo.c                 |   3 +-
 include/linux/fanotify.h           |  19 ++++
 include/linux/fsnotify_backend.h   |   2 +-
 include/linux/sched/user.h         |   3 -
 include/linux/user_namespace.h     |   4 +
 kernel/sysctl.c                    |  12 ++-
 kernel/ucount.c                    |   4 +
 9 files changed, 183 insertions(+), 33 deletions(-)

-- 
2.25.1

