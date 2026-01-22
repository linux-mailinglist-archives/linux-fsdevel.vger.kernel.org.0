Return-Path: <linux-fsdevel+bounces-75003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ICfMuz3cWmvZwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 11:11:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDF9650FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 11:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09A175EAF48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 10:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3ED349AF5;
	Thu, 22 Jan 2026 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pJC1znOe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O1bbz291";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pZjEUgCS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aKosdbzv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD4333A9F4
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076258; cv=none; b=fSWr77obsXjADSiUoL1OcKuMHZ6DX4Ax1iucV8KPwKWbovvEZk4sR1yaY5JO8EmoZ6UXzxQKYK8G++5cK2udVz70xhoKVYHIOkFJo/7E3Pgp90at9N1QtOVc8/NZOjIgJx7cMnNmqDu/DFwFl42qQCVhY5jJXu33ec0y5r3C/Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076258; c=relaxed/simple;
	bh=4P4LlUvWbd8ldQ3qfNeyHfqT62rCjhyQ8JQlNmyFG/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQJ+wq0/GbXVwakyszXBSxruZ7lZPXUxdG3xKKFOFf0Kgd72Y/2E61yTj/UEdKV51XzkG+vV2rMdIxoBoQSiCw+9K+1e54Jes3g4otl4dYp2s8ObDlRBXyQI+KipxZRto/wXI0C8Qt93Ta+4iSghCo4GiwevlxbQwODwFa7ys4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pJC1znOe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O1bbz291; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pZjEUgCS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aKosdbzv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4E8A25BCC8;
	Thu, 22 Jan 2026 10:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769076254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UZ/XmaREgp8GNWAvARGhfYlge3VlZ7ChZAFPXfehaIc=;
	b=pJC1znOeozvNpApP9ZvgY1nhJoz2P4A8gH2U7ydHwi8dz587n/RZfzymd29pLdVaSE8VNY
	xuPrtJcySdIu1jmfBRK/BSYX18rJfjWceg8GibSbQRFfYsO1f8MkmR7brXU4kLBHhOXZ9u
	tcEDMUw9pnbdYrug2cguoYx7vrxQVOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769076254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UZ/XmaREgp8GNWAvARGhfYlge3VlZ7ChZAFPXfehaIc=;
	b=O1bbz291iB8TO4ppKbeIrcrwzUXlv+r75Gysl0aH5pT3E7LzSkmBv6cVKNNtZDzvG5JgRv
	X0FputpE3GVEvdDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769076253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UZ/XmaREgp8GNWAvARGhfYlge3VlZ7ChZAFPXfehaIc=;
	b=pZjEUgCS16WLj4Pupd6wZobBBbWWG7Y8lZQbLhReP6bxlCjK2yijmMdHlNvQBsrBlswmYV
	4Z0Xln1UFFsChSxWkXSGw5unXnexCzqVEcKl+Rs9DyfIkBtfg+CEgVcEf3DXq2BDd9JnOI
	Ra5nnChQfYD5KEZDlgqcI4trgr0NMEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769076253;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UZ/XmaREgp8GNWAvARGhfYlge3VlZ7ChZAFPXfehaIc=;
	b=aKosdbzvsASjBiRtJ97pxX2f7QbLBCv82rhQhOtxJ1pBFJTdqcqoLaFuV5eyKivZtkgH5g
	a++aS783cclYKdCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3791813978;
	Thu, 22 Jan 2026 10:04:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AEaLDR32cWl+IQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 22 Jan 2026 10:04:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F2711A082E; Thu, 22 Jan 2026 11:04:12 +0100 (CET)
Date: Thu, 22 Jan 2026 11:04:12 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] fsnotify: Use connector list for destroying inode
 marks
Message-ID: <zx4boczfwcbu5a6vcmalup6ogcqlqg2sbn5ex7rbidd3rdwr7s@2exh6w7hypi3>
References: <20260121135513.12008-1-jack@suse.cz>
 <20260121135948.8448-5-jack@suse.cz>
 <CAOQ4uxg4HrLqizEdgc8TUaZOUbBTR1if0SBSwxeu5VKAwU5FBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zgangunqkhoupvkv"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxg4HrLqizEdgc8TUaZOUbBTR1if0SBSwxeu5VKAwU5FBA@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75003-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,suse.com:email,suse.cz:email,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1EDF9650FE
