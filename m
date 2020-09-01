Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720F025A020
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 22:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgIAUlO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 16:41:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39726 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726091AbgIAUlN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 16:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598992872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cxF9BttqqXPreWfRjYQJSPoLifnHtkhSs2UK+cqtlWI=;
        b=UXYwXKUPPZTkr5VLveqe4Oq3/QDD8s9qaXKl8d5b2mtpz8FEIALuAf7f5MKLoZtA//snAP
        y7Sf7Ni+UaZ0cPE2AvIynMCKh36j7YY4nmJgNtQceWCmQSr2ZugDY7KIy4S9aTSXGJg4nl
        wS5xsBQFN1UA20mvt+2k0cl2Q0z7b4w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-4ZAMqRlsOWy4y73t-SUq9A-1; Tue, 01 Sep 2020 16:41:07 -0400
X-MC-Unique: 4ZAMqRlsOWy4y73t-SUq9A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAD661007471;
        Tue,  1 Sep 2020 20:41:04 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-208.rdu2.redhat.com [10.10.116.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B45819C66;
        Tue,  1 Sep 2020 20:40:55 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 3DBFC22053E; Tue,  1 Sep 2020 16:40:55 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        miklos@szeredi.hu
Cc:     vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com
Subject: [RFC PATCH 0/2] fuse: Enable SB_NOSEC if filesystem is not shared
Date:   Tue,  1 Sep 2020 16:40:43 -0400
Message-Id: <20200901204045.1250822-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I want to enable SB_NOSEC in fuse in some form so that performance of
small random writes can be improved. As of now, we call file_remove_privs(),
which results in fuse always sending getxattr(security.capability) to
server to figure out if security.capability has been set on file or not.
If it has been set, it needs to be cleared. This slows down small
random writes tremendously.

I posted couple of proposals in the past here.

Proposal 1:

https://lore.kernel.org/linux-fsdevel/20200716144032.GC422759@redhat.com/

Proposal 2:

https://lore.kernel.org/linux-fsdevel/20200724183812.19573-1-vgoyal@redhat.com/

This is 3rd proposal now. One of the roadblocks in enabling SB_NOSEC
is shared filesystem. It is possible that another client modified the
file data and this client does not know about it. So we might regress
if we don't fetch security.capability always.

So looks like this needs to be handled different for shared filesystems
and non-shared filesystems. non-shared filesystems will be more like
local filesystems where fuse does not expect file data/metadata to
change outside the fuse. And we should be able to enable SB_NOSEC
optimization. This is what this proposal does.

It does not handle the case of shared filesystems. I believe solution
to that will depend on filesystem based on what's the cache coherency
guarantees filesystem provides and what's the cache invalidation 
mechanism it uses.

For now, all filesystems which are not shared can benefit from this
optimization. I am interested in virtiofs which is not shared in
many of the cases. In fact we don't even support shared mode yet. 

Any comments or feedback is welcome.

Thanks
Vivek

Vivek Goyal (2):
  fuse: Add a flag FUSE_NONSHARED_FS
  fuse: Enable SB_NOSEC if filesystem is not shared

 fs/fuse/fuse_i.h          |  3 +++
 fs/fuse/inode.c           | 12 +++++++++++-
 include/uapi/linux/fuse.h |  4 ++++
 3 files changed, 18 insertions(+), 1 deletion(-)

-- 
2.25.4

