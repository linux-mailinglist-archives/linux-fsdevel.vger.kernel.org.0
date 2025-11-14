Return-Path: <linux-fsdevel+bounces-68535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BD7C5E963
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 18:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9CC214F0ABE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 17:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04DF2D2489;
	Fri, 14 Nov 2025 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iEfDma9e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF572C3260
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763140550; cv=none; b=emEtoPbO/wd+uWhH9lbmlupzUZYK5aMxVtwkH395N37TquXRVUZVWoxn7+m5hvYl0AL0Bun69gS+nurVpj1rzCEUFHPeqvbEnA93UZMaLaxa3P8ymTHT0w8szVierSLEtKQNLYXM7z6Nq1vs0itlceX8KBgMlrzQ+B+0GgIpHFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763140550; c=relaxed/simple;
	bh=p7zWsA6p10dSfXC3EAgj5MJMAg5hjna2T5d6QZIKVpw=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=AGu1D4oHMJg6h+4rWCu+oBNmmsk6hdn5OYIBXmES48G9w8jDIeujCvalBTjQ4v4LjwMlWyH9tQuTE6MZKz3Q8e7NLxFy8cus7SDolRokXpevFI8rRxFz/xAdDRxg7yztpCe0Xs7sUjklQ0IGfYU0ldrQeNkhm/MERppNNDUU+yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iEfDma9e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763140545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/eE9/n3POJ4QJUAuHCEiGBaBYoDQnqqxFuCeHbIcfCE=;
	b=iEfDma9eaV4THCM1sb2SXn3FsC5jxGGxLP8myA9iJOUBTM3arwGka7dZIAAB+jg5O3ShXU
	KGSLnbQ569Yjvbfsk8m6RgR0JcQuJ2OkM5ylbJ5zTmgxRTtp4MG8ANicdMBPmYgvQB5ANo
	4pR9TY3Uf+7HNF8V/7C4sTaJfnoZCcc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-TjZuEYb-PLq-Yep1kH7FJg-1; Fri,
 14 Nov 2025 12:15:40 -0500
X-MC-Unique: TjZuEYb-PLq-Yep1kH7FJg-1
X-Mimecast-MFC-AGG-ID: TjZuEYb-PLq-Yep1kH7FJg_1763140539
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 296DF19560A3;
	Fri, 14 Nov 2025 17:15:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.87])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 718851955F1B;
	Fri, 14 Nov 2025 17:15:36 +0000 (UTC)
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
Content-ID: <1869901.1763140535.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Nov 2025 17:15:35 +0000
Message-ID: <1869902.1763140535@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Steve,

Would you be interested in a patch that adds a tracepoint to log EIO error=
s?
I have here a chunk of said patch that I've been using to debug stuff, but
it's not complete as yet.

