Return-Path: <linux-fsdevel+bounces-62637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B78B9B486
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED66D189C70B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60E0328978;
	Wed, 24 Sep 2025 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWpcaMbx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293AC31B10F;
	Wed, 24 Sep 2025 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737241; cv=none; b=HnyyLqX2oVHEiD1ukODjP92lKSdqlmSZvH7ONiDMYp46O4hMO6v9VUYXzc9jQU0QDZ6lqM+cUD6yT6IWGDGycYbyQ4xmOuUZNVcPjdyeEVZVNveR//TFeAibWF8PmWRb/DlMIgcYiOALtrkZruquHPbgLJpkUYjbtbFmhX306LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737241; c=relaxed/simple;
	bh=oT/w7e0Nr7icIaUg0hP6gAU9LrXGgCmmNZYpD7atfdI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gTq51BC/SbAJ9IGeeUWTCK5nV1r3DRCUbroxMP4C/n4jSk6SBiXJPIV+vZZFbEKTvX617Z04scLCHnkDNOMmu1a1C99pqwWM0QpUIX5AJsSZa4p3AVrvFgytV9BN2cisDp+tCG7LvMImoT/T+pEmThlcjUlKHuW1H3aFFNpTUFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWpcaMbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A41C116D0;
	Wed, 24 Sep 2025 18:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737240;
	bh=oT/w7e0Nr7icIaUg0hP6gAU9LrXGgCmmNZYpD7atfdI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RWpcaMbx2qYF/uf5jGq6xatsU3jhoiTLPfpak0JkDg6nvgKUR+ZRMdVWN4lu7/+jz
	 W7OSNFX5GSo80umfQ/Sf+2foVpgVW9K5Da+BS+r0fa6e017b+jPH1Ejvw4jAnfir+L
	 LiYmfpbeEMomX3txd6MQcSp5HWjF6pA56RCLbOUtP78Z+O4+AA4nZzaqs0TEoIhmBS
	 7nr9pm72Sy+PCnszF8TL05ztBPjWLAFX+oAFryv+47XqMy555l5T3jlF1QUgSwe/WQ
	 DGGvhXlr3R2UjO995w/22xY3J2X6QgiWwR2AtoWICMciYTF9vz+FkDLaskkzN9E66r
	 2QhFEGCoBcXYg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:06:05 -0400
Subject: [PATCH v3 19/38] nfsd: add protocol support for CB_NOTIFY
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-19-9f3af8bc5c40@kernel.org>
References: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
In-Reply-To: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Paulo Alcantara <pc@manguebit.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Paulo Alcantara <pc@manguebit.org>
Cc: Rick Macklem <rick.macklem@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-doc@vger.kernel.org, netfs@lists.linux.dev, ecryptfs@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=46930; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=oT/w7e0Nr7icIaUg0hP6gAU9LrXGgCmmNZYpD7atfdI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMO6FsciOMtqAUFWvZtc9wsPN/jk63Hm+Spk
 K0AhAxs0qSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzDgAKCRAADmhBGVaC
 FcxDD/4sj8ZZJR/r8UDRKw4AeYv1akn7tI/SmR5iQ2pK+yv2TBJLkKT4CPPgT7bo2J1c/2zlAdb
 0WrnzP2rNamV6CT3LNl3rv73OlGINDup1iXDXmeLJTXRueagO1rvNCn9g5AIVo6dwe1ZI5Zcmws
 FibaTP3HZHJ+ii2UlMrX84bzdHK1UxcZtNcvfre9/kw7EDqH+sMtGE2nsFZU4sBGLFFGC/le0KE
 6C+gzm+rPq78wCgansLmMAcGG9RxnSqmMOibbiW7W8wUE7I3JjCombUskl6RLeLlutDF7TR20aY
 R3gNUtwR0Fg9x0Vfoxtf8dS8CAUkEpAkFCjSHgRjRoZfeeH8pJ0MGVyXOO4R+jLRtQ1jYm80qeC
 tE8rwhwYiPBm4JnQa98jGofAsmveo66TIZzlhyTikTA8Rpwv4ltlqXkw7gTjIx78KPkvou+CQSa
 jhErX2F3EZDExxyGSd1rICGsivJyUeA0u+zBv5+1y8kDq1rB/ewnheGJe5j3xTbl1Dl/K0gwU+L
 +5Cbnpr7GzDzxuBtweBgR3m9Bzcx3ErXFqLn112/5VPsbkfiCpo61ne+MHsuLgFG8gY+nbNku95
 ihXr85sN352SKG2I6XuKi7I8/Srnfx5w4eUaQEbExU6SOEQwlDfs7Cea/ldBfNKGfmH1Pjob9vh
 m+CUrwOCbnkHbsQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the necessary bits to nfs4_1.x and remove the duplicate definitions
from nfs4.h and the uapi nfs4 header. Regenerate the xdr files.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/sunrpc/xdr/nfs4_1.x    | 253 +++++++++++++++++-
 fs/nfsd/nfs4xdr_gen.c                | 506 ++++++++++++++++++++++++++++++++++-
 fs/nfsd/nfs4xdr_gen.h                |  20 +-
 fs/nfsd/trace.h                      |   1 +
 include/linux/nfs4.h                 | 127 ---------
 include/linux/sunrpc/xdrgen/nfs4_1.h | 293 +++++++++++++++++++-
 include/uapi/linux/nfs4.h            |   2 -
 7 files changed, 1061 insertions(+), 141 deletions(-)

diff --git a/Documentation/sunrpc/xdr/nfs4_1.x b/Documentation/sunrpc/xdr/nfs4_1.x
index ca95150a3a29fc5418991bf2395326bd73645ea8..9e00910c02e0aecfb0f86ff7b534049d2c588cf3 100644
--- a/Documentation/sunrpc/xdr/nfs4_1.x
+++ b/Documentation/sunrpc/xdr/nfs4_1.x
@@ -45,13 +45,162 @@ pragma header nfs4;
 /*
  * Basic typedefs for RFC 1832 data type definitions
  */
-typedef hyper		int64_t;
-typedef unsigned int	uint32_t;
+typedef int                  int32_t;
+typedef unsigned int         uint32_t;
+typedef hyper                int64_t;
+typedef unsigned hyper       uint64_t;
+
+const NFS4_VERIFIER_SIZE        = 8;
+const NFS4_FHSIZE               = 128;
+
+enum nfsstat4 {
+ NFS4_OK                = 0,    /* everything is okay      */
+ NFS4ERR_PERM           = 1,    /* caller not privileged   */
+ NFS4ERR_NOENT          = 2,    /* no such file/directory  */
+ NFS4ERR_IO             = 5,    /* hard I/O error          */
+ NFS4ERR_NXIO           = 6,    /* no such device          */
+ NFS4ERR_ACCESS         = 13,   /* access denied           */
+ NFS4ERR_EXIST          = 17,   /* file already exists     */
+ NFS4ERR_XDEV           = 18,   /* different filesystems   */
+
+ /*
+  * Please do not allocate value 19; it was used in NFSv3
+  * and we do not want a value in NFSv3 to have a different
+  * meaning in NFSv4.x.
+  */
+
+ NFS4ERR_NOTDIR         = 20,   /* should be a directory   */
+ NFS4ERR_ISDIR          = 21,   /* should not be directory */
+ NFS4ERR_INVAL          = 22,   /* invalid argument        */
+ NFS4ERR_FBIG           = 27,   /* file exceeds server max */
+ NFS4ERR_NOSPC          = 28,   /* no space on filesystem  */
+ NFS4ERR_ROFS           = 30,   /* read-only filesystem    */
+ NFS4ERR_MLINK          = 31,   /* too many hard links     */
+ NFS4ERR_NAMETOOLONG    = 63,   /* name exceeds server max */
+ NFS4ERR_NOTEMPTY       = 66,   /* directory not empty     */
+ NFS4ERR_DQUOT          = 69,   /* hard quota limit reached*/
+ NFS4ERR_STALE          = 70,   /* file no longer exists   */
+ NFS4ERR_BADHANDLE      = 10001,/* Illegal filehandle      */
+ NFS4ERR_BAD_COOKIE     = 10003,/* READDIR cookie is stale */
+ NFS4ERR_NOTSUPP        = 10004,/* operation not supported */
+ NFS4ERR_TOOSMALL       = 10005,/* response limit exceeded */
+ NFS4ERR_SERVERFAULT    = 10006,/* undefined server error  */
+ NFS4ERR_BADTYPE        = 10007,/* type invalid for CREATE */
+ NFS4ERR_DELAY          = 10008,/* file "busy" - retry     */
+ NFS4ERR_SAME           = 10009,/* nverify says attrs same */
+ NFS4ERR_DENIED         = 10010,/* lock unavailable        */
+ NFS4ERR_EXPIRED        = 10011,/* lock lease expired      */
+ NFS4ERR_LOCKED         = 10012,/* I/O failed due to lock  */
+ NFS4ERR_GRACE          = 10013,/* in grace period         */
+ NFS4ERR_FHEXPIRED      = 10014,/* filehandle expired      */
+ NFS4ERR_SHARE_DENIED   = 10015,/* share reserve denied    */
+ NFS4ERR_WRONGSEC       = 10016,/* wrong security flavor   */
+ NFS4ERR_CLID_INUSE     = 10017,/* clientid in use         */
+
+ /* NFS4ERR_RESOURCE is not a valid error in NFSv4.1 */
+ NFS4ERR_RESOURCE       = 10018,/* resource exhaustion     */
+
+ NFS4ERR_MOVED          = 10019,/* filesystem relocated    */
+ NFS4ERR_NOFILEHANDLE   = 10020,/* current FH is not set   */
+ NFS4ERR_MINOR_VERS_MISMATCH= 10021,/* minor vers not supp */
+ NFS4ERR_STALE_CLIENTID = 10022,/* server has rebooted     */
+ NFS4ERR_STALE_STATEID  = 10023,/* server has rebooted     */
+ NFS4ERR_OLD_STATEID    = 10024,/* state is out of sync    */
+ NFS4ERR_BAD_STATEID    = 10025,/* incorrect stateid       */
+ NFS4ERR_BAD_SEQID      = 10026,/* request is out of seq.  */
+ NFS4ERR_NOT_SAME       = 10027,/* verify - attrs not same */
+ NFS4ERR_LOCK_RANGE     = 10028,/* overlapping lock range  */
+ NFS4ERR_SYMLINK        = 10029,/* should be file/directory*/
+ NFS4ERR_RESTOREFH      = 10030,/* no saved filehandle     */
+ NFS4ERR_LEASE_MOVED    = 10031,/* some filesystem moved   */
+ NFS4ERR_ATTRNOTSUPP    = 10032,/* recommended attr not sup*/
+ NFS4ERR_NO_GRACE       = 10033,/* reclaim outside of grace*/
+ NFS4ERR_RECLAIM_BAD    = 10034,/* reclaim error at server */
+ NFS4ERR_RECLAIM_CONFLICT= 10035,/* conflict on reclaim    */
+ NFS4ERR_BADXDR         = 10036,/* XDR decode failed       */
+ NFS4ERR_LOCKS_HELD     = 10037,/* file locks held at CLOSE*/
+ NFS4ERR_OPENMODE       = 10038,/* conflict in OPEN and I/O*/
+ NFS4ERR_BADOWNER       = 10039,/* owner translation bad   */
+ NFS4ERR_BADCHAR        = 10040,/* utf-8 char not supported*/
+ NFS4ERR_BADNAME        = 10041,/* name not supported      */
+ NFS4ERR_BAD_RANGE      = 10042,/* lock range not supported*/
+ NFS4ERR_LOCK_NOTSUPP   = 10043,/* no atomic up/downgrade  */
+ NFS4ERR_OP_ILLEGAL     = 10044,/* undefined operation     */
+ NFS4ERR_DEADLOCK       = 10045,/* file locking deadlock   */
+ NFS4ERR_FILE_OPEN      = 10046,/* open file blocks op.    */
+ NFS4ERR_ADMIN_REVOKED  = 10047,/* lockowner state revoked */
+ NFS4ERR_CB_PATH_DOWN   = 10048,/* callback path down      */
+
+ /* NFSv4.1 errors start here. */
+
+ NFS4ERR_BADIOMODE      = 10049,
+ NFS4ERR_BADLAYOUT      = 10050,
+ NFS4ERR_BAD_SESSION_DIGEST = 10051,
+ NFS4ERR_BADSESSION     = 10052,
+ NFS4ERR_BADSLOT        = 10053,
+ NFS4ERR_COMPLETE_ALREADY = 10054,
+ NFS4ERR_CONN_NOT_BOUND_TO_SESSION = 10055,
+ NFS4ERR_DELEG_ALREADY_WANTED = 10056,
+ NFS4ERR_BACK_CHAN_BUSY = 10057,/*backchan reqs outstanding*/
+ NFS4ERR_LAYOUTTRYLATER = 10058,
+ NFS4ERR_LAYOUTUNAVAILABLE = 10059,
+ NFS4ERR_NOMATCHING_LAYOUT = 10060,
+ NFS4ERR_RECALLCONFLICT = 10061,
+ NFS4ERR_UNKNOWN_LAYOUTTYPE = 10062,
+ NFS4ERR_SEQ_MISORDERED = 10063,/* unexpected seq.ID in req*/
+ NFS4ERR_SEQUENCE_POS   = 10064,/* [CB_]SEQ. op not 1st op */
+ NFS4ERR_REQ_TOO_BIG    = 10065,/* request too big         */
+ NFS4ERR_REP_TOO_BIG    = 10066,/* reply too big           */
+ NFS4ERR_REP_TOO_BIG_TO_CACHE =10067,/* rep. not all cached*/
+ NFS4ERR_RETRY_UNCACHED_REP =10068,/* retry & rep. uncached*/
+ NFS4ERR_UNSAFE_COMPOUND =10069,/* retry/recovery too hard */
+ NFS4ERR_TOO_MANY_OPS   = 10070,/*too many ops in [CB_]COMP*/
+ NFS4ERR_OP_NOT_IN_SESSION =10071,/* op needs [CB_]SEQ. op */
+ NFS4ERR_HASH_ALG_UNSUPP = 10072, /* hash alg. not supp.   */
+                                /* Error 10073 is unused.  */
+ NFS4ERR_CLIENTID_BUSY  = 10074,/* clientid has state      */
+ NFS4ERR_PNFS_IO_HOLE   = 10075,/* IO to _SPARSE file hole */
+ NFS4ERR_SEQ_FALSE_RETRY= 10076,/* Retry != original req.  */
+ NFS4ERR_BAD_HIGH_SLOT  = 10077,/* req has bad highest_slot*/
+ NFS4ERR_DEADSESSION    = 10078,/*new req sent to dead sess*/
+ NFS4ERR_ENCR_ALG_UNSUPP= 10079,/* encr alg. not supp.     */
+ NFS4ERR_PNFS_NO_LAYOUT = 10080,/* I/O without a layout    */
+ NFS4ERR_NOT_ONLY_OP    = 10081,/* addl ops not allowed    */
+ NFS4ERR_WRONG_CRED     = 10082,/* op done by wrong cred   */
+ NFS4ERR_WRONG_TYPE     = 10083,/* op on wrong type object */
+ NFS4ERR_DIRDELEG_UNAVAIL=10084,/* delegation not avail.   */
+ NFS4ERR_REJECT_DELEG   = 10085,/* cb rejected delegation  */
+ NFS4ERR_RETURNCONFLICT = 10086,/* layout get before return*/
+ NFS4ERR_DELEG_REVOKED  = 10087, /* deleg./layout revoked   */
+ NFS4ERR_PARTNER_NOTSUPP = 10088,
+ NFS4ERR_PARTNER_NO_AUTH = 10089,
+ NFS4ERR_UNION_NOTSUPP = 10090,
+ NFS4ERR_OFFLOAD_DENIED = 10091,
+ NFS4ERR_WRONG_LFS = 10092,
+ NFS4ERR_BADLABEL = 10093,
+ NFS4ERR_OFFLOAD_NO_REQS = 10094,
+ NFS4ERR_NOXATTR = 10095,
+ NFS4ERR_XATTR2BIG = 10096,
+
+ /* always set this to one more than the last one in the enum */
+ NFS4ERR_FIRST_FREE = 10097
+};
 
 /*
  * Basic data types
  */
+typedef opaque		attrlist4<>;
 typedef uint32_t	bitmap4<>;
+typedef uint64_t        nfs_cookie4;
+typedef opaque		nfs_fh4<NFS4_FHSIZE>;
+typedef opaque		utf8string<>;
+typedef utf8string      utf8str_cis;
+typedef utf8string      utf8str_cs;
+typedef utf8string      utf8str_mixed;
+typedef utf8str_cs      component4;
+typedef utf8str_cs      linktext4;
+typedef component4      pathname4<>;
+typedef opaque		verifier4[NFS4_VERIFIER_SIZE];
 
 /*
  * Timeval
@@ -61,6 +210,21 @@ struct nfstime4 {
 	uint32_t	nseconds;
 };
 
+/*
+ * File attribute container
+ */
+struct fattr4 {
+        bitmap4         attrmask;
+        attrlist4       attr_vals;
+};
+
+/*
+ * Stateid
+ */
+struct stateid4 {
+        uint32_t        seqid;
+        opaque          other[12];
+};
 
 /*
  * The following content was extracted from draft-ietf-nfsv4-delstid
@@ -184,3 +348,88 @@ enum open_delegation_type4 {
        OPEN_DELEGATE_READ_ATTRS_DELEG      = 4,
        OPEN_DELEGATE_WRITE_ATTRS_DELEG     = 5
 };
+
+/*
+ * Directory notification types.
+ */
+enum notify_type4 {
+        NOTIFY4_CHANGE_CHILD_ATTRS = 0,
+        NOTIFY4_CHANGE_DIR_ATTRS = 1,
+        NOTIFY4_REMOVE_ENTRY = 2,
+        NOTIFY4_ADD_ENTRY = 3,
+        NOTIFY4_RENAME_ENTRY = 4,
+        NOTIFY4_CHANGE_COOKIE_VERIFIER = 5
+};
+
+/* Changed entry information.  */
+struct notify_entry4 {
+        component4      ne_file;
+        fattr4          ne_attrs;
+};
+
+/* Previous entry information */
+struct prev_entry4 {
+        notify_entry4   pe_prev_entry;
+        /* what READDIR returned for this entry */
+        nfs_cookie4     pe_prev_entry_cookie;
+};
+
+struct notify_remove4 {
+        notify_entry4   nrm_old_entry;
+        nfs_cookie4     nrm_old_entry_cookie;
+};
+pragma public notify_remove4;
+
+struct notify_add4 {
+        /*
+         * Information on object
+         * possibly renamed over.
+         */
+        notify_remove4      nad_old_entry<1>;
+        notify_entry4       nad_new_entry;
+        /* what READDIR would have returned for this entry */
+        nfs_cookie4         nad_new_entry_cookie<1>;
+        prev_entry4         nad_prev_entry<1>;
+        bool                nad_last_entry;
+};
+pragma public notify_add4;
+
+struct notify_attr4 {
+        notify_entry4   na_changed_entry;
+};
+pragma public notify_attr4;
+
+struct notify_rename4 {
+        notify_remove4  nrn_old_entry;
+        notify_add4     nrn_new_entry;
+};
+pragma public notify_rename4;
+
+struct notify_verifier4 {
+        verifier4       nv_old_cookieverf;
+        verifier4       nv_new_cookieverf;
+};
+
+/*
+ * Objects of type notify_<>4 and
+ * notify_device_<>4 are encoded in this.
+ */
+typedef opaque notifylist4<>;
+
+struct notify4 {
+        /* composed from notify_type4 or notify_deviceid_type4 */
+        bitmap4         notify_mask;
+        notifylist4     notify_vals;
+};
+
+struct CB_NOTIFY4args {
+        stateid4    cna_stateid;
+        nfs_fh4     cna_fh;
+        notify4     cna_changes<>;
+};
+pragma public CB_NOTIFY4args;
+
+struct CB_NOTIFY4res {
+        nfsstat4    cnr_status;
+};
+pragma public CB_NOTIFY4res;
diff --git a/fs/nfsd/nfs4xdr_gen.c b/fs/nfsd/nfs4xdr_gen.c
index a17b5d8e60b3579caa2e2a8b40ed757070e1a622..306a4c30c3a4e6b9066c5ad41c1f0f7ffbb27bae 100644
--- a/fs/nfsd/nfs4xdr_gen.c
+++ b/fs/nfsd/nfs4xdr_gen.c
@@ -1,16 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0
 // Generated by xdrgen. Manual edits will be lost.
 // XDR specification file: ../../Documentation/sunrpc/xdr/nfs4_1.x
-// XDR specification modification time: Mon Oct 14 09:10:13 2024
+// XDR specification modification time: Wed Sep 24 09:38:03 2025
 
 #include <linux/sunrpc/svc.h>
 
 #include "nfs4xdr_gen.h"
 
 static bool __maybe_unused
-xdrgen_decode_int64_t(struct xdr_stream *xdr, int64_t *ptr)
+xdrgen_decode_int32_t(struct xdr_stream *xdr, int32_t *ptr)
 {
-	return xdrgen_decode_hyper(xdr, ptr);
+	return xdrgen_decode_int(xdr, ptr);
 };
 
 static bool __maybe_unused
@@ -19,6 +19,35 @@ xdrgen_decode_uint32_t(struct xdr_stream *xdr, uint32_t *ptr)
 	return xdrgen_decode_unsigned_int(xdr, ptr);
 };
 
+static bool __maybe_unused
+xdrgen_decode_int64_t(struct xdr_stream *xdr, int64_t *ptr)
+{
+	return xdrgen_decode_hyper(xdr, ptr);
+};
+
+static bool __maybe_unused
+xdrgen_decode_uint64_t(struct xdr_stream *xdr, uint64_t *ptr)
+{
+	return xdrgen_decode_unsigned_hyper(xdr, ptr);
+};
+
+static bool __maybe_unused
+xdrgen_decode_nfsstat4(struct xdr_stream *xdr, nfsstat4 *ptr)
+{
+	u32 val;
+
+	if (xdr_stream_decode_u32(xdr, &val) < 0)
+		return false;
+	*ptr = val;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_attrlist4(struct xdr_stream *xdr, attrlist4 *ptr)
+{
+	return xdrgen_decode_opaque(xdr, ptr, 0);
+};
+
 static bool __maybe_unused
 xdrgen_decode_bitmap4(struct xdr_stream *xdr, bitmap4 *ptr)
 {
@@ -30,6 +59,71 @@ xdrgen_decode_bitmap4(struct xdr_stream *xdr, bitmap4 *ptr)
 	return true;
 };
 
+static bool __maybe_unused
+xdrgen_decode_nfs_cookie4(struct xdr_stream *xdr, nfs_cookie4 *ptr)
+{
+	return xdrgen_decode_uint64_t(xdr, ptr);
+};
+
+static bool __maybe_unused
+xdrgen_decode_nfs_fh4(struct xdr_stream *xdr, nfs_fh4 *ptr)
+{
+	return xdrgen_decode_opaque(xdr, ptr, NFS4_FHSIZE);
+};
+
+static bool __maybe_unused
+xdrgen_decode_utf8string(struct xdr_stream *xdr, utf8string *ptr)
+{
+	return xdrgen_decode_opaque(xdr, ptr, 0);
+};
+
+static bool __maybe_unused
+xdrgen_decode_utf8str_cis(struct xdr_stream *xdr, utf8str_cis *ptr)
+{
+	return xdrgen_decode_utf8string(xdr, ptr);
+};
+
+static bool __maybe_unused
+xdrgen_decode_utf8str_cs(struct xdr_stream *xdr, utf8str_cs *ptr)
+{
+	return xdrgen_decode_utf8string(xdr, ptr);
+};
+
+static bool __maybe_unused
+xdrgen_decode_utf8str_mixed(struct xdr_stream *xdr, utf8str_mixed *ptr)
+{
+	return xdrgen_decode_utf8string(xdr, ptr);
+};
+
+static bool __maybe_unused
+xdrgen_decode_component4(struct xdr_stream *xdr, component4 *ptr)
+{
+	return xdrgen_decode_utf8str_cs(xdr, ptr);
+};
+
+static bool __maybe_unused
+xdrgen_decode_linktext4(struct xdr_stream *xdr, linktext4 *ptr)
+{
+	return xdrgen_decode_utf8str_cs(xdr, ptr);
+};
+
+static bool __maybe_unused
+xdrgen_decode_pathname4(struct xdr_stream *xdr, pathname4 *ptr)
+{
+	if (xdr_stream_decode_u32(xdr, &ptr->count) < 0)
+		return false;
+	for (u32 i = 0; i < ptr->count; i++)
+		if (!xdrgen_decode_component4(xdr, &ptr->element[i]))
+			return false;
+	return true;
+};
+
+static bool __maybe_unused
+xdrgen_decode_verifier4(struct xdr_stream *xdr, verifier4 *ptr)
+{
+	return xdr_stream_decode_opaque_fixed(xdr, ptr, NFS4_VERIFIER_SIZE) == 0;
+};
+
 static bool __maybe_unused
 xdrgen_decode_nfstime4(struct xdr_stream *xdr, struct nfstime4 *ptr)
 {
@@ -40,6 +134,26 @@ xdrgen_decode_nfstime4(struct xdr_stream *xdr, struct nfstime4 *ptr)
 	return true;
 };
 
+static bool __maybe_unused
+xdrgen_decode_fattr4(struct xdr_stream *xdr, struct fattr4 *ptr)
+{
+	if (!xdrgen_decode_bitmap4(xdr, &ptr->attrmask))
+		return false;
+	if (!xdrgen_decode_attrlist4(xdr, &ptr->attr_vals))
+		return false;
+	return true;
+};
+
+static bool __maybe_unused
+xdrgen_decode_stateid4(struct xdr_stream *xdr, struct stateid4 *ptr)
+{
+	if (!xdrgen_decode_uint32_t(xdr, &ptr->seqid))
+		return false;
+	if (xdr_stream_decode_opaque_fixed(xdr, ptr->other, 12) < 0)
+		return false;
+	return true;
+};
+
 static bool __maybe_unused
 xdrgen_decode_fattr4_offline(struct xdr_stream *xdr, fattr4_offline *ptr)
 {
@@ -147,9 +261,148 @@ xdrgen_decode_open_delegation_type4(struct xdr_stream *xdr, open_delegation_type
 }
 
 static bool __maybe_unused
-xdrgen_encode_int64_t(struct xdr_stream *xdr, const int64_t value)
+xdrgen_decode_notify_type4(struct xdr_stream *xdr, notify_type4 *ptr)
 {
-	return xdrgen_encode_hyper(xdr, value);
+	u32 val;
+
+	if (xdr_stream_decode_u32(xdr, &val) < 0)
+		return false;
+	*ptr = val;
+	return true;
+}
+
+static bool __maybe_unused
+xdrgen_decode_notify_entry4(struct xdr_stream *xdr, struct notify_entry4 *ptr)
+{
+	if (!xdrgen_decode_component4(xdr, &ptr->ne_file))
+		return false;
+	if (!xdrgen_decode_fattr4(xdr, &ptr->ne_attrs))
+		return false;
+	return true;
+};
+
+static bool __maybe_unused
+xdrgen_decode_prev_entry4(struct xdr_stream *xdr, struct prev_entry4 *ptr)
+{
+	if (!xdrgen_decode_notify_entry4(xdr, &ptr->pe_prev_entry))
+		return false;
+	if (!xdrgen_decode_nfs_cookie4(xdr, &ptr->pe_prev_entry_cookie))
+		return false;
+	return true;
+};
+
+bool
+xdrgen_decode_notify_remove4(struct xdr_stream *xdr, struct notify_remove4 *ptr)
+{
+	if (!xdrgen_decode_notify_entry4(xdr, &ptr->nrm_old_entry))
+		return false;
+	if (!xdrgen_decode_nfs_cookie4(xdr, &ptr->nrm_old_entry_cookie))
+		return false;
+	return true;
+};
+
+bool
+xdrgen_decode_notify_add4(struct xdr_stream *xdr, struct notify_add4 *ptr)
+{
+	if (xdr_stream_decode_u32(xdr, &ptr->nad_old_entry.count) < 0)
+		return false;
+	if (ptr->nad_old_entry.count > 1)
+		return false;
+	for (u32 i = 0; i < ptr->nad_old_entry.count; i++)
+		if (!xdrgen_decode_notify_remove4(xdr, &ptr->nad_old_entry.element[i]))
+			return false;
+	if (!xdrgen_decode_notify_entry4(xdr, &ptr->nad_new_entry))
+		return false;
+	if (xdr_stream_decode_u32(xdr, &ptr->nad_new_entry_cookie.count) < 0)
+		return false;
+	if (ptr->nad_new_entry_cookie.count > 1)
+		return false;
+	for (u32 i = 0; i < ptr->nad_new_entry_cookie.count; i++)
+		if (!xdrgen_decode_nfs_cookie4(xdr, &ptr->nad_new_entry_cookie.element[i]))
+			return false;
+	if (xdr_stream_decode_u32(xdr, &ptr->nad_prev_entry.count) < 0)
+		return false;
+	if (ptr->nad_prev_entry.count > 1)
+		return false;
+	for (u32 i = 0; i < ptr->nad_prev_entry.count; i++)
+		if (!xdrgen_decode_prev_entry4(xdr, &ptr->nad_prev_entry.element[i]))
+			return false;
+	if (!xdrgen_decode_bool(xdr, &ptr->nad_last_entry))
+		return false;
+	return true;
+};
+
+bool
+xdrgen_decode_notify_attr4(struct xdr_stream *xdr, struct notify_attr4 *ptr)
+{
+	if (!xdrgen_decode_notify_entry4(xdr, &ptr->na_changed_entry))
+		return false;
+	return true;
+};
+
+bool
+xdrgen_decode_notify_rename4(struct xdr_stream *xdr, struct notify_rename4 *ptr)
+{
+	if (!xdrgen_decode_notify_remove4(xdr, &ptr->nrn_old_entry))
+		return false;
+	if (!xdrgen_decode_notify_add4(xdr, &ptr->nrn_new_entry))
+		return false;
+	return true;
+};
+
+static bool __maybe_unused
+xdrgen_decode_notify_verifier4(struct xdr_stream *xdr, struct notify_verifier4 *ptr)
+{
+	if (!xdrgen_decode_verifier4(xdr, &ptr->nv_old_cookieverf))
+		return false;
+	if (!xdrgen_decode_verifier4(xdr, &ptr->nv_new_cookieverf))
+		return false;
+	return true;
+};
+
+static bool __maybe_unused
+xdrgen_decode_notifylist4(struct xdr_stream *xdr, notifylist4 *ptr)
+{
+	return xdrgen_decode_opaque(xdr, ptr, 0);
+};
+
+static bool __maybe_unused
+xdrgen_decode_notify4(struct xdr_stream *xdr, struct notify4 *ptr)
+{
+	if (!xdrgen_decode_bitmap4(xdr, &ptr->notify_mask))
+		return false;
+	if (!xdrgen_decode_notifylist4(xdr, &ptr->notify_vals))
+		return false;
+	return true;
+};
+
+bool
+xdrgen_decode_CB_NOTIFY4args(struct xdr_stream *xdr, struct CB_NOTIFY4args *ptr)
+{
+	if (!xdrgen_decode_stateid4(xdr, &ptr->cna_stateid))
+		return false;
+	if (!xdrgen_decode_nfs_fh4(xdr, &ptr->cna_fh))
+		return false;
+	if (xdr_stream_decode_u32(xdr, &ptr->cna_changes.count) < 0)
+		return false;
+	for (u32 i = 0; i < ptr->cna_changes.count; i++)
+		if (!xdrgen_decode_notify4(xdr, &ptr->cna_changes.element[i]))
+			return false;
+	return true;
+};
+
+bool
+xdrgen_decode_CB_NOTIFY4res(struct xdr_stream *xdr, struct CB_NOTIFY4res *ptr)
+{
+	if (!xdrgen_decode_nfsstat4(xdr, &ptr->cnr_status))
+		return false;
+	return true;
+};
+
+static bool __maybe_unused
+xdrgen_encode_int32_t(struct xdr_stream *xdr, const int32_t value)
+{
+	return xdrgen_encode_int(xdr, value);
 };
 
 static bool __maybe_unused
@@ -158,6 +411,30 @@ xdrgen_encode_uint32_t(struct xdr_stream *xdr, const uint32_t value)
 	return xdrgen_encode_unsigned_int(xdr, value);
 };
 
+static bool __maybe_unused
+xdrgen_encode_int64_t(struct xdr_stream *xdr, const int64_t value)
+{
+	return xdrgen_encode_hyper(xdr, value);
+};
+
+static bool __maybe_unused
+xdrgen_encode_uint64_t(struct xdr_stream *xdr, const uint64_t value)
+{
+	return xdrgen_encode_unsigned_hyper(xdr, value);
+};
+
+static bool __maybe_unused
+xdrgen_encode_nfsstat4(struct xdr_stream *xdr, nfsstat4 value)
+{
+	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
+}
+
+static bool __maybe_unused
+xdrgen_encode_attrlist4(struct xdr_stream *xdr, const attrlist4 value)
+{
+	return xdr_stream_encode_opaque(xdr, value.data, value.len) >= 0;
+};
+
 static bool __maybe_unused
 xdrgen_encode_bitmap4(struct xdr_stream *xdr, const bitmap4 value)
 {
@@ -169,6 +446,71 @@ xdrgen_encode_bitmap4(struct xdr_stream *xdr, const bitmap4 value)
 	return true;
 };
 
+static bool __maybe_unused
+xdrgen_encode_nfs_cookie4(struct xdr_stream *xdr, const nfs_cookie4 value)
+{
+	return xdrgen_encode_uint64_t(xdr, value);
+};
+
+static bool __maybe_unused
+xdrgen_encode_nfs_fh4(struct xdr_stream *xdr, const nfs_fh4 value)
+{
+	return xdr_stream_encode_opaque(xdr, value.data, value.len) >= 0;
+};
+
+static bool __maybe_unused
+xdrgen_encode_utf8string(struct xdr_stream *xdr, const utf8string value)
+{
+	return xdr_stream_encode_opaque(xdr, value.data, value.len) >= 0;
+};
+
+static bool __maybe_unused
+xdrgen_encode_utf8str_cis(struct xdr_stream *xdr, const utf8str_cis value)
+{
+	return xdrgen_encode_utf8string(xdr, value);
+};
+
+static bool __maybe_unused
+xdrgen_encode_utf8str_cs(struct xdr_stream *xdr, const utf8str_cs value)
+{
+	return xdrgen_encode_utf8string(xdr, value);
+};
+
+static bool __maybe_unused
+xdrgen_encode_utf8str_mixed(struct xdr_stream *xdr, const utf8str_mixed value)
+{
+	return xdrgen_encode_utf8string(xdr, value);
+};
+
+static bool __maybe_unused
+xdrgen_encode_component4(struct xdr_stream *xdr, const component4 value)
+{
+	return xdrgen_encode_utf8str_cs(xdr, value);
+};
+
+static bool __maybe_unused
+xdrgen_encode_linktext4(struct xdr_stream *xdr, const linktext4 value)
+{
+	return xdrgen_encode_utf8str_cs(xdr, value);
+};
+
+static bool __maybe_unused
+xdrgen_encode_pathname4(struct xdr_stream *xdr, const pathname4 value)
+{
+	if (xdr_stream_encode_u32(xdr, value.count) != XDR_UNIT)
+		return false;
+	for (u32 i = 0; i < value.count; i++)
+		if (!xdrgen_encode_component4(xdr, value.element[i]))
+			return false;
+	return true;
+};
+
+static bool __maybe_unused
+xdrgen_encode_verifier4(struct xdr_stream *xdr, const verifier4 value)
+{
+	return xdr_stream_encode_opaque_fixed(xdr, value, NFS4_VERIFIER_SIZE) >= 0;
+};
+
 static bool __maybe_unused
 xdrgen_encode_nfstime4(struct xdr_stream *xdr, const struct nfstime4 *value)
 {
@@ -179,6 +521,26 @@ xdrgen_encode_nfstime4(struct xdr_stream *xdr, const struct nfstime4 *value)
 	return true;
 };
 
+static bool __maybe_unused
+xdrgen_encode_fattr4(struct xdr_stream *xdr, const struct fattr4 *value)
+{
+	if (!xdrgen_encode_bitmap4(xdr, value->attrmask))
+		return false;
+	if (!xdrgen_encode_attrlist4(xdr, value->attr_vals))
+		return false;
+	return true;
+};
+
+static bool __maybe_unused
+xdrgen_encode_stateid4(struct xdr_stream *xdr, const struct stateid4 *value)
+{
+	if (!xdrgen_encode_uint32_t(xdr, value->seqid))
+		return false;
+	if (xdr_stream_encode_opaque_fixed(xdr, value->other, 12) < 0)
+		return false;
+	return true;
+};
+
 static bool __maybe_unused
 xdrgen_encode_fattr4_offline(struct xdr_stream *xdr, const fattr4_offline value)
 {
@@ -254,3 +616,137 @@ xdrgen_encode_open_delegation_type4(struct xdr_stream *xdr, open_delegation_type
 {
 	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
 }
+
+static bool __maybe_unused
+xdrgen_encode_notify_type4(struct xdr_stream *xdr, notify_type4 value)
+{
+	return xdr_stream_encode_u32(xdr, value) == XDR_UNIT;
+}
+
+static bool __maybe_unused
+xdrgen_encode_notify_entry4(struct xdr_stream *xdr, const struct notify_entry4 *value)
+{
+	if (!xdrgen_encode_component4(xdr, value->ne_file))
+		return false;
+	if (!xdrgen_encode_fattr4(xdr, &value->ne_attrs))
+		return false;
+	return true;
+};
+
+static bool __maybe_unused
+xdrgen_encode_prev_entry4(struct xdr_stream *xdr, const struct prev_entry4 *value)
+{
+	if (!xdrgen_encode_notify_entry4(xdr, &value->pe_prev_entry))
+		return false;
+	if (!xdrgen_encode_nfs_cookie4(xdr, value->pe_prev_entry_cookie))
+		return false;
+	return true;
+};
+
+bool
+xdrgen_encode_notify_remove4(struct xdr_stream *xdr, const struct notify_remove4 *value)
+{
+	if (!xdrgen_encode_notify_entry4(xdr, &value->nrm_old_entry))
+		return false;
+	if (!xdrgen_encode_nfs_cookie4(xdr, value->nrm_old_entry_cookie))
+		return false;
+	return true;
+};
+
+bool
+xdrgen_encode_notify_add4(struct xdr_stream *xdr, const struct notify_add4 *value)
+{
+	if (value->nad_old_entry.count > 1)
+		return false;
+	if (xdr_stream_encode_u32(xdr, value->nad_old_entry.count) != XDR_UNIT)
+		return false;
+	for (u32 i = 0; i < value->nad_old_entry.count; i++)
+		if (!xdrgen_encode_notify_remove4(xdr, &value->nad_old_entry.element[i]))
+			return false;
+	if (!xdrgen_encode_notify_entry4(xdr, &value->nad_new_entry))
+		return false;
+	if (value->nad_new_entry_cookie.count > 1)
+		return false;
+	if (xdr_stream_encode_u32(xdr, value->nad_new_entry_cookie.count) != XDR_UNIT)
+		return false;
+	for (u32 i = 0; i < value->nad_new_entry_cookie.count; i++)
+		if (!xdrgen_encode_nfs_cookie4(xdr, value->nad_new_entry_cookie.element[i]))
+			return false;
+	if (value->nad_prev_entry.count > 1)
+		return false;
+	if (xdr_stream_encode_u32(xdr, value->nad_prev_entry.count) != XDR_UNIT)
+		return false;
+	for (u32 i = 0; i < value->nad_prev_entry.count; i++)
+		if (!xdrgen_encode_prev_entry4(xdr, &value->nad_prev_entry.element[i]))
+			return false;
+	if (!xdrgen_encode_bool(xdr, value->nad_last_entry))
+		return false;
+	return true;
+};
+
+bool
+xdrgen_encode_notify_attr4(struct xdr_stream *xdr, const struct notify_attr4 *value)
+{
+	if (!xdrgen_encode_notify_entry4(xdr, &value->na_changed_entry))
+		return false;
+	return true;
+};
+
+bool
+xdrgen_encode_notify_rename4(struct xdr_stream *xdr, const struct notify_rename4 *value)
+{
+	if (!xdrgen_encode_notify_remove4(xdr, &value->nrn_old_entry))
+		return false;
+	if (!xdrgen_encode_notify_add4(xdr, &value->nrn_new_entry))
+		return false;
+	return true;
+};
+
+static bool __maybe_unused
+xdrgen_encode_notify_verifier4(struct xdr_stream *xdr, const struct notify_verifier4 *value)
+{
+	if (!xdrgen_encode_verifier4(xdr, value->nv_old_cookieverf))
+		return false;
+	if (!xdrgen_encode_verifier4(xdr, value->nv_new_cookieverf))
+		return false;
+	return true;
+};
+
+static bool __maybe_unused
+xdrgen_encode_notifylist4(struct xdr_stream *xdr, const notifylist4 value)
+{
+	return xdr_stream_encode_opaque(xdr, value.data, value.len) >= 0;
+};
+
+static bool __maybe_unused
+xdrgen_encode_notify4(struct xdr_stream *xdr, const struct notify4 *value)
+{
+	if (!xdrgen_encode_bitmap4(xdr, value->notify_mask))
+		return false;
+	if (!xdrgen_encode_notifylist4(xdr, value->notify_vals))
+		return false;
+	return true;
+};
+
+bool
+xdrgen_encode_CB_NOTIFY4args(struct xdr_stream *xdr, const struct CB_NOTIFY4args *value)
+{
+	if (!xdrgen_encode_stateid4(xdr, &value->cna_stateid))
+		return false;
+	if (!xdrgen_encode_nfs_fh4(xdr, value->cna_fh))
+		return false;
+	if (xdr_stream_encode_u32(xdr, value->cna_changes.count) != XDR_UNIT)
+		return false;
+	for (u32 i = 0; i < value->cna_changes.count; i++)
+		if (!xdrgen_encode_notify4(xdr, &value->cna_changes.element[i]))
+			return false;
+	return true;
+};
+
+bool
+xdrgen_encode_CB_NOTIFY4res(struct xdr_stream *xdr, const struct CB_NOTIFY4res *value)
+{
+	if (!xdrgen_encode_nfsstat4(xdr, value->cnr_status))
+		return false;
+	return true;
+};
diff --git a/fs/nfsd/nfs4xdr_gen.h b/fs/nfsd/nfs4xdr_gen.h
index 41a0033b72562ee3c1fcdcd4a887ce635385b22b..e8f8dd65d58a23f39d432bed02ac21cb0640261f 100644
--- a/fs/nfsd/nfs4xdr_gen.h
+++ b/fs/nfsd/nfs4xdr_gen.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Generated by xdrgen. Manual edits will be lost. */
 /* XDR specification file: ../../Documentation/sunrpc/xdr/nfs4_1.x */
-/* XDR specification modification time: Mon Oct 14 09:10:13 2024 */
+/* XDR specification modification time: Wed Sep 24 09:38:03 2025 */
 
 #ifndef _LINUX_XDRGEN_NFS4_1_DECL_H
 #define _LINUX_XDRGEN_NFS4_1_DECL_H
@@ -22,4 +22,22 @@ bool xdrgen_encode_fattr4_time_deleg_access(struct xdr_stream *xdr, const fattr4
 bool xdrgen_decode_fattr4_time_deleg_modify(struct xdr_stream *xdr, fattr4_time_deleg_modify *ptr);
 bool xdrgen_encode_fattr4_time_deleg_modify(struct xdr_stream *xdr, const fattr4_time_deleg_modify *value);
 
+bool xdrgen_decode_notify_remove4(struct xdr_stream *xdr, struct notify_remove4 *ptr);
+bool xdrgen_encode_notify_remove4(struct xdr_stream *xdr, const struct notify_remove4 *value);
+
+bool xdrgen_decode_notify_add4(struct xdr_stream *xdr, struct notify_add4 *ptr);
+bool xdrgen_encode_notify_add4(struct xdr_stream *xdr, const struct notify_add4 *value);
+
+bool xdrgen_decode_notify_attr4(struct xdr_stream *xdr, struct notify_attr4 *ptr);
+bool xdrgen_encode_notify_attr4(struct xdr_stream *xdr, const struct notify_attr4 *value);
+
+bool xdrgen_decode_notify_rename4(struct xdr_stream *xdr, struct notify_rename4 *ptr);
+bool xdrgen_encode_notify_rename4(struct xdr_stream *xdr, const struct notify_rename4 *value);
+
+bool xdrgen_decode_CB_NOTIFY4args(struct xdr_stream *xdr, struct CB_NOTIFY4args *ptr);
+bool xdrgen_encode_CB_NOTIFY4args(struct xdr_stream *xdr, const struct CB_NOTIFY4args *value);
+
+bool xdrgen_decode_CB_NOTIFY4res(struct xdr_stream *xdr, struct CB_NOTIFY4res *ptr);
+bool xdrgen_encode_CB_NOTIFY4res(struct xdr_stream *xdr, const struct CB_NOTIFY4res *value);
+
 #endif /* _LINUX_XDRGEN_NFS4_1_DECL_H */
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index a664fdf1161e9afe9de59d4edd91762400a99350..01380425347b946bbf5a70a2ba10190ae4ec6303 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1611,6 +1611,7 @@ TRACE_EVENT(nfsd_cb_setup_err,
 		{ OP_CB_RECALL,			"CB_RECALL" },		\
 		{ OP_CB_LAYOUTRECALL,		"CB_LAYOUTRECALL" },	\
 		{ OP_CB_RECALL_ANY,		"CB_RECALL_ANY" },	\
+		{ OP_CB_NOTIFY,			"CB_NOTIFY" },		\
 		{ OP_CB_NOTIFY_LOCK,		"CB_NOTIFY_LOCK" },	\
 		{ OP_CB_OFFLOAD,		"CB_OFFLOAD" })
 
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index e947af6a3684a4ae4abedbc56ff1811d15c23f3c..25bf410edec8ffde0508b33648af55d62594ad73 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -171,133 +171,6 @@ Needs to be updated if more operations are defined in future.*/
 #define LAST_NFS42_OP	OP_REMOVEXATTR
 #define LAST_NFS4_OP	LAST_NFS42_OP
 
-enum nfsstat4 {
-	NFS4_OK = 0,
-	NFS4ERR_PERM = 1,
-	NFS4ERR_NOENT = 2,
-	NFS4ERR_IO = 5,
-	NFS4ERR_NXIO = 6,
-	NFS4ERR_ACCESS = 13,
-	NFS4ERR_EXIST = 17,
-	NFS4ERR_XDEV = 18,
-	/* Unused/reserved 19 */
-	NFS4ERR_NOTDIR = 20,
-	NFS4ERR_ISDIR = 21,
-	NFS4ERR_INVAL = 22,
-	NFS4ERR_FBIG = 27,
-	NFS4ERR_NOSPC = 28,
-	NFS4ERR_ROFS = 30,
-	NFS4ERR_MLINK = 31,
-	NFS4ERR_NAMETOOLONG = 63,
-	NFS4ERR_NOTEMPTY = 66,
-	NFS4ERR_DQUOT = 69,
-	NFS4ERR_STALE = 70,
-	NFS4ERR_BADHANDLE = 10001,
-	NFS4ERR_BAD_COOKIE = 10003,
-	NFS4ERR_NOTSUPP = 10004,
-	NFS4ERR_TOOSMALL = 10005,
-	NFS4ERR_SERVERFAULT = 10006,
-	NFS4ERR_BADTYPE = 10007,
-	NFS4ERR_DELAY = 10008,
-	NFS4ERR_SAME = 10009,
-	NFS4ERR_DENIED = 10010,
-	NFS4ERR_EXPIRED = 10011,
-	NFS4ERR_LOCKED = 10012,
-	NFS4ERR_GRACE = 10013,
-	NFS4ERR_FHEXPIRED = 10014,
-	NFS4ERR_SHARE_DENIED = 10015,
-	NFS4ERR_WRONGSEC = 10016,
-	NFS4ERR_CLID_INUSE = 10017,
-	NFS4ERR_RESOURCE = 10018,
-	NFS4ERR_MOVED = 10019,
-	NFS4ERR_NOFILEHANDLE = 10020,
-	NFS4ERR_MINOR_VERS_MISMATCH = 10021,
-	NFS4ERR_STALE_CLIENTID = 10022,
-	NFS4ERR_STALE_STATEID = 10023,
-	NFS4ERR_OLD_STATEID = 10024,
-	NFS4ERR_BAD_STATEID = 10025,
-	NFS4ERR_BAD_SEQID = 10026,
-	NFS4ERR_NOT_SAME = 10027,
-	NFS4ERR_LOCK_RANGE = 10028,
-	NFS4ERR_SYMLINK = 10029,
-	NFS4ERR_RESTOREFH = 10030,
-	NFS4ERR_LEASE_MOVED = 10031,
-	NFS4ERR_ATTRNOTSUPP = 10032,
-	NFS4ERR_NO_GRACE = 10033,
-	NFS4ERR_RECLAIM_BAD = 10034,
-	NFS4ERR_RECLAIM_CONFLICT = 10035,
-	NFS4ERR_BADXDR = 10036,
-	NFS4ERR_LOCKS_HELD = 10037,
-	NFS4ERR_OPENMODE = 10038,
-	NFS4ERR_BADOWNER = 10039,
-	NFS4ERR_BADCHAR = 10040,
-	NFS4ERR_BADNAME = 10041,
-	NFS4ERR_BAD_RANGE = 10042,
-	NFS4ERR_LOCK_NOTSUPP = 10043,
-	NFS4ERR_OP_ILLEGAL = 10044,
-	NFS4ERR_DEADLOCK = 10045,
-	NFS4ERR_FILE_OPEN = 10046,
-	NFS4ERR_ADMIN_REVOKED = 10047,
-	NFS4ERR_CB_PATH_DOWN = 10048,
-
-	/* nfs41 */
-	NFS4ERR_BADIOMODE	= 10049,
-	NFS4ERR_BADLAYOUT	= 10050,
-	NFS4ERR_BAD_SESSION_DIGEST = 10051,
-	NFS4ERR_BADSESSION	= 10052,
-	NFS4ERR_BADSLOT		= 10053,
-	NFS4ERR_COMPLETE_ALREADY = 10054,
-	NFS4ERR_CONN_NOT_BOUND_TO_SESSION = 10055,
-	NFS4ERR_DELEG_ALREADY_WANTED = 10056,
-	NFS4ERR_BACK_CHAN_BUSY	= 10057,	/* backchan reqs outstanding */
-	NFS4ERR_LAYOUTTRYLATER	= 10058,
-	NFS4ERR_LAYOUTUNAVAILABLE = 10059,
-	NFS4ERR_NOMATCHING_LAYOUT = 10060,
-	NFS4ERR_RECALLCONFLICT	= 10061,
-	NFS4ERR_UNKNOWN_LAYOUTTYPE = 10062,
-	NFS4ERR_SEQ_MISORDERED = 10063, 	/* unexpected seq.id in req */
-	NFS4ERR_SEQUENCE_POS	= 10064,	/* [CB_]SEQ. op not 1st op */
-	NFS4ERR_REQ_TOO_BIG	= 10065,	/* request too big */
-	NFS4ERR_REP_TOO_BIG	= 10066,	/* reply too big */
-	NFS4ERR_REP_TOO_BIG_TO_CACHE = 10067,	/* rep. not all cached */
-	NFS4ERR_RETRY_UNCACHED_REP = 10068,	/* retry & rep. uncached */
-	NFS4ERR_UNSAFE_COMPOUND = 10069,	/* retry/recovery too hard */
-	NFS4ERR_TOO_MANY_OPS	= 10070,	/* too many ops in [CB_]COMP */
-	NFS4ERR_OP_NOT_IN_SESSION = 10071,	/* op needs [CB_]SEQ. op */
-	NFS4ERR_HASH_ALG_UNSUPP = 10072,	/* hash alg. not supp. */
-						/* Error 10073 is unused. */
-	NFS4ERR_CLIENTID_BUSY	= 10074,	/* clientid has state */
-	NFS4ERR_PNFS_IO_HOLE	= 10075,	/* IO to _SPARSE file hole */
-	NFS4ERR_SEQ_FALSE_RETRY	= 10076,	/* retry not original */
-	NFS4ERR_BAD_HIGH_SLOT	= 10077,	/* sequence arg bad */
-	NFS4ERR_DEADSESSION	= 10078,	/* persistent session dead */
-	NFS4ERR_ENCR_ALG_UNSUPP = 10079,	/* SSV alg mismatch */
-	NFS4ERR_PNFS_NO_LAYOUT	= 10080,	/* direct I/O with no layout */
-	NFS4ERR_NOT_ONLY_OP	= 10081,	/* bad compound */
-	NFS4ERR_WRONG_CRED	= 10082,	/* permissions:state change */
-	NFS4ERR_WRONG_TYPE	= 10083,	/* current operation mismatch */
-	NFS4ERR_DIRDELEG_UNAVAIL = 10084,	/* no directory delegation */
-	NFS4ERR_REJECT_DELEG	= 10085,	/* on callback */
-	NFS4ERR_RETURNCONFLICT	= 10086,	/* outstanding layoutreturn */
-	NFS4ERR_DELEG_REVOKED	= 10087,	/* deleg./layout revoked */
-
-	/* nfs42 */
-	NFS4ERR_PARTNER_NOTSUPP	= 10088,
-	NFS4ERR_PARTNER_NO_AUTH	= 10089,
-	NFS4ERR_UNION_NOTSUPP	= 10090,
-	NFS4ERR_OFFLOAD_DENIED	= 10091,
-	NFS4ERR_WRONG_LFS	= 10092,
-	NFS4ERR_BADLABEL	= 10093,
-	NFS4ERR_OFFLOAD_NO_REQS	= 10094,
-
-	/* xattr (RFC8276) */
-	NFS4ERR_NOXATTR		= 10095,
-	NFS4ERR_XATTR2BIG	= 10096,
-
-	/* can be used for internal errors */
-	NFS4ERR_FIRST_FREE
-};
-
 /* error codes for internal client use */
 #define NFS4ERR_RESET_TO_MDS   12001
 #define NFS4ERR_RESET_TO_PNFS  12002
diff --git a/include/linux/sunrpc/xdrgen/nfs4_1.h b/include/linux/sunrpc/xdrgen/nfs4_1.h
index cf21a14aa8850f4b21cd365cb7bc22a02c6097ce..7d9f4c5f169bc47ddf31ff5b1b96db30329e8ad2 100644
--- a/include/linux/sunrpc/xdrgen/nfs4_1.h
+++ b/include/linux/sunrpc/xdrgen/nfs4_1.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Generated by xdrgen. Manual edits will be lost. */
 /* XDR specification file: ../../Documentation/sunrpc/xdr/nfs4_1.x */
-/* XDR specification modification time: Mon Oct 14 09:10:13 2024 */
+/* XDR specification modification time: Wed Sep 24 09:38:03 2025 */
 
 #ifndef _LINUX_XDRGEN_NFS4_1_DEF_H
 #define _LINUX_XDRGEN_NFS4_1_DEF_H
@@ -9,20 +9,181 @@
 #include <linux/types.h>
 #include <linux/sunrpc/xdrgen/_defs.h>
 
-typedef s64 int64_t;
+typedef s32 int32_t;
 
 typedef u32 uint32_t;
 
+typedef s64 int64_t;
+
+typedef u64 uint64_t;
+
+enum { NFS4_VERIFIER_SIZE = 8 };
+
+enum { NFS4_FHSIZE = 128 };
+
+enum nfsstat4 {
+	NFS4_OK = 0,
+	NFS4ERR_PERM = 1,
+	NFS4ERR_NOENT = 2,
+	NFS4ERR_IO = 5,
+	NFS4ERR_NXIO = 6,
+	NFS4ERR_ACCESS = 13,
+	NFS4ERR_EXIST = 17,
+	NFS4ERR_XDEV = 18,
+	NFS4ERR_NOTDIR = 20,
+	NFS4ERR_ISDIR = 21,
+	NFS4ERR_INVAL = 22,
+	NFS4ERR_FBIG = 27,
+	NFS4ERR_NOSPC = 28,
+	NFS4ERR_ROFS = 30,
+	NFS4ERR_MLINK = 31,
+	NFS4ERR_NAMETOOLONG = 63,
+	NFS4ERR_NOTEMPTY = 66,
+	NFS4ERR_DQUOT = 69,
+	NFS4ERR_STALE = 70,
+	NFS4ERR_BADHANDLE = 10001,
+	NFS4ERR_BAD_COOKIE = 10003,
+	NFS4ERR_NOTSUPP = 10004,
+	NFS4ERR_TOOSMALL = 10005,
+	NFS4ERR_SERVERFAULT = 10006,
+	NFS4ERR_BADTYPE = 10007,
+	NFS4ERR_DELAY = 10008,
+	NFS4ERR_SAME = 10009,
+	NFS4ERR_DENIED = 10010,
+	NFS4ERR_EXPIRED = 10011,
+	NFS4ERR_LOCKED = 10012,
+	NFS4ERR_GRACE = 10013,
+	NFS4ERR_FHEXPIRED = 10014,
+	NFS4ERR_SHARE_DENIED = 10015,
+	NFS4ERR_WRONGSEC = 10016,
+	NFS4ERR_CLID_INUSE = 10017,
+	NFS4ERR_RESOURCE = 10018,
+	NFS4ERR_MOVED = 10019,
+	NFS4ERR_NOFILEHANDLE = 10020,
+	NFS4ERR_MINOR_VERS_MISMATCH = 10021,
+	NFS4ERR_STALE_CLIENTID = 10022,
+	NFS4ERR_STALE_STATEID = 10023,
+	NFS4ERR_OLD_STATEID = 10024,
+	NFS4ERR_BAD_STATEID = 10025,
+	NFS4ERR_BAD_SEQID = 10026,
+	NFS4ERR_NOT_SAME = 10027,
+	NFS4ERR_LOCK_RANGE = 10028,
+	NFS4ERR_SYMLINK = 10029,
+	NFS4ERR_RESTOREFH = 10030,
+	NFS4ERR_LEASE_MOVED = 10031,
+	NFS4ERR_ATTRNOTSUPP = 10032,
+	NFS4ERR_NO_GRACE = 10033,
+	NFS4ERR_RECLAIM_BAD = 10034,
+	NFS4ERR_RECLAIM_CONFLICT = 10035,
+	NFS4ERR_BADXDR = 10036,
+	NFS4ERR_LOCKS_HELD = 10037,
+	NFS4ERR_OPENMODE = 10038,
+	NFS4ERR_BADOWNER = 10039,
+	NFS4ERR_BADCHAR = 10040,
+	NFS4ERR_BADNAME = 10041,
+	NFS4ERR_BAD_RANGE = 10042,
+	NFS4ERR_LOCK_NOTSUPP = 10043,
+	NFS4ERR_OP_ILLEGAL = 10044,
+	NFS4ERR_DEADLOCK = 10045,
+	NFS4ERR_FILE_OPEN = 10046,
+	NFS4ERR_ADMIN_REVOKED = 10047,
+	NFS4ERR_CB_PATH_DOWN = 10048,
+	NFS4ERR_BADIOMODE = 10049,
+	NFS4ERR_BADLAYOUT = 10050,
+	NFS4ERR_BAD_SESSION_DIGEST = 10051,
+	NFS4ERR_BADSESSION = 10052,
+	NFS4ERR_BADSLOT = 10053,
+	NFS4ERR_COMPLETE_ALREADY = 10054,
+	NFS4ERR_CONN_NOT_BOUND_TO_SESSION = 10055,
+	NFS4ERR_DELEG_ALREADY_WANTED = 10056,
+	NFS4ERR_BACK_CHAN_BUSY = 10057,
+	NFS4ERR_LAYOUTTRYLATER = 10058,
+	NFS4ERR_LAYOUTUNAVAILABLE = 10059,
+	NFS4ERR_NOMATCHING_LAYOUT = 10060,
+	NFS4ERR_RECALLCONFLICT = 10061,
+	NFS4ERR_UNKNOWN_LAYOUTTYPE = 10062,
+	NFS4ERR_SEQ_MISORDERED = 10063,
+	NFS4ERR_SEQUENCE_POS = 10064,
+	NFS4ERR_REQ_TOO_BIG = 10065,
+	NFS4ERR_REP_TOO_BIG = 10066,
+	NFS4ERR_REP_TOO_BIG_TO_CACHE = 10067,
+	NFS4ERR_RETRY_UNCACHED_REP = 10068,
+	NFS4ERR_UNSAFE_COMPOUND = 10069,
+	NFS4ERR_TOO_MANY_OPS = 10070,
+	NFS4ERR_OP_NOT_IN_SESSION = 10071,
+	NFS4ERR_HASH_ALG_UNSUPP = 10072,
+	NFS4ERR_CLIENTID_BUSY = 10074,
+	NFS4ERR_PNFS_IO_HOLE = 10075,
+	NFS4ERR_SEQ_FALSE_RETRY = 10076,
+	NFS4ERR_BAD_HIGH_SLOT = 10077,
+	NFS4ERR_DEADSESSION = 10078,
+	NFS4ERR_ENCR_ALG_UNSUPP = 10079,
+	NFS4ERR_PNFS_NO_LAYOUT = 10080,
+	NFS4ERR_NOT_ONLY_OP = 10081,
+	NFS4ERR_WRONG_CRED = 10082,
+	NFS4ERR_WRONG_TYPE = 10083,
+	NFS4ERR_DIRDELEG_UNAVAIL = 10084,
+	NFS4ERR_REJECT_DELEG = 10085,
+	NFS4ERR_RETURNCONFLICT = 10086,
+	NFS4ERR_DELEG_REVOKED = 10087,
+	NFS4ERR_PARTNER_NOTSUPP = 10088,
+	NFS4ERR_PARTNER_NO_AUTH = 10089,
+	NFS4ERR_UNION_NOTSUPP = 10090,
+	NFS4ERR_OFFLOAD_DENIED = 10091,
+	NFS4ERR_WRONG_LFS = 10092,
+	NFS4ERR_BADLABEL = 10093,
+	NFS4ERR_OFFLOAD_NO_REQS = 10094,
+	NFS4ERR_NOXATTR = 10095,
+	NFS4ERR_XATTR2BIG = 10096,
+	NFS4ERR_FIRST_FREE = 10097,
+};
+typedef enum nfsstat4 nfsstat4;
+
+typedef opaque attrlist4;
+
 typedef struct {
 	u32 count;
 	uint32_t *element;
 } bitmap4;
 
+typedef uint64_t nfs_cookie4;
+
+typedef opaque nfs_fh4;
+
+typedef opaque utf8string;
+
+typedef utf8string utf8str_cis;
+
+typedef utf8string utf8str_cs;
+
+typedef utf8string utf8str_mixed;
+
+typedef utf8str_cs component4;
+
+typedef utf8str_cs linktext4;
+
+typedef struct {
+	u32 count;
+	component4 *element;
+} pathname4;
+
+typedef u8 verifier4[NFS4_VERIFIER_SIZE];
+
 struct nfstime4 {
 	int64_t seconds;
 	uint32_t nseconds;
 };
 
+struct fattr4 {
+	bitmap4 attrmask;
+	attrlist4 attr_vals;
+};
+
+struct stateid4 {
+	uint32_t seqid;
+	u8 other[12];
+};
+
 typedef bool fattr4_offline;
 
 enum { FATTR4_OFFLINE = 83 };
@@ -126,13 +287,115 @@ enum open_delegation_type4 {
 };
 typedef enum open_delegation_type4 open_delegation_type4;
 
-#define NFS4_int64_t_sz                 \
-	(XDR_hyper)
+enum notify_type4 {
+	NOTIFY4_CHANGE_CHILD_ATTRS = 0,
+	NOTIFY4_CHANGE_DIR_ATTRS = 1,
+	NOTIFY4_REMOVE_ENTRY = 2,
+	NOTIFY4_ADD_ENTRY = 3,
+	NOTIFY4_RENAME_ENTRY = 4,
+	NOTIFY4_CHANGE_COOKIE_VERIFIER = 5,
+};
+typedef enum notify_type4 notify_type4;
+
+struct notify_entry4 {
+	component4 ne_file;
+	struct fattr4 ne_attrs;
+};
+
+struct prev_entry4 {
+	struct notify_entry4 pe_prev_entry;
+	nfs_cookie4 pe_prev_entry_cookie;
+};
+
+struct notify_remove4 {
+	struct notify_entry4 nrm_old_entry;
+	nfs_cookie4 nrm_old_entry_cookie;
+};
+
+struct notify_add4 {
+	struct {
+		u32 count;
+		struct notify_remove4 *element;
+	} nad_old_entry;
+	struct notify_entry4 nad_new_entry;
+	struct {
+		u32 count;
+		nfs_cookie4 *element;
+	} nad_new_entry_cookie;
+	struct {
+		u32 count;
+		struct prev_entry4 *element;
+	} nad_prev_entry;
+	bool nad_last_entry;
+};
+
+struct notify_attr4 {
+	struct notify_entry4 na_changed_entry;
+};
+
+struct notify_rename4 {
+	struct notify_remove4 nrn_old_entry;
+	struct notify_add4 nrn_new_entry;
+};
+
+struct notify_verifier4 {
+	verifier4 nv_old_cookieverf;
+	verifier4 nv_new_cookieverf;
+};
+
+typedef opaque notifylist4;
+
+struct notify4 {
+	bitmap4 notify_mask;
+	notifylist4 notify_vals;
+};
+
+struct CB_NOTIFY4args {
+	struct stateid4 cna_stateid;
+	nfs_fh4 cna_fh;
+	struct {
+		u32 count;
+		struct notify4 *element;
+	} cna_changes;
+};
+
+struct CB_NOTIFY4res {
+	nfsstat4 cnr_status;
+};
+
+#define NFS4_int32_t_sz                 \
+	(XDR_int)
 #define NFS4_uint32_t_sz                \
 	(XDR_unsigned_int)
+#define NFS4_int64_t_sz                 \
+	(XDR_hyper)
+#define NFS4_uint64_t_sz                \
+	(XDR_unsigned_hyper)
+#define NFS4_nfsstat4_sz                (XDR_int)
+#define NFS4_attrlist4_sz               (XDR_unsigned_int)
 #define NFS4_bitmap4_sz                 (XDR_unsigned_int)
+#define NFS4_nfs_cookie4_sz             \
+	(NFS4_uint64_t_sz)
+#define NFS4_nfs_fh4_sz                 (XDR_unsigned_int + XDR_QUADLEN(NFS4_FHSIZE))
+#define NFS4_utf8string_sz              (XDR_unsigned_int)
+#define NFS4_utf8str_cis_sz             \
+	(NFS4_utf8string_sz)
+#define NFS4_utf8str_cs_sz              \
+	(NFS4_utf8string_sz)
+#define NFS4_utf8str_mixed_sz           \
+	(NFS4_utf8string_sz)
+#define NFS4_component4_sz              \
+	(NFS4_utf8str_cs_sz)
+#define NFS4_linktext4_sz               \
+	(NFS4_utf8str_cs_sz)
+#define NFS4_pathname4_sz               (XDR_unsigned_int)
+#define NFS4_verifier4_sz               (XDR_QUADLEN(NFS4_VERIFIER_SIZE))
 #define NFS4_nfstime4_sz                \
 	(NFS4_int64_t_sz + NFS4_uint32_t_sz)
+#define NFS4_fattr4_sz                  \
+	(NFS4_bitmap4_sz + NFS4_attrlist4_sz)
+#define NFS4_stateid4_sz                \
+	(NFS4_uint32_t_sz + XDR_QUADLEN(12))
 #define NFS4_fattr4_offline_sz          \
 	(XDR_bool)
 #define NFS4_open_arguments4_sz         \
@@ -149,5 +412,27 @@ typedef enum open_delegation_type4 open_delegation_type4;
 #define NFS4_fattr4_time_deleg_modify_sz \
 	(NFS4_nfstime4_sz)
 #define NFS4_open_delegation_type4_sz   (XDR_int)
+#define NFS4_notify_type4_sz            (XDR_int)
+#define NFS4_notify_entry4_sz           \
+	(NFS4_component4_sz + NFS4_fattr4_sz)
+#define NFS4_prev_entry4_sz             \
+	(NFS4_notify_entry4_sz + NFS4_nfs_cookie4_sz)
+#define NFS4_notify_remove4_sz          \
+	(NFS4_notify_entry4_sz + NFS4_nfs_cookie4_sz)
+#define NFS4_notify_add4_sz             \
+	(XDR_unsigned_int + (1 * (NFS4_notify_remove4_sz)) + NFS4_notify_entry4_sz + XDR_unsigned_int + (1 * (NFS4_nfs_cookie4_sz)) + XDR_unsigned_int + (1 * (NFS4_prev_entry4_sz)) + XDR_bool)
+#define NFS4_notify_attr4_sz            \
+	(NFS4_notify_entry4_sz)
+#define NFS4_notify_rename4_sz          \
+	(NFS4_notify_remove4_sz + NFS4_notify_add4_sz)
+#define NFS4_notify_verifier4_sz        \
+	(NFS4_verifier4_sz + NFS4_verifier4_sz)
+#define NFS4_notifylist4_sz             (XDR_unsigned_int)
+#define NFS4_notify4_sz                 \
+	(NFS4_bitmap4_sz + NFS4_notifylist4_sz)
+#define NFS4_CB_NOTIFY4args_sz          \
+	(NFS4_stateid4_sz + NFS4_nfs_fh4_sz + XDR_unsigned_int)
+#define NFS4_CB_NOTIFY4res_sz           \
+	(NFS4_nfsstat4_sz)
 
 #endif /* _LINUX_XDRGEN_NFS4_1_DEF_H */
diff --git a/include/uapi/linux/nfs4.h b/include/uapi/linux/nfs4.h
index 4273e0249fcbb54996f5642f9920826b9d68b7b9..289205b53a0858e589380c69ad1ba0cfd5f825fd 100644
--- a/include/uapi/linux/nfs4.h
+++ b/include/uapi/linux/nfs4.h
@@ -17,11 +17,9 @@
 #include <linux/types.h>
 
 #define NFS4_BITMAP_SIZE	3
-#define NFS4_VERIFIER_SIZE	8
 #define NFS4_STATEID_SEQID_SIZE 4
 #define NFS4_STATEID_OTHER_SIZE 12
 #define NFS4_STATEID_SIZE	(NFS4_STATEID_SEQID_SIZE + NFS4_STATEID_OTHER_SIZE)
-#define NFS4_FHSIZE		128
 #define NFS4_MAXPATHLEN		PATH_MAX
 #define NFS4_MAXNAMLEN		NAME_MAX
 #define NFS4_OPAQUE_LIMIT	1024

-- 
2.51.0


