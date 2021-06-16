Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83F23AA191
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 18:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFPQmz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 12:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhFPQmy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:42:54 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BF1C0617A6
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 09:40:47 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id q25so2646998pfh.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 09:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=epXDcsa+iB2IdU4Gd981bdI+VgdMiEH3uS5c66pfdMk=;
        b=GkLCmFh/vzfPIF7v1q7mJc1wazpBYwrpHlrK8VamLK/tdnFXUDt3Jqpo/4zhnIgkB8
         w2Pa4tHYHF/iTjxBxw7knQzMcGPxxObyF5+9fqOM24ruxemJU2JYyJ4aKfJ6/wO0ElHe
         T6vfoZDbGX45mQjwQTttWWusehKNnlTA3+E6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=epXDcsa+iB2IdU4Gd981bdI+VgdMiEH3uS5c66pfdMk=;
        b=dD5jhN/tiS6brjhx+E5IzeOkmX6EgJzcRf34RYM4H4IS3oBjde6QFmxMzshGBqtPr7
         vkgQCiJkc5piM9g1eAdbhHX7E6eKXRgU7NvTouFT4Knry9xWBWv/nSX8kvVB0WFGw9az
         pywO6TdSgrKCrA0fZf76DYKruQMbgEGjFvFK+JBJGAUSQlCErMweT2yMrgFVFP5ziC6z
         oclLyIRNw+ETgA1oO8L5XD7rIZ9GNeevabJxWO92KZLAjB3xXtauzyjz03d6nuTzT7fa
         fqxOpfFaL26pIRHhD1hw5Ko02BJfiMc3MIHSWSZMNo8/mYKXNPl7GsFgkrNpcDIFH9R7
         rcUA==
X-Gm-Message-State: AOAM5319VzKBZHGIc4xidWtEnn78rJUzm75UtH8nRVqcuKF7Hliu6XdZ
        me/Lt34rLTDKhmJaUy/XPFob8A==
X-Google-Smtp-Source: ABdhPJwSppm5irPLhD/8UhbktXBLwwAA5AGV8driRal8NYsxUQyf0Pz+CGSw19WrD/+6GFIZo7Qt8Q==
X-Received: by 2002:a63:5c04:: with SMTP id q4mr453285pgb.127.1623861647276;
        Wed, 16 Jun 2021 09:40:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c5sm2840547pfn.144.2021.06.16.09.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 09:40:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, gmpy.liaowx@gmail.com,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-doc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 0/5] Use the normal block device I/O path
Date:   Wed, 16 Jun 2021 09:40:38 -0700
Message-Id: <20210616164043.1221861-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This fixes up pstore/blk to avoid touching block internals, and includes
additional fixes and clean-ups.

-Kees

v3:
- split verify_size move into a separate patch
- several changes suggested by hch from the v2 thread
- add reviewed-bys
v2: https://lore.kernel.org/lkml/20210615212121.1200820-1-keescook@chromium.org
v1: https://lore.kernel.org/lkml/20210614200421.2702002-1-keescook@chromium.org

Kees Cook (5):
  pstore/blk: Improve failure reporting
  pstore/blk: Move verify_size() macro out of function
  pstore/blk: Use the normal block device I/O path
  pstore/blk: Fix kerndoc and redundancy on blkdev param
  pstore/blk: Include zone in pstore_device_info

 Documentation/admin-guide/pstore-blk.rst |  14 +-
 drivers/mtd/mtdpstore.c                  |  10 +-
 fs/pstore/blk.c                          | 403 +++++++++--------------
 include/linux/pstore_blk.h               |  27 +-
 4 files changed, 171 insertions(+), 283 deletions(-)

-- 
2.25.1

