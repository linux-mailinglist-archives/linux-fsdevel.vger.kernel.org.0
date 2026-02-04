Return-Path: <linux-fsdevel+bounces-76339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOQtHoKEg2llowMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 18:40:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E08FBEB0D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 18:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2F12304074C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 17:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1802B34B404;
	Wed,  4 Feb 2026 17:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="R0Q3oFeK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3B226D4CD;
	Wed,  4 Feb 2026 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770226728; cv=none; b=bkrX6u8xINOwYvG6d8kdRHIYZcjnZJS1hVzmtWIaUXEzaTHoDiVdw3EJZR4goT0IMVfQnwRfK+Wuf9FK956FXkFKfEkSlnjmcRBMNdmmUHYpVujswnjVWYIoDH1MIeFR/qhAI4G3s49Z9Aclb6XCaIlSFgi2t7e049fP6ZHd1Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770226728; c=relaxed/simple;
	bh=cS+EuC5p1VMrOtkLCLVxJ+xUKQ3y/RVuNEVJZno12Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvtvhjSwtiYxPgMimFtOzvFSTpypSTUwper5gPaNZOuN6yMsPNYgpwXaYPpIs6lPm7JoxQyFrHjRYyKCbEjJ2o/+8+59K4WXj0ABDNi27rRaGzCXJj36Mpp0rqQwmljxDsOfzIcdjnhtHwGAiQ6qzj4n9CoAJgs+EILOrczrnAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=R0Q3oFeK; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=61pfU41i5sIOIevtxeUy3MqUaNFG40wWbGOMRZnMY+Q=; b=R0Q3oFeKKUSAy462Qfa3KQ8o/U
	SZaWwzgsnN4ZsU5fiwZ2mTsHxb5+doHBc1zDgnjGSqKnEoNNylQx+yW9H6ium7Nnk43VCLh/0JNfn
	InQWwRCXUae4k4DF3GLajqq9VBnoP9S9Zf2M/wwwQ/32nhaxdX7Rsg+0rGeucKox2Q4+53DXt7TbI
	lE7Tv7PhMmbMEFcV/HHf7FrYLCcrlRs48jb8tx/b1NyN5rARBlumQfY3Ue8k4QzIEdXG6FF9Mylig
	SyDYsh4/ZqCWcNeTrmoJlR/tf/OTLpScUQMDvDi+t8UMI4O6pAIiJ7vmxMSPJhunXSFtggK1Y2YqE
	im43hyAg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vngrv-00000005HST-3gh5;
	Wed, 04 Feb 2026 17:40:47 +0000
Date: Wed, 4 Feb 2026 17:40:47 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "shardulsb08@gmail.com" <shardulsb08@gmail.com>,
	"jack@suse.cz" <jack@suse.cz>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"shardul.b@mpiricsoftware.com" <shardul.b@mpiricsoftware.com>,
	"glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"janak@mpiricsoftware.com" <janak@mpiricsoftware.com>,
	"syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com" <syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com>
Subject: Re: [PATCH v2] hfsplus: fix s_fs_info leak on mount setup failure
Message-ID: <20260204174047.GM3183987@ZenIV>
References: <20260201131229.4009115-1-shardul.b@mpiricsoftware.com>
 <cace4df975e1ae6e31af0103efcbca9cdb8b8350.camel@ibm.com>
 <20260203043806.GF3183987@ZenIV>
 <b9374ab2503627e0dd6f62a29ab5dcde9fc0354f.camel@ibm.com>
 <20260204173029.GL3183987@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204173029.GL3183987@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76339-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,vivo.com,kernel.org,vger.kernel.org,dubeyko.com,mpiricsoftware.com,physik.fu-berlin.de,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel,99f6ed51479b86ac4c41];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:dkim,folder.id:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E08FBEB0D0
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 05:30:29PM +0000, Al Viro wrote:

> While we are at it, this
>         kfree(sbi->s_vhdr_buf);
> 	kfree(sbi->s_backup_vhdr_buf);
> might as well go into ->kill_sb().  That would result in the (untested)
> delta below and IMO it's easier to follow that way...

AFAICS once you've got ->s_root set, you can just return an error and
be done with that - regular cleanup should take care of those parts
(note that iput(NULL) is explicitly a no-op and the same goes for
cancel_delayed_work_sync() on something that has never been through
queue_delayed_work()).

Incremental to the previous would be

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 6ce4d121e446..94fbc68e1bd1 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -560,26 +560,23 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 		err = -ENOMEM;
 		goto out_put_alloc_file;
 	}
+	/* from that point on we just return an error on failure */
 
 	str.len = sizeof(HFSP_HIDDENDIR_NAME) - 1;
 	str.name = HFSP_HIDDENDIR_NAME;
 	err = hfs_find_init(sbi->cat_tree, &fd);
 	if (err)
-		goto out_put_root;
+		return err;
 	err = hfsplus_cat_build_key(sb, fd.search_key, HFSPLUS_ROOT_CNID, &str);
 	if (unlikely(err < 0))
-		goto out_put_root;
+		return err;
 	if (!hfs_brec_read(&fd, &entry, sizeof(entry))) {
 		hfs_find_exit(&fd);
-		if (entry.type != cpu_to_be16(HFSPLUS_FOLDER)) {
-			err = -EIO;
-			goto out_put_root;
-		}
+		if (entry.type != cpu_to_be16(HFSPLUS_FOLDER))
+			return -EIO;
 		inode = hfsplus_iget(sb, be32_to_cpu(entry.folder.id));
-		if (IS_ERR(inode)) {
-			err = PTR_ERR(inode);
-			goto out_put_root;
-		}
+		if (IS_ERR(inode))
+			return PTR_ERR(inode);
 		sbi->hidden_dir = inode;
 	} else
 		hfs_find_exit(&fd);
@@ -597,14 +594,13 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 			sbi->hidden_dir = hfsplus_new_inode(sb, root, S_IFDIR);
 			if (!sbi->hidden_dir) {
 				mutex_unlock(&sbi->vh_mutex);
-				err = -ENOMEM;
-				goto out_put_root;
+				return -ENOMEM;
 			}
 			err = hfsplus_create_cat(sbi->hidden_dir->i_ino, root,
 						 &str, sbi->hidden_dir);
 			if (err) {
 				mutex_unlock(&sbi->vh_mutex);
-				goto out_put_hidden_dir;
+				return err;
 			}
 
 			err = hfsplus_init_security(sbi->hidden_dir,
@@ -619,7 +615,7 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 				hfsplus_delete_cat(sbi->hidden_dir->i_ino,
 							root, &str);
 				mutex_unlock(&sbi->vh_mutex);
-				goto out_put_hidden_dir;
+				return err;
 			}
 
 			mutex_unlock(&sbi->vh_mutex);
@@ -632,12 +628,6 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbi->nls = nls;
 	return 0;
 
-out_put_hidden_dir:
-	cancel_delayed_work_sync(&sbi->sync_work);
-	iput(sbi->hidden_dir);
-out_put_root:
-	dput(sb->s_root);
-	sb->s_root = NULL;
 out_put_alloc_file:
 	iput(sbi->alloc_file);
 out_close_attr_tree:

