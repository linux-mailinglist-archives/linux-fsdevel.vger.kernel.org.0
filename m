Return-Path: <linux-fsdevel+bounces-61036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3863BB54A07
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 12:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEC01585567
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 10:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88BF2EC0A2;
	Fri, 12 Sep 2025 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PJf9Oixr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r/JfvYxz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PJf9Oixr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r/JfvYxz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22732EB86E
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 10:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673540; cv=none; b=odtgsGHVdpR1zjGvfXWGAwfsaHMD6ivkPAhK1TdovqkRU7EHZ7XIC0T5xfa46HrKDSR7xnWpMQ8D/F1q7MokVzFvptf7nQlGGB6ESbihiOFvE0v4f9/PWUBwiLY799RPyBjn7b34o5hJ9hlFz69w6//mZV4qfmW9i4Z4eu8yKFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673540; c=relaxed/simple;
	bh=GFpSSvi8SL5ry95uzJhX3PdRZhclIlFRUQTLMLhDQgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APRsgD9OoRrpJvakj/NyJoNzUDDuT9V1C1HTV+xJ9b5by3nahQcJy20FpBQh1bvRxI8fU32L3iSyoijHET2twxVUsU7R1l1bEXGbrEx0uu8bdiCHE7cGY4HaE10xFPq7r+n+60NDwg5EEa/Rm5s4qS43k9nrHoJNW4UZJVuGfmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PJf9Oixr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r/JfvYxz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PJf9Oixr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r/JfvYxz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6E45738A4C;
	Fri, 12 Sep 2025 10:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757673530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hQHrXlOcw2o88+sX8FvmUXpyimBUrFviHJaPJFe4cTY=;
	b=PJf9OixrtU4BNGOg/xvQOKG7AKyp/GgBt5s3RduR/s4BbZ1H2XL9e35yOCDHV/O+NkAn5t
	srEMC6GDo3PBzvJIFk4xBxG5gF5nxHYJtVz1R/FbH/0qp93sU6qCaptl2Zg0g/0V4QrYUn
	jSvTdJjBeS71qTFHivejkjgrOVX9jec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757673530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hQHrXlOcw2o88+sX8FvmUXpyimBUrFviHJaPJFe4cTY=;
	b=r/JfvYxzg7XhPVbq51+Bj7jJXdlsimCxFlY9TPggYobkMW8axDv/bxRPreVMQtJEolqXFe
	peFuRBQmM2ZXR8DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757673530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hQHrXlOcw2o88+sX8FvmUXpyimBUrFviHJaPJFe4cTY=;
	b=PJf9OixrtU4BNGOg/xvQOKG7AKyp/GgBt5s3RduR/s4BbZ1H2XL9e35yOCDHV/O+NkAn5t
	srEMC6GDo3PBzvJIFk4xBxG5gF5nxHYJtVz1R/FbH/0qp93sU6qCaptl2Zg0g/0V4QrYUn
	jSvTdJjBeS71qTFHivejkjgrOVX9jec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757673530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hQHrXlOcw2o88+sX8FvmUXpyimBUrFviHJaPJFe4cTY=;
	b=r/JfvYxzg7XhPVbq51+Bj7jJXdlsimCxFlY9TPggYobkMW8axDv/bxRPreVMQtJEolqXFe
	peFuRBQmM2ZXR8DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6510B13869;
	Fri, 12 Sep 2025 10:38:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +vunGDr4w2geWAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 12 Sep 2025 10:38:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 21AC5A0A68; Fri, 12 Sep 2025 12:38:50 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 3/4] writeback: Avoid excessively long inode switching times
