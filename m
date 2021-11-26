Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE0445E8E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 08:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345808AbhKZH4Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 02:56:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52839 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245205AbhKZHyX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 02:54:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637913070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=pKrBdACVIJnw8UTyT2VosD/1qF59jead3LdbchpARS0=;
        b=SQsx5VGeakjfeyByuI5AB9+G1Bc4bsp2UA/nLWEHs+VETV/RU/kzoKHXDx7FfKisZr/84m
        vuvExqJg54gFLhCJZg7LiSaTajRDqILiDQeXlhCxUsI3rbV702One31X6s/51YE5ZM/0Dp
        BEWWFw6+TvYDWmEe/cY6zykEK5Kscic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-vl-rd88cMjCx-PcJSkGtmA-1; Fri, 26 Nov 2021 02:51:07 -0500
X-MC-Unique: vl-rd88cMjCx-PcJSkGtmA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05415363A6;
        Fri, 26 Nov 2021 07:51:06 +0000 (UTC)
Received: from work (unknown [10.40.192.244])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DD9D4ABA2;
        Fri, 26 Nov 2021 07:51:04 +0000 (UTC)
Date:   Fri, 26 Nov 2021 08:51:00 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     hughd@google.com, linux-mm@kvack.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: unusual behavior of loop dev with backing file in tmpfs
Message-ID: <20211126075100.gd64odg2bcptiqeb@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I've noticed unusual test failure in e2fsprogs testsuite
(m_assume_storage_prezeroed) where we use mke2fs to create a file system
on loop device backed in file on tmpfs. For some reason sometimes the
resulting file number of allocated blocks (stat -c '%b' /tmp/file) differs,
but it really should not.

I was trying to create a simplified reproducer and noticed the following
behavior on mainline kernel (v5.16-rc2-54-g5d9f4cf36721)

# truncate -s16M /tmp/file
# stat -c '%b' /tmp/file
0

# losetup -f /tmp/file
# stat -c '%b' /tmp/file
672

That alone is a little unexpected since the file is really supposed to
be empty and when copied out of the tmpfs, it really is empty. But the
following is even more weird.

We have a loop setup from above, so let's assume it's /dev/loop0. The
following should be executed in quick succession, like in a script.

# dd if=/dev/zero of=/dev/loop0 bs=4k
# blkdiscard -f /dev/loop0
# stat -c '%b' /tmp/file
0
# sleep 1
# stat -c '%b' /tmp/file
672

Is that expected behavior ? From what I've seen when I use mkfs instead
of this simplified example the number of blocks allocated as reported by
stat can vary a quite a lot given more complex operations. The file itself
does not seem to be corrupted in any way, so it is likely just an
accounting problem.

Any idea what is going on there ?

Thanks!
-Lukas

