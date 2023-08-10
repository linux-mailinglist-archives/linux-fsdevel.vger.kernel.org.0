Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B82077764E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 12:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbjHJKzx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 06:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjHJKzw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:55:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E24F1BD9
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 03:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691664906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4a8siX/+wG3hq5xMXYUTtdAS457pJBY6Lm5dQtPSVgg=;
        b=Zs2FE5thrnnWRcwMgFKor4IX2iIpzo45nGmR5KJh+wiYGj6P9Qqne5TFWOZuTjylvjUxpG
        xa+6nRfGEurUAB2WQI6NjiDiFhqx/oi3uoeo5WwQJMcjrjfnPtVa3vWqDvBAwknLRZMFjq
        8XDc5eho66NiXcLcQJQ2MSJwKp86sfM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-ZLKAY-nzO0u_Bs2cbQoBPw-1; Thu, 10 Aug 2023 06:55:05 -0400
X-MC-Unique: ZLKAY-nzO0u_Bs2cbQoBPw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5238ef044e5so329959a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 03:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691664903; x=1692269703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4a8siX/+wG3hq5xMXYUTtdAS457pJBY6Lm5dQtPSVgg=;
        b=gMu6kERgPKF6EVzIQEqUkPrp02d0GIuiKMtrIqmXHawUqYhHniBocFT3ZOshVprGs9
         l+lElJPI8dtWRA+VfMEBS+l6ViYiaO0TxozXbu+0pHUCzMJGxC8Lz/KNPZ84LfJAQOMN
         TqJ9W0roqVL+IO/zCjekmiG6BtUTxJUQz8pkA56G/KGhf/sztgY6ldfol/fyXFeyK6gO
         PqE4g5bLeGATrrU6gVYtLNBau7gSIUzsiyQQbRnj3HZZWtGnX9VCRh5OJVki2nnH+q4Q
         ecILPa/v9l1gnhFNl9o1GfQk00pZcAkdRmKb/MytqUsMfggPTOX1X//YhgrHotWb9qF7
         sC/g==
X-Gm-Message-State: AOJu0YwZADve/2M//FlvVQMYwe+08i3QxCoGKBQ+BwwjQwzf+uc5kW76
        EKRQNyCD+80G0SKd99tm0lMLyKSdONYlQ0xo6iKdWN6q4HTTVlafPdt9HthgIeqAdEHT8SxUGtX
        29bZoZgL6ay7mfKr9xmQFeGQ0+ed/XO/8+d82MWdn/f87FrXvMHmY10AVNmby8AmJb6EO4QyP2c
        uALQ9O8Cq7cg==
X-Received: by 2002:a05:6402:14c4:b0:523:17ad:c7d4 with SMTP id f4-20020a05640214c400b0052317adc7d4mr1373084edx.39.1691664903544;
        Thu, 10 Aug 2023 03:55:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2CgzHfrZbf928tdPueRGDTU7wer9UrgPm1hDgB+HgjtqHqJ4UTB3TbvG0c3UMZT8dZ1pmcg==
X-Received: by 2002:a05:6402:14c4:b0:523:17ad:c7d4 with SMTP id f4-20020a05640214c400b0052317adc7d4mr1373069edx.39.1691664903209;
        Thu, 10 Aug 2023 03:55:03 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-246-142.pool.digikabel.hu. [193.226.246.142])
        by smtp.gmail.com with ESMTPSA id v20-20020aa7cd54000000b005231f324a0bsm643732edw.28.2023.08.10.03.55.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 03:55:02 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/5] fuse: support birth time
Date:   Thu, 10 Aug 2023 12:54:56 +0200
Message-Id: <20230810105501.1418427-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the infrastructure for btime support in the form of a new STATX
request.

The format of the STATX reply is binary compatible with struct statx on
Linux, but the structure is defined separately in the fuse API for other
OS's.

Currently STATX only supports basic attributes, same as the GETATTR
request, plus btime.  But nothing prevents extending support to other
(present and future) statx fields.

---
Miklos Szeredi (5):
  fuse: handle empty request_mask in statx
  fuse: add STATX request
  fuse: add ATTR_TIMEOUT macro
  fuse: implement statx
  fuse: cache btime

 fs/fuse/dir.c             | 145 +++++++++++++++++++++++++++++++-------
 fs/fuse/fuse_i.h          |  15 +++-
 fs/fuse/inode.c           |  30 ++++++--
 fs/fuse/readdir.c         |   6 +-
 include/uapi/linux/fuse.h |  56 ++++++++++++++-
 5 files changed, 218 insertions(+), 34 deletions(-)

-- 
2.40.1

