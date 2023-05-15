Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4631770370B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 19:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243925AbjEORQ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 13:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243764AbjEORP4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 13:15:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED203100F3;
        Mon, 15 May 2023 10:14:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59B6F62BBB;
        Mon, 15 May 2023 17:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179D0C433EF;
        Mon, 15 May 2023 17:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170883;
        bh=4jSls9SEgL+5agkw266mNjGCuZcNspC+bOyWIa1yb6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jRYAjJ608jjjiUSdRUie7QQOp8sksSyc0lYCe+rMnhsYqNmfqaPJaGwYKFqEaNJwD
         Jix+TYhDkHwYlLIEBLWepcRRm2q4KLrkXmoOUlbz5/mSeQlv11/SJIfV95hHYubpxN
         TYN3I+WedvJaQTxke0ZPSFnlCr60Ti+e6XNpZehg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+ebc945fdb4acd72cba78@syzkaller.appspotmail.com,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 031/242] rxrpc: Fix potential data race in rxrpc_wait_to_be_connected()
Date:   Mon, 15 May 2023 18:25:57 +0200
Message-Id: <20230515161722.857279092@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit 2b5fdc0f5caa505afe34d608e2eefadadf2ee67a ]

Inside the loop in rxrpc_wait_to_be_connected() it checks call->error to
see if it should exit the loop without first checking the call state.  This
is probably safe as if call->error is set, the call is dead anyway, but we
should probably wait for the call state to have been set to completion
first, lest it cause surprise on the way out.

Fix this by only accessing call->error if the call is complete.  We don't
actually need to access the error inside the loop as we'll do that after.

This caused the following report:

    BUG: KCSAN: data-race in rxrpc_send_data / rxrpc_set_call_completion

    write to 0xffff888159cf3c50 of 4 bytes by task 25673 on cpu 1:
     rxrpc_set_call_completion+0x71/0x1c0 net/rxrpc/call_state.c:22
     rxrpc_send_data_packet+0xba9/0x1650 net/rxrpc/output.c:479
     rxrpc_transmit_one+0x1e/0x130 net/rxrpc/output.c:714
     rxrpc_decant_prepared_tx net/rxrpc/call_event.c:326 [inline]
     rxrpc_transmit_some_data+0x496/0x600 net/rxrpc/call_event.c:350
     rxrpc_input_call_event+0x564/0x1220 net/rxrpc/call_event.c:464
     rxrpc_io_thread+0x307/0x1d80 net/rxrpc/io_thread.c:461
     kthread+0x1ac/0x1e0 kernel/kthread.c:376
     ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

    read to 0xffff888159cf3c50 of 4 bytes by task 25672 on cpu 0:
     rxrpc_send_data+0x29e/0x1950 net/rxrpc/sendmsg.c:296
     rxrpc_do_sendmsg+0xb7a/0xc20 net/rxrpc/sendmsg.c:726
     rxrpc_sendmsg+0x413/0x520 net/rxrpc/af_rxrpc.c:565
     sock_sendmsg_nosec net/socket.c:724 [inline]
     sock_sendmsg net/socket.c:747 [inline]
     ____sys_sendmsg+0x375/0x4c0 net/socket.c:2501
     ___sys_sendmsg net/socket.c:2555 [inline]
     __sys_sendmmsg+0x263/0x500 net/socket.c:2641
     __do_sys_sendmmsg net/socket.c:2670 [inline]
     __se_sys_sendmmsg net/socket.c:2667 [inline]
     __x64_sys_sendmmsg+0x57/0x60 net/socket.c:2667
     do_syscall_x64 arch/x86/entry/common.c:50 [inline]
     do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
     entry_SYSCALL_64_after_hwframe+0x63/0xcd

    value changed: 0x00000000 -> 0xffffffea

Fixes: 9d35d880e0e4 ("rxrpc: Move client call connection to the I/O thread")
Reported-by: syzbot+ebc945fdb4acd72cba78@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/000000000000e7c6d205fa10a3cd@google.com/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Dmitry Vyukov <dvyukov@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
cc: netdev@vger.kernel.org
Link: https://lore.kernel.org/r/508133.1682427395@warthog.procyon.org.uk
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/sendmsg.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index da49fcf1c4567..6caa47d352ed6 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -50,15 +50,11 @@ static int rxrpc_wait_to_be_connected(struct rxrpc_call *call, long *timeo)
 	_enter("%d", call->debug_id);
 
 	if (rxrpc_call_state(call) != RXRPC_CALL_CLIENT_AWAIT_CONN)
-		return call->error;
+		goto no_wait;
 
 	add_wait_queue_exclusive(&call->waitq, &myself);
 
 	for (;;) {
-		ret = call->error;
-		if (ret < 0)
-			break;
-
 		switch (call->interruptibility) {
 		case RXRPC_INTERRUPTIBLE:
 		case RXRPC_PREINTERRUPTIBLE:
@@ -69,10 +65,9 @@ static int rxrpc_wait_to_be_connected(struct rxrpc_call *call, long *timeo)
 			set_current_state(TASK_UNINTERRUPTIBLE);
 			break;
 		}
-		if (rxrpc_call_state(call) != RXRPC_CALL_CLIENT_AWAIT_CONN) {
-			ret = call->error;
+
+		if (rxrpc_call_state(call) != RXRPC_CALL_CLIENT_AWAIT_CONN)
 			break;
-		}
 		if ((call->interruptibility == RXRPC_INTERRUPTIBLE ||
 		     call->interruptibility == RXRPC_PREINTERRUPTIBLE) &&
 		    signal_pending(current)) {
@@ -85,6 +80,7 @@ static int rxrpc_wait_to_be_connected(struct rxrpc_call *call, long *timeo)
 	remove_wait_queue(&call->waitq, &myself);
 	__set_current_state(TASK_RUNNING);
 
+no_wait:
 	if (ret == 0 && rxrpc_call_is_complete(call))
 		ret = call->error;
 
-- 
2.39.2



