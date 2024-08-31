Return-Path: <linux-fsdevel+bounces-28134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEF69673CB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 00:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDFF61F21E5F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 22:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8F9193426;
	Sat, 31 Aug 2024 22:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4zrr2kC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AC1192D81;
	Sat, 31 Aug 2024 22:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725143909; cv=none; b=m72/RxDoUJsdrZM62IhZT4OlxG712YsGLGo89WaR3ULc/fhp9tn7PUFzsrSoOESweMqneG3Crycy32Ckl3A48znyTkDIShQ8DhyRrdDgwGxLWEPGUHW8WFA4+Ogfx4V9CybYk1fbZYEPROXt61Ymw8In4ZMGnPEa4/RB/cePxb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725143909; c=relaxed/simple;
	bh=JgnpeS11Keq0XFdHvrGpUxWO8nvqka4CA0YQKu5zQXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTo1JKgWdehLF4Lu6+Pi8WKn3KQOiOPl8GGiNPCvuISi6S2/YK87h7SKz/ptk4Qr3NpoYfFtRl7GxZGVU0dMXvwDkclH8Gcpnbcn6oGxLUcN2oC0IlLm5KfxPz8XgG54e5P1y/Wy53VTIZZxDtGBKuOTXw6yneS4PsDWOLdMB3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4zrr2kC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB014C4CEC7;
	Sat, 31 Aug 2024 22:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725143909;
	bh=JgnpeS11Keq0XFdHvrGpUxWO8nvqka4CA0YQKu5zQXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y4zrr2kC+L8UcLCz00iK+GcxGDBdZvSpJ9fuvb47fNGnjOYS7lZXuCK8sr/SH3LCW
	 Q0FBF+mB5jrDTWK5FSlkNojjjyT5+n+W391H0EHkEs/m8hU/EODd8PeduaNJLSqCsX
	 cBtw1HBPsSc9Qv7EIn0mrgB3SPK+dhil6JygAAPMlhDtq0/CNAZ5z5sZtQcNyPSU2v
	 oPK8ExwWyNBnSkN2YFQXu71kW4PV/LbZ28SKeQyUdUIRDJnoDecScSwXnYnLzffYsb
	 ZEPkfWAshIIoGin4fl2tJGAZiDkfZPlkZX4PwmOD+CpI32GtCuruXeaiwAgWGS9kTz
	 llg40DysA8/Ww==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 24/26] nfs: add Documentation/filesystems/nfs/localio.rst
Date: Sat, 31 Aug 2024 18:37:44 -0400
Message-ID: <20240831223755.8569-25-snitzer@kernel.org>
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

This document gives an overview of the LOCALIO auxiliary RPC protocol
added to the Linux NFS client and server to allow them to reliably
handshake to determine if they are on the same host.

Once an NFS client and server handshake as "local", the client will
bypass the network RPC protocol for read, write and commit operations.
Due to this XDR and RPC bypass, these operations will operate faster.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 Documentation/filesystems/nfs/localio.rst | 203 ++++++++++++++++++++++
 1 file changed, 203 insertions(+)
 create mode 100644 Documentation/filesystems/nfs/localio.rst

diff --git a/Documentation/filesystems/nfs/localio.rst b/Documentation/filesystems/nfs/localio.rst
new file mode 100644
index 000000000000..3c9bc370079b
--- /dev/null
+++ b/Documentation/filesystems/nfs/localio.rst
@@ -0,0 +1,203 @@
+===========
+NFS LOCALIO
+===========
+
+Overview
+========
+
+The LOCALIO auxiliary RPC protocol allows the Linux NFS client and
+server to reliably handshake to determine if they are on the same
+host. Select "NFS client and server support for LOCALIO auxiliary
+protocol" in menuconfig to enable CONFIG_NFS_LOCALIO in the kernel
+config (both CONFIG_NFS_FS and CONFIG_NFSD must also be enabled).
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
+
+fio for 20 secs with directio, qd of 8, 16 libaio threads:
+- With LOCALIO:
+  4K read:    IOPS=979k,  BW=3825MiB/s (4011MB/s)(74.7GiB/20002msec)
+  4K write:   IOPS=165k,  BW=646MiB/s  (678MB/s)(12.6GiB/20002msec)
+  128K read:  IOPS=402k,  BW=49.1GiB/s (52.7GB/s)(982GiB/20002msec)
+  128K write: IOPS=11.5k, BW=1433MiB/s (1503MB/s)(28.0GiB/20004msec)
+
+- Without LOCALIO:
+  4K read:    IOPS=79.2k, BW=309MiB/s  (324MB/s)(6188MiB/20003msec)
+  4K write:   IOPS=59.8k, BW=234MiB/s  (245MB/s)(4671MiB/20002msec)
+  128K read:  IOPS=33.9k, BW=4234MiB/s (4440MB/s)(82.7GiB/20004msec)
+  128K write: IOPS=11.5k, BW=1434MiB/s (1504MB/s)(28.0GiB/20011msec)
+
+fio for 20 secs with directio, qd of 8, 1 libaio thread:
+- With LOCALIO:
+  4K read:    IOPS=230k,  BW=898MiB/s  (941MB/s)(17.5GiB/20001msec)
+  4K write:   IOPS=22.6k, BW=88.3MiB/s (92.6MB/s)(1766MiB/20001msec)
+  128K read:  IOPS=38.8k, BW=4855MiB/s (5091MB/s)(94.8GiB/20001msec)
+  128K write: IOPS=11.4k, BW=1428MiB/s (1497MB/s)(27.9GiB/20001msec)
+
+- Without LOCALIO:
+  4K read:    IOPS=77.1k, BW=301MiB/s  (316MB/s)(6022MiB/20001msec)
+  4K write:   IOPS=32.8k, BW=128MiB/s  (135MB/s)(2566MiB/20001msec)
+  128K read:  IOPS=24.4k, BW=3050MiB/s (3198MB/s)(59.6GiB/20001msec)
+  128K write: IOPS=11.4k, BW=1430MiB/s (1500MB/s)(27.9GiB/20001msec)
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
+members in the nfs_uuid_t struct. The NFS client then uses nfs_common to
+transfer the nfs_uuid_t from its nfs_uuids to the nn->nfsd_serv
+clients_list from the nfs_common's uuids_list.  See:
+fs/nfs/localio.c:nfs_local_probe()
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
+performance, alternatives to the traditional NFS wire protocol (SUNRPC
+with XDR) must be provided to access the backing filesystem.
+
+See fs/nfs/localio.c:nfs_local_open_fh() and
+fs/nfsd/localio.c:nfsd_open_local_fh() for the interface that makes
+focused use of select nfs server objects to allow a client local to a
+server to open a file pointer without needing to go over the network.
+
+The client's fs/nfs/localio.c:nfs_local_open_fh() will call into the
+server's fs/nfsd/localio.c:nfsd_open_local_fh() and carefully access
+both the associated nfsd network namespace and nn->nfsd_serv in terms of
+RCU. If nfsd_open_local_fh() finds that the client no longer sees valid
+nfsd objects (be it struct net or nn->nfsd_serv) it returns -ENXIO
+to nfs_local_open_fh() and the client will try to reestablish the
+LOCALIO resources needed by calling nfs_local_probe() again. This
+recovery is needed if/when an nfsd instance running in a container were
+to reboot while a LOCALIO client is connected to it.
+
+Once the client has an open nfsd_file pointer it will issue reads,
+writes and commits directly to the underlying local filesystem (normally
+done by the nfs server). As such, for these operations, the NFS client
+is issuing IO to the underlying local filesystem that it is sharing with
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
-- 
2.44.0


