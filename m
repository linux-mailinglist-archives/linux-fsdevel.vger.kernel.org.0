Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5F93D8330
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 00:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbhG0Wmm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 18:42:42 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53886 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbhG0Wml (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:42:41 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 52AAE1FF40;
        Tue, 27 Jul 2021 22:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627425759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EUPFwhQ4l0lXEkkNGESyS5BwcbfXYjC/1aLE4BjDLe4=;
        b=kl0n9co+iBonCLM/u0/Pfx7Yl/a9T5BQ2njBwHoMgpDE2exuUyRN9nXAVFDso8k9raZXnK
        W5p4kNWedyIjumCLQz2XoJDrZ4ND9xY0umMBOM+jyVNLC3PisvN+5IJdNEIomWvujh+e8Z
        ec3jcVWxdiN0n0sbdvgY+cBnfAdQVdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627425759;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EUPFwhQ4l0lXEkkNGESyS5BwcbfXYjC/1aLE4BjDLe4=;
        b=Of5rBFkryDtdNvTQ72fjf5pezhSy9A+sJiILBS/I15WgplE0J09V5KoRLDFBml1vPYxPTo
        Ffz7uhXr6cfR5eCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E09313A5D;
        Tue, 27 Jul 2021 22:42:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HhFlC9yLAGGPVQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 27 Jul 2021 22:42:36 +0000
Subject: [PATCH 01/11] VFS: show correct dev num in mountinfo
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
Message-ID: <162742546548.32498.10889023150565429936.stgit@noble.brown>
In-Reply-To: <162742539595.32498.13687924366155737575.stgit@noble.brown>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

/proc/$PID/mountinfo contains a field for the device number of the
filesystem at each mount.

This is taken from the superblock ->s_dev field, which is correct for
every filesystem except btrfs.  A btrfs filesystem can contain multiple
subvols which each have a different device number.  If (a directory
within) one of these subvols is mounted, the device number reported in
mountinfo will be different from the device number reported by stat().

This confuses some libraries and tools such as, historically, findmnt.
Current findmnt seems to cope with the strangeness.

So instead of using ->s_dev, call vfs_getattr_nosec() and use the ->dev
provided.  As there is no STATX flag to ask for the device number, we
pass a request mask for zero, and also ask the filesystem to avoid
syncing with any remote service.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/proc_namespace.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 392ef5162655..f342a0231e9e 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -138,10 +138,16 @@ static int show_mountinfo(struct seq_file *m, struct vfsmount *mnt)
 	struct mount *r = real_mount(mnt);
 	struct super_block *sb = mnt->mnt_sb;
 	struct path mnt_path = { .dentry = mnt->mnt_root, .mnt = mnt };
+	struct kstat stat;
 	int err;
 
+	/* We only want ->dev, and there is no STATX flag for that,
+	 * so ask for nothing and assume we get ->dev
+	 */
+	vfs_getattr_nosec(&mnt_path, &stat, 0, AT_STATX_DONT_SYNC);
+
 	seq_printf(m, "%i %i %u:%u ", r->mnt_id, r->mnt_parent->mnt_id,
-		   MAJOR(sb->s_dev), MINOR(sb->s_dev));
+		   MAJOR(stat.dev), MINOR(stat.dev));
 	if (sb->s_op->show_path) {
 		err = sb->s_op->show_path(m, mnt->mnt_root);
 		if (err)


