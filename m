Return-Path: <linux-fsdevel+bounces-71850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF970CD74EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 23:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E3E7302D28D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 22:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CE0311967;
	Mon, 22 Dec 2025 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HuAMRPhc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FA33126BD
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442634; cv=none; b=LS8qsxY1cCQb0TCJNbWBwAl2BezF+YsEsPvjeue3Sxx6Wm44Ry8E9RyQ34zPTwJEfLEfGX5Xy3Y8BzmmIAAy6Sa1l2OVOIFne9ffKw/zWOZXsZMii7O1Nw7uBVcT4tdeK+9Llc8qm4/rmYaWMx6s7BDO81+ctRISK0ABoegchNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442634; c=relaxed/simple;
	bh=cjkGThD2KR1C18c/BDFLbZzKUh7OTN8uA+UpgLNAuyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RH6k/yoHSoZPk6b0wybVAPLmj8J3h+mEmG9ykXHY1SY3m+9iPrTZTjZdFcD3M83QCTy7SOKYowylAb/uIAgqy3Z3w7O1ZuN3pMgN2KSbwb9K4Mo1xVmo+LjNECbM1Di4AuMPZZ6XFbq8gVKgCCladLO2l8KBeo96zMwrUemhTXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HuAMRPhc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766442629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BbQ98WR2WVYi2gn2XigC2Jug93hwOUAeexJw4T7ovQU=;
	b=HuAMRPhcJfArJ2daDpF5HaDARG2ESF05vjiXEOfee8h0fRJ0aG+bMfVlj2SkbMR1BMzHRU
	7N5ybNydKeTE4xCWLeNzWlCjEvJobJW9L5hkFrB3aPJw96NM6SV5Ko24JLBnaSvnoKmwVF
	4AfA6VsVuvsgstFXN5MkcngUiv7LQ3I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-hmizKprPNgK9GYsS7nsb_A-1; Mon,
 22 Dec 2025 17:30:23 -0500
X-MC-Unique: hmizKprPNgK9GYsS7nsb_A-1
X-Mimecast-MFC-AGG-ID: hmizKprPNgK9GYsS7nsb_A_1766442622
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5EED195605F;
	Mon, 22 Dec 2025 22:30:21 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BB30619560B4;
	Mon, 22 Dec 2025 22:30:19 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/37] cifs: Scripted clean up fs/smb/client/cifsproto.h
Date: Mon, 22 Dec 2025 22:29:28 +0000
Message-ID: <20251222223006.1075635-4-dhowells@redhat.com>
In-Reply-To: <20251222223006.1075635-1-dhowells@redhat.com>
References: <20251222223006.1075635-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Remove externs, correct argument names and reformat declarations.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
---
 fs/smb/client/cifsproto.h | 965 ++++++++++++++++++--------------------
 1 file changed, 462 insertions(+), 503 deletions(-)

diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index f8c0615d4ee4..75a474f9e99a 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -25,16 +25,15 @@ struct smb3_fs_context;
  *****************************************************************
  */
 
-extern struct smb_hdr *cifs_buf_get(void);
-extern void cifs_buf_release(void *);
-extern struct smb_hdr *cifs_small_buf_get(void);
-extern void cifs_small_buf_release(void *);
-extern void free_rsp_buf(int, void *);
-extern int smb_send_kvec(struct TCP_Server_Info *server,
-			 struct msghdr *msg,
-			 size_t *sent);
-extern unsigned int _get_xid(void);
-extern void _free_xid(unsigned int);
+struct smb_hdr *cifs_buf_get(void);
+void cifs_buf_release(void *buf_to_free);
+struct smb_hdr *cifs_small_buf_get(void);
+void cifs_small_buf_release(void *buf_to_free);
+void free_rsp_buf(int resp_buftype, void *rsp);
+int smb_send_kvec(struct TCP_Server_Info *server, struct msghdr *smb_msg,
+		  size_t *sent);
+unsigned int _get_xid(void);
+void _free_xid(unsigned int xid);
 #define get_xid()							\
 ({									\
 	unsigned int __xid = _get_xid();				\
@@ -55,16 +54,16 @@ do {									\
 	else								\
 		trace_smb3_exit_done(curr_xid, __func__);		\
 } while (0)
-extern int init_cifs_idmap(void);
-extern void exit_cifs_idmap(void);
-extern int init_cifs_spnego(void);
-extern void exit_cifs_spnego(void);
-extern const char *build_path_from_dentry(struct dentry *, void *);
-char *__build_path_from_dentry_optional_prefix(struct dentry *direntry, void *page,
-					       const char *tree, int tree_len,
-					       bool prefix);
-extern char *build_path_from_dentry_optional_prefix(struct dentry *direntry,
-						    void *page, bool prefix);
+int init_cifs_idmap(void);
+void exit_cifs_idmap(void);
+int init_cifs_spnego(void);
+void exit_cifs_spnego(void);
+const char *build_path_from_dentry(struct dentry *direntry, void *page);
+char *__build_path_from_dentry_optional_prefix(struct dentry *direntry,
+					       void *page, const char *tree,
+					       int tree_len, bool prefix);
+char *build_path_from_dentry_optional_prefix(struct dentry *direntry,
+					     void *page, bool prefix);
 static inline void *alloc_dentry_path(void)
 {
 	return __getname();
@@ -76,57 +75,56 @@ static inline void free_dentry_path(void *page)
 		__putname(page);
 }
 
-extern char *cifs_build_path_to_root(struct smb3_fs_context *ctx,
-				     struct cifs_sb_info *cifs_sb,
-				     struct cifs_tcon *tcon,
-				     int add_treename);
+char *cifs_build_path_to_root(struct smb3_fs_context *ctx,
+			      struct cifs_sb_info *cifs_sb,
+			      struct cifs_tcon *tcon, int add_treename);
 char *cifs_build_devname(char *nodename, const char *prepath);
 void delete_mid(struct TCP_Server_Info *server, struct mid_q_entry *mid);
-void __release_mid(struct TCP_Server_Info *server, struct mid_q_entry *mid);
-void cifs_wake_up_task(struct TCP_Server_Info *server, struct mid_q_entry *mid);
-extern int cifs_handle_standard(struct TCP_Server_Info *server,
-				struct mid_q_entry *mid);
-extern char *smb3_fs_context_fullpath(const struct smb3_fs_context *ctx,
-				      char dirsep);
-extern int smb3_parse_devname(const char *devname, struct smb3_fs_context *ctx);
-extern int smb3_parse_opt(const char *options, const char *key, char **val);
-extern int cifs_ipaddr_cmp(struct sockaddr *srcaddr, struct sockaddr *rhs);
-extern bool cifs_match_ipaddr(struct sockaddr *srcaddr, struct sockaddr *rhs);
-extern int cifs_discard_remaining_data(struct TCP_Server_Info *server);
-extern int cifs_call_async(struct TCP_Server_Info *server,
-			   struct smb_rqst *rqst,
-			   mid_receive_t receive, mid_callback_t callback,
-			   mid_handle_t handle, void *cbdata, const int flags,
-			   const struct cifs_credits *exist_credits);
-extern struct TCP_Server_Info *cifs_pick_channel(struct cifs_ses *ses);
-extern int cifs_send_recv(const unsigned int xid, struct cifs_ses *ses,
-			  struct TCP_Server_Info *server,
-			  struct smb_rqst *rqst, int *resp_buf_type,
-			  const int flags, struct kvec *resp_iov);
-extern int compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
-			      struct TCP_Server_Info *server,
-			      const int flags, const int num_rqst,
-			      struct smb_rqst *rqst, int *resp_buf_type,
-			      struct kvec *resp_iov);
+void __release_mid(struct TCP_Server_Info *server,
+		   struct mid_q_entry *midEntry);
+void cifs_wake_up_task(struct TCP_Server_Info *server,
+		       struct mid_q_entry *mid);
+int cifs_handle_standard(struct TCP_Server_Info *server,
+			 struct mid_q_entry *mid);
+char *smb3_fs_context_fullpath(const struct smb3_fs_context *ctx, char dirsep);
+int smb3_parse_devname(const char *devname, struct smb3_fs_context *ctx);
+int smb3_parse_opt(const char *options, const char *key, char **val);
+int cifs_ipaddr_cmp(struct sockaddr *srcaddr, struct sockaddr *rhs);
+bool cifs_match_ipaddr(struct sockaddr *srcaddr, struct sockaddr *rhs);
+int cifs_discard_remaining_data(struct TCP_Server_Info *server);
+int cifs_call_async(struct TCP_Server_Info *server, struct smb_rqst *rqst,
+		    mid_receive_t receive, mid_callback_t callback,
+		    mid_handle_t handle, void *cbdata, const int flags,
+		    const struct cifs_credits *exist_credits);
+struct TCP_Server_Info *cifs_pick_channel(struct cifs_ses *ses);
+int cifs_send_recv(const unsigned int xid, struct cifs_ses *ses,
+		   struct TCP_Server_Info *server, struct smb_rqst *rqst,
+		   int *resp_buf_type, const int flags, struct kvec *resp_iov);
+int compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
+		       struct TCP_Server_Info *server, const int flags,
+		       const int num_rqst, struct smb_rqst *rqst,
+		       int *resp_buf_type, struct kvec *resp_iov);
 int SendReceive(const unsigned int xid, struct cifs_ses *ses,
 		struct smb_hdr *in_buf, unsigned int in_len,
-		struct smb_hdr *out_buf, int *pbytes_returned, const int flags);
+		struct smb_hdr *out_buf, int *pbytes_returned,
+		const int flags);
 int SendReceiveNoRsp(const unsigned int xid, struct cifs_ses *ses,
 		     char *in_buf, unsigned int in_len, int flags);
