Return-Path: <linux-fsdevel+bounces-26305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E849572F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 20:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACDE41F22B59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 18:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1877018991D;
	Mon, 19 Aug 2024 18:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIS3y8zY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774D4189531;
	Mon, 19 Aug 2024 18:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091498; cv=none; b=eXFNfnX+oOO8E4A7j+4UYBiL9PhlH26ccoSjkSm4R7Hn66yvyw62ugiePidSAWJ3mqkmlcF/bunc+C/r0ZjFcM/chaeq4c8Ars89wZdDi3ePxyzCdX+XMLjdEGLNMIOfORcsFgncPbdxGz5vSXYZJM1zRILNa3xxtzhQnjCnGHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091498; c=relaxed/simple;
	bh=mjyQRMCe58a9B+YYnhVr9bUVZwZykriX2VNmuqTCmfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lCMTeCbD1wmPGGpn3mxWmDCmO3CUprneXMG+d4lEzTuLT1GUvLz6GLxTUxLTWaaeqaNwUd+S52RxXgUOpRbtMoa8OjTYKOYEnMpceDB0NqYjGT1fbpk7wvASFwI45oeftezycAfYGX4VOoGsc01sygpmkBHZPfHbHKSBg4ouysA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIS3y8zY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E41C32782;
	Mon, 19 Aug 2024 18:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724091498;
	bh=mjyQRMCe58a9B+YYnhVr9bUVZwZykriX2VNmuqTCmfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kIS3y8zYf2MBOTUbQc4rRimybHQv6mGgs6aG/+4GVKG9NquB772UYrbjeuRFsZNBL
	 0DCLQZKuwKr0LbrBSyN+narIClWUhbG3jXshSIW+6uaQXaFspMc95NbXn2lwPWux2B
	 aKMvUXX8YpMDBvb0MnhZjQjZvGz798PXlibk8MrL24+896/r1NX8rlSFUSg5v9QjCz
	 vSxeCTzAbbTLs2CZJnEuYKRX/s0RgVG1OAvQHyslngDqsizlZIILn9XcPUDvyYtpJS
	 bvDNVhnP38im09BC5BDZXseHBnoQdurzIJ2Yc5vQ5rCiZ0R7Dtf6CmauDBKcVOp2eW
	 2Z3q/52PCLvyw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v12 19/24] nfs: add Documentation/filesystems/nfs/localio.rst
Date: Mon, 19 Aug 2024 14:17:24 -0400
Message-ID: <20240819181750.70570-20-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240819181750.70570-1-snitzer@kernel.org>
References: <20240819181750.70570-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This document gives an overview of the LOCALIO auxiliary RPC protocol
added to the Linux NFS client and server to allow them to reliably
handshake to determine if they are on the same host.

Once an NFS client and server handshake as "local", the client will
bypass the network RPC protocol for read, write and commit operations.
Due to this XDR and RPC bypass, these operations will operate faster.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 Documentation/filesystems/nfs/localio.rst | 178 ++++++++++++++++++++++
 include/linux/nfslocalio.h                |   2 +
 2 files changed, 180 insertions(+)
 create mode 100644 Documentation/filesystems/nfs/localio.rst

