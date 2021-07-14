Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B57A3C9203
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 22:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbhGNU0o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 16:26:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32155 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235267AbhGNU0m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 16:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626294230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FkQL0/TmGD7gb6xNFLA0sWKjd2e7ZFTezB20AWmdyek=;
        b=TfPv4/dgvJCigQWMS9NiDtvlzu3Ny3kNvdQCaptTifQoDLvgAljHLLcBWthTwApTHQkNhK
        +9twkeNBowE0oYJ3AwgnZI5pTfhX1TDssa5mpntyPJLls24BxD2UZmBmCMu1NBlkEcvVMj
        T7wQO7z/zdBk+mU/6FbEClyyHb+aBXA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-cvqwb-V3NMWwTZbmW1VrgQ-1; Wed, 14 Jul 2021 16:23:49 -0400
X-MC-Unique: cvqwb-V3NMWwTZbmW1VrgQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C93381904A;
        Wed, 14 Jul 2021 20:23:41 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-201.rdu2.redhat.com [10.10.114.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCA0717AE2;
        Wed, 14 Jul 2021 20:23:40 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 5CE9A22021C; Wed, 14 Jul 2021 16:23:40 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, virtio-fs@redhat.com,
        v9fs-developer@lists.sourceforge.net, stefanha@redhat.com,
        miklos@szeredi.hu, Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH v3 0/3] support booting of arbitrary non-blockdevice file systems
Date:   Wed, 14 Jul 2021 16:23:18 -0400
Message-Id: <20210714202321.59729-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This is V3 of patches. Christoph had posted V2 here.

https://lore.kernel.org/linux-fsdevel/20210621062657.3641879-1-hch@lst.de/

There was a small issue in last patch series that list_bdev_fs_names()
did not put an extra '\0' at the end as current callers were expecting.

To fix this, I have modified list_bdev_fs_names() and split_fs_names()
to return number of null terminated strings they have parsed. And
modified callers to use that to loop through strings (instead of
relying on an extra null at the end).

Christoph was finding it hard to find time so I took his patches, 
added my changes in patch3 and reposting the patch series.

I have tested it with 9p, virtiofs and ext4 filesystems as rootfs
and it works for me.

Thanks
Vivek

Christoph Hellwig (3):
  init: split get_fs_names
  init: allow mounting arbitrary non-blockdevice filesystems as root
  fs: simplify get_filesystem_list / get_all_fs_names

 fs/filesystems.c   | 27 ++++++++------
 include/linux/fs.h |  2 +-
 init/do_mounts.c   | 90 +++++++++++++++++++++++++++++++++-------------
 3 files changed, 83 insertions(+), 36 deletions(-)

-- 
2.31.1