-int cifs_sync_mid_result(struct mid_q_entry *mid, struct TCP_Server_Info *server);
-struct mid_q_entry *cifs_setup_request(struct cifs_ses *ses, struct TCP_Server_Info *ignored,
+int cifs_sync_mid_result(struct mid_q_entry *mid,
+			 struct TCP_Server_Info *server);
+struct mid_q_entry *cifs_setup_request(struct cifs_ses *ses,
+				       struct TCP_Server_Info *server,
 				       struct smb_rqst *rqst);
 struct mid_q_entry *cifs_setup_async_request(struct TCP_Server_Info *server,
 					     struct smb_rqst *rqst);
 int __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 		    struct smb_rqst *rqst);
-extern int cifs_check_receive(struct mid_q_entry *mid,
-			struct TCP_Server_Info *server, bool log_error);
+int cifs_check_receive(struct mid_q_entry *mid, struct TCP_Server_Info *server,
+		       bool log_error);
 int wait_for_free_request(struct TCP_Server_Info *server, const int flags,
 			  unsigned int *instance);
-extern int cifs_wait_mtu_credits(struct TCP_Server_Info *server,
-				 size_t size, size_t *num,
-				 struct cifs_credits *credits);
+int cifs_wait_mtu_credits(struct TCP_Server_Info *server, size_t size,
+			  size_t *num, struct cifs_credits *credits);
 
 static inline int
 send_cancel(struct cifs_ses *ses, struct TCP_Server_Info *server,
@@ -137,291 +135,274 @@ send_cancel(struct cifs_ses *ses, struct TCP_Server_Info *server,
 		server->ops->send_cancel(ses, server, rqst, mid, xid) : 0;
 }
 
-int wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry *midQ);
-extern int SendReceive2(const unsigned int /* xid */ , struct cifs_ses *,
-			struct kvec *, int /* nvec to send */,
-			int * /* type of buf returned */, const int flags,
-			struct kvec * /* resp vec */);
+int wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry *mid);
+int SendReceive2(const unsigned int xid, struct cifs_ses *ses,
+		 struct kvec *iov, int n_vec, int *resp_buf_type /* ret */,
+		 const int flags, struct kvec *resp_iov);
 
 void smb2_query_server_interfaces(struct work_struct *work);
-void
-cifs_signal_cifsd_for_reconnect(struct TCP_Server_Info *server,
-				      bool all_channels);
-void
-cifs_mark_tcp_ses_conns_for_reconnect(struct TCP_Server_Info *server,
-				      bool mark_smb_session);
-extern int cifs_reconnect(struct TCP_Server_Info *server,
-			  bool mark_smb_session);
-int checkSMB(char *buf, unsigned int pdu_len, unsigned int len,
-	     struct TCP_Server_Info *srvr);
-extern bool is_valid_oplock_break(char *, struct TCP_Server_Info *);
-extern bool backup_cred(struct cifs_sb_info *);
-extern bool is_size_safe_to_change(struct cifsInodeInfo *cifsInode, __u64 eof,
-				   bool from_readdir);
-void cifs_write_subrequest_terminated(struct cifs_io_subrequest *wdata, ssize_t result);
-extern struct cifsFileInfo *find_writable_file(struct cifsInodeInfo *, int);
-extern int cifs_get_writable_file(struct cifsInodeInfo *cifs_inode,
-				  int flags,
-				  struct cifsFileInfo **ret_file);
-extern int cifs_get_writable_path(struct cifs_tcon *tcon, const char *name,
-				  int flags,
-				  struct cifsFileInfo **ret_file);
-extern struct cifsFileInfo *find_readable_file(struct cifsInodeInfo *, bool);
-extern int cifs_get_readable_path(struct cifs_tcon *tcon, const char *name,
-				  struct cifsFileInfo **ret_file);
-extern int cifs_get_hardlink_path(struct cifs_tcon *tcon, struct inode *inode,
-				  struct file *file);
-extern unsigned int smbCalcSize(void *buf);
-extern int decode_negTokenInit(unsigned char *security_blob, int length,
+void cifs_signal_cifsd_for_reconnect(struct TCP_Server_Info *server,
+				     bool all_channels);
+void cifs_mark_tcp_ses_conns_for_reconnect(struct TCP_Server_Info *server,
+					   bool mark_smb_session);
+int cifs_reconnect(struct TCP_Server_Info *server, bool mark_smb_session);
+int checkSMB(char *buf, unsigned int pdu_len, unsigned int total_read,
+	     struct TCP_Server_Info *server);
+bool is_valid_oplock_break(char *buffer, struct TCP_Server_Info *srv);
+bool backup_cred(struct cifs_sb_info *cifs_sb);
+bool is_size_safe_to_change(struct cifsInodeInfo *cifsInode, __u64 end_of_file,
+			    bool from_readdir);
+void cifs_write_subrequest_terminated(struct cifs_io_subrequest *wdata,
+				      ssize_t result);
+struct cifsFileInfo *find_writable_file(struct cifsInodeInfo *cifs_inode,
+					int flags);
+int cifs_get_writable_file(struct cifsInodeInfo *cifs_inode, int flags,
+			   struct cifsFileInfo **ret_file);
+int cifs_get_writable_path(struct cifs_tcon *tcon, const char *name, int flags,
+			   struct cifsFileInfo **ret_file);
+struct cifsFileInfo *find_readable_file(struct cifsInodeInfo *cifs_inode,
+					bool fsuid_only);
+int cifs_get_readable_path(struct cifs_tcon *tcon, const char *name,
+			   struct cifsFileInfo **ret_file);
+int cifs_get_hardlink_path(struct cifs_tcon *tcon, struct inode *inode,
+			   struct file *file);
+unsigned int smbCalcSize(void *buf);
+int decode_negTokenInit(unsigned char *security_blob, int length,
 			struct TCP_Server_Info *server);
-extern int cifs_convert_address(struct sockaddr *dst, const char *src, int len);
-extern void cifs_set_port(struct sockaddr *addr, const unsigned short int port);
-extern int map_smb_to_linux_error(char *buf, bool logErr);
-extern int map_and_check_smb_error(struct TCP_Server_Info *server,
-				   struct mid_q_entry *mid, bool logErr);
+int cifs_convert_address(struct sockaddr *dst, const char *src, int len);
+void cifs_set_port(struct sockaddr *addr, const unsigned short int port);
+int map_smb_to_linux_error(char *buf, bool logErr);
+int map_and_check_smb_error(struct TCP_Server_Info *server,
+			    struct mid_q_entry *mid, bool logErr);
 unsigned int header_assemble(struct smb_hdr *buffer, char smb_command,
 			     const struct cifs_tcon *treeCon, int word_count
-			     /* length of fixed section word count in two byte units  */);
-extern int small_smb_init_no_tc(const int smb_cmd, const int wct,
-				struct cifs_ses *ses,
-				void **request_buf);
-extern int CIFS_SessSetup(const unsigned int xid, struct cifs_ses *ses,
-			  struct TCP_Server_Info *server,
-			  const struct nls_table *nls_cp);
-extern struct timespec64 cifs_NTtimeToUnix(__le64 utc_nanoseconds_since_1601);
-extern u64 cifs_UnixTimeToNT(struct timespec64);
-extern struct timespec64 cnvrtDosUnixTm(__le16 le_date, __le16 le_time,
-				      int offset);
-extern void cifs_set_oplock_level(struct cifsInodeInfo *cinode, __u32 oplock);
-extern int cifs_get_writer(struct cifsInodeInfo *cinode);
-extern void cifs_put_writer(struct cifsInodeInfo *cinode);
-extern void cifs_done_oplock_break(struct cifsInodeInfo *cinode);
-extern int cifs_unlock_range(struct cifsFileInfo *cfile,
-			     struct file_lock *flock, const unsigned int xid);
-extern int cifs_push_mandatory_locks(struct cifsFileInfo *cfile);
-
-extern void cifs_down_write(struct rw_semaphore *sem);
+			     /* length of fixed section (word count) in two byte units  */);
+int small_smb_init_no_tc(const int smb_command, const int wct,
+			 struct cifs_ses *ses, void **request_buf);
+int CIFS_SessSetup(const unsigned int xid, struct cifs_ses *ses,
+		   struct TCP_Server_Info *server,
+		   const struct nls_table *nls_cp);
+struct timespec64 cifs_NTtimeToUnix(__le64 ntutc);
+u64 cifs_UnixTimeToNT(struct timespec64 t);
+struct timespec64 cnvrtDosUnixTm(__le16 le_date, __le16 le_time, int offset);
+void cifs_set_oplock_level(struct cifsInodeInfo *cinode, __u32 oplock);
+int cifs_get_writer(struct cifsInodeInfo *cinode);
+void cifs_put_writer(struct cifsInodeInfo *cinode);
+void cifs_done_oplock_break(struct cifsInodeInfo *cinode);
+int cifs_unlock_range(struct cifsFileInfo *cfile, struct file_lock *flock,
+		      unsigned int xid);
+int cifs_push_mandatory_locks(struct cifsFileInfo *cfile);
+
+void cifs_down_write(struct rw_semaphore *sem);
 struct cifsFileInfo *cifs_new_fileinfo(struct cifs_fid *fid, struct file *file,
 				       struct tcon_link *tlink, __u32 oplock,
 				       const char *symlink_target);