X-Rspamd-Action: no action


--zgangunqkhoupvkv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed 21-01-26 17:27:45, Amir Goldstein wrote:
> On Wed, Jan 21, 2026 at 3:00 PM Jan Kara <jack@suse.cz> wrote:
> > +               spin_lock(&inode->i_lock);
> > +               if (unlikely(
> > +                   inode_state_read(inode) & (I_FREEING | I_WILL_FREE))) {
> > +                       spin_unlock(&inode->i_lock);
> > +                       continue;
> > +               }
> > +               __iget(inode);
> > +               spin_unlock(&inode->i_lock);
> > +               spin_unlock(&sbinfo->list_lock);
> > +               fsnotify_inode(inode, FS_UNMOUNT);
> > +               fsnotify_clear_marks_by_inode(inode);
> > +               iput(inode);
> > +               cond_resched();
> > +               goto restart;
> > +       }
> 
> This loop looks odd being a while loop that is always restarted for
> the likely branch.
> 
> Maybe would be more clear to add some comment like:
> 
> find_next_inode:
>        /* Find the first non-evicting inodes and free connector and marks */
>        spin_lock(&sbinfo->list_lock);
>        list_for_each_entry(iconn, &sbinfo->inode_conn_list, conns_list) {
> 
> Just a thought.

I agree the loop is perverse and I'm not happy about it either (but at
least it works :)). With a fresh mind: What about the attached variant?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--zgangunqkhoupvkv
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-fsnotify-Use-connector-list-for-destroying-inode-mar.patch"

From e2e6bc81f309f26812455a84f42dddbb6a194847 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Wed, 15 Oct 2025 16:02:47 +0200
Subject: [PATCH 2/3] fsnotify: Use connector list for destroying inode marks

Instead of iterating all inodes belonging to a superblock to find inode
marks and remove them on umount, iterate all inode connectors for the
superblock. This may be substantially faster since there are generally
much less inodes with fsnotify marks than all inodes. It also removes
one use of sb->s_inodes list which we strive to ultimately remove.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/notify/fsnotify.c | 61 +-------------------------------------------
 fs/notify/fsnotify.h |  3 +++
 fs/notify/mark.c     | 50 ++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 60 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 706484fb3bf3..9995de1710e5 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -33,65 +33,6 @@ void __fsnotify_mntns_delete(struct mnt_namespace *mntns)
 	fsnotify_clear_marks_by_mntns(mntns);
 }
 
