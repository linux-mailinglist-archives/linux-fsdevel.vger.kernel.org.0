Return-Path: <linux-fsdevel+bounces-28136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3189673CF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 00:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F52A1C210B4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 22:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD0F199FC7;
	Sat, 31 Aug 2024 22:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1j9Q7pd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB400199FA6;
	Sat, 31 Aug 2024 22:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725143911; cv=none; b=cPrE6DkZ7uq72vkoXyltfS81kTsJxnOH8XohNiZyV9XN8ablv6utg93b28hR2fmcmH3gwfGp5hu8xzZhLxnt7fPW7272XnTW+opJpOzacrXRppYuyV4WeK53tnU4e1Evv99s7jRgZT7LJMotJASpWM2gDhM/LP80etdGqeoJwr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725143911; c=relaxed/simple;
	bh=5gYKaNb9YNOgingbnDs/WOnab5e9XeuNx3JaLfoNfDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCfSw302DFJ0TZ6/raKKlyrAXDc5Ayxh295aIK6lcu+SwAS2TpK2d630RqSjlcpXbMfj6OkDrVyuM6jkxSTaaoRFOX+4+z1z5fpFK5BxbhAVyajIsGK0KfZH1F17vktxg+P+UIVz9IfOqkvEI88lbJil8sm8/cOIl6zyaKbiaTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1j9Q7pd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFE1C4CEC0;
	Sat, 31 Aug 2024 22:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725143911;
	bh=5gYKaNb9YNOgingbnDs/WOnab5e9XeuNx3JaLfoNfDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H1j9Q7pdQanl6xrrG+0drXqhcATJpPuN7ytuhgNwlzgbuk3G++oNtkY9v+qz7QJct
	 IZt1ACF/V7l7ACFiVYHR/7XywZ9cNqOzJtIlBmjTzsa8Q/BwBv4Pazz0EK2B39ei80
	 0PE7ej7zGVxHfK6zssm+k4mSj8DKypW8vmzSFxz+amDEN0OCKkXqxgqKYiqWn4ZD5t
	 a4xD2j1MHGnoy1jMX+ZUaoCnKlGXn7XAKMmNEKtiY3cLoW4HpbRmMC7OBiSAIoVTxo
	 CJhwzM5hByKkRlmVCz6jZ4EwvEUuUFrjbOwRBhKg8kpPcdOj8Zy0G6xkaMCrCPo4O5
	 e3MLONBn7Uj2w==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 26/26] nfs: add "NFS Client and Server Interlock" section to localio.rst
Date: Sat, 31 Aug 2024 18:37:46 -0400
Message-ID: <20240831223755.8569-27-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240831223755.8569-1-snitzer@kernel.org>
References: <20240831223755.8569-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This section answers a new FAQ entry:

9. How does LOCALIO make certain that object lifetimes are managed
   properly given NFSD and NFS operate in different contexts?

   See the detailed "NFS Client and Server Interlock" section below.

The first half of the section details NeilBrown's elegant design
for LOCALIO's nfs_uuid_t based interlock and is heavily based on
Neil's "net namespace refcounting" description here:
  https://marc.info/?l=linux-nfs&m=172498546024767&w=2

The second half of the section details the per-cpu-refcount introduced
to ensure NFSD's nfsd_serv isn't destroyed while in use by a LOCALIO
client.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 Documentation/filesystems/nfs/localio.rst | 68 +++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/Documentation/filesystems/nfs/localio.rst b/Documentation/filesystems/nfs/localio.rst
index ef3851d48133..4637c0b34753 100644
--- a/Documentation/filesystems/nfs/localio.rst
+++ b/Documentation/filesystems/nfs/localio.rst
@@ -150,6 +150,11 @@ FAQ
    __fh_verify().  So they get handled exactly the same way for LOCALIO
    as they do for non-LOCALIO.
 
+9. How does LOCALIO make certain that object lifetimes are managed
+   properly given NFSD and NFS operate in different contexts?
+
+   See the detailed "NFS Client and Server Interlock" section below.
+
 RPC
 ===
 
@@ -209,6 +214,69 @@ objects to span from the host kernel's nfsd to per-container knfsd
 instances that are connected to nfs client's running on the same local
 host.
 
+NFS Client and Server Interlock
+===============================
+
+LOCALIO provides the nfs_uuid_t object and associated interfaces to
+allow proper network namespace (net-ns) and NFSD object refcounting:
+
+    We don't want to keep a long-term counted reference on each NFSD's
+    net-ns in the client because that prevents a server container from
+    completely shutting down.
+
+    So we avoid taking a reference at all and rely on the per-cpu
+    reference to the server (detailed below) being sufficient to keep
+    the net-ns active. This involves allowing the NFSD's net-ns exit
+    code to iterate all active clients and clear their ->net pointers
+    (which are needed to find the per-cpu-refcount for the nfsd_serv).
+
+    Details:
+
+     - Embed nfs_uuid_t in nfs_client. nfs_uuid_t provides a list_head
+       that can be used to find the client. It does add the 16-byte
+       uuid_t to nfs_client so it is bigger than needed (given that
+       uuid_t is only used during the initial NFS client and server
+       LOCALIO handshake to determine if they are local to each other).
+       If that is really a problem we can find a fix.
+
+     - When the nfs server confirms that the uuid_t is local, it moves
+       the nfs_uuid_t onto a per-net-ns list in NFSD's nfsd_net.
+
+     - When each server's net-ns is shutting down - in a "pre_exit"
+       handler, all these nfs_uuid_t have their ->net cleared. There is
+       an rcu_synchronize() call between pre_exit() handlers and exit()
+       handlers so any caller that sees nfs_uuid_t ->net as not NULL can
+       safely manage the per-cpu-refcount for nfsd_serv.
+
+     - The client's nfs_uuid_t is passed to nfsd_open_local_fh() so it
+       can safely dereference ->net in a private rcu_read_lock() section
+       to allow safe access to the associated nfsd_net and nfsd_serv.
+
+So LOCALIO required the introduction and use of NFSD's percpu_ref to
+interlock nfsd_destroy_serv() and nfsd_open_local_fh(), to ensure each
+nn->nfsd_serv is not destroyed while in use by nfsd_open_local_fh(), and
+warrants a more detailed explanation:
+
+    nfsd_open_local_fh() uses nfsd_serv_try_get() before opening its
+    nfsd_file handle and then the caller (NFS client) must drop the
+    reference for the nfsd_file and associated nn->nfsd_serv using
+    nfs_file_put_local() once it has completed its IO.
+
+    This interlock working relies heavily on nfsd_open_local_fh() being
+    afforded the ability to safely deal with the possibility that the
+    NFSD's net-ns (and nfsd_net by association) may have been destroyed
+    by nfsd_destroy_serv() via nfsd_shutdown_net() -- which is only
+    possible given the nfs_uuid_t ->net pointer managemenet detailed
+    above.
+
+All told, this elaborate interlock of the NFS client and server has been
+verified to fix an easy to hit crash that would occur if an NFSD
+instance running in a container, with a LOCALIO client mounted, is
+shutdown. Upon restart of the container and associated NFSD the client
+would go on to crash due to NULL pointer dereference that occurred due
+to the LOCALIO client's attempting to nfsd_open_local_fh(), using
+nn->nfsd_serv, without having a proper reference on nn->nfsd_serv.
+
 NFS Client issues IO instead of Server
 ======================================
 
-- 
2.44.0


