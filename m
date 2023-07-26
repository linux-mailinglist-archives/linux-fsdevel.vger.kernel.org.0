Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5226E763286
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 11:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbjGZJlJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 05:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGZJlI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:41:08 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D47B100;
        Wed, 26 Jul 2023 02:41:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0VoGYt9._1690364457;
Received: from 30.221.136.164(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VoGYt9._1690364457)
          by smtp.aliyun-inc.com;
          Wed, 26 Jul 2023 17:40:58 +0800
Message-ID: <1da81657-2ee1-0ef3-c222-66e00d021c24@linux.alibaba.com>
Date:   Wed, 26 Jul 2023 17:40:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v6 1/7] fs: pass the request_mask to generic_fillattr
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Anthony Iliopoulos <ailiop@suse.com>, v9fs@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-nfs@vger.kernel.org,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        devel@lists.orangefs.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-mtd@lists.infradead.org,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org
References: <20230725-mgctime-v6-0-a794c2b7abca@kernel.org>
 <20230725-mgctime-v6-1-a794c2b7abca@kernel.org>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20230725-mgctime-v6-1-a794c2b7abca@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/25/23 10:58 PM, Jeff Layton wrote:
> generic_fillattr just fills in the entire stat struct indiscriminately
> today, copying data from the inode. There is at least one attribute
> (STATX_CHANGE_COOKIE) that can have side effects when it is reported,
> and we're looking at adding more with the addition of multigrain
> timestamps.
> 
> Add a request_mask argument to generic_fillattr and have most callers
> just pass in the value that is passed to getattr. Have other callers
> (e.g. ksmbd) just pass in STATX_BASIC_STATS. Also move the setting of
> STATX_CHANGE_COOKIE into generic_fillattr.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/9p/vfs_inode.c       |  4 ++--
>  fs/9p/vfs_inode_dotl.c  |  4 ++--
>  fs/afs/inode.c          |  2 +-
>  fs/btrfs/inode.c        |  2 +-
>  fs/ceph/inode.c         |  2 +-
>  fs/coda/inode.c         |  3 ++-
>  fs/ecryptfs/inode.c     |  5 +++--
>  fs/erofs/inode.c        |  2 +-
>  fs/exfat/file.c         |  2 +-
>  fs/ext2/inode.c         |  2 +-
>  fs/ext4/inode.c         |  2 +-
>  fs/f2fs/file.c          |  2 +-
>  fs/fat/file.c           |  2 +-
>  fs/fuse/dir.c           |  2 +-
>  fs/gfs2/inode.c         |  2 +-
>  fs/hfsplus/inode.c      |  2 +-
>  fs/kernfs/inode.c       |  2 +-
>  fs/libfs.c              |  4 ++--
>  fs/minix/inode.c        |  2 +-
>  fs/nfs/inode.c          |  2 +-
>  fs/nfs/namespace.c      |  3 ++-
>  fs/ntfs3/file.c         |  2 +-
>  fs/ocfs2/file.c         |  2 +-
>  fs/orangefs/inode.c     |  2 +-
>  fs/proc/base.c          |  4 ++--
>  fs/proc/fd.c            |  2 +-
>  fs/proc/generic.c       |  2 +-
>  fs/proc/proc_net.c      |  2 +-
>  fs/proc/proc_sysctl.c   |  2 +-
>  fs/proc/root.c          |  3 ++-
>  fs/smb/client/inode.c   |  2 +-
>  fs/smb/server/smb2pdu.c | 22 +++++++++++-----------
>  fs/smb/server/vfs.c     |  3 ++-
>  fs/stat.c               | 18 ++++++++++--------
>  fs/sysv/itree.c         |  3 ++-
>  fs/ubifs/dir.c          |  2 +-
>  fs/udf/symlink.c        |  2 +-
>  fs/vboxsf/utils.c       |  2 +-
>  include/linux/fs.h      |  2 +-
>  mm/shmem.c              |  2 +-
>  40 files changed, 70 insertions(+), 62 deletions(-)
> 

...

> diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
> index 1b337ebce4df..8184499ae7a5 100644
> --- a/fs/ocfs2/file.c
> +++ b/fs/ocfs2/file.c
> @@ -1319,7 +1319,7 @@ int ocfs2_getattr(struct mnt_idmap *idmap, const struct path *path,
>  		goto bail;
>  	}
>  
> -	generic_fillattr(&nop_mnt_idmap, inode, stat);
> +	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);

For ocfs2 part, looks fine to me.

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>

>  	/*
>  	 * If there is inline data in the inode, the inode will normally not
>  	 * have data blocks allocated (it may have an external xattr block).

...

> diff --git a/fs/stat.c b/fs/stat.c
> index 8c2b30af19f5..062f311b5386 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -29,6 +29,7 @@
>  /**
>   * generic_fillattr - Fill in the basic attributes from the inode struct
>   * @idmap:	idmap of the mount the inode was found from
> + * @req_mask	statx request_mask

s/req_mask/request_mask

>   * @inode:	Inode to use as the source
>   * @stat:	Where to fill in the attributes
>   *
> @@ -42,8 +43,8 @@
>   * uid and gid filds. On non-idmapped mounts or if permission checking is to be
>   * performed on the raw inode simply passs @nop_mnt_idmap.
>   */
> -void generic_fillattr(struct mnt_idmap *idmap, struct inode *inode,
> -		      struct kstat *stat)
> +void generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
> +		      struct inode *inode, struct kstat *stat)
>  {
>  	vfsuid_t vfsuid = i_uid_into_vfsuid(idmap, inode);
>  	vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, inode);
> @@ -61,6 +62,12 @@ void generic_fillattr(struct mnt_idmap *idmap, struct inode *inode,
>  	stat->ctime = inode_get_ctime(inode);
>  	stat->blksize = i_blocksize(inode);
>  	stat->blocks = inode->i_blocks;
> +
> +	if ((request_mask & STATX_CHANGE_COOKIE) && IS_I_VERSION(inode)) {
> +		stat->result_mask |= STATX_CHANGE_COOKIE;
> +		stat->change_cookie = inode_query_iversion(inode);
> +	}
> +
>  }
>  EXPORT_SYMBOL(generic_fillattr);
>  
> @@ -123,17 +130,12 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
>  	stat->attributes_mask |= (STATX_ATTR_AUTOMOUNT |
>  				  STATX_ATTR_DAX);
>  
> -	if ((request_mask & STATX_CHANGE_COOKIE) && IS_I_VERSION(inode)) {
> -		stat->result_mask |= STATX_CHANGE_COOKIE;
> -		stat->change_cookie = inode_query_iversion(inode);
> -	}
> -
>  	idmap = mnt_idmap(path->mnt);
>  	if (inode->i_op->getattr)
>  		return inode->i_op->getattr(idmap, path, stat,
>  					    request_mask, query_flags);
>  
> -	generic_fillattr(idmap, inode, stat);
> +	generic_fillattr(idmap, request_mask, inode, stat);
>  	return 0;
>  }
>  EXPORT_SYMBOL(vfs_getattr_nosec);

...

