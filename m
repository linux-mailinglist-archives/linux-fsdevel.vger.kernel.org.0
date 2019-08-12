Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21DDE8953F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 03:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfHLBu5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Aug 2019 21:50:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43921 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfHLBu4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Aug 2019 21:50:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id v12so1141998pfn.10;
        Sun, 11 Aug 2019 18:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pfaVFzFF0GvUkP+csExf9mRMYKLakGIqocXWtOijWcs=;
        b=J3n5ZKeoQQ0bmNJgluv6gAytDIfBo9heugCs0XBMhVCrev0LMMnqqYvHMPS/Cr0eBt
         gctxUlCPGnoXwjK2CwzgVvi28Wb22MRLlEhA2lKWros6W4HEdEFgJOn/NBCaUfYs2Th8
         uPiE4ZxUz27VerKWtltJreVV1o5cNvwgiQmm2L4fmmkncjkGTaspegF0sY5rCwFaz1Bj
         NmwHks4rnhNi7uAo/lBpxeuM3ZbiuZQc8DkW7I1xNK4QRa1pZCMUjYzqmjrptEEwb9Fi
         DfhQnMHmRrF6nz3dpmgznKvjSD+eNOrb0yEq+WeDxCYjBjqUNCYLFdD0M1uwwALX4eRZ
         OSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pfaVFzFF0GvUkP+csExf9mRMYKLakGIqocXWtOijWcs=;
        b=MXJwOuOHmKADAU2vW5Wl+ibhpMmFzsIFmV9dQVSznTMaeSqywa251ZKEmB8DChqAtv
         MBzHJRjZnFMSWb7mnvbWw+FG+sZT9r0bYfuHgEGOU67iL6pb2NFfbim3jIpRNUJRU7oJ
         HVxkxX/bX76r9mLlPlr10ooXMhXfs+yO7rsW0+3b2n3nSp9G/SH6jJLN2EI5sGp1tqZW
         r7b6v5anIqIp5IvaEleQDqTaLAgV9BBHinmn8eEbIaG1pNpi/PVc1fFQwQ/Sq7iR2Ap7
         4t4VUEvFH1/VSdF1D05tc8ALRAYZs8iHRCc/C1TUAigSFtO22OaTVKYnGauINordz8o+
         rjOw==
X-Gm-Message-State: APjAAAV5MRK7ASlQc6cFhAXEcnQ9SbO9LMetLVT5YBzO5i6NHDs4S/da
        RinunS/jdu+RtHY9PI2hhDHGPMXA
X-Google-Smtp-Source: APXvYqwiGohojGGhDnygsE9A4cyzbEHPkz9fH4ggMXoJfzmaJzcdAgT3McHJiakV36cLDMyvSwP/zg==
X-Received: by 2002:a65:44cc:: with SMTP id g12mr27761338pgs.409.1565574656022;
        Sun, 11 Aug 2019 18:50:56 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id j20sm100062363pfr.113.2019.08.11.18.50.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 18:50:55 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-rdma@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>
Subject: [RFC PATCH 0/2] mm/gup: introduce vaddr_pin_pages_remote(), FOLL_PIN
Date:   Sun, 11 Aug 2019 18:50:42 -0700
Message-Id: <20190812015044.26176-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Hi,

Dave Chinner's head didn't seem to explode...much, when he saw Ira's
series, so I optimistically started taking it from there...this builds on
top of Ira's patchset that he just sent out:

  "[RFC PATCH v2 00/19] RDMA/FS DAX truncate proposal V1,000,002   ;-)" [1]

...which in turn is based on the latest -mmotm.

If Ira's series and this one are both acceptable, then

    a) I'll rework the 41-patch "put_user_pages(): miscellaneous call
       sites" series, and

    b) note that this will take rather longer and will be quite a bit more
       intrusive for each call site (but it's worth it), due to the
       need to plumb the owning struct file* all the way down to the gup()
       call. whew.

[1] https://lore.kernel.org/r/20190809225833.6657-1-ira.weiny@intel.com

[2] https://lore.kernel.org/r/20190807013340.9706-1-jhubbard@nvidia.com

John Hubbard (2):
  mm/gup: introduce FOLL_PIN flag for get_user_pages()
  mm/gup: introduce vaddr_pin_pages_remote()

 drivers/infiniband/core/umem_odp.c | 15 ++++----
 include/linux/mm.h                 |  8 +++++
 mm/gup.c                           | 55 +++++++++++++++++++++++++++++-
 3 files changed, 71 insertions(+), 7 deletions(-)

-- 
2.22.0

