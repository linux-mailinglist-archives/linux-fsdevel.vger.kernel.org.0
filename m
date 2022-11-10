Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665B86243E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Nov 2022 15:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiKJONj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Nov 2022 09:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiKJONe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:13:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354E61743E
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Nov 2022 06:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668089561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sG+jutGzOgaFRFm9buFpKva94M9MOYUWoscJc0fFXY0=;
        b=Xpkg+e/LauA4WmM87zAS9S3YpZZNMpoTntd1G3S8m9oRxGxFZKF62UeH9OMsmhgZPmrKso
        QBxBfd2Pf/l6/RB3JvM4RIdOuTevdvKZPOALxznkpQSsFGDnHJvOnpNQR359ZXrfDZ7ldy
        11OkqflMv7ZW4Jv0Q2x9Y/z0t/iyUEA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-oBEUIxlkMK-zTLbNQHjk3g-1; Thu, 10 Nov 2022 09:12:38 -0500
X-MC-Unique: oBEUIxlkMK-zTLbNQHjk3g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76BA5833A0D;
        Thu, 10 Nov 2022 14:12:37 +0000 (UTC)
Received: from localhost (unknown [10.39.208.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 36B1C4EA5A;
        Thu, 10 Nov 2022 14:12:37 +0000 (UTC)
From:   Niels de Vos <ndevos@redhat.com>
To:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
        Marcel Lauhoff <marcel.lauhoff@suse.com>,
        Niels de Vos <ndevos@redhat.com>
Subject: [RFC 0/4] fs: provide per-filesystem options to disable fscrypt
Date:   Thu, 10 Nov 2022 15:12:21 +0100
Message-Id: <20221110141225.2308856-1-ndevos@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While more filesystems are getting support for fscrypt, it is useful to
be able to disable fscrypt for a selection of filesystems, while
enabling it for others.

The new USE_FS_ENCRYPTION define gets picked up in
include/linux/fscrypt.h. This allows filesystems to choose to use the
empty function definitions, or the functional ones when fscrypt is to be
used with the filesystem.

Using USE_FS_ENCRYPTION is a relatively clean approach, and requires
minimal changes to the filesystems supporting fscrypt. This RFC is
mostly for checking the acceptance of this solution, or if an other
direction is preferred.

---

Niels de Vos (4):
  fscrypt: introduce USE_FS_ENCRYPTION
  fs: make fscrypt support an ext4 config option
  fs: make fscrypt support a f2fs config option
  fs: make fscrypt support a UBIFS config option

 Documentation/filesystems/fscrypt.rst |  2 +-
 fs/crypto/Kconfig                     |  3 +++
 fs/crypto/fscrypt_private.h           |  2 ++
 fs/ext4/Kconfig                       | 13 ++++++++++++-
 fs/ext4/Makefile                      |  2 +-
 fs/ext4/ext4.h                        | 12 ++++++++----
 fs/ext4/inode.c                       |  6 +++---
 fs/ext4/namei.c                       |  6 +++---
 fs/ext4/super.c                       |  6 +++---
 fs/ext4/sysfs.c                       |  8 ++++----
 fs/f2fs/Kconfig                       | 15 +++++++++++++--
 fs/f2fs/data.c                        |  2 +-
 fs/f2fs/dir.c                         |  6 +++---
 fs/f2fs/f2fs.h                        |  8 ++++++--
 fs/f2fs/super.c                       |  6 +++---
 fs/f2fs/sysfs.c                       |  8 ++++----
 fs/ubifs/Kconfig                      | 14 ++++++++++++--
 fs/ubifs/Makefile                     |  2 +-
 fs/ubifs/sb.c                         |  4 ++--
 fs/ubifs/ubifs.h                      |  7 +++++--
 include/linux/fscrypt.h               |  6 +++---
 21 files changed, 93 insertions(+), 45 deletions(-)

-- 
2.37.3

