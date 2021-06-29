Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD3E3B74A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 16:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbhF2OvS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 10:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbhF2OvS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:51:18 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2A1C061760;
        Tue, 29 Jun 2021 07:48:51 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so2101202pjs.2;
        Tue, 29 Jun 2021 07:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=koZtRUNjw4bYNAZV6JWLxfBDPL3I14Zph7TjpLy0UpA=;
        b=TooWxCAcuEemzgn3EAdG7nTJRrAJ8QghigYKwSlw5aodIB+yRqTVWNb/aydNu/NtXX
         tu5CsEXgtXvvZV1mTv5tLDhZhzxxBYkrIfWauY9PlVKerJkwfNJLGYVmbJ1BMoA4QwPj
         x5OoXpSGahS4Wmyn9czcbO4JsI99DKFlIulK5f+SOhjBVwj8FWw7BfUUen6rtI5JjTXK
         ECQKFrDI9SmThzfvtmkTzBZOLUpo5FCnqjGlzeAl7yCMGmf3shsYVkjBbzT27M+ZSTPg
         IZvieyGuaM4YLphD+xmvrd4UMjO5QoyGLGyBezfQqdJQoqEtu73vnv+Z3LMuBYgzknBy
         qX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=koZtRUNjw4bYNAZV6JWLxfBDPL3I14Zph7TjpLy0UpA=;
        b=BdavNIyqzexV+rZvlRRLjaL5aoKJH5KV2Z0nl+7rVrx6f0OSMp+Z0IrNlwTmyaPAbr
         2AJEMDK3zQgDALuV3aj0490MZ2aFc7iHCtimOpa0zDRgpt8aNpH7lzQx7TWL/Ge6vMDD
         q5wLm8i5pcvORmjiFa9tuC4cqVuKxxntUpD0Hgu0zZ54dDjQKAmpt5wjm7GDOjTcd5ch
         VkefcTMgcGoRr4zKIWE/grZmkHSojVXv3MTGAluKLWPIBYopBYkl4NqipJUi/TE/kByN
         tPLWOOG7jCXWj/3eTHtq8Z5vuSJd6xvwDfofItXVD7j3Un985vZ1k7jXs2F57EZF/ZHE
         0cbw==
X-Gm-Message-State: AOAM53360lDwOjV6ShttQtFuu57/VaZCBHvv3FBcSWyub3/n9R/QbN+Z
        sHN54EbXKLiujqQMH5H33Gk=
X-Google-Smtp-Source: ABdhPJzDOltMmEszV+HSvCrb8aMX9wydlrmi1DRwuaxNyG5WZixOQVcnzzn9OUmGR98tanV2a4V+uQ==
X-Received: by 2002:a17:902:bc4a:b029:129:ef:3c35 with SMTP id t10-20020a170902bc4ab029012900ef3c35mr2788828plz.46.1624978130555;
        Tue, 29 Jun 2021 07:48:50 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id i2sm3417262pjj.25.2021.06.29.07.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 07:48:50 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     gustavoars@kernel.org, viro@zeniv.linux.org.uk
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 0/3] hfs: fix various errors
Date:   Tue, 29 Jun 2021 22:48:00 +0800
Message-Id: <20210629144803.62541-1-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This series ultimately aims to address a lockdep warning in hfs_find_init reported by Syzbot:
https://syzkaller.appspot.com/bug?id=f007ef1d7a31a469e3be7aeb0fde0769b18585db

The work done for this led to the discovery of another bug, and the Syzkaller repro test also reveals an invalid memory access error after clearing the lockdep warning. Hence, this series is broken up into three patches:

1. Add a missing call to hfs_find_exit an error path in hfs_fill_super

2. Fix memory mapping in hfs_bnode_read by fixing calls to kmap

3. Add lock nesting notation to tell lockdep that the observed locking hierarchy is safe

Desmond Cheong Zhi Xi (3):
  hfs: add missing clean-up in hfs_fill_super
  hfs: fix high memory mapping in hfs_bnode_read
  hfs: add lock nesting notation to hfs_find_init

 fs/hfs/bfind.c | 14 +++++++++++++-
 fs/hfs/bnode.c | 18 ++++++++++++++----
 fs/hfs/btree.h |  7 +++++++
 fs/hfs/super.c |  1 +
 4 files changed, 35 insertions(+), 5 deletions(-)

-- 
2.25.1

