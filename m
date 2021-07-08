Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA543BF8F9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jul 2021 13:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhGHL3f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jul 2021 07:29:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231670AbhGHL3e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jul 2021 07:29:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96698613D6;
        Thu,  8 Jul 2021 11:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625743613;
        bh=LtazYHbZHuDJeCCjAhOWXlBI+lH4PdE7peEWpl4I6ZA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JNscC7wTk0XQCalqQUh5+sThV1TKIJwJwKE9wBK2fzPDK8+F0cCL2EUSvcjSprKff
         PWLml/Bxf1akpHJSfjlz9GwYnJ+mWx01H1BN86jb3buvoc51zmtmkO431wYzUK8ow1
         d2ZcIO0ntKtX9gGJgkpkpSqehsfKaxQIJOmcfmshgC1jjlpyzeXaFa3mAiMUJrHZ5U
         SJ45IDPSHx6D40O7JUGb99wmecKMPqDJefOhNlDdwfkvub+8MsdzrfAKVAxWLIOfNk
         ZjlSeNaMpLtFwFzZwDgee3/D8hE9jSa5y+kNnhCrmJwWkAQBBAdIDe48NgDEaduN9Q
         HUlw4SN8aECwg==
Message-ID: <1554bb07a80a04de2cb1c44fccecc7d14f172e82.camel@kernel.org>
Subject: Re: [RFC PATCH v7 06/24] ceph: parse new fscrypt_auth and
 fscrypt_file fields in inode traces
From:   Jeff Layton <jlayton@kernel.org>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Xiubo Li <xiubli@redhat.com>, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com
Date:   Thu, 08 Jul 2021 07:26:51 -0400
In-Reply-To: <YOXAo8Q0GQoWaAQE@suse.de>
References: <20210625135834.12934-1-jlayton@kernel.org>
         <20210625135834.12934-7-jlayton@kernel.org> <YOWGPv099N7EsMVA@suse.de>
         <14d96eb9-c9b5-d854-d87a-65c1ab3be57e@redhat.com>
         <d9a56cc0d568bbf59cc76ad618b4d0f92c021fed.camel@kernel.org>
         <YOW67YA8e6vivdkh@suse.de> <YOXAo8Q0GQoWaAQE@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-07-07 at 15:56 +0100, Luis Henriques wrote:
