Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5080761081E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 04:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbiJ1Ce0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Oct 2022 22:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236225AbiJ1CeQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Oct 2022 22:34:16 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD39BB3B3;
        Thu, 27 Oct 2022 19:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=S5sSKwRpGU7UU+k7AkqNa+33gzMDR/HU3Q0I7AADvGE=; b=H7I1zODKgLY7uj4pnPDhXdpQec
        MJHJ6Iol68gQ38C18UFXVI7M3weaukW+6JMhAay5w5iubYLmub4uCl0r+MZbLo4VV6ilTHy1uIi1u
        C9P6n6ImIZcafImbQJE8PkjCDpQ6UqU71PieEQn7OsbdRtPZY+7X2qpcHigrwi0YdGXtlCGBLUrjM
        3hnT1ldhXhXdLFmvoEG4TZehbqS4H4z4Ktae8b89H6nhZteqn+upAki6HYOKlwY5nlgNz8HyCC4aS
        BxiFk9Mgd+3FRRYb9CVi8dOmTy9V1IzHgtmO9ugeoURfd2W8LjwH/GuAbVn1ppurkzqgNcY3EGl9O
        N2DHoaOg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ooFBy-00Eorr-0m;
        Fri, 28 Oct 2022 02:33:54 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>, willy@infradead.org,
        dchinner@redhat.com, Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, torvalds@linux-foundation.org,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/12] use less confusing names for iov_iter direction initializers
Date:   Fri, 28 Oct 2022 03:33:52 +0100
Message-Id: <20221028023352.3532080-12-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028023352.3532080-1-viro@zeniv.linux.org.uk>
References: <Y1btOP0tyPtcYajo@ZenIV>
 <20221028023352.3532080-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

READ/WRITE proved to be actively confusing - the meanings are
"data destination, as used with read(2)" and "data source, as
used with write(2)", but people keep interpreting those as
"we read data from it" and "we write data to it", i.e. exactly
the wrong way.

Call them ITER_DEST and ITER_SOURCE - at least that is harder
to misinterpret...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/s390/kernel/crash_dump.c            |  2 +-
 arch/s390/mm/maccess.c                   |  2 +-
 arch/x86/kernel/cpu/microcode/intel.c    |  2 +-
 arch/x86/kernel/crash_dump_64.c          |  2 +-
 crypto/testmgr.c                         |  4 ++--
 drivers/acpi/pfr_update.c                |  2 +-
 drivers/block/drbd/drbd_main.c           |  2 +-
 drivers/block/drbd/drbd_receiver.c       |  2 +-
 drivers/block/loop.c                     | 12 ++++++------
 drivers/block/nbd.c                      | 10 +++++-----
 drivers/char/random.c                    |  4 ++--
 drivers/fsi/fsi-sbefifo.c                |  6 +++---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c   |  2 +-
 drivers/isdn/mISDN/l1oip_core.c          |  2 +-
 drivers/misc/vmw_vmci/vmci_queue_pair.c  |  6 +++---
 drivers/net/ppp/ppp_generic.c            |  2 +-
 drivers/nvme/host/tcp.c                  |  4 ++--
 drivers/nvme/target/io-cmd-file.c        |  4 ++--
 drivers/nvme/target/tcp.c                |  2 +-
 drivers/s390/char/zcore.c                |  2 +-
 drivers/scsi/sg.c                        |  2 +-
 drivers/target/iscsi/iscsi_target_util.c |  4 ++--
 drivers/target/target_core_file.c        |  2 +-
 drivers/usb/usbip/usbip_common.c         |  2 +-
 drivers/vhost/net.c                      |  6 +++---
 drivers/vhost/scsi.c                     | 10 +++++-----
 drivers/vhost/vhost.c                    |  6 +++---
 drivers/vhost/vringh.c                   |  4 ++--
 drivers/vhost/vsock.c                    |  4 ++--
 drivers/xen/pvcalls-back.c               |  8 ++++----
 fs/9p/vfs_addr.c                         |  4 ++--
 fs/9p/vfs_dir.c                          |  2 +-
 fs/9p/xattr.c                            |  4 ++--
 fs/afs/cmservice.c                       |  2 +-
 fs/afs/dir.c                             |  2 +-
 fs/afs/file.c                            |  4 ++--
 fs/afs/internal.h                        |  4 ++--
 fs/afs/rxrpc.c                           | 10 +++++-----
 fs/afs/write.c                           |  4 ++--
 fs/aio.c                                 |  4 ++--
 fs/btrfs/ioctl.c                         |  4 ++--
 fs/ceph/addr.c                           |  4 ++--
 fs/ceph/file.c                           |  4 ++--
 fs/cifs/connect.c                        |  6 +++---
 fs/cifs/file.c                           |  4 ++--
 fs/cifs/fscache.c                        |  4 ++--
 fs/cifs/smb2ops.c                        |  4 ++--
 fs/cifs/transport.c                      |  6 +++---
 fs/coredump.c                            |  2 +-
 fs/erofs/fscache.c                       |  6 +++---
 fs/fscache/io.c                          |  2 +-
 fs/fuse/ioctl.c                          |  4 ++--
 fs/netfs/io.c                            |  6 +++---
 fs/nfs/fscache.c                         |  4 ++--
 fs/nfsd/vfs.c                            |  4 ++--
 fs/ocfs2/cluster/tcp.c                   |  2 +-
 fs/orangefs/inode.c                      |  8 ++++----
 fs/proc/vmcore.c                         |  6 +++---
 fs/read_write.c                          | 12 ++++++------
 fs/seq_file.c                            |  2 +-
 fs/splice.c                              | 10 +++++-----
 include/linux/uio.h                      |  3 +++
 io_uring/net.c                           | 14 +++++++-------
 io_uring/rw.c                            | 10 +++++-----
 kernel/trace/trace_events_user.c         |  2 +-
 mm/madvise.c                             |  2 +-
 mm/page_io.c                             |  4 ++--
 mm/process_vm_access.c                   |  2 +-
 net/9p/client.c                          |  2 +-
 net/bluetooth/6lowpan.c                  |  2 +-
 net/bluetooth/a2mp.c                     |  2 +-
 net/bluetooth/smp.c                      |  2 +-
 net/ceph/messenger_v1.c                  |  4 ++--
 net/ceph/messenger_v2.c                  | 14 +++++++-------
 net/compat.c                             |  3 ++-
 net/ipv4/tcp.c                           |  4 ++--
 net/netfilter/ipvs/ip_vs_sync.c          |  2 +-
 net/smc/smc_clc.c                        |  6 +++---
 net/smc/smc_tx.c                         |  2 +-
 net/socket.c                             | 12 ++++++------
 net/sunrpc/socklib.c                     |  6 +++---
 net/sunrpc/svcsock.c                     |  4 ++--
 net/sunrpc/xprtsock.c                    |  6 +++---
 net/tipc/topsrv.c                        |  2 +-
 net/tls/tls_device.c                     |  4 ++--
 net/xfrm/espintcp.c                      |  2 +-
 security/keys/keyctl.c                   |  4 ++--
 87 files changed, 195 insertions(+), 191 deletions(-)

diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index 7ad7f20320b9..f3c3cf316f65 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -153,7 +153,7 @@ int copy_oldmem_kernel(void *dst, unsigned long src, size_t count)
 
 	kvec.iov_base = dst;
 	kvec.iov_len = count;
-	iov_iter_kvec(&iter, READ, &kvec, 1, count);
+	iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, count);
 	if (copy_oldmem_iter(&iter, src, count) < count)
 		return -EFAULT;
 	return 0;
diff --git a/arch/s390/mm/maccess.c b/arch/s390/mm/maccess.c
index 753b006c8ea5..4824d1cd33d8 100644
--- a/arch/s390/mm/maccess.c
+++ b/arch/s390/mm/maccess.c
@@ -128,7 +128,7 @@ int memcpy_real(void *dest, unsigned long src, size_t count)
 
 	kvec.iov_base = dest;
 	kvec.iov_len = count;
-	iov_iter_kvec(&iter, READ, &kvec, 1, count);
+	iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, count);
 	if (memcpy_real_iter(&iter, src, count) < count)
 		return -EFAULT;
 	return 0;
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 1fcbd671f1df..fdd2c4a754ce 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -908,7 +908,7 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device,
 
 	kvec.iov_base = (void *)firmware->data;
 	kvec.iov_len = firmware->size;
-	iov_iter_kvec(&iter, WRITE, &kvec, 1, firmware->size);
+	iov_iter_kvec(&iter, ITER_SOURCE, &kvec, 1, firmware->size);
 	ret = generic_load_microcode(cpu, &iter);
 
 	release_firmware(firmware);
diff --git a/arch/x86/kernel/crash_dump_64.c b/arch/x86/kernel/crash_dump_64.c
index e75bc2f217ff..32d710f7eb84 100644
--- a/arch/x86/kernel/crash_dump_64.c
+++ b/arch/x86/kernel/crash_dump_64.c
@@ -57,7 +57,7 @@ ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos)
 	struct kvec kvec = { .iov_base = buf, .iov_len = count };
 	struct iov_iter iter;
 
