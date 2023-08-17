Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32EE77F871
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 16:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351748AbjHQONv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 10:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351751AbjHQONo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:13:44 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA6D19A1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:13:43 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe9c20f449so42860575e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692281621; x=1692886421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QVHWjix6tag3gdjHBnAcTfGpW9o6RQ613+06RP/dwe0=;
        b=loLLZ+B7VThk6yizXOcsjYRSRuvCSIAvNA78QrQJvlh4CLvEsHft82mawBiQjrRZBI
         +V5zJDfpzkakkKS//9spgnsFMaCGji8hzKpAcHBTR1PhgnBnxd88D9aFn9YUA1ZiO/8B
         8vr4phzT/6kDMz/ZBMRlLeYYmnBDulGmS8thiIBVURGw/MspHcnSSqGaODjQNz/9Ux92
         P2rbXt8fGMnIFWf9IkKoI9L5iTzOGLR/6kXvguHjPF/MvxIGp/KyUagIHzvJYrQmg5d/
         /jq62id/XYamHldtra2u6+eCBllGM//IfXWlKxw7wvMItm8JOeV1GIpD0Ts8LWA3qS8Q
         pTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692281621; x=1692886421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVHWjix6tag3gdjHBnAcTfGpW9o6RQ613+06RP/dwe0=;
        b=ZuTQ1AAM3RhkzrKxMmmo959TstrMSKhgQWMXkDKZuwhwub1h7iEFIbtTqPmBlshMS3
         OE3Y1EFOCU1IbEay9kwdf4VfgcNOqpHyIl1HEON10B4lI6m6Eye1wyWjmy1NuvxHA/Cm
         U8G1pzhS233f+5OKidliymuESX4JTafx8QNMWoEMd6odieh6/THp6eQQ389TdVzO0+Ak
         UherhmWLiNOMcutjl+CsZq6TMK6xYNi7dT1l3NtXMGZ7+pJMKGWkvWX3mZ6ysdRDoxn6
         pf90plZM+D1khaxk6qJHpRHFAP6j0FUI9Yqo1NGEXqS2t905xAljyVk/iErvBPBq3zSr
         xiYQ==
X-Gm-Message-State: AOJu0YzE0jtdlpaZUXo2PwbqjL7GCKeL9d3LYBssyb7bszSxqD/iLk/A
        Ku1su4qNhxH6uostCetAHNP13iQL7fc=
X-Google-Smtp-Source: AGHT+IEYI54htVaPcgyojzOAn4CK3h4Pi9nV1hM2cNuANy7KNiTZQFx5InO6om7bKkMSxBUzYD9tSA==
X-Received: by 2002:a1c:4c17:0:b0:3fb:a62d:1992 with SMTP id z23-20020a1c4c17000000b003fba62d1992mr3675698wmf.0.1692281621191;
        Thu, 17 Aug 2023 07:13:41 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id m12-20020a7bca4c000000b003fe2120ad0bsm3080605wml.41.2023.08.17.07.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 07:13:40 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 0/7] kiocb_{start,end}_write() helpers
Date:   Thu, 17 Aug 2023 17:13:30 +0300
Message-Id: <20230817141337.1025891-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian,

This is an attempt to consolidate the open coded lockdep fooling in
all those async io submitters into a single helper.
The idea to do that consolidation was suggested by Jan.

This re-factoring is part of a larger vfs cleanup I am doing for
fanotify permission events.  The complete series is not ready for
prime time yet, but this one patch is independent and I would love
to get it reviewed/merged a head of the rest.

This v3 series addresses the review comments of Jens on v2 [1].

Thanks,
Amir.

Changes since v2:
- Split patches to helpers and use helpers per caller (Jens)
- Drop IOCB_WRITE_STARTED flag

Changes since v1:
- Leave ISREG checks in callers (Jens)
- Leave setting IOCB_WRITE flag in callers

[1] https://lore.kernel.org/linux-fsdevel/20230816085439.894112-1-amir73il@gmail.com/

Amir Goldstein (7):
  io_uring: rename kiocb_end_write() local helper
  fs: add kerneldoc to file_{start,end}_write() helpers
  fs: create kiocb_{start,end}_write() helpers
  io_uring: use kiocb_{start,end}_write() helpers
  aio: use kiocb_{start,end}_write() helpers
  ovl: use kiocb_{start,end}_write() helpers
  cachefiles: use kiocb_{start,end}_write() helpers

 fs/aio.c            | 20 +++---------------
 fs/cachefiles/io.c  | 16 +++-----------
 fs/overlayfs/file.c | 10 ++-------
 include/linux/fs.h  | 51 ++++++++++++++++++++++++++++++++++++++++++++-
 io_uring/rw.c       | 33 ++++++++---------------------
 5 files changed, 67 insertions(+), 63 deletions(-)

-- 
2.34.1

