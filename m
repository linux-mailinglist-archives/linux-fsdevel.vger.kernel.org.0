Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73AFF2B7BAF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 11:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgKRKr6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 05:47:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31503 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726249AbgKRKr5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 05:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605696477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=d1ViazE1oJ7ZzrekNrldTatPxa+EknhxU8UIoPVA6q0=;
        b=STp3Ht+R1/3M0HG4Nng1UkPco+thlNJ1VTMX62fK9cOAvKHHiAYa69zYjMQcrnPU77Ak2L
        kSzRLYuh740yozCvDFrR2xASOOhWCd4VxiY3ZX4FfJ8sAUORfBRzkC2tA/J2jSGAnvH9vE
        wtaznxZLR6FzGK7Fz2fy2tPiMd3PFYo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-QPENoFnWNfunk1vroYYsTw-1; Wed, 18 Nov 2020 05:47:54 -0500
X-MC-Unique: QPENoFnWNfunk1vroYYsTw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E76551007B26;
        Wed, 18 Nov 2020 10:47:52 +0000 (UTC)
Received: from lithium.redhat.com (ovpn-113-143.ams2.redhat.com [10.36.113.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1F2960C05;
        Wed, 18 Nov 2020 10:47:50 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     linux-kernel@vger.kernel.org, christian.brauner@ubuntu.com
Cc:     linux@rasmusvillemoes.dk, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org
Subject: [PATCH v3 0/2] fs, close_range: add flag CLOSE_RANGE_CLOEXEC
Date:   Wed, 18 Nov 2020 11:47:44 +0100
Message-Id: <20201118104746.873084-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When the new flag is used, close_range will set the close-on-exec bit
for the file descriptors instead of close()-ing them.

It is useful for e.g. container runtimes that want to minimize the
number of syscalls used after a seccomp profile is installed but want
to keep some fds open until the container process is executed.

v3:
- fixed indentation
- selftests: use ASSERT_EQ instead of EXPECT_EQ for hard failures

v2: https://lkml.kernel.org/lkml/20201019102654.16642-1-gscrivan@redhat.com/
- move close_range(..., CLOSE_RANGE_CLOEXEC) implementation to a separate function.
- use bitmap_set() to set the close-on-exec bits in the bitmap.
- add test with rlimit(RLIMIT_NOFILE) in place.
- use "cur_max" that is already used by close_range(..., 0).

v1: https://lkml.kernel.org/lkml/20201013140609.2269319-1-gscrivan@redhat.com/

Giuseppe Scrivano (2):
  fs, close_range: add flag CLOSE_RANGE_CLOEXEC
  selftests: core: add tests for CLOSE_RANGE_CLOEXEC

 fs/file.c                                     | 44 ++++++++---
 include/uapi/linux/close_range.h              |  3 +
 .../testing/selftests/core/close_range_test.c | 74 +++++++++++++++++++
 3 files changed, 111 insertions(+), 10 deletions(-)

--
2.28.0

