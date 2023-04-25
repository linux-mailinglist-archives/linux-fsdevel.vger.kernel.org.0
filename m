Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6A86EE2D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 15:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbjDYNWg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 09:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbjDYNWe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:22:34 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A43E12C92;
        Tue, 25 Apr 2023 06:22:32 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-2f625d52275so5535311f8f.3;
        Tue, 25 Apr 2023 06:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682428951; x=1685020951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T0ZsjvV/9cbUj7kTIaemNHRLJMoP4XNl0sJ/sTuYTSg=;
        b=dkn+N2B5wcH0Lcy5M8gXSHYefBfOCcCxo/tg2mKIy1AQ/n3hzZGi2vI/C6se4b4Kac
         fQ18mirgXoOSnnfoAo8MwvKfjBErn1T0+ryo42LnOFaaanA47WAQAMJ2IYZ9h99Ahav0
         pZKICcM7FeApW6d3IIqvC8NVq32KfJALP9fDiecSCtqFnMvTSwdDuo0xpaawDlt1FpZb
         TI4yn6mYyIr3nU03Qv/6WOkWq7e4BVWrxHxoYf8DHNhFqTtPI9sODrgTYfNbVNY9L0ya
         CBTivBcvKe60wGexBv7AM6EmJH1XxVid+kOwa4TJJY4eu7UcvZsZSoEc/ZBFZ9hQMPSj
         BJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682428951; x=1685020951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0ZsjvV/9cbUj7kTIaemNHRLJMoP4XNl0sJ/sTuYTSg=;
        b=BtCnmt1aglvi/GHSYBLTAkNEqqeFFIzHKxmktp0u5nKKgO5cntrCEpsngKycAtVT4g
         udAZE8W8q/g+VnAu3hv/3H6lpr0ONlLFihYqEmK7x944h3HI6FeKdcVaLmBWGAHMN3xN
         iEesnk5mxYit5wWwh0wxJGkx/BYthwF/HYFsZ2j2rpw/2APmZftY9Nh8P15oqxDRxXYx
         i/NVoHrZDyF9/xpvgecchGdy8mO/siU7yAzwwxXruO7/FIxZALdTk3g3uJzGmLY6TJEf
         RJ+6yBX8atkJwLSZb//1DVHD2GiayyRGgMagxA96fv6tsNHnbqKRm0eHLZ7wy1kenrm0
         VjwA==
X-Gm-Message-State: AAQBX9ds1nI5Vq1SlhJmUfYoC2gMcmcFDotyKOublNg95d4N06tnM8oC
        NCXqyQk9KTQwcAE2nnoyQo0=
X-Google-Smtp-Source: AKy350alWA9yLJwOppQ3HyTxHoiCc+gT4AlrxDyqOxRxaDLvoqL8TJkjQYnbma9U3QMFtHr9Tpv5Mw==
X-Received: by 2002:adf:ee86:0:b0:2ff:2c39:d06b with SMTP id b6-20020adfee86000000b002ff2c39d06bmr12825210wro.46.1682428950671;
        Tue, 25 Apr 2023 06:22:30 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id f12-20020adfdb4c000000b002f9ff443184sm13076973wrj.24.2023.04.25.06.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 06:22:30 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH 0/3] Prepare for supporting more filesystems with fanotify
Date:   Tue, 25 Apr 2023 16:22:20 +0300
Message-Id: <20230425132223.2608226-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos,

This is the second part of the proposal to support fanotify reporing
file ids on overlayfs.

The first part [1] relaxes the requirements for filesystems to support
reporting events with fid to require only the ->encode_fh() operation.

In this patch set, overlayfs is changed to meet the new requirements
with default overlay configurations (i.e. no need for nfs_export=on).

The overlayfs and vfs/fanotify patch sets are completely independent.
The are both available on my github branch [2] and there is a simple
LTP test variant that tests reporting fid from overlayfs [3].

Patches 2-3 are not really needed to support reporting fanotify events
with fid, because overlayfs already reports a non-zero f_fsid, it's just
not a very good fsid.  So before allowing to report overlayfs fids, I
prefer to fix f_fsid to be more unique.

I went back and forth about this change of behavior (from real fsid to
per-instance fsid) - can we make this change without breaking any
existing workloads? I don't know.

For now, I added a mount option with a very lousy name (uuid=nogen)
as an escape hatch, but I also left a const bool ovl_uuid_gen_def var
that we can wire to a Kconfig/module option if that is desired.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20230425130105.2606684-1-amir73il@gmail.com/
[2] https://github.com/amir73il/linux/commits/exportfs_encode_fid
[3] https://github.com/amir73il/ltp/commits/exportfs_encode_fid

Amir Goldstein (3):
  ovl: support encoding non-decodeable file handles
  ovl: report a per-instance f_fsid by default
  ovl: use persistent s_uuid with index=on

 Documentation/filesystems/overlayfs.rst | 10 ++--
 fs/overlayfs/export.c                   | 26 ++++++++---
 fs/overlayfs/inode.c                    |  2 +-
 fs/overlayfs/overlayfs.h                | 10 ++++
 fs/overlayfs/ovl_entry.h                |  3 +-
 fs/overlayfs/super.c                    | 62 ++++++++++++++++++++++---
 fs/overlayfs/util.c                     | 41 ++++++++++++++++
 7 files changed, 135 insertions(+), 19 deletions(-)

-- 
2.34.1

