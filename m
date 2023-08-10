Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E704777800F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 20:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbjHJSO0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 14:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjHJSOZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:14:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEA9E4B;
        Thu, 10 Aug 2023 11:14:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B203A1F45B;
        Thu, 10 Aug 2023 18:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691691263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EtACbPUf2jciroUOwqpt2N6vNFZggLTp4OAzqG/4taE=;
        b=y0bjlm1WNB3Ygc3dgC3Kv8bc5ZJyIxCe9ta+2EwqzpPoGdBb6TSGISmCiwJa3S+0U7Q35G
        +4djJF18Qc6Z1325CwpU9HDJU/IBkfJZfzExHWfm0GZE8wxvxQXYKjn8MGr08DUX4RI9m+
        jxkKrBwNHD6TBJZX6w5lOET4v8eOeCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691691263;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EtACbPUf2jciroUOwqpt2N6vNFZggLTp4OAzqG/4taE=;
        b=7PjYFUIKEw1GXEov7YN9IhoFXZPsyn4524+pgBxoltMvENURUdC4NVCBm+H0l+iWNYGZT1
        L46pv46dVdE2PXBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C4B6138E2;
        Thu, 10 Aug 2023 18:14:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o0waJv8o1WRkYwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 10 Aug 2023 18:14:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1B1B9A076F; Thu, 10 Aug 2023 20:14:23 +0200 (CEST)
Date:   Thu, 10 Aug 2023 20:14:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 02/12] nilfs2: use setup_bdev_super to de-duplicate the
 mount code
Message-ID: <20230810181423.dfz3lrezwvutls2w@quack3>
References: <20230802154131.2221419-1-hch@lst.de>
 <20230802154131.2221419-3-hch@lst.de>
 <20230803114651.ihtqqgthbdjjgxev@quack3>
 <CAKFNMomzHg33SHnp6xGMEZY=+k6Y4t7dvBvgBDbO9H3ujzNDCw@mail.gmail.com>
 <20230810110547.ks62g2flysgwpgru@quack3>
 <CAKFNMon_3A7dC+k1q_RjEnoXXNtxBJAUQud_FD4s4VrHZdCVzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKFNMon_3A7dC+k1q_RjEnoXXNtxBJAUQud_FD4s4VrHZdCVzg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 11-08-23 01:39:10, Ryusuke Konishi wrote:
> On Thu, Aug 10, 2023 at 8:05 PM Jan Kara wrote:
> >
> > On Fri 04-08-23 11:01:39, Ryusuke Konishi wrote:
> > > On Thu, Aug 3, 2023 at 8:46 PM Jan Kara wrote:
> > > >
> > > > On Wed 02-08-23 17:41:21, Christoph Hellwig wrote:
> > > > > Use the generic setup_bdev_super helper to open the main block device
> > > > > and do various bits of superblock setup instead of duplicating the
> > > > > logic.  This includes moving to the new scheme implemented in common
> > > > > code that only opens the block device after the superblock has allocated.
> > > > >
> > > > > It does not yet convert nilfs2 to the new mount API, but doing so will
> > > > > become a bit simpler after this first step.
> > > > >
> > > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > >
> > > > AFAICS nilfs2 could *almost* use mount_bdev() directly and then just do its
> > >
> > > > snapshot thing after mount_bdev() returns. But it has this weird logic
> > > > that: "if the superblock is already mounted but we can shrink the whole
> > > > dcache, then do remount instead of ignoring mount options". Firstly, this
> > > > looks racy - what prevents someone from say opening a file on the sb just
> > > > after nilfs_tree_is_busy() shrinks dcache? Secondly, it is inconsistent
> > > > with any other filesystem so it's going to surprise sysadmins not
> > > > intimately knowing nilfs2. Thirdly, from userspace you cannot tell what
> > > > your mount call is going to do. Last but not least, what is it really good
> > > > for? Ryusuke, can you explain please?
> > > >
> > > >                                                                 Honza
> > >
> > > I think you are referring to the following part:
> > >
> > > >        if (!s->s_root) {
> > > ...
> > > >        } else if (!sd.cno) {
> > > >                if (nilfs_tree_is_busy(s->s_root)) {
> > > >                        if ((flags ^ s->s_flags) & SB_RDONLY) {
> > > >                                nilfs_err(s,
> > > >                                          "the device already has a %s mount.",
> > > >                                          sb_rdonly(s) ? "read-only" : "read/write");
> > > >                                err = -EBUSY;
> > > >                                goto failed_super;
> > > >                        }
> > > >                } else {
> > > >                        /*
> > > >                         * Try remount to setup mount states if the current
> > > >                         * tree is not mounted and only snapshots use this sb.
> > > >                         */
> > > >                        err = nilfs_remount(s, &flags, data);
> > > >                        if (err)
> > > >                                goto failed_super;
> > > >                }
> > > >        }
> > >
> > > What this logic is trying to do is, if there is already a nilfs2 mount
> > > instance for the device, and are trying to mounting the current tree
> > > (sd.cno is 0, so this is not a snapshot mount), then will switch
> > > depending on whether the current tree has a mount:
> > >
> > > - If the current tree is mounted, it's just like a normal filesystem.
> > > (A read-only mount and a read/write mount can't coexist, so check
> > > that, and reuse the instance if possible)
> > > - Otherwise, i.e. for snapshot mounts only, do whatever is necessary
> > > to add a new current mount, such as starting a log writer.
> > >    Since it does the same thing that nilfs_remount does, so
> > > nilfs_remount() is used there.
> > >
> > > Whether or not there is a current tree mount can be determined by
> > > d_count(s->s_root) > 1 as nilfs_tree_is_busy() does.
> > > Where s->s_root is always the root dentry of the current tree, not
> > > that of the mounted snapshot.
> >
> > I see now, thanks for explanation! But one thing still is not clear to me.
> > If you say have a snapshot mounted read-write and then you mount the
> > current snapshot (cno == 0) read-only, you'll switch the whole superblock
> > to read-only state. So also the mounted snapshot is suddently read-only
> > which is unexpected and actually supposedly breaks things because you can
> > still have file handles open for writing on the snapshot etc.. So how do
> > you solve that?
> >
> >                                                                 Honza
> 
> One thing I have to tell you as a premise is that nilfs2's snapshot
> mounts (cno != 0) are read-only.
> 
> The read-only option is mandatory for nilfs2 snapshot mounts, so
> remounting to read/write mode will result in an error.
> This constraint is checked in nilfs_parse_snapshot_option() which is
> called from nilfs_identify().
> 
> In fact, any write mode file/inode operations on a snapshot mount will
> result in an EROFS error, regardless of whether the coexisting current
> tree mount is read-only or read/write (i.e. regardless of the
> read-only flag of the superblock instance).
> 
> This is mostly (and possibly entirely) accomplished at the vfs layer
> by checking the MNT_READONLY flag in mnt_flags of the vfsmount
> structure, and even on the nilfs2 side,  iops->permission
> (=nilfs_permission) rejects write operations on snapshot mounts.
> 
> Therefore, the problem you pointed out shouldn't occur in the first
> place since the situation where a snapshot with a handle in write mode
> suddenly becomes read-only doesn't happen.   Unless I'm missing
> something..

No, I think you are correct. This particular case should be safe because
MNT_READONLY flags on the mounts used by snapshots will still keep them
read-only even if you remount the superblock to read-write mode for the
current snapshot. So I see why this is useful and I agree this isn't easy
to implement using mount_bdev() so no special code reduction here ;).
Thanks for patient explanation!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
