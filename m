Return-Path: <linux-fsdevel+bounces-2401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA597E5B00
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 17:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29B17B20E5A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 16:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3802830FAF;
	Wed,  8 Nov 2023 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnkIHOyv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11C031593;
	Wed,  8 Nov 2023 16:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE99C433C7;
	Wed,  8 Nov 2023 16:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699460416;
	bh=XiPOVn8w0c1M28EzUm0NGR3MsVQpxJYBnwBHYh0XaJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KnkIHOyv6KecafHR1LZJ7iJYCE2kl8jEHwUXXGa6euXi3QXQ8WZK0WJlneiCIOu2t
	 BVRYgO2FxReaXX5iqpA2EU68B+421vAkAuQgAn/p/Jq9qHS2gWtWR3w5Z/eqH2m2ru
	 iq1WR0WuY7XOEKqcx0vAbd0W9hOyfBgLNGANGmwwG1M6yN9LmIFRshIPMoHF/vIJJc
	 WrUR3TE6HC+EBiOE4pk48calYqNlyTKjcDBZurvQCC0OKL+T2FGkWEQo+GbPhp7Kkw
	 MXYhJgQ4cbwBpuzPjNTa0J4DfO64y+vhakDKyeUa/O2rc+E9aFkjj/rHjQOxrzJZbk
	 F3u8CAMoWo3iw==
Date: Wed, 8 Nov 2023 17:20:06 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231108-herleiten-bezwangen-ffb2821f539e@brauner>
References: <20231106-fragment-geweigert-1d80138523e5@brauner>
 <ZUjcI1SE+a2t8n1v@infradead.org>
 <20231106-unser-fiskus-9d1eba9fc64c@brauner>
 <ZUker5S8sZXnsvOl@infradead.org>
 <20231106224210.GA3812457@perftesting>
 <20231107-leiden-drinnen-913c37d86f37@brauner>
 <ZUs+MkCMkTPs4EtQ@infradead.org>
 <20231108-zertreten-disqualifikation-bd170f2e8afb@brauner>
 <ZUuWSVgRT3k/hanT@infradead.org>
 <20231108-atemwege-polterabend-694ca7612cf8@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231108-atemwege-polterabend-694ca7612cf8@brauner>

On Wed, Nov 08, 2023 at 05:16:38PM +0100, Christian Brauner wrote:
> On Wed, Nov 08, 2023 at 06:08:09AM -0800, Christoph Hellwig wrote:
> > On Wed, Nov 08, 2023 at 09:27:44AM +0100, Christian Brauner wrote:
> > > > What is that flag going to buy us?
> > > 
> > > The initial list that Josef provided in
> > > https://lore.kernel.org/linux-btrfs/20231025210654.GA2892534@perftesting
> > > asks to give users a way to figure out whether a file is located on a
> > > subvolume. Which I think is reasonable and there's a good chunk of
> > > software out there that could really benefit from this. Now all of the

I explained myself badly here. What I mean and what is immediately
useful is to add STATX_ATTR_SUBVOLUME_ROOT which works for both btrfs
and bcachefs and makes it easy for userspace to figure out whether an
inode is the root of a subvolume:

(This won't compile obviously.)

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 166d8d8abe68..fce8603d37b0 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -776,6 +776,10 @@ static int bch2_getattr(struct mnt_idmap *idmap,
                stat->attributes |= STATX_ATTR_NODUMP;
        stat->attributes_mask    |= STATX_ATTR_NODUMP;

+       if (BTRFS_is_subvol_root(inode))
+               stat->attributes_mask |= STATX_ATTR_SUBVOLUME_ROOT;
+       stat->attributes_mask |= STATX_ATTR_SUBVOLUME_ROOT;
+
        return 0;
 }

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5e3fccddde0c..c339a9a08d7e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8657,10 +8657,14 @@ static int btrfs_getattr(struct mnt_idmap *idmap,
        if (bi_ro_flags & BTRFS_INODE_RO_VERITY)
                stat->attributes |= STATX_ATTR_VERITY;

+       if (BCH2_is_subvol_root(inode))
+               stat->attributes        |= STATX_ATTR_SUBVOLUME_ROOT;
+
        stat->attributes_mask |= (STATX_ATTR_APPEND |
                                  STATX_ATTR_COMPRESSED |
                                  STATX_ATTR_IMMUTABLE |
-                                 STATX_ATTR_NODUMP);
+                                 STATX_ATTR_NODUMP |
+                                 STATX_ATTR_SUBVOLUME_ROOT);

        generic_fillattr(idmap, request_mask, inode, stat);
        stat->dev = BTRFS_I(inode)->root->anon_dev;
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 7cab2c65d3d7..24d493babe63 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -187,6 +187,7 @@ struct statx {
 #define STATX_ATTR_ENCRYPTED           0x00000800 /* [I] File requires key to decrypt in fs */
 #define STATX_ATTR_AUTOMOUNT           0x00001000 /* Dir: Automount trigger */
 #define STATX_ATTR_MOUNT_ROOT          0x00002000 /* Root of a mount */
+#define STATX_ATTR_SUBVOLUME_ROOT      0x00004000 /* Root of a subvolume */
 #define STATX_ATTR_VERITY              0x00100000 /* [I] Verity protected file */
 #define STATX_ATTR_DAX                 0x00200000 /* File is currently in DAX state */

This would be a pretty big help for userspace already.

Right now all code needs to do a stat() and a statfs() and then check
the inode number. And that likely only works for btrfs.

This would also allow tools that want to to detect when they're crossing
into a new subvolume - be it on btrfs or bcachefs - and take appropriate
measures deciding what they want to do just relying on statx() without
any additional system calls.

And I think that's something we should do.

