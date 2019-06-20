Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D84E54D1DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 17:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731511AbfFTPSv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jun 2019 11:18:51 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34862 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbfFTPSu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:18:50 -0400
Received: by mail-io1-f65.google.com with SMTP id m24so648476ioo.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2019 08:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cjD1oM5q5tMvxLtnHLi6QjIV6Kzj0WhrdaBw8sxqP6E=;
        b=KL5ut//fcz2BIKILaDyB8ohi01uo46BlAttcUNa51KKAK1tcFXFhC8SCH2ucE0+zu0
         joRzLAIQOyAlR2Jt4XsZvDwQoJQxyJxF0Eha7wO+Lcc8hMsDmgZFzdjia1zGXgTCUqe+
         R4q+jSRaCPpupw065Ncg6Ytj3OtHHyjuvu7rI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cjD1oM5q5tMvxLtnHLi6QjIV6Kzj0WhrdaBw8sxqP6E=;
        b=cD/smk24eUe/xX8TElrtgHCyAl2E/fGKDzNwPTyM3zdaV4icyKJ1uGra5qRkV2cTtS
         gspDi3IO6Fww+ok/6rsaKrXmVU5WcX9Qo+cShaHDZSPx0oajF1gvoTYszC0btIOtTrAd
         JGnl780fgceiQ0uyj1TUapKuNx+y3qodyqMBat0AeINRGnMEoL4jgEP9CUWoYMW3SQKR
         XqOrOA8hS+EVYVRaf3ewH5HcZ1LhB76S+sWWwlNy9JFf5S/5VxyvM6SNgnVERYQMO9Kp
         hKMfzdpSwx8lLYG+vf48EyPXXz71F3dnMXHiM4Y/m9DiFU1p4KtjDBeVvIQBipVLX6Rm
         LS+w==
X-Gm-Message-State: APjAAAXgT82kmbNz0GXOpzhDU7m2F5zzEFXGk3Tqg89gMkIrYgRpFwx2
        RY46eiww3XwQAsJOUlqZISL03Q==
X-Google-Smtp-Source: APXvYqyhVkr7S5sXnpnoik5KXYCmAR287xq9lSFfhPvYClEQVEFY414UtXFLtAdnecBoub+5eQcwPg==
X-Received: by 2002:a6b:641a:: with SMTP id t26mr5195793iog.3.1561043929997;
        Thu, 20 Jun 2019 08:18:49 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:855f:8919:84a7:4794])
        by smtp.gmail.com with ESMTPSA id c23sm140526iod.11.2019.06.20.08.18.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 08:18:49 -0700 (PDT)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>, "Theodore Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Fletcher Woodruff <fletcherw@google.com>,
        Justin TerAvest <teravest@google.com>
Subject: [PATCH v2 0/3] Add dirty range scoping to jbd2
Date:   Thu, 20 Jun 2019 09:18:36 -0600
Message-Id: <20190620151839.195506-1-zwisler@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changes from v1:
 - Relocated the code which resets dirty range upon transaction completion.
   (Jan)
 - Cc'd stable@vger.kernel.org because we see this issue with v4.14 and
   v4.19 stable kernels in the field.

---

This patch series fixes the issue I described here:

https://www.spinics.net/lists/linux-block/msg38274.html

Essentially the issue is that journal_finish_inode_data_buffers() operates
on the entire address space of each of the inodes associated with a given
journal entry.  This means that if we have an inode where we are constantly
appending dirty pages we can end up waiting for an indefinite amount of
time in journal_finish_inode_data_buffers().

This series improves this situation in ext4 by scoping each of the inode
dirty ranges associated with a given transaction.  Other users of jbd2
which don't (yet?) take advantage of this scoping (ocfs2) will continue to
have the old behavior.

Ross Zwisler (3):
  mm: add filemap_fdatawait_range_keep_errors()
  jbd2: introduce jbd2_inode dirty range scoping
  ext4: use jbd2_inode dirty range scoping

 fs/ext4/ext4_jbd2.h   | 12 +++++------
 fs/ext4/inode.c       | 13 +++++++++---
 fs/ext4/move_extent.c |  3 ++-
 fs/jbd2/commit.c      | 23 ++++++++++++++------
 fs/jbd2/journal.c     |  2 ++
 fs/jbd2/transaction.c | 49 ++++++++++++++++++++++++-------------------
 include/linux/fs.h    |  2 ++
 include/linux/jbd2.h  | 22 +++++++++++++++++++
 mm/filemap.c          | 22 +++++++++++++++++++
 9 files changed, 111 insertions(+), 37 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

