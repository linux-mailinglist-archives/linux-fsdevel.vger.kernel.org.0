Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C2C4BEF4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 03:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbiBVB4v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 20:56:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbiBVB4t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 20:56:49 -0500
Received: from out20-39.mail.aliyun.com (out20-39.mail.aliyun.com [115.124.20.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D917425C4E;
        Mon, 21 Feb 2022 17:56:22 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04438479|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.178653-0.00896939-0.812378;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.Mth-WDF_1645494979;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Mth-WDF_1645494979)
          by smtp.aliyun-inc.com(33.45.47.205);
          Tue, 22 Feb 2022 09:56:20 +0800
Date:   Tue, 22 Feb 2022 09:56:22 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     "NeilBrown" <neilb@suse.de>
Subject: Re: [PATCH] fs: allow cross-vfsmount reflink/dedupe
Cc:     "Josef Bacik" <josef@toxicpanda.com>, viro@ZenIV.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
In-Reply-To: <164548762019.8827.10420692800919301859@noble.neil.brown.name>
References: <164548078112.17923.854375583220948734@noble.neil.brown.name> <164548762019.8827.10420692800919301859@noble.neil.brown.name>
Message-Id: <20220222095622.1F0C.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

> On Tue, 22 Feb 2022, NeilBrown wrote:
> > On Thu, 17 Feb 2022, Wang Yugui wrote:
> > > Hi,
> > > 
> > > > On Thu, 17 Feb 2022, Wang Yugui wrote:
> > > > > Hi,
> > > > > Cc: NeilBrown
> > > > > 
> > > > > btrfs cross-vfsmount reflink works well now with these 2 patches.
> > > > > 
> > > > > [PATCH] fs: allow cross-vfsmount reflink/dedupe
> > > > > [PATCH] btrfs: remove the cross file system checks from remap
> > > > > 
> > > > > But nfs over btrfs still fail to do cross-vfsmount reflink.
> > > > > need some patch for nfs too?
> > > > 
> > > > NFS doesn't support reflinks at all, does it?
> > > 
> > > NFS support reflinks now.
> > > 
> > > # df -h /ssd
> > > Filesystem              Type  Size  Used Avail Use% Mounted on
> > > T640:/ssd               nfs4   17T  5.5T   12T  34% /ssd
> > > # /bin/cp --reflink=always /ssd/1.txt /ssd/2.txt
> > > # uname -a
> > > Linux T7610 5.15.24-3.el7.x86_64 #1 SMP Thu Feb 17 12:13:25 CST 2022 x86_64 x86_64 x86_64 GNU/Linux
> > > 
> > 
> > So it does ..... ahhh, the CLONE command in NFSv4.2.....
> > This is used by the .remap_file_range file operation.  That operation
> > only gets called when the "from" and "to" files have the same
> > superblock.
> > btrfs has an ....  interesting concept of filesystem identity.  While
> > different "subvols" have the same superblock locally, when they are
> > exported over NFS they appear to be different filesystems and so have
> > different superblocks.  This is in part because btrfs cannot create
> > properly unique inode numbers across the whole filesystem.
> > Until btrfs sorts itself out, it will not be able to work with NFS
> > properly.
> 
> Actually, that might be a little bit simplistic...
> 
> How are you exporting the btfs filesystem on the server.
> If you are exporting each subvolume separately, then they probably look
> like different filesystems to NFS.  If you export just the top level and
> allow the subvolumes to be accessed by name, then they should have the
> same superblock and reflink should work.
> 
> NeilBrown

struct vfsmount {
	struct dentry *mnt_root;	/* root of the mounted tree */
	struct super_block *mnt_sb;	/* pointer to superblock */
	int mnt_flags;
	struct user_namespace *mnt_userns;
} __randomize_layout;

for local mount of btrfs different subvols, there are 1 same attr and 2
different attr.
same attr:
	struct super_block *mnt_sb
different:
	struct dentry *mnt_root;
	subvol attr; to save it in struct user_namespace?

for nfs mount of btrfs different subvols, there maybe similar way?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/02/22