Date: Fri, 12 Sep 2025 12:38:37 +0200
Message-ID: <20250912103840.4844-7-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912103522.2935-1-jack@suse.cz>
References: <20250912103522.2935-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3564; i=jack@suse.cz; h=from:subject; bh=GFpSSvi8SL5ry95uzJhX3PdRZhclIlFRUQTLMLhDQgU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBow/gymZ3gDLEf6a35HPIKERIWJyuoQC6xjkYj4 ke39ctvoOGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaMP4MgAKCRCcnaoHP2RA 2QLjCADQu/EFN8zZbfWJR0ruvf82wQK1KaAsmTyEazrAJOZcc2EoHrCxMxD3qPh9IUvd4/WDQGu vTfg0BZDwh7br9RLH75mhmbFl8yBWXbYo2cdMENb8m3lD5tyKUy0WA3xbw066//xObASdUEznsY h2ebw6KadGpcKIlfIXyf7aXyeHXFqOMN2XKm6WsfBkKUuhqiMA709n08kGjYbIM/RNaWLMFupGJ w5q2/2OSq68bfMNqyKNwBdw82v0+ZWzTwQqlWaQNyjLDW+k3AlSqekwG4w+fXcROBcUSTuo7cbc +jpqreufHyOqvIEwhGCuyqfSmd2W5q8AnipKbQLzmuuBn7G8
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Score: -6.80

With lazytime mount option enabled we can be switching many dirty inodes
on cgroup exit to the parent cgroup. The numbers observed in practice
when systemd slice of a large cron job exits can easily reach hundreds
of thousands or millions. The logic in inode_do_switch_wbs() which sorts
the inode into appropriate place in b_dirty list of the target wb
however has linear complexity in the number of dirty inodes thus overall
time complexity of switching all the inodes is quadratic leading to
workers being pegged for hours consuming 100% of the CPU and switching
inodes to the parent wb.

Simple reproducer of the issue:
  FILES=10000
  # Filesystem mounted with lazytime mount option
  MNT=/mnt/
  echo "Creating files and switching timestamps"
  for (( j = 0; j < 50; j ++ )); do
      mkdir $MNT/dir$j
      for (( i = 0; i < $FILES; i++ )); do
          echo "foo" >$MNT/dir$j/file$i
      done
      touch -a -t 202501010000 $MNT/dir$j/file*
  done
  wait
  echo "Syncing and flushing"
  sync
  echo 3 >/proc/sys/vm/drop_caches

  echo "Reading all files from a cgroup"
  mkdir /sys/fs/cgroup/unified/mycg1 || exit
  echo $$ >/sys/fs/cgroup/unified/mycg1/cgroup.procs || exit
  for (( j = 0; j < 50; j ++ )); do
      cat /mnt/dir$j/file* >/dev/null &
  done
  wait
  echo "Switching wbs"
  # Now rmdir the cgroup after the script exits

We need to maintain b_dirty list ordering to keep writeback happy so
instead of sorting inode into appropriate place just append it at the
end of the list and clobber dirtied_time_when. This may result in inode
writeback starting later after cgroup switch however cgroup switches are
rare so it shouldn't matter much. Since the cgroup had write access to
the inode, there are no practical concerns of the possible DoS issues.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 40b42c385b55..22fe313ae0d3 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -445,22 +445,23 @@ static bool inode_do_switch_wbs(struct inode *inode,
 	 * Transfer to @new_wb's IO list if necessary.  If the @inode is dirty,
 	 * the specific list @inode was on is ignored and the @inode is put on
 	 * ->b_dirty which is always correct including from ->b_dirty_time.
-	 * The transfer preserves @inode->dirtied_when ordering.  If the @inode
-	 * was clean, it means it was on the b_attached list, so move it onto
-	 * the b_attached list of @new_wb.
+	 * If the @inode was clean, it means it was on the b_attached list, so
+	 * move it onto the b_attached list of @new_wb.
 	 */
 	if (!list_empty(&inode->i_io_list)) {
 		inode->i_wb = new_wb;
 
 		if (inode->i_state & I_DIRTY_ALL) {
-			struct inode *pos;
-
-			list_for_each_entry(pos, &new_wb->b_dirty, i_io_list)
-				if (time_after_eq(inode->dirtied_when,
-						  pos->dirtied_when))
-					break;
+			/*
+			 * We need to keep b_dirty list sorted by
+			 * dirtied_time_when. However properly sorting the
+			 * inode in the list gets too expensive when switching
+			 * many inodes. So just attach inode at the end of the
+			 * dirty list and clobber the dirtied_time_when.
+			 */
+			inode->dirtied_time_when = jiffies;
 			inode_io_list_move_locked(inode, new_wb,
-						  pos->i_io_list.prev);
+						  &new_wb->b_dirty);
 		} else {
 			inode_cgwb_move_to_attached(inode, new_wb);
 		}
-- 
2.51.0