-extern int cifs_posix_open(const char *full_path, struct inode **inode,
-			   struct super_block *sb, int mode,
-			   unsigned int f_flags, __u32 *oplock, __u16 *netfid,
-			   unsigned int xid);
+int cifs_posix_open(const char *full_path, struct inode **pinode,
+		    struct super_block *sb, int mode, unsigned int f_flags,
+		    __u32 *poplock, __u16 *pnetfid, unsigned int xid);
 void cifs_fill_uniqueid(struct super_block *sb, struct cifs_fattr *fattr);
-extern void cifs_unix_basic_to_fattr(struct cifs_fattr *fattr,
-				     FILE_UNIX_BASIC_INFO *info,
-				     struct cifs_sb_info *cifs_sb);
-extern void cifs_dir_info_to_fattr(struct cifs_fattr *, FILE_DIRECTORY_INFO *,
-					struct cifs_sb_info *);
-extern int cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr,
-			       bool from_readdir);
-extern struct inode *cifs_iget(struct super_block *sb,
-			       struct cifs_fattr *fattr);
+void cifs_unix_basic_to_fattr(struct cifs_fattr *fattr,
+			      FILE_UNIX_BASIC_INFO *info,
+			      struct cifs_sb_info *cifs_sb);
+void cifs_dir_info_to_fattr(struct cifs_fattr *fattr,
+			    FILE_DIRECTORY_INFO *info,
+			    struct cifs_sb_info *cifs_sb);
+int cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr,
+			bool from_readdir);
+struct inode *cifs_iget(struct super_block *sb, struct cifs_fattr *fattr);
 
 int cifs_get_inode_info(struct inode **inode, const char *full_path,
-			struct cifs_open_info_data *data, struct super_block *sb, int xid,
+			struct cifs_open_info_data *data,
+			struct super_block *sb, int xid,
 			const struct cifs_fid *fid);
-extern int smb311_posix_get_inode_info(struct inode **inode,
-				       const char *full_path,
-				       struct cifs_open_info_data *data,
-				       struct super_block *sb,
-				       const unsigned int xid);
-extern int cifs_get_inode_info_unix(struct inode **pinode,
-			const unsigned char *search_path,
-			struct super_block *sb, unsigned int xid);
-extern int cifs_set_file_info(struct inode *inode, struct iattr *attrs,
-			      unsigned int xid, const char *full_path, __u32 dosattr);
-extern int cifs_rename_pending_delete(const char *full_path,
-				      struct dentry *dentry,
-				      const unsigned int xid);
-extern int sid_to_id(struct cifs_sb_info *cifs_sb, struct smb_sid *psid,
-				struct cifs_fattr *fattr, uint sidtype);
-extern int cifs_acl_to_fattr(struct cifs_sb_info *cifs_sb,
-			      struct cifs_fattr *fattr, struct inode *inode,
-			      bool get_mode_from_special_sid,
-			      const char *path, const struct cifs_fid *pfid);
-extern int id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
-					kuid_t uid, kgid_t gid);
-extern struct smb_ntsd *get_cifs_acl(struct cifs_sb_info *cifssmb, struct inode *ino,
-				      const char *path, u32 *plen, u32 info);
-extern struct smb_ntsd *get_cifs_acl_by_fid(struct cifs_sb_info *cifssb,
-				const struct cifs_fid *pfid, u32 *plen, u32 info);
-extern struct posix_acl *cifs_get_acl(struct mnt_idmap *idmap,
-				      struct dentry *dentry, int type);
-extern int cifs_set_acl(struct mnt_idmap *idmap,
-			struct dentry *dentry, struct posix_acl *acl, int type);
-extern int set_cifs_acl(struct smb_ntsd *pntsd, __u32 len, struct inode *ino,
-				const char *path, int flag);
-extern unsigned int setup_authusers_ACE(struct smb_ace *pace);
-extern unsigned int setup_special_mode_ACE(struct smb_ace *pace,
-					   bool posix,
-					   __u64 nmode);
-extern unsigned int setup_special_user_owner_ACE(struct smb_ace *pace);
-
-void dequeue_mid(struct TCP_Server_Info *server, struct mid_q_entry *mid, bool malformed);
-extern int cifs_read_from_socket(struct TCP_Server_Info *server, char *buf,
-			         unsigned int to_read);
-extern ssize_t cifs_discard_from_socket(struct TCP_Server_Info *server,
-					size_t to_read);
+int smb311_posix_get_inode_info(struct inode **inode, const char *full_path,
+				struct cifs_open_info_data *data,
+				struct super_block *sb,
+				const unsigned int xid);
+int cifs_get_inode_info_unix(struct inode **pinode,
+			     const unsigned char *full_path,
+			     struct super_block *sb, unsigned int xid);
+int cifs_set_file_info(struct inode *inode, struct iattr *attrs,
+		       unsigned int xid, const char *full_path, __u32 dosattr);
+int cifs_rename_pending_delete(const char *full_path, struct dentry *dentry,
+			       const unsigned int xid);
+int sid_to_id(struct cifs_sb_info *cifs_sb, struct smb_sid *psid,
+	      struct cifs_fattr *fattr, uint sidtype);
+int cifs_acl_to_fattr(struct cifs_sb_info *cifs_sb, struct cifs_fattr *fattr,
+		      struct inode *inode, bool mode_from_special_sid,
+		      const char *path, const struct cifs_fid *pfid);
+int id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
+			kuid_t uid, kgid_t gid);
+struct smb_ntsd *get_cifs_acl(struct cifs_sb_info *cifs_sb,
+			      struct inode *inode, const char *path,
+			      u32 *pacllen, u32 info);
+struct smb_ntsd *get_cifs_acl_by_fid(struct cifs_sb_info *cifs_sb,
+				     const struct cifs_fid *cifsfid,
+				     u32 *pacllen, u32 info);
+struct posix_acl *cifs_get_acl(struct mnt_idmap *idmap, struct dentry *dentry,
+			       int type);
+int cifs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
+		 struct posix_acl *acl, int type);
+int set_cifs_acl(struct smb_ntsd *pnntsd, __u32 acllen, struct inode *inode,
+		 const char *path, int aclflag);
+unsigned int setup_authusers_ACE(struct smb_ace *pntace);
+unsigned int setup_special_mode_ACE(struct smb_ace *pntace, bool posix,
+				    __u64 nmode);
+unsigned int setup_special_user_owner_ACE(struct smb_ace *pntace);
+
+void dequeue_mid(struct TCP_Server_Info *server, struct mid_q_entry *mid,
+		 bool malformed);
+int cifs_read_from_socket(struct TCP_Server_Info *server, char *buf,
+			  unsigned int to_read);
+ssize_t cifs_discard_from_socket(struct TCP_Server_Info *server,
+				 size_t to_read);
 int cifs_read_iter_from_socket(struct TCP_Server_Info *server,
-			       struct iov_iter *iter,
-			       unsigned int to_read);
-extern int cifs_setup_cifs_sb(struct cifs_sb_info *cifs_sb);
+			       struct iov_iter *iter, unsigned int to_read);
+int cifs_setup_cifs_sb(struct cifs_sb_info *cifs_sb);
 void cifs_mount_put_conns(struct cifs_mount_ctx *mnt_ctx);
 int cifs_mount_get_session(struct cifs_mount_ctx *mnt_ctx);
 int cifs_is_path_remote(struct cifs_mount_ctx *mnt_ctx);
 int cifs_mount_get_tcon(struct cifs_mount_ctx *mnt_ctx);
