Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9583A6D67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 19:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbhFNRrW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 13:47:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38344 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233643AbhFNRrV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 13:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623692718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SJXA9AEn+G0ZxynctTM6t+9QwrNGEDMN+owDaQzZTPY=;
        b=PEDqulM1Ey6CLsSfZnRzIWtG9E9f4ZkqQJq/nt9UoV2nBfwYQwJc5TfPFzW0vHVA0j/uI3
        1XJSF1slLQ3QjhKkGXa2UJrE/GFIUW79IbMT++XrdISVgUi4FCdqTPE3erMSwXtptyGjqx
        /ivpZ51i6D68nU1TgkBdl5F8YNmNSb8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-cqRUetrsPwGt4IWVIOBmkg-1; Mon, 14 Jun 2021 13:45:15 -0400
X-MC-Unique: cqRUetrsPwGt4IWVIOBmkg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F9E59F92D;
        Mon, 14 Jun 2021 17:45:13 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-174.rdu2.redhat.com [10.10.114.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D491E5C1C2;
        Mon, 14 Jun 2021 17:45:06 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 5C9F422054F; Mon, 14 Jun 2021 13:45:06 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, viro@zeniv.linux.org.uk, dhowells@redhat.com,
        richard.weinberger@gmail.com, hch@infradead.org,
        asmadeus@codewreck.org, v9fs-developer@lists.sourceforge.net
Subject: [PATCH v2 0/2] Add support to boot virtiofs and 9pfs as rootfs
Date:   Mon, 14 Jun 2021 13:44:52 -0400
Message-Id: <20210614174454.903555-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

We want to be able to compile in virtiofs/9pfs in kernel and then
boot kernel and mount virtiofs/9pfs as root filesystem.

Currently there does not seem to be any good way to be able to do
that. There seem to be some hacky ways like prefixing filesystem
tag with "mtd" or naming the filesystem tag as "/dev/root" to
mount viritofs.

Both viritofs and 9pfs have the notion of a "tag" to mount a filesystem
and they take this "tag" as a source argument of the mount. Filesystem
understands how to handle the tag.

Current code already has hooks to mount mtd/ubi/cifs/nfs root
filesystems (apart of regular block based filesystems). So intead
of creating two separate hooks for two filesystems, I have tried
creating a hook for tag based filesystems. And now both the filesystems
benefit from it.

This is generic enough that I think many more use cases might be
able to take advantage of it down the line.

Vivek Goyal (2):
  init/do_mounts.c: Add a path to boot from tag based filesystems
  init/do_mounts.c: Add 9pfs to the list of tag based filesystems

 init/do_mounts.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

-- 
2.25.4

