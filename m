Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131CF2925C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Oct 2020 12:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgJSK1L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Oct 2020 06:27:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36611 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726599AbgJSK1L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Oct 2020 06:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603103230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jFk5VbhicfU6IQL8Kp5azjg7j7zrM24dueZ68njQ5EQ=;
        b=Q0J/aEE89nsCSaAEvxNLfTCpsV03+mzROsbwCbfs6kLxq5OPWYBqFg3BP6LpYFJgPE0k1V
        CFIoWI+F4AL3+hJOtF75DPY+CGZk/sluDfKgGjy+lyP19hMqGDaniQkepL2keLxzEgkDWm
        yPZj52NFCwWTo0fQYp4gOamzyVLNNB8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-yRWT7b4OMF2ehwEatrA4Gw-1; Mon, 19 Oct 2020 06:27:08 -0400
X-MC-Unique: yRWT7b4OMF2ehwEatrA4Gw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5614F1006704;
        Mon, 19 Oct 2020 10:27:07 +0000 (UTC)
Received: from lithium.redhat.com (ovpn-115-42.ams2.redhat.com [10.36.115.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1910350B44;
        Mon, 19 Oct 2020 10:27:04 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, christian.brauner@ubuntu.com,
        containers@lists.linux-foundation.org
Subject: [PATCH v2 0/2] fs, close_range: add flag CLOSE_RANGE_CLOEXEC
Date:   Mon, 19 Oct 2020 12:26:52 +0200
Message-Id: <20201019102654.16642-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When the new flag is used, close_range will set the close-on-exec bit
for the file descriptors instead of close()-ing them.

It is useful for e.g. container runtimes that want to minimize the
number of syscalls used after a seccomp profile is installed but want
to keep some fds open until the container process is executed.

v1->v2:
* move close_range(..., CLOSE_RANGE_CLOEXEC) implementation to a separate function.
* use bitmap_set() to set the close-on-exec bits in the bitmap.
* add test with rlimit(RLIMIT_NOFILE) in place.
* use "cur_max" that is already used by close_range(..., 0).

Giuseppe Scrivano (2):
  fs, close_range: add flag CLOSE_RANGE_CLOEXEC
  selftests: add tests for CLOSE_RANGE_CLOEXEC

 fs/file.c                                     | 44 ++++++++---
 include/uapi/linux/close_range.h              |  3 +
 .../testing/selftests/core/close_range_test.c | 74 +++++++++++++++++++
 3 files changed, 111 insertions(+), 10 deletions(-)

--
2.26.2

