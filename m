Return-Path: <linux-fsdevel+bounces-69375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 16229C78EAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 12:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 00F844E8FD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 11:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D34347FEE;
	Fri, 21 Nov 2025 11:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KIs8Ztlf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BF1199EAD
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 11:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763726217; cv=none; b=t7SfB7K6KMhj+F6Rtwv2DTvVUUUzG0o4gqTCa4s1aWoXICjGg+QKTs8rDKmDJFA4kPWELkZ0jWD8zAm+3PrbeYHiAPXWt2ZnQVhxefPX3Ns6S6fxpSexVnuU6GFxI9m8flFj02jQZ34P7nXo1YF9tdKQoObIl8DyvUVgVjbuACE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763726217; c=relaxed/simple;
	bh=UF0bznYUBAW8UfvKepNdU2uQub/kFmWLs8EDF2EAA+k=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=R7E/uBqZWeSM8WXHBBwKoZgclXrHzgoMZfSQOW7NnKgtQt5+wrA6MaBGDjoAZsQhrQBcROQhXr0FfQl7JLfkNsabRzvDNpfB3snPY2jIH3nBuFj2KbooUBAhCiAjYxWJjR1juv/8iRhmNME3VIluzM4jNBPy7W6DR5CaTz3JWrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KIs8Ztlf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763726211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z3qiN2kJfq+Dg1rjrRF6xo1eA6PTZys2353mZXjcfrs=;
	b=KIs8ZtlflsanheTn0J7xbvOzjzFG/an5pOpUj9RTsyne/v0aoWLieGeLhUl4cxHKpynW/+
	e4Z43Md1k4lczofEQkrD5dMa6vHHQEA2iMu6OJo/2yblr2kVCrGpUU39q7Ci78ASUEMG7j
	ebnR/3KGrAD5HKNbfx7W0vtLOxeiLA0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-vzuq0WbqOo-Mpc2TT5pXmg-1; Fri,
 21 Nov 2025 06:56:47 -0500
X-MC-Unique: vzuq0WbqOo-Mpc2TT5pXmg-1
X-Mimecast-MFC-AGG-ID: vzuq0WbqOo-Mpc2TT5pXmg_1763726206
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 893D5180047F;
	Fri, 21 Nov 2025 11:56:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A3411940E82;
	Fri, 21 Nov 2025 11:56:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
    Paulo Alcantara <pc@manguebit.org>,
    Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Add a tracepoint to log EIO errors
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2754320.1763726201.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Nov 2025 11:56:41 +0000
Message-ID: <2754321.1763726201@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

    =

Add a tracepoint to log EIO errors and give it the capacity to convey up t=
o
two integers of information.  This is then wrapped with three functions:

 int smb_EIO(enum smb_eio_trace trace)
 int smb_EIO1(enum smb_eio_trace trace, unsigned long info)
 int smb_EIO2(enum smb_eio_trace trace, unsigned long info,
              unsigned long info2)

depending on how many bits of info are desired to be logged with any
particular trace.  The functions all return -EIO and can be used in place
of -EIO.

The trace argument is an enum value that gets translated to a string when
the trace is printed.

This makes is easier to log EIO instances when the client is under high
load than turning on a printk wrapper such as cifs_dbg().  Granted, EIO
could have its own separate EIO printing since EIO shouldn't happen.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cached_dir.c    |    2 =

 fs/smb/client/cifsacl.c       |   10 +-
 fs/smb/client/cifsencrypt.c   |   13 +--
 fs/smb/client/cifsglob.h      |   88 ---------------------
 fs/smb/client/cifsproto.h     |  106 +++++++++++++++++++++++++
 fs/smb/client/cifssmb.c       |  147 ++++++++++++++++++++++-------------
 fs/smb/client/cifstransport.c |    8 -
 fs/smb/client/compress.c      |    2 =

 fs/smb/client/connect.c       |   11 +-
 fs/smb/client/dir.c           |    6 -
 fs/smb/client/file.c          |    6 -
 fs/smb/client/inode.c         |   14 +--
 fs/smb/client/link.c          |   10 +-
 fs/smb/client/misc.c          |   18 ++--
 fs/smb/client/netmisc.c       |    4 =

 fs/smb/client/readdir.c       |    2 =

 fs/smb/client/reparse.c       |   50 +++++++-----
 fs/smb/client/sess.c          |    8 -
 fs/smb/client/smb2file.c      |    6 -
 fs/smb/client/smb2inode.c     |   10 +-
 fs/smb/client/smb2maperror.c  |    3 =

 fs/smb/client/smb2ops.c       |   41 ++++++---
 fs/smb/client/smb2pdu.c       |  174 +++++++++++++++++++++++++-----------=
------
 fs/smb/client/smb2transport.c |    2 =

 fs/smb/client/smbdirect.c     |   18 ++--
 fs/smb/client/trace.h         |  153 ++++++++++++++++++++++++++++++++++++
 fs/smb/client/transport.c     |   21 ++---
 fs/smb/client/xattr.c         |    2 =

 28 files changed, 613 insertions(+), 322 deletions(-)

diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index 018055fd2cdb..543b8181ae1d 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -175,7 +175,7 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon=
 *tcon,
 	server =3D cifs_pick_channel(ses);
 =

 	if (!server->ops->new_lease_key)
-		return -EIO;
+		return smb_EIO(smb_eio_trace_no_lease_key);
 =

 	utf16_path =3D cifs_convert_path_to_utf16(path, cifs_sb);
 	if (!utf16_path)
diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index ce2ebc213a1d..7e6e473bd4a0 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -300,7 +300,7 @@ id_to_sid(unsigned int cid, uint sidtype, struct smb_s=
id *ssid)
 			 __func__, sidtype =3D=3D SIDOWNER ? 'u' : 'g', cid);
 		goto out_revert_creds;
 	} else if (sidkey->datalen < CIFS_SID_BASE_SIZE) {
-		rc =3D -EIO;
+		rc =3D smb_EIO1(smb_eio_trace_malformed_sid_key, sidkey->datalen);
 		cifs_dbg(FYI, "%s: Downcall contained malformed key (datalen=3D%hu)\n",
 			 __func__, sidkey->datalen);
 		goto invalidate_key;
@@ -317,7 +317,8 @@ id_to_sid(unsigned int cid, uint sidtype, struct smb_s=
id *ssid)
 =

 	ksid_size =3D CIFS_SID_BASE_SIZE + (ksid->num_subauth * sizeof(__le32));
 	if (ksid_size > sidkey->datalen) {
-		rc =3D -EIO;
+		rc =3D smb_EIO2(smb_eio_trace_malformed_ksid_key,
+			      ksid_size, sidkey->datalen);
 		cifs_dbg(FYI, "%s: Downcall contained malformed key (datalen=3D%hu, ksi=
d_size=3D%u)\n",
 			 __func__, sidkey->datalen, ksid_size);
 		goto invalidate_key;
@@ -352,7 +353,8 @@ sid_to_id(struct cifs_sb_info *cifs_sb, struct smb_sid=
 *psid,
 	if (unlikely(psid->num_subauth > SID_MAX_SUB_AUTHORITIES)) {
 		cifs_dbg(FYI, "%s: %u subauthorities is too many!\n",
 			 __func__, psid->num_subauth);
-		return -EIO;
+		return smb_EIO2(smb_eio_trace_sid_too_many_auth,
+				psid->num_subauth, SID_MAX_SUB_AUTHORITIES);
 	}
 =

 	if ((cifs_sb->mnt_cifs_flags & CIFS_MOUNT_UID_FROM_ACL) ||
@@ -1227,7 +1229,7 @@ static int parse_sec_desc(struct cifs_sb_info *cifs_=
sb,
 	__u32 dacloffset;
 =

 	if (pntsd =3D=3D NULL)
-		return -EIO;
+		return smb_EIO(smb_eio_trace_null_pointers);
 =

 	owner_sid_ptr =3D (struct smb_sid *)((char *)pntsd +
 				le32_to_cpu(pntsd->osidoffset));
diff --git a/fs/smb/client/cifsencrypt.c b/fs/smb/client/cifsencrypt.c
index a9a57904c6b1..ca2a84e8673e 100644
--- a/fs/smb/client/cifsencrypt.c
+++ b/fs/smb/client/cifsencrypt.c
@@ -75,11 +75,13 @@ static int cifs_sig_iter(const struct iov_iter *iter, =
size_t maxsize,
 			 struct cifs_calc_sig_ctx *ctx)
 {
 	struct iov_iter tmp_iter =3D *iter;
-	int err =3D -EIO;
+	size_t did;
+	int err;
 =

-	if (iterate_and_advance_kernel(&tmp_iter, maxsize, ctx, &err,
-				       cifs_sig_step) !=3D maxsize)
-		return err;
+	did =3D iterate_and_advance_kernel(&tmp_iter, maxsize, ctx, &err,
+					 cifs_sig_step);
+	if (did !=3D maxsize)
+		return smb_EIO2(smb_eio_trace_sig_iter, did, maxsize);
 	return 0;
 }
 =

@@ -96,7 +98,8 @@ int __cifs_calc_signature(struct smb_rqst *rqst, struct =
TCP_Server_Info *server,
 	iov_iter_kvec(&iter, ITER_SOURCE, rqst->rq_iov, rqst->rq_nvec, size);
 =

 	if (iov_iter_count(&iter) <=3D 4)
-		return -EIO;
+		return smb_EIO2(smb_eio_trace_sig_data_too_small,
+				iov_iter_count(&iter), 4);
 =

 	rc =3D cifs_sig_iter(&iter, iov_iter_count(&iter), ctx);
 	if (rc < 0)
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index bdcdb038c9e5..43f3a299779e 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -2205,94 +2205,6 @@ static inline void move_cifs_info_to_smb2(struct sm=
b2_file_all_info *dst, const
 	dst->FileNameLength =3D src->FileNameLength;
 }
 =

-static inline int cifs_get_num_sgs(const struct smb_rqst *rqst,
-				   int num_rqst,
-				   const u8 *sig)
-{
-	unsigned int len, skip;
-	unsigned int nents =3D 0;
-	unsigned long addr;
-	size_t data_size;
-	int i, j;
-
-	/*
-	 * The first rqst has a transform header where the first 20 bytes are
-	 * not part of the encrypted blob.
-	 */
-	skip =3D 20;
-
-	/* Assumes the first rqst has a transform header as the first iov.
-	 * I.e.
-	 * rqst[0].rq_iov[0]  is transform header
-	 * rqst[0].rq_iov[1+] data to be encrypted/decrypted
-	 * rqst[1+].rq_iov[0+] data to be encrypted/decrypted
-	 */
-	for (i =3D 0; i < num_rqst; i++) {
-		data_size =3D iov_iter_count(&rqst[i].rq_iter);
-
-		/* We really don't want a mixture of pinned and unpinned pages
-		 * in the sglist.  It's hard to keep track of which is what.
-		 * Instead, we convert to a BVEC-type iterator higher up.
-		 */
-		if (data_size &&
-		    WARN_ON_ONCE(user_backed_iter(&rqst[i].rq_iter)))
-			return -EIO;
-
-		/* We also don't want to have any extra refs or pins to clean
-		 * up in the sglist.
-		 */
-		if (data_size &&
-		    WARN_ON_ONCE(iov_iter_extract_will_pin(&rqst[i].rq_iter)))
-			return -EIO;
-
-		for (j =3D 0; j < rqst[i].rq_nvec; j++) {
-			struct kvec *iov =3D &rqst[i].rq_iov[j];
-
-			addr =3D (unsigned long)iov->iov_base + skip;
-			if (is_vmalloc_or_module_addr((void *)addr)) {
-				len =3D iov->iov_len - skip;
-				nents +=3D DIV_ROUND_UP(offset_in_page(addr) + len,
-						      PAGE_SIZE);
-			} else {
-				nents++;
-			}
-			skip =3D 0;
-		}
-		if (data_size)
-			nents +=3D iov_iter_npages(&rqst[i].rq_iter, INT_MAX);
-	}
-	nents +=3D DIV_ROUND_UP(offset_in_page(sig) + SMB2_SIGNATURE_SIZE, PAGE_=
SIZE);
-	return nents;
-}
-
-/* We can not use the normal sg_set_buf() as we will sometimes pass a
- * stack object as buf.
- */
-static inline void cifs_sg_set_buf(struct sg_table *sgtable,
-				   const void *buf,
-				   unsigned int buflen)
-{
-	unsigned long addr =3D (unsigned long)buf;
-	unsigned int off =3D offset_in_page(addr);
-
-	addr &=3D PAGE_MASK;
-	if (is_vmalloc_or_module_addr((void *)addr)) {
-		do {
-			unsigned int len =3D min_t(unsigned int, buflen, PAGE_SIZE - off);
-
-			sg_set_page(&sgtable->sgl[sgtable->nents++],
-				    vmalloc_to_page((void *)addr), len, off);
-
-			off =3D 0;
-			addr +=3D PAGE_SIZE;
-			buflen -=3D len;
-		} while (buflen);
-	} else {
-		sg_set_page(&sgtable->sgl[sgtable->nents++],
-			    virt_to_page((void *)addr), buflen, off);
-	}
-}
-
 #define CIFS_OPARMS(_cifs_sb, _tcon, _path, _da, _cd, _co, _mode) \
 	((struct cifs_open_parms) { \
 		.tcon =3D _tcon, \
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 33a216f5ed4d..cd289bc9f5fc 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -787,4 +787,110 @@ static inline void cifs_free_open_info(struct cifs_o=
pen_info_data *data)
 	memset(data, 0, sizeof(*data));
 }
 =

+static inline int smb_EIO(enum smb_eio_trace trace)
+{
+	trace_smb3_eio(trace, 0, 0);
+	return -EIO;
+}
+
+static inline int smb_EIO1(enum smb_eio_trace trace, unsigned long info)
+{
+	trace_smb3_eio(trace, info, 0);
+	return -EIO;
+}
+
+static inline int smb_EIO2(enum smb_eio_trace trace, unsigned long info, =
unsigned long info2)
+{
+	trace_smb3_eio(trace, info, info2);
+	return -EIO;
+}
+
+static inline int cifs_get_num_sgs(const struct smb_rqst *rqst,
+				   int num_rqst,
+				   const u8 *sig)
+{
+	unsigned int len, skip;
+	unsigned int nents =3D 0;
+	unsigned long addr;
+	size_t data_size;
+	int i, j;
+
+	/*
+	 * The first rqst has a transform header where the first 20 bytes are
+	 * not part of the encrypted blob.
+	 */
+	skip =3D 20;
+
+	/* Assumes the first rqst has a transform header as the first iov.
+	 * I.e.
+	 * rqst[0].rq_iov[0]  is transform header
+	 * rqst[0].rq_iov[1+] data to be encrypted/decrypted
+	 * rqst[1+].rq_iov[0+] data to be encrypted/decrypted
+	 */
+	for (i =3D 0; i < num_rqst; i++) {
+		data_size =3D iov_iter_count(&rqst[i].rq_iter);
+
+		/* We really don't want a mixture of pinned and unpinned pages
+		 * in the sglist.  It's hard to keep track of which is what.
+		 * Instead, we convert to a BVEC-type iterator higher up.
+		 */
+		if (data_size &&
+		    WARN_ON_ONCE(user_backed_iter(&rqst[i].rq_iter)))
+			return smb_EIO(smb_eio_trace_user_iter);
+
+		/* We also don't want to have any extra refs or pins to clean
+		 * up in the sglist.
+		 */
+		if (data_size &&
+		    WARN_ON_ONCE(iov_iter_extract_will_pin(&rqst[i].rq_iter)))
+			return smb_EIO(smb_eio_trace_extract_will_pin);
+
+		for (j =3D 0; j < rqst[i].rq_nvec; j++) {
+			struct kvec *iov =3D &rqst[i].rq_iov[j];
+
+			addr =3D (unsigned long)iov->iov_base + skip;
+			if (is_vmalloc_or_module_addr((void *)addr)) {
+				len =3D iov->iov_len - skip;
+				nents +=3D DIV_ROUND_UP(offset_in_page(addr) + len,
+						      PAGE_SIZE);
+			} else {
+				nents++;
+			}
+			skip =3D 0;
+		}
+		if (data_size)
+			nents +=3D iov_iter_npages(&rqst[i].rq_iter, INT_MAX);
+	}
+	nents +=3D DIV_ROUND_UP(offset_in_page(sig) + SMB2_SIGNATURE_SIZE, PAGE_=
SIZE);
+	return nents;
+}
+
+/* We can not use the normal sg_set_buf() as we will sometimes pass a
+ * stack object as buf.
+ */
+static inline void cifs_sg_set_buf(struct sg_table *sgtable,
+				   const void *buf,
+				   unsigned int buflen)
+{
+	unsigned long addr =3D (unsigned long)buf;
+	unsigned int off =3D offset_in_page(addr);
+
+	addr &=3D PAGE_MASK;
+	if (is_vmalloc_or_module_addr((void *)addr)) {
+		do {
+			unsigned int len =3D min_t(unsigned int, buflen, PAGE_SIZE - off);
+
+			sg_set_page(&sgtable->sgl[sgtable->nents++],
+				    vmalloc_to_page((void *)addr), len, off);
+
+			off =3D 0;
+			addr +=3D PAGE_SIZE;
+			buflen -=3D len;
+		} while (buflen);
+	} else {
+		sg_set_page(&sgtable->sgl[sgtable->nents++],
+			    virt_to_page((void *)addr), buflen, off);
+	}
+}
+
 #endif			/* _CIFSPROTO_H */
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 2d71d5183e3d..3fc320a051bf 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -373,7 +373,8 @@ decode_ext_sec_blob(struct cifs_ses *ses, SMB_NEGOTIAT=
E_RSP *pSMBr)
 =

 	count =3D get_bcc(&pSMBr->hdr);
 	if (count < SMB1_CLIENT_GUID_SIZE)
-		return -EIO;
+		return smb_EIO2(smb_eio_trace_neg_sec_blob_too_small,
+				count, SMB1_CLIENT_GUID_SIZE);
 =

 	spin_lock(&cifs_tcp_ses_lock);
 	if (server->srv_count > 1) {
@@ -432,7 +433,7 @@ CIFSSMBNegotiate(const unsigned int xid,
 =

 	if (!server) {
 		WARN(1, "%s: server is NULL!\n", __func__);
-		return -EIO;
+		return smb_EIO(smb_eio_trace_null_pointers);
 	}
 =

 	rc =3D smb_init(SMB_COM_NEGOTIATE, 0, NULL /* no tcon yet */ ,
@@ -516,7 +517,8 @@ CIFSSMBNegotiate(const unsigned int xid,
 		server->negflavor =3D CIFS_NEGFLAVOR_EXTENDED;
 		rc =3D decode_ext_sec_blob(ses, pSMBr);
 	} else if (server->sec_mode & SECMODE_PW_ENCRYPT) {
-		rc =3D -EIO; /* no crypt key only if plain text pwd */
+		/* no crypt key only if plain text pwd */
+		rc =3D smb_EIO(smb_eio_trace_neg_no_crypt_key);
 	} else {
 		server->negflavor =3D CIFS_NEGFLAVOR_UNENCAP;
 		server->capabilities &=3D ~CAP_EXTENDED_SECURITY;
@@ -542,7 +544,7 @@ CIFSSMBTDis(const unsigned int xid, struct cifs_tcon *=
tcon)
 =

 	/* BB: do we need to check this? These should never be NULL. */
 	if ((tcon->ses =3D=3D NULL) || (tcon->ses->server =3D=3D NULL))
-		return -EIO;
+		return smb_EIO(smb_eio_trace_null_pointers);
 =

 	/*
 	 * No need to return error on this operation if tid invalidated and
@@ -553,7 +555,7 @@ CIFSSMBTDis(const unsigned int xid, struct cifs_tcon *=
tcon)
 	spin_lock(&tcon->ses->chan_lock);
 	if ((tcon->need_reconnect) || CIFS_ALL_CHANS_NEED_RECONNECT(tcon->ses)) =
{
 		spin_unlock(&tcon->ses->chan_lock);
-		return -EIO;
+		return smb_EIO(smb_eio_trace_tdis_in_reconnect);
 	}
 	spin_unlock(&tcon->ses->chan_lock);
 =

@@ -650,7 +652,7 @@ CIFSSMBLogoff(const unsigned int xid, struct cifs_ses =
*ses)
 	 * should probably be a BUG()
 	 */
 	if (!ses || !ses->server)
-		return -EIO;
+		return smb_EIO(smb_eio_trace_null_pointers);
 =

 	mutex_lock(&ses->session_mutex);
 	spin_lock(&ses->chan_lock);
@@ -980,7 +982,8 @@ CIFSPOSIXCreate(const unsigned int xid, struct cifs_tc=
on *tcon,
 	rc =3D validate_t2((struct smb_t2_rsp *)pSMBr);
 =

 	if (rc || get_bcc(&pSMBr->hdr) < sizeof(OPEN_PSX_RSP)) {
-		rc =3D -EIO;	/* bad smb */
+		rc =3D smb_EIO2(smb_eio_trace_create_rsp_too_small,
+			      get_bcc(&pSMBr->hdr), sizeof(OPEN_PSX_RSP));
 		goto psx_create_err;
 	}
 =

@@ -1371,11 +1374,12 @@ cifs_readv_callback(struct TCP_Server_Info *server=
, struct smb_message *smb)
 		break;
 	case MID_RESPONSE_MALFORMED:
 		trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_malformed);
-		rdata->result =3D -EIO;
+		rdata->result =3D smb_EIO(smb_eio_trace_read_rsp_malformed);
 		break;
 	default:
 		trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_unknown);
-		rdata->result =3D -EIO;
+		rdata->result =3D smb_EIO1(smb_eio_trace_read_mid_state_unknown,
+					 smb->mid_state);
 		break;
 	}
 =

@@ -1446,7 +1450,7 @@ cifs_async_readv(struct cifs_io_subrequest *rdata)
 		wct =3D 10; /* old style read */
 		if ((rdata->subreq.start >> 32) > 0)  {
 			/* can not handle this big offset for old */
-			return -EIO;
+			return smb_EIO(smb_eio_trace_read_too_far);
 		}
 	}
 =

@@ -1521,7 +1525,7 @@ CIFSSMBRead(const unsigned int xid, struct cifs_io_p=
arms *io_parms,
 		wct =3D 10; /* old style read */
 		if ((offset >> 32) > 0)  {
 			/* can not handle this big offset for old */
-			return -EIO;
+			return smb_EIO(smb_eio_trace_read_too_far);
 		}
 	}
 =

@@ -1576,7 +1580,8 @@ CIFSSMBRead(const unsigned int xid, struct cifs_io_p=
arms *io_parms,
 				|| (data_length > count)) {
 			cifs_dbg(FYI, "bad length %d for count %d\n",
 				 data_length, count);
-			rc =3D -EIO;
+			rc =3D smb_EIO2(smb_eio_trace_read_overlarge,
+				      data_length, count);
 			*nbytes =3D 0;
 		} else {
 			pReadData =3D (char *) (&pSMBr->hdr.Protocol) +
@@ -1635,7 +1640,7 @@ CIFSSMBWrite(const unsigned int xid, struct cifs_io_=
parms *io_parms,
 		wct =3D 12;
 		if ((offset >> 32) > 0) {
 			/* can not handle big offset for old srv */
-			return -EIO;
+			return smb_EIO(smb_eio_trace_write_too_far);
 		}
 	}
 =

@@ -1786,11 +1791,12 @@ cifs_writev_callback(struct TCP_Server_Info *serve=
r, struct smb_message *smb)
 		break;
 	case MID_RESPONSE_MALFORMED:
 		trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_malformed);
-		result =3D -EIO;
+		result =3D smb_EIO(smb_eio_trace_write_rsp_malformed);
 		break;
 	default:
 		trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_unknown);
-		result =3D -EIO;
+		result =3D smb_EIO1(smb_eio_trace_write_mid_state_unknown,
+				  smb->mid_state);
 		break;
 	}
 =

@@ -1825,7 +1831,7 @@ cifs_async_writev(struct cifs_io_subrequest *wdata)
 		wct =3D 12;
 		if (wdata->subreq.start >> 32 > 0) {
 			/* can not handle big offset for old srv */
-			rc =3D -EIO;
+			rc =3D smb_EIO(smb_eio_trace_write_too_far);
 			goto out;
 		}
 	}
@@ -1917,7 +1923,7 @@ CIFSSMBWrite2(const unsigned int xid, struct cifs_io=
_parms *io_parms,
 		wct =3D 12;
 		if ((offset >> 32) > 0) {
 			/* can not handle big offset for old srv */
-			return -EIO;
+			return smb_EIO(smb_eio_trace_write_too_far);
 		}
 	}
 	rc =3D small_smb_init(SMB_COM_WRITE_ANDX, wct, tcon, (void **) &pSMB);
@@ -1973,7 +1979,7 @@ CIFSSMBWrite2(const unsigned int xid, struct cifs_io=
_parms *io_parms,
 		cifs_dbg(FYI, "Send error Write2 =3D %d\n", rc);
 	} else if (resp_buf_type =3D=3D 0) {
 		/* presumably this can not happen, but best to be safe */
-		rc =3D -EIO;
+		rc =3D smb_EIO1(smb_eio_trace_write_bad_buf_type, resp_buf_type);
 	} else {
 		WRITE_RSP *pSMBr =3D (WRITE_RSP *)rsp_iov.iov_base;
 		*nbytes =3D le16_to_cpu(pSMBr->CountHigh);
@@ -2209,13 +2215,15 @@ CIFSSMBPosixLock(const unsigned int xid, struct ci=
fs_tcon *tcon,
 		rc =3D validate_t2((struct smb_t2_rsp *)pSMBr);
 =

 		if (rc || get_bcc(&pSMBr->hdr) < sizeof(*parm_data)) {
-			rc =3D -EIO;      /* bad smb */
+			rc =3D smb_EIO2(smb_eio_trace_lock_bcc_too_small,
+				      get_bcc(&pSMBr->hdr), sizeof(*parm_data));
 			goto plk_err_exit;
 		}
 		data_offset =3D le16_to_cpu(pSMBr->t2.DataOffset);
 		data_count  =3D le16_to_cpu(pSMBr->t2.DataCount);
 		if (data_count < sizeof(struct cifs_posix_lock)) {
-			rc =3D -EIO;
+			rc =3D smb_EIO2(smb_eio_trace_lock_data_too_small,
+				      data_count, sizeof(struct cifs_posix_lock));
 			goto plk_err_exit;
 		}
 		parm_data =3D (struct cifs_posix_lock *)
@@ -2774,7 +2782,8 @@ CIFSSMBUnixQuerySymLink(const unsigned int xid, stru=
ct cifs_tcon *tcon,
 		rc =3D validate_t2((struct smb_t2_rsp *)pSMBr);
 		/* BB also check enough total bytes returned */
 		if (rc || get_bcc(&pSMBr->hdr) < 2)
-			rc =3D -EIO;
+			rc =3D smb_EIO2(smb_eio_trace_qsym_bcc_too_small,
+				      get_bcc(&pSMBr->hdr), 2);
 		else {
 			bool is_unicode;
 			u16 count =3D le16_to_cpu(pSMBr->t2.DataCount);
@@ -2876,13 +2885,15 @@ int cifs_query_reparse_point(const unsigned int xi=
d,
 	data_count =3D le32_to_cpu(io_rsp->DataCount);
 	if (get_bcc(&io_rsp->hdr) < 2 || data_offset > 512 ||
 	    !data_count || data_count > 2048) {
-		rc =3D -EIO;
+		rc =3D smb_EIO2(smb_eio_trace_qreparse_sizes_wrong,
+			      get_bcc(&io_rsp->hdr), data_count);
 		goto error;
 	}
 =

 	/* SetupCount must be 1, otherwise offset to ByteCount is incorrect. */
 	if (io_rsp->SetupCount !=3D 1) {
-		rc =3D -EIO;
+		rc =3D smb_EIO2(smb_eio_trace_qreparse_setup_count,
+			      io_rsp->SetupCount, 1);
 		goto error;
 	}
 =

@@ -2892,14 +2903,17 @@ int cifs_query_reparse_point(const unsigned int xi=
d,
 	 * Check that we have full FSCTL_GET_REPARSE_POINT buffer.
 	 */
 	if (data_count !=3D le16_to_cpu(io_rsp->ReturnedDataLen)) {
-		rc =3D -EIO;
+		rc =3D smb_EIO2(smb_eio_trace_qreparse_ret_datalen,
+			      data_count, le16_to_cpu(io_rsp->ReturnedDataLen));
 		goto error;
 	}
 =

 	end =3D 2 + get_bcc(&io_rsp->hdr) + (__u8 *)&io_rsp->ByteCount;
 	start =3D (__u8 *)&io_rsp->hdr.Protocol + data_offset;
 	if (start >=3D end) {
-		rc =3D -EIO;
+		rc =3D smb_EIO2(smb_eio_trace_qreparse_data_area,
+			      (unsigned long)start - (unsigned long)io_rsp,
+			      (unsigned long)end - (unsigned long)io_rsp);
 		goto error;
 	}
 =

@@ -2908,7 +2922,8 @@ int cifs_query_reparse_point(const unsigned int xid,
 	len =3D sizeof(*buf);
 	if (data_count < len ||
 	    data_count < le16_to_cpu(buf->ReparseDataLength) + len) {
-		rc =3D -EIO;
+		rc =3D smb_EIO2(smb_eio_trace_qreparse_rep_datalen,
+			      data_count, le16_to_cpu(buf->ReparseDataLength) + len);
 		goto error;
 	}
 =

@@ -3352,7 +3367,8 @@ int cifs_do_get_acl(const unsigned int xid, struct c=
ifs_tcon *tcon,
 		rc =3D validate_t2((struct smb_t2_rsp *)pSMBr);
 		/* BB also check enough total bytes returned */
 		if (rc || get_bcc(&pSMBr->hdr) < 2)
-			rc =3D -EIO;      /* bad smb */
+			rc =3D smb_EIO2(smb_eio_trace_getacl_bcc_too_small,
+				      get_bcc(&pSMBr->hdr), 2);
 		else {
 			__u16 data_offset =3D le16_to_cpu(pSMBr->t2.DataOffset);
 			__u16 count =3D le16_to_cpu(pSMBr->t2.DataCount);
@@ -3525,7 +3541,8 @@ CIFSGetExtAttr(const unsigned int xid, struct cifs_t=
con *tcon,
 		if (rc || get_bcc(&pSMBr->hdr) < 2)
 			/* If rc should we check for EOPNOSUPP and
 			   disable the srvino flag? or in caller? */
-			rc =3D -EIO;      /* bad smb */
+			rc =3D smb_EIO2(smb_eio_trace_getextattr_bcc_too_small,
+				      get_bcc(&pSMBr->hdr), 2);
 		else {
 			__u16 data_offset =3D le16_to_cpu(pSMBr->t2.DataOffset);
 			__u16 count =3D le16_to_cpu(pSMBr->t2.DataCount);
@@ -3533,7 +3550,8 @@ CIFSGetExtAttr(const unsigned int xid, struct cifs_t=
con *tcon,
 =

 			if (count !=3D 16) {
 				cifs_dbg(FYI, "Invalid size ret in GetExtAttr\n");
-				rc =3D -EIO;
+				rc =3D smb_EIO2(smb_eio_trace_getextattr_inv_size,
+					      count, 16);
 				goto GetExtAttrOut;
 			}
 			pfinfo =3D (struct file_chattr_info *)
@@ -3700,7 +3718,8 @@ CIFSSMBGetCIFSACL(const unsigned int xid, struct cif=
s_tcon *tcon, __u16 fid,
 			 pSMBr, parm, *acl_inf);
 =

 		if (le32_to_cpu(pSMBr->ParameterCount) !=3D 4) {
-			rc =3D -EIO;      /* bad smb */
+			rc =3D smb_EIO2(smb_eio_trace_getcifsacl_param_count,
+				      le32_to_cpu(pSMBr->ParameterCount), 4);
 			*pbuflen =3D 0;
 			goto qsec_out;
 		}
@@ -3858,8 +3877,10 @@ SMBQueryInformation(const unsigned int xid, struct =
cifs_tcon *tcon,
 		data->EndOfFile =3D data->AllocationSize;
 		data->Attributes =3D
 			cpu_to_le32(le16_to_cpu(pSMBr->attr));
-	} else
-		rc =3D -EIO; /* bad buffer passed in */
+	} else {
+		/* bad buffer passed in */
+		rc =3D smb_EIO(smb_eio_trace_null_pointers);
+	}
 =

 	cifs_buf_release(pSMB);
 =

@@ -3921,9 +3942,11 @@ CIFSSMBQFileInfo(const unsigned int xid, struct cif=
s_tcon *tcon,
 		rc =3D validate_t2((struct smb_t2_rsp *)pSMBr);
 =

 		if (rc) /* BB add auto retry on EOPNOTSUPP? */
-			rc =3D -EIO;
+			rc =3D smb_EIO2(smb_eio_trace_qfileinfo_invalid,
+				      get_bcc(&pSMBr->hdr), 40);
 		else if (get_bcc(&pSMBr->hdr) < 40)
-			rc =3D -EIO;	/* bad smb */
+			rc =3D smb_EIO2(smb_eio_trace_qfileinfo_bcc_too_small,
+				      get_bcc(&pSMBr->hdr), 40);
 		else if (pFindData) {
 			__u16 data_offset =3D le16_to_cpu(pSMBr->t2.DataOffset);
 			memcpy((char *) pFindData,
@@ -4008,12 +4031,15 @@ CIFSSMBQPathInfo(const unsigned int xid, struct ci=
fs_tcon *tcon,
 		rc =3D validate_t2((struct smb_t2_rsp *)pSMBr);
 =

 		if (rc) /* BB add auto retry on EOPNOTSUPP? */
-			rc =3D -EIO;
+			rc =3D smb_EIO2(smb_eio_trace_qpathinfo_invalid,
+				      get_bcc(&pSMBr->hdr), 40);
 		else if (!legacy && get_bcc(&pSMBr->hdr) < 40)
-			rc =3D -EIO;	/* bad smb */
+			rc =3D smb_EIO2(smb_eio_trace_qpathinfo_bcc_too_small,
+				      get_bcc(&pSMBr->hdr), 40);
 		else if (legacy && get_bcc(&pSMBr->hdr) < 24)
-			rc =3D -EIO;  /* 24 or 26 expected but we do not read
-					last field */
+			/* 24 or 26 expected but we do not read last field */
+			rc =3D smb_EIO2(smb_eio_trace_qpathinfo_bcc_too_small,
+				      get_bcc(&pSMBr->hdr), 24);
 		else if (data) {
 			int size;
 			__u16 data_offset =3D le16_to_cpu(pSMBr->t2.DataOffset);
@@ -4093,7 +4119,8 @@ CIFSSMBUnixQFileInfo(const unsigned int xid, struct =
cifs_tcon *tcon,
 =

 		if (rc || get_bcc(&pSMBr->hdr) < sizeof(FILE_UNIX_BASIC_INFO)) {
 			cifs_dbg(VFS, "Malformed FILE_UNIX_BASIC_INFO response. Unix Extension=
s can be disabled on mount by specifying the nosfu mount option.\n");
-			rc =3D -EIO;	/* bad smb */
+			rc =3D smb_EIO2(smb_eio_trace_unixqfileinfo_bcc_too_small,
+				      get_bcc(&pSMBr->hdr), sizeof(FILE_UNIX_BASIC_INFO));
 		} else {
 			__u16 data_offset =3D le16_to_cpu(pSMBr->t2.DataOffset);
 			memcpy((char *) pFindData,
@@ -4177,7 +4204,8 @@ CIFSSMBUnixQPathInfo(const unsigned int xid, struct =
cifs_tcon *tcon,
 =

 		if (rc || get_bcc(&pSMBr->hdr) < sizeof(FILE_UNIX_BASIC_INFO)) {
 			cifs_dbg(VFS, "Malformed FILE_UNIX_BASIC_INFO response. Unix Extension=
s can be disabled on mount by specifying the nosfu mount option.\n");
-			rc =3D -EIO;	/* bad smb */
+			rc =3D smb_EIO2(smb_eio_trace_unixqpathinfo_bcc_too_small,
+				      get_bcc(&pSMBr->hdr), sizeof(FILE_UNIX_BASIC_INFO));
 		} else {
 			__u16 data_offset =3D le16_to_cpu(pSMBr->t2.DataOffset);
 			memcpy((char *) pFindData,
@@ -4580,7 +4608,8 @@ CIFSGetSrvInodeNumber(const unsigned int xid, struct=
 cifs_tcon *tcon,
 		if (rc || get_bcc(&pSMBr->hdr) < 2)
 			/* If rc should we check for EOPNOSUPP and
 			disable the srvino flag? or in caller? */
-			rc =3D -EIO;      /* bad smb */
+			rc =3D smb_EIO2(smb_eio_trace_getsrvinonum_bcc_too_small,
+				      get_bcc(&pSMBr->hdr), 2);
 		else {
 			__u16 data_offset =3D le16_to_cpu(pSMBr->t2.DataOffset);
 			__u16 count =3D le16_to_cpu(pSMBr->t2.DataCount);
@@ -4588,7 +4617,8 @@ CIFSGetSrvInodeNumber(const unsigned int xid, struct=
 cifs_tcon *tcon,
 			/* BB Do we need a cast or hash here ? */
 			if (count < 8) {
 				cifs_dbg(FYI, "Invalid size ret in QryIntrnlInf\n");
-				rc =3D -EIO;
+				rc =3D smb_EIO2(smb_eio_trace_getsrvinonum_size,
+					      count, 8);
 				goto GetInodeNumOut;
 			}
 			pfinfo =3D (struct file_internal_info *)
@@ -4697,7 +4727,8 @@ CIFSGetDFSRefer(const unsigned int xid, struct cifs_=
ses *ses,
 =

 	/* BB Also check if enough total bytes returned? */
 	if (rc || get_bcc(&pSMBr->hdr) < 17) {
-		rc =3D -EIO;      /* bad smb */
+		rc =3D smb_EIO2(smb_eio_trace_getdfsrefer_bcc_too_small,
+			      get_bcc(&pSMBr->hdr), 17);
 		goto GetDFSRefExit;
 	}
 =

@@ -4773,7 +4804,8 @@ SMBOldQFSInfo(const unsigned int xid, struct cifs_tc=
on *tcon,
 		rc =3D validate_t2((struct smb_t2_rsp *)pSMBr);
 =

 		if (rc || get_bcc(&pSMBr->hdr) < 18)
-			rc =3D -EIO;      /* bad smb */
+			rc =3D smb_EIO2(smb_eio_trace_oldqfsinfo_bcc_too_small,
+				      get_bcc(&pSMBr->hdr), 18);
 		else {
 			__u16 data_offset =3D le16_to_cpu(pSMBr->t2.DataOffset);
 			cifs_dbg(FYI, "qfsinf resp BCC: %d  Offset %d\n",
@@ -4862,7 +4894,8 @@ CIFSSMBQFSInfo(const unsigned int xid, struct cifs_t=
con *tcon,
 		rc =3D validate_t2((struct smb_t2_rsp *)pSMBr);
 =

 		if (rc || get_bcc(&pSMBr->hdr) < 24)
-			rc =3D -EIO;	/* bad smb */
+			rc =3D smb_EIO2(smb_eio_trace_qfsinfo_bcc_too_small,
+				      get_bcc(&pSMBr->hdr), 24);
 		else {
 			__u16 data_offset =3D le16_to_cpu(pSMBr->t2.DataOffset);
 =

@@ -4952,7 +4985,8 @@ CIFSSMBQFSAttributeInfo(const unsigned int xid, stru=
ct cifs_tcon *tcon)
 =

 		if (rc || get_bcc(&pSMBr->hdr) < 13) {
 			/* BB also check if enough bytes returned */
-			rc =3D -EIO;	/* bad smb */
+			rc =3D smb_EIO2(smb_eio_trace_qfsattrinfo_bcc_too_small,
+				      get_bcc(&pSMBr->hdr), 13);
 		} else {
 			__u16 data_offset =3D le16_to_cpu(pSMBr->t2.DataOffset);
 			response_data =3D
@@ -5025,7 +5059,9 @@ CIFSSMBQFSDeviceInfo(const unsigned int xid, struct =
cifs_tcon *tcon)
 =

 		if (rc || get_bcc(&pSMBr->hdr) <
 			  sizeof(FILE_SYSTEM_DEVICE_INFO))
-			rc =3D -EIO;	/* bad smb */
+			rc =3D smb_EIO2(smb_eio_trace_qfsdevinfo_bcc_too_small,
+				      get_bcc(&pSMBr->hdr),
+				      sizeof(FILE_SYSTEM_DEVICE_INFO));
 		else {
 			__u16 data_offset =3D le16_to_cpu(pSMBr->t2.DataOffset);
 			response_data =3D
@@ -5096,7 +5132,8 @@ CIFSSMBQFSUnixInfo(const unsigned int xid, struct ci=
fs_tcon *tcon)
 		rc =3D validate_t2((struct smb_t2_rsp *)pSMBr);
 =

 		if (rc || get_bcc(&pSMBr->hdr) < 13) {
-			rc =3D -EIO;	/* bad smb */
+			rc =3D smb_EIO2(smb_eio_trace_qfsunixinfo_bcc_too_small,
+				      get_bcc(&pSMBr->hdr), 13);
 		} else {
 			__u16 data_offset =3D le16_to_cpu(pSMBr->t2.DataOffset);
 			response_data =3D
@@ -5244,7 +5281,8 @@ CIFSSMBQFSPosixInfo(const unsigned int xid, struct c=
ifs_tcon *tcon,
 		rc =3D validate_t2((struct smb_t2_rsp *)pSMBr);
 =

 		if (rc || get_bcc(&pSMBr->hdr) < 13) {
-			rc =3D -EIO;	/* bad smb */
+			rc =3D smb_EIO2(smb_eio_trace_qfsposixinfo_bcc_too_small,
+				      get_bcc(&pSMBr->hdr), 13);
 		} else {
 			__u16 data_offset =3D le16_to_cpu(pSMBr->t2.DataOffset);
 			response_data =3D
@@ -6044,7 +6082,8 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_t=
con *tcon,
 =

 	rc =3D validate_t2((struct smb_t2_rsp *)pSMBr);
 	if (rc || get_bcc(&pSMBr->hdr) < 4) {
-		rc =3D -EIO;	/* bad smb */
+		rc =3D smb_EIO2(smb_eio_trace_qalleas_bcc_too_small,
+			      get_bcc(&pSMBr->hdr), 4);
 		goto QAllEAsOut;
 	}
 =

@@ -6074,7 +6113,9 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_t=
con *tcon,
 	end_of_smb =3D (char *)pByteArea(&pSMBr->hdr) + get_bcc(&pSMBr->hdr);
 	if ((char *)ea_response_data + list_len > end_of_smb) {
 		cifs_dbg(FYI, "EA list appears to go beyond SMB\n");
-		rc =3D -EIO;
+		rc =3D smb_EIO2(smb_eio_trace_qalleas_overlong,
+			      (unsigned long)ea_response_data + list_len - (unsigned long)pSMB=
r,
+			      (unsigned long)end_of_smb - (unsigned long)pSMBr);
 		goto QAllEAsOut;
 	}
 =

@@ -6091,7 +6132,7 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_t=
con *tcon,
 		/* make sure we can read name_len and value_len */
 		if (list_len < 0) {
 			cifs_dbg(FYI, "EA entry goes beyond length of list\n");
-			rc =3D -EIO;
+			rc =3D smb_EIO1(smb_eio_trace_qalleas_ea_overlong, list_len);
 			goto QAllEAsOut;
 		}
 =

@@ -6100,7 +6141,7 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_t=
con *tcon,
 		list_len -=3D name_len + 1 + value_len;
 		if (list_len < 0) {
 			cifs_dbg(FYI, "EA entry goes beyond length of list\n");
-			rc =3D -EIO;
+			rc =3D smb_EIO1(smb_eio_trace_qalleas_ea_overlong, list_len);
 			goto QAllEAsOut;
 		}
 =

diff --git a/fs/smb/client/cifstransport.c b/fs/smb/client/cifstransport.c
index 6b7d4bac8b83..cfd877b0008a 100644
--- a/fs/smb/client/cifstransport.c
+++ b/fs/smb/client/cifstransport.c
@@ -227,15 +227,15 @@ SendReceive(const unsigned int xid, struct cifs_ses =
*ses,
 	int rc =3D 0;
 =

 	if (WARN_ON_ONCE(in_len > 0xffffff))
-		return -EIO;
+		return smb_EIO1(smb_eio_trace_tx_too_long, in_len);
 	if (ses =3D=3D NULL) {
 		cifs_dbg(VFS, "Null smb session\n");
-		return -EIO;
+		return smb_EIO(smb_eio_trace_null_pointers);
 	}
 	server =3D ses->server;
 	if (server =3D=3D NULL) {
 		cifs_dbg(VFS, "Null tcp session\n");
-		return -EIO;
+		return smb_EIO(smb_eio_trace_null_pointers);
 	}
 =

 	/* Ensure that we do not send more than 50 overlapping requests
@@ -245,7 +245,7 @@ SendReceive(const unsigned int xid, struct cifs_ses *s=
es,
 	if (in_len > CIFSMaxBufSize + MAX_CIFS_HDR_SIZE) {
 		cifs_server_dbg(VFS, "Invalid length, greater than maximum frame, %d\n"=
,
 				in_len);
-		return -EIO;
+		return smb_EIO1(smb_eio_trace_tx_too_long, in_len);
 	}
 =

 	rc =3D cifs_send_recv(xid, ses, ses->server,
diff --git a/fs/smb/client/compress.c b/fs/smb/client/compress.c
index db709f5cd2e1..f03dd9804427 100644
--- a/fs/smb/client/compress.c
+++ b/fs/smb/client/compress.c
@@ -310,7 +310,7 @@ int smb_compress(struct TCP_Server_Info *server, struc=
t smb_rqst *rq, compress_s
 	iter =3D rq->rq_iter;
 =

 	if (!copy_from_iter_full(src, slen, &iter)) {
-		ret =3D -EIO;
+		ret =3D smb_EIO(smb_eio_trace_compress_copy);
 		goto err_free;
 	}
 =

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 592f9f6de075..a2b84a556430 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -3240,7 +3240,7 @@ ip_rfc1001_connect(struct TCP_Server_Info *server)
 		if (be16_to_cpu(resp.length) !=3D 0) {
 			cifs_dbg(VFS, "RFC 1002 positive session response but with invalid non=
-zero length %u\n",
 				 be16_to_cpu(resp.length));
-			return -EIO;
+			return smb_EIO(smb_eio_trace_rx_pos_sess_resp);
 		}
 		cifs_dbg(FYI, "RFC 1002 positive session response");
 		break;
@@ -3279,17 +3279,18 @@ ip_rfc1001_connect(struct TCP_Server_Info *server)
 				break;
 			case RFC1002_INSUFFICIENT_RESOURCE:
 				/* remote server resource error */
+				smb_EIO(smb_eio_trace_rx_insuff_res);
 				rc =3D -EREMOTEIO;
 				break;
 			case RFC1002_UNSPECIFIED_ERROR:
 			default:
 				/* other/unknown error */
-				rc =3D -EIO;
+				rc =3D smb_EIO(smb_eio_trace_rx_unspec_error);
 				break;
 			}
 		} else {
 			cifs_dbg(VFS, "RFC 1002 negative session response\n");
-			rc =3D -EIO;
+			rc =3D smb_EIO(smb_eio_trace_rx_neg_sess_resp);
 		}
 		return rc;
 	case RFC1002_RETARGET_SESSION_RESPONSE:
@@ -3311,7 +3312,7 @@ ip_rfc1001_connect(struct TCP_Server_Info *server)
 		return -EMULTIHOP;
 	default:
 		cifs_dbg(VFS, "RFC 1002 unknown response type 0x%x\n", resp.type);
-		return -EIO;
+		return smb_EIO1(smb_eio_trace_rx_unknown_resp, resp.type);
 	}
 =

 	server->with_rfc1001 =3D true;
@@ -4001,7 +4002,7 @@ CIFSTCon(const unsigned int xid, struct cifs_ses *se=
s,
 	__u16 bytes_left, count;
 =

 	if (ses =3D=3D NULL)
-		return -EIO;
+		return smb_EIO(smb_eio_trace_null_pointers);
 =

 	smb_buffer =3D cifs_buf_get();
 	if (smb_buffer =3D=3D NULL)
diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index da5597dbf5b9..4ad69dc77e09 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -471,7 +471,7 @@ cifs_atomic_open(struct inode *inode, struct dentry *d=
irentry,
 	struct cifs_open_info_data buf =3D {};
 =

 	if (unlikely(cifs_forced_shutdown(CIFS_SB(inode->i_sb))))
-		return -EIO;
+		return smb_EIO(smb_eio_trace_forced_shutdown);
 =

 	/*
 	 * Posix open is only called (at lookup time) for file create now. For
@@ -589,7 +589,7 @@ int cifs_create(struct mnt_idmap *idmap, struct inode =
*inode,
 		 inode, direntry, direntry);
 =

 	if (unlikely(cifs_forced_shutdown(CIFS_SB(inode->i_sb)))) {
-		rc =3D -EIO;
+		rc =3D smb_EIO(smb_eio_trace_forced_shutdown);
 		goto out_free_xid;
 	}
 =

@@ -631,7 +631,7 @@ int cifs_mknod(struct mnt_idmap *idmap, struct inode *=
inode,
 =

 	cifs_sb =3D CIFS_SB(inode->i_sb);
 	if (unlikely(cifs_forced_shutdown(cifs_sb)))
-		return -EIO;
+		return smb_EIO(smb_eio_trace_forced_shutdown);
 =

 	tlink =3D cifs_sb_tlink(cifs_sb);
 	if (IS_ERR(tlink))
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 474dadeb1593..0c01d5736e45 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -117,7 +117,7 @@ static void cifs_issue_write(struct netfs_io_subreques=
t *subreq)
 	int rc;
 =

 	if (cifs_forced_shutdown(sbi)) {
-		rc =3D -EIO;
+		rc =3D smb_EIO(smb_eio_trace_forced_shutdown);
 		goto fail;
 	}
 =

@@ -285,7 +285,7 @@ static int cifs_init_request(struct netfs_io_request *=
rreq, struct file *file)
 			req->pid =3D req->cfile->pid;
 	} else if (rreq->origin !=3D NETFS_WRITEBACK) {
 		WARN_ON_ONCE(1);
-		return -EIO;
+		return smb_EIO1(smb_eio_trace_not_netfs_writeback, rreq->origin);
 	}
 =

 	return 0;
@@ -1035,7 +1035,7 @@ int cifs_open(struct inode *inode, struct file *file=
)
 	cifs_sb =3D CIFS_SB(inode->i_sb);
 	if (unlikely(cifs_forced_shutdown(cifs_sb))) {
 		free_xid(xid);
-		return -EIO;
+		return smb_EIO(smb_eio_trace_forced_shutdown);
 	}
 =

 	tlink =3D cifs_sb_tlink(cifs_sb);
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index c2ac39d89df2..d30f2fe296e9 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -1951,7 +1951,7 @@ static int __cifs_unlink(struct inode *dir, struct d=
entry *dentry, bool sillyren
 	cifs_dbg(FYI, "cifs_unlink, dir=3D0x%p, dentry=3D0x%p\n", dir, dentry);
 =

 	if (unlikely(cifs_forced_shutdown(cifs_sb)))
-		return -EIO;
+		return smb_EIO(smb_eio_trace_forced_shutdown);
 =

 	/* Unhash dentry in advance to prevent any concurrent opens */
 	spin_lock(&dentry->d_lock);
@@ -2267,7 +2267,7 @@ struct dentry *cifs_mkdir(struct mnt_idmap *idmap, s=
truct inode *inode,
 =

 	cifs_sb =3D CIFS_SB(inode->i_sb);
 	if (unlikely(cifs_forced_shutdown(cifs_sb)))
-		return ERR_PTR(-EIO);
+		return ERR_PTR(smb_EIO(smb_eio_trace_forced_shutdown));
 	tlink =3D cifs_sb_tlink(cifs_sb);
 	if (IS_ERR(tlink))
 		return ERR_CAST(tlink);
@@ -2353,7 +2353,7 @@ int cifs_rmdir(struct inode *inode, struct dentry *d=
irentry)
 =

 	cifs_sb =3D CIFS_SB(inode->i_sb);
 	if (unlikely(cifs_forced_shutdown(cifs_sb))) {
-		rc =3D -EIO;
+		rc =3D smb_EIO(smb_eio_trace_forced_shutdown);
 		goto rmdir_exit;
 	}
 =

@@ -2515,7 +2515,7 @@ cifs_rename2(struct mnt_idmap *idmap, struct inode *=
source_dir,
 =

 	cifs_sb =3D CIFS_SB(source_dir->i_sb);
 	if (unlikely(cifs_forced_shutdown(cifs_sb)))
-		return -EIO;
+		return smb_EIO(smb_eio_trace_forced_shutdown);
 =

 	/*
 	 * Prevent any concurrent opens on the target by unhashing the dentry.
@@ -2900,7 +2900,7 @@ int cifs_getattr(struct mnt_idmap *idmap, const stru=
ct path *path,
 	int rc;
 =

 	if (unlikely(cifs_forced_shutdown(CIFS_SB(inode->i_sb))))
-		return -EIO;
+		return smb_EIO(smb_eio_trace_forced_shutdown);
 =

 	/*
 	 * We need to be sure that all dirty pages are written and the server
@@ -2975,7 +2975,7 @@ int cifs_fiemap(struct inode *inode, struct fiemap_e=
xtent_info *fei, u64 start,
 	int rc;
 =

 	if (unlikely(cifs_forced_shutdown(cifs_sb)))
-		return -EIO;
+		return smb_EIO(smb_eio_trace_forced_shutdown);
 =

 	/*
 	 * We need to be sure that all dirty pages are written as they
@@ -3467,7 +3467,7 @@ cifs_setattr(struct mnt_idmap *idmap, struct dentry =
*direntry,
 #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
 =

 	if (unlikely(cifs_forced_shutdown(cifs_sb)))
-		return -EIO;
+		return smb_EIO(smb_eio_trace_forced_shutdown);
 	/*
 	 * Avoid setting [cm]time with O_TRUNC to prevent the server from
 	 * disabling automatic timestamp updates as specified in
diff --git a/fs/smb/client/link.c b/fs/smb/client/link.c
index 70f3c0c67eeb..fdfdc9a3abdd 100644
--- a/fs/smb/client/link.c
+++ b/fs/smb/client/link.c
@@ -160,7 +160,8 @@ create_mf_symlink(const unsigned int xid, struct cifs_=
tcon *tcon,
 		goto out;
 =

 	if (bytes_written !=3D CIFS_MF_SYMLINK_FILE_SIZE)
-		rc =3D -EIO;
+		rc =3D smb_EIO2(smb_eio_trace_symlink_file_size,
+			      bytes_written, CIFS_MF_SYMLINK_FILE_SIZE);
 out:
 	kfree(buf);
 	return rc;
@@ -424,7 +425,8 @@ smb3_create_mf_symlink(unsigned int xid, struct cifs_t=
con *tcon,
 =

 	/* Make sure we wrote all of the symlink data */
 	if ((rc =3D=3D 0) && (*pbytes_written !=3D CIFS_MF_SYMLINK_FILE_SIZE))
-		rc =3D -EIO;
+		rc =3D smb_EIO2(smb_eio_trace_short_symlink_write,
+			      *pbytes_written, CIFS_MF_SYMLINK_FILE_SIZE);
 =

 	SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fid);
 =

@@ -451,7 +453,7 @@ cifs_hardlink(struct dentry *old_file, struct inode *i=
node,
 	struct cifsInodeInfo *cifsInode;
 =

 	if (unlikely(cifs_forced_shutdown(cifs_sb)))
-		return -EIO;
+		return smb_EIO(smb_eio_trace_forced_shutdown);
 =

 	tlink =3D cifs_sb_tlink(cifs_sb);
 	if (IS_ERR(tlink))
@@ -553,7 +555,7 @@ cifs_symlink(struct mnt_idmap *idmap, struct inode *in=
ode,
 	struct inode *newinode =3D NULL;
 =

 	if (unlikely(cifs_forced_shutdown(cifs_sb)))
-		return -EIO;
+		return smb_EIO(smb_eio_trace_forced_shutdown);
 =

 	page =3D alloc_dentry_path();
 	if (!page)
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 83b253ac37e9..4fc56f1d95fe 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -379,25 +379,29 @@ checkSMB(char *buf, unsigned int pdu_len, unsigned i=
nt total_read,
 				return 0;
 			}
 			cifs_dbg(VFS, "rcvd invalid byte count (bcc)\n");
+			return smb_EIO1(smb_eio_trace_rx_inv_bcc, tmp[sizeof(struct smb_hdr)])=
;
 		} else {
 			cifs_dbg(VFS, "Length less than smb header size\n");
+			return smb_EIO2(smb_eio_trace_rx_too_short,
+					total_read, smb->WordCount);
 		}
-		return -EIO;
 	} else if (total_read < sizeof(*smb) + 2 * smb->WordCount) {
 		cifs_dbg(VFS, "%s: can't read BCC due to invalid WordCount(%u)\n",
 			 __func__, smb->WordCount);
-		return -EIO;
+		return smb_EIO2(smb_eio_trace_rx_check_rsp,
+				total_read, 2 + sizeof(struct smb_hdr));
 	}
 =

 	/* otherwise, there is enough to get to the BCC */
 	if (check_smb_hdr(smb))
-		return -EIO;
+		return smb_EIO1(smb_eio_trace_rx_rfc1002_magic, *(u32 *)smb->Protocol);
 	clc_len =3D smbCalcSize(smb);
 =

 	if (rfclen !=3D total_read) {
 		cifs_dbg(VFS, "Length read does not match RFC1001 length %d/%d\n",
 			 rfclen, total_read);
-		return -EIO;
+		return smb_EIO2(smb_eio_trace_rx_check_rsp,
+				total_read, rfclen);
 	}
 =

 	if (rfclen !=3D clc_len) {
@@ -414,7 +418,8 @@ checkSMB(char *buf, unsigned int pdu_len, unsigned int=
 total_read,
 		if (rfclen < clc_len) {
 			cifs_dbg(VFS, "RFC1001 size %u smaller than SMB for mid=3D%u\n",
 				 rfclen, mid);
-			return -EIO;
+			return smb_EIO2(smb_eio_trace_rx_calc_len_too_big,
+					rfclen, clc_len);
 		} else if (rfclen > clc_len + 512) {
 			/*
 			 * Some servers (Windows XP in particular) send more
@@ -427,7 +432,8 @@ checkSMB(char *buf, unsigned int pdu_len, unsigned int=
 total_read,
 			 */
 			cifs_dbg(VFS, "RFC1001 size %u more than 512 bytes larger than SMB for=
 mid=3D%u\n",
 				 rfclen, mid);
-			return -EIO;
+			return smb_EIO2(smb_eio_trace_rx_overlong,
+					rfclen, clc_len + 512);
 		}
 	}
 	return 0;
diff --git a/fs/smb/client/netmisc.c b/fs/smb/client/netmisc.c
index 89bd1ca9e3ce..ee614e4db3b0 100644
--- a/fs/smb/client/netmisc.c
+++ b/fs/smb/client/netmisc.c
@@ -885,6 +885,10 @@ map_smb_to_linux_error(char *buf, bool logErr)
 	/* generic corrective action e.g. reconnect SMB session on
 	 * ERRbaduid could be added */
 =

+	if (rc =3D=3D -EIO)
+		smb_EIO2(smb_eio_trace_smb1_received_error,
+			 le32_to_cpu(smb->Status.CifsError),
+			 le16_to_cpu(smb->Flags2));
 	return rc;
 }
 =

diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
index 7ff728503ed1..6844f1dc3921 100644
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -775,7 +775,7 @@ find_cifs_entry(const unsigned int xid, struct cifs_tc=
on *tcon, loff_t pos,
 =

 		if (cfile->srch_inf.ntwrk_buf_start =3D=3D NULL) {
 			cifs_dbg(VFS, "ntwrk_buf_start is NULL during readdir\n");
-			return -EIO;
+			return smb_EIO(smb_eio_trace_null_pointers);
 		}
 =

 		end_of_smb =3D cfile->srch_inf.ntwrk_buf_start +
diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
index 10c84c095fe7..d8b7a48efbcb 100644
--- a/fs/smb/client/reparse.c
+++ b/fs/smb/client/reparse.c
@@ -732,7 +732,8 @@ static int parse_reparse_nfs(struct reparse_nfs_data_b=
uffer *buf,
 	len =3D le16_to_cpu(buf->ReparseDataLength);
 	if (len < sizeof(buf->InodeType)) {
 		cifs_dbg(VFS, "srv returned malformed nfs buffer\n");
-		return -EIO;
+		return smb_EIO2(smb_eio_trace_reparse_nfs_too_short,
+				len, sizeof(buf->InodeType));
 	}
 =

 	len -=3D sizeof(buf->InodeType);
@@ -741,7 +742,7 @@ static int parse_reparse_nfs(struct reparse_nfs_data_b=
uffer *buf,
 	case NFS_SPECFILE_LNK:
 		if (len =3D=3D 0 || (len % 2)) {
 			cifs_dbg(VFS, "srv returned malformed nfs symlink buffer\n");
-			return -EIO;
+			return smb_EIO1(smb_eio_trace_reparse_nfs_symbuf, len);
 		}
 		/*
 		 * Check that buffer does not contain UTF-16 null codepoint
@@ -749,7 +750,7 @@ static int parse_reparse_nfs(struct reparse_nfs_data_b=
uffer *buf,
 		 */
 		if (UniStrnlen((wchar_t *)buf->DataBuffer, len/2) !=3D len/2) {
 			cifs_dbg(VFS, "srv returned null byte in nfs symlink target location\n=
");
-			return -EIO;
+			return smb_EIO1(smb_eio_trace_reparse_nfs_nul, len);
 		}
 		data->symlink_target =3D cifs_strndup_from_utf16(buf->DataBuffer,
 							       len, true,
@@ -764,7 +765,7 @@ static int parse_reparse_nfs(struct reparse_nfs_data_b=
uffer *buf,
 		/* DataBuffer for block and char devices contains two 32-bit numbers */
 		if (len !=3D 8) {
 			cifs_dbg(VFS, "srv returned malformed nfs buffer for type: 0x%llx\n", =
type);
-			return -EIO;
+			return smb_EIO1(smb_eio_trace_reparse_nfs_dev, len);
 		}
 		break;
 	case NFS_SPECFILE_FIFO:
@@ -772,7 +773,7 @@ static int parse_reparse_nfs(struct reparse_nfs_data_b=
uffer *buf,
 		/* DataBuffer for fifos and sockets is empty */
 		if (len !=3D 0) {
 			cifs_dbg(VFS, "srv returned malformed nfs buffer for type: 0x%llx\n", =
type);
-			return -EIO;
+			return smb_EIO1(smb_eio_trace_reparse_nfs_sockfifo, len);
 		}
 		break;
 	default:
@@ -796,13 +797,13 @@ int smb2_parse_native_symlink(char **target, const c=
har *buf, unsigned int len,
 	int abs_path_len;
 	char *abs_path;
 	int levels;
-	int rc;
+	int rc, ulen;
 	int i;
 =

 	/* Check that length it valid */
 	if (!len || (len % 2)) {
 		cifs_dbg(VFS, "srv returned malformed symlink buffer\n");
-		rc =3D -EIO;
+		rc =3D smb_EIO1(smb_eio_trace_reparse_native_nul, len);
 		goto out;
 	}
 =

@@ -810,9 +811,10 @@ int smb2_parse_native_symlink(char **target, const ch=
ar *buf, unsigned int len,
 	 * Check that buffer does not contain UTF-16 null codepoint
 	 * because Linux cannot process symlink with null byte.
 	 */
-	if (UniStrnlen((wchar_t *)buf, len/2) !=3D len/2) {
+	ulen =3D UniStrnlen((wchar_t *)buf, len/2);
+	if (ulen !=3D len/2) {
 		cifs_dbg(VFS, "srv returned null byte in native symlink target location=
\n");
-		rc =3D -EIO;
+		rc =3D smb_EIO2(smb_eio_trace_reparse_native_nul, ulen, len);
 		goto out;
 	}
 =

@@ -996,7 +998,8 @@ static int parse_reparse_native_symlink(struct reparse=
_symlink_data_buffer *sym,
 	len =3D le16_to_cpu(sym->SubstituteNameLength);
 	if (offs + 20 > plen || offs + len + 20 > plen) {
 		cifs_dbg(VFS, "srv returned malformed symlink buffer\n");
-		return -EIO;
+		return smb_EIO2(smb_eio_trace_reparse_native_sym_len,
+				offs << 16 | len, plen);
 	}
 =

 	return smb2_parse_native_symlink(&data->symlink_target,
@@ -1019,13 +1022,15 @@ static int parse_reparse_wsl_symlink(struct repars=
e_wsl_symlink_data_buffer *buf
 =

 	if (len <=3D data_offset) {
 		cifs_dbg(VFS, "srv returned malformed wsl symlink buffer\n");
-		return -EIO;
+		return smb_EIO2(smb_eio_trace_reparse_wsl_symbuf,
+				len, data_offset);
 	}
 =

 	/* MS-FSCC 2.1.2.7 defines layout of the Target field only for Version 2=
. */
-	if (le32_to_cpu(buf->Version) !=3D 2) {
-		cifs_dbg(VFS, "srv returned unsupported wsl symlink version %u\n", le32=
_to_cpu(buf->Version));
-		return -EIO;
+	u32 version =3D le32_to_cpu(buf->Version);
+	if (version !=3D 2) {
+		cifs_dbg(VFS, "srv returned unsupported wsl symlink version %u\n", vers=
ion);
+		return smb_EIO1(smb_eio_trace_reparse_wsl_ver, version);
 	}
 =

 	/* Target for Version 2 is in UTF-8 but without trailing null-term byte =
*/
@@ -1034,9 +1039,11 @@ static int parse_reparse_wsl_symlink(struct reparse=
_wsl_symlink_data_buffer *buf
 	 * Check that buffer does not contain null byte
 	 * because Linux cannot process symlink with null byte.
 	 */
-	if (strnlen(buf->Target, symname_utf8_len) !=3D symname_utf8_len) {
+	size_t ulen =3D strnlen(buf->Target, symname_utf8_len);
+	if (ulen !=3D symname_utf8_len) {
 		cifs_dbg(VFS, "srv returned null byte in wsl symlink target location\n"=
);
-		return -EIO;
+		return smb_EIO2(smb_eio_trace_reparse_wsl_ver,
+				ulen, symname_utf8_len);
 	}
 	symname_utf16 =3D kzalloc(symname_utf8_len * 2, GFP_KERNEL);
 	if (!symname_utf16)
@@ -1083,13 +1090,16 @@ int parse_reparse_point(struct reparse_data_buffer=
 *buf,
 	case IO_REPARSE_TAG_AF_UNIX:
 	case IO_REPARSE_TAG_LX_FIFO:
 	case IO_REPARSE_TAG_LX_CHR:
-	case IO_REPARSE_TAG_LX_BLK:
-		if (le16_to_cpu(buf->ReparseDataLength) !=3D 0) {
+	case IO_REPARSE_TAG_LX_BLK: {
+		u16 dlen =3D le16_to_cpu(buf->ReparseDataLength);
+		if (dlen !=3D 0) {
+			u32 rtag =3D le32_to_cpu(buf->ReparseTag);
 			cifs_dbg(VFS, "srv returned malformed buffer for reparse point: 0x%08x=
\n",
-				 le32_to_cpu(buf->ReparseTag));
-			return -EIO;
+				 rtag);
+			return smb_EIO2(smb_eio_trace_reparse_data_len, dlen, rtag);
 		}
 		return 0;
+	}
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index 752dee5a020c..3e39faf63786 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -1503,7 +1503,7 @@ sess_auth_ntlmv2(struct sess_data *sess_data)
 	smb_buf =3D (struct smb_hdr *)sess_data->iov[0].iov_base;
 =

 	if (smb_buf->WordCount !=3D 3) {
-		rc =3D -EIO;
+		rc =3D smb_EIO1(smb_eio_trace_sess_nl2_wcc, smb_buf->WordCount);
 		cifs_dbg(VFS, "bad word count %d\n", smb_buf->WordCount);
 		goto out;
 	}
@@ -1629,7 +1629,7 @@ sess_auth_kerberos(struct sess_data *sess_data)
 	smb_buf =3D (struct smb_hdr *)sess_data->iov[0].iov_base;
 =

 	if (smb_buf->WordCount !=3D 4) {
-		rc =3D -EIO;
+		rc =3D smb_EIO1(smb_eio_trace_sess_krb_wcc, smb_buf->WordCount);
 		cifs_dbg(VFS, "bad word count %d\n", smb_buf->WordCount);
 		goto out_put_spnego_key;
 	}
@@ -1790,7 +1790,7 @@ sess_auth_rawntlmssp_negotiate(struct sess_data *ses=
s_data)
 	cifs_dbg(FYI, "rawntlmssp session setup challenge phase\n");
 =

 	if (smb_buf->WordCount !=3D 4) {
-		rc =3D -EIO;
+		rc =3D smb_EIO1(smb_eio_trace_sess_rawnl_neg_wcc, smb_buf->WordCount);
 		cifs_dbg(VFS, "bad word count %d\n", smb_buf->WordCount);
 		goto out_free_ntlmsspblob;
 	}
@@ -1880,7 +1880,7 @@ sess_auth_rawntlmssp_authenticate(struct sess_data *=
sess_data)
 	pSMB =3D (SESSION_SETUP_ANDX *)sess_data->iov[0].iov_base;
 	smb_buf =3D (struct smb_hdr *)sess_data->iov[0].iov_base;
 	if (smb_buf->WordCount !=3D 4) {
-		rc =3D -EIO;
+		rc =3D smb_EIO1(smb_eio_trace_sess_rawnl_auth_wcc, smb_buf->WordCount);
 		cifs_dbg(VFS, "bad word count %d\n", smb_buf->WordCount);
 		goto out_free_ntlmsspblob;
 	}
diff --git a/fs/smb/client/smb2file.c b/fs/smb/client/smb2file.c
index a7f629238830..68d37f11f3f3 100644
--- a/fs/smb/client/smb2file.c
+++ b/fs/smb/client/smb2file.c
@@ -76,11 +76,11 @@ int smb2_fix_symlink_target_type(char **target, bool d=
irectory, struct cifs_sb_i
 		return 0;
 =

 	if (!*target)
-		return -EIO;
+		return smb_EIO(smb_eio_trace_null_pointers);
 =

 	len =3D strlen(*target);
 	if (!len)
-		return -EIO;
+		return smb_EIO1(smb_eio_trace_sym_target_len, len);
 =

 	/*
 	 * If this is directory symlink and it does not have trailing slash then
@@ -104,7 +104,7 @@ int smb2_fix_symlink_target_type(char **target, bool d=
irectory, struct cifs_sb_i
 	 * both Windows and Linux systems. So return an error for such symlink.
 	 */
 	if (!directory && (*target)[len-1] =3D=3D '/')
-		return -EIO;
+		return smb_EIO(smb_eio_trace_sym_slash);
 =

 	return 0;
 }
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index d0aad4821ed4..8369e8db2ea5 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -35,12 +35,14 @@ static struct reparse_data_buffer *reparse_buf_ptr(str=
uct kvec *iov)
 	count =3D le32_to_cpu(io->OutputCount);
 	off =3D le32_to_cpu(io->OutputOffset);
 	if (check_add_overflow(off, count, &len) || len > iov->iov_len)
-		return ERR_PTR(-EIO);
+		return ERR_PTR(smb_EIO2(smb_eio_trace_reparse_overlong,
+					off, count));
 =

 	buf =3D (struct reparse_data_buffer *)((u8 *)io + off);
 	len =3D sizeof(*buf);
-	if (count < len || count < le16_to_cpu(buf->ReparseDataLength) + len)
-		return ERR_PTR(-EIO);
+	u16 rdlen =3D le16_to_cpu(buf->ReparseDataLength);
+	if (count < len || count < rdlen + len)
+		return ERR_PTR(smb_EIO2(smb_eio_trace_reparse_rdlen, count, rdlen));
 	return buf;
 }
 =

@@ -1635,7 +1637,7 @@ int smb2_rename_pending_delete(const char *full_path=
,
 	} else {
 		cifs_tcon_dbg(FYI, "%s: failed to rename '%s' to '%s': %d\n",
 			      __func__, full_path, to_name, rc);
-		rc =3D -EIO;
+		rc =3D smb_EIO1(smb_eio_trace_pend_del_fail, rc);
 	}
 out:
 	cifs_put_tlink(tlink);
diff --git a/fs/smb/client/smb2maperror.c b/fs/smb/client/smb2maperror.c
index 12c2b868789f..b179d7369fba 100644
--- a/fs/smb/client/smb2maperror.c
+++ b/fs/smb/client/smb2maperror.c
@@ -9,6 +9,7 @@
  */
 #include <linux/errno.h>
 #include "cifsglob.h"
+#include "cifsproto.h"
 #include "cifs_debug.h"
 #include "smb2pdu.h"
 #include "smb2proto.h"
@@ -2477,5 +2478,7 @@ map_smb2_to_linux_error(char *buf, bool log_err)
 			   le16_to_cpu(shdr->Command),
 			   le64_to_cpu(shdr->MessageId),
 			   le32_to_cpu(smb2err), rc);
+	if (rc =3D=3D -EIO)
+		smb_EIO1(smb_eio_trace_smb2_received_error, le32_to_cpu(smb2err));
 	return rc;
 }
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index d19104f99fe4..e6cc9a6da214 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -1046,7 +1046,8 @@ move_smb2_ea_to_cifs(char *dst, size_t dst_size,
 =

 		if (src_size < 8 + name_len + 1 + value_len) {
 			cifs_dbg(FYI, "EA entry goes beyond length of list\n");
-			rc =3D -EIO;
+			rc =3D smb_EIO2(smb_eio_trace_ea_overrun,
+				      src_size, 8 + name_len + 1 + value_len);
 			goto out;
 		}
 =

@@ -1607,7 +1608,7 @@ smb2_ioctl_query_info(const unsigned int xid,
 	}
 =

 	if (!ses || !server) {
-		rc =3D -EIO;
+		rc =3D smb_EIO(smb_eio_trace_null_pointers);
 		goto free_vars;
 	}
 =

@@ -1942,7 +1943,7 @@ smb2_copychunk_range(const unsigned int xid,
 		if (unlikely(ret_data_len !=3D sizeof(*cc_rsp))) {
 			cifs_tcon_dbg(VFS, "Copychunk invalid response: size %u/%zu\n",
 				      ret_data_len, sizeof(*cc_rsp));
-			rc =3D -EIO;
+			rc =3D smb_EIO1(smb_eio_trace_copychunk_inv_rsp, ret_data_len);
 			goto out;
 		}
 =

@@ -1952,11 +1953,18 @@ smb2_copychunk_range(const unsigned int xid,
 =

 		if (rc =3D=3D 0) {
 			/* Check if server claimed to write more than we asked */
-			if (unlikely(!bytes_written || bytes_written > copy_bytes ||
-				     !chunks_written || chunks_written > chunks)) {
-				cifs_tcon_dbg(VFS, "Copychunk invalid response: bytes written %u/%u, =
chunks written %u/%u\n",
-					      bytes_written, copy_bytes, chunks_written, chunks);
-				rc =3D -EIO;
+			if (unlikely(!bytes_written || bytes_written > copy_bytes)) {
+				cifs_tcon_dbg(VFS, "Copychunk invalid response: bytes written %u/%u\n=
",
+					      bytes_written, copy_bytes);
+				rc =3D smb_EIO2(smb_eio_trace_copychunk_overcopy_b,
+					      bytes_written, copy_bytes);
+				goto out;
+			}
+			if (unlikely(!chunks_written || chunks_written > chunks)) {
+				cifs_tcon_dbg(VFS, "Copychunk invalid response: chunks written %u/%u\=
n",
+					      chunks_written, chunks);
+				rc =3D smb_EIO2(smb_eio_trace_copychunk_overcopy_c,
+					      chunks_written, chunks);
 				goto out;
 			}
 =

@@ -3127,7 +3135,7 @@ smb2_get_dfs_refer(const unsigned int xid, struct ci=
fs_ses *ses,
 	}
 =

 	if (!rc && !dfs_rsp)
-		rc =3D -EIO;
+		rc =3D smb_EIO(smb_eio_trace_dfsref_no_rsp);
 	if (rc) {
 		if (!is_retryable_error(rc) && rc !=3D -ENOENT && rc !=3D -EOPNOTSUPP)
 			cifs_tcon_dbg(FYI, "%s: ioctl error: rc=3D%d\n", __func__, rc);
@@ -4555,7 +4563,7 @@ smb3_init_transform_rq(struct TCP_Server_Info *serve=
r, int num_rqst,
 					     buffer, 0, 0, size);
 =

 			if (!cifs_copy_iter_to_folioq(&old->rq_iter, size, buffer)) {
-				rc =3D -EIO;
+				rc =3D smb_EIO1(smb_eio_trace_tx_copy_iter_to_buf, size);
 				goto err_free;
 			}
 		}
@@ -4656,7 +4664,8 @@ cifs_copy_folioq_to_iter(struct folio_queue *folioq,=
 size_t data_size,
 			n =3D copy_folio_to_iter(folio, skip, len, iter);
 			if (n !=3D len) {
 				cifs_dbg(VFS, "%s: something went wrong\n", __func__);
-				return -EIO;
+				return smb_EIO2(smb_eio_trace_rx_copy_to_iter,
+						n, len);
 			}
 			data_size -=3D n;
 			skip =3D 0;
@@ -4739,7 +4748,7 @@ handle_read_data(struct TCP_Server_Info *server, str=
uct smb_message *smb,
 		/* data_offset is beyond the end of smallbuf */
 		cifs_dbg(FYI, "%s: data offset (%u) beyond end of smallbuf\n",
 			 __func__, data_offset);
-		rdata->result =3D -EIO;
+		rdata->result =3D smb_EIO1(smb_eio_trace_rx_overlong, data_offset);
 		if (is_offloaded)
 			smb->mid_state =3D MID_RESPONSE_MALFORMED;
 		else
@@ -4758,7 +4767,7 @@ handle_read_data(struct TCP_Server_Info *server, str=
uct smb_message *smb,
 			/* data offset is beyond the 1st page of response */
 			cifs_dbg(FYI, "%s: data offset (%u) beyond 1st page of response\n",
 				 __func__, data_offset);
-			rdata->result =3D -EIO;
+			rdata->result =3D smb_EIO1(smb_eio_trace_rx_overpage, data_offset);
 			if (is_offloaded)
 				smb->mid_state =3D MID_RESPONSE_MALFORMED;
 			else
@@ -4768,7 +4777,7 @@ handle_read_data(struct TCP_Server_Info *server, str=
uct smb_message *smb,
 =

 		if (data_len > buffer_len - pad_len) {
 			/* data_len is corrupt -- discard frame */
-			rdata->result =3D -EIO;
+			rdata->result =3D smb_EIO1(smb_eio_trace_rx_bad_datalen, data_len);
 			if (is_offloaded)
 				smb->mid_state =3D MID_RESPONSE_MALFORMED;
 			else
@@ -4793,12 +4802,12 @@ handle_read_data(struct TCP_Server_Info *server, s=
truct smb_message *smb,
 		WARN_ONCE(buffer, "read data can be either in buf or in buffer");
 		copied =3D copy_to_iter(buf + data_offset, data_len, &rdata->subreq.io_=
iter);
 		if (copied =3D=3D 0)
-			return -EIO;
+			return smb_EIO2(smb_eio_trace_rx_copy_to_iter, copied, data_len);
 		rdata->got_bytes =3D copied;
 	} else {
 		/* read response payload cannot be in both buf and pages */
 		WARN_ONCE(1, "buf can not contain only a part of read data");
-		rdata->result =3D -EIO;
+		rdata->result =3D smb_EIO(smb_eio_trace_rx_both_buf);
 		if (is_offloaded)
 			smb->mid_state =3D MID_RESPONSE_MALFORMED;
 		else
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index b5f174b44be0..38536bc5c127 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -249,15 +249,15 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon=
 *tcon,
 =

 	ses =3D tcon->ses;
 	if (!ses)
-		return -EIO;
+		return smb_EIO(smb_eio_trace_null_pointers);
 	spin_lock(&ses->ses_lock);
 	if (ses->ses_status =3D=3D SES_EXITING) {
 		spin_unlock(&ses->ses_lock);
-		return -EIO;
+		return smb_EIO(smb_eio_trace_sess_exiting);
 	}
 	spin_unlock(&ses->ses_lock);
 	if (!ses->server || !server)
-		return -EIO;
+		return smb_EIO(smb_eio_trace_null_pointers);
 =

 	spin_lock(&server->srv_lock);
 	if (server->tcpStatus =3D=3D CifsNeedReconnect) {
@@ -1061,7 +1061,7 @@ SMB2_negotiate(const unsigned int xid,
 =

 	if (!server) {
 		WARN(1, "%s: server is NULL!\n", __func__);
-		return -EIO;
+		return smb_EIO(smb_eio_trace_null_pointers);
 	}
 =

 	rc =3D smb2_plain_req_init(SMB2_NEGOTIATE, NULL, server,
@@ -1142,64 +1142,84 @@ SMB2_negotiate(const unsigned int xid,
 	} else if (rc !=3D 0)
 		goto neg_exit;
 =

-	rc =3D -EIO;
+	u16 dialect =3D le16_to_cpu(rsp->DialectRevision);
 	if (strcmp(server->vals->version_string,
 		   SMB3ANY_VERSION_STRING) =3D=3D 0) {
-		if (rsp->DialectRevision =3D=3D cpu_to_le16(SMB20_PROT_ID)) {
+		switch (dialect) {
+		case SMB20_PROT_ID:
 			cifs_server_dbg(VFS,
 				"SMB2 dialect returned but not requested\n");
+			rc =3D smb_EIO2(smb_eio_trace_neg_unreq_dialect, dialect, 3);
 			goto neg_exit;
-		} else if (rsp->DialectRevision =3D=3D cpu_to_le16(SMB21_PROT_ID)) {
+		case SMB21_PROT_ID:
 			cifs_server_dbg(VFS,
 				"SMB2.1 dialect returned but not requested\n");
+			rc =3D smb_EIO2(smb_eio_trace_neg_unreq_dialect, dialect, 3);
 			goto neg_exit;
-		} else if (rsp->DialectRevision =3D=3D cpu_to_le16(SMB311_PROT_ID)) {
+		case SMB311_PROT_ID:
 			/* ops set to 3.0 by default for default so update */
 			server->ops =3D &smb311_operations;
 			server->vals =3D &smb311_values;
+			break;
+		default:
+			break;
 		}
 	} else if (strcmp(server->vals->version_string,
-		   SMBDEFAULT_VERSION_STRING) =3D=3D 0) {
-		if (rsp->DialectRevision =3D=3D cpu_to_le16(SMB20_PROT_ID)) {
+			  SMBDEFAULT_VERSION_STRING) =3D=3D 0) {
+		switch (dialect) {
+		case SMB20_PROT_ID:
 			cifs_server_dbg(VFS,
 				"SMB2 dialect returned but not requested\n");
+			rc =3D smb_EIO2(smb_eio_trace_neg_unreq_dialect, dialect, 0);
 			goto neg_exit;
-		} else if (rsp->DialectRevision =3D=3D cpu_to_le16(SMB21_PROT_ID)) {
+		case SMB21_PROT_ID:
 			/* ops set to 3.0 by default for default so update */
 			server->ops =3D &smb21_operations;
 			server->vals =3D &smb21_values;
-		} else if (rsp->DialectRevision =3D=3D cpu_to_le16(SMB311_PROT_ID)) {
+			break;
+		case SMB311_PROT_ID:
 			server->ops =3D &smb311_operations;
 			server->vals =3D &smb311_values;
+			break;
+		default:
+			break;
 		}
-	} else if (le16_to_cpu(rsp->DialectRevision) !=3D
-				server->vals->protocol_id) {
+	} else if (dialect !=3D server->vals->protocol_id) {
 		/* if requested single dialect ensure returned dialect matched */
 		cifs_server_dbg(VFS, "Invalid 0x%x dialect returned: not requested\n",
-				le16_to_cpu(rsp->DialectRevision));
+				dialect);
+		rc =3D smb_EIO2(smb_eio_trace_neg_unreq_dialect,
+			      dialect, server->vals->protocol_id);
 		goto neg_exit;
 	}
 =

 	cifs_dbg(FYI, "mode 0x%x\n", rsp->SecurityMode);
 =

-	if (rsp->DialectRevision =3D=3D cpu_to_le16(SMB20_PROT_ID))
+	switch (dialect) {
+	case SMB20_PROT_ID:
 		cifs_dbg(FYI, "negotiated smb2.0 dialect\n");
-	else if (rsp->DialectRevision =3D=3D cpu_to_le16(SMB21_PROT_ID))
+		break;
+	case SMB21_PROT_ID:
 		cifs_dbg(FYI, "negotiated smb2.1 dialect\n");
-	else if (rsp->DialectRevision =3D=3D cpu_to_le16(SMB30_PROT_ID))
+		break;
+	case SMB30_PROT_ID:
 		cifs_dbg(FYI, "negotiated smb3.0 dialect\n");
-	else if (rsp->DialectRevision =3D=3D cpu_to_le16(SMB302_PROT_ID))
+		break;
+	case SMB302_PROT_ID:
 		cifs_dbg(FYI, "negotiated smb3.02 dialect\n");
-	else if (rsp->DialectRevision =3D=3D cpu_to_le16(SMB311_PROT_ID))
+		break;
+	case SMB311_PROT_ID:
 		cifs_dbg(FYI, "negotiated smb3.1.1 dialect\n");
-	else {
+		break;
+	default:
 		cifs_server_dbg(VFS, "Invalid dialect returned by server 0x%x\n",
-				le16_to_cpu(rsp->DialectRevision));
+				dialect);
+		rc =3D smb_EIO1(smb_eio_trace_neg_inval_dialect, dialect);
 		goto neg_exit;
 	}
 =

 	rc =3D 0;
-	server->dialect =3D le16_to_cpu(rsp->DialectRevision);
+	server->dialect =3D dialect;
 =

 	/*
 	 * Keep a copy of the hash after negprot. This hash will be
@@ -1255,10 +1275,10 @@ SMB2_negotiate(const unsigned int xid,
 		if (rc =3D=3D 1)
 			rc =3D 0;
 		else if (rc =3D=3D 0)
-			rc =3D -EIO;
+			rc =3D smb_EIO1(smb_eio_trace_neg_decode_token, rc);
 	}
 =

-	if (rsp->DialectRevision =3D=3D cpu_to_le16(SMB311_PROT_ID)) {
+	if (server->dialect =3D=3D SMB311_PROT_ID) {
 		if (rsp->NegotiateContextCount)
 			rc =3D smb311_decode_neg_context(rsp, server,
 						       rsp_iov.iov_len);
@@ -1371,32 +1391,44 @@ int smb3_validate_negotiate(const unsigned int xid=
, struct cifs_tcon *tcon)
 	} else if (rc !=3D 0) {
 		cifs_tcon_dbg(VFS, "validate protocol negotiate failed: %d\n",
 			      rc);
-		rc =3D -EIO;
+		rc =3D smb_EIO1(smb_eio_trace_neg_info_fail, rc);
 		goto out_free_inbuf;
 	}
 =

-	rc =3D -EIO;
 	if (rsplen !=3D sizeof(*pneg_rsp)) {
 		cifs_tcon_dbg(VFS, "Invalid protocol negotiate response size: %d\n",
 			      rsplen);
 =

 		/* relax check since Mac returns max bufsize allowed on ioctl */
-		if (rsplen > CIFSMaxBufSize || rsplen < sizeof(*pneg_rsp))
+		if (rsplen > CIFSMaxBufSize || rsplen < sizeof(*pneg_rsp)) {
+			rc =3D smb_EIO1(smb_eio_trace_neg_bad_rsplen, rsplen);
 			goto out_free_rsp;
+		}
 	}
 =

 	/* check validate negotiate info response matches what we got earlier */
-	if (pneg_rsp->Dialect !=3D cpu_to_le16(server->dialect))
+	u16 dialect =3D le16_to_cpu(pneg_rsp->Dialect);
+	if (dialect !=3D server->dialect) {
+		rc =3D smb_EIO2(smb_eio_trace_neg_info_dialect,
+			      dialect, server->dialect);
 		goto vneg_out;
+	}
 =

-	if (pneg_rsp->SecurityMode !=3D cpu_to_le16(server->sec_mode))
+	u16 sec_mode =3D le16_to_cpu(pneg_rsp->SecurityMode);
+	if (sec_mode !=3D server->sec_mode) {
+		rc =3D smb_EIO2(smb_eio_trace_neg_info_sec_mode,
+			      sec_mode, server->sec_mode);
 		goto vneg_out;
+	}
 =

 	/* do not validate server guid because not saved at negprot time yet */
-
-	if ((le32_to_cpu(pneg_rsp->Capabilities) | SMB2_NT_FIND |
-	      SMB2_LARGE_FILES) !=3D server->capabilities)
+	u32 caps =3D le32_to_cpu(pneg_rsp->Capabilities);
+	if ((caps | SMB2_NT_FIND |
+	     SMB2_LARGE_FILES) !=3D server->capabilities) {
+		rc =3D smb_EIO2(smb_eio_trace_neg_info_caps,
+			      caps, server->capabilities);
 		goto vneg_out;
+	}
 =

 	/* validate negotiate successful */
 	rc =3D 0;
@@ -1758,11 +1790,10 @@ SMB2_sess_auth_rawntlmssp_negotiate(struct SMB2_se=
ss_data *sess_data)
 	if (rc)
 		goto out;
 =

-	if (offsetof(struct smb2_sess_setup_rsp, Buffer) !=3D
-			le16_to_cpu(rsp->SecurityBufferOffset)) {
-		cifs_dbg(VFS, "Invalid security buffer offset %d\n",
-			le16_to_cpu(rsp->SecurityBufferOffset));
-		rc =3D -EIO;
+	u16 boff =3D le16_to_cpu(rsp->SecurityBufferOffset);
+	if (offsetof(struct smb2_sess_setup_rsp, Buffer) !=3D boff) {
+		cifs_dbg(VFS, "Invalid security buffer offset %d\n", boff);
+		rc =3D smb_EIO1(smb_eio_trace_sess_buf_off, boff);
 		goto out;
 	}
 	rc =3D decode_ntlmssp_challenge(rsp->Buffer,
@@ -1916,7 +1947,7 @@ SMB2_sess_setup(const unsigned int xid, struct cifs_=
ses *ses,
 =

 	if (!server) {
 		WARN(1, "%s: server is NULL!\n", __func__);
-		return -EIO;
+		return smb_EIO(smb_eio_trace_null_pointers);
 	}
 =

 	sess_data =3D kzalloc(sizeof(struct SMB2_sess_data), GFP_KERNEL);
@@ -1966,10 +1997,9 @@ SMB2_logoff(const unsigned int xid, struct cifs_ses=
 *ses)
 =

 	cifs_dbg(FYI, "disconnect session %p\n", ses);
 =

-	if (ses && (ses->server))
-		server =3D ses->server;
-	else
-		return -EIO;
+	if (!ses || !ses->server)
+		return smb_EIO(smb_eio_trace_null_pointers);
+	server =3D ses->server;
 =

 	/* no need to send SMB logoff if uid already closed due to reconnect */
 	spin_lock(&ses->chan_lock);
@@ -2048,7 +2078,7 @@ SMB2_tcon(const unsigned int xid, struct cifs_ses *s=
es, const char *tree,
 	cifs_dbg(FYI, "TCON\n");
 =

 	if (!server || !tree)
-		return -EIO;
+		return smb_EIO(smb_eio_trace_null_pointers);
 =

 	unc_path =3D kmalloc(MAX_SHARENAME_LENGTH * 2, GFP_KERNEL);
 	if (unc_path =3D=3D NULL)
@@ -2186,7 +2216,7 @@ SMB2_tdis(const unsigned int xid, struct cifs_tcon *=
tcon)
 	cifs_dbg(FYI, "Tree Disconnect\n");
 =

 	if (!ses || !(ses->server))
-		return -EIO;
+		return smb_EIO(smb_eio_trace_null_pointers);
 =

 	trace_smb3_tdis_enter(xid, tcon->tid, ses->Suid, tcon->tree_name);
 	spin_lock(&ses->chan_lock);
@@ -2856,7 +2886,7 @@ int smb311_posix_mkdir(const unsigned int xid, struc=
t inode *inode,
 		return -ENOMEM;
 =

 	if (!ses || !server) {
-		rc =3D -EIO;
+		rc =3D smb_EIO(smb_eio_trace_null_pointers);
 		goto err_free_path;
 	}
 =

@@ -2973,7 +3003,7 @@ int smb311_posix_mkdir(const unsigned int xid, struc=
t inode *inode,
 	 */
 	rsp =3D (struct smb2_create_rsp *)rsp_iov.iov_base;
 	if (rsp =3D=3D NULL) {
-		rc =3D -EIO;
+		rc =3D smb_EIO(smb_eio_trace_mkdir_no_rsp);
 		kfree(pc_buf);
 		goto err_free_req;
 	}
@@ -3211,7 +3241,7 @@ SMB2_open(const unsigned int xid, struct cifs_open_p=
arms *oparms, __le16 *path,
 =

 	cifs_dbg(FYI, "create/open\n");
 	if (!ses || !server)
-		return -EIO;
+		return smb_EIO(smb_eio_trace_null_pointers);
 =

 	if (smb3_encryption_required(tcon))
 		flags |=3D CIFS_TRANSFORM_REQ;
@@ -3417,11 +3447,11 @@ SMB2_ioctl(const unsigned int xid, struct cifs_tco=
n *tcon, u64 persistent_fid,
 	int retries =3D 0, cur_sleep =3D 1;
 =

 	if (!tcon)
-		return -EIO;
+		return smb_EIO(smb_eio_trace_null_pointers);
 =

 	ses =3D tcon->ses;
 	if (!ses)
-		return -EIO;
+		return smb_EIO(smb_eio_trace_null_pointers);
 =

 replay_again:
 	/* reinitialize for possible replay */
@@ -3429,7 +3459,7 @@ SMB2_ioctl(const unsigned int xid, struct cifs_tcon =
*tcon, u64 persistent_fid,
 	server =3D cifs_pick_channel(ses);
 =

 	if (!server)
-		return -EIO;
+		return smb_EIO(smb_eio_trace_null_pointers);
 =

 	cifs_dbg(FYI, "SMB2 IOCTL\n");
 =

@@ -3492,7 +3522,7 @@ SMB2_ioctl(const unsigned int xid, struct cifs_tcon =
*tcon, u64 persistent_fid,
 	 * warning)
 	 */
 	if (rsp =3D=3D NULL) {
-		rc =3D -EIO;
+		rc =3D smb_EIO(smb_eio_trace_ioctl_no_rsp);
 		goto ioctl_exit;
 	}
 =

@@ -3503,16 +3533,17 @@ SMB2_ioctl(const unsigned int xid, struct cifs_tco=
n *tcon, u64 persistent_fid,
 		goto ioctl_exit; /* server returned no data */
 	else if (*plen > rsp_iov.iov_len || *plen > 0xFF00) {
 		cifs_tcon_dbg(VFS, "srv returned invalid ioctl length: %d\n", *plen);
+		rc =3D smb_EIO2(smb_eio_trace_ioctl_data_len, *plen, rsp_iov.iov_len);
 		*plen =3D 0;
-		rc =3D -EIO;
 		goto ioctl_exit;
 	}
 =

-	if (rsp_iov.iov_len - *plen < le32_to_cpu(rsp->OutputOffset)) {
-		cifs_tcon_dbg(VFS, "Malformed ioctl resp: len %d offset %d\n", *plen,
-			le32_to_cpu(rsp->OutputOffset));
+	u32 outoff =3D le32_to_cpu(rsp->OutputOffset);
+	if (rsp_iov.iov_len - *plen < outoff) {
+		cifs_tcon_dbg(VFS, "Malformed ioctl resp: len %d offset %d\n",
+			      *plen, outoff);
+		rc =3D smb_EIO2(smb_eio_trace_ioctl_out_off, rsp_iov.iov_len - *plen, o=
utoff);
 		*plen =3D 0;
-		rc =3D -EIO;
 		goto ioctl_exit;
 	}
 =

@@ -3620,7 +3651,7 @@ __SMB2_close(const unsigned int xid, struct cifs_tco=
n *tcon,
 	cifs_dbg(FYI, "Close\n");
 =

 	if (!ses || !server)
-		return -EIO;
+		return smb_EIO(smb_eio_trace_null_pointers);
 =

 	if (smb3_encryption_required(tcon))
 		flags |=3D CIFS_TRANSFORM_REQ;
@@ -3817,7 +3848,7 @@ query_info(const unsigned int xid, struct cifs_tcon =
*tcon,
 	cifs_dbg(FYI, "Query Info\n");
 =

 	if (!ses)
-		return -EIO;
+		return smb_EIO(smb_eio_trace_null_pointers);
 =

 replay_again:
 	/* reinitialize for possible replay */
@@ -3826,7 +3857,7 @@ query_info(const unsigned int xid, struct cifs_tcon =
*tcon,
 	server =3D cifs_pick_channel(ses);
 =

 	if (!server)
-		return -EIO;
+		return smb_EIO(smb_eio_trace_null_pointers);
 =

 	if (smb3_encryption_required(tcon))
 		flags |=3D CIFS_TRANSFORM_REQ;
@@ -4011,7 +4042,7 @@ SMB2_change_notify(const unsigned int xid, struct ci=
fs_tcon *tcon,
 =

 	cifs_dbg(FYI, "change notify\n");
 	if (!ses || !server)
-		return -EIO;
+		return smb_EIO(smb_eio_trace_null_pointers);
 =

 	if (smb3_encryption_required(tcon))
 		flags |=3D CIFS_TRANSFORM_REQ;
@@ -4347,7 +4378,7 @@ SMB2_flush(const unsigned int xid, struct cifs_tcon =
*tcon, u64 persistent_fid,
 =

 	cifs_dbg(FYI, "flush\n");
 	if (!ses || !(ses->server))
-		return -EIO;
+		return smb_EIO(smb_eio_trace_null_pointers);
 =

 	if (smb3_encryption_required(tcon))
 		flags |=3D CIFS_TRANSFORM_REQ;
@@ -4582,11 +4613,12 @@ smb2_readv_callback(struct TCP_Server_Info *server=
, struct smb_message *smb)
 		trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_malformed);
 		credits.value =3D le16_to_cpu(shdr->CreditRequest);
 		credits.instance =3D server->reconnect_instance;
-		rdata->result =3D -EIO;
+		rdata->result =3D smb_EIO(smb_eio_trace_read_rsp_malformed);
 		break;
 	default:
 		trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_unknown);
-		rdata->result =3D -EIO;
+		rdata->result =3D smb_EIO1(smb_eio_trace_read_mid_state_unknown,
+					 smb->mid_state);
 		break;
 	}
 #ifdef CONFIG_CIFS_SMB_DIRECT
@@ -4795,7 +4827,8 @@ SMB2_read(const unsigned int xid, struct cifs_io_par=
ms *io_parms,
 	    (*nbytes > io_parms->length)) {
 		cifs_dbg(FYI, "bad length %d for count %d\n",
 			 *nbytes, io_parms->length);
-		rc =3D -EIO;
+		rc =3D smb_EIO2(smb_eio_trace_read_overlarge,
+			      *nbytes, io_parms->length);
 		*nbytes =3D 0;
 	}
 =

@@ -4881,11 +4914,12 @@ smb2_writev_callback(struct TCP_Server_Info *serve=
r, struct smb_message *smb)
 		trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_malformed);
 		credits.value =3D le16_to_cpu(rsp->hdr.CreditRequest);
 		credits.instance =3D server->reconnect_instance;
-		result =3D -EIO;
+		result =3D smb_EIO(smb_eio_trace_write_rsp_malformed);
 		break;
 	default:
 		trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_unknown);
-		result =3D -EIO;
+		result =3D smb_EIO1(smb_eio_trace_write_mid_state_unknown,
+				  smb->mid_state);
 		break;
 	}
 #ifdef CONFIG_CIFS_SMB_DIRECT
@@ -5528,7 +5562,7 @@ SMB2_query_directory(const unsigned int xid, struct =
cifs_tcon *tcon,
 	server =3D cifs_pick_channel(ses);
 =

 	if (!ses || !(ses->server))
-		return -EIO;
+		return smb_EIO(smb_eio_trace_null_pointers);
 =

 	if (smb3_encryption_required(tcon))
 		flags |=3D CIFS_TRANSFORM_REQ;
@@ -5663,7 +5697,7 @@ send_set_info(const unsigned int xid, struct cifs_tc=
on *tcon,
 	server =3D cifs_pick_channel(ses);
 =

 	if (!ses || !server)
-		return -EIO;
+		return smb_EIO(smb_eio_trace_null_pointers);
 =

 	if (!num)
 		return -EINVAL;
@@ -5860,7 +5894,7 @@ build_qfs_info_req(struct kvec *iov, struct cifs_tco=
n *tcon,
 	cifs_dbg(FYI, "Query FSInfo level %d\n", level);
 =

 	if ((tcon->ses =3D=3D NULL) || server =3D=3D NULL)
-		return -EIO;
+		return smb_EIO(smb_eio_trace_null_pointers);
 =

 	rc =3D smb2_plain_req_init(SMB2_QUERY_INFO, tcon, server,
 				 (void **) &req, &total_len);
diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
index 47eab3753c9e..b5bd450d30a8 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -153,7 +153,7 @@ static int smb2_get_sign_key(struct TCP_Server_Info *s=
erver,
 				memcpy(key, ses->auth_key.response,
 				       SMB2_NTLMV2_SESSKEY_SIZE);
 			} else {
-				rc =3D -EIO;
+				rc =3D smb_EIO(smb_eio_trace_no_auth_key);
 			}
 			break;
 		default:
diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index c6c428c2e08d..1c2fc560b2de 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -979,7 +979,7 @@ static int smbd_post_send_negotiate_req(struct smbdire=
ct_socket *sc)
 				sc->ib.dev, (void *)packet,
 				sizeof(*packet), DMA_TO_DEVICE);
 	if (ib_dma_mapping_error(sc->ib.dev, request->sge[0].addr)) {
-		rc =3D -EIO;
+		rc =3D smb_EIO(smb_eio_trace_rdma_dma_map);
 		goto dma_mapping_failed;
 	}
 =

@@ -1179,7 +1179,7 @@ static int smbd_post_send_iter(struct smbdirect_sock=
et *sc,
 						 header_length,
 						 DMA_TO_DEVICE);
 	if (ib_dma_mapping_error(sc->ib.dev, request->sge[0].addr)) {
-		rc =3D -EIO;
+		rc =3D smb_EIO(smb_eio_trace_rdma_dma_map);
 		goto err_dma;
 	}
 =

@@ -1321,13 +1321,13 @@ static int smbd_post_recv(
 {
 	struct smbdirect_socket_parameters *sp =3D &sc->parameters;
 	struct ib_recv_wr recv_wr;
-	int rc =3D -EIO;
+	int rc;
 =

 	response->sge.addr =3D ib_dma_map_single(
 				sc->ib.dev, response->packet,
 				sp->max_recv_size, DMA_FROM_DEVICE);
 	if (ib_dma_mapping_error(sc->ib.dev, response->sge.addr))
-		return rc;
+		return smb_EIO(smb_eio_trace_rdma_dma_map);
 =

 	response->sge.length =3D sp->max_recv_size;
 	response->sge.lkey =3D sc->ib.pd->local_dma_lkey;
@@ -2855,7 +2855,7 @@ static ssize_t smb_extract_bvec_to_rdma(struct iov_i=
ter *iter,
 		off =3D bv[i].bv_offset + start;
 =

 		if (!smb_set_sge(rdma, bv[i].bv_page, off, len))
-			return -EIO;
+			return smb_EIO(smb_eio_trace_rdma_set_sge);
 =

 		ret +=3D len;
 		maxsize -=3D len;
@@ -2909,7 +2909,7 @@ static ssize_t smb_extract_kvec_to_rdma(struct iov_i=
ter *iter,
 				page =3D virt_to_page((void *)kaddr);
 =

 			if (!smb_set_sge(rdma, page, off, seg))
-				return -EIO;
+				return smb_EIO(smb_eio_trace_rdma_set_sge);
 =

 			ret +=3D seg;
 			len -=3D seg;
@@ -2945,7 +2945,7 @@ static ssize_t smb_extract_folioq_to_rdma(struct iov=
_iter *iter,
 	if (slot >=3D folioq_nr_slots(folioq)) {
 		folioq =3D folioq->next;
 		if (WARN_ON_ONCE(!folioq))
-			return -EIO;
+			return smb_EIO(smb_eio_trace_rdma_fq_overrun);
 		slot =3D 0;
 	}
 =

@@ -2957,7 +2957,7 @@ static ssize_t smb_extract_folioq_to_rdma(struct iov=
_iter *iter,
 			size_t part =3D umin(maxsize, fsize - offset);
 =

 			if (!smb_set_sge(rdma, folio_page(folio, 0), offset, part))
-				return -EIO;
+				return smb_EIO(smb_eio_trace_rdma_set_sge);
 =

 			offset +=3D part;
 			ret +=3D part;
@@ -3014,7 +3014,7 @@ static ssize_t smb_extract_iter_to_rdma(struct iov_i=
ter *iter, size_t len,
 		break;
 	default:
 		WARN_ON_ONCE(1);
-		return -EIO;
+		return smb_EIO(smb_eio_trace_rdma_iter_type);
 	}
 =

 	if (ret < 0) {
diff --git a/fs/smb/client/trace.h b/fs/smb/client/trace.h
index 28e00c34df1c..65c62c7a7b00 100644
--- a/fs/smb/client/trace.h
+++ b/fs/smb/client/trace.h
@@ -20,6 +20,140 @@
 /*
  * Specify enums for tracing information.
  */
+#define smb_eio_traces \
+	EM(smb_eio_trace_compress_copy,			"compress_copy") \
+	EM(smb_eio_trace_copychunk_inv_rsp,		"copychunk_inv_rsp") \
+	EM(smb_eio_trace_copychunk_overcopy_b,		"copychunk_overcopy_b") \
+	EM(smb_eio_trace_copychunk_overcopy_c,		"copychunk_overcopy_c") \
+	EM(smb_eio_trace_create_rsp_too_small,		"create_rsp_too_small") \
+	EM(smb_eio_trace_dfsref_no_rsp,			"dfsref_no_rsp") \
+	EM(smb_eio_trace_ea_overrun,			"ea_overrun") \
+	EM(smb_eio_trace_extract_will_pin,		"extract_will_pin") \
+	EM(smb_eio_trace_forced_shutdown,		"forced_shutdown") \
+	EM(smb_eio_trace_getacl_bcc_too_small,		"getacl_bcc_too_small") \
+	EM(smb_eio_trace_getcifsacl_param_count,	"getcifsacl_param_count") \
+	EM(smb_eio_trace_getdfsrefer_bcc_too_small,	"getdfsrefer_bcc_too_small")=
 \
+	EM(smb_eio_trace_getextattr_bcc_too_small,	"getextattr_bcc_too_small") \
+	EM(smb_eio_trace_getextattr_inv_size,		"getextattr_inv_size") \
+	EM(smb_eio_trace_getsrvinonum_bcc_too_small,	"getsrvinonum_bcc_too_small=
") \
+	EM(smb_eio_trace_getsrvinonum_size,		"getsrvinonum_size") \
+	EM(smb_eio_trace_ioctl_data_len,		"ioctl_data_len") \
+	EM(smb_eio_trace_ioctl_no_rsp,			"ioctl_no_rsp") \
+	EM(smb_eio_trace_ioctl_out_off,			"ioctl_out_off") \
+	EM(smb_eio_trace_lock_bcc_too_small,		"lock_bcc_too_small") \
+	EM(smb_eio_trace_lock_data_too_small,		"lock_data_too_small") \
+	EM(smb_eio_trace_malformed_ksid_key,		"malformed_ksid_key") \
+	EM(smb_eio_trace_malformed_sid_key,		"malformed_sid_key") \
+	EM(smb_eio_trace_mkdir_no_rsp,			"mkdir_no_rsp") \
+	EM(smb_eio_trace_neg_bad_rsplen,		"neg_bad_rsplen") \
+	EM(smb_eio_trace_neg_decode_token,		"neg_decode_token") \
+	EM(smb_eio_trace_neg_info_caps,			"neg_info_caps") \
+	EM(smb_eio_trace_neg_info_dialect,		"neg_info_dialect") \
+	EM(smb_eio_trace_neg_info_fail,			"neg_info_fail") \
+	EM(smb_eio_trace_neg_info_sec_mode,		"neg_info_sec_mode") \
+	EM(smb_eio_trace_neg_inval_dialect,		"neg_inval_dialect") \
+	EM(smb_eio_trace_neg_no_crypt_key,		"neg_no_crypt_key") \
+	EM(smb_eio_trace_neg_sec_blob_too_small,	"neg_sec_blob_too_small") \
+	EM(smb_eio_trace_neg_unreq_dialect,		"neg_unreq_dialect") \
+	EM(smb_eio_trace_no_auth_key,			"no_auth_key") \
+	EM(smb_eio_trace_no_lease_key,			"no_lease_key") \
+	EM(smb_eio_trace_not_netfs_writeback,		"not_netfs_writeback") \
+	EM(smb_eio_trace_null_pointers,			"null_pointers") \
+	EM(smb_eio_trace_oldqfsinfo_bcc_too_small,	"oldqfsinfo_bcc_too_small") \
+	EM(smb_eio_trace_pend_del_fail,			"pend_del_fail") \
+	EM(smb_eio_trace_qalleas_bcc_too_small,		"qalleas_bcc_too_small") \
+	EM(smb_eio_trace_qalleas_ea_overlong,		"qalleas_ea_overlong") \
+	EM(smb_eio_trace_qalleas_overlong,		"qalleas_overlong") \
+	EM(smb_eio_trace_qfileinfo_bcc_too_small,	"qfileinfo_bcc_too_small") \
+	EM(smb_eio_trace_qfileinfo_invalid,		"qfileinfo_invalid") \
+	EM(smb_eio_trace_qfsattrinfo_bcc_too_small,	"qfsattrinfo_bcc_too_small")=
 \
+	EM(smb_eio_trace_qfsdevinfo_bcc_too_small,	"qfsdevinfo_bcc_too_small") \
+	EM(smb_eio_trace_qfsinfo_bcc_too_small,		"qfsinfo_bcc_too_small") \
+	EM(smb_eio_trace_qfsposixinfo_bcc_too_small,	"qfsposixinfo_bcc_too_small=
") \
+	EM(smb_eio_trace_qfsunixinfo_bcc_too_small,	"qfsunixinfo_bcc_too_small")=
 \
+	EM(smb_eio_trace_qpathinfo_bcc_too_small,	"qpathinfo_bcc_too_small") \
+	EM(smb_eio_trace_qpathinfo_invalid,		"qpathinfo_invalid") \
+	EM(smb_eio_trace_qreparse_data_area,		"qreparse_data_area") \
+	EM(smb_eio_trace_qreparse_rep_datalen,		"qreparse_rep_datalen") \
+	EM(smb_eio_trace_qreparse_ret_datalen,		"qreparse_ret_datalen") \
+	EM(smb_eio_trace_qreparse_setup_count,		"qreparse_setup_count") \
+	EM(smb_eio_trace_qreparse_sizes_wrong,		"qreparse_sizes_wrong") \
+	EM(smb_eio_trace_qsym_bcc_too_small,		"qsym_bcc_too_small") \
+	EM(smb_eio_trace_rdma_dma_map,			"rdma_dma_map") \
+	EM(smb_eio_trace_rdma_fq_overrun,		"rdma_fq_overrun") \
+	EM(smb_eio_trace_rdma_iter_type,		"rdma_iter_type") \
+	EM(smb_eio_trace_rdma_set_sge,			"rdma_set_sge") \
+	EM(smb_eio_trace_read_mid_state_unknown,	"read_mid_state_unknown") \
+	EM(smb_eio_trace_read_overlarge,		"read_overlarge") \
+	EM(smb_eio_trace_read_rsp_malformed,		"read_rsp_malformed") \
+	EM(smb_eio_trace_read_rsp_short,		"read_rsp_short") \
+	EM(smb_eio_trace_read_too_far,			"read_too_far") \
+	EM(smb_eio_trace_reparse_data_len,		"reparse_data_len") \
+	EM(smb_eio_trace_reparse_native_len,		"reparse_native_len") \
+	EM(smb_eio_trace_reparse_native_nul,		"reparse_native_nul") \
+	EM(smb_eio_trace_reparse_native_sym_len,	"reparse_native_sym_len") \
+	EM(smb_eio_trace_reparse_nfs_dev,		"reparse_nfs_dev") \
+	EM(smb_eio_trace_reparse_nfs_nul,		"reparse_nfs_nul") \
+	EM(smb_eio_trace_reparse_nfs_sockfifo,		"reparse_nfs_sockfifo") \
+	EM(smb_eio_trace_reparse_nfs_symbuf,		"reparse_nfs_symbuf") \
+	EM(smb_eio_trace_reparse_nfs_too_short,		"reparse_nfs_too_short") \
+	EM(smb_eio_trace_reparse_overlong,		"reparse_overlong") \
+	EM(smb_eio_trace_reparse_rdlen,			"reparse_rdlen") \
+	EM(smb_eio_trace_reparse_wsl_nul,		"reparse_wsl_nul") \
+	EM(smb_eio_trace_reparse_wsl_symbuf,		"reparse_wsl_symbuf") \
+	EM(smb_eio_trace_reparse_wsl_ver,		"reparse_wsl_ver") \
+	EM(smb_eio_trace_rx_b_read_short,		"rx_b_read_short") \
+	EM(smb_eio_trace_rx_bad_datalen,		"rx_bad_datalen") \
+	EM(smb_eio_trace_rx_both_buf,			"rx_both_buf") \
+	EM(smb_eio_trace_rx_calc_len_too_big,		"rx_calc_len_too_big") \
+	EM(smb_eio_trace_rx_check_rsp,			"rx_check_rsp") \
+	EM(smb_eio_trace_rx_copy_to_iter,		"rx_copy_to_iter") \
+	EM(smb_eio_trace_rx_insuff_res,			"rx_insuff_res") \
+	EM(smb_eio_trace_rx_inv_bcc,			"rx_inv_bcc") \
+	EM(smb_eio_trace_rx_mid_unready,		"rx_mid_unready") \
+	EM(smb_eio_trace_rx_neg_sess_resp,		"rx_neg_sess_resp") \
+	EM(smb_eio_trace_rx_overlong,			"rx_overlong") \
+	EM(smb_eio_trace_rx_overpage,			"rx_overpage") \
+	EM(smb_eio_trace_rx_pos_sess_resp,		"rx_pos_sess_resp") \
+	EM(smb_eio_trace_rx_rfc1002_magic,		"rx_rfc1002_magic") \
+	EM(smb_eio_trace_rx_sync_mid_invalid,		"rx_sync_mid_invalid") \
+	EM(smb_eio_trace_rx_sync_mid_malformed,		"rx_sync_mid_malformed") \
+	EM(smb_eio_trace_rx_too_short,			"rx_too_short") \
+	EM(smb_eio_trace_rx_trans2_extract,		"rx_trans2_extract") \
+	EM(smb_eio_trace_rx_unknown_resp,		"rx_unknown_resp") \
+	EM(smb_eio_trace_rx_unspec_error,		"rx_unspec_error") \
+	EM(smb_eio_trace_sess_buf_off,			"sess_buf_off") \
+	EM(smb_eio_trace_sess_exiting,			"sess_exiting") \
+	EM(smb_eio_trace_sess_krb_wcc,			"sess_krb_wcc") \
+	EM(smb_eio_trace_sess_nl2_wcc,			"sess_nl2_wcc") \
+	EM(smb_eio_trace_sess_rawnl_auth_wcc,		"sess_rawnl_auth_wcc") \
+	EM(smb_eio_trace_sess_rawnl_neg_wcc,		"sess_rawnl_neg_wcc") \
+	EM(smb_eio_trace_short_symlink_write,		"short_symlink_write") \
+	EM(smb_eio_trace_sid_too_many_auth,		"sid_too_many_auth") \
+	EM(smb_eio_trace_sig_data_too_small,		"sig_data_too_small") \
+	EM(smb_eio_trace_sig_iter,			"sig_iter") \
+	EM(smb_eio_trace_smb1_received_error,		"smb1_received_error") \
+	EM(smb_eio_trace_smb2_received_error,		"smb2_received_error") \
+	EM(smb_eio_trace_sym_slash,			"sym_slash") \
+	EM(smb_eio_trace_sym_target_len,		"sym_target_len") \
+	EM(smb_eio_trace_symlink_file_size,		"symlink_file_size") \
+	EM(smb_eio_trace_tdis_in_reconnect,		"tdis_in_reconnect") \
+	EM(smb_eio_trace_tx_chained_async,		"tx_chained_async") \
+	EM(smb_eio_trace_tx_compress_failed,		"tx_compress_failed") \
+	EM(smb_eio_trace_tx_copy_iter_to_buf,		"tx_copy_iter_to_buf") \
+	EM(smb_eio_trace_tx_copy_to_buf,		"tx_copy_to_buf") \
+	EM(smb_eio_trace_tx_max_compound,		"tx_max_compound") \
+	EM(smb_eio_trace_tx_miscopy_to_buf,		"tx_miscopy_to_buf") \
+	EM(smb_eio_trace_tx_need_transform,		"tx_need_transform") \
+	EM(smb_eio_trace_tx_too_long,			"sr_too_long") \
+	EM(smb_eio_trace_unixqfileinfo_bcc_too_small,	"unixqfileinfo_bcc_too_sma=
ll") \
+	EM(smb_eio_trace_unixqpathinfo_bcc_too_small,	"unixqpathinfo_bcc_too_sma=
ll") \
+	EM(smb_eio_trace_user_iter,			"user_iter") \
+	EM(smb_eio_trace_write_bad_buf_type,		"write_bad_buf_type") \
+	EM(smb_eio_trace_write_mid_state_unknown,	"write_mid_state_unknown") \
+	EM(smb_eio_trace_write_rsp_malformed,		"write_rsp_malformed") \
+	E_(smb_eio_trace_write_too_far,			"write_too_far")
+
 #define smb3_rw_credits_traces \
 	EM(cifs_trace_rw_credits_call_readv_adjust,	"rd-call-adj") \
 	EM(cifs_trace_rw_credits_call_writev_adjust,	"wr-call-adj") \
@@ -79,6 +213,7 @@
 #define EM(a, b) a,
 #define E_(a, b) a
 =

+enum smb_eio_trace		{ smb_eio_traces } __mode(byte);
 enum smb3_rw_credits_trace	{ smb3_rw_credits_traces } __mode(byte);
 enum smb3_tcon_ref_trace	{ smb3_tcon_ref_traces } __mode(byte);
 =

@@ -92,6 +227,7 @@ enum smb3_tcon_ref_trace	{ smb3_tcon_ref_traces } __mod=
e(byte);
 #define EM(a, b) TRACE_DEFINE_ENUM(a);
 #define E_(a, b) TRACE_DEFINE_ENUM(a);
 =

+smb_eio_traces;
 smb3_rw_credits_traces;
 smb3_tcon_ref_traces;
 =

@@ -1616,6 +1752,23 @@ TRACE_EVENT(smb3_rw_credits,
 		      __entry->server_credits, __entry->in_flight)
 	    );
 =

+TRACE_EVENT(smb3_eio,
+	    TP_PROTO(enum smb_eio_trace trace, unsigned long info, unsigned long=
 info2),
+	    TP_ARGS(trace, info, info2),
+	    TP_STRUCT__entry(
+		    __field(enum smb_eio_trace,	trace)
+		    __field(unsigned long,	info)
+		    __field(unsigned long,	info2)
+			     ),
+	    TP_fast_assign(
+		    __entry->trace	=3D trace;
+		    __entry->info	=3D info;
+		    __entry->info2	=3D info2;
+			   ),
+	    TP_printk("%s info=3D%lx,%lx",
+		      __print_symbolic(__entry->trace, smb_eio_traces),
+		      __entry->info, __entry->info2)
+	    );
 =

 #undef EM
 #undef E_
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 362c5c6c91a4..47bfa5bef4e5 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -402,11 +402,11 @@ smb_send_rqst(struct TCP_Server_Info *server, int nu=
m_rqst,
 		return __smb_send_rqst(server, num_rqst, rqst);
 =

 	if (WARN_ON_ONCE(num_rqst > MAX_COMPOUND - 1))
-		return -EIO;
+		return smb_EIO1(smb_eio_trace_tx_max_compound, num_rqst);
 =

 	if (!server->ops->init_transform_rq) {
 		cifs_server_dbg(VFS, "Encryption requested but transform callback is mi=
ssing\n");
-		return -EIO;
+		return smb_EIO(smb_eio_trace_tx_need_transform);
 	}
 =

 	new_rqst[0].rq_iov =3D &iov;
@@ -753,7 +753,7 @@ int cifs_sync_mid_result(struct smb_message *smb, stru=
ct TCP_Server_Info *server
 		rc =3D -EAGAIN;
 		break;
 	case MID_RESPONSE_MALFORMED:
-		rc =3D -EIO;
+		rc =3D smb_EIO(smb_eio_trace_rx_sync_mid_malformed);
 		break;
 	case MID_SHUTDOWN:
 		rc =3D -EHOSTDOWN;
@@ -769,7 +769,7 @@ int cifs_sync_mid_result(struct smb_message *smb, stru=
ct TCP_Server_Info *server
 		spin_unlock(&server->mid_queue_lock);
 		cifs_server_dbg(VFS, "%s: invalid mid state mid=3D%llu state=3D%d\n",
 			 __func__, smb->mid, smb->mid_state);
-		rc =3D -EIO;
+		rc =3D smb_EIO1(smb_eio_trace_rx_sync_mid_invalid, smb->mid_state);
 		goto sync_mid_done;
 	}
 	spin_unlock(&server->mid_queue_lock);
@@ -883,7 +883,7 @@ compound_send_recv(const unsigned int xid, struct cifs=
_ses *ses,
 =

 	if (!ses || !ses->server || !server) {
 		cifs_dbg(VFS, "Null session\n");
-		return -EIO;
+		return smb_EIO(smb_eio_trace_null_pointers);
 	}
 =

 	spin_lock(&server->srv_lock);
@@ -1040,7 +1040,7 @@ compound_send_recv(const unsigned int xid, struct ci=
fs_ses *ses,
 =

 		if (!smb[i]->resp_buf ||
 		    smb[i]->mid_state !=3D MID_RESPONSE_READY) {
-			rc =3D -EIO;
+			rc =3D smb_EIO1(smb_eio_trace_rx_mid_unready, smb[i]->mid_state);
 			cifs_dbg(FYI, "Bad MID state?\n");
 			goto out;
 		}
@@ -1212,7 +1212,8 @@ cifs_readv_receive(struct TCP_Server_Info *server, s=
truct smb_message *smb)
 		cifs_dbg(FYI, "%s: server returned short header. got=3D%u expected=3D%z=
u\n",
 			 __func__, server->total_read,
 			 server->vals->read_rsp_size);
-		rdata->result =3D -EIO;
+		rdata->result =3D smb_EIO2(smb_eio_trace_read_rsp_short,
+					 server->total_read, server->vals->read_rsp_size);
 		return cifs_readv_discard(server, smb);
 	}
 =

@@ -1230,7 +1231,8 @@ cifs_readv_receive(struct TCP_Server_Info *server, s=
truct smb_message *smb)
 		/* data_offset is beyond the end of smallbuf */
 		cifs_dbg(FYI, "%s: data offset (%u) beyond end of smallbuf\n",
 			 __func__, data_offset);
-		rdata->result =3D -EIO;
+		rdata->result =3D smb_EIO1(smb_eio_trace_read_overlarge,
+					 data_offset);
 		return cifs_readv_discard(server, smb);
 	}
 =

@@ -1254,7 +1256,8 @@ cifs_readv_receive(struct TCP_Server_Info *server, s=
truct smb_message *smb)
 	data_len =3D server->ops->read_data_length(buf, use_rdma_mr);
 	if (!use_rdma_mr && (data_offset + data_len > buflen)) {
 		/* data_len is corrupt -- discard frame */
-		rdata->result =3D -EIO;
+		rdata->result =3D smb_EIO2(smb_eio_trace_read_rsp_malformed,
+					 data_offset + data_len, buflen);
 		return cifs_readv_discard(server, smb);
 	}
 =

diff --git a/fs/smb/client/xattr.c b/fs/smb/client/xattr.c
index 029910d56c22..6bc89c59164a 100644
--- a/fs/smb/client/xattr.c
+++ b/fs/smb/client/xattr.c
@@ -397,7 +397,7 @@ ssize_t cifs_listxattr(struct dentry *direntry, char *=
data, size_t buf_size)
 	void *page;
 =

 	if (unlikely(cifs_forced_shutdown(cifs_sb)))
-		return -EIO;
+		return smb_EIO(smb_eio_trace_forced_shutdown);
 =

 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_XATTR)
 		return -EOPNOTSUPP;


