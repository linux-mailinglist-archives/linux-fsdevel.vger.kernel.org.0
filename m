Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958871E8A93
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 00:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgE2WAk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 18:00:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36857 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728360AbgE2WAk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 18:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590789639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=70IZFh5behlXRlJRSzDmC2eijLSegUZJ/U/xqyRcr80=;
        b=aS3gJFcmSQ57fecA4XBbuToULOH3cdYy6QSceFAKrvd8FvMbc+2rgnt5ZtBD0/0r3ztcWE
        +FgR1WAlCdQDgpaVU26DZo6sYwtWxQQCRv806inboEVq9LtpTyxhbIjrf8v6L5O+wKSgdz
        fykfXrw9/+wMaQvDg7GQPLS/6n0551o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-xRgIiA0lNIeErHdBr19dRg-1; Fri, 29 May 2020 18:00:30 -0400
X-MC-Unique: xRgIiA0lNIeErHdBr19dRg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D471218A8221;
        Fri, 29 May 2020 22:00:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16A097B91C;
        Fri, 29 May 2020 22:00:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 03/27] rxrpc: Adjust /proc/net/rxrpc/calls to display
 call->debug_id not user_ID
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 29 May 2020 23:00:23 +0100
Message-ID: <159078962321.679399.13472724526939818025.stgit@warthog.procyon.org.uk>
In-Reply-To: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
References: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The user ID value isn't actually much use - and leaks a kernel pointer or a
userspace value - so replace it with the call debug ID, which appears in trace
points.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/proc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index 8b179e3c802a..543afd9bd664 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -68,7 +68,7 @@ static int rxrpc_call_seq_show(struct seq_file *seq, void *v)
 			 "Proto Local                                          "
 			 " Remote                                         "
 			 " SvID ConnID   CallID   End Use State    Abort   "
-			 " UserID           TxSeq    TW RxSeq    RW RxSerial RxTimo\n");
+			 " DebugId  TxSeq    TW RxSeq    RW RxSerial RxTimo\n");
 		return 0;
 	}
 
@@ -100,7 +100,7 @@ static int rxrpc_call_seq_show(struct seq_file *seq, void *v)
 	rx_hard_ack = READ_ONCE(call->rx_hard_ack);
 	seq_printf(seq,
 		   "UDP   %-47.47s %-47.47s %4x %08x %08x %s %3u"
-		   " %-8.8s %08x %lx %08x %02x %08x %02x %08x %06lx\n",
+		   " %-8.8s %08x %08x %08x %02x %08x %02x %08x %06lx\n",
 		   lbuff,
 		   rbuff,
 		   call->service_id,
@@ -110,7 +110,7 @@ static int rxrpc_call_seq_show(struct seq_file *seq, void *v)
 		   atomic_read(&call->usage),
 		   rxrpc_call_states[call->state],
 		   call->abort_code,
-		   call->user_call_ID,
+		   call->debug_id,
 		   tx_hard_ack, READ_ONCE(call->tx_top) - tx_hard_ack,
 		   rx_hard_ack, READ_ONCE(call->rx_top) - rx_hard_ack,
 		   call->rx_serial,


