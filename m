Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C242FEB2F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 14:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbhAUNKw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 08:10:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54088 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729223AbhAUNEu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:04:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611234202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1Wk8B5MXn6xg0n77dkvsA+bqX6yH65B4udd8ZjJ4krQ=;
        b=gV8Rh5TqFm01MSQX56JSt9g79M4CIUKZxuB8ANkBMrwOobJrF9FOnCf+fF4BenmHKzIoph
        D14vvoZhZEDTaLhZ7ab8IEXAEgsofUpTXVBkjCYvXr1rzYlxb6phELzBqt7Bz/JGVrVq+W
        rjI2KVFdaGW57ljqSIzUOtidSvSnF0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-DHN5VuFxOFS71OcZIaa9og-1; Thu, 21 Jan 2021 08:03:20 -0500
X-MC-Unique: DHN5VuFxOFS71OcZIaa9og-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08C021935780;
        Thu, 21 Jan 2021 13:03:19 +0000 (UTC)
Received: from x1.localdomain (ovpn-115-46.ams2.redhat.com [10.36.115.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16F7E60BF3;
        Thu, 21 Jan 2021 13:03:17 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/4] vboxsf: Add support for the atomic_open directory-inode op
Date:   Thu, 21 Jan 2021 14:03:13 +0100
Message-Id: <20210121130317.146506-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi All,

Opening a new file is done in 2 steps on regular filesystems:

1. Call the create inode-op on the parent-dir to create an inode
to hold the meta-data related to the file.
2. Call the open file-op to get a handle for the file.

vboxsf however does not really use disk-backed inodes because it
is based on passing through file-related system-calls through to
the hypervisor. So both steps translate to an open(2) call being
passed through to the hypervisor. With the handle returned by
the first call immediately being closed again.

Making 2 open calls for a single open(..., O_CREATE, ...) calls
has 2 problems:

a) It is not really efficient.
b) It actually breaks some apps.

An example of b) is doing a git clone inside a vboxsf mount.
When git clone tries to create a tempfile to store the pak
files which is downloading the following happens:

1. vboxsf_dir_mkfile() gets called with a mode of 0444 and succeeds.
2. vboxsf_file_open() gets called with file->f_flags containing
O_RDWR. When the host is a Linux machine this fails because doing
a open(..., O_RDWR) on a file which exists and has mode 0444 results
in an -EPERM error.

This series fixes this by adding support for the atomic_open
directory-inode op.

Hans de Goede (4):
  vboxsf: Honor excl flag to the dir-inode create op
  vboxsf: Make vboxsf_dir_create() return the handle for the created file
  vboxsf: Add vboxsf_[create|release]_sf_handle() helpers
  vboxsf: Add support for the atomic_open directory-inode op

 fs/vboxsf/dir.c    | 76 +++++++++++++++++++++++++++++++++++++++-------
 fs/vboxsf/file.c   | 71 +++++++++++++++++++++++++++----------------
 fs/vboxsf/vfsmod.h |  7 +++++
 3 files changed, 116 insertions(+), 38 deletions(-)

Regards,

Hans