diff --git a/Documentation/filesystems/nfs/localio.rst b/Documentation/filesystems/nfs/localio.rst
new file mode 100644
index 000000000000..d8bdab88f1db
--- /dev/null
+++ b/Documentation/filesystems/nfs/localio.rst
@@ -0,0 +1,178 @@
+===========
+NFS LOCALIO
+===========
+
+Overview
+========
+
+The LOCALIO auxiliary RPC protocol allows the Linux NFS client and
+server to reliably handshake to determine if they are on the same host.
+
+Once an NFS client and server handshake as "local", the client will
+bypass the network RPC protocol for read, write and commit operations.
+Due to this XDR and RPC bypass, these operations will operate faster.
+
+The LOCALIO auxiliary protocol's implementation, which uses the same
+connection as NFS traffic, follows the pattern established by the NFS
+ACL protocol extension.
+
+The LOCALIO auxiliary protocol is needed to allow robust discovery of
+clients local to their servers. In a private implementation that
+preceded use of this LOCALIO protocol, a fragile sockaddr network
+address based match against all local network interfaces was attempted.
+But unlike the LOCALIO protocol, the sockaddr-based matching didn't
+handle use of iptables or containers.
+
+The robust handshake between local client and server is just the
+beginning, the ultimate use case this locality makes possible is the
+client is able to open files and issue reads, writes and commits
+directly to the server without having to go over the network. The
+requirement is to perform these loopback NFS operations as efficiently
+as possible, this is particularly useful for container use cases
+(e.g. kubernetes) where it is possible to run an IO job local to the
+server.
+
+The performance advantage realized from LOCALIO's ability to bypass
+using XDR and RPC for reads, writes and commits can be extreme, e.g.:
+fio for 20 secs with 24 libaio threads, 128k directio reads, qd of 8,
+- With LOCALIO:
+  read: IOPS=311k, BW=38.0GiB/s (40.8GB/s)(760GiB/20001msec)
+- Without LOCALIO:
+  read: IOPS=12.0k, BW=1495MiB/s (1568MB/s)(29.2GiB/20015msec)
+
+RPC
+===
+
+The LOCALIO auxiliary RPC protocol consists of a single "UUID_IS_LOCAL"
+RPC method that allows the Linux NFS client to verify the local Linux
+NFS server can see the nonce (single-use UUID) the client generated and
+made available in nfs_common. This protocol isn't part of an IETF
+standard, nor does it need to be considering it is Linux-to-Linux
+auxiliary RPC protocol that amounts to an implementation detail.
+
+The UUID_IS_LOCAL method encodes the client generated uuid_t in terms of
+the fixed UUID_SIZE (16 bytes). The fixed size opaque encode and decode
+XDR methods are used instead of the less efficient variable sized
+methods.
+
+The RPC program number for the NFS_LOCALIO_PROGRAM is 400122 (as assigned
+by IANA, see https://www.iana.org/assignments/rpc-program-numbers/ ):
+Linux Kernel Organization       400122  nfslocalio
+
+The LOCALIO protocol spec in rpcgen syntax is:
+
+/* raw RFC 9562 UUID */
+#define UUID_SIZE 16
+typedef u8 uuid_t<UUID_SIZE>;
+
+program NFS_LOCALIO_PROGRAM {
+    version LOCALIO_V1 {
+        void
+            NULL(void) = 0;
+
+        void
+            UUID_IS_LOCAL(uuid_t) = 1;
+    } = 1;
+} = 400122;
+
+LOCALIO uses the same transport connection as NFS traffic. As such,
+LOCALIO is not registered with rpcbind.
+
+NFS Common and Client/Server Handshake
+======================================
+
+fs/nfs_common/nfslocalio.c provides interfaces that enable an NFS client
+to generate a nonce (single-use UUID) and associated short-lived
+nfs_uuid_t struct, register it with nfs_common for subsequent lookup and
+verification by the NFS server and if matched the NFS server populates
+members in the nfs_uuid_t struct. The nfs client then transfers these
+nfs_uuid_t struct member pointers to the nfs_client struct and cleans up
+the nfs_uuid_t struct.  See: fs/nfs/localio.c:nfs_local_probe()
+
+nfs_common's nfs_uuids list is the basis for LOCALIO enablement, as such
+it has members that point to nfsd memory for direct use by the client
+(e.g. 'net' is the server's network namespace, through it the client can
+access nn->nfsd_serv with proper rcu read access). It is this client
+and server synchronization that enables advanced usage and lifetime of
+objects to span from the host kernel's nfsd to per-container knfsd
+instances that are connected to nfs client's running on the same local
+host.
+
+NFS Client issues IO instead of Server
+======================================
+
+Because LOCALIO is focused on protocol bypass to achieve improved IO
+performance alternatives to traditional NFS wire protocol (SUNRPC with
+XDR) to access the backing filesystem must be provided.
+
+See fs/nfs/localio.c:nfs_local_open_fh() and
+fs/nfsd/localio.c:nfsd_open_local_fh() for the interface that makes
+focused use of select nfs server objects to allow a client local to a
+server to open a file pointer without needing to go over the network.
+
+The client's fs/nfs/localio.c:nfs_local_open_fh() will call into the
+server's fs/nfsd/localio.c:nfsd_open_local_fh() and carefully access
+both the nfsd network namespace and the associated nn->nfsd_serv in
+terms of RCU. If nfsd_open_local_fh() finds that client no longer sees
+valid nfsd objects (be it struct net or nn->nfsd_serv) it returns ENXIO
+to nfs_local_open_fh() and the client will try to reestablish the
+LOCALIO resources needed by calling nfs_local_probe() again. This
+recovery is needed if/when an nfsd instance running in a container were
+to reboot while a LOCALIO client is connected to it.
+
+Once the client has an open file pointer it will issue reads, writes and
+commits directly to the underlying local filesystem (normally done by
+the nfs server). As such, for these operations, the NFS client is
+issuing IO to the underlying local filesystem that it is sharing with
+the NFS server. See: fs/nfs/localio.c:nfs_local_doio() and
+fs/nfs/localio.c:nfs_local_commit().
+
+Security
+========
+
+Localio is only supported when UNIX-style authentication (AUTH_UNIX, aka
+AUTH_SYS) is used.
+
+Care is taken to ensure the same NFS security mechanisms are used
+(authentication, etc) regardless of whether LOCALIO or regular NFS
+access is used. The auth_domain established as part of the traditional
+NFS client access to the NFS server is also used for LOCALIO.
+
+Relative to containers, LOCALIO gives the client access to the network
+namespace the server has. This is required to allow the client to access
+the server's per-namespace nfsd_net struct. With traditional NFS, the
+client is afforded this same level of access (albeit in terms of the NFS
+protocol via SUNRPC). No other namespaces (user, mount, etc) have been
+altered or purposely extended from the server to the client.
+
+Testing
+=======
+
+The LOCALIO auxiliary protocol and associated NFS LOCALIO read, write
+and commit access have proven stable against various test scenarios:
+
+- Client and server both on the same host.
+
+- All permutations of client and server support enablement for both
+  local and remote client and server.
+
+- Testing against NFS storage products that don't support the LOCALIO
+  protocol was also performed.
+
+- Client on host, server within a container (for both v3 and v4.2).
+  The container testing was in terms of podman managed containers and
+  includes successful container stop/restart scenario.
+
+- Formalizing these test scenarios in terms of existing test
+  infrastructure is on-going. Initial regular coverage is provided in
+  terms of ktest running xfstests against a LOCALIO-enabled NFS loopback
+  mount configuration, and includes lockdep and KASAN coverage, see:
+  https://evilpiepirate.org/~testdashboard/ci?user=snitzer&branch=snitm-nfs-next
+  https://github.com/koverstreet/ktest
+
+- Various kdevops testing (in terms of "Chuck's BuildBot") has been
+  performed to regularly verify the LOCALIO changes haven't caused any
+  regressions to non-LOCALIO NFS use cases.
+
+- All of Hammerspace's various sanity tests pass with LOCALIO enabled
+  (this includes numerous pNFS and flexfiles tests).
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index 109cb8534e3f..c6edcb7c0dcd 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -15,6 +15,8 @@
 /*
  * Useful to allow a client to negotiate if localio
  * possible with its server.
+ *
+ * See Documentation/filesystems/nfs/localio.rst for more detail.
  */
 typedef struct {
 	uuid_t uuid;
-- 
2.44.0


