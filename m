Return-Path: <linux-fsdevel+bounces-70587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B74CA169C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 20:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C78A3037CFE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 19:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B1E307AD9;
	Wed,  3 Dec 2025 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6GN/F4r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8623064A0
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764790165; cv=none; b=gSbHGe+ROmj9nphuONc2xipzGUPkkrGAIqZf0xCIt463Zg5SDHmalOhd7pbDEkffkkMiJWgUa97WTSMiYu6+PK3ii23zGMtlvQB48t5Cy/KDt0CkAe/PtJCrpPY9yhBSWW9hz8oR7OFiKGlxEeRT0tjiLOqCONrovVA48wHAlkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764790165; c=relaxed/simple;
	bh=nMkmjGXRVyyxnY8Zfdzvj3s+CvbzFa4myvYAW4xIuYY=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=e94XnuiENniH0IBysaAZtkDlaE3ceyiVQno3KA7Eho8GGlo9uabHw8F/+mxgsVFsaGzC8nsrUDTRBk9WnCKHCKUiIhppujoBqsBFFJ7ZQrVcvPUgqQidYO0xINWwc/6dgmLA5u7cjm1XiFCMpD9nG+b9gtFTeMglh6qB1NxDuV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P6GN/F4r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764790162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MCGJPkB/jAsO8BmWJbd7QmxOjLhr4HMBn8S9GeWmxNA=;
	b=P6GN/F4rL+ysTq3o6Ei5v6aN+neOutn2ZbksPw0tWrhzwz4ddf1Avde6/mujXdDYu3vU2x
	5GmmaAlH4R1UiWeutK4XgLcL3oLecSy1l2I6/DOKanWtO+iXFKq71mrOLG9uaTgFUmK+js
	08ioS912ezWWEtUiXOJqsQbbGeYxRh8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-a8SRREW7NTmLQUuxKSVH3g-1; Wed,
 03 Dec 2025 14:29:19 -0500
X-MC-Unique: a8SRREW7NTmLQUuxKSVH3g-1
X-Mimecast-MFC-AGG-ID: a8SRREW7NTmLQUuxKSVH3g_1764790158
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 670D3180060D;
	Wed,  3 Dec 2025 19:29:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CD2B019560AD;
	Wed,  3 Dec 2025 19:29:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Remove dead function prototypes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1951983.1764790155.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Dec 2025 19:29:15 +0000
Message-ID: <1951984.1764790155@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

    =

Remove a bunch of dead function prototypes.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifsproto.h |    6 ------
 fs/smb/client/smb2proto.h |   12 ------------
 2 files changed, 18 deletions(-)

diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index e2cf6d1dd63b..ac745a7e2d18 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -80,7 +80,6 @@ extern char *cifs_build_path_to_root(struct smb3_fs_cont=
ext *ctx,
 				     struct cifs_sb_info *cifs_sb,
 				     struct cifs_tcon *tcon,
 				     int add_treename);
-extern char *build_wildcard_path_from_dentry(struct dentry *direntry);
 char *cifs_build_devname(char *nodename, const char *prepath);
 void delete_mid(struct TCP_Server_Info *server, struct mid_q_entry *mid);
 void __release_mid(struct TCP_Server_Info *server, struct mid_q_entry *mi=
d);
@@ -159,8 +158,6 @@ extern bool is_valid_oplock_break(char *, struct TCP_S=
erver_Info *);
 extern bool backup_cred(struct cifs_sb_info *);
 extern bool is_size_safe_to_change(struct cifsInodeInfo *cifsInode, __u64=
 eof,
 				   bool from_readdir);
-extern void cifs_update_eof(struct cifsInodeInfo *cifsi, loff_t offset,
-			    unsigned int bytes_written);
 void cifs_write_subrequest_terminated(struct cifs_io_subrequest *wdata, s=
size_t result);
 extern struct cifsFileInfo *find_writable_file(struct cifsInodeInfo *, in=
t);
 extern int cifs_get_writable_file(struct cifsInodeInfo *cifs_inode,
@@ -188,8 +185,6 @@ unsigned int header_assemble(struct smb_hdr *buffer, c=
har smb_command,
 extern int small_smb_init_no_tc(const int smb_cmd, const int wct,
 				struct cifs_ses *ses,
 				void **request_buf);
-extern enum securityEnum select_sectype(struct TCP_Server_Info *server,
-				enum securityEnum requested);
 extern int CIFS_SessSetup(const unsigned int xid, struct cifs_ses *ses,
 			  struct TCP_Server_Info *server,
 			  const struct nls_table *nls_cp);
@@ -638,7 +633,6 @@ int cifs_try_adding_channels(struct cifs_ses *ses);
 int smb3_update_ses_channels(struct cifs_ses *ses, struct TCP_Server_Info=
 *server,
 					bool from_reconnect, bool from_reconfigure);
 bool is_ses_using_iface(struct cifs_ses *ses, struct cifs_server_iface *i=
face);
-void cifs_ses_mark_for_reconnect(struct cifs_ses *ses);
 =

 int
 cifs_ses_get_chan_index(struct cifs_ses *ses,
diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
index 152e888512aa..063c9f83bbcd 100644
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -41,15 +41,11 @@ extern struct mid_q_entry *smb2_setup_async_request(
 			struct TCP_Server_Info *server, struct smb_rqst *rqst);
 extern struct cifs_tcon *smb2_find_smb_tcon(struct TCP_Server_Info *serve=
r,
 						__u64 ses_id, __u32  tid);
-extern void smb2_echo_request(struct work_struct *work);
 extern __le32 smb2_get_lease_state(struct cifsInodeInfo *cinode);
 extern bool smb2_is_valid_oplock_break(char *buffer,
 				       struct TCP_Server_Info *srv);
 extern int smb3_handle_read_data(struct TCP_Server_Info *server,
 				 struct mid_q_entry *mid);
-extern int smb2_query_reparse_tag(const unsigned int xid, struct cifs_tco=
n *tcon,
-				struct cifs_sb_info *cifs_sb, const char *path,
-				__u32 *reparse_tag);
 struct inode *smb2_create_reparse_inode(struct cifs_open_info_data *data,
 				     struct super_block *sb,
 				     const unsigned int xid,
@@ -302,17 +298,9 @@ extern int smb2_query_info_compound(const unsigned in=
t xid,
 				    struct kvec *rsp, int *buftype,
 				    struct cifs_sb_info *cifs_sb);
 /* query path info from the server using SMB311 POSIX extensions*/
-int smb311_posix_query_path_info(const unsigned int xid,
-				 struct cifs_tcon *tcon,
-				 struct cifs_sb_info *cifs_sb,
-				 const char *full_path,
-				 struct cifs_open_info_data *data);
 int posix_info_parse(const void *beg, const void *end,
 		     struct smb2_posix_info_parsed *out);
 int posix_info_sid_size(const void *beg, const void *end);
-int smb2_make_nfs_node(unsigned int xid, struct inode *inode,
-		       struct dentry *dentry, struct cifs_tcon *tcon,
-		       const char *full_path, umode_t mode, dev_t dev);
 int smb2_rename_pending_delete(const char *full_path,
 			       struct dentry *dentry,
 			       const unsigned int xid);


