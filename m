Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B213FAA8B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 11:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbhH2J5Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Aug 2021 05:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhH2J5Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Aug 2021 05:57:24 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26357C061575;
        Sun, 29 Aug 2021 02:56:31 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id f2so20142901ljn.1;
        Sun, 29 Aug 2021 02:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7dy64JCm4INpSzM1TYkFxB4+j6CWHYLWvpVuPYin1b4=;
        b=RtWjFJVSa5qOrZW9iG2JrOrwqnCEKjZu+fBipcNcPQFfxKmoeS/SpkUe6kz3mgChEL
         MUxEjZ0RMYbl5aheIyjbh/GYtZoY9Yu6Y6JgZ2iWoZVB9fRaLwCIdMbD+uRtVit4oHtJ
         zQgMdxsyG+qQqztBuLo5mcf2HCKuoTX2aUV8AqVqXGmI1lNgLRk2kkXGCxoWQufESVYf
         1lIbkYH53XdHS3/1ZgOCWosto56zqZyf8974NL14xa27sAQr3E3gs8cTOgl/G1/u7BSi
         ZDDRSrJZZlkwuUIF39q5kJ0C9dskPeSc6xubhfmHm3EYRge44xX6/JlYWD/Y3zlrIIjs
         0uxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7dy64JCm4INpSzM1TYkFxB4+j6CWHYLWvpVuPYin1b4=;
        b=nfCB0Efxhne4GLUgPLzBzrKG8idXaJVKqcRZtU04+xq9XRUVwBiCWwOwrJBOIXLAjH
         cqk4IcpAFP8gb6mz+2jMhCxPh0UM5EMO/TxNMPxEWEnO4olyz9IJvU7Hb3/ANrY6i0IG
         7MFpSGWKstzmAUNLfXYCpy2v2FxBo7+n4WVoS1+NKFcsS4NGBe85UDpm5r1FdqU3i2SW
         hlLSVxUZ+wFKhB04/cobxuwyEH/bFWYQoJ+OVX0ZXwEnSm3LUrNgQJKuDXLn7Bdku8sT
         JdKR2DUgbn+gLYxtf4nI9V3h0W2I7S0ZfSxBYjXgGGrYO6RcT5Knlm/LtG4bCXIn5rzk
         2ruw==
X-Gm-Message-State: AOAM5334FfZzG8eBfYoxGVBuAuyOjXWB7Tbfog6O4VxB3OyG41OCnhFN
        w/LkNJ8UUflxcR48JzJBEWGWwatRKjMcUg==
X-Google-Smtp-Source: ABdhPJxKmCxSQAzOdeFdxNjx4kUhgBUQ1ddvBNDA8SnKZlaTSMKkuvvbtlJ6JP7kxoaS3gMPKnqNyw==
X-Received: by 2002:a05:651c:113b:: with SMTP id e27mr11513416ljo.6.1630230989518;
        Sun, 29 Aug 2021 02:56:29 -0700 (PDT)
Received: from localhost.localdomain (37-33-245-172.bb.dnainternet.fi. [37.33.245.172])
        by smtp.gmail.com with ESMTPSA id d6sm1090521lfi.57.2021.08.29.02.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 02:56:29 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 0/9] fs/ntfs3: Use new mount api and change some opts
Date:   Sun, 29 Aug 2021 12:56:05 +0300
Message-Id: <20210829095614.50021-1-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

See V2 if you want:
lore.kernel.org/ntfs3/20210819002633.689831-1-kari.argillander@gmail.com

NLS change is now blocked when remounting. Christoph also suggest that
we block all other mount options, but I have tested a couple and they
seem to work. I wish that we do not block any other than NLS because
in theory they should work. Also Konstantin can comment about this.

I have not include reviewed/acked to patch "Use new api for mounting"
because it change so much. I have also included three new patch to this
series:
	- Convert mount options to pointer in sbi
		So that we do not need to initiliaze whole spi in 
		remount.
	- Init spi more in init_fs_context than fill_super
		This is just refactoring. (Series does not depend on this)
	- Show uid/gid always in show_options()
		Christian Brauner kinda ask this. (Series does not depend
		on this)

Series is ones again tested with kvm-xfstests. Every commit is build
tested.

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
  fs/ntfs3: Rename mount option no_acl_rules > (no)acl_rules
  fs/ntfs3: Show uid/gid always in show_options()

 Documentation/filesystems/ntfs3.rst |  10 +-
 fs/ntfs3/attrib.c                   |   2 +-
 fs/ntfs3/dir.c                      |   8 +-
 fs/ntfs3/file.c                     |   4 +-
 fs/ntfs3/inode.c                    |  12 +-
 fs/ntfs3/ntfs_fs.h                  |  26 +-
 fs/ntfs3/super.c                    | 486 +++++++++++++++-------------
 fs/ntfs3/xattr.c                    |   2 +-
 8 files changed, 284 insertions(+), 266 deletions(-)

-- 
2.25.1

