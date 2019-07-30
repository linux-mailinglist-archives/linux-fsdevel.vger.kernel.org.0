Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD8467B4AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 22:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfG3U5J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 16:57:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39966 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbfG3U5J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:57:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so30683265pgj.7;
        Tue, 30 Jul 2019 13:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uqJmpXDtzLBWNlelQWuVA7iDRDyZ/qRljFOmlSAAnn0=;
        b=NqDbh2O85KBLGJwB95wfPrIlnecdhR2uQrPFwjpUkrDdeCEBoZOXuXAUHe9xcOwYdE
         7eTcvJNfUnCdUWexszZcf+DvLJ1OdISQx9CQRlfNBJFR5U3aSpeH6jy6URKtMpx1OLef
         QBBW/iq2fVyiwN5P9A3tVS9c80X+Pm16kPgexkp66bPV/A+6Kgkew/ofKlAUO9uUcrBI
         efgD3JxOO564hLodKPUr4nYTImYgmOwz7byaI7fdBHyYEDVv9DOLlYMm/yNrkjJ65wAs
         OFPF8ZW5FFPq4B1VlhQdTxfzAuDPHjJnAdP2T2CYXiO2DNiigyO64i83I8LN5jSVO5Ug
         lc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uqJmpXDtzLBWNlelQWuVA7iDRDyZ/qRljFOmlSAAnn0=;
        b=r6aedpXNi0/n2/PNRCHKTu9I6mnd/Y15hc4FLjK/fMC2Z4Zl7Dt66V2Upgz1PDBQZx
         T7eLpVfHBaZQiv304FPJluupE/PEytKO9+rKL+tAIbyA3GFiBVEYaXFhMtoCp4SANMyl
         muPCmE59tTe4VZ+RlTH7J6mJf/tmsAOYp2Ahj1yUlLlEpGZR+QHBHC5yGn549so9hbTs
         +TXQ6LtIvQm6ciRbu4whAcCcbc4x5Bsw8nDQ5bZ/g9umw/qKF1jnZmnhXpfOaXS2p4xu
         1ajhG4o6gGF5IdLU+bpIGRgBcO5aqXX++VwNohU11NgVW7fVNpO09Xmk35KfDjgM/9cy
         d3qg==
X-Gm-Message-State: APjAAAV6wENbnVEVEv0Xh730YGoN7oWRfSmlB4kjeX1Yam1WbEzLBZRR
        OX+8ryBiZd5EPbxmsCZFznM=
X-Google-Smtp-Source: APXvYqwcRbMlDK99ar4exlWQ05oz6IdyB0wpqZP985LoMg3ICsxtQKsx77BzPQMx87QOkdoFN7DPKQ==
X-Received: by 2002:a63:1:: with SMTP id 1mr45751834pga.162.1564520228384;
        Tue, 30 Jul 2019 13:57:08 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id 137sm80565678pfz.112.2019.07.30.13.57.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 13:57:07 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v4 0/3] mm/gup: add make_dirty arg to put_user_pages_dirty_lock()
Date:   Tue, 30 Jul 2019 13:57:02 -0700
Message-Id: <20190730205705.9018-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Changes since v3:

* Fixed an unused variable warning in siw_mem.c

Changes since v2:

* Critical bug fix: remove a stray "break;" from the new routine.

Changes since v1:

* Instead of providing __put_user_pages(), add an argument to
  put_user_pages_dirty_lock(), and delete put_user_pages_dirty().
  This is based on the following points:

    1. Lots of call sites become simpler if a bool is passed
    into put_user_page*(), instead of making the call site
    choose which put_user_page*() variant to call.

    2. Christoph Hellwig's observation that set_page_dirty_lock()
    is usually correct, and set_page_dirty() is usually a
    bug, or at least questionable, within a put_user_page*()
    calling chain.

* Added the Infiniband driver back to the patch series, because it is
  a caller of put_user_pages_dirty_lock().

Unchanged parts from the v1 cover letter (except for the diffstat):

Notes about the remaining patches to come:

There are about 50+ patches in my tree [2], and I'll be sending out the
remaining ones in a few more groups:

    * The block/bio related changes (Jerome mostly wrote those, but I've
      had to move stuff around extensively, and add a little code)

    * mm/ changes

    * other subsystem patches

    * an RFC that shows the current state of the tracking patch set. That
      can only be applied after all call sites are converted, but it's
      good to get an early look at it.

This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
("mm: introduce put_user_page*(), placeholder versions").

John Hubbard (3):
  mm/gup: add make_dirty arg to put_user_pages_dirty_lock()
  drivers/gpu/drm/via: convert put_page() to put_user_page*()
  net/xdp: convert put_page() to put_user_page*()

 drivers/gpu/drm/via/via_dmablit.c          |  10 +-
 drivers/infiniband/core/umem.c             |   5 +-
 drivers/infiniband/hw/hfi1/user_pages.c    |   5 +-
 drivers/infiniband/hw/qib/qib_user_pages.c |   5 +-
 drivers/infiniband/hw/usnic/usnic_uiom.c   |   5 +-
 drivers/infiniband/sw/siw/siw_mem.c        |  10 +-
 include/linux/mm.h                         |   5 +-
 mm/gup.c                                   | 115 +++++++++------------
 net/xdp/xdp_umem.c                         |   9 +-
 9 files changed, 61 insertions(+), 108 deletions(-)

-- 
2.22.0

