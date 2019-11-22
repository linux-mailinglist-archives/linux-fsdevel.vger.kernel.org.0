Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3A1610685A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 09:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfKVIx2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 03:53:28 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35153 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726248AbfKVIx2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 03:53:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574412807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aLRFhBBORazaUR0+DIMIvvKS9f0zpMfMOhQxEjtVTcM=;
        b=cqHctMX0PjQUuk6Krh7MLduROM1MCO0Rd3kBzo5hCZi8Jocbptxj9pODf1HPwFYzewrJb2
        9M+fel8zhPmTSHVcPPxGvkfJpDIhnMlD1uN64y1Mqqn1wdI81WUR+k2806pwh2AuZW22yU
        rOQaPveawvKujW3MhFjzo2/YQS8/+vg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-k2J0TIsvOvSk7j2yvKgFZQ-1; Fri, 22 Nov 2019 03:53:26 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F76E1005512;
        Fri, 22 Nov 2019 08:53:24 +0000 (UTC)
Received: from orion.redhat.com (unknown [10.40.205.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B4F1608F3;
        Fri, 22 Nov 2019 08:53:22 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de, darrick.wong@oracle.com, sandeen@sandeen.net
Subject: [PATCH 0/5] Refactor ioctl_fibmap() internal interface
Date:   Fri, 22 Nov 2019 09:53:15 +0100
Message-Id: <20191122085320.124560-1-cmaiolino@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: k2J0TIsvOvSk7j2yvKgFZQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This series refactor the internal structure of FIBMAP so that the filesyste=
m can
properly report errors back to VFS, and also simplifies its usage by
standardizing all ->bmap() method usage via bmap() function.

The last patch is a bug fix for ioctl_fibmap() calls with negative block va=
lues.



This patchset is essentially a part of the original series reworking FIEMAP=
 to
also be used for FIBMAP calls.

Due the fact the original series makes too many changes, I decided to split=
 it
into smaller series, so they can be reviewed and applied individually, with
specific purposes, instead of changing everything in a single set. I believ=
e
this makes the review process for this work easier too.

Cheers.

Carlos Maiolino (5):
  fs: Enable bmap() function to properly return errors
  cachefiles: drop direct usage of ->bmap method.
  ecryptfs: drop direct calls to ->bmap
  fibmap: Use bmap instead of ->bmap method in ioctl_fibmap
  fibmap: Reject negative block numbers

 drivers/md/md-bitmap.c | 16 ++++++++++------
 fs/cachefiles/rdwr.c   | 27 ++++++++++++++-------------
 fs/ecryptfs/mmap.c     | 16 ++++++----------
 fs/f2fs/data.c         | 16 +++++++++++-----
 fs/inode.c             | 30 +++++++++++++++++-------------
 fs/ioctl.c             | 32 ++++++++++++++++++++++----------
 fs/jbd2/journal.c      | 22 +++++++++++++++-------
 include/linux/fs.h     |  9 ++++++++-
 mm/page_io.c           | 11 +++++++----
 9 files changed, 110 insertions(+), 69 deletions(-)

--=20
2.23.0

