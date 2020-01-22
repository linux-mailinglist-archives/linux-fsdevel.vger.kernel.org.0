Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38D731449D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 03:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgAVCe3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 21:34:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20684 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726407AbgAVCe3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 21:34:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579660468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ErRO2ILuGx1foqM3wdNWLGssNasA98+6VqpX3GGQZMw=;
        b=HqdoC9iF/SmWplGgyZFfI717Dx0NM2jwdmtzOzzw6i2aTU+hnbK1c6j6U4vz9SN1T4munV
        7BWdtt3saolsvdDmaUTvisAr/wC21xx2eMQRi0Tv9RIVSmAyVo07bqo6IaUj8tmspXgZ4a
        KU9q7V2HjqhTUJHXBqwTgGiWzHkAg1Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-Lpm72C6RMaOMGrGLz1RDig-1; Tue, 21 Jan 2020 21:34:23 -0500
X-MC-Unique: Lpm72C6RMaOMGrGLz1RDig-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87B1C1005512;
        Wed, 22 Jan 2020 02:34:22 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-7.rdu2.redhat.com [10.10.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A3BD1A7E4;
        Wed, 22 Jan 2020 02:34:20 +0000 (UTC)
From:   jglisse@redhat.com
To:     lsf-pc@lists.linux-foundation.org
Cc:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Jens Axboe <axboe@kernel.dk>, Benjamin LaHaise <bcrl@kvack.org>
Subject: [LSF/MM/BPF TOPIC] Do not pin pages for various direct-io scheme
Date:   Tue, 21 Jan 2020 18:31:00 -0800
Message-Id: <20200122023100.75226-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>

Direct I/O does pin memory through GUP (get user page) this does
block several mm activities like:
    - compaction
    - numa
    - migration
    ...

It is also troublesome if the pinned pages are actualy file back
pages that migth go under writeback. In which case the page can
not be write protected from direct-io point of view (see various
discussion about recent work on GUP [1]). This does happens for
instance if the virtual memory address use as buffer for read
operation is the outcome of an mmap of a regular file.


With direct-io or aio (asynchronous io) pages are pinned until
syscall completion (which depends on many factors: io size,
block device speed, ...). For io-uring pages can be pinned an
indifinite amount of time.


So i would like to convert direct io code (direct-io, aio and
io-uring) to obey mmu notifier and thus allow memory management
and writeback to work and behave like any other process memory.

For direct-io and aio this mostly gives a way to wait on syscall
completion. For io-uring this means that buffer might need to be
re-validated (ie looking up pages again to get the new set of
pages for the buffer). Impact for io-uring is the delay needed
to lookup new pages or wait on writeback (if necessary). This
would only happens _if_ an invalidation event happens, which it-
self should only happen under memory preissure or for NUMA
activities.

They are ways to minimize the impact (for instance by using the
mmu notifier type to ignore some invalidation cases).


So i would like to discuss all this during LSF, it is mostly a
filesystem discussion with strong tie to mm.


[1] GUP https://lkml.org/lkml/2019/3/8/805 and all subsequent
    discussion.

To: lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Benjamin LaHaise <bcrl@kvack.org>

