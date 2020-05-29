Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC101E7470
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 06:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgE2ERn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 00:17:43 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34700 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727875AbgE2ERm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 00:17:42 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 04T4HIhU009522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 May 2020 00:17:18 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D8E4D420304; Fri, 29 May 2020 00:17:17 -0400 (EDT)
Date:   Fri, 29 May 2020 00:17:17 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     ira.weiny@intel.com
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 0/9] Enable ext4 support for per-file/directory DAX
 operations
Message-ID: <20200529041717.GN228632@mit.edu>
References: <20200528150003.828793-1-ira.weiny@intel.com>
 <20200529025441.GI228632@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529025441.GI228632@mit.edu>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 28, 2020 at 10:54:41PM -0400, Theodore Y. Ts'o wrote:
> 
> Thanks, applied to the ext4-dax branch.
> 

I spoke too soon.  While I tried merging with the ext4.git dev branch,
a merge conflict made me look closer and I realize I needed to make
the following changes (see diff between your patch set and what is
currently in ext4-dax).

Essentially, I needed to rework the branch to take into account commit
e0198aff3ae3 ("ext4: reject mount options not supported when
remounting in handle_mount_opt()").

The problem is that if you allow handle_mount_opt() to apply the
changes to the dax settings, and then later on, ext4_remount() realize
that we're remounting, and we need to reject the change, there's a
race if we restore the mount options to the original configuration.
Specifically, as Syzkaller pointed out, between when we change the dax
settings and then reset them, it's possible for some file to be opened
with "wrong" dax setting, and then when they are reset, *boom*.

The correct way to deal with this is to reject the mount option change
much earlier, in handle_mount_opt(), *before* we mess with the dax
settings.

Please take a look at the ext4-dax for the actual changes which I
made.

Cheers,

					- Ted


diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 3658e3016999..9a37d70394b2 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1733,7 +1733,7 @@ static int clear_qf_name(struct super_block *sb, int qtype)
 #define MOPT_NO_EXT3	0x0200
 #define MOPT_EXT4_ONLY	(MOPT_NO_EXT2 | MOPT_NO_EXT3)
 #define MOPT_STRING	0x0400
-#define MOPT_SKIP	0x0800
+#define MOPT_NO_REMOUNT	0x0800
 
 static const struct mount_opts {
 	int	token;
@@ -1783,18 +1783,15 @@ static const struct mount_opts {
 	{Opt_min_batch_time, 0, MOPT_GTE0},
 	{Opt_inode_readahead_blks, 0, MOPT_GTE0},
 	{Opt_init_itable, 0, MOPT_GTE0},
-	{Opt_dax, EXT4_MOUNT_DAX_ALWAYS, MOPT_SET | MOPT_SKIP},
-	{Opt_dax_always, EXT4_MOUNT_DAX_ALWAYS,
-		MOPT_EXT4_ONLY | MOPT_SET | MOPT_SKIP},
-	{Opt_dax_inode, EXT4_MOUNT2_DAX_INODE,
-		MOPT_EXT4_ONLY | MOPT_SET | MOPT_SKIP},
-	{Opt_dax_never, EXT4_MOUNT2_DAX_NEVER,
-		MOPT_EXT4_ONLY | MOPT_SET | MOPT_SKIP},
+	{Opt_dax, 0, MOPT_NO_REMOUNT},
+	{Opt_dax_always, 0, MOPT_NO_REMOUNT},
+	{Opt_dax_inode, 0, MOPT_NO_REMOUNT},
+	{Opt_dax_never, 0, MOPT_NO_REMOUNT},
 	{Opt_stripe, 0, MOPT_GTE0},
 	{Opt_resuid, 0, MOPT_GTE0},
 	{Opt_resgid, 0, MOPT_GTE0},
-	{Opt_journal_dev, 0, MOPT_NO_EXT2 | MOPT_GTE0},
-	{Opt_journal_path, 0, MOPT_NO_EXT2 | MOPT_STRING},
+	{Opt_journal_dev, 0, MOPT_NO_EXT2 | MOPT_GTE0 | MOPT_NO_REMOUNT},
+	{Opt_journal_path, 0, MOPT_NO_EXT2 | MOPT_STRING | MOPT_NO_REMOUNT},
 	{Opt_journal_ioprio, 0, MOPT_NO_EXT2 | MOPT_GTE0},
 	{Opt_data_journal, EXT4_MOUNT_JOURNAL_DATA, MOPT_NO_EXT2 | MOPT_DATAJ},
 	{Opt_data_ordered, EXT4_MOUNT_ORDERED_DATA, MOPT_NO_EXT2 | MOPT_DATAJ},
@@ -1831,7 +1828,7 @@ static const struct mount_opts {
 	{Opt_jqfmt_vfsv1, QFMT_VFS_V1, MOPT_QFMT},
 	{Opt_max_dir_size_kb, 0, MOPT_GTE0},
 	{Opt_test_dummy_encryption, 0, MOPT_GTE0},
-	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
+	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET | MOPT_NO_REMOUNT},
 	{Opt_err, 0, 0}
 };
 
@@ -1929,6 +1926,12 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
 			 "Mount option \"%s\" incompatible with ext3", opt);
 		return -1;
 	}
