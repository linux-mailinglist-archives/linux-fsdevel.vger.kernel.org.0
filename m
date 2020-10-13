Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E30E28CFCC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 16:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgJMOGY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 10:06:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35971 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726567AbgJMOGY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602597983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hRhtp39izvKuhb0WGSaB0X6uSAU7cMnTwf7afyntNPA=;
        b=Nmod+Qy5xnTf/vTHk+K95HVagNtMtA1Wr6UK7KH23tK6ZyrxDSNON3wnk299PWhFCVotS+
        qC5APoWpzQbiIDDq9WlZCKXL2UrSZwISFzJ19xUWBJgTZJ7d+WiyPyBnSzX5ibnb/aEGzP
        IQS4+kCfNhbms6IcQhwhc54pqSyYNBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-pZpXX0C6ONurJD2j-iRD0g-1; Tue, 13 Oct 2020 10:06:21 -0400
X-MC-Unique: pZpXX0C6ONurJD2j-iRD0g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CC66108E1A0;
        Tue, 13 Oct 2020 14:06:20 +0000 (UTC)
Received: from lithium.redhat.com (ovpn-112-43.ams2.redhat.com [10.36.112.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76D885C1C2;
        Tue, 13 Oct 2020 14:06:18 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        christian.brauner@ubuntu.com, containers@lists.linux-foundation.org
Subject: [PATCH 0/2] fs, close_range: add flag CLOSE_RANGE_CLOEXEC
Date:   Tue, 13 Oct 2020 16:06:07 +0200
Message-Id: <20201013140609.2269319-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When the new flag is used, close_range will set the close-on-exec bit
for the file descriptors instead of close()-ing them.

It is useful for e.g. container runtimes that want to minimize the
number of syscalls used after a seccomp profile is installed but want
to keep some fds open until the container process is executed.

Giuseppe Scrivano (2):
  fs, close_range: add flag CLOSE_RANGE_CLOEXEC
  selftests: add tests for CLOSE_RANGE_CLOEXEC

 fs/file.c                                     | 56 +++++++++++++------
 include/uapi/linux/close_range.h              |  3 +
 .../testing/selftests/core/close_range_test.c | 44 +++++++++++++++
 3 files changed, 86 insertions(+), 17 deletions(-)

-- 
2.26.2

