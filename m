Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D339FE6A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 21:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfKOU5Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 15:57:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25944 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726550AbfKOU5Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 15:57:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573851443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dtdHS3hNTi80U2lS2ee30H71MuBUQr4CKOdjoMCLxHw=;
        b=D9ttZUjFDyXlJJ788NHnIwfFqdxk4YpFtjbSyi2iAO3xiS06bVe9Zk5zZVGlJOxR5jT4qQ
        WJ7F+TYSHUfBYQ3MAmlr23wRiy0rOFf2Y+EuSHjk+UlMB6QS4mBo62UvwvAIrW7Dfe5LGR
        1QPoUYh9503kuFIW/nC9cS0rrwsf1MY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-dPLdeRlwNHqUMrx2aGfu2A-1; Fri, 15 Nov 2019 15:57:21 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 829861005502;
        Fri, 15 Nov 2019 20:57:20 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FECD28DF4;
        Fri, 15 Nov 2019 20:57:15 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9D71E220C26; Fri, 15 Nov 2019 15:57:14 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     virtio-fs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        miklos@szeredi.hu
Subject: [PATCH 0/4] [RFC] virtiofs: Add a notification queue
Date:   Fri, 15 Nov 2019 15:57:01 -0500
Message-Id: <20191115205705.2046-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: dPLdeRlwNHqUMrx2aGfu2A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

These are RFC patches for adding a notification queue to allow sending
notifications from host to guest.

It also adds support for blocking remote posix locks using the newly
introduced notification queue.

These patches apply on top of 5.4-rc8 plus following patch series I had
posted a while back.

https://lkml.org/lkml/2019/10/30/493

These changes require virtio spec changes as well. I have yet to do
that.

Thanks
Vivek

Vivek Goyal (4):
  virtiofs: Provide a helper function for virtqueue initialization
  virtiofs: Add an index to keep track of first request queue
  virtiofs: Add a virtqueue for notifications
  virtiofs: Support blocking posix locks (fcntl(F_SETLKW))

 fs/fuse/virtio_fs.c            | 328 ++++++++++++++++++++++++++++++---
 include/uapi/linux/fuse.h      |   7 +
 include/uapi/linux/virtio_fs.h |   5 +
 3 files changed, 310 insertions(+), 30 deletions(-)

--=20
2.20.1