> On Wed, Jul 07, 2021 at 03:32:13PM +0100, Luis Henriques wrote:
> > On Wed, Jul 07, 2021 at 08:19:25AM -0400, Jeff Layton wrote:
> > > On Wed, 2021-07-07 at 19:19 +0800, Xiubo Li wrote:
> > > > On 7/7/21 6:47 PM, Luis Henriques wrote:
> > > > > On Fri, Jun 25, 2021 at 09:58:16AM -0400, Jeff Layton wrote:
> > > > > > ...and store them in the ceph_inode_info.
> > > > > > 
> > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > ---
> > > > > >   fs/ceph/file.c       |  2 ++
> > > > > >   fs/ceph/inode.c      | 18 ++++++++++++++++++
> > > > > >   fs/ceph/mds_client.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
> > > > > >   fs/ceph/mds_client.h |  4 ++++
> > > > > >   fs/ceph/super.h      |  6 ++++++
> > > > > >   5 files changed, 74 insertions(+)
> > > > > > 
> > > > > > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > > > > > index 2cda398ba64d..ea0e85075b7b 100644
> > > > > > --- a/fs/ceph/file.c
> > > > > > +++ b/fs/ceph/file.c
> > > > > > @@ -592,6 +592,8 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
> > > > > >   	iinfo.xattr_data = xattr_buf;
> > > > > >   	memset(iinfo.xattr_data, 0, iinfo.xattr_len);
> > > > > >   
> > > > > > +	/* FIXME: set fscrypt_auth and fscrypt_file */
> > > > > > +
> > > > > >   	in.ino = cpu_to_le64(vino.ino);
> > > > > >   	in.snapid = cpu_to_le64(CEPH_NOSNAP);
> > > > > >   	in.version = cpu_to_le64(1);	// ???
> > > > > > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > > > > > index f62785e4dbcb..b620281ea65b 100644
> > > > > > --- a/fs/ceph/inode.c
> > > > > > +++ b/fs/ceph/inode.c
> > > > > > @@ -611,6 +611,13 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
> > > > > >   
> > > > > >   	ci->i_meta_err = 0;
> > > > > >   
> > > > > > +#ifdef CONFIG_FS_ENCRYPTION
> > > > > > +	ci->fscrypt_auth = NULL;
> > > > > > +	ci->fscrypt_auth_len = 0;
> > > > > > +	ci->fscrypt_file = NULL;
> > > > > > +	ci->fscrypt_file_len = 0;
> > > > > > +#endif
> > > > > > +
> > > > > >   	return &ci->vfs_inode;
> > > > > >   }
> > > > > >   
> > > > > > @@ -619,6 +626,9 @@ void ceph_free_inode(struct inode *inode)
> > > > > >   	struct ceph_inode_info *ci = ceph_inode(inode);
> > > > > >   
> > > > > >   	kfree(ci->i_symlink);
> > > > > > +#ifdef CONFIG_FS_ENCRYPTION
> > > > > > +	kfree(ci->fscrypt_auth);
> > > > > > +#endif
> > > > > >   	kmem_cache_free(ceph_inode_cachep, ci);
> > > > > >   }
> > > > > >   
> > > > > > @@ -1021,6 +1031,14 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
> > > > > >   		xattr_blob = NULL;
> > > > > >   	}
> > > > > >   
> > > > > > +	if (iinfo->fscrypt_auth_len && !ci->fscrypt_auth) {
> > > > > > +		ci->fscrypt_auth_len = iinfo->fscrypt_auth_len;
> > > > > > +		ci->fscrypt_auth = iinfo->fscrypt_auth;
> > > > > > +		iinfo->fscrypt_auth = NULL;
> > > > > > +		iinfo->fscrypt_auth_len = 0;
> > > > > > +		inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
> > > > > > +	}
> > > > > I think we also need to free iinfo->fscrypt_auth here if ci->fscrypt_auth
> > > > > is already set.  Something like:
> > > > > 
> > > > > 	if (iinfo->fscrypt_auth_len) {
> > > > > 		if (!ci->fscrypt_auth) {
> > > > > 			...
> > > > > 		} else {
> > > > > 			kfree(iinfo->fscrypt_auth);
> > > > > 			iinfo->fscrypt_auth = NULL;
> > > > > 		}
> > > > > 	}
> > > > > 
> > > > IMO, this should be okay because it will be freed in 
> > > > destroy_reply_info() when putting the request.
> > > > 
> > > > 
> > > 
> > > Yes. All of that should get cleaned up with the request.
> > 
> > Hmm... ok, so maybe I missed something because I *did* saw kmemleak
> > complaining.  Maybe it was on the READDIR path.  /me goes look again.
> 
> Ah, that was indeed the problem.  So, here's a quick hack to fix
> destroy_reply_info() so that it also frees the extra memory from READDIR:
> 
> @@ -686,12 +686,23 @@ static int parse_reply_info(struct ceph_mds_session *s, struct ceph_msg *msg,
>  
>  static void destroy_reply_info(struct ceph_mds_reply_info_parsed *info)
>  {
> +	int i = 0;
> +
>  	kfree(info->diri.fscrypt_auth);
>  	kfree(info->diri.fscrypt_file);
>  	kfree(info->targeti.fscrypt_auth);
>  	kfree(info->targeti.fscrypt_file);
>  	if (!info->dir_entries)
>  		return;
> +
> +	for (i = 0; i < info->dir_nr; i++) {
> +		struct ceph_mds_reply_dir_entry *rde = info->dir_entries + i;
> +		if (rde->inode.fscrypt_auth_len)
> +			kfree(rde->inode.fscrypt_auth);
> +	}
> +	       
>  	free_pages((unsigned long)info->dir_entries, get_order(info->dir_buf_size));
>  }
>  
> 

Well spotted! I'll plan to incorporate a fix like that soon.
-- 
Jeff Layton <jlayton@kernel.org>

