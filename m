Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12ED434073A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 14:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhCRNwn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 09:52:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23102 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231218AbhCRNw1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616075546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UprCVl9Z9D+zE6R7kV/byYJErag/BNbjRXXDocssQUE=;
        b=N/NwIn9b/c3butQ9KJ7GCeN8KB+Wydowgg5xcfDLrd3/iWYXmNuPa5pSUGILYoOkoQznb0
        +aX8rJ7vr7IufSpyHcbkI2ta4P2LpO4+auC87fLbd7gRttu4kVR1bQAXsLcJ7RmK1+Xi5J
        4yszFdHaQatzdl0MofkTpVcgdlNcoZY=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-cZ3K8e0sPU266lN_RoaPCw-1; Thu, 18 Mar 2021 09:52:25 -0400
X-MC-Unique: cZ3K8e0sPU266lN_RoaPCw-1
Received: by mail-oi1-f200.google.com with SMTP id t16so17442990oie.17
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Mar 2021 06:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UprCVl9Z9D+zE6R7kV/byYJErag/BNbjRXXDocssQUE=;
        b=a25mujiStamaXIPkq2FNHJUEBWjx9TkZDtoBAZjsFamrtoBG5uwMGgGQ5M0ot0Ugf9
         n8L2xFFLmwfxk9QK36jAoCmjvLpWfMr+p/NPHGPjViDXtgQq7+H7WxeJ1p5SxFCrQv2j
         vT8PP7b7o0gZUUBeee5G9zkcV2eQHT1ocqgAswHyc6ed985sS4cRCjBuyyOLBE607aQN
         FpWqL2OTkMk7DQwpZFklb48Dj06Opqxp7lMLceY8CY9CZ6hjpyx86uixXYJoKxy12wyo
         txJfbXj0jNxb3ZE9pbzG3cMQ/EDSJ7R3xtNXhmYSAatmgbot39bCAAqOe4im5ElGVlIR
         s0Pw==
X-Gm-Message-State: AOAM533xpC4H1YJo9bdGai4lu3G4M2eyOgbARi84CgUjguDoLioARYgT
        qdxhFZF9eKd8iARf9UdE1KRf4CDlk/Ma5w8Oe9jTSwZw4pjIZcZpckGGQQLm1fAZlk5Nws66Omv
        HBuvT11pXBS9U0CuhVAbbnYvWtA==
X-Received: by 2002:a4a:a74d:: with SMTP id h13mr7581109oom.50.1616075544555;
        Thu, 18 Mar 2021 06:52:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqQKp9ps6vRkAHFyh5PBk8krVl2W3790JAj4xZcjYW5dNRB7Y9EOHxE69gqTWfJuA7/b3Exw==
X-Received: by 2002:a4a:a74d:: with SMTP id h13mr7581096oom.50.1616075544410;
        Thu, 18 Mar 2021 06:52:24 -0700 (PDT)
Received: from redhat.redhat.com (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
        by smtp.gmail.com with ESMTPSA id i11sm465342otp.76.2021.03.18.06.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 06:52:24 -0700 (PDT)
From:   Connor Kuehl <ckuehl@redhat.com>
To:     virtio-fs@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, stefanha@redhat.com,
        vgoyal@redhat.com, miklos@szeredi.hu, jasowang@redhat.com,
        mst@redhat.com
Subject: [PATCH 0/3] virtiofs: split requests that exceed virtqueue size
Date:   Thu, 18 Mar 2021 08:52:20 -0500
Message-Id: <20210318135223.1342795-1-ckuehl@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I also have a patch in this series that fixes a typo I saw while I was
in there.

For testing, I have been using a toy program that performs a readv or a
writev with a large number of iovecs that exceeds the number of
descriptors available to the virtqueue and observing the number of
scattergather lists generated don't exceed the size of the virtqueue.

Connor Kuehl (3):
  virtio_ring: always warn when descriptor chain exceeds queue size
  virtiofs: split requests that exceed virtqueue size
  fuse: fix typo for fuse_conn.max_pages comment

 drivers/virtio/virtio_ring.c |  7 ++++---
 fs/fuse/fuse_i.h             |  7 ++++++-
 fs/fuse/inode.c              |  7 +++++++
 fs/fuse/virtio_fs.c          | 14 ++++++++++++++
 4 files changed, 31 insertions(+), 4 deletions(-)

-- 
2.30.2