-extern int cifs_match_super(struct super_block *, void *);
-extern int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx);
-extern void cifs_umount(struct cifs_sb_info *);
-extern void cifs_mark_open_files_invalid(struct cifs_tcon *tcon);
-extern void cifs_reopen_persistent_handles(struct cifs_tcon *tcon);
-
-extern bool cifs_find_lock_conflict(struct cifsFileInfo *cfile, __u64 offset,
-				    __u64 length, __u8 type, __u16 flags,
-				    struct cifsLockInfo **conf_lock,
-				    int rw_check);
-extern void cifs_add_pending_open(struct cifs_fid *fid,
+int cifs_match_super(struct super_block *sb, void *data);
+int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx);
+void cifs_umount(struct cifs_sb_info *cifs_sb);
+void cifs_mark_open_files_invalid(struct cifs_tcon *tcon);
+void cifs_reopen_persistent_handles(struct cifs_tcon *tcon);
+
+bool cifs_find_lock_conflict(struct cifsFileInfo *cfile, __u64 offset,
+			     __u64 length, __u8 type, __u16 flags,
+			     struct cifsLockInfo **conf_lock, int rw_check);
+void cifs_add_pending_open(struct cifs_fid *fid, struct tcon_link *tlink,
+			   struct cifs_pending_open *open);
+void cifs_add_pending_open_locked(struct cifs_fid *fid,
 				  struct tcon_link *tlink,
 				  struct cifs_pending_open *open);
-extern void cifs_add_pending_open_locked(struct cifs_fid *fid,
-					 struct tcon_link *tlink,
-					 struct cifs_pending_open *open);
-extern void cifs_del_pending_open(struct cifs_pending_open *open);
+void cifs_del_pending_open(struct cifs_pending_open *open);
 
-extern bool cifs_is_deferred_close(struct cifsFileInfo *cfile,
-				struct cifs_deferred_close **dclose);
+bool cifs_is_deferred_close(struct cifsFileInfo *cfile,
+			    struct cifs_deferred_close **pdclose);
 
-extern void cifs_add_deferred_close(struct cifsFileInfo *cfile,
-				struct cifs_deferred_close *dclose);
+void cifs_add_deferred_close(struct cifsFileInfo *cfile,
+			     struct cifs_deferred_close *dclose);
 
-extern void cifs_del_deferred_close(struct cifsFileInfo *cfile);
+void cifs_del_deferred_close(struct cifsFileInfo *cfile);
 
-extern void cifs_close_deferred_file(struct cifsInodeInfo *cifs_inode);
+void cifs_close_deferred_file(struct cifsInodeInfo *cifs_inode);
 
-extern void cifs_close_all_deferred_files(struct cifs_tcon *cifs_tcon);
+void cifs_close_all_deferred_files(struct cifs_tcon *tcon);
 
-void cifs_close_deferred_file_under_dentry(struct cifs_tcon *cifs_tcon,
+void cifs_close_deferred_file_under_dentry(struct cifs_tcon *tcon,
 					   struct dentry *dentry);
 
-extern void cifs_mark_open_handles_for_deleted_file(struct inode *inode,
-				const char *path);
+void cifs_mark_open_handles_for_deleted_file(struct inode *inode,
+					     const char *path);
 
-extern struct TCP_Server_Info *
-cifs_get_tcp_session(struct smb3_fs_context *ctx,
-		     struct TCP_Server_Info *primary_server);
-extern void cifs_put_tcp_session(struct TCP_Server_Info *server,
-				 int from_reconnect);
-extern void cifs_put_tcon(struct cifs_tcon *tcon, enum smb3_tcon_ref_trace trace);
+struct TCP_Server_Info *cifs_get_tcp_session(struct smb3_fs_context *ctx,
+					     struct TCP_Server_Info *primary_server);
+void cifs_put_tcp_session(struct TCP_Server_Info *server, int from_reconnect);
+void cifs_put_tcon(struct cifs_tcon *tcon, enum smb3_tcon_ref_trace trace);
 
-extern void cifs_release_automount_timer(void);
+void cifs_release_automount_timer(void);
 
 void cifs_proc_init(void);
 void cifs_proc_clean(void);
 
-extern void cifs_move_llist(struct list_head *source, struct list_head *dest);
-extern void cifs_free_llist(struct list_head *llist);
-extern void cifs_del_lock_waiters(struct cifsLockInfo *lock);
+void cifs_move_llist(struct list_head *source, struct list_head *dest);
+void cifs_free_llist(struct list_head *llist);
+void cifs_del_lock_waiters(struct cifsLockInfo *lock);
 
 int cifs_tree_connect(const unsigned int xid, struct cifs_tcon *tcon);
 
-extern int cifs_negotiate_protocol(const unsigned int xid,
-				   struct cifs_ses *ses,
-				   struct TCP_Server_Info *server);
-extern int cifs_setup_session(const unsigned int xid, struct cifs_ses *ses,
-			      struct TCP_Server_Info *server,
-			      struct nls_table *nls_info);
-extern int cifs_enable_signing(struct TCP_Server_Info *server, bool mnt_sign_required);
-extern int CIFSSMBNegotiate(const unsigned int xid,
-			    struct cifs_ses *ses,
+int cifs_negotiate_protocol(const unsigned int xid, struct cifs_ses *ses,
 			    struct TCP_Server_Info *server);
-
-extern int CIFSTCon(const unsigned int xid, struct cifs_ses *ses,
-		    const char *tree, struct cifs_tcon *tcon,
-		    const struct nls_table *);
-
-extern int CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
-		const char *searchName, struct cifs_sb_info *cifs_sb,
-		__u16 *searchHandle, __u16 search_flags,
-		struct cifs_search_info *psrch_inf,
-		bool msearch);
-
-extern int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
-		__u16 searchHandle, __u16 search_flags,
-		struct cifs_search_info *psrch_inf);
-
-extern int CIFSFindClose(const unsigned int xid, struct cifs_tcon *tcon,
-			const __u16 search_handle);
-
-extern int CIFSSMBQFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
-			u16 netfid, FILE_ALL_INFO *pFindData);
-extern int CIFSSMBQPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
-			    const char *search_Name, FILE_ALL_INFO *data,
-			    int legacy /* whether to use old info level */,
-			    const struct nls_table *nls_codepage, int remap);
-extern int SMBQueryInformation(const unsigned int xid, struct cifs_tcon *tcon,
-			       const char *search_name, FILE_ALL_INFO *data,
-			       const struct nls_table *nls_codepage, int remap);
-
-extern int CIFSSMBUnixQFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
-			u16 netfid, FILE_UNIX_BASIC_INFO *pFindData);
-extern int CIFSSMBUnixQPathInfo(const unsigned int xid,
-			struct cifs_tcon *tcon,
-			const unsigned char *searchName,
-			FILE_UNIX_BASIC_INFO *pFindData,
+int cifs_setup_session(const unsigned int xid, struct cifs_ses *ses,
+		       struct TCP_Server_Info *server,
+		       struct nls_table *nls_info);
+int cifs_enable_signing(struct TCP_Server_Info *server,
+			bool mnt_sign_required);
+int CIFSSMBNegotiate(const unsigned int xid, struct cifs_ses *ses,
+		     struct TCP_Server_Info *server);
+
+int CIFSTCon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
+	     struct cifs_tcon *tcon, const struct nls_table *nls_codepage);
+
+int CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
+		  const char *searchName, struct cifs_sb_info *cifs_sb,
+		  __u16 *pnetfid, __u16 search_flags,
+		  struct cifs_search_info *psrch_inf, bool msearch);
+
+int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
+		 __u16 searchHandle, __u16 search_flags,
+		 struct cifs_search_info *psrch_inf);
+
+int CIFSFindClose(const unsigned int xid, struct cifs_tcon *tcon,
+		  const __u16 searchHandle);
+
+int CIFSSMBQFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
+		     u16 netfid, FILE_ALL_INFO *pFindData);
+int CIFSSMBQPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
+		     const char *search_name, FILE_ALL_INFO *data,
+		     int legacy /* old style infolevel */,
+		     const struct nls_table *nls_codepage, int remap);
+int SMBQueryInformation(const unsigned int xid, struct cifs_tcon *tcon,
+			const char *search_name, FILE_ALL_INFO *data,
 			const struct nls_table *nls_codepage, int remap);
 
