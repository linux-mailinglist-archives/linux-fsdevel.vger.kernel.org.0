Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 035D01A886
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2019 18:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfEKQ5a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 May 2019 12:57:30 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:54210 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbfEKQ5a (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 May 2019 12:57:30 -0400
Received: from chromobil.fritz.box (unknown [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6])
        by mail.stbuehler.de (Postfix) with ESMTPSA id 5DE1BC03030;
        Sat, 11 May 2019 16:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1557593848;
        bh=Sz0IqtVp0zqbISyZSsfHYQ6NljV1iL3lwcnJvx5rZy0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PhlNa/R+jW+U/UqufrFFNRpGK7MjamdVqEKemLD/JCRH5V4Rg/RcmH+W6PFscKlRS
         T05InqtjRBDvMHfFGiVFQOLsAUdNqe+8063wGKatw+kZiPGQkm5ILGchXOkyPRF55V
         aQ48Ry6kOCqMtWfw7WPyyg+ya8v5IJylkT7TKgO4=
From:   =?UTF-8?q?Stefan=20B=C3=BChler?= <source@stbuehler.de>
To:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/5] tcp: handle SPLICE_F_NONBLOCK in tcp_splice_read
Date:   Sat, 11 May 2019 18:57:24 +0200
Message-Id: <20190511165727.31599-2-source@stbuehler.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190511165727.31599-1-source@stbuehler.de>
References: <e2bf63a3-703b-9be2-c171-5dcc1797d2b1@stbuehler.de>
 <20190511165727.31599-1-source@stbuehler.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now both O_NONBLOCK and SPLICE_F_NONBLOCK will trigger non-blocking
behavior.

The spice man page is unclear about the exact semantics:

First it says splice may still block if SPLICE_F_NONBLOCK is set but
O_NONBLOCK isn't.

Then it says it might return EAGAIN if one or the other is set (and on
my debian system it says EAGAIN can only be returned if
SPLICE_F_NONBLOCK was set).

Signed-off-by: Stefan Bühler <source@stbuehler.de>
---
 net/ipv4/tcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 6baa6dc1b13b..65f9917ed8ca 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -784,6 +784,8 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
 	long timeo;
 	ssize_t spliced;
 	int ret;
+	bool noblock = (sock->file->f_flags & O_NONBLOCK) ||
+		       (flags & SPLICE_F_NONBLOCK);
 
 	sock_rps_record_flow(sk);
 	/*
@@ -796,7 +798,7 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
 
 	lock_sock(sk);
 
-	timeo = sock_rcvtimeo(sk, sock->file->f_flags & O_NONBLOCK);
+	timeo = sock_rcvtimeo(sk, noblock);
 	while (tss.len) {
 		ret = __tcp_splice_read(sk, &tss);
 		if (ret < 0)
-- 
2.20.1