David
---
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
index 6d80df815da4..b6ce4e31a0d8 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -2231,94 +2231,6 @@ static inline void move_cifs_info_to_smb2(struct sm=
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
index cf70dddb486a..1f83c6585eae 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -373,7 +373,8 @@ decode_ext_sec_blob(struct cifs_ses *ses, NEGOTIATE_RS=
P *pSMBr)
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
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index abb8bafc95c8..eed35bff4cd9 100644
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
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 744262c3390e..b53a98e0740e 100644
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
diff --git a/fs/smb/client/trace.h b/fs/smb/client/trace.h
index 28e00c34df1c..ae8a90d64577 100644
--- a/fs/smb/client/trace.h
+++ b/fs/smb/client/trace.h
@@ -20,6 +20,86 @@
 /*
  * Specify enums for tracing information.
  */
+#define smb_eio_traces \
+	EM(smb_eio_trace_create_rsp_too_small,		"create_rsp_too_small") \
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
+	EM(smb_eio_trace_lock_bcc_too_small,		"lock_bcc_too_small") \
+	EM(smb_eio_trace_lock_data_too_small,		"lock_data_too_small") \
+	EM(smb_eio_trace_malformed_ksid_key,		"malformed_ksid_key") \
+	EM(smb_eio_trace_malformed_sid_key,		"malformed_sid_key") \
+	EM(smb_eio_trace_neg_no_crypt_key,		"neg_no_crypt_key") \
+	EM(smb_eio_trace_neg_sec_blob_too_small,	"neg_sec_blob_too_small") \
+	EM(smb_eio_trace_no_lease_key,			"no_lease_key") \
+	EM(smb_eio_trace_not_netfs_writeback,		"not_netfs_writeback") \
+	EM(smb_eio_trace_null_pointers,			"null_pointers") \
+	EM(smb_eio_trace_oldqfsinfo_bcc_too_small,	"oldqfsinfo_bcc_too_small") \
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
+	EM(smb_eio_trace_read_mid_state_unknown,	"read_mid_state_unknown") \
+	EM(smb_eio_trace_read_overlarge,		"read_overlarge") \
+	EM(smb_eio_trace_read_rsp_malformed,		"read_rsp_malformed") \
+	EM(smb_eio_trace_read_too_far,			"read_too_far") \
+	EM(smb_eio_trace_rx_b_read_short,		"rx_b_read_short") \
+	EM(smb_eio_trace_rx_calc_len_too_big,		"rx_calc_len_too_big") \
+	EM(smb_eio_trace_rx_check_rsp,			"rx_check_rsp") \
+	EM(smb_eio_trace_rx_insuff_res,			"rx_insuff_res") \
+	EM(smb_eio_trace_rx_inv_bcc,			"rx_inv_bcc") \
+	EM(smb_eio_trace_rx_mid_unready,		"rx_mid_unready") \
+	EM(smb_eio_trace_rx_neg_sess_resp,		"rx_neg_sess_resp") \
+	EM(smb_eio_trace_rx_overlong,			"rx_overlong") \
+	EM(smb_eio_trace_rx_pos_sess_resp,		"rx_pos_sess_resp") \
+	EM(smb_eio_trace_rx_rfc1002_magic,		"rx_rfc1002_magic") \
+	EM(smb_eio_trace_rx_sync_mid_invalid,		"rx_sync_mid_invalid") \
+	EM(smb_eio_trace_rx_sync_mid_malformed,		"rx_sync_mid_malformed") \
+	EM(smb_eio_trace_rx_too_short,			"rx_too_short") \
+	EM(smb_eio_trace_rx_trans2_extract,		"rx_trans2_extract") \
+	EM(smb_eio_trace_rx_unknown_resp,		"rx_unknown_resp") \
+	EM(smb_eio_trace_rx_unspec_error,		"rx_unspec_error") \
+	EM(smb_eio_trace_sid_too_many_auth,		"sid_too_many_auth") \
+	EM(smb_eio_trace_sig_data_too_small,		"sig_data_too_small") \
+	EM(smb_eio_trace_sig_iter,			"sig_iter") \
+	EM(smb_eio_trace_smb1_received_error,		"smb1_received_error") \
+	EM(smb_eio_trace_smb2_received_error,		"smb2_received_error") \
+	EM(smb_eio_trace_tdis_in_reconnect,		"tdis_in_reconnect") \
+	EM(smb_eio_trace_tx_chained_async,		"tx_chained_async") \
+	EM(smb_eio_trace_tx_compress_failed,		"tx_compress_failed") \
+	EM(smb_eio_trace_tx_copy_iter_to_buf,		"tx_copy_iter_to_buf") \
+	EM(smb_eio_trace_tx_copy_to_buf,		"tx_copy_to_buf") \
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
@@ -79,6 +159,7 @@
 #define EM(a, b) a,
 #define E_(a, b) a
 =

+enum smb_eio_trace		{ smb_eio_traces } __mode(byte);
 enum smb3_rw_credits_trace	{ smb3_rw_credits_traces } __mode(byte);
 enum smb3_tcon_ref_trace	{ smb3_tcon_ref_traces } __mode(byte);
 =

@@ -92,6 +173,7 @@ enum smb3_tcon_ref_trace	{ smb3_tcon_ref_traces } __mod=
e(byte);
 #define EM(a, b) TRACE_DEFINE_ENUM(a);
 #define E_(a, b) TRACE_DEFINE_ENUM(a);
 =

+smb_eio_traces;
 smb3_rw_credits_traces;
 smb3_tcon_ref_traces;
 =

@@ -1616,6 +1698,23 @@ TRACE_EVENT(smb3_rw_credits,
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
index 362c5c6c91a4..e0cef95fee97 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -406,7 +406,7 @@ smb_send_rqst(struct TCP_Server_Info *server, int num_=
rqst,
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


