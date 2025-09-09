Return-Path: <linux-fsdevel+bounces-60673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B21FB4FFC9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 16:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17794E24AF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 14:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D28F3451B6;
	Tue,  9 Sep 2025 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1xdIbqoD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uVyeVjtg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lsIS8WIv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S7wo19sr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4901338F23
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 14:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429073; cv=none; b=ALyD4blkTs1Jjf1cqLXK+tUSbBw0voeLYRDxG0Xna5X7Vuvf1ubil7JrAesDAS9voefGIXYmAFefvA8EqOqfxs/Ay63fpAcvSIS27P6O2xw0SXhZaCu9BiVMeUbZv1nFfAVTELuyRiHJlK0KPbpEhszfmEy20F/qlXRx7a94AtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429073; c=relaxed/simple;
	bh=7KYAKIKmrfod7C7EzJhcbdCi1kJUs9jixIB7VUpU15c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCjZXpRz3XbekjSBP4060rL7npeq3/d6NRVwGjbn4hRbmXtXL32jSIRFMUHP+NhhvOcZyg9L2oPCjmFVVMfPtL/0uN+INx45hILPiw/LSYRXgKUMSLDP9fulON+w9ftUqZjGWuRpyozB8oqn1ZtP+XCEfAbulAzOy92n95XkBfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1xdIbqoD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uVyeVjtg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lsIS8WIv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S7wo19sr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E10FE5D734;
	Tue,  9 Sep 2025 14:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757429070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OUhov8tIxR8NBvo4QkjpeUUK/G3OTnab2I3RTk2yV+Y=;
	b=1xdIbqoDnhj82m7udLQ+2FIiDEFD+ssa9KsMVarO1ORGBrlch5TeTJcFot9AJs5KAtP56k
	Nd/ddDvY4B+LrGdPYWb6zebu7A4PYdn/bJrqtGppVml5M6urIGMAdDI8V/YOkK3Do+yjLd
	opYgjcASwKbmfLo1uH7ygLSVQVmA54k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757429070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OUhov8tIxR8NBvo4QkjpeUUK/G3OTnab2I3RTk2yV+Y=;
	b=uVyeVjtgNI/A1cT9u+XQasKESrQrBFWJQ86177kOaSaG0PDU5/MQs0ypES7W+CpGlgPcJS
	z9AmO4KESwP10rAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757429069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OUhov8tIxR8NBvo4QkjpeUUK/G3OTnab2I3RTk2yV+Y=;
	b=lsIS8WIv3x8tSJyU8L1EXN9rKHmmqVxX8WkuhLKqUqnCSK9vqtoNU/N0ebEgrW26PeRdGj
	DedIHWJbCV0gCCoATo1wfzRW23lPPex6bnx9f6uyyAkCOeVhshCKiZkBTBvhJSTVNp6kHx
	ZiTGc4sUN2JhMU1AWFwUvg8aLfOygnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757429069;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OUhov8tIxR8NBvo4QkjpeUUK/G3OTnab2I3RTk2yV+Y=;
	b=S7wo19sr5UjnjLG793WXKvYk527u3mQE3I8K5cJEmEEfJOFeWwmk2dvVvfhKchdGedasl+
	uGnOr6HBwqUAsBAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6FC81388C;
	Tue,  9 Sep 2025 14:44:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4pJ2NE09wGiTdwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 09 Sep 2025 14:44:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7DD92A0AAF; Tue,  9 Sep 2025 16:44:29 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 3/4] writeback: Avoid excessively long inode switching times
Date: Tue,  9 Sep 2025 16:44:04 +0200
Message-ID: <20250909144400.2901-7-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909143734.30801-1-jack@suse.cz>
References: <20250909143734.30801-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3527; i=jack@suse.cz; h=from:subject; bh=7KYAKIKmrfod7C7EzJhcbdCi1kJUs9jixIB7VUpU15c=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBowD0ypmD9J1BwJ3Zm1VNQGni8cy/nrwjf+6b1H 0DLJggmCYmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaMA9MgAKCRCcnaoHP2RA 2bhLCADRk747XRUXLL0o3awP7IS04OP1bLncfOBnv+JG7DsdeHDzWoYw5RuqYh6oEJt9WDL0tYF jiFnqlY7KAl4ZOIJjYPuDfCqd6as/3ku6Lyzbh7n5rAPJaE+Gl8F9yoEGhBuAMgXV1lrs64CRCu 1/yUyYv+DS9tHxHggM20v4C9hoJV6J/t4mKZDPAwGe3Ub0zr/FmxOYRMRpqIdeG+KIPjpyewcmH fZsY2VaTfnuYbftIQ5eB8XOMQjnUCZIHig0413Y5u+RWlVuulDr7KQI4Lmx+YC6dw99Q6JAxPEl FODA+o7Si722uZZSdKlpH9cDzlJ1oZWTXqvlL6dclPQ3HE1+
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

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

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 125f477c34c1..7765c3deccd6 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -447,22 +447,23 @@ static bool inode_do_switch_wbs(struct inode *inode,
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


