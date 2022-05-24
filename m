Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E04353271C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 12:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbiEXKMS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 06:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiEXKMQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 06:12:16 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 818C55F8F0;
        Tue, 24 May 2022 03:12:13 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 901C410E66B1;
        Tue, 24 May 2022 20:12:06 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ntRWH-00Fn9P-Gs; Tue, 24 May 2022 20:12:05 +1000
Date:   Tue, 24 May 2022 20:12:05 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     David Howells <dhowells@redhat.com>
Cc:     jlayton@kernel.org, keescook@chromium.org,
        Jonathan Corbet <corbet@lwn.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Steve French <smfrench@gmail.com>,
        William Kucharski <william.kucharski@oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-doc@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] netfs: Fix gcc-12 warning by embedding vfs inode in
 netfs_i_context
Message-ID: <20220524101205.GI2306852@dread.disaster.area>
References: <165305805651.4094995.7763502506786714216.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165305805651.4094995.7763502506786714216.stgit@warthog.procyon.org.uk>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=628caf7c
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=7-415B0cAAAA:8
        a=OnzENxpBzhtb90kDdFQA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 20, 2022 at 03:47:36PM +0100, David Howells wrote:
> While randstruct was satisfied with using an open-coded "void *" offset
> cast for the netfs_i_context <-> inode casting, __builtin_object_size() as
> used by FORTIFY_SOURCE was not as easily fooled.  This was causing the
> following complaint[1] from gcc v12:
> 
> In file included from ./include/linux/string.h:253,
>                  from ./include/linux/ceph/ceph_debug.h:7,
>                  from fs/ceph/inode.c:2:
> In function 'fortify_memset_chk',
>     inlined from 'netfs_i_context_init' at ./include/linux/netfs.h:326:2,
>     inlined from 'ceph_alloc_inode' at fs/ceph/inode.c:463:2:
> ./include/linux/fortify-string.h:242:25: warning: call to '__write_overflow_field' declared with attribute warning:
> detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
>   242 |                         __write_overflow_field(p_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fix this by embedding a struct inode into struct netfs_i_context (which
> should perhaps be renamed to struct netfs_inode).  The struct inode
> vfs_inode fields are then removed from the 9p, afs, ceph and cifs inode
> structs and vfs_inode is then simply changed to "netfs.inode" in those
> filesystems.
> 
> Further, rename netfs_i_context to netfs_inode, get rid of the
> netfs_inode() function that converted a netfs_i_context pointer to an inode
> pointer (that can now be done with &ctx->inode) and rename the
> netfs_i_context() function to netfs_inode() (which is now a wrapper around
> container_of()).
> 
> Most of the changes were done with:
> 
>   perl -p -i -e 's/vfs_inode/netfs.inode/'g \
> 	`git grep -l 'vfs_inode' -- fs/{9p,afs,ceph,cifs}/*.[ch]`
> 
> Kees suggested doing it with a pair structure[2] and a special declarator
> to insert that into the network filesystem's inode wrapper[3], but I think
> it's cleaner to embed it - and then it doesn't matter if struct
> randomisation reorders things.

I can't help but think the code would be so much cleaner with a
wrapper to covert from the filesysetm structure to the vfs inode.
e.g. in XFS we use VFS_I(xfs_inode) to get the struct inode and
XFS_I(inode) to get the xfs_inode from the struct inode.
i.e.:

/* Convert from vfs inode to xfs inode */
static inline struct xfs_inode *XFS_I(struct inode *inode)
{
        return container_of(inode, struct xfs_inode, i_vnode);
}

/* convert from xfs inode to vfs inode */
static inline struct inode *VFS_I(struct xfs_inode *ip)
{
        return &ip->i_vnode;
}

Then we end up with stuff like this reading:

> diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
> index e28ddf763b3b..0129de2ea31a 100644
> --- a/fs/9p/v9fs.c
> +++ b/fs/9p/v9fs.c
> @@ -625,7 +625,7 @@ static void v9fs_inode_init_once(void *foo)
>  	struct v9fs_inode *v9inode = (struct v9fs_inode *)foo;
>  
>  	memset(&v9inode->qid, 0, sizeof(v9inode->qid));
> -	inode_init_once(&v9inode->vfs_inode);
> +	inode_init_once(&v9inode->netfs.inode);

	inode_init_once(VFS_I(v9inode));

>  }
>  
>  /**
> diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
> index ec0e8df3b2eb..1b219c21d15e 100644
> --- a/fs/9p/v9fs.h
> +++ b/fs/9p/v9fs.h
> @@ -109,11 +109,7 @@ struct v9fs_session_info {
>  #define V9FS_INO_INVALID_ATTR 0x01
>  
>  struct v9fs_inode {
> -	struct {
> -		/* These must be contiguous */
> -		struct inode	vfs_inode;	/* the VFS's inode record */
> -		struct netfs_i_context netfs_ctx; /* Netfslib context */
> -	};
> +	struct netfs_inode netfs; /* Netfslib context and vfs inode */
>  	struct p9_qid qid;
>  	unsigned int cache_validity;
>  	struct p9_fid *writeback_fid;
> @@ -122,13 +118,13 @@ struct v9fs_inode {
>  
>  static inline struct v9fs_inode *V9FS_I(const struct inode *inode)
>  {
> -	return container_of(inode, struct v9fs_inode, vfs_inode);
> +	return container_of(inode, struct v9fs_inode, netfs.inode);
>  }

Looky dat - there's already the V9FS_I() function for going from the
VFS inode to the 9p inode....

I think that having a VFS_I() for every filesystem would make all
this code a lot cleaner, and it would be easier for everyone to
understand without having to know the exact details of how the netfs
inode encapsulates the struct inode. Consistency of code conventions
across multiple filesystems is a good thing. And if this netfs inode
structure ever has to be changed in future, it's just a few wrapper
functions that need updating, not lots of code...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
