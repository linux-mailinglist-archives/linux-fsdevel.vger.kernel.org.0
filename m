Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0373D8354
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 00:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbhG0Wnx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 18:43:53 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57312 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbhG0Wnv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:43:51 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1EA5922236;
        Tue, 27 Jul 2021 22:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627425830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lm7XB6jR4TjnMiZxavOOo4KztvJwCpv6U5v30F4iOGM=;
        b=Ruy1UKS5MFYt+ikokL5kri3piAU9UYkgt7PEvOrIsLbHcZEhZllORnWezNvk6A7RB2slTd
        czUkBE/KdhHqx80je46krijH743QwxUO//XKIMczIEOYKqUVKvew5wyS/K6+UjgI/QVUR1
        HBC/U3YHjy7EAMZ+CFb3fC4ovhW+teg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627425830;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lm7XB6jR4TjnMiZxavOOo4KztvJwCpv6U5v30F4iOGM=;
        b=OEAQvFW1Q330kWqehW6WoRxhd+EvDE7JGKS4U7ymQgJuDbfwBYnCZH1J+uTMJagralu77U
        MOpBbC8+su+CkhAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3ABFD13A5D;
        Tue, 27 Jul 2021 22:43:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hGaHOiKMAGHnVQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 27 Jul 2021 22:43:46 +0000
Subject: [PATCH 10/11] btrfs: introduce mapping function from location to inum
From:   NeilBrown <neilb@suse.de>
To:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Date:   Wed, 28 Jul 2021 08:37:45 +1000
Message-ID: <162742546557.32498.956193040064011710.stgit@noble.brown>
In-Reply-To: <162742539595.32498.13687924366155737575.stgit@noble.brown>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A btrfs directory entry can refer to two different sorts of objects

 BTRFS_INODE_ITEM_KEY - a regular fs object (file, dir, etc)
 BTRFS_ROOT_ITEM_KEY  - a reference to a subvol.

The 'objectid' numbers for these two are independent, so it is possible
(and common) for an INODE and a ROOT to have the same objectid.

As readdir reports the objectid as the inode number, if two such are in
the same directory, a tool which examines the inode numbers in getdents
results could think they are links.

As the BTRFS_ROOT_ITEM_KEY objectid is not visible via stat() (only
getdents), this is rarely if ever a problem.  However a future patch
will expose this number as the i_ino of an automount point.  This will
cause problems if the objectid is used as-is.

So: create a simple mapping function to reduce (or eliminate?) the
possibility of conflict.  The objectid of BTRFS_ROOT_ITEM_KEY is
subtracted from ULONG_MAX to make an inode number.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/btrfs/btrfs_inode.h |   10 ++++++++++
 fs/btrfs/inode.c       |    3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index c652e19ad74e..a4b5f38196e6 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -328,6 +328,16 @@ static inline bool btrfs_inode_in_log(struct btrfs_inode *inode, u64 generation)
 	return ret;
 }
 
+static inline unsigned long btrfs_location_to_ino(struct btrfs_key *location)
+{
+	if (location->type == BTRFS_INODE_ITEM_KEY)
+		return location->objectid;
+	/* Probably BTRFS_ROOT_ITEM_KEY, try to keep the inode
+	 * numbers separate.
+	 */
+	return ULONG_MAX - location->objectid;
+}
+
 struct btrfs_dio_private {
 	struct inode *inode;
 	u64 logical_offset;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8f60314c36c5..02537c1a9763 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6136,7 +6136,8 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 		put_unaligned(fs_ftype_to_dtype(btrfs_dir_type(leaf, di)),
 				&entry->type);
 		btrfs_dir_item_key_to_cpu(leaf, di, &location);
-		put_unaligned(location.objectid, &entry->ino);
+		put_unaligned(btrfs_location_to_ino(&location),
+			      &entry->ino);
 		put_unaligned(found_key.offset, &entry->offset);
 		entries++;
 		addr += sizeof(struct dir_entry) + name_len;