-extern int CIFSGetDFSRefer(const unsigned int xid, struct cifs_ses *ses,
-			   const char *search_name,
-			   struct dfs_info3_param **target_nodes,
-			   unsigned int *num_of_nodes,
-			   const struct nls_table *nls_codepage, int remap);
-
-extern int parse_dfs_referrals(struct get_dfs_referral_rsp *rsp, u32 rsp_size,
-			       unsigned int *num_of_nodes,
-			       struct dfs_info3_param **target_nodes,
-			       const struct nls_table *nls_codepage, int remap,
-			       const char *searchName, bool is_unicode);
-extern void reset_cifs_unix_caps(unsigned int xid, struct cifs_tcon *tcon,
-				 struct cifs_sb_info *cifs_sb,
-				 struct smb3_fs_context *ctx);
-extern int CIFSSMBQFSInfo(const unsigned int xid, struct cifs_tcon *tcon,
-			struct kstatfs *FSData);
-extern int SMBOldQFSInfo(const unsigned int xid, struct cifs_tcon *tcon,
-			struct kstatfs *FSData);
-extern int CIFSSMBSetFSUnixInfo(const unsigned int xid, struct cifs_tcon *tcon,
-			__u64 cap);
-
-extern int CIFSSMBQFSAttributeInfo(const unsigned int xid,
-			struct cifs_tcon *tcon);
-extern int CIFSSMBQFSDeviceInfo(const unsigned int xid, struct cifs_tcon *tcon);
-extern int CIFSSMBQFSUnixInfo(const unsigned int xid, struct cifs_tcon *tcon);
-extern int CIFSSMBQFSPosixInfo(const unsigned int xid, struct cifs_tcon *tcon,
+int CIFSSMBUnixQFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
+			 u16 netfid, FILE_UNIX_BASIC_INFO *pFindData);
+int CIFSSMBUnixQPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
+			 const unsigned char *searchName,
+			 FILE_UNIX_BASIC_INFO *pFindData,
+			 const struct nls_table *nls_codepage, int remap);
+
+int CIFSGetDFSRefer(const unsigned int xid, struct cifs_ses *ses,
+		    const char *search_name,
+		    struct dfs_info3_param **target_nodes,
+		    unsigned int *num_of_nodes,
+		    const struct nls_table *nls_codepage, int remap);
+
+int parse_dfs_referrals(struct get_dfs_referral_rsp *rsp, u32 rsp_size,
+			unsigned int *num_of_nodes,
+			struct dfs_info3_param **target_nodes,
+			const struct nls_table *nls_codepage, int remap,
+			const char *searchName, bool is_unicode);
+void reset_cifs_unix_caps(unsigned int xid, struct cifs_tcon *tcon,
+			  struct cifs_sb_info *cifs_sb,
+			  struct smb3_fs_context *ctx);
+int CIFSSMBQFSInfo(const unsigned int xid, struct cifs_tcon *tcon,
+		   struct kstatfs *FSData);
+int SMBOldQFSInfo(const unsigned int xid, struct cifs_tcon *tcon,
+		  struct kstatfs *FSData);
+int CIFSSMBSetFSUnixInfo(const unsigned int xid, struct cifs_tcon *tcon,
+			 __u64 cap);
+
+int CIFSSMBQFSAttributeInfo(const unsigned int xid, struct cifs_tcon *tcon);
+int CIFSSMBQFSDeviceInfo(const unsigned int xid, struct cifs_tcon *tcon);
+int CIFSSMBQFSUnixInfo(const unsigned int xid, struct cifs_tcon *tcon);
+int CIFSSMBQFSPosixInfo(const unsigned int xid, struct cifs_tcon *tcon,
 			struct kstatfs *FSData);
 
-extern int SMBSetInformation(const unsigned int xid, struct cifs_tcon *tcon,
-			     const char *fileName, __le32 attributes, __le64 write_time,
-			     const struct nls_table *nls_codepage,
-			     struct cifs_sb_info *cifs_sb);
-extern int CIFSSMBSetPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
-			const char *fileName, const FILE_BASIC_INFO *data,
-			const struct nls_table *nls_codepage,
-			struct cifs_sb_info *cifs_sb);
-extern int CIFSSMBSetFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
-			const FILE_BASIC_INFO *data, __u16 fid,
-			__u32 pid_of_opener);
-extern int CIFSSMBSetFileDisposition(const unsigned int xid,
-				     struct cifs_tcon *tcon,
-				     bool delete_file, __u16 fid,
-				     __u32 pid_of_opener);
-extern int CIFSSMBSetEOF(const unsigned int xid, struct cifs_tcon *tcon,
-			 const char *file_name, __u64 size,
-			 struct cifs_sb_info *cifs_sb, bool set_allocation,
-			 struct dentry *dentry);
-extern int CIFSSMBSetFileSize(const unsigned int xid, struct cifs_tcon *tcon,
-			      struct cifsFileInfo *cfile, __u64 size,
-			      bool set_allocation);
+int SMBSetInformation(const unsigned int xid, struct cifs_tcon *tcon,
+		      const char *fileName, __le32 attributes,
+		      __le64 write_time, const struct nls_table *nls_codepage,
+		      struct cifs_sb_info *cifs_sb);
+int CIFSSMBSetPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
+		       const char *fileName, const FILE_BASIC_INFO *data,
+		       const struct nls_table *nls_codepage,
+		       struct cifs_sb_info *cifs_sb);
+int CIFSSMBSetFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
+		       const FILE_BASIC_INFO *data, __u16 fid,
+		       __u32 pid_of_opener);
+int CIFSSMBSetFileDisposition(const unsigned int xid, struct cifs_tcon *tcon,
+			      bool delete_file, __u16 fid,
+			      __u32 pid_of_opener);
+int CIFSSMBSetEOF(const unsigned int xid, struct cifs_tcon *tcon,
+		  const char *file_name, __u64 size,
+		  struct cifs_sb_info *cifs_sb, bool set_allocation,
+		  struct dentry *dentry);
+int CIFSSMBSetFileSize(const unsigned int xid, struct cifs_tcon *tcon,
+		       struct cifsFileInfo *cfile, __u64 size,
+		       bool set_allocation);
 
 struct cifs_unix_set_info_args {
 	__u64	ctime;
@@ -433,184 +414,170 @@ struct cifs_unix_set_info_args {
 	dev_t	device;
 };
 
-extern int CIFSSMBUnixSetFileInfo(const unsigned int xid,
-				  struct cifs_tcon *tcon,
-				  const struct cifs_unix_set_info_args *args,
-				  u16 fid, u32 pid_of_opener);
-
-extern int CIFSSMBUnixSetPathInfo(const unsigned int xid,
-				  struct cifs_tcon *tcon, const char *file_name,
-				  const struct cifs_unix_set_info_args *args,
-				  const struct nls_table *nls_codepage,
-				  int remap);
-
-extern int CIFSSMBMkDir(const unsigned int xid, struct inode *inode,
-			umode_t mode, struct cifs_tcon *tcon,
-			const char *name, struct cifs_sb_info *cifs_sb);
-extern int CIFSSMBRmDir(const unsigned int xid, struct cifs_tcon *tcon,
-			const char *name, struct cifs_sb_info *cifs_sb);
-extern int CIFSPOSIXDelFile(const unsigned int xid, struct cifs_tcon *tcon,
-			const char *name, __u16 type,
-			const struct nls_table *nls_codepage,
-			int remap_special_chars);
-extern int CIFSSMBDelFile(const unsigned int xid, struct cifs_tcon *tcon,
-			  const char *name, struct cifs_sb_info *cifs_sb,
-			  struct dentry *dentry);
+int CIFSSMBUnixSetFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
+			   const struct cifs_unix_set_info_args *args, u16 fid,
+			   u32 pid_of_opener);
+
+int CIFSSMBUnixSetPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
+			   const char *file_name,
+			   const struct cifs_unix_set_info_args *args,
+			   const struct nls_table *nls_codepage, int remap);
+
+int CIFSSMBMkDir(const unsigned int xid, struct inode *inode, umode_t mode,
+		 struct cifs_tcon *tcon, const char *name,
+		 struct cifs_sb_info *cifs_sb);
+int CIFSSMBRmDir(const unsigned int xid, struct cifs_tcon *tcon,
+		 const char *name, struct cifs_sb_info *cifs_sb);
+int CIFSPOSIXDelFile(const unsigned int xid, struct cifs_tcon *tcon,
+		     const char *fileName, __u16 type,
+		     const struct nls_table *nls_codepage, int remap);
+int CIFSSMBDelFile(const unsigned int xid, struct cifs_tcon *tcon,
+		   const char *name, struct cifs_sb_info *cifs_sb,
+		   struct dentry *dentry);
 int CIFSSMBRename(const unsigned int xid, struct cifs_tcon *tcon,
-		  struct dentry *source_dentry,
-		  const char *from_name, const char *to_name,
-		  struct cifs_sb_info *cifs_sb);
-extern int CIFSSMBRenameOpenFile(const unsigned int xid, struct cifs_tcon *tcon,
-				 int netfid, const char *target_name,
-				 const struct nls_table *nls_codepage,
-				 int remap_special_chars);
-int CIFSCreateHardLink(const unsigned int xid,
-		       struct cifs_tcon *tcon,
-		       struct dentry *source_dentry,
-		       const char *from_name, const char *to_name,
-		       struct cifs_sb_info *cifs_sb);
-extern int CIFSUnixCreateHardLink(const unsigned int xid,
-			struct cifs_tcon *tcon,
-			const char *fromName, const char *toName,
-			const struct nls_table *nls_codepage,
-			int remap_special_chars);
-extern int CIFSUnixCreateSymLink(const unsigned int xid,
-			struct cifs_tcon *tcon,
-			const char *fromName, const char *toName,
-			const struct nls_table *nls_codepage, int remap);
-extern int CIFSSMBUnixQuerySymLink(const unsigned int xid,
-			struct cifs_tcon *tcon,
-			const unsigned char *searchName, char **syminfo,
-			const struct nls_table *nls_codepage, int remap);
-extern int cifs_query_reparse_point(const unsigned int xid,
-				    struct cifs_tcon *tcon,
-				    struct cifs_sb_info *cifs_sb,
-				    const char *full_path,
-				    u32 *tag, struct kvec *rsp,
-				    int *rsp_buftype);
-extern struct inode *cifs_create_reparse_inode(struct cifs_open_info_data *data,
-					       struct super_block *sb,
-					       const unsigned int xid,
-					       struct cifs_tcon *tcon,
-					       const char *full_path,
-					       bool directory,
-					       struct kvec *reparse_iov,
-					       struct kvec *xattr_iov);
-extern int CIFSSMB_set_compression(const unsigned int xid,
-				   struct cifs_tcon *tcon, __u16 fid);
-extern int CIFS_open(const unsigned int xid, struct cifs_open_parms *oparms,
-		     int *oplock, FILE_ALL_INFO *buf);
-extern int SMBLegacyOpen(const unsigned int xid, struct cifs_tcon *tcon,
-			const char *fileName, const int disposition,
-			const int access_flags, const int omode,
-			__u16 *netfid, int *pOplock, FILE_ALL_INFO *,
-			const struct nls_table *nls_codepage, int remap);
-extern int CIFSPOSIXCreate(const unsigned int xid, struct cifs_tcon *tcon,
-			u32 posix_flags, __u64 mode, __u16 *netfid,
-			FILE_UNIX_BASIC_INFO *pRetData,
-			__u32 *pOplock, const char *name,
-			const struct nls_table *nls_codepage, int remap);
-extern int CIFSSMBClose(const unsigned int xid, struct cifs_tcon *tcon,
-			const int smb_file_id);
-
-extern int CIFSSMBFlush(const unsigned int xid, struct cifs_tcon *tcon,
-			const int smb_file_id);
-
-extern int CIFSSMBRead(const unsigned int xid, struct cifs_io_parms *io_parms,
-			unsigned int *nbytes, char **buf,
-			int *return_buf_type);
-extern int CIFSSMBWrite(const unsigned int xid, struct cifs_io_parms *io_parms,
-			unsigned int *nbytes, const char *buf);
-extern int CIFSSMBWrite2(const unsigned int xid, struct cifs_io_parms *io_parms,
-			unsigned int *nbytes, struct kvec *iov, const int nvec);
-extern int CIFSGetSrvInodeNumber(const unsigned int xid, struct cifs_tcon *tcon,
-				 const char *search_name, __u64 *inode_number,
-				 const struct nls_table *nls_codepage,
-				 int remap);
-
-extern int cifs_lockv(const unsigned int xid, struct cifs_tcon *tcon,
-		      const __u16 netfid, const __u8 lock_type,
-		      const __u32 num_unlock, const __u32 num_lock,
-		      LOCKING_ANDX_RANGE *buf);
-extern int CIFSSMBLock(const unsigned int xid, struct cifs_tcon *tcon,
-			const __u16 netfid, const __u32 netpid, const __u64 len,
-			const __u64 offset, const __u32 numUnlock,
-			const __u32 numLock, const __u8 lockType,
-			const bool waitFlag, const __u8 oplock_level);
-extern int CIFSSMBPosixLock(const unsigned int xid, struct cifs_tcon *tcon,
-			const __u16 smb_file_id, const __u32 netpid,
-			const loff_t start_offset, const __u64 len,
-			struct file_lock *, const __u16 lock_type,
-			const bool waitFlag);
-extern int CIFSSMBTDis(const unsigned int xid, struct cifs_tcon *tcon);
-extern int CIFSSMBEcho(struct TCP_Server_Info *server);
-extern int CIFSSMBLogoff(const unsigned int xid, struct cifs_ses *ses);
-
-extern struct cifs_ses *sesInfoAlloc(void);
-extern void sesInfoFree(struct cifs_ses *);
-extern struct cifs_tcon *tcon_info_alloc(bool dir_leases_enabled,
-					 enum smb3_tcon_ref_trace trace);
-extern void tconInfoFree(struct cifs_tcon *tcon, enum smb3_tcon_ref_trace trace);
-
-extern int cifs_sign_rqst(struct smb_rqst *rqst, struct TCP_Server_Info *server,
+		  struct dentry *source_dentry, const char *from_name,
+		  const char *to_name, struct cifs_sb_info *cifs_sb);
+int CIFSSMBRenameOpenFile(const unsigned int xid, struct cifs_tcon *pTcon,
+			  int netfid, const char *target_name,
+			  const struct nls_table *nls_codepage, int remap);
+int CIFSCreateHardLink(const unsigned int xid, struct cifs_tcon *tcon,
+		       struct dentry *source_dentry, const char *from_name,
+		       const char *to_name, struct cifs_sb_info *cifs_sb);
+int CIFSUnixCreateHardLink(const unsigned int xid, struct cifs_tcon *tcon,
+			   const char *fromName, const char *toName,
+			   const struct nls_table *nls_codepage, int remap);
+int CIFSUnixCreateSymLink(const unsigned int xid, struct cifs_tcon *tcon,
+			  const char *fromName, const char *toName,
+			  const struct nls_table *nls_codepage, int remap);
+int CIFSSMBUnixQuerySymLink(const unsigned int xid, struct cifs_tcon *tcon,
+			    const unsigned char *searchName,
+			    char **symlinkinfo,
+			    const struct nls_table *nls_codepage, int remap);
+int cifs_query_reparse_point(const unsigned int xid, struct cifs_tcon *tcon,
+			     struct cifs_sb_info *cifs_sb,
+			     const char *full_path, u32 *tag, struct kvec *rsp,
+			     int *rsp_buftype);
+struct inode *cifs_create_reparse_inode(struct cifs_open_info_data *data,
+					struct super_block *sb,
+					const unsigned int xid,
+					struct cifs_tcon *tcon,
+					const char *full_path, bool directory,
+					struct kvec *reparse_iov,
+					struct kvec *xattr_iov);
+int CIFSSMB_set_compression(const unsigned int xid, struct cifs_tcon *tcon,
+			    __u16 fid);
+int CIFS_open(const unsigned int xid, struct cifs_open_parms *oparms,
+	      int *oplock, FILE_ALL_INFO *buf);
+int SMBLegacyOpen(const unsigned int xid, struct cifs_tcon *tcon,
+		  const char *fileName, const int openDisposition,
+		  const int access_flags, const int create_options,
+		  __u16 *netfid, int *pOplock, FILE_ALL_INFO *pfile_info,
+		  const struct nls_table *nls_codepage, int remap);
+int CIFSPOSIXCreate(const unsigned int xid, struct cifs_tcon *tcon,
+		    __u32 posix_flags, __u64 mode, __u16 *netfid,
+		    FILE_UNIX_BASIC_INFO *pRetData, __u32 *pOplock,
+		    const char *name, const struct nls_table *nls_codepage,
+		    int remap);
+int CIFSSMBClose(const unsigned int xid, struct cifs_tcon *tcon,
+		 int smb_file_id);
+
+int CIFSSMBFlush(const unsigned int xid, struct cifs_tcon *tcon,
+		 int smb_file_id);
+
+int CIFSSMBRead(const unsigned int xid, struct cifs_io_parms *io_parms,
+		unsigned int *nbytes, char **buf, int *pbuf_type);
+int CIFSSMBWrite(const unsigned int xid, struct cifs_io_parms *io_parms,
+		 unsigned int *nbytes, const char *buf);
+int CIFSSMBWrite2(const unsigned int xid, struct cifs_io_parms *io_parms,
+		  unsigned int *nbytes, struct kvec *iov, int n_vec);
+int CIFSGetSrvInodeNumber(const unsigned int xid, struct cifs_tcon *tcon,
+			  const char *search_name, __u64 *inode_number,
+			  const struct nls_table *nls_codepage, int remap);
+
+int cifs_lockv(const unsigned int xid, struct cifs_tcon *tcon,
+	       const __u16 netfid, const __u8 lock_type,
+	       const __u32 num_unlock, const __u32 num_lock,
+	       LOCKING_ANDX_RANGE *buf);
+int CIFSSMBLock(const unsigned int xid, struct cifs_tcon *tcon,
+		const __u16 smb_file_id, const __u32 netpid, const __u64 len,
+		const __u64 offset, const __u32 numUnlock, const __u32 numLock,
+		const __u8 lockType, const bool waitFlag,
+		const __u8 oplock_level);
+int CIFSSMBPosixLock(const unsigned int xid, struct cifs_tcon *tcon,
+		     const __u16 smb_file_id, const __u32 netpid,
+		     const loff_t start_offset, const __u64 len,
+		     struct file_lock *pLockData, const __u16 lock_type,
+		     const bool waitFlag);
+int CIFSSMBTDis(const unsigned int xid, struct cifs_tcon *tcon);
+int CIFSSMBEcho(struct TCP_Server_Info *server);
+int CIFSSMBLogoff(const unsigned int xid, struct cifs_ses *ses);
+
+struct cifs_ses *sesInfoAlloc(void);
+void sesInfoFree(struct cifs_ses *buf_to_free);
+struct cifs_tcon *tcon_info_alloc(bool dir_leases_enabled,
+				  enum smb3_tcon_ref_trace trace);
+void tconInfoFree(struct cifs_tcon *tcon, enum smb3_tcon_ref_trace trace);
+
+int cifs_sign_rqst(struct smb_rqst *rqst, struct TCP_Server_Info *server,
 		   __u32 *pexpected_response_sequence_number);
 int cifs_verify_signature(struct smb_rqst *rqst,
 			  struct TCP_Server_Info *server,
 			  __u32 expected_sequence_number);
