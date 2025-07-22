Return-Path: <linux-fsdevel+bounces-55690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE67B0DDEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 16:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B70F5827C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 14:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBC92ECD2C;
	Tue, 22 Jul 2025 14:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xTi2UDEU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEBB2ECD06;
	Tue, 22 Jul 2025 14:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193371; cv=none; b=PNsq2pycRuXwWCr7MUK8IB6Y71O9gKkB9WjRa06NgyhKQJ56TALkr3S9gipOVRNMf3P9Os7edjIcq5B9sd3vdUW2eFwvuK99gsZOo0T27Wh1TA76S/JBulaLhVEf/a+m4W0za0Wyob2izpTzLA61tLYdA8itbLBC9fJeKv34kJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193371; c=relaxed/simple;
	bh=Z9qSj0KE84oYYRUfkF3tr8G0dEelpY7HNF4AVG43U3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rratcu+ENFdMvLoXpW6KsXjyiH1rtJe1WP298LmGtuoPH1Z/hU1Aq+UJs4fCrQzbnQr1/Hd/wEQjGZSziPsg9E98qwFRLZfkSU232kZq9l61NBhmGi73OBB3OM77NfFsYaFWNKa3SVkgxR5T8c/xoDQ87PpRhJZIn6m4HQBcj38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xTi2UDEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5597DC4CEEB;
	Tue, 22 Jul 2025 14:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753193370;
	bh=Z9qSj0KE84oYYRUfkF3tr8G0dEelpY7HNF4AVG43U3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xTi2UDEUYZT8TVw+R/R5JK9TJ49vK8C50mVXMklYZrCviE73M8Mx8WgDfMDm0MUSV
	 jVPYGaKKlVMaxEo72tl2BEy7O2Z3nHM6TpPKozbQ9fRy+j4nO6ToqObNffFvGYZCor
	 h86j21M+D7GMJ5mxD7FQ41I8ADD+5GNTj11jXcJc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Max Kellermann <max.kellermann@ionos.com>,
	David Howells <dhowells@redhat.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.15 038/187] netfs: Fix copy-to-cache so that it performs collection with ceph+fscache
Date: Tue, 22 Jul 2025 15:43:28 +0200
Message-ID: <20250722134347.177757976@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134345.761035548@linuxfoundation.org>
References: <20250722134345.761035548@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit 4c238e30774e3022a505fa54311273add7570f13 upstream.

The netfs copy-to-cache that is used by Ceph with local caching sets up a
new request to write data just read to the cache.  The request is started
and then left to look after itself whilst the app continues.  The request
gets notified by the backing fs upon completion of the async DIO write, but
then tries to wake up the app because NETFS_RREQ_OFFLOAD_COLLECTION isn't
set - but the app isn't waiting there, and so the request just hangs.

Fix this by setting NETFS_RREQ_OFFLOAD_COLLECTION which causes the
notification from the backing filesystem to put the collection onto a work
queue instead.

Fixes: e2d46f2ec332 ("netfs: Change the read result collector to only use one work item")
Reported-by: Max Kellermann <max.kellermann@ionos.com>
Link: https://lore.kernel.org/r/CAKPOu+8z_ijTLHdiCYGU_Uk7yYD=shxyGLwfe-L7AV3DhebS3w@mail.gmail.com/
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/20250711151005.2956810-2-dhowells@redhat.com
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: netfs@lists.linux.dev
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/netfs/read_pgpriv2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/netfs/read_pgpriv2.c b/fs/netfs/read_pgpriv2.c
index 5bbe906a551d..080d2a6a51d9 100644
--- a/fs/netfs/read_pgpriv2.c
+++ b/fs/netfs/read_pgpriv2.c
@@ -110,6 +110,7 @@ static struct netfs_io_request *netfs_pgpriv2_begin_copy_to_cache(
 	if (!creq->io_streams[1].avail)
 		goto cancel_put;
 
+	__set_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &creq->flags);
 	trace_netfs_write(creq, netfs_write_trace_copy_to_cache);
 	netfs_stat(&netfs_n_wh_copy_to_cache);
 	rreq->copy_to_cache = creq;
-- 
2.50.1