-	iov_iter_kvec(&iter, READ, &kvec, 1, count);
+	iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, count);
 
 	return read_from_oldmem(&iter, count, ppos,
 				cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT));
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index bcd059caa1c8..814d2dc87d7e 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -766,7 +766,7 @@ static int build_cipher_test_sglists(struct cipher_test_sglists *tsgls,
 	struct iov_iter input;
 	int err;
 
-	iov_iter_kvec(&input, WRITE, inputs, nr_inputs, src_total_len);
+	iov_iter_kvec(&input, ITER_SOURCE, inputs, nr_inputs, src_total_len);
 	err = build_test_sglist(&tsgls->src, cfg->src_divs, alignmask,
 				cfg->inplace_mode != OUT_OF_PLACE ?
 					max(dst_total_len, src_total_len) :
@@ -1180,7 +1180,7 @@ static int build_hash_sglist(struct test_sglist *tsgl,
 
 	kv.iov_base = (void *)vec->plaintext;
 	kv.iov_len = vec->psize;
-	iov_iter_kvec(&input, WRITE, &kv, 1, vec->psize);
+	iov_iter_kvec(&input, ITER_SOURCE, &kv, 1, vec->psize);
 	return build_test_sglist(tsgl, cfg->src_divs, alignmask, vec->psize,
 				 &input, divs);
 }
diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
index 6bb0b778b5da..9a93ceedd936 100644
--- a/drivers/acpi/pfr_update.c
+++ b/drivers/acpi/pfr_update.c
@@ -455,7 +455,7 @@ static ssize_t pfru_write(struct file *file, const char __user *buf,
 
 	iov.iov_base = (void __user *)buf;
 	iov.iov_len = len;
-	iov_iter_init(&iter, WRITE, &iov, 1, len);
+	iov_iter_init(&iter, ITER_SOURCE, &iov, 1, len);
 
 	/* map the communication buffer */
 	phy_addr = (phys_addr_t)((buf_info.addr_hi << 32) | buf_info.addr_lo);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index f3e4db16fd07..7a8ba0a5c7e7 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1816,7 +1816,7 @@ int drbd_send(struct drbd_connection *connection, struct socket *sock,
 
 	/* THINK  if (signal_pending) return ... ? */
 
-	iov_iter_kvec(&msg.msg_iter, WRITE, &iov, 1, size);
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &iov, 1, size);
 
 	if (sock == connection->data.socket) {
 		rcu_read_lock();
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index ee69d50ba4fd..54010eac6ca9 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -507,7 +507,7 @@ static int drbd_recv_short(struct socket *sock, void *buf, size_t size, int flag
 	struct msghdr msg = {
 		.msg_flags = (flags ? flags : MSG_WAITALL | MSG_NOSIGNAL)
 	};
-	iov_iter_kvec(&msg.msg_iter, READ, &iov, 1, size);
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, size);
 	return sock_recvmsg(sock, &msg, msg.msg_flags);
 }
 
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ad92192c7d61..1f8f3b87bdfa 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -243,7 +243,7 @@ static int lo_write_bvec(struct file *file, struct bio_vec *bvec, loff_t *ppos)
 	struct iov_iter i;
 	ssize_t bw;
 
-	iov_iter_bvec(&i, WRITE, bvec, 1, bvec->bv_len);
+	iov_iter_bvec(&i, ITER_SOURCE, bvec, 1, bvec->bv_len);
 
 	file_start_write(file);
 	bw = vfs_iter_write(file, &i, ppos, 0);
@@ -286,7 +286,7 @@ static int lo_read_simple(struct loop_device *lo, struct request *rq,
 	ssize_t len;
 
 	rq_for_each_segment(bvec, rq, iter) {
-		iov_iter_bvec(&i, READ, &bvec, 1, bvec.bv_len);
+		iov_iter_bvec(&i, ITER_DEST, &bvec, 1, bvec.bv_len);
 		len = vfs_iter_read(lo->lo_backing_file, &i, &pos, 0);
 		if (len < 0)
 			return len;
@@ -392,7 +392,7 @@ static void lo_rw_aio_complete(struct kiocb *iocb, long ret)
 }
 
 static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
-		     loff_t pos, bool rw)
+		     loff_t pos, int rw)
 {
 	struct iov_iter iter;
 	struct req_iterator rq_iter;
@@ -448,7 +448,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	cmd->iocb.ki_flags = IOCB_DIRECT;
 	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
 
-	if (rw == WRITE)
+	if (rw == ITER_SOURCE)
 		ret = call_write_iter(file, &cmd->iocb, &iter);
 	else
 		ret = call_read_iter(file, &cmd->iocb, &iter);
@@ -490,12 +490,12 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 		return lo_fallocate(lo, rq, pos, FALLOC_FL_PUNCH_HOLE);
 	case REQ_OP_WRITE:
 		if (cmd->use_aio)
-			return lo_rw_aio(lo, cmd, pos, WRITE);
+			return lo_rw_aio(lo, cmd, pos, ITER_SOURCE);
 		else
 			return lo_write_simple(lo, rq, pos);
 	case REQ_OP_READ:
 		if (cmd->use_aio)
-			return lo_rw_aio(lo, cmd, pos, READ);
+			return lo_rw_aio(lo, cmd, pos, ITER_DEST);
 		else
 			return lo_read_simple(lo, rq, pos);
 	default:
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 5cffd96ef2d7..e379ccc63c52 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -563,7 +563,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 	u32 nbd_cmd_flags = 0;
 	int sent = nsock->sent, skip = 0;
 
-	iov_iter_kvec(&from, WRITE, &iov, 1, sizeof(request));
+	iov_iter_kvec(&from, ITER_SOURCE, &iov, 1, sizeof(request));
 
 	type = req_to_nbd_cmd_type(req);
 	if (type == U32_MAX)
@@ -649,7 +649,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 
 			dev_dbg(nbd_to_dev(nbd), "request %p: sending %d bytes data\n",
 				req, bvec.bv_len);
-			iov_iter_bvec(&from, WRITE, &bvec, 1, bvec.bv_len);
+			iov_iter_bvec(&from, ITER_SOURCE, &bvec, 1, bvec.bv_len);
 			if (skip) {
 				if (skip >= iov_iter_count(&from)) {
 					skip -= iov_iter_count(&from);
@@ -701,7 +701,7 @@ static int nbd_read_reply(struct nbd_device *nbd, int index,
 	int result;
 
 	reply->magic = 0;
-	iov_iter_kvec(&to, READ, &iov, 1, sizeof(*reply));
+	iov_iter_kvec(&to, ITER_DEST, &iov, 1, sizeof(*reply));
 	result = sock_xmit(nbd, index, 0, &to, MSG_WAITALL, NULL);
 	if (result < 0) {
 		if (!nbd_disconnected(nbd->config))
@@ -790,7 +790,7 @@ static struct nbd_cmd *nbd_handle_reply(struct nbd_device *nbd, int index,
 		struct iov_iter to;
 
 		rq_for_each_segment(bvec, req, iter) {
-			iov_iter_bvec(&to, READ, &bvec, 1, bvec.bv_len);
+			iov_iter_bvec(&to, ITER_DEST, &bvec, 1, bvec.bv_len);
 			result = sock_xmit(nbd, index, 0, &to, MSG_WAITALL, NULL);
 			if (result < 0) {
 				dev_err(disk_to_dev(nbd->disk), "Receive data failed (result %d)\n",
@@ -1267,7 +1267,7 @@ static void send_disconnects(struct nbd_device *nbd)
 	for (i = 0; i < config->num_connections; i++) {
 		struct nbd_sock *nsock = config->socks[i];
 
-		iov_iter_kvec(&from, WRITE, &iov, 1, sizeof(request));
+		iov_iter_kvec(&from, ITER_SOURCE, &iov, 1, sizeof(request));
 		mutex_lock(&nsock->tx_lock);
 		ret = sock_xmit(nbd, i, 1, &from, 0, NULL);
 		if (ret < 0)
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 2fe28eeb2f38..3d4c61cf6587 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1291,7 +1291,7 @@ SYSCALL_DEFINE3(getrandom, char __user *, ubuf, size_t, len, unsigned int, flags
 			return ret;
 	}
 
-	ret = import_single_range(READ, ubuf, len, &iov, &iter);
+	ret = import_single_range(ITER_DEST, ubuf, len, &iov, &iter);
 	if (unlikely(ret))
 		return ret;
 	return get_random_bytes_user(&iter);
@@ -1409,7 +1409,7 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 			return -EINVAL;
 		if (get_user(len, p++))
 			return -EFAULT;
-		ret = import_single_range(WRITE, p, len, &iov, &iter);
+		ret = import_single_range(ITER_SOURCE, p, len, &iov, &iter);
 		if (unlikely(ret))
 			return ret;
 		ret = write_pool_user(&iter);
diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index efd4942aa043..9912b7a6a4b9 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -659,7 +659,7 @@ static void sbefifo_collect_async_ffdc(struct sbefifo *sbefifo)
 	}
         ffdc_iov.iov_base = ffdc;
 	ffdc_iov.iov_len = SBEFIFO_MAX_FFDC_SIZE;
-        iov_iter_kvec(&ffdc_iter, READ, &ffdc_iov, 1, SBEFIFO_MAX_FFDC_SIZE);
+        iov_iter_kvec(&ffdc_iter, ITER_DEST, &ffdc_iov, 1, SBEFIFO_MAX_FFDC_SIZE);
 	cmd[0] = cpu_to_be32(2);
 	cmd[1] = cpu_to_be32(SBEFIFO_CMD_GET_SBE_FFDC);
 	rc = sbefifo_do_command(sbefifo, cmd, 2, &ffdc_iter);
@@ -756,7 +756,7 @@ int sbefifo_submit(struct device *dev, const __be32 *command, size_t cmd_len,
 	rbytes = (*resp_len) * sizeof(__be32);
 	resp_iov.iov_base = response;
 	resp_iov.iov_len = rbytes;
-        iov_iter_kvec(&resp_iter, READ, &resp_iov, 1, rbytes);
+        iov_iter_kvec(&resp_iter, ITER_DEST, &resp_iov, 1, rbytes);
 
 	/* Perform the command */
 	rc = mutex_lock_interruptible(&sbefifo->lock);
@@ -839,7 +839,7 @@ static ssize_t sbefifo_user_read(struct file *file, char __user *buf,
 	/* Prepare iov iterator */
 	resp_iov.iov_base = buf;
 	resp_iov.iov_len = len;
-	iov_iter_init(&resp_iter, READ, &resp_iov, 1, len);
+	iov_iter_init(&resp_iter, ITER_DEST, &resp_iov, 1, len);
 
 	/* Perform the command */
 	rc = mutex_lock_interruptible(&sbefifo->lock);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 88282b288abd..730f2f1e09bb 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -966,7 +966,7 @@ static void rtrs_clt_init_req(struct rtrs_clt_io_req *req,
 	refcount_set(&req->ref, 1);
 	req->mp_policy = clt_path->clt->mp_policy;
 
-	iov_iter_kvec(&iter, WRITE, vec, 1, usr_len);
+	iov_iter_kvec(&iter, ITER_SOURCE, vec, 1, usr_len);
 	len = _copy_from_iter(req->iu->buf, usr_len, &iter);
 	WARN_ON(len != usr_len);
 
diff --git a/drivers/isdn/mISDN/l1oip_core.c b/drivers/isdn/mISDN/l1oip_core.c
index a77195e378b7..c24771336f61 100644
--- a/drivers/isdn/mISDN/l1oip_core.c
+++ b/drivers/isdn/mISDN/l1oip_core.c
@@ -706,7 +706,7 @@ l1oip_socket_thread(void *data)
 		printk(KERN_DEBUG "%s: socket created and open\n",
 		       __func__);
 	while (!signal_pending(current)) {
-		iov_iter_kvec(&msg.msg_iter, READ, &iov, 1, recvbuf_size);
+		iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, recvbuf_size);
 		recvlen = sock_recvmsg(socket, &msg, 0);
 		if (recvlen > 0) {
 			l1oip_socket_parse(hc, &sin_rx, recvbuf, recvlen);
diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
index e71068f7759b..4d51d9b7d933 100644
--- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
@@ -3042,7 +3042,7 @@ ssize_t vmci_qpair_enqueue(struct vmci_qp *qpair,
 	if (!qpair || !buf)
 		return VMCI_ERROR_INVALID_ARGS;
 
-	iov_iter_kvec(&from, WRITE, &v, 1, buf_size);
+	iov_iter_kvec(&from, ITER_SOURCE, &v, 1, buf_size);
 
 	qp_lock(qpair);
 
@@ -3086,7 +3086,7 @@ ssize_t vmci_qpair_dequeue(struct vmci_qp *qpair,
 	if (!qpair || !buf)
 		return VMCI_ERROR_INVALID_ARGS;
 
-	iov_iter_kvec(&to, READ, &v, 1, buf_size);
+	iov_iter_kvec(&to, ITER_DEST, &v, 1, buf_size);
 
 	qp_lock(qpair);
 
@@ -3131,7 +3131,7 @@ ssize_t vmci_qpair_peek(struct vmci_qp *qpair,
 	if (!qpair || !buf)
 		return VMCI_ERROR_INVALID_ARGS;
 
-	iov_iter_kvec(&to, READ, &v, 1, buf_size);
+	iov_iter_kvec(&to, ITER_DEST, &v, 1, buf_size);
 
 	qp_lock(qpair);
 
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 9206c660a72e..be2fab0469cf 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -480,7 +480,7 @@ static ssize_t ppp_read(struct file *file, char __user *buf,
 	ret = -EFAULT;
 	iov.iov_base = buf;
 	iov.iov_len = count;
-	iov_iter_init(&to, READ, &iov, 1, count);
+	iov_iter_init(&to, ITER_DEST, &iov, 1, count);
 	if (skb_copy_datagram_iter(skb, 0, &to, skb->len))
 		goto outf;
 	ret = skb->len;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1eed0fc26b3a..47cff9679770 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -301,7 +301,7 @@ static inline void nvme_tcp_advance_req(struct nvme_tcp_request *req,
 	if (!iov_iter_count(&req->iter) &&
 	    req->data_sent < req->data_len) {
 		req->curr_bio = req->curr_bio->bi_next;
-		nvme_tcp_init_iter(req, WRITE);
+		nvme_tcp_init_iter(req, ITER_SOURCE);
 	}
 }
 
@@ -781,7 +781,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 				nvme_tcp_init_recv_ctx(queue);
 				return -EIO;
 			}
-			nvme_tcp_init_iter(req, READ);
+			nvme_tcp_init_iter(req, ITER_DEST);
 		}
 
 		/* we can read only from what is left in this bio */
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 64b47e2a4633..946ad0240ee5 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -102,10 +102,10 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 		if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
 			ki_flags |= IOCB_DSYNC;
 		call_iter = req->ns->file->f_op->write_iter;
-		rw = WRITE;
+		rw = ITER_SOURCE;
 	} else {
 		call_iter = req->ns->file->f_op->read_iter;
-		rw = READ;
+		rw = ITER_DEST;
 	}
 
 	iov_iter_bvec(&iter, rw, req->f.bvec, nr_segs, count);
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 6c1476e086ef..cc05c094de22 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -331,7 +331,7 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 		sg_offset = 0;
 	}
 
-	iov_iter_bvec(&cmd->recv_msg.msg_iter, READ, cmd->iov,
+	iov_iter_bvec(&cmd->recv_msg.msg_iter, ITER_DEST, cmd->iov,
 		      nr_pages, cmd->pdu_len);
 }
 
diff --git a/drivers/s390/char/zcore.c b/drivers/s390/char/zcore.c
index 83ddac1e5838..a41833557d55 100644
--- a/drivers/s390/char/zcore.c
+++ b/drivers/s390/char/zcore.c
@@ -103,7 +103,7 @@ static inline int memcpy_hsa_kernel(void *dst, unsigned long src, size_t count)
 
 	kvec.iov_base = dst;
 	kvec.iov_len = count;
-	iov_iter_kvec(&iter, READ, &kvec, 1, count);
+	iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, count);
 	if (memcpy_hsa_iter(&iter, src, count) < count)
 		return -EIO;
 	return 0;
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index ce34a8ad53b4..12344be14232 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1726,7 +1726,7 @@ sg_start_req(Sg_request *srp, unsigned char *cmd)
 	Sg_scatter_hold *rsv_schp = &sfp->reserve;
 	struct request_queue *q = sfp->parentdp->device->request_queue;
 	struct rq_map_data *md, map_data;
-	int rw = hp->dxfer_direction == SG_DXFER_TO_DEV ? WRITE : READ;
+	int rw = hp->dxfer_direction == SG_DXFER_TO_DEV ? ITER_SOURCE : ITER_DEST;
 	struct scsi_cmnd *scmd;
 
 	SCSI_LOG_TIMEOUT(4, sg_printk(KERN_INFO, sfp->parentdp,
diff --git a/drivers/target/iscsi/iscsi_target_util.c b/drivers/target/iscsi/iscsi_target_util.c
index 8d9f21372b67..26dc8ed3045b 100644
--- a/drivers/target/iscsi/iscsi_target_util.c
+++ b/drivers/target/iscsi/iscsi_target_util.c
@@ -1225,7 +1225,7 @@ int rx_data(
 		return -1;
 
 	memset(&msg, 0, sizeof(struct msghdr));
-	iov_iter_kvec(&msg.msg_iter, READ, iov, iov_count, data);
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, iov, iov_count, data);
 
 	while (msg_data_left(&msg)) {
 		rx_loop = sock_recvmsg(conn->sock, &msg, MSG_WAITALL);
@@ -1261,7 +1261,7 @@ int tx_data(
 
 	memset(&msg, 0, sizeof(struct msghdr));
 
-	iov_iter_kvec(&msg.msg_iter, WRITE, iov, iov_count, data);
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, iov, iov_count, data);
 
 	while (msg_data_left(&msg)) {
 		int tx_loop = sock_sendmsg(conn->sock, &msg);
diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index 55935040541b..7e81a53dbf3c 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -473,7 +473,7 @@ fd_execute_write_same(struct se_cmd *cmd)
 		len += se_dev->dev_attrib.block_size;
 	}
 
-	iov_iter_bvec(&iter, WRITE, bvec, nolb, len);
+	iov_iter_bvec(&iter, ITER_SOURCE, bvec, nolb, len);
 	ret = vfs_iter_write(fd_dev->fd_file, &iter, &pos, 0);
 
 	kfree(bvec);
diff --git a/drivers/usb/usbip/usbip_common.c b/drivers/usb/usbip/usbip_common.c
index 053a2bca4c47..f8b326eed54d 100644
--- a/drivers/usb/usbip/usbip_common.c
+++ b/drivers/usb/usbip/usbip_common.c
@@ -309,7 +309,7 @@ int usbip_recv(struct socket *sock, void *buf, int size)
 	if (!sock || !buf || !size)
 		return -EINVAL;
 
-	iov_iter_kvec(&msg.msg_iter, READ, &iov, 1, size);
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, size);
 
 	usbip_dbg_xmit("enter\n");
 
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 20265393aee7..9af19b0cf3b7 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -611,7 +611,7 @@ static size_t init_iov_iter(struct vhost_virtqueue *vq, struct iov_iter *iter,
 	/* Skip header. TODO: support TSO. */
 	size_t len = iov_length(vq->iov, out);
 
-	iov_iter_init(iter, WRITE, vq->iov, out, len);
+	iov_iter_init(iter, ITER_SOURCE, vq->iov, out, len);
 	iov_iter_advance(iter, hdr_size);
 
 	return iov_iter_count(iter);
@@ -1184,14 +1184,14 @@ static void handle_rx(struct vhost_net *net)
 			msg.msg_control = vhost_net_buf_consume(&nvq->rxq);
 		/* On overrun, truncate and discard */
 		if (unlikely(headcount > UIO_MAXIOV)) {
-			iov_iter_init(&msg.msg_iter, READ, vq->iov, 1, 1);
+			iov_iter_init(&msg.msg_iter, ITER_DEST, vq->iov, 1, 1);
 			err = sock->ops->recvmsg(sock, &msg,
 						 1, MSG_DONTWAIT | MSG_TRUNC);
 			pr_debug("Discarded rx packet: len %zd\n", sock_len);
 			continue;
 		}
 		/* We don't need to be notified again. */
-		iov_iter_init(&msg.msg_iter, READ, vq->iov, in, vhost_len);
+		iov_iter_init(&msg.msg_iter, ITER_DEST, vq->iov, in, vhost_len);
 		fixup = msg.msg_iter;
 		if (unlikely((vhost_hlen))) {
 			/* We will supply the header ourselves
diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 7ebf106d50c1..dca6346d75b3 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -563,7 +563,7 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 		memcpy(v_rsp.sense, cmd->tvc_sense_buf,
 		       se_cmd->scsi_sense_length);
 
-		iov_iter_init(&iov_iter, READ, &cmd->tvc_resp_iov,
+		iov_iter_init(&iov_iter, ITER_DEST, &cmd->tvc_resp_iov,
 			      cmd->tvc_in_iovs, sizeof(v_rsp));
 		ret = copy_to_iter(&v_rsp, sizeof(v_rsp), &iov_iter);
 		if (likely(ret == sizeof(v_rsp))) {
@@ -864,7 +864,7 @@ vhost_scsi_get_desc(struct vhost_scsi *vs, struct vhost_virtqueue *vq,
 	 * point at the start of the outgoing WRITE payload, if
 	 * DMA_TO_DEVICE is set.
 	 */
-	iov_iter_init(&vc->out_iter, WRITE, vq->iov, vc->out, vc->out_size);
+	iov_iter_init(&vc->out_iter, ITER_SOURCE, vq->iov, vc->out, vc->out_size);
 	ret = 0;
 
 done:
@@ -1016,7 +1016,7 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 			data_direction = DMA_FROM_DEVICE;
 			exp_data_len = vc.in_size - vc.rsp_size;
 
-			iov_iter_init(&in_iter, READ, &vq->iov[vc.out], vc.in,
+			iov_iter_init(&in_iter, ITER_DEST, &vq->iov[vc.out], vc.in,
 				      vc.rsp_size + exp_data_len);
 			iov_iter_advance(&in_iter, vc.rsp_size);
 			data_iter = in_iter;
@@ -1146,7 +1146,7 @@ vhost_scsi_send_tmf_resp(struct vhost_scsi *vs, struct vhost_virtqueue *vq,
 	memset(&rsp, 0, sizeof(rsp));
 	rsp.response = tmf_resp_code;
 
-	iov_iter_init(&iov_iter, READ, resp_iov, in_iovs, sizeof(rsp));
+	iov_iter_init(&iov_iter, ITER_DEST, resp_iov, in_iovs, sizeof(rsp));
 
 	ret = copy_to_iter(&rsp, sizeof(rsp), &iov_iter);
 	if (likely(ret == sizeof(rsp)))
@@ -1238,7 +1238,7 @@ vhost_scsi_send_an_resp(struct vhost_scsi *vs,
 	memset(&rsp, 0, sizeof(rsp));	/* event_actual = 0 */
 	rsp.response = VIRTIO_SCSI_S_OK;
 
-	iov_iter_init(&iov_iter, READ, &vq->iov[vc->out], vc->in, sizeof(rsp));
+	iov_iter_init(&iov_iter, ITER_DEST, &vq->iov[vc->out], vc->in, sizeof(rsp));
 
 	ret = copy_to_iter(&rsp, sizeof(rsp), &iov_iter);
 	if (likely(ret == sizeof(rsp)))
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index da0ff415b0a1..5c9fe3c9c364 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -832,7 +832,7 @@ static int vhost_copy_to_user(struct vhost_virtqueue *vq, void __user *to,
 				     VHOST_ACCESS_WO);
 		if (ret < 0)
 			goto out;
-		iov_iter_init(&t, READ, vq->iotlb_iov, ret, size);
+		iov_iter_init(&t, ITER_DEST, vq->iotlb_iov, ret, size);
 		ret = copy_to_iter(from, size, &t);
 		if (ret == size)
 			ret = 0;
@@ -871,7 +871,7 @@ static int vhost_copy_from_user(struct vhost_virtqueue *vq, void *to,
 			       (unsigned long long) size);
 			goto out;
 		}
-		iov_iter_init(&f, WRITE, vq->iotlb_iov, ret, size);
+		iov_iter_init(&f, ITER_SOURCE, vq->iotlb_iov, ret, size);
 		ret = copy_from_iter(to, size, &f);
 		if (ret == size)
 			ret = 0;
@@ -2135,7 +2135,7 @@ static int get_indirect(struct vhost_virtqueue *vq,
 			vq_err(vq, "Translation failure %d in indirect.\n", ret);
 		return ret;
 	}
-	iov_iter_init(&from, WRITE, vq->indirect, ret, len);
+	iov_iter_init(&from, ITER_SOURCE, vq->indirect, ret, len);
 	count = len / sizeof desc;
 	/* Buffers are chained via a 16 bit next field, so
 	 * we can have at most 2^16 of these. */
diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 8be8f30a78f7..c9f5c8ea3afb 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1162,7 +1162,7 @@ static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
 		else if (ret < 0)
 			return ret;
 
-		iov_iter_bvec(&iter, WRITE, iov, ret, translated);
+		iov_iter_bvec(&iter, ITER_SOURCE, iov, ret, translated);
 
 		ret = copy_from_iter(dst, translated, &iter);
 		if (ret < 0)
@@ -1195,7 +1195,7 @@ static inline int copy_to_iotlb(const struct vringh *vrh, void *dst,
 		else if (ret < 0)
 			return ret;
 
-		iov_iter_bvec(&iter, READ, iov, ret, translated);
+		iov_iter_bvec(&iter, ITER_DEST, iov, ret, translated);
 
 		ret = copy_to_iter(src, translated, &iter);
 		if (ret < 0)
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 5703775af129..cd6f7776013a 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -165,7 +165,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 			break;
 		}
 
-		iov_iter_init(&iov_iter, READ, &vq->iov[out], in, iov_len);
+		iov_iter_init(&iov_iter, ITER_DEST, &vq->iov[out], in, iov_len);
 		payload_len = pkt->len - pkt->off;
 
 		/* If the packet is greater than the space available in the
@@ -371,7 +371,7 @@ vhost_vsock_alloc_pkt(struct vhost_virtqueue *vq,
 		return NULL;
 
 	len = iov_length(vq->iov, out);
-	iov_iter_init(&iov_iter, WRITE, vq->iov, out, len);
+	iov_iter_init(&iov_iter, ITER_SOURCE, vq->iov, out, len);
 
 	nbytes = copy_from_iter(&pkt->hdr, sizeof(pkt->hdr), &iov_iter);
 	if (nbytes != sizeof(pkt->hdr)) {
diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index 21b9c850a382..28b2a1fa25ab 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -129,13 +129,13 @@ static bool pvcalls_conn_back_read(void *opaque)
 	if (masked_prod < masked_cons) {
 		vec[0].iov_base = data->in + masked_prod;
 		vec[0].iov_len = wanted;
-		iov_iter_kvec(&msg.msg_iter, READ, vec, 1, wanted);
+		iov_iter_kvec(&msg.msg_iter, ITER_DEST, vec, 1, wanted);
 	} else {
 		vec[0].iov_base = data->in + masked_prod;
 		vec[0].iov_len = array_size - masked_prod;
 		vec[1].iov_base = data->in;
 		vec[1].iov_len = wanted - vec[0].iov_len;
-		iov_iter_kvec(&msg.msg_iter, READ, vec, 2, wanted);
+		iov_iter_kvec(&msg.msg_iter, ITER_DEST, vec, 2, wanted);
 	}
 
 	atomic_set(&map->read, 0);
@@ -188,13 +188,13 @@ static bool pvcalls_conn_back_write(struct sock_mapping *map)
 	if (pvcalls_mask(prod, array_size) > pvcalls_mask(cons, array_size)) {
 		vec[0].iov_base = data->out + pvcalls_mask(cons, array_size);
 		vec[0].iov_len = size;
-		iov_iter_kvec(&msg.msg_iter, WRITE, vec, 1, size);
+		iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, vec, 1, size);
 	} else {
 		vec[0].iov_base = data->out + pvcalls_mask(cons, array_size);
 		vec[0].iov_len = array_size - pvcalls_mask(cons, array_size);
 		vec[1].iov_base = data->out;
 		vec[1].iov_len = size - vec[0].iov_len;
-		iov_iter_kvec(&msg.msg_iter, WRITE, vec, 2, size);
+		iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, vec, 2, size);
 	}
 
 	atomic_set(&map->write, 0);
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 47b9a1122f34..a19891015f19 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -40,7 +40,7 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
 	size_t len = subreq->len   - subreq->transferred;
 	int total, err;
 
-	iov_iter_xarray(&to, READ, &rreq->mapping->i_pages, pos, len);
+	iov_iter_xarray(&to, ITER_DEST, &rreq->mapping->i_pages, pos, len);
 
 	total = p9_client_read(fid, pos, &to, &err);
 
@@ -172,7 +172,7 @@ static int v9fs_vfs_write_folio_locked(struct folio *folio)
 
 	len = min_t(loff_t, i_size - start, len);
 
-	iov_iter_xarray(&from, WRITE, &folio_mapping(folio)->i_pages, start, len);
+	iov_iter_xarray(&from, ITER_SOURCE, &folio_mapping(folio)->i_pages, start, len);
 
 	/* We should have writeback_fid always set */
 	BUG_ON(!v9inode->writeback_fid);
diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index 000fbaae9b18..3bb95adc9619 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -109,7 +109,7 @@ static int v9fs_dir_readdir(struct file *file, struct dir_context *ctx)
 			struct iov_iter to;
 			int n;
 
-			iov_iter_kvec(&to, READ, &kvec, 1, buflen);
+			iov_iter_kvec(&to, ITER_DEST, &kvec, 1, buflen);
 			n = p9_client_read(file->private_data, ctx->pos, &to,
 					   &err);
 			if (err)
diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
index 1f9298a4bd42..2807bb63f780 100644
--- a/fs/9p/xattr.c
+++ b/fs/9p/xattr.c
@@ -24,7 +24,7 @@ ssize_t v9fs_fid_xattr_get(struct p9_fid *fid, const char *name,
 	struct iov_iter to;
 	int err;
 
-	iov_iter_kvec(&to, READ, &kvec, 1, buffer_size);
+	iov_iter_kvec(&to, ITER_DEST, &kvec, 1, buffer_size);
 
 	attr_fid = p9_client_xattrwalk(fid, name, &attr_size);
 	if (IS_ERR(attr_fid)) {
@@ -109,7 +109,7 @@ int v9fs_fid_xattr_set(struct p9_fid *fid, const char *name,
 	struct iov_iter from;
 	int retval, err;
 
-	iov_iter_kvec(&from, WRITE, &kvec, 1, value_len);
+	iov_iter_kvec(&from, ITER_SOURCE, &kvec, 1, value_len);
 
 	p9_debug(P9_DEBUG_VFS, "name = %s value_len = %zu flags = %d\n",
 		 name, value_len, flags);
diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index 0a090d614e76..7dcd59693a0c 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -298,7 +298,7 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 		if (call->count2 != call->count && call->count2 != 0)
 			return afs_protocol_error(call, afs_eproto_cb_count);
 		call->iter = &call->def_iter;
-		iov_iter_discard(&call->def_iter, READ, call->count2 * 3 * 4);
+		iov_iter_discard(&call->def_iter, ITER_DEST, call->count2 * 3 * 4);
 		call->unmarshall++;
 
 		fallthrough;
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 230c2d19116d..104df2964225 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -305,7 +305,7 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 	req->actual_len = i_size; /* May change */
 	req->len = nr_pages * PAGE_SIZE; /* We can ask for more than there is */
 	req->data_version = dvnode->status.data_version; /* May change */
-	iov_iter_xarray(&req->def_iter, READ, &dvnode->netfs.inode.i_mapping->i_pages,
+	iov_iter_xarray(&req->def_iter, ITER_DEST, &dvnode->netfs.inode.i_mapping->i_pages,
 			0, i_size);
 	req->iter = &req->def_iter;
 
diff --git a/fs/afs/file.c b/fs/afs/file.c
index d1cfb235c4b9..2eeab57df133 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -324,7 +324,7 @@ static void afs_issue_read(struct netfs_io_subrequest *subreq)
 	fsreq->vnode	= vnode;
 	fsreq->iter	= &fsreq->def_iter;
 
-	iov_iter_xarray(&fsreq->def_iter, READ,
+	iov_iter_xarray(&fsreq->def_iter, ITER_DEST,
 			&fsreq->vnode->netfs.inode.i_mapping->i_pages,
 			fsreq->pos, fsreq->len);
 
@@ -346,7 +346,7 @@ static int afs_symlink_read_folio(struct file *file, struct folio *folio)
 	fsreq->len	= folio_size(folio);
 	fsreq->vnode	= vnode;
 	fsreq->iter	= &fsreq->def_iter;
-	iov_iter_xarray(&fsreq->def_iter, READ, &folio->mapping->i_pages,
+	iov_iter_xarray(&fsreq->def_iter, ITER_DEST, &folio->mapping->i_pages,
 			fsreq->pos, fsreq->len);
 
 	ret = afs_fetch_data(fsreq->vnode, fsreq);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 723d162078a3..9ba7b68375c9 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1301,7 +1301,7 @@ static inline void afs_extract_begin(struct afs_call *call, void *buf, size_t si
 	call->iov_len = size;
 	call->kvec[0].iov_base = buf;
 	call->kvec[0].iov_len = size;
-	iov_iter_kvec(&call->def_iter, READ, call->kvec, 1, size);
+	iov_iter_kvec(&call->def_iter, ITER_DEST, call->kvec, 1, size);
 }
 
 static inline void afs_extract_to_tmp(struct afs_call *call)
@@ -1319,7 +1319,7 @@ static inline void afs_extract_to_tmp64(struct afs_call *call)
 static inline void afs_extract_discard(struct afs_call *call, size_t size)
 {
 	call->iov_len = size;
-	iov_iter_discard(&call->def_iter, READ, size);
+	iov_iter_discard(&call->def_iter, ITER_DEST, size);
 }
 
 static inline void afs_extract_to_buf(struct afs_call *call, size_t size)
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index eccc3cd0cb70..c62939e5ea1f 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -359,7 +359,7 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 
 	msg.msg_name		= NULL;
 	msg.msg_namelen		= 0;
-	iov_iter_kvec(&msg.msg_iter, WRITE, iov, 1, call->request_size);
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, iov, 1, call->request_size);
 	msg.msg_control		= NULL;
 	msg.msg_controllen	= 0;
 	msg.msg_flags		= MSG_WAITALL | (call->write_iter ? MSG_MORE : 0);
@@ -400,7 +400,7 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 					RX_USER_ABORT, ret, "KSD");
 	} else {
 		len = 0;
-		iov_iter_kvec(&msg.msg_iter, READ, NULL, 0, 0);
+		iov_iter_kvec(&msg.msg_iter, ITER_DEST, NULL, 0, 0);
 		rxrpc_kernel_recv_data(call->net->socket, rxcall,
 				       &msg.msg_iter, &len, false,
 				       &call->abort_code, &call->service_id);
@@ -485,7 +485,7 @@ static void afs_deliver_to_call(struct afs_call *call)
 	       ) {
 		if (state == AFS_CALL_SV_AWAIT_ACK) {
 			len = 0;
-			iov_iter_kvec(&call->def_iter, READ, NULL, 0, 0);
+			iov_iter_kvec(&call->def_iter, ITER_DEST, NULL, 0, 0);
 			ret = rxrpc_kernel_recv_data(call->net->socket,
 						     call->rxcall, &call->def_iter,
 						     &len, false, &remote_abort,
@@ -822,7 +822,7 @@ void afs_send_empty_reply(struct afs_call *call)
 
 	msg.msg_name		= NULL;
 	msg.msg_namelen		= 0;
-	iov_iter_kvec(&msg.msg_iter, WRITE, NULL, 0, 0);
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, NULL, 0, 0);
 	msg.msg_control		= NULL;
 	msg.msg_controllen	= 0;
 	msg.msg_flags		= 0;
@@ -862,7 +862,7 @@ void afs_send_simple_reply(struct afs_call *call, const void *buf, size_t len)
 	iov[0].iov_len		= len;
 	msg.msg_name		= NULL;
 	msg.msg_namelen		= 0;
-	iov_iter_kvec(&msg.msg_iter, WRITE, iov, 1, len);
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, iov, 1, len);
 	msg.msg_control		= NULL;
 	msg.msg_controllen	= 0;
 	msg.msg_flags		= 0;
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 9ebdd36eaf2f..08fd456dde67 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -609,7 +609,7 @@ static ssize_t afs_write_back_from_locked_folio(struct address_space *mapping,
 		 */
 		afs_write_to_cache(vnode, start, len, i_size, caching);
 
-		iov_iter_xarray(&iter, WRITE, &mapping->i_pages, start, len);
+		iov_iter_xarray(&iter, ITER_SOURCE, &mapping->i_pages, start, len);
 		ret = afs_store_data(vnode, &iter, start, false);
 	} else {
 		_debug("write discard %x @%llx [%llx]", len, start, i_size);
@@ -1000,7 +1000,7 @@ int afs_launder_folio(struct folio *folio)
 		bv[0].bv_page = &folio->page;
 		bv[0].bv_offset = f;
 		bv[0].bv_len = t - f;
-		iov_iter_bvec(&iter, WRITE, bv, 1, bv[0].bv_len);
+		iov_iter_bvec(&iter, ITER_SOURCE, bv, 1, bv[0].bv_len);
 
 		trace_afs_folio_dirty(vnode, tracepoint_string("launder"), folio);
 		ret = afs_store_data(vnode, &iter, folio_pos(folio) + f, true);
diff --git a/fs/aio.c b/fs/aio.c
index 5b2ff20ad322..562916d85cba 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1552,7 +1552,7 @@ static int aio_read(struct kiocb *req, const struct iocb *iocb,
 	if (unlikely(!file->f_op->read_iter))
 		return -EINVAL;
 
-	ret = aio_setup_rw(READ, iocb, &iovec, vectored, compat, &iter);
+	ret = aio_setup_rw(ITER_DEST, iocb, &iovec, vectored, compat, &iter);
 	if (ret < 0)
 		return ret;
 	ret = rw_verify_area(READ, file, &req->ki_pos, iov_iter_count(&iter));
@@ -1580,7 +1580,7 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 	if (unlikely(!file->f_op->write_iter))
 		return -EINVAL;
 
-	ret = aio_setup_rw(WRITE, iocb, &iovec, vectored, compat, &iter);
+	ret = aio_setup_rw(ITER_SOURCE, iocb, &iovec, vectored, compat, &iter);
 	if (ret < 0)
 		return ret;
 	ret = rw_verify_area(WRITE, file, &req->ki_pos, iov_iter_count(&iter));
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d5dd8bed1488..a59c884c2cb0 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -5283,7 +5283,7 @@ static int btrfs_ioctl_encoded_read(struct file *file, void __user *argp,
 		goto out_acct;
 	}
 
-	ret = import_iovec(READ, args.iov, args.iovcnt, ARRAY_SIZE(iovstack),
+	ret = import_iovec(ITER_DEST, args.iov, args.iovcnt, ARRAY_SIZE(iovstack),
 			   &iov, &iter);
 	if (ret < 0)
 		goto out_acct;
@@ -5382,7 +5382,7 @@ static int btrfs_ioctl_encoded_write(struct file *file, void __user *argp, bool
 	if (args.len > args.unencoded_len - args.unencoded_offset)
 		goto out_acct;
 
-	ret = import_iovec(WRITE, args.iov, args.iovcnt, ARRAY_SIZE(iovstack),
+	ret = import_iovec(ITER_SOURCE, args.iov, args.iovcnt, ARRAY_SIZE(iovstack),
 			   &iov, &iter);
 	if (ret < 0)
 		goto out_acct;
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index dcf701b05cc1..61f47debec5a 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -288,7 +288,7 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 	}
 
 	len = min_t(size_t, iinfo->inline_len - subreq->start, subreq->len);
-	iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages, subreq->start, len);
+	iov_iter_xarray(&iter, ITER_DEST, &rreq->mapping->i_pages, subreq->start, len);
 	err = copy_to_iter(iinfo->inline_data + subreq->start, len, &iter);
 	if (err == 0)
 		err = -EFAULT;
@@ -327,7 +327,7 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 	}
 
 	dout("%s: pos=%llu orig_len=%zu len=%llu\n", __func__, subreq->start, subreq->len, len);
-	iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages, subreq->start, len);
+	iov_iter_xarray(&iter, ITER_DEST, &rreq->mapping->i_pages, subreq->start, len);
 	err = iov_iter_get_pages_alloc2(&iter, &pages, len, &page_off);
 	if (err < 0) {
 		dout("%s: iov_ter_get_pages_alloc returned %d\n", __func__, err);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 04fd34557de8..6f9580defb2b 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1161,7 +1161,7 @@ static void ceph_aio_complete_req(struct ceph_osd_request *req)
 				aio_req->total_len = rc + zlen;
 			}
 
-			iov_iter_bvec(&i, READ, osd_data->bvec_pos.bvecs,
+			iov_iter_bvec(&i, ITER_DEST, osd_data->bvec_pos.bvecs,
 				      osd_data->num_bvecs, len);
 			iov_iter_advance(&i, rc);
 			iov_iter_zero(zlen, &i);
@@ -1400,7 +1400,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 				int zlen = min_t(size_t, len - ret,
 						 size - pos - ret);
 
-				iov_iter_bvec(&i, READ, bvecs, num_pages, len);
+				iov_iter_bvec(&i, ITER_DEST, bvecs, num_pages, len);
 				iov_iter_advance(&i, ret);
 				iov_iter_zero(zlen, &i);
 				ret += zlen;
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index ffb291579bb9..2ad5c0c0a7fe 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -759,7 +759,7 @@ cifs_read_from_socket(struct TCP_Server_Info *server, char *buf,
 {
 	struct msghdr smb_msg = {};
 	struct kvec iov = {.iov_base = buf, .iov_len = to_read};
-	iov_iter_kvec(&smb_msg.msg_iter, READ, &iov, 1, to_read);
+	iov_iter_kvec(&smb_msg.msg_iter, ITER_DEST, &iov, 1, to_read);
 
 	return cifs_readv_from_socket(server, &smb_msg);
 }
@@ -774,7 +774,7 @@ cifs_discard_from_socket(struct TCP_Server_Info *server, size_t to_read)
 	 *  and cifs_readv_from_socket sets msg_control and msg_controllen
 	 *  so little to initialize in struct msghdr
 	 */
-	iov_iter_discard(&smb_msg.msg_iter, READ, to_read);
+	iov_iter_discard(&smb_msg.msg_iter, ITER_DEST, to_read);
 
 	return cifs_readv_from_socket(server, &smb_msg);
 }
@@ -786,7 +786,7 @@ cifs_read_page_from_socket(struct TCP_Server_Info *server, struct page *page,
 	struct msghdr smb_msg = {};
 	struct bio_vec bv = {
 		.bv_page = page, .bv_len = to_read, .bv_offset = page_offset};
-	iov_iter_bvec(&smb_msg.msg_iter, READ, &bv, 1, to_read);
+	iov_iter_bvec(&smb_msg.msg_iter, ITER_DEST, &bv, 1, to_read);
 	return cifs_readv_from_socket(server, &smb_msg);
 }
 
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index f6ffee514c34..e9ccec4d3dcd 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3522,7 +3522,7 @@ static ssize_t __cifs_writev(
 		ctx->iter = *from;
 		ctx->len = len;
 	} else {
-		rc = setup_aio_ctx_iter(ctx, from, WRITE);
+		rc = setup_aio_ctx_iter(ctx, from, ITER_SOURCE);
 		if (rc) {
 			kref_put(&ctx->refcount, cifs_aio_ctx_release);
 			return rc;
@@ -4266,7 +4266,7 @@ static ssize_t __cifs_readv(
 		ctx->iter = *to;
 		ctx->len = len;
 	} else {
-		rc = setup_aio_ctx_iter(ctx, to, READ);
+		rc = setup_aio_ctx_iter(ctx, to, ITER_DEST);
 		if (rc) {
 			kref_put(&ctx->refcount, cifs_aio_ctx_release);
 			return rc;
diff --git a/fs/cifs/fscache.c b/fs/cifs/fscache.c
index a1751b956318..f6f3a6b75601 100644
--- a/fs/cifs/fscache.c
+++ b/fs/cifs/fscache.c
@@ -150,7 +150,7 @@ static int fscache_fallback_read_page(struct inode *inode, struct page *page)
 	bvec[0].bv_page		= page;
 	bvec[0].bv_offset	= 0;
 	bvec[0].bv_len		= PAGE_SIZE;
-	iov_iter_bvec(&iter, READ, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
+	iov_iter_bvec(&iter, ITER_DEST, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
 
 	ret = fscache_begin_read_operation(&cres, cookie);
 	if (ret < 0)
@@ -180,7 +180,7 @@ static int fscache_fallback_write_page(struct inode *inode, struct page *page,
 	bvec[0].bv_page		= page;
 	bvec[0].bv_offset	= 0;
 	bvec[0].bv_len		= PAGE_SIZE;
-	iov_iter_bvec(&iter, WRITE, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
+	iov_iter_bvec(&iter, ITER_SOURCE, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
 
 	ret = fscache_begin_write_operation(&cres, cookie);
 	if (ret < 0)
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 17b25153cb68..befd3b129ed2 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -4712,13 +4712,13 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 			return 0;
 		}
 
-		iov_iter_bvec(&iter, WRITE, bvec, npages, data_len);
+		iov_iter_bvec(&iter, ITER_SOURCE, bvec, npages, data_len);
 	} else if (buf_len >= data_offset + data_len) {
 		/* read response payload is in buf */
 		WARN_ONCE(npages > 0, "read data can be either in buf or in pages");
 		iov.iov_base = buf + data_offset;
 		iov.iov_len = data_len;
-		iov_iter_kvec(&iter, WRITE, &iov, 1, data_len);
+		iov_iter_kvec(&iter, ITER_SOURCE, &iov, 1, data_len);
 	} else {
 		/* read response payload cannot be in both buf and pages */
 		WARN_ONCE(1, "buf can not contain only a part of read data");
diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index 575fa8f58342..3851d0aaa288 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -347,7 +347,7 @@ __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 			.iov_base = &rfc1002_marker,
 			.iov_len  = 4
 		};
-		iov_iter_kvec(&smb_msg.msg_iter, WRITE, &hiov, 1, 4);
+		iov_iter_kvec(&smb_msg.msg_iter, ITER_SOURCE, &hiov, 1, 4);
 		rc = smb_send_kvec(server, &smb_msg, &sent);
 		if (rc < 0)
 			goto unmask;
@@ -368,7 +368,7 @@ __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 			size += iov[i].iov_len;
 		}
 
-		iov_iter_kvec(&smb_msg.msg_iter, WRITE, iov, n_vec, size);
+		iov_iter_kvec(&smb_msg.msg_iter, ITER_SOURCE, iov, n_vec, size);
 
 		rc = smb_send_kvec(server, &smb_msg, &sent);
 		if (rc < 0)
@@ -384,7 +384,7 @@ __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 			rqst_page_get_length(&rqst[j], i, &bvec.bv_len,
 					     &bvec.bv_offset);
 
-			iov_iter_bvec(&smb_msg.msg_iter, WRITE,
+			iov_iter_bvec(&smb_msg.msg_iter, ITER_SOURCE,
 				      &bvec, 1, bvec.bv_len);
 			rc = smb_send_kvec(server, &smb_msg, &sent);
 			if (rc < 0)
diff --git a/fs/coredump.c b/fs/coredump.c
index 7bad7785e8e6..095ed821c8ac 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -853,7 +853,7 @@ static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 	if (dump_interrupted())
 		return 0;
 	pos = file->f_pos;
-	iov_iter_bvec(&iter, WRITE, &bvec, 1, PAGE_SIZE);
+	iov_iter_bvec(&iter, ITER_SOURCE, &bvec, 1, PAGE_SIZE);
 	n = __kernel_write_iter(cprm->file, &iter, &pos);
 	if (n != PAGE_SIZE)
 		return 0;
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 998cd26a1b3b..c08b3a0e4014 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -190,7 +190,7 @@ static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
 
 		atomic_inc(&rreq->nr_outstanding);
 
-		iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages,
+		iov_iter_xarray(&iter, ITER_DEST, &rreq->mapping->i_pages,
 				start + done, subreq->len);
 
 		ret = fscache_read(cres, subreq->start, &iter,
@@ -286,7 +286,7 @@ static int erofs_fscache_data_read(struct address_space *mapping,
 		if (IS_ERR(src))
 			return PTR_ERR(src);
 
-		iov_iter_xarray(&iter, READ, &mapping->i_pages, pos, PAGE_SIZE);
+		iov_iter_xarray(&iter, ITER_DEST, &mapping->i_pages, pos, PAGE_SIZE);
 		if (copy_to_iter(src + offset, size, &iter) != size)
 			return -EFAULT;
 		iov_iter_zero(PAGE_SIZE - size, &iter);
@@ -298,7 +298,7 @@ static int erofs_fscache_data_read(struct address_space *mapping,
 	DBG_BUGON(!count || count % PAGE_SIZE);
 
 	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
-		iov_iter_xarray(&iter, READ, &mapping->i_pages, pos, count);
+		iov_iter_xarray(&iter, ITER_DEST, &mapping->i_pages, pos, count);
 		iov_iter_zero(count, &iter);
 		return count;
 	}
diff --git a/fs/fscache/io.c b/fs/fscache/io.c
index 3af3b08a9bb3..0d2b8dec8f82 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -286,7 +286,7 @@ void __fscache_write_to_cache(struct fscache_cookie *cookie,
 	 * taken into account.
 	 */
 
-	iov_iter_xarray(&iter, WRITE, &mapping->i_pages, start, len);
+	iov_iter_xarray(&iter, ITER_SOURCE, &mapping->i_pages, start, len);
 	fscache_write(cres, start, &iter, fscache_wreq_done, wreq);
 	return;
 
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index 61d8afcb10a3..fcce94ace2c2 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -255,7 +255,7 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
 		ap.args.in_pages = true;
 
 		err = -EFAULT;
-		iov_iter_init(&ii, WRITE, in_iov, in_iovs, in_size);
+		iov_iter_init(&ii, ITER_SOURCE, in_iov, in_iovs, in_size);
 		for (i = 0; iov_iter_count(&ii) && !WARN_ON(i >= ap.num_pages); i++) {
 			c = copy_page_from_iter(ap.pages[i], 0, PAGE_SIZE, &ii);
 			if (c != PAGE_SIZE && iov_iter_count(&ii))
@@ -324,7 +324,7 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
 		goto out;
 
 	err = -EFAULT;
-	iov_iter_init(&ii, READ, out_iov, out_iovs, transferred);
+	iov_iter_init(&ii, ITER_DEST, out_iov, out_iovs, transferred);
 	for (i = 0; iov_iter_count(&ii) && !WARN_ON(i >= ap.num_pages); i++) {
 		c = copy_page_to_iter(ap.pages[i], 0, PAGE_SIZE, &ii);
 		if (c != PAGE_SIZE && iov_iter_count(&ii))
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 428925899282..f8cc449e5954 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -23,7 +23,7 @@ static void netfs_clear_unread(struct netfs_io_subrequest *subreq)
 {
 	struct iov_iter iter;
 
-	iov_iter_xarray(&iter, READ, &subreq->rreq->mapping->i_pages,
+	iov_iter_xarray(&iter, ITER_DEST, &subreq->rreq->mapping->i_pages,
 			subreq->start + subreq->transferred,
 			subreq->len   - subreq->transferred);
 	iov_iter_zero(iov_iter_count(&iter), &iter);
@@ -49,7 +49,7 @@ static void netfs_read_from_cache(struct netfs_io_request *rreq,
 	struct iov_iter iter;
 
 	netfs_stat(&netfs_n_rh_read);
-	iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages,
+	iov_iter_xarray(&iter, ITER_DEST, &rreq->mapping->i_pages,
 			subreq->start + subreq->transferred,
 			subreq->len   - subreq->transferred);
 
@@ -205,7 +205,7 @@ static void netfs_rreq_do_write_to_cache(struct netfs_io_request *rreq)
 			continue;
 		}
 
-		iov_iter_xarray(&iter, WRITE, &rreq->mapping->i_pages,
+		iov_iter_xarray(&iter, ITER_SOURCE, &rreq->mapping->i_pages,
 				subreq->start, subreq->len);
 
 		atomic_inc(&rreq->nr_copy_ops);
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index e861d7bae305..e731c00a9fcb 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -252,7 +252,7 @@ static int fscache_fallback_read_page(struct inode *inode, struct page *page)
 	bvec[0].bv_page		= page;
 	bvec[0].bv_offset	= 0;
 	bvec[0].bv_len		= PAGE_SIZE;
-	iov_iter_bvec(&iter, READ, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
+	iov_iter_bvec(&iter, ITER_DEST, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
 
 	ret = fscache_begin_read_operation(&cres, cookie);
 	if (ret < 0)
@@ -282,7 +282,7 @@ static int fscache_fallback_write_page(struct inode *inode, struct page *page,
 	bvec[0].bv_page		= page;
 	bvec[0].bv_offset	= 0;
 	bvec[0].bv_len		= PAGE_SIZE;
-	iov_iter_bvec(&iter, WRITE, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
+	iov_iter_bvec(&iter, ITER_SOURCE, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
 
 	ret = fscache_begin_write_operation(&cres, cookie);
 	if (ret < 0)
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index f650afedd67f..51f453baa952 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -942,7 +942,7 @@ __be32 nfsd_readv(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	ssize_t host_err;
 
 	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
-	iov_iter_kvec(&iter, READ, vec, vlen, *count);
+	iov_iter_kvec(&iter, ITER_DEST, vec, vlen, *count);
 	host_err = vfs_iter_read(file, &iter, &ppos, 0);
 	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
 }
@@ -1032,7 +1032,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	if (stable && !use_wgather)
 		flags |= RWF_SYNC;
 
-	iov_iter_kvec(&iter, WRITE, vec, vlen, *cnt);
+	iov_iter_kvec(&iter, ITER_SOURCE, vec, vlen, *cnt);
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
 		nfsd_copy_write_verifier(verf, nn);
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index f660c0dbdb63..785cabd71d67 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -900,7 +900,7 @@ static int o2net_recv_tcp_msg(struct socket *sock, void *data, size_t len)
 {
 	struct kvec vec = { .iov_len = len, .iov_base = data, };
 	struct msghdr msg = { .msg_flags = MSG_DONTWAIT, };
-	iov_iter_kvec(&msg.msg_iter, READ, &vec, 1, len);
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &vec, 1, len);
 	return sock_recvmsg(sock, &msg, MSG_DONTWAIT);
 }
 
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 7a8c0c6e698d..b3bbb5a5787a 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -53,7 +53,7 @@ static int orangefs_writepage_locked(struct page *page,
 	bv.bv_len = wlen;
 	bv.bv_offset = off % PAGE_SIZE;
 	WARN_ON(wlen == 0);
-	iov_iter_bvec(&iter, WRITE, &bv, 1, wlen);
+	iov_iter_bvec(&iter, ITER_SOURCE, &bv, 1, wlen);
 
 	ret = wait_for_direct_io(ORANGEFS_IO_WRITE, inode, &off, &iter, wlen,
 	    len, wr, NULL, NULL);
@@ -112,7 +112,7 @@ static int orangefs_writepages_work(struct orangefs_writepages *ow,
 		else
 			ow->bv[i].bv_offset = 0;
 	}
-	iov_iter_bvec(&iter, WRITE, ow->bv, ow->npages, ow->len);
+	iov_iter_bvec(&iter, ITER_SOURCE, ow->bv, ow->npages, ow->len);
 
 	WARN_ON(ow->off >= len);
 	if (ow->off + ow->len > len)
@@ -270,7 +270,7 @@ static void orangefs_readahead(struct readahead_control *rac)
 	offset = readahead_pos(rac);
 	i_pages = &rac->mapping->i_pages;
 
-	iov_iter_xarray(&iter, READ, i_pages, offset, readahead_length(rac));
+	iov_iter_xarray(&iter, ITER_DEST, i_pages, offset, readahead_length(rac));
 
 	/* read in the pages. */
 	if ((ret = wait_for_direct_io(ORANGEFS_IO_READ, inode,
@@ -303,7 +303,7 @@ static int orangefs_read_folio(struct file *file, struct folio *folio)
 	bv.bv_page = &folio->page;
 	bv.bv_len = folio_size(folio);
 	bv.bv_offset = 0;
-	iov_iter_bvec(&iter, READ, &bv, 1, folio_size(folio));
+	iov_iter_bvec(&iter, ITER_DEST, &bv, 1, folio_size(folio));
 
 	ret = wait_for_direct_io(ORANGEFS_IO_READ, inode, &off, &iter,
 			folio_size(folio), inode->i_size, NULL, NULL, file);
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index f2aa86c421f2..5aa527ca6dbe 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -199,7 +199,7 @@ ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
 	struct kvec kvec = { .iov_base = buf, .iov_len = count };
 	struct iov_iter iter;
 
-	iov_iter_kvec(&iter, READ, &kvec, 1, count);
+	iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, count);
 
 	return read_from_oldmem(&iter, count, ppos, false);
 }
@@ -212,7 +212,7 @@ ssize_t __weak elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos)
 	struct kvec kvec = { .iov_base = buf, .iov_len = count };
 	struct iov_iter iter;
 
-	iov_iter_kvec(&iter, READ, &kvec, 1, count);
+	iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, count);
 
 	return read_from_oldmem(&iter, count, ppos,
 			cc_platform_has(CC_ATTR_MEM_ENCRYPT));
@@ -437,7 +437,7 @@ static vm_fault_t mmap_vmcore_fault(struct vm_fault *vmf)
 		offset = (loff_t) index << PAGE_SHIFT;
 		kvec.iov_base = page_address(page);
 		kvec.iov_len = PAGE_SIZE;
-		iov_iter_kvec(&iter, READ, &kvec, 1, PAGE_SIZE);
+		iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, PAGE_SIZE);
 
 		rc = __read_vmcore(&iter, &offset);
 		if (rc < 0) {
diff --git a/fs/read_write.c b/fs/read_write.c
index 328ce8cf9a85..37c2f28b51e8 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -384,7 +384,7 @@ static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, lo
 
 	init_sync_kiocb(&kiocb, filp);
 	kiocb.ki_pos = (ppos ? *ppos : 0);
-	iov_iter_ubuf(&iter, READ, buf, len);
+	iov_iter_ubuf(&iter, ITER_DEST, buf, len);
 
 	ret = call_read_iter(filp, &kiocb, &iter);
 	BUG_ON(ret == -EIOCBQUEUED);
@@ -424,7 +424,7 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 
 	init_sync_kiocb(&kiocb, file);
 	kiocb.ki_pos = pos ? *pos : 0;
-	iov_iter_kvec(&iter, READ, &iov, 1, iov.iov_len);
+	iov_iter_kvec(&iter, ITER_DEST, &iov, 1, iov.iov_len);
 	ret = file->f_op->read_iter(&kiocb, &iter);
 	if (ret > 0) {
 		if (pos)
@@ -486,7 +486,7 @@ static ssize_t new_sync_write(struct file *filp, const char __user *buf, size_t
 
 	init_sync_kiocb(&kiocb, filp);
 	kiocb.ki_pos = (ppos ? *ppos : 0);
-	iov_iter_ubuf(&iter, WRITE, (void __user *)buf, len);
+	iov_iter_ubuf(&iter, ITER_SOURCE, (void __user *)buf, len);
 
 	ret = call_write_iter(filp, &kiocb, &iter);
 	BUG_ON(ret == -EIOCBQUEUED);
@@ -533,7 +533,7 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
 		.iov_len	= min_t(size_t, count, MAX_RW_COUNT),
 	};
 	struct iov_iter iter;
-	iov_iter_kvec(&iter, WRITE, &iov, 1, iov.iov_len);
+	iov_iter_kvec(&iter, ITER_SOURCE, &iov, 1, iov.iov_len);
 	return __kernel_write_iter(file, &iter, pos);
 }
 /*
@@ -911,7 +911,7 @@ static ssize_t vfs_readv(struct file *file, const struct iovec __user *vec,
 	struct iov_iter iter;
 	ssize_t ret;
 
-	ret = import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
+	ret = import_iovec(ITER_DEST, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
 	if (ret >= 0) {
 		ret = do_iter_read(file, &iter, pos, flags);
 		kfree(iov);
@@ -928,7 +928,7 @@ static ssize_t vfs_writev(struct file *file, const struct iovec __user *vec,
 	struct iov_iter iter;
 	ssize_t ret;
 
-	ret = import_iovec(WRITE, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
+	ret = import_iovec(ITER_SOURCE, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
 	if (ret >= 0) {
 		file_start_write(file);
 		ret = do_iter_write(file, &iter, pos, flags);
diff --git a/fs/seq_file.c b/fs/seq_file.c
index 9456a2032224..f5fdaf3b1572 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -156,7 +156,7 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 	ssize_t ret;
 
 	init_sync_kiocb(&kiocb, file);
-	iov_iter_init(&iter, READ, &iov, 1, size);
+	iov_iter_init(&iter, ITER_DEST, &iov, 1, size);
 
 	kiocb.ki_pos = *ppos;
 	ret = seq_read_iter(&kiocb, &iter);
diff --git a/fs/splice.c b/fs/splice.c
index 0878b852b355..5969b7a1d353 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -303,7 +303,7 @@ ssize_t generic_file_splice_read(struct file *in, loff_t *ppos,
 	struct kiocb kiocb;
 	int ret;
 
-	iov_iter_pipe(&to, READ, pipe, len);
+	iov_iter_pipe(&to, ITER_DEST, pipe, len);
 	init_sync_kiocb(&kiocb, in);
 	kiocb.ki_pos = *ppos;
 	ret = call_read_iter(in, &kiocb, &to);
@@ -682,7 +682,7 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 			n++;
 		}
 
-		iov_iter_bvec(&from, WRITE, array, n, sd.total_len - left);
+		iov_iter_bvec(&from, ITER_SOURCE, array, n, sd.total_len - left);
 		ret = vfs_iter_write(out, &from, &sd.pos, 0);
 		if (ret <= 0)
 			break;
@@ -1263,9 +1263,9 @@ static int vmsplice_type(struct fd f, int *type)
 	if (!f.file)
 		return -EBADF;
 	if (f.file->f_mode & FMODE_WRITE) {
-		*type = WRITE;
+		*type = ITER_SOURCE;
 	} else if (f.file->f_mode & FMODE_READ) {
-		*type = READ;
+		*type = ITER_DEST;
 	} else {
 		fdput(f);
 		return -EBADF;
@@ -1314,7 +1314,7 @@ SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec __user *, uiov,
 
 	if (!iov_iter_count(&iter))
 		error = 0;
-	else if (iov_iter_rw(&iter) == WRITE)
+	else if (type == ITER_SOURCE)
 		error = vmsplice_to_pipe(f.file, &iter, flags);
 	else
 		error = vmsplice_to_user(f.file, &iter, flags);
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 2e3134b14ffd..87fc3d0dda98 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -29,6 +29,9 @@ enum iter_type {
 	ITER_UBUF,
 };
 
+#define ITER_SOURCE	1	// == WRITE
+#define ITER_DEST	0	// == READ
+
 struct iov_iter_state {
 	size_t iov_offset;
 	size_t count;
diff --git a/io_uring/net.c b/io_uring/net.c
index 8c7226b5bf41..7e409938cae6 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -365,7 +365,7 @@ int io_send(struct io_kiocb *req, unsigned int issue_flags)
 	if (unlikely(!sock))
 		return -ENOTSOCK;
 
-	ret = import_single_range(WRITE, sr->buf, sr->len, &iov, &msg.msg_iter);
+	ret = import_single_range(ITER_SOURCE, sr->buf, sr->len, &iov, &msg.msg_iter);
 	if (unlikely(ret))
 		return ret;
 
@@ -451,7 +451,7 @@ static int __io_recvmsg_copy_hdr(struct io_kiocb *req,
 		}
 	} else {
 		iomsg->free_iov = iomsg->fast_iov;
-		ret = __import_iovec(READ, msg.msg_iov, msg.msg_iovlen, UIO_FASTIOV,
+		ret = __import_iovec(ITER_DEST, msg.msg_iov, msg.msg_iovlen, UIO_FASTIOV,
 				     &iomsg->free_iov, &iomsg->msg.msg_iter,
 				     false);
 		if (ret > 0)
@@ -503,7 +503,7 @@ static int __io_compat_recvmsg_copy_hdr(struct io_kiocb *req,
 		}
 	} else {
 		iomsg->free_iov = iomsg->fast_iov;
-		ret = __import_iovec(READ, (struct iovec __user *)uiov, msg.msg_iovlen,
+		ret = __import_iovec(ITER_DEST, (struct iovec __user *)uiov, msg.msg_iovlen,
 				   UIO_FASTIOV, &iomsg->free_iov,
 				   &iomsg->msg.msg_iter, true);
 		if (ret < 0)
@@ -752,7 +752,7 @@ int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
 
 		kmsg->fast_iov[0].iov_base = buf;
 		kmsg->fast_iov[0].iov_len = len;
-		iov_iter_init(&kmsg->msg.msg_iter, READ, kmsg->fast_iov, 1,
+		iov_iter_init(&kmsg->msg.msg_iter, ITER_DEST, kmsg->fast_iov, 1,
 				len);
 	}
 
@@ -847,7 +847,7 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 		sr->buf = buf;
 	}
 
-	ret = import_single_range(READ, sr->buf, len, &iov, &msg.msg_iter);
+	ret = import_single_range(ITER_DEST, sr->buf, len, &iov, &msg.msg_iter);
 	if (unlikely(ret))
 		goto out_free;
 
@@ -1081,13 +1081,13 @@ int io_send_zc(struct io_kiocb *req, unsigned int issue_flags)
 		return io_setup_async_addr(req, &__address, issue_flags);
 
 	if (zc->flags & IORING_RECVSEND_FIXED_BUF) {
-		ret = io_import_fixed(WRITE, &msg.msg_iter, req->imu,
+		ret = io_import_fixed(ITER_SOURCE, &msg.msg_iter, req->imu,
 					(u64)(uintptr_t)zc->buf, zc->len);
 		if (unlikely(ret))
 			return ret;
 		msg.sg_from_iter = io_sg_from_iter;
 	} else {
-		ret = import_single_range(WRITE, zc->buf, zc->len, &iov,
+		ret = import_single_range(ITER_SOURCE, zc->buf, zc->len, &iov,
 					  &msg.msg_iter);
 		if (unlikely(ret))
 			return ret;
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 100de2626e47..b00929d70fe3 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -550,12 +550,12 @@ static inline int io_rw_prep_async(struct io_kiocb *req, int rw)
 
 int io_readv_prep_async(struct io_kiocb *req)
 {
-	return io_rw_prep_async(req, READ);
+	return io_rw_prep_async(req, ITER_DEST);
 }
 
 int io_writev_prep_async(struct io_kiocb *req)
 {
-	return io_rw_prep_async(req, WRITE);
+	return io_rw_prep_async(req, ITER_SOURCE);
 }
 
 /*
@@ -706,7 +706,7 @@ int io_read(struct io_kiocb *req, unsigned int issue_flags)
 	loff_t *ppos;
 
 	if (!req_has_async_data(req)) {
-		ret = io_import_iovec(READ, req, &iovec, s, issue_flags);
+		ret = io_import_iovec(ITER_DEST, req, &iovec, s, issue_flags);
 		if (unlikely(ret < 0))
 			return ret;
 	} else {
@@ -718,7 +718,7 @@ int io_read(struct io_kiocb *req, unsigned int issue_flags)
 		 * buffers, as we dropped the selected one before retry.
 		 */
 		if (io_do_buffer_select(req)) {
-			ret = io_import_iovec(READ, req, &iovec, s, issue_flags);
+			ret = io_import_iovec(ITER_DEST, req, &iovec, s, issue_flags);
 			if (unlikely(ret < 0))
 				return ret;
 		}
@@ -853,7 +853,7 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
 	loff_t *ppos;
 
 	if (!req_has_async_data(req)) {
-		ret = io_import_iovec(WRITE, req, &iovec, s, issue_flags);
+		ret = io_import_iovec(ITER_SOURCE, req, &iovec, s, issue_flags);
 		if (unlikely(ret < 0))
 			return ret;
 	} else {
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index ae78c2d53c8a..d25b055d23a6 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1486,7 +1486,7 @@ static ssize_t user_events_write(struct file *file, const char __user *ubuf,
 	if (unlikely(*ppos != 0))
 		return -EFAULT;
 
-	if (unlikely(import_single_range(WRITE, (char __user *)ubuf,
+	if (unlikely(import_single_range(ITER_SOURCE, (char __user *)ubuf,
 					 count, &iov, &i)))
 		return -EFAULT;
 
diff --git a/mm/madvise.c b/mm/madvise.c
index 2baa93ca2310..f76a08ffc669 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1449,7 +1449,7 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 		goto out;
 	}
 
-	ret = import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
+	ret = import_iovec(ITER_DEST, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
 	if (ret < 0)
 		goto out;
 
diff --git a/mm/page_io.c b/mm/page_io.c
index 2af34dd8fa4d..3a5f921b932e 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -376,7 +376,7 @@ void swap_write_unplug(struct swap_iocb *sio)
 	struct address_space *mapping = sio->iocb.ki_filp->f_mapping;
 	int ret;
 
-	iov_iter_bvec(&from, WRITE, sio->bvec, sio->pages, sio->len);
+	iov_iter_bvec(&from, ITER_SOURCE, sio->bvec, sio->pages, sio->len);
 	ret = mapping->a_ops->swap_rw(&sio->iocb, &from);
 	if (ret != -EIOCBQUEUED)
 		sio_write_complete(&sio->iocb, ret);
@@ -530,7 +530,7 @@ void __swap_read_unplug(struct swap_iocb *sio)
 	struct address_space *mapping = sio->iocb.ki_filp->f_mapping;
 	int ret;
 
-	iov_iter_bvec(&from, READ, sio->bvec, sio->pages, sio->len);
+	iov_iter_bvec(&from, ITER_DEST, sio->bvec, sio->pages, sio->len);
 	ret = mapping->a_ops->swap_rw(&sio->iocb, &from);
 	if (ret != -EIOCBQUEUED)
 		sio_read_complete(&sio->iocb, ret);
diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
index 4bcc11958089..78dfaf9e8990 100644
--- a/mm/process_vm_access.c
+++ b/mm/process_vm_access.c
@@ -263,7 +263,7 @@ static ssize_t process_vm_rw(pid_t pid,
 	struct iovec *iov_r;
 	struct iov_iter iter;
 	ssize_t rc;
-	int dir = vm_write ? WRITE : READ;
+	int dir = vm_write ? ITER_SOURCE : ITER_DEST;
 
 	if (flags != 0)
 		return -EINVAL;
diff --git a/net/9p/client.c b/net/9p/client.c
index aaa37b07e30a..0638b12055ba 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -2043,7 +2043,7 @@ int p9_client_readdir(struct p9_fid *fid, char *data, u32 count, u64 offset)
 	struct kvec kv = {.iov_base = data, .iov_len = count};
 	struct iov_iter to;
 
-	iov_iter_kvec(&to, READ, &kv, 1, count);
+	iov_iter_kvec(&to, ITER_DEST, &kv, 1, count);
 
 	p9_debug(P9_DEBUG_9P, ">>> TREADDIR fid %d offset %llu count %d\n",
 		 fid->fid, offset, count);
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 215af9b3b589..d57b2e3ece2a 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -441,7 +441,7 @@ static int send_pkt(struct l2cap_chan *chan, struct sk_buff *skb,
 	iv.iov_len = skb->len;
 
 	memset(&msg, 0, sizeof(msg));
-	iov_iter_kvec(&msg.msg_iter, WRITE, &iv, 1, skb->len);
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &iv, 1, skb->len);
 
 	err = l2cap_chan_send(chan, &msg, skb->len);
 	if (err > 0) {
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 1fcc482397c3..e7adb8a98cf9 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -56,7 +56,7 @@ static void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *dat
 
 	memset(&msg, 0, sizeof(msg));
 
-	iov_iter_kvec(&msg.msg_iter, WRITE, &iv, 1, total_len);
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &iv, 1, total_len);
 
 	l2cap_chan_send(chan, &msg, total_len);
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 11f853d0500f..70663229b3cc 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -605,7 +605,7 @@ static void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)
 
 	memset(&msg, 0, sizeof(msg));
 
-	iov_iter_kvec(&msg.msg_iter, WRITE, iv, 2, 1 + len);
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, iv, 2, 1 + len);
 
 	l2cap_chan_send(chan, &msg, 1 + len);
 
diff --git a/net/ceph/messenger_v1.c b/net/ceph/messenger_v1.c
index 3ddbde87e4d6..d1787d7d33ef 100644
--- a/net/ceph/messenger_v1.c
+++ b/net/ceph/messenger_v1.c
@@ -30,7 +30,7 @@ static int ceph_tcp_recvmsg(struct socket *sock, void *buf, size_t len)
 	if (!buf)
 		msg.msg_flags |= MSG_TRUNC;
 
-	iov_iter_kvec(&msg.msg_iter, READ, &iov, 1, len);
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, len);
 	r = sock_recvmsg(sock, &msg, msg.msg_flags);
 	if (r == -EAGAIN)
 		r = 0;
@@ -49,7 +49,7 @@ static int ceph_tcp_recvpage(struct socket *sock, struct page *page,
 	int r;
 
 	BUG_ON(page_offset + length > PAGE_SIZE);
-	iov_iter_bvec(&msg.msg_iter, READ, &bvec, 1, length);
+	iov_iter_bvec(&msg.msg_iter, ITER_DEST, &bvec, 1, length);
 	r = sock_recvmsg(sock, &msg, msg.msg_flags);
 	if (r == -EAGAIN)
 		r = 0;
diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
index cc8ff81a50b7..3009028c4fa2 100644
--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -168,7 +168,7 @@ static int do_try_sendpage(struct socket *sock, struct iov_iter *it)
 						  bv.bv_offset, bv.bv_len,
 						  CEPH_MSG_FLAGS);
 		} else {
-			iov_iter_bvec(&msg.msg_iter, WRITE, &bv, 1, bv.bv_len);
+			iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bv, 1, bv.bv_len);
 			ret = sock_sendmsg(sock, &msg);
 		}
 		if (ret <= 0) {
@@ -225,7 +225,7 @@ static void reset_in_kvecs(struct ceph_connection *con)
 	WARN_ON(iov_iter_count(&con->v2.in_iter));
 
 	con->v2.in_kvec_cnt = 0;
-	iov_iter_kvec(&con->v2.in_iter, READ, con->v2.in_kvecs, 0, 0);
+	iov_iter_kvec(&con->v2.in_iter, ITER_DEST, con->v2.in_kvecs, 0, 0);
 }
 
 static void set_in_bvec(struct ceph_connection *con, const struct bio_vec *bv)
@@ -233,7 +233,7 @@ static void set_in_bvec(struct ceph_connection *con, const struct bio_vec *bv)
 	WARN_ON(iov_iter_count(&con->v2.in_iter));
 
 	con->v2.in_bvec = *bv;
-	iov_iter_bvec(&con->v2.in_iter, READ, &con->v2.in_bvec, 1, bv->bv_len);
+	iov_iter_bvec(&con->v2.in_iter, ITER_DEST, &con->v2.in_bvec, 1, bv->bv_len);
 }
 
 static void set_in_skip(struct ceph_connection *con, int len)
@@ -241,7 +241,7 @@ static void set_in_skip(struct ceph_connection *con, int len)
 	WARN_ON(iov_iter_count(&con->v2.in_iter));
 
 	dout("%s con %p len %d\n", __func__, con, len);
-	iov_iter_discard(&con->v2.in_iter, READ, len);
+	iov_iter_discard(&con->v2.in_iter, ITER_DEST, len);
 }
 
 static void add_out_kvec(struct ceph_connection *con, void *buf, int len)
@@ -265,7 +265,7 @@ static void reset_out_kvecs(struct ceph_connection *con)
 
 	con->v2.out_kvec_cnt = 0;
 
-	iov_iter_kvec(&con->v2.out_iter, WRITE, con->v2.out_kvecs, 0, 0);
+	iov_iter_kvec(&con->v2.out_iter, ITER_SOURCE, con->v2.out_kvecs, 0, 0);
 	con->v2.out_iter_sendpage = false;
 }
 
@@ -277,7 +277,7 @@ static void set_out_bvec(struct ceph_connection *con, const struct bio_vec *bv,
 
 	con->v2.out_bvec = *bv;
 	con->v2.out_iter_sendpage = zerocopy;
-	iov_iter_bvec(&con->v2.out_iter, WRITE, &con->v2.out_bvec, 1,
+	iov_iter_bvec(&con->v2.out_iter, ITER_SOURCE, &con->v2.out_bvec, 1,
 		      con->v2.out_bvec.bv_len);
 }
 
@@ -290,7 +290,7 @@ static void set_out_bvec_zero(struct ceph_connection *con)
 	con->v2.out_bvec.bv_offset = 0;
 	con->v2.out_bvec.bv_len = min(con->v2.out_zero, (int)PAGE_SIZE);
 	con->v2.out_iter_sendpage = true;
-	iov_iter_bvec(&con->v2.out_iter, WRITE, &con->v2.out_bvec, 1,
+	iov_iter_bvec(&con->v2.out_iter, ITER_SOURCE, &con->v2.out_bvec, 1,
 		      con->v2.out_bvec.bv_len);
 }
 
diff --git a/net/compat.c b/net/compat.c
index 385f04a6be2f..161b7bea1f62 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -95,7 +95,8 @@ int get_compat_msghdr(struct msghdr *kmsg,
 	if (err)
 		return err;
 
-	err = import_iovec(save_addr ? READ : WRITE, compat_ptr(msg.msg_iov), msg.msg_iovlen,
+	err = import_iovec(save_addr ? ITER_DEST : ITER_SOURCE,
+			   compat_ptr(msg.msg_iov), msg.msg_iovlen,
 			   UIO_FASTIOV, iov, &kmsg->msg_iter);
 	return err < 0 ? err : 0;
 }
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f8232811a5be..112a33475dfb 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1999,7 +1999,7 @@ static int receive_fallback_to_copy(struct sock *sk,
 	if (copy_address != zc->copybuf_address)
 		return -EINVAL;
 
-	err = import_single_range(READ, (void __user *)copy_address,
+	err = import_single_range(ITER_DEST, (void __user *)copy_address,
 				  inq, &iov, &msg.msg_iter);
 	if (err)
 		return err;
@@ -2033,7 +2033,7 @@ static int tcp_copy_straggler_data(struct tcp_zerocopy_receive *zc,
 	if (copy_address != zc->copybuf_address)
 		return -EINVAL;
 
-	err = import_single_range(READ, (void __user *)copy_address,
+	err = import_single_range(ITER_DEST, (void __user *)copy_address,
 				  copylen, &iov, &msg.msg_iter);
 	if (err)
 		return err;
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index a56fd0b5a430..4963fec815da 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1617,7 +1617,7 @@ ip_vs_receive(struct socket *sock, char *buffer, const size_t buflen)
 	EnterFunction(7);
 
 	/* Receive a packet */
-	iov_iter_kvec(&msg.msg_iter, READ, &iov, 1, buflen);
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, buflen);
 	len = sock_recvmsg(sock, &msg, MSG_DONTWAIT);
 	if (len < 0)
 		return len;
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 1472f31480d8..dfb9797f7bc6 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -673,7 +673,7 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 	 */
 	krflags = MSG_PEEK | MSG_WAITALL;
 	clc_sk->sk_rcvtimeo = timeout;
-	iov_iter_kvec(&msg.msg_iter, READ, &vec, 1,
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &vec, 1,
 			sizeof(struct smc_clc_msg_hdr));
 	len = sock_recvmsg(smc->clcsock, &msg, krflags);
 	if (signal_pending(current)) {
@@ -720,7 +720,7 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 	} else {
 		recvlen = datlen;
 	}
-	iov_iter_kvec(&msg.msg_iter, READ, &vec, 1, recvlen);
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &vec, 1, recvlen);
 	krflags = MSG_WAITALL;
 	len = sock_recvmsg(smc->clcsock, &msg, krflags);
 	if (len < recvlen || !smc_clc_msg_hdr_valid(clcm, check_trl)) {
@@ -737,7 +737,7 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 		/* receive remaining proposal message */
 		recvlen = datlen > SMC_CLC_RECV_BUF_LEN ?
 						SMC_CLC_RECV_BUF_LEN : datlen;
-		iov_iter_kvec(&msg.msg_iter, READ, &vec, 1, recvlen);
+		iov_iter_kvec(&msg.msg_iter, ITER_DEST, &vec, 1, recvlen);
 		len = sock_recvmsg(smc->clcsock, &msg, krflags);
 		datlen -= len;
 	}
diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 64dedffe9d26..f4b6a71ac488 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -308,7 +308,7 @@ int smc_tx_sendpage(struct smc_sock *smc, struct page *page, int offset,
 
 	iov.iov_base = kaddr + offset;
 	iov.iov_len = size;
-	iov_iter_kvec(&msg.msg_iter, WRITE, &iov, 1, size);
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &iov, 1, size);
 	rc = smc_tx_sendmsg(smc, &msg, size);
 	kunmap(page);
 	return rc;
diff --git a/net/socket.c b/net/socket.c
index 00da9ce3dba0..73463c7c3702 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -750,7 +750,7 @@ EXPORT_SYMBOL(sock_sendmsg);
 int kernel_sendmsg(struct socket *sock, struct msghdr *msg,
 		   struct kvec *vec, size_t num, size_t size)
 {
-	iov_iter_kvec(&msg->msg_iter, WRITE, vec, num, size);
+	iov_iter_kvec(&msg->msg_iter, ITER_SOURCE, vec, num, size);
 	return sock_sendmsg(sock, msg);
 }
 EXPORT_SYMBOL(kernel_sendmsg);
@@ -776,7 +776,7 @@ int kernel_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 	if (!sock->ops->sendmsg_locked)
 		return sock_no_sendmsg_locked(sk, msg, size);
 
-	iov_iter_kvec(&msg->msg_iter, WRITE, vec, num, size);
+	iov_iter_kvec(&msg->msg_iter, ITER_SOURCE, vec, num, size);
 
 	return sock->ops->sendmsg_locked(sk, msg, msg_data_left(msg));
 }
@@ -1034,7 +1034,7 @@ int kernel_recvmsg(struct socket *sock, struct msghdr *msg,
 		   struct kvec *vec, size_t num, size_t size, int flags)
 {
 	msg->msg_control_is_user = false;
-	iov_iter_kvec(&msg->msg_iter, READ, vec, num, size);
+	iov_iter_kvec(&msg->msg_iter, ITER_DEST, vec, num, size);
 	return sock_recvmsg(sock, msg, flags);
 }
 EXPORT_SYMBOL(kernel_recvmsg);
@@ -2092,7 +2092,7 @@ int __sys_sendto(int fd, void __user *buff, size_t len, unsigned int flags,
 	struct iovec iov;
 	int fput_needed;
 
-	err = import_single_range(WRITE, buff, len, &iov, &msg.msg_iter);
+	err = import_single_range(ITER_SOURCE, buff, len, &iov, &msg.msg_iter);
 	if (unlikely(err))
 		return err;
 	sock = sockfd_lookup_light(fd, &err, &fput_needed);
@@ -2157,7 +2157,7 @@ int __sys_recvfrom(int fd, void __user *ubuf, size_t size, unsigned int flags,
 	int err, err2;
 	int fput_needed;
 
-	err = import_single_range(READ, ubuf, size, &iov, &msg.msg_iter);
+	err = import_single_range(ITER_DEST, ubuf, size, &iov, &msg.msg_iter);
 	if (unlikely(err))
 		return err;
 	sock = sockfd_lookup_light(fd, &err, &fput_needed);
@@ -2417,7 +2417,7 @@ static int copy_msghdr_from_user(struct msghdr *kmsg,
 	if (err)
 		return err;
 
-	err = import_iovec(save_addr ? READ : WRITE,
+	err = import_iovec(save_addr ? ITER_DEST : ITER_SOURCE,
 			    msg.msg_iov, msg.msg_iovlen,
 			    UIO_FASTIOV, iov, &kmsg->msg_iter);
 	return err < 0 ? err : 0;
diff --git a/net/sunrpc/socklib.c b/net/sunrpc/socklib.c
index 71ba4cf513bc..1b2b84feeec6 100644
--- a/net/sunrpc/socklib.c
+++ b/net/sunrpc/socklib.c
@@ -214,14 +214,14 @@ static inline int xprt_sendmsg(struct socket *sock, struct msghdr *msg,
 static int xprt_send_kvec(struct socket *sock, struct msghdr *msg,
 			  struct kvec *vec, size_t seek)
 {
-	iov_iter_kvec(&msg->msg_iter, WRITE, vec, 1, vec->iov_len);
+	iov_iter_kvec(&msg->msg_iter, ITER_SOURCE, vec, 1, vec->iov_len);
 	return xprt_sendmsg(sock, msg, seek);
 }
 
 static int xprt_send_pagedata(struct socket *sock, struct msghdr *msg,
 			      struct xdr_buf *xdr, size_t base)
 {
-	iov_iter_bvec(&msg->msg_iter, WRITE, xdr->bvec, xdr_buf_pagecount(xdr),
+	iov_iter_bvec(&msg->msg_iter, ITER_SOURCE, xdr->bvec, xdr_buf_pagecount(xdr),
 		      xdr->page_len + xdr->page_base);
 	return xprt_sendmsg(sock, msg, base + xdr->page_base);
 }
@@ -244,7 +244,7 @@ static int xprt_send_rm_and_kvec(struct socket *sock, struct msghdr *msg,
 	};
 	size_t len = iov[0].iov_len + iov[1].iov_len;
 
-	iov_iter_kvec(&msg->msg_iter, WRITE, iov, 2, len);
+	iov_iter_kvec(&msg->msg_iter, ITER_SOURCE, iov, 2, len);
 	return xprt_sendmsg(sock, msg, base);
 }
 
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 2fc98fea59b4..015714398007 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -260,7 +260,7 @@ static ssize_t svc_tcp_read_msg(struct svc_rqst *rqstp, size_t buflen,
 	rqstp->rq_respages = &rqstp->rq_pages[i];
 	rqstp->rq_next_page = rqstp->rq_respages + 1;
 
-	iov_iter_bvec(&msg.msg_iter, READ, bvec, i, buflen);
+	iov_iter_bvec(&msg.msg_iter, ITER_DEST, bvec, i, buflen);
 	if (seek) {
 		iov_iter_advance(&msg.msg_iter, seek);
 		buflen -= seek;
@@ -874,7 +874,7 @@ static ssize_t svc_tcp_read_marker(struct svc_sock *svsk,
 		want = sizeof(rpc_fraghdr) - svsk->sk_tcplen;
 		iov.iov_base = ((char *)&svsk->sk_marker) + svsk->sk_tcplen;
 		iov.iov_len  = want;
-		iov_iter_kvec(&msg.msg_iter, READ, &iov, 1, want);
+		iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, want);
 		len = sock_recvmsg(svsk->sk_sock, &msg, MSG_DONTWAIT);
 		if (len < 0)
 			return len;
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 915b9902f673..b3ab6d9d752e 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -364,7 +364,7 @@ static ssize_t
 xs_read_kvec(struct socket *sock, struct msghdr *msg, int flags,
 		struct kvec *kvec, size_t count, size_t seek)
 {
-	iov_iter_kvec(&msg->msg_iter, READ, kvec, 1, count);
+	iov_iter_kvec(&msg->msg_iter, ITER_DEST, kvec, 1, count);
 	return xs_sock_recvmsg(sock, msg, flags, seek);
 }
 
@@ -373,7 +373,7 @@ xs_read_bvec(struct socket *sock, struct msghdr *msg, int flags,
 		struct bio_vec *bvec, unsigned long nr, size_t count,
 		size_t seek)
 {
-	iov_iter_bvec(&msg->msg_iter, READ, bvec, nr, count);
+	iov_iter_bvec(&msg->msg_iter, ITER_DEST, bvec, nr, count);
 	return xs_sock_recvmsg(sock, msg, flags, seek);
 }
 
@@ -381,7 +381,7 @@ static ssize_t
 xs_read_discard(struct socket *sock, struct msghdr *msg, int flags,
 		size_t count)
 {
-	iov_iter_discard(&msg->msg_iter, READ, count);
+	iov_iter_discard(&msg->msg_iter, ITER_DEST, count);
 	return sock_recvmsg(sock, msg, flags);
 }
 
diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index 5522865deae9..5713ec2295ec 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -394,7 +394,7 @@ static int tipc_conn_rcv_from_sock(struct tipc_conn *con)
 	iov.iov_base = &s;
 	iov.iov_len = sizeof(s);
 	msg.msg_name = NULL;
-	iov_iter_kvec(&msg.msg_iter, READ, &iov, 1, iov.iov_len);
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, iov.iov_len);
 	ret = sock_recvmsg(con->sock, &msg, MSG_DONTWAIT);
 	if (ret == -EWOULDBLOCK)
 		return -EWOULDBLOCK;
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index a03d66046ca3..6c593788dc25 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -620,7 +620,7 @@ int tls_device_sendpage(struct sock *sk, struct page *page,
 	kaddr = kmap(page);
 	iov.iov_base = kaddr + offset;
 	iov.iov_len = size;
-	iov_iter_kvec(&msg_iter, WRITE, &iov, 1, size);
+	iov_iter_kvec(&msg_iter, ITER_SOURCE, &iov, 1, size);
 	iter_offset.msg_iter = &msg_iter;
 	rc = tls_push_data(sk, iter_offset, size, flags, TLS_RECORD_TYPE_DATA,
 			   NULL);
@@ -697,7 +697,7 @@ static int tls_device_push_pending_record(struct sock *sk, int flags)
 	union tls_iter_offset iter;
 	struct iov_iter msg_iter;
 
-	iov_iter_kvec(&msg_iter, WRITE, NULL, 0, 0);
+	iov_iter_kvec(&msg_iter, ITER_SOURCE, NULL, 0, 0);
 	iter.msg_iter = &msg_iter;
 	return tls_push_data(sk, iter, 0, flags, TLS_RECORD_TYPE_DATA, NULL);
 }
diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index 29a540dcb5a7..d6fece1ed982 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -354,7 +354,7 @@ static int espintcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	*((__be16 *)buf) = cpu_to_be16(msglen);
 	pfx_iov.iov_base = buf;
 	pfx_iov.iov_len = sizeof(buf);
-	iov_iter_kvec(&pfx_iter, WRITE, &pfx_iov, 1, pfx_iov.iov_len);
+	iov_iter_kvec(&pfx_iter, ITER_SOURCE, &pfx_iov, 1, pfx_iov.iov_len);
 
 	err = sk_msg_memcopy_from_iter(sk, &pfx_iter, &emsg->skmsg,
 				       pfx_iov.iov_len);
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 96a92a645216..d54f73c558f7 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1251,7 +1251,7 @@ long keyctl_instantiate_key(key_serial_t id,
 		struct iov_iter from;
 		int ret;
 
-		ret = import_single_range(WRITE, (void __user *)_payload, plen,
+		ret = import_single_range(ITER_SOURCE, (void __user *)_payload, plen,
 					  &iov, &from);
 		if (unlikely(ret))
 			return ret;
@@ -1283,7 +1283,7 @@ long keyctl_instantiate_key_iov(key_serial_t id,
 	if (!_payload_iov)
 		ioc = 0;
 
-	ret = import_iovec(WRITE, _payload_iov, ioc,
+	ret = import_iovec(ITER_SOURCE, _payload_iov, ioc,
 				    ARRAY_SIZE(iovstack), &iov, &from);
 	if (ret < 0)
 		return ret;
-- 
2.30.2

