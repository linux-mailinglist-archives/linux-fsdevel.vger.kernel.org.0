Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B5A7A70A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 04:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjITClU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 22:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjITClT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 22:41:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4274AC6
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 19:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695177628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=U+J1rD224OXQwt6+fApFrG7se4T0Y/Il8Zhj9rlFzBg=;
        b=MN/JJaA1pYmi1xpbLwzP8/NLlNHju9jPGyTsoSVWb5Eb0XPfF/2d5XQV7yMB1MDpkEgq4h
        9fwfgmNnR7wvQm4awbZr5ULKGEXCpmOGQ1ay/0ZL2SxXM+FvT1JKhYsaYzs4vcyq2JkUuG
        9RsB9VX78ZqhRgk7EUUawHj/x7n7w9k=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-vsl9kwJCM_Obh5P87rYPRg-1; Tue, 19 Sep 2023 22:40:26 -0400
X-MC-Unique: vsl9kwJCM_Obh5P87rYPRg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-41219864601so71542751cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 19:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695177624; x=1695782424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+J1rD224OXQwt6+fApFrG7se4T0Y/Il8Zhj9rlFzBg=;
        b=JdiX/fZn8sKnf8jF6pkRY8gdQIyZRy/6QlEoqKKMhFtuWubGIK+Uev21ydqMmo1OEi
         sO6Dae0Kh4eoWD1UP/sFIZzS96dcI9G6ZN4cYkafYqpHrM3I/TDTBGshhdNqAAcceKx0
         iY4ro8mg9DzQ4A7WcZeKDNa/ado+gCBuvimzhZ+o8oPtOd3Una+lE7SSWUrwYXQI9GBZ
         x5IptLizWDijEnBs6PQpVkzqcPIPp47XTbkQIqBzwwK/6PP/yfADHk0cUsTuSJfUOYuh
         QTshHeR88GGaoUz0CFFusUFjHrC5haGsPjUkOfS/4OBRgdGZs+qEZXLjdMB3mhUjkNHx
         mGUA==
X-Gm-Message-State: AOJu0YzcEozBgLxLFI4MYNeDI/rjRLFJ3yt77jycVVsE6umBhWqtDYrn
        EuNRxoJeYgfY9Lhs193HMDbSh/cf17sjZKFdnWaRlLVZLxWeFuLj2vqmjagaqxP01qUcYf3ItSi
        SKIax7ZDiCYsk9HWw0YBeAxVkxmc6d7+vhRq1W+N3zBtf7C2F7/q2vP2/GAzRfb1MLsjLIoBHAH
        VT8fmYZHubUpWY
X-Received: by 2002:a05:622a:15c3:b0:417:99d0:46d1 with SMTP id d3-20020a05622a15c300b0041799d046d1mr1704539qty.14.1695177624231;
        Tue, 19 Sep 2023 19:40:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7qYbnvHi24PszCfpjQId1u4Chb2UdSzW7cVlnoJVvjIq684cHIW2AvK0CIo+HRWx5CpJXsw==
X-Received: by 2002:a05:622a:15c3:b0:417:99d0:46d1 with SMTP id d3-20020a05622a15c300b0041799d046d1mr1704526qty.14.1695177623960;
        Tue, 19 Sep 2023 19:40:23 -0700 (PDT)
Received: from fedora.redhat.com ([2600:4040:7c46:e800:32a2:d966:1af4:8863])
        by smtp.gmail.com with ESMTPSA id j23-20020ac84417000000b0041020e8e261sm4277093qtn.1.2023.09.19.19.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 19:40:22 -0700 (PDT)
From:   Tyler Fanelli <tfanelli@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     mszeredi@redhat.com, gmaglione@redhat.com, hreitz@redhat.com,
        Tyler Fanelli <tfanelli@redhat.com>
Subject: [PATCH 0/2] fuse: Rename DIRECT_IO_{RELAX -> ALLOW_MMAP}
Date:   Tue, 19 Sep 2023 22:39:59 -0400
Message-Id: <20230920024001.493477-1-tfanelli@redhat.com>
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

At the moment, FUSE_INIT's DIRECT_IO_RELAX flag only serves the purpose
of allowing shared mmap of files opened/created with DIRECT_IO enabled.
However, it leaves open the possibility of further relaxing the
DIRECT_IO restrictions (and in-effect, the cache coherency guarantees of
DIRECT_IO) in the future.

The DIRECT_IO_ALLOW_MMAP flag leaves no ambiguity of its purpose. It
only serves to allow shared mmap of DIRECT_IO files, while still
bypassing the cache on regular reads and writes. The shared mmap is the
only loosening of the cache policy that can take place with the flag.
This removes some ambiguity and introduces a more stable flag to be used
in FUSE_INIT. Furthermore, we can document that to allow shared mmap'ing
of DIRECT_IO files, a user must enable DIRECT_IO_ALLOW_MMAP.

Tyler Fanelli (2):
  fs/fuse: Rename DIRECT_IO_RELAX to DIRECT_IO_ALLOW_MMAP
  docs/fuse-io: Document the usage of DIRECT_IO_ALLOW_MMAP

 Documentation/filesystems/fuse-io.rst | 3 ++-
 fs/fuse/file.c                        | 6 +++---
 fs/fuse/fuse_i.h                      | 4 ++--
 fs/fuse/inode.c                       | 6 +++---
 include/uapi/linux/fuse.h             | 7 +++----
 5 files changed, 13 insertions(+), 13 deletions(-)

-- 
2.40.1

