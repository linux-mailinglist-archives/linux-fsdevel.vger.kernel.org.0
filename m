Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28345276E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 09:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbfEWH0w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 03:26:52 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42668 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfEWH0w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 03:26:52 -0400
Received: by mail-pg1-f193.google.com with SMTP id e17so2511748pgo.9;
        Thu, 23 May 2019 00:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jlgXheI8cakQJ3hxWBVQn//xqmqtv7/wivwFD999U00=;
        b=miPz6BwBvCH/RwStiWjuSr1wakdqBdEhGehwuMJC4tO21Cw8ngK6NXuRGZ2I5CWEg4
         WleCVkkpJ9zCcpvwW7NirYcjPdM7WxWnwjsOjpDkOJuHLgXB9Azi6BCQOJC2rxzxObo/
         rFwHQgUe5y6j6V7golq2+nWhc58gg72Q6WQ95IBEfq1NeWEHmmu8tpmagq+WJDplyTI/
         1B4Edp3PxMoN13A0VtjmgUU3SWYeokLlAd+8cbYTJNS6ihRDMNpjXBONnvqkU71mdRnj
         wDtlRBdO/GTSgGNbezXpJMcWScq97PkWVgYwu3zbMf7D+AzZDTwIrfIA16vKv9F/yKRr
         xZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jlgXheI8cakQJ3hxWBVQn//xqmqtv7/wivwFD999U00=;
        b=RDQ4tXbQGr1+0VKS5juY8021AoUUN0iJC2Irh/zeA64D+NevbCvS2s7Z3grcN2O18j
         jG3SB/8UyHGwWw14WTBCTgc6/3Glfg4hlFgl35aY2RXoDZpsm3HKqXVvjbqZoOlpfSO6
         uZupzGhYP0gk/mngMq3qabJXDqHGdmJ1DUbS6KlZQEQYyc0c87xe1LWk3r3q18l4e6bC
         jxLOns78o2nZyDzaSYSrtwLJ0jrI9PIFcs+wzF4nxS4c+RjhVaqYA2HLg08f7Hi6WllF
         gNob9TP2iyUJu98RHx1KcDWaFWPCuNpVMWUZf/9lRvN6BXQ2i+yFl7XotFl5Yz5rAJL+
         TGhg==
X-Gm-Message-State: APjAAAV0vJ77kC1JKsg75qbI3Y6Yu73Dd0O/A8mZawG5SD8Netlqw94E
        cq4WHa/94v8BrdIfRnI1uzw=
X-Google-Smtp-Source: APXvYqwf8LWIvH1gPuRB+qfMGWb6tJdZL0eVa2OLEmxDxHtdyyOSvGVrXYSWrhxK4E/sp3TNPYSyjA==
X-Received: by 2002:a62:5487:: with SMTP id i129mr100345262pfb.68.1558596410687;
        Thu, 23 May 2019 00:26:50 -0700 (PDT)
Received: from sandstorm.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id i7sm25052054pfo.19.2019.05.23.00.26.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 00:26:49 -0700 (PDT)
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
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 0/1] infiniband/mm: convert put_page() to put_user_page*()
Date:   Thu, 23 May 2019 00:25:36 -0700
Message-Id: <20190523072537.31940-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Hi Jason and all,

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

