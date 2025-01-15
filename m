Return-Path: <linux-fsdevel+bounces-39274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E013A120B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 11:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C089F169E66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC841E98E4;
	Wed, 15 Jan 2025 10:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uHdCCXl8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76228248BDE;
	Wed, 15 Jan 2025 10:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736938096; cv=none; b=XtMZqL1TrxwwcSThppHNVPpQiBie1QxNVas4LzAI3GotEwfrZfWW6aLIHdy+fWX4JlA9mBeugNYWTOyEXNO4KyCN062Gk7YOOBP/GJqQdOfyC1GN/9U3wrWyOcvV3xk4GVMaVu4hURC2hjBBCbJpDFKIzHHqdRgo+EggrHLH98M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736938096; c=relaxed/simple;
	bh=DBvTNx5WZ00FXWc9brltJLXVau2q4RNCLcI8SZa5Qr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTPiGHGBckGU7bIYPkyTQtuaZgQoSbsCTaO5lR9kg+tF9S03c0C/AHHWLJFNMgGbdpFHv2jQRAaVRaGdpv7rAeaXUXqvEhgZCjys2ggnM6rQEsW4kqqQyaUfDAaHiFCEngANg6mYarm/LXedBME36rh/mvdvdEi87Q3YJ+xCuz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uHdCCXl8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70D5C4CEDF;
	Wed, 15 Jan 2025 10:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736938096;
	bh=DBvTNx5WZ00FXWc9brltJLXVau2q4RNCLcI8SZa5Qr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uHdCCXl83FVzNp7SO/AWWJBLB9tYjocOMrmu5G6n+qZkkrgn6pig5VdRQBfu9jcVB
	 7PtwjxPesdpxs5Ca9Fn/8FLUcj3YO1ZshPejya6QGclHWGvK0aWhnEey5EcEOyaDnH
	 xOcllnN4lT4G/Q46TXkRdLi3pPv58aJY9QZO3j8w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nicolas Baranger <nicolas.baranger@3xo.fr>,
	David Howells <dhowells@redhat.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	Steve French <smfrench@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 081/189] netfs: Fix kernel async DIO
Date: Wed, 15 Jan 2025 11:36:17 +0100
Message-ID: <20250115103609.579059069@linuxfoundation.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115103606.357764746@linuxfoundation.org>
References: <20250115103606.357764746@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 3f6bc9e3ab9b127171d39f9ac6eca1abb693b731 ]

Netfslib needs to be able to handle kernel-initiated asynchronous DIO that
is supplied with a bio_vec[] array.  Currently, because of the async flag,
this gets passed to netfs_extract_user_iter() which throws a warning and
fails because it only handles IOVEC and UBUF iterators.  This can be
triggered through a combination of cifs and a loopback blockdev with
something like:

        mount //my/cifs/share /foo
        dd if=/dev/zero of=/foo/m0 bs=4K count=1K
        losetup --sector-size 4096 --direct-io=on /dev/loop2046 /foo/m0
        echo hello >/dev/loop2046

This causes the following to appear in syslog:

        WARNING: CPU: 2 PID: 109 at fs/netfs/iterator.c:50 netfs_extract_user_iter+0x170/0x250 [netfs]

and the write to fail.

Fix this by removing the check in netfs_unbuffered_write_iter_locked() that
causes async kernel DIO writes to be handled as userspace writes.  Note
that this change relies on the kernel caller maintaining the existence of
the bio_vec array (or kvec[] or folio_queue) until the op is complete.

Fixes: 153a9961b551 ("netfs: Implement unbuffered/DIO write support")
Reported-by: Nicolas Baranger <nicolas.baranger@3xo.fr>
Closes: https://lore.kernel.org/r/fedd8a40d54b2969097ffa4507979858@3xo.fr/
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/608725.1736275167@warthog.procyon.org.uk
Tested-by: Nicolas Baranger <nicolas.baranger@3xo.fr>
Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
cc: Steve French <smfrench@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/direct_write.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index 88f2adfab75e..26cf9c94deeb 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -67,7 +67,7 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 		 * allocate a sufficiently large bvec array and may shorten the
 		 * request.
 		 */
-		if (async || user_backed_iter(iter)) {
+		if (user_backed_iter(iter)) {
 			n = netfs_extract_user_iter(iter, len, &wreq->iter, 0);
 			if (n < 0) {
 				ret = n;
@@ -77,6 +77,11 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 			wreq->direct_bv_count = n;
 			wreq->direct_bv_unpin = iov_iter_extract_will_pin(iter);
 		} else {
+			/* If this is a kernel-generated async DIO request,
+			 * assume that any resources the iterator points to
+			 * (eg. a bio_vec array) will persist till the end of
+			 * the op.
+			 */
 			wreq->iter = *iter;
 		}
 
-- 
2.39.5




