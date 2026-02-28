Return-Path: <linux-fsdevel+bounces-78832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eF3KMuxIo2l//AQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 20:58:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E15F1C7AAE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 20:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 030A431CD664
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 19:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506B74A2E14;
	Sat, 28 Feb 2026 17:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhnYncYr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B8235A3B7;
	Sat, 28 Feb 2026 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300910; cv=none; b=fgTE7yNHKd7snx8/U73ppbLEOaLwas4uprlpgkFFBff4Qn0dJpqB6KjkW1VtmLk8I+V/nw7RF9Lyk8YjlwYA1NrMQRI2s7eEUDH1IiGGwbLrLXE4Q9+lxevMB3PS6pyfW8nD1U4gDeIRvwiFYR5C2kGyDE7L3eKvggCvwJb+CPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300910; c=relaxed/simple;
	bh=lgckruRzCqInsR1TwxzrE/g9fFUJVXK1HokDjmRbsYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4MawOFyV26wo1sEpr+Eat5FdrY+/CupbIQB9zzsO+chJqvG0U5OP5WKAg8owZqFY6mxgIJj+X90XLAKX6THqN1knhzNnjhbyLny8rP/4hWxPMr2oPp74psYIv9aauWBMleiGQfTomDD2gKZoU8J4wraCKGfVN9+1evtCbOU1ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhnYncYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A26EC116D0;
	Sat, 28 Feb 2026 17:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300910;
	bh=lgckruRzCqInsR1TwxzrE/g9fFUJVXK1HokDjmRbsYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uhnYncYriERdHE2lyL+KOWzkzXcJ8hQtTjh2Rys7hLdJd2jBJXjIJh8+mz0btlhPk
	 QwgB+3mbTvQZmA+TwUHBRd/pRnfSlL1jrYFkon5ACiglkJRPQHSu8qgWLTAPvR7F6r
	 qVyfQoBg5p+EmYugGjbCz66/omIUj80b+CrAHluqGPGcZfrTIKzpEM09hcb4PQgxWx
	 Op2H3dTHUh1bScn7u0jHdaOnU4n355Z8O8ai2+mcl/0nIsJP5CkJzFMjKd/tGMAkQ9
	 m/JVJUrPEKMFGGM27VbAsihIwGYcpo2zE+djLca4Udplhayzhp7XtuSFuhq91PbxMi
	 s3VZooeGqq7pg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 025/752] hfsplus: fix volume corruption issue for generic/498
Date: Sat, 28 Feb 2026 12:35:36 -0500
Message-ID: <20260228174750.1542406-25-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78832-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E15F1C7AAE
X-Rspamd-Action: no action

From: Viacheslav Dubeyko <slava@dubeyko.com>

[ Upstream commit 9a8c4ad44721da4c48e1ff240ac76286c82837fe ]

The xfstests' test-case generic/498 leaves HFS+ volume
in corrupted state:

sudo ./check generic/498
FSTYP -- hfsplus
PLATFORM -- Linux/x86_64 hfsplus-testing-0001 6.18.0-rc1+ #18 SMP PREEMPT_DYNAMIC Thu Dec 4 12:24:45 PST 2025
MKFS_OPTIONS -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/498 _check_generic_filesystem: filesystem on /dev/loop51 is inconsistent
(see XFSTESTS-2/xfstests-dev/results//generic/498.full for details)

Ran: generic/498
Failures: generic/498
Failed 1 of 1 tests

sudo fsck.hfsplus -d /dev/loop51
** /dev/loop51
Using cacheBlockSize=32K cacheTotalBlock=1024 cacheSize=32768K.
Executing fsck_hfs (version 540.1-Linux).
** Checking non-journaled HFS Plus Volume.
The volume name is untitled
** Checking extents overflow file.
** Checking catalog file.
Invalid leaf record count
(It should be 16 instead of 2)
** Checking multi-linked files.
CheckHardLinks: found 1 pre-Leopard file inodes.
** Checking catalog hierarchy.
** Checking extended attributes file.
** Checking volume bitmap.
** Checking volume information.
Verify Status: VIStat = 0x0000, ABTStat = 0x0000 EBTStat = 0x0000
CBTStat = 0x8000 CatStat = 0x00000000
** Repairing volume.
** Rechecking volume.
** Checking non-journaled HFS Plus Volume.
The volume name is untitled
** Checking extents overflow file.
** Checking catalog file.
** Checking multi-linked files.
CheckHardLinks: found 1 pre-Leopard file inodes.
** Checking catalog hierarchy.
** Checking extended attributes file.
** Checking volume bitmap.
** Checking volume information.
** The volume untitled was repaired successfully.

The generic/498 test executes such steps on final phase:

mkdir $SCRATCH_MNT/A
mkdir $SCRATCH_MNT/B
mkdir $SCRATCH_MNT/A/C
touch $SCRATCH_MNT/B/foo
$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/B/foo

ln $SCRATCH_MNT/B/foo $SCRATCH_MNT/A/C/foo
$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/A

"Simulate a power failure and mount the filesystem
to check that what we explicitly fsync'ed exists."

_flakey_drop_and_remount

The FSCK tool complains about "Invalid leaf record count".
HFS+ b-tree header contains leaf_count field is updated
by hfs_brec_insert() and hfs_brec_remove(). The hfs_brec_insert()
is involved into hard link creation process. However,
modified in-core leaf_count field is stored into HFS+
b-tree header by hfs_btree_write() method. But,
unfortunately, hfs_btree_write() hasn't been called
by hfsplus_cat_write_inode() and hfsplus_file_fsync()
stores not fully consistent state of the Catalog File's
b-tree.

This patch adds calling hfs_btree_write() method in
the hfsplus_cat_write_inode() with the goal of
storing consistent state of Catalog File's b-tree.
Finally, it makes FSCK tool happy.

sudo ./check generic/498
FSTYP         -- hfsplus
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.18.0-rc1+ #22 SMP PREEMPT_DYNAMIC Sat Dec  6 17:01:31 PST 2025
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/498 33s ...  31s
Ran: generic/498
Passed all 1 tests

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20251207035821.3863657-1-slava@dubeyko.com
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfsplus/inode.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index c762bf909d1aa..6153e5cc6eb65 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -615,6 +615,7 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 int hfsplus_cat_write_inode(struct inode *inode)
 {
 	struct inode *main_inode = inode;
+	struct hfs_btree *tree = HFSPLUS_SB(inode->i_sb)->cat_tree;
 	struct hfs_find_data fd;
 	hfsplus_cat_entry entry;
 	int res = 0;
@@ -627,7 +628,7 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	if (!main_inode->i_nlink)
 		return 0;
 
-	if (hfs_find_init(HFSPLUS_SB(main_inode->i_sb)->cat_tree, &fd))
+	if (hfs_find_init(tree, &fd))
 		/* panic? */
 		return -EIO;
 
@@ -692,6 +693,15 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	set_bit(HFSPLUS_I_CAT_DIRTY, &HFSPLUS_I(inode)->flags);
 out:
 	hfs_find_exit(&fd);
+
+	if (!res) {
+		res = hfs_btree_write(tree);
+		if (res) {
+			pr_err("b-tree write err: %d, ino %lu\n",
+			       res, inode->i_ino);
+		}
+	}
+
 	return res;
 }
 
-- 
2.51.0


