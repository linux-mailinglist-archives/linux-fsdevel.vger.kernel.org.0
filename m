Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD1C5AF6A1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 23:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiIFVJU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 17:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiIFVJT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 17:09:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F533AFAFA
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Sep 2022 14:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662498557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WCO5+s9TYggaCmf9Mqg92lGhKjcPJhftqzaa6O2dwfw=;
        b=cCj8du2BmaclcPQlHgRXt68tyHkF9ychCv+boO7zgeaTXXwqR03FfsXfaURzwpLoLHYUPH
        ipf+DByAxaL17S1b4y+CWuaoWbylku/gI5xsbY0R7da2p/xAI0JrI1PJweKEK4L0Wnel2z
        Y9/h4BY5W7yYko9cuZMf4YpTdVoXDhw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-393-s_ErBx-ENEGZNspZxiSF7Q-1; Tue, 06 Sep 2022 17:09:14 -0400
X-MC-Unique: s_ErBx-ENEGZNspZxiSF7Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2CF073C1068B;
        Tue,  6 Sep 2022 21:09:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F83840CF8ED;
        Tue,  6 Sep 2022 21:09:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, marc.dionne@auristor.com,
        jaltman@auristor.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Return -EAGAIN, not -EREMOTEIO, when a file already locked
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <390.1662498551.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 06 Sep 2022 22:09:11 +0100
Message-ID: <391.1662498551@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Can you apply this please?

Thanks,
David
---
afs: Return -EAGAIN, not -EREMOTEIO, when a file already locked

When trying to get a file lock on an AFS file, the server may return
UAEAGAIN to indicate that the lock is already held.  This is currently
translated by the default path to -EREMOTEIO.  Translate it instead to
-EAGAIN so that we know we can retry it.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeffrey E Altman <jaltman@auristor.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/166075761334.3533338.2591992675160918098.s=
tgit@warthog.procyon.org.uk/
---
 fs/afs/misc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/misc.c b/fs/afs/misc.c
index 933e67fcdab1..805328ca5428 100644
--- a/fs/afs/misc.c
+++ b/fs/afs/misc.c
@@ -69,6 +69,7 @@ int afs_abort_to_error(u32 abort_code)
 		/* Unified AFS error table */
 	case UAEPERM:			return -EPERM;
 	case UAENOENT:			return -ENOENT;
+	case UAEAGAIN:			return -EAGAIN;
 	case UAEACCES:			return -EACCES;
 	case UAEBUSY:			return -EBUSY;
 	case UAEEXIST:			return -EEXIST;

