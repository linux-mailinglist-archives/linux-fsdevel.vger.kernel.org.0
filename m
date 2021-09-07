Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E37B402BEB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 17:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345366AbhIGPhO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 11:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244911AbhIGPhN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:37:13 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27158C061575;
        Tue,  7 Sep 2021 08:36:07 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id l18so17193695lji.12;
        Tue, 07 Sep 2021 08:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lKjtChchih7HsFrFsp2Wwav0eUYrjghrLF4msDPDeS8=;
        b=Z7UIIsxIMIa8H6JfbbY6X99kkXuF2OoWO5QHpcFh7Ug5SqK7C/S12U5tnpRP42Fv67
         jHzdv0hU9cd1TUi4M9ndZWIwOum6YY8vs6Qxff0ky83Fq17lhSaYtsZsCFOHxIOuuz/C
         sweWUlzy4fZnluGYih2L5NzCIRkSnTSEoFUV7MPkY0NY4BD4AYyLZjq6eLwuix/B3l6Z
         9MS3RmNm/sIHFL8s3oh6qZB63njpW2w45UX9Cc8vKEknUUgpOoF/sPXfCruSMMSy8wZG
         4cTLETk0QXAMEJHALQK/SVkumFqzYMCauDlunt0Kmk3p6YXY3jkmrkIFBxWthgL7AXZE
         RODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lKjtChchih7HsFrFsp2Wwav0eUYrjghrLF4msDPDeS8=;
        b=YPc/6fEYsqgeWnlCxTEOxX3EaiOMfcOS/H/PwNdPoumzO7eJbJR48aXF/CcHivrh2b
         qf/DRXmv8FIhjmI9WLA2Yqj0GJiYZDupN2TsM784fFp3+NcYbHvhEux2Gz0D6BvmTs68
         OFfxkiU4+39/1K+GonMyjDY3eBDVTK/3t53akbzE30WwZmhwBQAC816SaxT+wF1KuuTJ
         oQIzrnyn+lnZ/n5UVRURVS1nR9fE6SQS89h90UUe2RwprkoHb1N7Pk18uQsbg6pz+m1A
         UeGNPmbA4/bFQY6HWqVq9zkwBRzihI7ipdXsZTmmzU3Gn2kgMrHPlndIOPWjKckgSrBs
         3I3w==
X-Gm-Message-State: AOAM53091HRUEXchAHT6+wSMj1SPZfqAyYVlslPrmIcrNlRdnOuolE0O
        d4kLk9jE4trI2wu6Ad/xCWQ=
X-Google-Smtp-Source: ABdhPJzi0tr66ohoRxixztdIhOImTR4jiQLehhI/b3egXBqWdGH9cO59XCULIDxjmwHBvn10eDihYQ==
X-Received: by 2002:a2e:9011:: with SMTP id h17mr15315258ljg.255.1631028965440;
        Tue, 07 Sep 2021 08:36:05 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id p14sm1484458lji.56.2021.09.07.08.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 08:36:04 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v4 0/9] fs/ntfs3: Use new mount api and change some opts
Date:   Tue,  7 Sep 2021 18:35:48 +0300
Message-Id: <20210907153557.144391-1-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

v3 link:
lore.kernel.org/ntfs3/20210829095614.50021-1-kari.argillander@gmail.com

This series will delete unnecessary mount options and rename some.
Also this will convert ntfs3 to use new mount api. In my opinion we
should get this in 5.15 because after that basically we have to have
deprecated flag with new mount options. Let's try to avoid that if
possible.

v4:
	- Rebased top of the current ntfs3/master
	- Rename mount option (no)acs_rules -> (no)acsrules
	- Fix acs commit message acl -> acs (Thank Pali)
v3:
	- Add patch "Convert mount options to pointer in sbi"
	- Add patch "Init spi more in init_fs_context than fill_super"
	- Add patch "Show uid/gid always in show_options"
	- Patch "Use new api for mounting" has make over
	- NLS loading is not anymore possible when remounting
	- show_options() iocharset printing is fixed
	- Delete comment that testing should be done with other
	  mount options.
	- Add reviewed/acked-tags to 1,2,6,8 
	- Rewrite this cover
v2:
	- Rewrite this cover leter
	- Reorder noatime to first patch
	- NLS loading with string
	- Delete default_options function
	- Remove remount flags
	- Rename no_acl_rules mount option
	- Making code cleaner
	- Add comment that mount options should be tested

Kari Argillander (9):
  fs/ntfs3: Remove unnecesarry mount option noatime
  fs/ntfs3: Remove unnecesarry remount flag handling
  fs/ntfs3: Convert mount options to pointer in sbi
  fs/ntfs3: Use new api for mounting
  fs/ntfs3: Init spi more in init_fs_context than fill_super
  fs/ntfs3: Make mount option nohidden more universal
  fs/ntfs3: Add iocharset= mount option as alias for nls=
  fs/ntfs3: Rename mount option no_acs_rules > (no)acsrules
  fs/ntfs3: Show uid/gid always in show_options()

 Documentation/filesystems/ntfs3.rst |  10 +-
 fs/ntfs3/attrib.c                   |   2 +-
 fs/ntfs3/dir.c                      |   8 +-
 fs/ntfs3/file.c                     |   4 +-
 fs/ntfs3/inode.c                    |  12 +-
 fs/ntfs3/ntfs_fs.h                  |  26 +-
 fs/ntfs3/super.c                    | 498 +++++++++++++++-------------
 fs/ntfs3/xattr.c                    |   2 +-
 8 files changed, 290 insertions(+), 272 deletions(-)


base-commit: 2e3a51b59ea26544303e168de8a0479915f09aa3
-- 
2.25.1