-/**
- * fsnotify_unmount_inodes - an sb is unmounting.  handle any watched inodes.
- * @sb: superblock being unmounted.
- *
- * Called during unmount with no locks held, so needs to be safe against
- * concurrent modifiers. We temporarily drop sb->s_inode_list_lock and CAN block.
- */
-static void fsnotify_unmount_inodes(struct super_block *sb)
-{
-	struct inode *inode, *iput_inode = NULL;
-
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		/*
-		 * We cannot __iget() an inode in state I_FREEING,
-		 * I_WILL_FREE, or I_NEW which is fine because by that point
-		 * the inode cannot have any associated watches.
-		 */
-		spin_lock(&inode->i_lock);
-		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-
-		/*
-		 * If i_count is zero, the inode cannot have any watches and
-		 * doing an __iget/iput with SB_ACTIVE clear would actually
-		 * evict all inodes with zero i_count from icache which is
-		 * unnecessarily violent and may in fact be illegal to do.
-		 * However, we should have been called /after/ evict_inodes
-		 * removed all zero refcount inodes, in any case.  Test to
-		 * be sure.
-		 */
-		if (!icount_read(inode)) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-
-		__iget(inode);
-		spin_unlock(&inode->i_lock);
-		spin_unlock(&sb->s_inode_list_lock);
-
-		iput(iput_inode);
-
-		/* for each watch, send FS_UNMOUNT and then remove it */
-		fsnotify_inode(inode, FS_UNMOUNT);
-
-		fsnotify_inode_delete(inode);
-
-		iput_inode = inode;
-
-		cond_resched();
-		spin_lock(&sb->s_inode_list_lock);
-	}
-	spin_unlock(&sb->s_inode_list_lock);
-
-	iput(iput_inode);
-}
-
 void fsnotify_sb_delete(struct super_block *sb)
 {
 	struct fsnotify_sb_info *sbinfo = fsnotify_sb_info(sb);
@@ -100,7 +41,7 @@ void fsnotify_sb_delete(struct super_block *sb)
 	if (!sbinfo)
 		return;
 
-	fsnotify_unmount_inodes(sb);
+	fsnotify_unmount_inodes(sbinfo);
 	fsnotify_clear_marks_by_sb(sb);
 	/* Wait for outstanding object references from connectors */
 	wait_var_event(fsnotify_sb_watched_objects(sb),
diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
index 6b58d733ceb6..58c7bb25e571 100644
--- a/fs/notify/fsnotify.h
+++ b/fs/notify/fsnotify.h
@@ -77,6 +77,9 @@ extern struct srcu_struct fsnotify_mark_srcu;
 extern int fsnotify_compare_groups(struct fsnotify_group *a,
 				   struct fsnotify_group *b);
 
+/* Destroy all inode marks for given superblock */
+void fsnotify_unmount_inodes(struct fsnotify_sb_info *sbinfo);
+
 /* Destroy all marks attached to an object via connector */
 extern void fsnotify_destroy_marks(fsnotify_connp_t *connp);
 /* run the list of all marks associated with inode and destroy them */
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 4a525791a2f3..8e6997e9aebb 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -666,6 +666,56 @@ struct fsnotify_inode_mark_connector {
 	struct list_head conns_list;
 };
 
+static struct inode *fsnotify_get_living_inode(struct fsnotify_sb_info *sbinfo)
+{
+	struct fsnotify_inode_mark_connector *iconn;
+	struct inode *inode;
+
+	spin_lock(&sbinfo->list_lock);
+	/* Find the first non-evicting inode */
+	list_for_each_entry(iconn, &sbinfo->inode_conn_list, conns_list) {
+		/* All connectors on the list are still attached to an inode */
+		inode = iconn->common.obj;
+		/*
+		 * For connectors without FSNOTIFY_CONN_FLAG_HAS_IREF
+		 * (evictable marks) corresponding inode may well have 0
+		 * refcount and can be undergoing eviction. OTOH list_lock
+		 * protects us from the connector getting detached and inode
+		 * freed. So we can poke around the inode safely.
+		 */
+		spin_lock(&inode->i_lock);
+		if (likely(
+		    !(inode_state_read(inode) & (I_FREEING | I_WILL_FREE)))) {
+			__iget(inode);
+			spin_unlock(&inode->i_lock);
+			spin_unlock(&sbinfo->list_lock);
+			return inode;
+		}
+		spin_unlock(&inode->i_lock);
+	}
+	spin_unlock(&sbinfo->list_lock);
+
+	return NULL;
+}
+
+/**
+ * fsnotify_unmount_inodes - an sb is unmounting. Handle any watched inodes.
+ * @sbinfo: fsnotify info for superblock being unmounted.
+ *
+ * Walk all inode connectors for the superblock and free all associated marks.
+ */
+void fsnotify_unmount_inodes(struct fsnotify_sb_info *sbinfo)
+{
+	struct inode *inode;
+
+	while ((inode = fsnotify_get_living_inode(sbinfo))) {
+		fsnotify_inode(inode, FS_UNMOUNT);
+		fsnotify_clear_marks_by_inode(inode);
+		iput(inode);
+		cond_resched();
+	}
+}
+
 static void fsnotify_init_connector(struct fsnotify_mark_connector *conn,
 				    void *obj, unsigned int obj_type)
 {
-- 
2.51.0


--zgangunqkhoupvkv--