-extern int setup_ntlmv2_rsp(struct cifs_ses *, const struct nls_table *);
-extern void cifs_crypto_secmech_release(struct TCP_Server_Info *server);
-extern int calc_seckey(struct cifs_ses *);
-extern int generate_smb30signingkey(struct cifs_ses *ses,
-				    struct TCP_Server_Info *server);
-extern int generate_smb311signingkey(struct cifs_ses *ses,
-				     struct TCP_Server_Info *server);
+int setup_ntlmv2_rsp(struct cifs_ses *ses, const struct nls_table *nls_cp);
+void cifs_crypto_secmech_release(struct TCP_Server_Info *server);
+int calc_seckey(struct cifs_ses *ses);
+int generate_smb30signingkey(struct cifs_ses *ses,
+			     struct TCP_Server_Info *server);
+int generate_smb311signingkey(struct cifs_ses *ses,
+			      struct TCP_Server_Info *server);
 
 #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
-extern ssize_t CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
-			const unsigned char *searchName,
-			const unsigned char *ea_name, char *EAData,
-			size_t bufsize, struct cifs_sb_info *cifs_sb);
-extern int CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
-		const char *fileName, const char *ea_name,
-		const void *ea_value, const __u16 ea_value_len,
-		const struct nls_table *nls_codepage,
-		struct cifs_sb_info *cifs_sb);
-extern int CIFSSMBGetCIFSACL(const unsigned int xid, struct cifs_tcon *tcon,
-			__u16 fid, struct smb_ntsd **acl_inf, __u32 *buflen, __u32 info);
-extern int CIFSSMBSetCIFSACL(const unsigned int, struct cifs_tcon *, __u16,
-			struct smb_ntsd *pntsd, __u32 len, int aclflag);
-extern int cifs_do_get_acl(const unsigned int xid, struct cifs_tcon *tcon,
-			   const unsigned char *searchName,
-			   struct posix_acl **acl, const int acl_type,
-			   const struct nls_table *nls_codepage, int remap);
-extern int cifs_do_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
-			   const unsigned char *fileName,
-			   const struct posix_acl *acl, const int acl_type,
-			   const struct nls_table *nls_codepage, int remap);
-extern int CIFSGetExtAttr(const unsigned int xid, struct cifs_tcon *tcon,
-			const int netfid, __u64 *pExtAttrBits, __u64 *pMask);
+ssize_t CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
+		       const unsigned char *searchName,
+		       const unsigned char *ea_name, char *EAData,
+		       size_t buf_size, struct cifs_sb_info *cifs_sb);
+int CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
+		 const char *fileName, const char *ea_name,
+		 const void *ea_value, const __u16 ea_value_len,
+		 const struct nls_table *nls_codepage,
+		 struct cifs_sb_info *cifs_sb);
+int CIFSSMBGetCIFSACL(const unsigned int xid, struct cifs_tcon *tcon,
+		      __u16 fid, struct smb_ntsd **acl_inf, __u32 *pbuflen,
+		      __u32 info);
+int CIFSSMBSetCIFSACL(const unsigned int xid, struct cifs_tcon *tcon,
+		      __u16 fid, struct smb_ntsd *pntsd, __u32 acllen,
+		      int aclflag);
+int cifs_do_get_acl(const unsigned int xid, struct cifs_tcon *tcon,
+		    const unsigned char *searchName, struct posix_acl **acl,
+		    const int acl_type, const struct nls_table *nls_codepage,
+		    int remap);
+int cifs_do_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
+		    const unsigned char *fileName, const struct posix_acl *acl,
+		    const int acl_type, const struct nls_table *nls_codepage,
+		    int remap);
+int CIFSGetExtAttr(const unsigned int xid, struct cifs_tcon *tcon,
+		   const int netfid, __u64 *pExtAttrBits, __u64 *pMask);
 #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
