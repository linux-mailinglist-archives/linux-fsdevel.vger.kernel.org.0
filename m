Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 568D182782
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 00:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbfHEWUW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 18:20:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38756 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbfHEWUW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 18:20:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id z14so3205476pga.5;
        Mon, 05 Aug 2019 15:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G0gFHWZTLbSduXOaMLchOdcBu5BZUnGvKngNJx2WzYs=;
        b=Z/ReGytPgMcBSprofJvaD3uijqrHGmjFXhQ8SVTciXecVSXakggzyHWNRDvFhRgU8T
         u6TPdY2PF5xYLBUpllXrYCHhWm8cHP++rJnHYNiU27wjl0NhOkK2oNas25KcpykV+WAz
         uvhk5+gNSSUsdbDCOQhiRwsFqde85qdUWdJmufamVV2FjeVQ2jd+cD5vTpmD+aQGq3CK
         AI9KsM8UqNDc8gYS8zbZ21eIvYP1MpSPEVe86POj8V8k1lu4grw0oNMFt2s04HsPZQlP
         l5pFJo5UMsb+GrSvmNFzB/AmGb9pxgF2lHamLHqRga4omD5TzOsglDe+56mBWpf9b7em
         uVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G0gFHWZTLbSduXOaMLchOdcBu5BZUnGvKngNJx2WzYs=;
        b=XX4anPX6uAEcjQXpmNH8f1c94E9akAcR+nzY4kh6di+3GtMxkZdsSimq3ol411YcFo
         j9hmt1j5vqHG2xCxnZEqL4hYzWfiYZOk1DBF1d+YjTMDI0O3n/hCTRaBjEk/bUpOw2yB
         Sg6sC5ZsD2j1d1KvH+dkeFm47fyiTemcEe2ZVIVkpDMq0jqDZNZD5RzpDYC4xFQw/xrU
         OmxiKGG8G4jX28Dl1srjo+Xc+pdA9mKEkLOUZZ4gSdIlFOg79DDURQ/QimPrhuOBQNxn
         eABB0AabD0h8sztYoY8pQLk0rXuSgKJowEFEYRBN4it9Pxet395eTOr1zYg7kj/tyFdd
         4H5g==
X-Gm-Message-State: APjAAAWoXqR03oI/d34bsoBW7oRhlPx3ZZe5XVkF1HlK8mLDWQdqJij7
        AVXJZbBwMs3XFIV1mlQgtXg=
X-Google-Smtp-Source: APXvYqw/Thz7xsbrkutCxM/PWuqVA1ryJfAAEe/B9LCqZStSRD/vIlf4fE6PvGQNZlDnGviC1E/eIQ==
X-Received: by 2002:aa7:8189:: with SMTP id g9mr238227pfi.143.1565043621658;
        Mon, 05 Aug 2019 15:20:21 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id 185sm85744057pfd.125.2019.08.05.15.20.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 15:20:20 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/3] mm/: 3 more put_user_page() conversions
Date:   Mon,  5 Aug 2019 15:20:16 -0700
Message-Id: <20190805222019.28592-1-jhubbard@nvidia.com>
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

Hi,

Here are a few more mm/ files that I wasn't ready to send with the
larger 34-patch set.

John Hubbard (3):
  mm/mlock.c: convert put_page() to put_user_page*()
  mm/mempolicy.c: convert put_page() to put_user_page*()
  mm/ksm: convert put_page() to put_user_page*()

 mm/ksm.c       | 14 +++++++-------
 mm/mempolicy.c |  2 +-
 mm/mlock.c     |  6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.22.0

