Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0623AA0E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 18:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbhFPQLL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 12:11:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50663 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbhFPQLK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623859744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=n/BEHfEuV5E/ENeWXxNnAnWNEJlsEsSQXbuX7kP6iyU=;
        b=ZFttEBdkao3Ee4Gy1hZ6OMoOyMH+CQNjjnufok4TPFN+tLpsH86P20vetaVxjFaiSthfOG
        1d4kZ58T5KRCcGcq024bx2gBENyjphPKMWbRAB4w4ewJ8OyGkxlszhPOZNMZpcAe3+nvBg
        m4NJvuNx2zOQLE0+T9Vfq6JVyi41aVw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-iAG7qi-rNxysk3zKGNnIgA-1; Wed, 16 Jun 2021 12:09:01 -0400
X-MC-Unique: iAG7qi-rNxysk3zKGNnIgA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0053A40CF;
        Wed, 16 Jun 2021 16:09:00 +0000 (UTC)
Received: from iangelak.remote.csb (ovpn-113-44.rdu2.redhat.com [10.10.113.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 782775C1C5;
        Wed, 16 Jun 2021 16:08:53 +0000 (UTC)
From:   Ioannis Angelakopoulos <iangelak@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com
Cc:     miklos@szeredi.hu, stefanha@redhat.com, vgoyal@redhat.com
Subject: [PATCH 0/3] Virtiofs: Support for remote blocking posix locks
Date:   Wed, 16 Jun 2021 12:08:33 -0400
Message-Id: <20210616160836.590206-1-iangelak@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adding support for remote blocking locks in virtiofs. Initially linux
only supported the fcntl(SETLK) option. Now the fcntl(SETLKW) option
is also supported.

A guest issuing a fcntl(SETLKW) system call will block if another guest
has already acquired the lock. Once the lock is available then the
blocking guest will receive a notification, through the notification
queue. Then the guest will unblock and acquire the lock.

Vivek Goyal (3):
  virtiofs: Add an index to keep track of first request queue
  virtiofs: Add a virtqueue for notifications
  virtiofs: Support blocking posix locks (fcntl(F_SETLKW))

 fs/fuse/virtio_fs.c            | 290 +++++++++++++++++++++++++++++++--
 include/uapi/linux/fuse.h      |   7 +
 include/uapi/linux/virtio_fs.h |   5 +
 3 files changed, 288 insertions(+), 14 deletions(-)

-- 
2.27.0