-extern void cifs_autodisable_serverino(struct cifs_sb_info *cifs_sb);
-extern bool couldbe_mf_symlink(const struct cifs_fattr *fattr);
-extern int check_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
-			      struct cifs_sb_info *cifs_sb,
-			      struct cifs_fattr *fattr,
-			      const unsigned char *path);
-extern int E_md4hash(const unsigned char *passwd, unsigned char *p16,
-			const struct nls_table *codepage);
+void cifs_autodisable_serverino(struct cifs_sb_info *cifs_sb);
+bool couldbe_mf_symlink(const struct cifs_fattr *fattr);
+int check_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
+		     struct cifs_sb_info *cifs_sb, struct cifs_fattr *fattr,
+		     const unsigned char *path);
+int E_md4hash(const unsigned char *passwd, unsigned char *p16,
+	      const struct nls_table *codepage);
 
-extern struct TCP_Server_Info *
-cifs_find_tcp_session(struct smb3_fs_context *ctx);
+struct TCP_Server_Info *cifs_find_tcp_session(struct smb3_fs_context *ctx);
 
 struct cifs_tcon *cifs_setup_ipc(struct cifs_ses *ses, bool seal);
 
 void __cifs_put_smb_ses(struct cifs_ses *ses);
 
-extern struct cifs_ses *
-cifs_get_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx);
+struct cifs_ses *cifs_get_smb_ses(struct TCP_Server_Info *server,
+				  struct smb3_fs_context *ctx);
 
 int cifs_async_readv(struct cifs_io_subrequest *rdata);
-int cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid);
+int cifs_readv_receive(struct TCP_Server_Info *server,
+		       struct mid_q_entry *mid);
 
 void cifs_async_writev(struct cifs_io_subrequest *wdata);
 int cifs_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
@@ -621,46 +588,41 @@ int cifs_create_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 			   struct cifs_sb_info *cifs_sb,
 			   const unsigned char *path, char *pbuf,
 			   unsigned int *pbytes_written);
-int __cifs_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server,
-			  char *signature, struct cifs_calc_sig_ctx *ctx);
-enum securityEnum cifs_select_sectype(struct TCP_Server_Info *,
-					enum securityEnum);
+int __cifs_calc_signature(struct smb_rqst *rqst,
+			  struct TCP_Server_Info *server, char *signature,
+			  struct cifs_calc_sig_ctx *ctx);
+enum securityEnum cifs_select_sectype(struct TCP_Server_Info *server,
+				      enum securityEnum requested);
 
 int cifs_alloc_hash(const char *name, struct shash_desc **sdesc);
 void cifs_free_hash(struct shash_desc **sdesc);
 
 int cifs_try_adding_channels(struct cifs_ses *ses);
-int smb3_update_ses_channels(struct cifs_ses *ses, struct TCP_Server_Info *server,
-					bool from_reconnect, bool disable_mchan);
+int smb3_update_ses_channels(struct cifs_ses *ses,
+			     struct TCP_Server_Info *server,
+			     bool from_reconnect, bool disable_mchan);
 bool is_ses_using_iface(struct cifs_ses *ses, struct cifs_server_iface *iface);
 
-int
-cifs_ses_get_chan_index(struct cifs_ses *ses,
-			struct TCP_Server_Info *server);
-void
-cifs_chan_set_in_reconnect(struct cifs_ses *ses,
-			     struct TCP_Server_Info *server);
-void
-cifs_chan_clear_in_reconnect(struct cifs_ses *ses,
+int cifs_ses_get_chan_index(struct cifs_ses *ses,
+			    struct TCP_Server_Info *server);
+void cifs_chan_set_in_reconnect(struct cifs_ses *ses,
+				struct TCP_Server_Info *server);
+void cifs_chan_clear_in_reconnect(struct cifs_ses *ses,
+				  struct TCP_Server_Info *server);
+void cifs_chan_set_need_reconnect(struct cifs_ses *ses,
+				  struct TCP_Server_Info *server);
+void cifs_chan_clear_need_reconnect(struct cifs_ses *ses,
+				    struct TCP_Server_Info *server);
+bool cifs_chan_needs_reconnect(struct cifs_ses *ses,
 			       struct TCP_Server_Info *server);
-void
-cifs_chan_set_need_reconnect(struct cifs_ses *ses,
-			     struct TCP_Server_Info *server);
-void
-cifs_chan_clear_need_reconnect(struct cifs_ses *ses,
+bool cifs_chan_is_iface_active(struct cifs_ses *ses,
 			       struct TCP_Server_Info *server);
-bool
-cifs_chan_needs_reconnect(struct cifs_ses *ses,
-			  struct TCP_Server_Info *server);
-bool
-cifs_chan_is_iface_active(struct cifs_ses *ses,
-			  struct TCP_Server_Info *server);
-void
-cifs_decrease_secondary_channels(struct cifs_ses *ses, bool disable_mchan);
-void
-cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server);
-int
-SMB3_request_interfaces(const unsigned int xid, struct cifs_tcon *tcon, bool in_mount);
+void cifs_decrease_secondary_channels(struct cifs_ses *ses,
+				      bool disable_mchan);
+void cifs_chan_update_iface(struct cifs_ses *ses,
+			    struct TCP_Server_Info *server);
+int SMB3_request_interfaces(const unsigned int xid, struct cifs_tcon *tcon,
+			    bool in_mount);
 
 void extract_unc_hostname(const char *unc, const char **h, size_t *len);
 int copy_path_name(char *dst, const char *src);
@@ -673,9 +635,8 @@ void cifs_put_tcp_super(struct super_block *sb);
 int cifs_update_super_prepath(struct cifs_sb_info *cifs_sb, char *prefix);
 char *extract_hostname(const char *unc);
 char *extract_sharename(const char *unc);
-int parse_reparse_point(struct reparse_data_buffer *buf,
-			u32 plen, struct cifs_sb_info *cifs_sb,
-			const char *full_path,
+int parse_reparse_point(struct reparse_data_buffer *buf, u32 plen,
+			struct cifs_sb_info *cifs_sb, const char *full_path,
 			struct cifs_open_info_data *data);
 int __cifs_sfu_make_node(unsigned int xid, struct inode *inode,
 			 struct dentry *dentry, struct cifs_tcon *tcon,
@@ -696,14 +657,12 @@ static inline int get_dfs_path(const unsigned int xid, struct cifs_ses *ses,
 			      referral, NULL);
 }
 
-int match_target_ip(struct TCP_Server_Info *server,
-		    const char *host, size_t hostlen,
-		    bool *result);
+int match_target_ip(struct TCP_Server_Info *server, const char *host,
+		    size_t hostlen, bool *result);
 int cifs_inval_name_dfs_link_error(const unsigned int xid,
 				   struct cifs_tcon *tcon,
 				   struct cifs_sb_info *cifs_sb,
-				   const char *full_path,
-				   bool *islink);
+				   const char *full_path, bool *islink);
 #else
 static inline int cifs_inval_name_dfs_link_error(const unsigned int xid,
 				   struct cifs_tcon *tcon,


