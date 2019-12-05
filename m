Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4F19113B6B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 06:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfLEFpQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 00:45:16 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:57774 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbfLEFpQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 00:45:16 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1icjwr-0007sG-8q; Thu, 05 Dec 2019 13:45:09 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1icjwn-0003y8-TT; Thu, 05 Dec 2019 13:45:05 +0800
Date:   Thu, 5 Dec 2019 13:45:05 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     syzbot <syzbot+c2f1558d49e25cc36e5e@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] crypto: af_alg - Use bh_lock_sock in sk_destruct
Message-ID: <20191205054505.wulhkajz64lwwffc@gondor.apana.org.au>
References: <0000000000003e5aa90598ed7415@google.com>
 <f7009e8d-a488-c6df-6875-e872265efec0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7009e8d-a488-c6df-6875-e872265efec0@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 04, 2019 at 08:59:11PM -0800, Eric Dumazet wrote:
>
> crypto layer (hash_sock_destruct()) is called from rcu callback (this in BH context) but tries to grab a socket lock.
> 
> A socket lock can schedule, which is illegal in BH context.

Fair enough.  Although I was rather intrigued as to how the RCU call
occured in the first place.  After some digging my theory is that
this is due to a SO_ATTACH_REUSEPORT_CBPF or SO_ATTACH_REUSEPORT_EBPF
setsockopt on the crypto socket.

What are these filters even suppposed to do on an af_alg socket?

Anyhow, this is a bug that could have been triggered even without
this, but it would have been almost impossible to do it through
syzbot as you need to have an outstanding async skcipher/aead request
that is freed in BH context.

---8<---
As af_alg_release_parent may be called from BH context (most notably
due to an async request that only completes after socket closure,
or as reported here because of an RCU-delayed sk_destruct call), we
must use bh_lock_sock instead of lock_sock.

Reported-by: syzbot+c2f1558d49e25cc36e5e@syzkaller.appspotmail.com
Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
Fixes: c840ac6af3f8 ("crypto: af_alg - Disallow bind/setkey/...")
Cc: <stable@vger.kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 0dceaabc6321..3d8e53010cda 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -134,11 +134,13 @@ void af_alg_release_parent(struct sock *sk)
 	sk = ask->parent;
 	ask = alg_sk(sk);
 
-	lock_sock(sk);
+	local_bh_disable();
+	bh_lock_sock(sk);
 	ask->nokey_refcnt -= nokey;
 	if (!last)
 		last = !--ask->refcnt;
-	release_sock(sk);
+	bh_unlock_sock(sk);
+	local_bh_enable();
 
 	if (last)
 		sock_put(sk);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
