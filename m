Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0291B2A253
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2019 03:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfEYBp0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 May 2019 21:45:26 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36931 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfEYBp0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 May 2019 21:45:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id p15so4831430pll.4;
        Fri, 24 May 2019 18:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Skm0BooE8bru2DUWoCfdtPEN/f8K6576ki1g23+28oU=;
        b=K5N+XnyhqbWmWhUFvHOx/ERUs9BUIfMuHlfBr6gTOB6CFeaYPRdw4zcRM1nYTEHTOU
         xBoX1wV8yIbIWcxiaxJ3nG+vzjoVEjeR7osDiXIRft7fmyDpFasAhmzfHZvtlSf7KKVw
         pwvJ3/LmrBOBrGfkhf1J68H6E4w2H+AmDUMngEweiFNd8EdDYF1hqRD68Y4BPN/VIyZg
         wrwtDwL/00b8fvLVUrAtRplkJJT4BzxxCjbLsBL+JbOO0Kh/+refSPYawJT+HI6SOFHn
         y+R8Rc47sHq9eihpvoqo1aFOedQPZFFGUm100G1iExkf6ax6Lxju2syMwDIScZTO9kTd
         tCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Skm0BooE8bru2DUWoCfdtPEN/f8K6576ki1g23+28oU=;
        b=dPTGVk7B5hM8TGn6sgQgLvCZiv6eee/0AFHMjmKtvnrYV7VfiCUzZqh8iy+K6MAhDN
         YnnE5ciHjQaQG01MHDR7XHg8Ix5nwTsKhdv2vX00khthn1XSYJs9V68kveehhrjNGgrU
         4ALXE8b8R94WBe6PHYWch/C5XK+20Lp1aNHS3H1jcixW93fQ3RU43qrN8xINj7zmHax/
         BZ2hSn4Ztd1/BQDvXS6TYuVDdopVa3ytFKjQ95Es8hZ8GspX4AbCav+HoSj007dWE6zU
         +ipNHebl5HW8QfhgDkRrN727tX01BFnZV3xkoKgHdvOmC89lFPGd1TfN1WbZJye/XWtI
         hLDg==
X-Gm-Message-State: APjAAAWBuif9Nlup55CQcsFhaXsjo6j/KE+l1wI5/AXTwGlggC9JZGjU
        a4/h8JBnKVdmtviSMod0Te8=
X-Google-Smtp-Source: APXvYqzPm1svpXwxu1qbq8IVYDweHwhOwp0Qkbxn4JKbwdQNGlhYtqaAT122dNOctLZcYWMWiq2KDg==
X-Received: by 2002:a17:902:aa97:: with SMTP id d23mr110476812plr.313.1558748725891;
        Fri, 24 May 2019 18:45:25 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id x6sm5441611pgr.36.2019.05.24.18.45.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 18:45:24 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Christian Benvenuti <benve@cisco.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ira Weiny <ira.weiny@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
Subject: [PATCH v2 0/1] infiniband/mm: convert put_page() to put_user_page*()
Date:   Fri, 24 May 2019 18:45:21 -0700
Message-Id: <20190525014522.8042-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Hi Jason and all,

I've added Jerome's and Ira's Reviewed-by tags. Other than that, this patch
is the same as v1.

==========================================================================
Earlier cover letter:

IIUC, now that we have the put_user_pages() merged in to linux.git, we can
start sending up the callsite conversions via different subsystem
maintainer trees. Here's one for linux-rdma.

I've left the various Reviewed-by: and Tested-by: tags on here, even
though it's been through a few rebases.

If anyone has hardware, it would be good to get a real test of this.

thanks,
--
John Hubbard
NVIDIA

Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc: Christian Benvenuti <benve@cisco.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jérôme Glisse <jglisse@redhat.com>

John Hubbard (1):
  infiniband/mm: convert put_page() to put_user_page*()

 drivers/infiniband/core/umem.c              |  7 ++++---
 drivers/infiniband/core/umem_odp.c          | 10 +++++-----
 drivers/infiniband/hw/hfi1/user_pages.c     | 11 ++++-------
 drivers/infiniband/hw/mthca/mthca_memfree.c |  6 +++---
 drivers/infiniband/hw/qib/qib_user_pages.c  | 11 ++++-------
 drivers/infiniband/hw/qib/qib_user_sdma.c   |  6 +++---
 drivers/infiniband/hw/usnic/usnic_uiom.c    |  7 ++++---
 7 files changed, 27 insertions(+), 31 deletions(-)

-- 
2.21.0