+	if ((m->flags & MOPT_NO_REMOUNT) && is_remount) {
+		ext4_msg(sb, KERN_ERR,
+			 "Mount option \"%s\" not supported when remounting",
+			 opt);
+		return -1;
+	}
 
 	if (args->from && !(m->flags & MOPT_STRING) && match_int(args, &arg))
 		return -1;
@@ -2008,11 +2011,6 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
 		}
 		sbi->s_resgid = gid;
 	} else if (token == Opt_journal_dev) {
-		if (is_remount) {
-			ext4_msg(sb, KERN_ERR,
-				 "Cannot specify journal on remount");
-			return -1;
-		}
 		*journal_devnum = arg;
 	} else if (token == Opt_journal_path) {
 		char *journal_path;
@@ -2020,11 +2018,6 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
 		struct path path;
 		int error;
 
-		if (is_remount) {
-			ext4_msg(sb, KERN_ERR,
-				 "Cannot specify journal on remount");
-			return -1;
-		}
 		journal_path = match_strdup(&args[0]);
 		if (!journal_path) {
 			ext4_msg(sb, KERN_ERR, "error: could not dup "
@@ -2287,7 +2280,7 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
 	for (m = ext4_mount_opts; m->token != Opt_err; m++) {
 		int want_set = m->flags & MOPT_SET;
 		if (((m->flags & (MOPT_SET|MOPT_CLEAR)) == 0) ||
-		    (m->flags & MOPT_CLEAR_ERR) || m->flags & MOPT_SKIP)
+		    (m->flags & MOPT_CLEAR_ERR))
 			continue;
 		if (!nodefs && !(m->mount_opt & (sbi->s_mount_opt ^ def_mount_opt)))
 			continue; /* skip if same as the default */
@@ -5474,24 +5467,6 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 		}
 	}
 
-	if ((sbi->s_mount_opt ^ old_opts.s_mount_opt) & EXT4_MOUNT_NO_MBCACHE) {
-		ext4_msg(sb, KERN_ERR, "can't enable nombcache during remount");
-		err = -EINVAL;
-		goto restore_opts;
-	}
-
-	if ((sbi->s_mount_opt ^ old_opts.s_mount_opt) & EXT4_MOUNT_DAX_ALWAYS ||
-	    (sbi->s_mount_opt2 ^ old_opts.s_mount_opt2) & EXT4_MOUNT2_DAX_NEVER ||
-	    (sbi->s_mount_opt2 ^ old_opts.s_mount_opt2) & EXT4_MOUNT2_DAX_INODE) {
-		ext4_msg(sb, KERN_WARNING, "warning: refusing change of "
-			"dax mount option with busy inodes while remounting");
-		sbi->s_mount_opt &= ~EXT4_MOUNT_DAX_ALWAYS;
-		sbi->s_mount_opt |= old_opts.s_mount_opt & EXT4_MOUNT_DAX_ALWAYS;
-		sbi->s_mount_opt2 &= ~(EXT4_MOUNT2_DAX_NEVER | EXT4_MOUNT2_DAX_INODE);
-		sbi->s_mount_opt2 |= old_opts.s_mount_opt2 &
-				     (EXT4_MOUNT2_DAX_NEVER | EXT4_MOUNT2_DAX_INODE);
-	}
-
 	if (sbi->s_mount_flags & EXT4_MF_FS_ABORTED)
 		ext4_abort(sb, EXT4_ERR_ESHUTDOWN, "Abort forced by user");
 
