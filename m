Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50C1E7DD36
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 16:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731414AbfHAOCs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 10:02:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55827 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730502AbfHAOCs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:02:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so64777777wmj.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Aug 2019 07:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bPITu1xJUcsyVUAunfEJ+7STRoUC8YhgbJi6vG+X1/s=;
        b=PklWQ4zE8k8obHwlCM1Y9FY+JS0ABl+ay189CCMZVXZ8DCsy0LD8t1sVgDsNxlLEWj
         8zNdYAXqLFkwKdxPbezv5a/xt2NbV0FNWq9tnz7CP/W2BwDQaKW26UwumO7Sl94BhTOD
         7VNwwqcQgvqlSClkXQfCY+4nmCeWXBPyd5YRJYSrhFlFwwpav1NB6nTUdyLmYprtIcfU
         kh+RRCbuWTeeb6O9lqs+bipOPPZ/amlOJVuPgDZs19o+LMvmwjVM7CfI1A5EHUjkF489
         vDu9jhkf4IM8cGbc7IELj0FNsycIbUXtTb9bhUF1Uyng5DLv3FvK+ftbvz5LuMa/qnAW
         6c5Q==
X-Gm-Message-State: APjAAAXBqGkNHavAyRShjUc9KSK2nznIZnL8TkIbUwP1yVVT7JTPQBqw
        mtshKyyRhzG6TAxkaYhe8wWQpedOqKs=
X-Google-Smtp-Source: APXvYqx/FgRtIl2NkzGCN3MQeLmf/HhINWWXFafkm+lfRM01MDOpX+XVKqJWk+aKHTQG3EQIAM19og==
X-Received: by 2002:a05:600c:2182:: with SMTP id e2mr51998743wme.104.1564668166166;
        Thu, 01 Aug 2019 07:02:46 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z7sm69909162wrh.67.2019.08.01.07.02.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 07:02:45 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/4] selinux: fix race when removing selinuxfs entries
Date:   Thu,  1 Aug 2019 16:02:39 +0200
Message-Id: <20190801140243.24080-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After hours and hours of getting familiar with dcache and debugging,
I think I finally found a solution that works and hopefully stands a
chance of being committed.

The series still doesn't address the lack of atomicity of the policy
reload transition, but this is part of a wider problem and can be
resolved later. Let's fix at least the userspace-triggered lockup
first.

Changes since v1:
 - switch to hopefully proper and actually working solution instead
   of the horrible mess I produced last time...
v1: https://lore.kernel.org/selinux/20181002111830.26342-1-omosnace@redhat.com/T/

Ondrej Mosnacek (4):
  d_walk: optionally lock also parent inode
  d_walk: add leave callback
  dcache: introduce d_genocide_safe()
  selinux: use d_genocide_safe() in selinuxfs

 fs/dcache.c                  | 87 +++++++++++++++++++++++++++++++-----
 include/linux/dcache.h       |  1 +
 security/selinux/selinuxfs.c |  2 +-
 3 files changed, 77 insertions(+), 13 deletions(-)

-- 
2.21.0

