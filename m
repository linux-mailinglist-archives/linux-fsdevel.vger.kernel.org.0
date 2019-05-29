Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2ED2E379
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 19:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfE2Rna (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 13:43:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38020 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfE2Rna (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 13:43:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id d18so2396174wrs.5;
        Wed, 29 May 2019 10:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SUYnB2bg4AR5y4HlcGNuWGzeCbLRgpuJBmh6fn5CpA4=;
        b=f17Sh1HPDc9bYMG1afQL0SErA2OLPo6bzs0M+RgImWRrvuYAE6X+IRRxhBfn2W8n0E
         GHV5S3VSKLum2UZG2m5jEEwK8YJoCH6NU8hq8TTgEr1vT6rIGaAS1my/czWl8uffAP0/
         Cu2fC0uC3HP8OIJi+W6ZBzEcsH05bCQsoWY2DcsxobER2+mSj7/5QtCDqY7JLuPOvPdz
         9YN5j/7+voP6EZ0q9aJ/GFALf7QeTIaoY8iWAKvRTcYOr6KnA96A+TZwu1T/A/V1q5GD
         hxkR7JeYoG95+ckNoW0Loz5RBtdwNSSwHXQUyeOgzTHAdWjwQpffAZZeHtflgtnYlu0v
         QDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SUYnB2bg4AR5y4HlcGNuWGzeCbLRgpuJBmh6fn5CpA4=;
        b=qxQcZ7L8a0kPUxyDe7dxpZBc6DpickgHPFEu1mzucgzgLCq37HfZr5CvRlUshF8h2g
         ArBrim/vZtlJ7EbFWJ7qgW3ifAwy3xq4DcXGJoIWpj1ByO/d2w7yfUJV7GnK7IcvOGNI
         6r/sRgYTlSLYMVV//F/fYPVYOuAZe+QxrifOBlUtaW+1bGDBBQadImUxGWIyp7XHllfM
         7mfOVddkfap5Ehg4+h8uWc3x/YmI8bUSSiHaBrrQ3S8LYKm7IQsuvHg2Puu04OUoWHpf
         nRJxEMjWA0UEJBmTcMNglYKm6hCGtThuv6adeq8GxXIBk6UKS/gXAGd0nGAJKCy3ZWdA
         iUjg==
X-Gm-Message-State: APjAAAVzkUH9n5/ITQUGy3IP6XQloCOZM2w5Jmky3/E8PwLLH5uuWRjO
        X6ULJpAM2qCOovs9dntWIcs=
X-Google-Smtp-Source: APXvYqwXQ8E44dxbKym/mvJKG8Qiroxs57QOiLNMp3g+8QBMB71+VtDnIZNwSmjflXVUKuCFoplM6g==
X-Received: by 2002:a5d:6b03:: with SMTP id v3mr22768077wrw.309.1559151807660;
        Wed, 29 May 2019 10:43:27 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id k125sm31702wmb.34.2019.05.29.10.43.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 10:43:26 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        linux-xfs@vger.kernel.org,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: [PATCH v3 00/13] Fixes for major copy_file_range() issues
Date:   Wed, 29 May 2019 20:43:04 +0300
Message-Id: <20190529174318.22424-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Darrick,

Following is a re-work of Dave Chinner's copy_file_range() patches.
This v3 patch set is based on your feedback to v2 [1].

NOTE that this work changes user visible behavior of copy_file_range(2)!
It introduces new errors for cases that were not checked before and it
allows cross-device copy by default. After this work, cifs copy offload
should be possible between two shares on the same server, but I did not
check this functionality.

Patches 1-3 have your Reviewed-by.
Patches 4-5 have been slightly amended to address your comments.
Patch 6 adds the new helper you requested dubbed file_modified().
Patch 7 uses the helper in xfs - unrelated to copy_file_range().
Patches 8-12 use the helper for various fs's ->copy_file_range().
Patch 13 (unmodified) has your Reviewed-by, because the bits that
you approved are those that matter to most filesystems (i.e. the
fallback logic).

The man page update patch (again, mostly Dave's work) is appended
to the series with fixes to your review comments.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20190526061100.21761-1-amir73il@gmail.com/

Changes since v2:
- Re-order generic_remap_checks() fix patch before
  forking generic_copy_file_checks()
- Document @req_count helper argument (Darrick)
- Fold generic_access_check_limits() (Darrick)
- Added file_modified() helper (Darrick)
- Added xfs patch to use file_modified() helper
- Drop generic_copy_file_range_prep() helper
- Per filesystem patch for file_modified()/file_accessed()
- Post copy file_remove_privs() for ceph/generic (Darrick)

Changes since v1:
- Short read instead of EINVAL (Christoph)
- generic_file_rw_checks() helper (Darrick)
- generic_copy_file_range_prep() helper (Christoph)
- Not calling ->remap_file_range() with different sb
- Not calling ->copy_file_range() with different fs type
- Remove changes to overlayfs
- Extra fix to clone/dedupe checks

Amir Goldstein (11):
  vfs: introduce generic_file_rw_checks()
  vfs: remove redundant checks from generic_remap_checks()
  vfs: add missing checks to copy_file_range
  vfs: introduce file_modified() helper
  xfs: use file_modified() helper
  vfs: copy_file_range needs to strip setuid bits and update timestamps
  ceph: copy_file_range needs to strip setuid bits and update timestamps
  cifs: copy_file_range needs to strip setuid bits and update timestamps
  fuse: copy_file_range needs to strip setuid bits and update timestamps
  nfs: copy_file_range needs to strip setuid bits and update timestamps
  vfs: allow copy_file_range to copy across devices

Dave Chinner (2):
  vfs: introduce generic_copy_file_range()
  vfs: no fallback for ->copy_file_range

 fs/ceph/file.c     |  40 ++++++++++++-
 fs/cifs/cifsfs.c   |  15 ++++-
 fs/fuse/file.c     |  29 ++++++++-
 fs/inode.c         |  20 +++++++
 fs/nfs/nfs42proc.c |   9 ++-
 fs/nfs/nfs4file.c  |  23 ++++++-
 fs/read_write.c    | 145 ++++++++++++++++++++++++++++-----------------
 fs/xfs/xfs_file.c  |  15 +----
 include/linux/fs.h |   9 +++
 mm/filemap.c       | 110 +++++++++++++++++++++++++++-------
 10 files changed, 309 insertions(+), 106 deletions(-)

-- 
2.17.1

