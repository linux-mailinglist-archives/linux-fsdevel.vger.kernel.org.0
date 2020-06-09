Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EACC1F4061
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 18:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbgFIQNd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 12:13:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42326 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731093AbgFIQNc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 12:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591719211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JUGhyhAM3xv/+2IOQidLA1A/yKCzpzQ3bL3njFAMOIs=;
        b=AuCsk62RuvQXn+b/oFfkWd69/W1qb041PlHeWy0vBT4yWK1YgfrfPzyVhjNrt4TxOTZcgs
        CRmUwIKqeXCPk2icuUIex6thgl/mjAibdCqBPMnb2FnmdVevbaCNqlse2F2flY+cGTqOO9
        5D2KyS3uqA9hUlTUWWPHYgUSdlzJP1c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-eumuOTcrNTyyjj6fSpoEKg-1; Tue, 09 Jun 2020 12:13:29 -0400
X-MC-Unique: eumuOTcrNTyyjj6fSpoEKg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E3FB8014D4;
        Tue,  9 Jun 2020 16:13:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-66.rdu2.redhat.com [10.10.114.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6BD81768DA;
        Tue,  9 Jun 2020 16:13:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 3/6] afs: Fix use of BUG()
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Kees Cook <keescook@chromium.org>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 09 Jun 2020 17:13:26 +0100
Message-ID: <159171920664.3038039.18059422273265286162.stgit@warthog.procyon.org.uk>
In-Reply-To: <159171918506.3038039.10915051218779105094.stgit@warthog.procyon.org.uk>
References: <159171918506.3038039.10915051218779105094.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix afs_compare_addrs() to use WARN_ON(1) instead of BUG() and return 1
(ie. srx_a > srx_b).

There's no point trying to put actual error handling in as this should not
occur unless a new transport address type is allowed by AFS.  And even if
it does, in this particular case, it'll just never match unknown types of
addresses.  This BUG() was more of a 'you need to add a case here'
indicator.

Reported-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/vl_alias.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/afs/vl_alias.c b/fs/afs/vl_alias.c
index 093895c49c21..136fc6164e00 100644
--- a/fs/afs/vl_alias.c
+++ b/fs/afs/vl_alias.c
@@ -73,7 +73,8 @@ static int afs_compare_addrs(const struct sockaddr_rxrpc *srx_a,
 	}
 
 	default:
-		BUG();
+		WARN_ON(1);
+		diff = 1;
 	}
 
 out:


