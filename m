Return-Path: <linux-fsdevel+bounces-75052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNLYCzpIcmnpfAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:54:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1B069490
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7E16D56CE10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 14:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AEF344024;
	Thu, 22 Jan 2026 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esL9eYXE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F414E2DA76A
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 14:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769091588; cv=none; b=k9t8A70MRRwNQji+t7mr/IPxGA67+4e54a/xq/2MI4I3tlVQ1mIYmTjlvSJwhXUGatpEgCjvwEJpdKNo5J0wQFhPIO7pdPhiXKIgTHgcmzTcySN8j6mdnNBexYsSr6t1QOpv59jnpYy7UBiyFGjcn5Q5VdH9HsFYVYFGIx6CzE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769091588; c=relaxed/simple;
	bh=ZKSvcZcZxXexWNdQflQ4tF+G2p45weoUygtUEccHvJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f2208BdJwmHvdseyNVQjCnJMHiBAs4bRi0nbfRnMGslF24z1pgAJdpkrfgAorru6bQl3rIc/pIkXrVZRa6qXPMClQCZGKfakpGtGDgrAoMHiir5awwKctMREf5+i7Ph/5h2D8my/mnys/umKQQizdmW1yiHeUBJ8d2Duh6GkD38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esL9eYXE; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-65814266b08so1951843a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 06:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769091585; x=1769696385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iwqruOkGitQ2/+rUHzZCRQ8gnj59rMd2hhsOTht7Eoc=;
        b=esL9eYXEMiJdzxq5cd7tNZk2R/ZrVZ9x5SlCjpR0FoZjxW1DNpJU2aRCFb65ruIcHZ
         NfiD0Qv2IHhtE8W1hC8lPLD70ArGVeQaOrzWSG+SLVEhB1aPuuNuAtRDpfoBOvUmoJpV
         ntm68JwvGZIEyYuIn+zo/iH1JMunXO9HggREmL12PZQaBV4wfWbBd8U5u4LScNK/TSkP
         DrSGMNdiCx4vq0RenZ9yz+BiiwOcKSASd5jX7btfyJ9urj1LZ4H1jMotTjc3svJB3ZIO
         QDyvyXGvoWWc8yDHVYa+7Isv1VsPM4IDbakXWO1tkd7CmWsm7SJBjs1pO5bZ7hx5tzuX
         vZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769091585; x=1769696385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwqruOkGitQ2/+rUHzZCRQ8gnj59rMd2hhsOTht7Eoc=;
        b=LlCfNrNiwG6SNk414OT8rzkbJ2tk0RSazcVBduPjoDqEuy0D903MBPF41zO+OUjGkx
         6B8yhjAYyw1YKFk5w6TLIgBE07LJRgp5M2beSSIRVmxfWqNilgUa1gahKRnsGIEfTgta
         9a+1qCBu9HwRijTO62AO4LiOUIjf2qHiYnw0z0oZKp2MgVpmpLw7vj+IkkrFN3cpPKPx
         fVAwuCeZ/RriMF+NvyB8ZNROdZZk/qHMYOPI0GLc53IUmSA950DZ87lvtwdV5Q3aHRUW
         1kW6iebyWzgKPYcYlGH5lO7TsZij7JP4jYSttvdzg/RMlaPmxVEqxRdr9dSPvLzn5x4c
         Im0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWm8dC1ndVhvbb0hVD9Ym9tpoLL1ZLmCiWQJMpeU/zvrNUTBljdvtQItd2pfPvFmTcn8NMUP0csYQk1gPC3@vger.kernel.org
X-Gm-Message-State: AOJu0YzoXo27Y7WbAkcsGQ+4w24gA8PZA9+nU8CxdSrcdcGVYqyw8pXD
	WHPA98DEaIkgWxIRvC/697jxHK+jPhLmn1RkWs9ryWF1nYNly330XI6I
X-Gm-Gg: AZuq6aKxxAHAsTB4lV4daLO3DKz1/DyqF9FQnwnBDWVSA9OrPG7C6U/IjYOE11M7dOB
	Uzzr1oFdpwDyIjyNUaWC4lSuJiIqmLeOhDOfSHTSB9bzG6+z4Dk8jkwev5OVlsy9iEa0nzOy3w7
	vAitn4eL9iNeywcmLerFtrdm6do+l0r+cZllX7N65evPZbTd/mi6OX0VEpA7ZniMxU0Cp7qi6Fs
	xG0EcIBcHHUVmNlBIHFpfmgIkGjqmAI817nb9meEHa5myaiUyp0TlLrCyRLxs2WmbcNQWHP76Ke
	w2Aa2jT83vIK+xhCJ+7r1y/vRAgV9Rieyt08iaKx+i3KBLeav3Zaj5bXFkPh/5YXAdjFqSgqdS5
	jawZrYSoHTFTmA1CpdpKsZP53QQF3YRhMAUqtmQPlSbRwly1KMb6lwGXkB7XI8iFM6GYdm4SA4D
	o3wc06F4qhsd0IkcNJcHjL8SFjw12Z2j1+bYi9Dknlfl6hdnygITTlyFbMDSgaZghQKO96+ZxI+
	+8RtaQhDPwZCw==
X-Received: by 2002:a05:6402:1d4a:b0:64d:16ba:b1c4 with SMTP id 4fb4d7f45d1cf-65452acddc5mr16873826a12.19.1769091585047;
        Thu, 22 Jan 2026 06:19:45 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-ea02-0082-2554-e1f0.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:ea02:82:2554:e1f0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6581329c854sm2418933a12.15.2026.01.22.06.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 06:19:44 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Neil Brown <neil@brown.name>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2] nfsd: do not allow exporting of special kernel filesystems
Date: Thu, 22 Jan 2026 15:19:42 +0100
Message-ID: <20260122141942.660948-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75052-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: CA1B069490
X-Rspamd-Action: no action

pidfs and nsfs recently gained support for encode/decode of file handles
via name_to_handle_at(2)/opan_by_handle_at(2).

These special kernel filesystems have custom ->open() and ->permission()
export methods, which nfsd does not respect and it was never meant to be
used for exporting those filesystems by nfsd.

Therefore, do not allow nfsd to export filesystems with custom ->open()
or ->permission() methods.

Update comments and Documentation/filesystems/nfs/exporting.rst to
express the fact the those methods are for open_by_handle(2) system only
and not compatible with nfsd.

Fixes: b3caba8f7a34a ("pidfs: implement file handle support")
Fixes: 5222470b2fbb3 ("nsfs: support file handles")
Reviewed-by: NeilBrown <neil@brown.name>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Christian,

Most of the stakeholders approved the approach in v1 [1] and
only comments were regarding lack of documentation for the new
incomapatible methods.

I did my best to add minimal documentation to express the fact
that those methods are not compatible with nfsd and remote filesystem
export in general.

Further documentations regarding the new uses of export_operations
beyond their original use for nfs export is outside the scope of this
patch and frankly, outside the reach of my documentation skills...

Thanks,
Amir.

Changes since v1:
- Use helper exportfs_may_export()
- Minimal documentation for open/permission methods
- Add RVBs

[1] https://lore.kernel.org/linux-fsdevel/20260121085028.558164-1-amir73il@gmail.com/

 Documentation/filesystems/nfs/exporting.rst | 13 ++++++++-
 fs/nfsd/export.c                            |  9 ++++--
 include/linux/exportfs.h                    | 31 +++++++++++++++++----
 3 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/filesystems/nfs/exporting.rst
index de64d2d002a20..da5236cb35012 100644
--- a/Documentation/filesystems/nfs/exporting.rst
+++ b/Documentation/filesystems/nfs/exporting.rst
@@ -100,7 +100,8 @@ Filesystem Issues
 
 For a filesystem to be exportable it must:
 
-   1. provide the filehandle fragment routines described below.
+   1. implement all the mandatory routines described below and
+      none of the export incompatible routines below.
    2. make sure that d_splice_alias is used rather than d_add
       when ->lookup finds an inode for a given parent and name.
 
@@ -151,6 +152,16 @@ struct which has the following members:
     to find potential names, and matches inode numbers to find the correct
     match.
 
+  permission: (incompatible for export to remote filesystem)
+    Allow filesystems to specify a custom permission function for the
+    open_by_handle_at(2) syscall instead of the default CAP_DAC_READ_SEARCH
+    check. This custom permission function is not respected by nfsd.
+
+  open: (incompatible for export to remote filesystem)
+    Allow filesystems to specify a custom open function for the
+    open_by_handle_at(2) syscall instead of the default file_open_root().
+    This custom open function is not respected by nfsd.
+
   flags
     Some filesystems may need to be handled differently than others. The
     export_operations struct also includes a flags field that allows the
diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 2a1499f2ad196..fef23d579b797 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -427,7 +427,9 @@ static int check_export(const struct path *path, int *flags, unsigned char *uuid
 	 *       either a device number (so FS_REQUIRES_DEV needed)
 	 *       or an FSID number (so NFSEXP_FSID or ->uuid is needed).
 	 * 2:  We must be able to find an inode from a filehandle.
-	 *       This means that s_export_op must be set.
+	 *       This means that s_export_op must be set and comply with
+	 *       the requirements for remote filesystem export.
+	 *       See Documentation/filesystems/nfs/exporting.rst.
 	 * 3: We must not currently be on an idmapped mount.
 	 */
 	if (!(inode->i_sb->s_type->fs_flags & FS_REQUIRES_DEV) &&
@@ -437,8 +439,9 @@ static int check_export(const struct path *path, int *flags, unsigned char *uuid
 		return -EINVAL;
 	}
 
-	if (!exportfs_can_decode_fh(inode->i_sb->s_export_op)) {
-		dprintk("exp_export: export of invalid fs type.\n");
+	if (!exportfs_may_export(inode->i_sb->s_export_op)) {
+		dprintk("exp_export: export of invalid fs type (%s).\n",
+			inode->i_sb->s_type->name);
 		return -EINVAL;
 	}
 
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index f0cf2714ec52d..8ac0de399dd51 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -192,7 +192,9 @@ struct handle_to_path_ctx {
 #define FILEID_VALID_USER_FLAGS	(FILEID_IS_CONNECTABLE | FILEID_IS_DIR)
 
 /**
- * struct export_operations - for nfsd to communicate with file systems
+ * struct export_operations
+ *
+ * Methods for nfsd to communicate with file systems:
  * @encode_fh:      encode a file handle fragment from a dentry
  * @fh_to_dentry:   find the implied object and get a dentry for it
  * @fh_to_parent:   find the implied object's parent and get a dentry for it
@@ -200,6 +202,10 @@ struct handle_to_path_ctx {
  * @get_parent:     find the parent of a given directory
  * @commit_metadata: commit metadata changes to stable storage
  *
+ * Methods for open_by_handle(2) syscall with special kernel file systems:
+ * @permission:     custom permission for opening a file by handle
+ * @open:           custom open routine for opening file by handle
+ *
  * See Documentation/filesystems/nfs/exporting.rst for details on how to use
  * this interface correctly.
  *
@@ -243,14 +249,18 @@ struct handle_to_path_ctx {
  *    is also a directory.  In the event that it cannot be found, or storage
  *    space cannot be allocated, a %ERR_PTR should be returned.
  *
+ * commit_metadata:
+ *    @commit_metadata should commit metadata changes to stable storage.
+ *
  * permission:
- *    Allow filesystems to specify a custom permission function.
+ *    Allow filesystems to specify a custom permission function for the
+ *    open_by_handle_at(2) syscall instead of the default CAP_DAC_READ_SEARCH
+ *    check. This custom permission function is not respected by nfsd.
  *
  * open:
- *    Allow filesystems to specify a custom open function.
- *
- * commit_metadata:
- *    @commit_metadata should commit metadata changes to stable storage.
+ *    Allow filesystems to specify a custom open function for the
+ *    open_by_handle_at(2) syscall instead of the default file_open_root().
+ *    This custom open function is not respected by nfsd.
  *
  * Locking rules:
  *    get_parent is called with child->d_inode->i_rwsem down
@@ -317,6 +327,15 @@ static inline bool exportfs_can_decode_fh(const struct export_operations *nop)
 	return nop && nop->fh_to_dentry;
 }
 
+static inline bool exportfs_may_export(const struct export_operations *nop)
+{
+	/*
+	 * Do not allow nfs export for filesystems with custom ->open() and
+	 * ->permission() ops, which nfsd does not respect (e.g. pidfs, nsfs).
+	 */
+	return exportfs_can_decode_fh(nop) && !nop->open && !nop->permission;
+}
+
 static inline bool exportfs_can_encode_fh(const struct export_operations *nop,
 					  int fh_flags)
 {
-- 
2.52.0


