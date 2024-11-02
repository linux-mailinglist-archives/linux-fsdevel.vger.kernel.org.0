Return-Path: <linux-fsdevel+bounces-33530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AEA9B9D25
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 06:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89AB71C2253A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 05:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73071AB513;
	Sat,  2 Nov 2024 05:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hiyyX94I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCDC1534EC;
	Sat,  2 Nov 2024 05:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730524115; cv=none; b=EZ7upngdC1Pbdei0FbpoXRBrrg5Y9CAE/SH3pWts9N6aKQdKn/F3L6+eNyrt7o6v2ZTEwzP3s41BLsw4KHSI3OVHKg3A9+d/805VCHy0947Ot5kxDfNra4vuw9ZR4xo2msjQVdfgatiy7mCfJ/zbXdxctDZlorLQx4VMfmMXRL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730524115; c=relaxed/simple;
	bh=K7vuLbqKFSl91LRqL8eiYFkVC4mjj8brygfD/JtO6wA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8DIgNaePo2NlFn6CI6ZUPHOgVpIk3VUFRb06PSDEtcBVBgQomdiVauowT/0+h3kbu3lK9CX+AfwcZV/Ygkr5P4+5X3Xr5eNa3fHkFNrUd8J1Q3V4Hozx0eEuMeZn6INt9Z0t6a3e35rJFoljdXIUYokeLT6XN2SvMyfdMWS988=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hiyyX94I; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=seW9/calu6of4t1ZXvDYtIn4YZmshNPOyX1IkBzHOrk=; b=hiyyX94IC2O9fFXiR524v2CKhp
	LarpS4weOfQNWbWYCBb1bbP9FWk95H7+yjGLQmARD6pp+hPHGb4zsGx/Cf2CkGUdEhyPOgDcqgt4F
	2iTghAPIojnno1+5YiIteONHw8GPGOMDgSoIhcq/BjvoYb+5r+OWs8NmS8MwPlbL3cL9UswkzNNRl
	XkZqcp2La9S5SBLCS+ZC6qn1obRWDJDSqjdIOHPJcNjipME/d6zC/E1AU0NNh+HsIqhQl3JI322oR
	Bd+lOSMG3aNzHErUTipBP35s+xtmTcpWPzszaPaOYF/+lZ4qRUqJCfyyCDbKdZ6IilgatcPdnSdEv
	J1dFrkTw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t76NC-0000000AHo7-1sbO;
	Sat, 02 Nov 2024 05:08:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH v3 23/28] convert do_select()
Date: Sat,  2 Nov 2024 05:08:21 +0000
Message-ID: <20241102050827.2451599-23-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
References: <20241102050219.GA2450028@ZenIV>
 <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

take the logics from fdget() to fdput() into an inlined helper - with existing
wait_key_set() subsumed into that.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/select.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index a77907faf2b4..b41e2d651cc1 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -462,15 +462,22 @@ static int max_select_fd(unsigned long n, fd_set_bits *fds)
 			 EPOLLNVAL)
 #define POLLEX_SET (EPOLLPRI | EPOLLNVAL)
 
-static inline void wait_key_set(poll_table *wait, unsigned long in,
+static inline __poll_t select_poll_one(int fd, poll_table *wait, unsigned long in,
 				unsigned long out, unsigned long bit,
 				__poll_t ll_flag)
 {
+	CLASS(fd, f)(fd);
+
+	if (fd_empty(f))
+		return EPOLLNVAL;
+
 	wait->_key = POLLEX_SET | ll_flag;
 	if (in & bit)
 		wait->_key |= POLLIN_SET;
 	if (out & bit)
 		wait->_key |= POLLOUT_SET;
+
+	return vfs_poll(fd_file(f), wait);
 }
 
 static noinline_for_stack int do_select(int n, fd_set_bits *fds, struct timespec64 *end_time)
@@ -522,20 +529,12 @@ static noinline_for_stack int do_select(int n, fd_set_bits *fds, struct timespec
 			}
 
 			for (j = 0; j < BITS_PER_LONG; ++j, ++i, bit <<= 1) {
-				struct fd f;
 				if (i >= n)
 					break;
 				if (!(bit & all_bits))
 					continue;
-				mask = EPOLLNVAL;
-				f = fdget(i);
-				if (fd_file(f)) {
-					wait_key_set(wait, in, out, bit,
-						     busy_flag);
-					mask = vfs_poll(fd_file(f), wait);
-
-					fdput(f);
-				}
+				mask = select_poll_one(i, wait, in, out, bit,
+						       busy_flag);
 				if ((mask & POLLIN_SET) && (in & bit)) {
 					res_in |= bit;
 					retval++;
-- 
2.39.5


