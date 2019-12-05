Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 232181145C8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 18:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbfLERVn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 12:21:43 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51749 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726028AbfLERVn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:21:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575566502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+gkrYl+7ULjoSpPL6Q/x2InLLIXxBTOiz5Yf3FnZWEI=;
        b=RXZ3ELzjixWjtkau7KuYC/6Pm5FMesROAA9QVGfAmC93rIRiQ/Jjq5af2AM/8GvvQmQQdx
        hgz230RBuJXJuriEZBR15oI5Tdi1GR/OCjvaNEbIiPW2ZvcD88YaFumWTEWjkXcwJl04J+
        pM44vQhEQo2VbwQooM/ILf9t4X8CiL0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-3M82R59APhuJfwjna_O9SQ-1; Thu, 05 Dec 2019 12:21:39 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF7B5800D54;
        Thu,  5 Dec 2019 17:21:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFC5610013A1;
        Thu,  5 Dec 2019 17:21:36 +0000 (UTC)
Subject: [PATCH 0/2] pipe: Fixes
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, ebiggers@kernel.org
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 05 Dec 2019 17:21:36 +0000
Message-ID: <157556649610.20869.8537079649495343567.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 3M82R59APhuJfwjna_O9SQ-1
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

 (2) The index mask and the max_usage values need to be regenerated after
     dropping the locks to wait in pipe_write() as F_SETPIPE_SZ could have
     been called during the wait.

David
---
David Howells (2):
      pipe: Remove assertion from pipe_poll()
      pipe: Fix missing mask update after pipe_wait()


 fs/pipe.c |    3 +++
 1 file changed, 3 insertions(+)

