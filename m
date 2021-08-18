Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1F13F0732
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 16:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239697AbhHROza (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 10:55:30 -0400
Received: from out20-111.mail.aliyun.com ([115.124.20.111]:48890 "EHLO
        out20-111.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239565AbhHROz3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:55:29 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04525916|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.684325-0.00469371-0.310981;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.L2MpJn6_1629298491;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.L2MpJn6_1629298491)
          by smtp.aliyun-inc.com(10.147.41.121);
          Wed, 18 Aug 2021 22:54:52 +0800
Date:   Wed, 18 Aug 2021 22:54:55 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     "NeilBrown" <neilb@suse.de>
Subject: Re: [PATCH] VFS/BTRFS/NFSD: provide more unique inode number for btrfs export
Cc:     "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
In-Reply-To: <162881913686.1695.12479588032010502384@noble.neil.brown.name>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown> <162881913686.1695.12479588032010502384@noble.neil.brown.name>
Message-Id: <20210818225454.9558.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

We use  'swab64' to combinate 'subvol id' and 'inode' into 64bit in this
patch.

case1:
'subvol id': 16bit => 64K, a little small because the subvol id is
always increase?
'inode':	48bit * 4K per node, this is big enough.

case2:
'subvol id': 24bit => 16M,  this is big enough.
'inode':	40bit * 4K per node => 4 PB.  this is a little small?

Is there a way to 'bit-swap' the subvol id, rather the current byte-swap?

If not, maybe it is a better balance if we combinate 22bit subvol id and
42 bit inode?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/08/18

> 
> [[This patch is a minimal patch which addresses the current problems
>   with nfsd and btrfs, in a way which I think is most supportable, least
>   surprising, and least likely to impact any future attempts to more
>   completely fix the btrfs file-identify problem]]
> 
> BTRFS does not provide unique inode numbers across a filesystem.
> It *does* provide unique inode numbers with a subvolume and
> uses synthetic device numbers for different subvolumes to ensure
> uniqueness for device+inode.
> 
> nfsd cannot use these varying device numbers.  If nfsd were to
> synthesise different stable filesystem ids to give to the client, that
> would cause subvolumes to appear in the mount table on the client, even
> though they don't appear in the mount table on the server.  Also, NFSv3
> doesn't support changing the filesystem id without a new explicit
> mount on the client (this is partially supported in practice, but
> violates the protocol specification).
> 
> So currently, the roots of all subvolumes report the same inode number
> in the same filesystem to NFS clients and tools like 'find' notice that
> a directory has the same identity as an ancestor, and so refuse to
> enter that directory.
> 
> This patch allows btrfs (or any filesystem) to provide a 64bit number
> that can be xored with the inode number to make the number more unique.
> Rather than the client being certain to see duplicates, with this patch
> it is possible but extremely rare.
> 
> The number than btrfs provides is a swab64() version of the subvolume
> identifier.  This has most entropy in the high bits (the low bits of the
> subvolume identifer), while the inoe has most entropy in the low bits.
> The result will always be unique within a subvolume, and will almost
> always be unique across the filesystem.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/btrfs/inode.c     |  4 ++++
>  fs/nfsd/nfs3xdr.c    | 17 ++++++++++++++++-
>  fs/nfsd/nfs4xdr.c    |  9 ++++++++-
>  fs/nfsd/xdr3.h       |  2 ++
>  include/linux/stat.h | 17 +++++++++++++++++
>  5 files changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 0117d867ecf8..989fdf2032d5 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9195,6 +9195,10 @@ static int btrfs_getattr(struct user_namespace *mnt_userns,
>  	generic_fillattr(&init_user_ns, inode, stat);
>  	stat->dev = BTRFS_I(inode)->root->anon_dev;
>  
> +	if (BTRFS_I(inode)->root->root_key.objectid != BTRFS_FS_TREE_OBJECTID)
> +		stat->ino_uniquifier =
> +			swab64(BTRFS_I(inode)->root->root_key.objectid);
> +
>  	spin_lock(&BTRFS_I(inode)->lock);
>  	delalloc_bytes = BTRFS_I(inode)->new_delalloc_bytes;
>  	inode_bytes = inode_get_bytes(inode);
> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
> index 0a5ebc52e6a9..669e2437362a 100644
> --- a/fs/nfsd/nfs3xdr.c
> +++ b/fs/nfsd/nfs3xdr.c
> @@ -340,6 +340,7 @@ svcxdr_encode_fattr3(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>  {
>  	struct user_namespace *userns = nfsd_user_namespace(rqstp);
>  	__be32 *p;
> +	u64 ino;
>  	u64 fsid;
>  
>  	p = xdr_reserve_space(xdr, XDR_UNIT * 21);
> @@ -377,7 +378,10 @@ svcxdr_encode_fattr3(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>  	p = xdr_encode_hyper(p, fsid);
>  
>  	/* fileid */
> -	p = xdr_encode_hyper(p, stat->ino);
> +	ino = stat->ino;
> +	if (stat->ino_uniquifier && stat->ino_uniquifier != ino)
> +		ino ^= stat->ino_uniquifier;
> +	p = xdr_encode_hyper(p, ino);
>  
>  	p = encode_nfstime3(p, &stat->atime);
>  	p = encode_nfstime3(p, &stat->mtime);
> @@ -1151,6 +1155,17 @@ svcxdr_encode_entry3_common(struct nfsd3_readdirres *resp, const char *name,
>  	if (xdr_stream_encode_item_present(xdr) < 0)
>  		return false;
>  	/* fileid */
> +	if (!resp->dir_have_uniquifier) {
> +		struct kstat stat;
> +		if (fh_getattr(&resp->fh, &stat) == nfs_ok)
> +			resp->dir_ino_uniquifier = stat.ino_uniquifier;
> +		else
> +			resp->dir_ino_uniquifier = 0;
> +		resp->dir_have_uniquifier = 1;
> +	}
> +	if (resp->dir_ino_uniquifier &&
> +	    resp->dir_ino_uniquifier != ino)
> +		ino ^= resp->dir_ino_uniquifier;
>  	if (xdr_stream_encode_u64(xdr, ino) < 0)
>  		return false;
>  	/* name */
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 7abeccb975b2..ddccf849c29c 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3114,10 +3114,14 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>  					fhp->fh_handle.fh_size);
>  	}
>  	if (bmval0 & FATTR4_WORD0_FILEID) {
> +		u64 ino = stat.ino;
> +		if (stat.ino_uniquifier &&
> +		    stat.ino_uniquifier != stat.ino)
> +			ino ^= stat.ino_uniquifier;
>  		p = xdr_reserve_space(xdr, 8);
>  		if (!p)
>  			goto out_resource;
> -		p = xdr_encode_hyper(p, stat.ino);
> +		p = xdr_encode_hyper(p, ino);
>  	}
>  	if (bmval0 & FATTR4_WORD0_FILES_AVAIL) {
>  		p = xdr_reserve_space(xdr, 8);
> @@ -3285,6 +3289,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>  			if (err)
>  				goto out_nfserr;
>  			ino = parent_stat.ino;
> +			if (parent_stat.ino_uniquifier &&
> +			    parent_stat.ino_uniquifier != ino)
> +				ino ^= parent_stat.ino_uniquifier;
>  		}
>  		p = xdr_encode_hyper(p, ino);
>  	}
> diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
> index 933008382bbe..b4f9f3c71f72 100644
> --- a/fs/nfsd/xdr3.h
> +++ b/fs/nfsd/xdr3.h
> @@ -179,6 +179,8 @@ struct nfsd3_readdirres {
>  	struct xdr_buf		dirlist;
>  	struct svc_fh		scratch;
>  	struct readdir_cd	common;
> +	u64			dir_ino_uniquifier;
> +	int			dir_have_uniquifier;
>  	unsigned int		cookie_offset;
>  	struct svc_rqst *	rqstp;
>  
> diff --git a/include/linux/stat.h b/include/linux/stat.h
> index fff27e603814..a5188f42ed81 100644
> --- a/include/linux/stat.h
> +++ b/include/linux/stat.h
> @@ -46,6 +46,23 @@ struct kstat {
>  	struct timespec64 btime;			/* File creation time */
>  	u64		blocks;
>  	u64		mnt_id;
> +	/*
> +	 * BTRFS does not provide unique inode numbers within a filesystem,
> +	 * depending on a synthetic 'dev' to provide uniqueness.
> +	 * NFSd cannot make use of this 'dev' number so clients often see
> +	 * duplicate inode numbers.
> +	 * For BTRFS, 'ino' is unlikely to use the high bits.  It puts
> +	 * another number in ino_uniquifier which:
> +	 * - has most entropy in the high bits
> +	 * - is different precisely when 'dev' is different
> +	 * - is stable across unmount/remount
> +	 * NFSd can xor this with 'ino' to get a substantially more unique
> +	 * number for reporting to the client.
> +	 * The ino_uniquifier for a directory can reasonably be applied
> +	 * to inode numbers reported by the readdir filldir callback.
> +	 * It is NOT currently exported to user-space.
> +	 */
> +	u64		ino_uniquifier;
>  };
>  
>  #endif
> -- 
> 2.32.0


