Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEF9D7E0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 19:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbfJORqm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 13:46:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34120 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfJORqm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:46:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A7E06412F;
        Tue, 15 Oct 2019 17:46:42 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82B4A60166;
        Tue, 15 Oct 2019 17:46:35 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 138B6220B4B; Tue, 15 Oct 2019 13:46:35 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, chirantan@chromium.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 0/5] virtiofs: Fix couple of deadlocks
Date:   Tue, 15 Oct 2019 13:46:21 -0400
Message-Id: <20191015174626.11593-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 15 Oct 2019 17:46:42 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

We have couple of places which can result in deadlock. This patch series
fixes these.

We can be called with fc->bg_lock (for background requests) while
submitting a request. This leads to two constraints.

- We can't end requests in submitter's context and call fuse_end_request()
  as it tries to take fc->bg_lock as well. So queue these requests on a
  list and use a worker to end these requests.

- If virtqueue is full, we can wait with fc->bg_lock held for queue to
  have space. Worker which is completing the request gets blocked on
  fc->bg_lock as well. And that means requests are not completing, that
  means descriptors are not being freed and that means submitter can't
  make progress. Deadlock. 

  Fix this by punting the requests to a list and retry submission later
  with the help of a worker.

Thanks
Vivek

Vivek Goyal (5):
  virtiofs: Do not end request in submission context
  virtiofs: No need to check fpq->connected state
  virtiofs: Set FR_SENT flag only after request has been sent
  virtiofs: Count pending forgets as in_flight forgets
  virtiofs: Retry request submission from worker context

 fs/fuse/virtio_fs.c | 165 +++++++++++++++++++++++++++++---------------
 1 file changed, 111 insertions(+), 54 deletions(-)

-- 
2.20.1

