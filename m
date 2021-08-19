Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CC43F0F6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 02:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbhHSA1j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 20:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbhHSA1i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 20:27:38 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD9DC061764;
        Wed, 18 Aug 2021 17:27:03 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id x7so8286204ljn.10;
        Wed, 18 Aug 2021 17:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y/98yOBNtI1xJBEJpjGb/cndGYZTpz7GoEKSdog/waY=;
        b=H81ShxiJhGM7J0xTJpm+RBi0m3ipezBJLDSWgy6jbsXnuehZ6u5PmAZ0yp00Y39/Oj
         81XX4wIcPlBrBuikvKtLpHfEDucjYbL3pquvk7zeyI2zRXIeBN35GBtr13i0NEJOQXzL
         ZrJoUndqxTm22o4fOc7PolOnD40wQlbI/DuK/g6Z4rVxc/1CCHEYHVeehIS1LsWBBhIW
         IB1pSUxE5iJeBTdaVFz0j0pfroMpFKKFBMDdq1IFOCbsThHDuO81B0mHJEoMzM7K4foG
         l7WjAJyJzNcLqUEIXWV9+0wyK8vnkVnd6uBAfS+N4D/hrAAcKYYgHnJ37DqK5kgLCpBo
         K+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y/98yOBNtI1xJBEJpjGb/cndGYZTpz7GoEKSdog/waY=;
        b=QvMnXii566OFVPhiihFT0Ki6FX4MkfoAiMZC0IqbxhapRVGxG7XW5Q8g+w+/qVQoZm
         n8eNocO3Lv8Zxy4xqXOR7IyYPUYZLQrGLaG8/9pMZrVENBLX8ks6canNCuyBO1M8c9xr
         UxBntU4OVSXDILm/mtIvH1rHA6+w/c4yNx/Ni3QF9bh9XxOKXH+i0jOagom0drxgBS/W
         f2SCrPfKMml+cSlqq12nNtwfd9mU5gUV/n7+/Xfrx1IfO6SYWUgK5ZwRtGPjg86NlOj4
         VldE6lao2g2xDEJQACQ42i10irkrmEyn055fzxanDR+H4fvRa2+koJatJntRhBuckcp1
         nDLA==
X-Gm-Message-State: AOAM530g6jAQWqxyeF/7fjdfgfubgEzF97MgIpUMmTYc8yJJ0YSIFYNu
        PhxEBtbKULEbJVvTcD3OojE=
X-Google-Smtp-Source: ABdhPJzN3EuV9kS/zU+RlpKGm6fSuXbgG6dkCouQVeYRkddmY+ngdnQLu0lH7Cd4rrdURjhERfRwJw==
X-Received: by 2002:a05:651c:11c7:: with SMTP id z7mr5188076ljo.464.1629332821422;
        Wed, 18 Aug 2021 17:27:01 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id l14sm125907lji.106.2021.08.18.17.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 17:27:00 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 0/6] fs/ntfs3: Use new mount api and change some opts
Date:   Thu, 19 Aug 2021 03:26:27 +0300
Message-Id: <20210819002633.689831-1-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series modify ntfs3 to use new mount api as Christoph Hellwig
wish for. And also it must be done at some point.
lore.kernel.org/linux-fsdevel/20210810090234.GA23732@lst.de/

It also modify mount options noatime (not needed). Make new alias for
nls because kernel is changing to use it as described in here
lore.kernel.org/linux-fsdevel/20210808162453.1653-1-pali@kernel.org/

Modify mount opt no_acl_rules so we can use new mount api feature so
new one is (no)acl_rules. I'm open to suggestion what should we call
this if this is not good.

I did testing some testing and there seems to be unnecesarry remount
flags. Probably copy paste from another driver. Christoph also
suggested that maybe we should not let user remount with every
possible parameter, but for now comment can do. This can be addressed
later imo. Of course we can talk about it and I will do it if we have
solution.

Xfstests also show same errors than before this patch series. We will
of course wait Paragon's results also because they might have some
tests that I cannot yeat run.

Hopefully Konstantin will also comment in some point. And we have to
remember that we do not even have v28 in review process which this is
based on. So no rush to review. I just feeled that this is quite
ready and also that Konstantin can comment newer version so thats why
"already" patch series v2.

Offtopic:
I have also started to make shutdown protocol to ntfs3 driver so that
we can use that somepoint for testing with xfstests. 

v2:
	- Rewrite this cover leter
	- Reorder noatime to first patch
	- NLS loading with string
	- Delete default_options function
	- Remove remount flags
	- Rename no_acl_rules mount option
	- Making code cleaner
	- Add comment that mount options should be tested

Kari Argillander (6):
  fs/ntfs3: Remove unnecesarry mount option noatime
  fs/ntfs3: Remove unnecesarry remount flag handling
  fs/ntfs3: Use new api for mounting
  fs/ntfs3: Make mount option nohidden more universal
  fs/ntfs3: Add iocharset= mount option as alias for nls=
  fs/ntfs3: Rename mount option no_acl_rules > (no)acl_rules

 Documentation/filesystems/ntfs3.rst |  10 +-
 fs/ntfs3/file.c                     |   2 +-
 fs/ntfs3/ntfs_fs.h                  |   3 +-
 fs/ntfs3/super.c                    | 413 ++++++++++++++--------------
 fs/ntfs3/xattr.c                    |   2 +-
 5 files changed, 213 insertions(+), 217 deletions(-)

-- 
2.25.1

