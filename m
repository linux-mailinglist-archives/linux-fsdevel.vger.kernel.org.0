Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEFFD114943
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 23:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfLEWaa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 17:30:30 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36891 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727194AbfLEWaa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 17:30:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575585028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=w7E5oF+2cttm86IlVc5CeQ8v5MMj9XUUWT8eYB5XTvc=;
        b=cYrkGVm9d6O8XnC1j+3jk5FbbRkeb4Z7Q+0AaKWO+LTw+d9oA6TFbqZjUp4WCjN/5gbJef
        fsLijeIaho8rXZXvnO7/o68Kw6sReMPbAP2mm186rKJEz0UKRj7jemrS8uf7/o6AKgmEPY
        A6Ri2jJC+UyzcuYt99xY8MqHDO2MIKM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-NP7vG2PUNGuKNWjTY0R3_g-1; Thu, 05 Dec 2019 17:30:25 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B92888024C0;
        Thu,  5 Dec 2019 22:30:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8197A1001901;
        Thu,  5 Dec 2019 22:30:23 +0000 (UTC)
Subject: [PATCH 0/2] pipe: Fixes [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, ebiggers@kernel.org
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 05 Dec 2019 22:30:22 +0000
Message-ID: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: NP7vG2PUNGuKNWjTY0R3_g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Linus, Eric,

Here are a couple of patches to fix bugs syzbot found in the pipe changes:

 (1) An assertion check will sometimes trip when polling a pipe because the
     ring size and indices used are approximate and may be being changed
     simultaneously.

     An equivalent approximate calculation was done previously, but without
     the assertion check, so I've just dropped the check.  To make it
     accurate, the pipe mutex would need to be taken or the spin lock could
     be used - but usage of the spinlock would need to be rolled out into
     splice, iov_iter and other places for that.

 (2) The index mask and the max_usage values cannot be cached across
     pipe_wait() as F_SETPIPE_SZ could have been called during the wait.
     This can cause pipe_write() to break.

David
---
David Howells (2):
      pipe: Remove assertion from pipe_poll()
      pipe: Fix missing mask update after pipe_wait()


 fs/pipe.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

