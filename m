Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1997D621277
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Nov 2022 14:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbiKHNcF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Nov 2022 08:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbiKHNcD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:32:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E2443AEB
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Nov 2022 05:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667914266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wetjxKkRrm9+E5qgVzNgI7+QzQNhg3aa53td2i6Cwss=;
        b=dLBBJ07qf6/stzW5630WqPdh22ty+QrBB/wuTDdS74oFbJ4f7hQJmIzksGW7lIs4wNpjoq
        f1ppSrgMUMRMk2STwniK3k9z5PoXZg6WkKU6Q2FZAKq1jgf/YgbHvHXRrEh45oxrkVcjQ6
        BsXUlN/xxuIR7ozKMeNeigeyYPLUook=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-_qc74EkWNrax99J06F70pA-1; Tue, 08 Nov 2022 08:30:20 -0500
X-MC-Unique: _qc74EkWNrax99J06F70pA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 54659381A72A;
        Tue,  8 Nov 2022 13:30:20 +0000 (UTC)
Received: from ovpn-194-7.brq.redhat.com (ovpn-194-7.brq.redhat.com [10.40.194.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A12A40C6FA3;
        Tue,  8 Nov 2022 13:30:19 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Jan Kara <jack@suse.com>, Eric Sandeen <sandeen@redhat.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] [RFC] shmem: user and group quota support for tmpfs
Date:   Tue,  8 Nov 2022 14:30:08 +0100
Message-Id: <20221108133010.75226-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

people have been asking for quota support in tmpfs many times in the past
mostly to avoid one malicious user, or misbehaving user/program to consume
all of the system memory. This has been partially solved with the size
mount option, but some problems still prevail.

One of the problems is the fact that /dev/shm is still generally unprotected
with this and another is administration overhead of managing multiple tmpfs
mounts and lack of more fine grained control.

Quota support can solve all these problems in a somewhat standard way
people are already familiar with from regular file systems. It can give us
more fine grained control over how much memory user/groups can consume.
Additionally it can also control number of inodes and with special quota
mount options introduced with a second patch we can set global limits
allowing us to replace the size mount option with quota entirely.

Currently the standard userspace quota tools (quota, xfs_quota) are only
using quotactl ioctl which is expecting a block device. I patched quota [1]
and xfs_quota [2] to use quotactl_fd in case we want to run the tools on
mount point directory to work nicely with tmpfs.

The implementation was tested on patched version of xfstests [3].

Thoughts?
-Lukas

[1] https://github.com/lczerner/quota/tree/quotactl_fd_support
[2] https://github.com/lczerner/xfsprogs/tree/quotactl_fd_support
[3] https://github.com/lczerner/xfstests/tree/tmpfs_quota_support

