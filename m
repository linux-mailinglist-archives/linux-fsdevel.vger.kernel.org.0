Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721F73BE78C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 14:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhGGMF3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 08:05:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231358AbhGGMF3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 08:05:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB29A61C78;
        Wed,  7 Jul 2021 12:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625659369;
        bh=HKZL+nmXnPrxOIYxOI03sCRYYEwSOhLdHp4JOzx4j08=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=vNoiGbeuTKwb+Vpu4aUliBS0AP9femLDSVbLKa42P4r83mRqrOeXEFv9D07POXrdt
         P8yPpefIMcH6e2SErzoiGRghhW2QBSehsxRY9mNmYLI/gToLbx6Fhris1sotSHfqxh
         SxadSAmlJoKbxlZ3LQ++Vv3+69YaB+LFtOKzjwx64zQ6yEGp3o6wUWTv7FoVH6eLHR
         i+LDFd92u+o5zdjF86/uJ7oE9wHHnNdWwB4JhATMZDh5lFn+EgSN0b68SX2BpZykqa
         IDIMiwuIXKJApeRd7t3heK/Hn0ld9dk2ZLH6ORYD4yO6VkHSoswTpPR6QgXcNTXkG4
         1GQapXrWwZBug==
Message-ID: <82a5c4dbcb9ccc131ab426490484334b02627691.camel@kernel.org>
Subject: Re: [RFC PATCH v7 07/24] ceph: add fscrypt_* handling to caps.c
From:   Jeff Layton <jlayton@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>, ceph-devel@vger.kernel.org
Cc:     lhenriques@suse.de, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, dhowells@redhat.com
Date:   Wed, 07 Jul 2021 08:02:47 -0400
In-Reply-To: <f8c7dc0f-49ee-2c25-8e41-e47557db80e4@redhat.com>
References: <20210625135834.12934-1-jlayton@kernel.org>
         <20210625135834.12934-8-jlayton@kernel.org>
         <f8c7dc0f-49ee-2c25-8e41-e47557db80e4@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-07-07 at 15:20 +0800, Xiubo Li wrote:
> Hi Jeff,
> 
> There has some following patches in your "fscrypt" branch, which is not 
> posted yet, the commit is:
> 
> "3161d2f549db ceph: size handling for encrypted inodes in cap updates"
> 
> It seems buggy.
> 

Yes. Those are still quite rough. If I haven't posted them, then YMMV. I
often push them to -experimental branches just for backup purposes. You
may want to wait on reviewing those until I've had a chance to clean
them up and post them.

> In the encode_cap_msg() you have removed the 'fscrypt_file_len' and and 
> added a new 8 bytes' data encoding:
> 
>          ceph_encode_32(&p, arg->fscrypt_auth_len);
>          ceph_encode_copy(&p, arg->fscrypt_auth, arg->fscrypt_auth_len);
> -       ceph_encode_32(&p, arg->fscrypt_file_len);
> -       ceph_encode_copy(&p, arg->fscrypt_file, arg->fscrypt_file_len);
> +       ceph_encode_32(&p, sizeof(__le64));
> +       ceph_encode_64(&p, fc->size);
> 
> That means no matter the 'arg->encrypted' is true or not, here it will 
> always encode extra 8 bytes' data ?
> 
> 
> But in cap_msg_size(), you are making it optional:
> 
> 
>   static inline int cap_msg_size(struct cap_msg_args *arg)
>   {
>          return CAP_MSG_FIXED_FIELDS + arg->fscrypt_auth_len +
> -                       arg->fscrypt_file_len;
> +                       arg->encrypted ? sizeof(__le64) : 0;
>   }
> 
> 
> Have I missed something important here ?
> 
> Thanks
> 

Nope, you're right. I had fixed that one in my local branch already, and
just hadn't yet pushed it to the repo. I'll plan to clean this up a bit
later today and push an updated branch.

> 
> On 6/25/21 9:58 PM, Jeff Layton wrote:
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >   fs/ceph/caps.c | 62 +++++++++++++++++++++++++++++++++++++++-----------
> >   1 file changed, 49 insertions(+), 13 deletions(-)
> > 
> > diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> > index 038f59cc4250..1be6c5148700 100644
> > --- a/fs/ceph/caps.c
> > +++ b/fs/ceph/caps.c
> > @@ -13,6 +13,7 @@
> >   #include "super.h"
> >   #include "mds_client.h"
> >   #include "cache.h"
> > +#include "crypto.h"
> >   #include <linux/ceph/decode.h>
> >   #include <linux/ceph/messenger.h>
> >   
> > @@ -1229,15 +1230,12 @@ struct cap_msg_args {
> >   	umode_t			mode;
> >   	bool			inline_data;
> >   	bool			wake;
> > +	u32			fscrypt_auth_len;
> > +	u32			fscrypt_file_len;
> > +	u8			fscrypt_auth[sizeof(struct ceph_fscrypt_auth)]; // for context
> > +	u8			fscrypt_file[sizeof(u64)]; // for size
> >   };
> >   
> > -/*
> > - * cap struct size + flock buffer size + inline version + inline data size +
> > - * osd_epoch_barrier + oldest_flush_tid
> > - */
> > -#define CAP_MSG_SIZE (sizeof(struct ceph_mds_caps) + \
> > -		      4 + 8 + 4 + 4 + 8 + 4 + 4 + 4 + 8 + 8 + 4)
> > -
> >   /* Marshal up the cap msg to the MDS */
> >   static void encode_cap_msg(struct ceph_msg *msg, struct cap_msg_args *arg)
> >   {
> > @@ -1253,7 +1251,7 @@ static void encode_cap_msg(struct ceph_msg *msg, struct cap_msg_args *arg)
> >   	     arg->size, arg->max_size, arg->xattr_version,
> >   	     arg->xattr_buf ? (int)arg->xattr_buf->vec.iov_len : 0);
> >   
> > -	msg->hdr.version = cpu_to_le16(10);
> > +	msg->hdr.version = cpu_to_le16(12);
> >   	msg->hdr.tid = cpu_to_le64(arg->flush_tid);
> >   
> >   	fc = msg->front.iov_base;
> > @@ -1324,6 +1322,16 @@ static void encode_cap_msg(struct ceph_msg *msg, struct cap_msg_args *arg)
> >   
> >   	/* Advisory flags (version 10) */
> >   	ceph_encode_32(&p, arg->flags);
> > +
> > +	/* dirstats (version 11) - these are r/o on the client */
> > +	ceph_encode_64(&p, 0);
> > +	ceph_encode_64(&p, 0);
> > +
> > +	/* fscrypt_auth and fscrypt_file (version 12) */
> > +	ceph_encode_32(&p, arg->fscrypt_auth_len);
> > +	ceph_encode_copy(&p, arg->fscrypt_auth, arg->fscrypt_auth_len);
> > +	ceph_encode_32(&p, arg->fscrypt_file_len);
> > +	ceph_encode_copy(&p, arg->fscrypt_file, arg->fscrypt_file_len);
> >   }
> >   
> >   /*
> > @@ -1445,6 +1453,26 @@ static void __prep_cap(struct cap_msg_args *arg, struct ceph_cap *cap,
> >   		}
> >   	}
> >   	arg->flags = flags;
> > +	if (ci->fscrypt_auth_len &&
> > +	    WARN_ON_ONCE(ci->fscrypt_auth_len != sizeof(struct ceph_fscrypt_auth))) {
> > +		/* Don't set this if it isn't right size */
> > +		arg->fscrypt_auth_len = 0;
> > +	} else {
> > +		arg->fscrypt_auth_len = ci->fscrypt_auth_len;
> > +		memcpy(arg->fscrypt_auth, ci->fscrypt_auth,
> > +			min_t(size_t, ci->fscrypt_auth_len, sizeof(arg->fscrypt_auth)));
> > +	}
> > +	/* FIXME: use this to track "real" size */
> > +	arg->fscrypt_file_len = 0;
> > +}
> > +
> > +#define CAP_MSG_FIXED_FIELDS (sizeof(struct ceph_mds_caps) + \
> > +		      4 + 8 + 4 + 4 + 8 + 4 + 4 + 4 + 8 + 8 + 4 + 8 + 8 + 4 + 4)
> > +
> > +static inline int cap_msg_size(struct cap_msg_args *arg)
> > +{
> > +	return CAP_MSG_FIXED_FIELDS + arg->fscrypt_auth_len +
> > +			arg->fscrypt_file_len;
> >   }
> >   
> >   /*
> > @@ -1457,7 +1485,7 @@ static void __send_cap(struct cap_msg_args *arg, struct ceph_inode_info *ci)
> >   	struct ceph_msg *msg;
> >   	struct inode *inode = &ci->vfs_inode;
> >   
> > -	msg = ceph_msg_new(CEPH_MSG_CLIENT_CAPS, CAP_MSG_SIZE, GFP_NOFS, false);
> > +	msg = ceph_msg_new(CEPH_MSG_CLIENT_CAPS, cap_msg_size(arg), GFP_NOFS, false);
> >   	if (!msg) {
> >   		pr_err("error allocating cap msg: ino (%llx.%llx) flushing %s tid %llu, requeuing cap.\n",
> >   		       ceph_vinop(inode), ceph_cap_string(arg->dirty),
> > @@ -1483,10 +1511,6 @@ static inline int __send_flush_snap(struct inode *inode,
> >   	struct cap_msg_args	arg;
> >   	struct ceph_msg		*msg;
> >   
> > -	msg = ceph_msg_new(CEPH_MSG_CLIENT_CAPS, CAP_MSG_SIZE, GFP_NOFS, false);
> > -	if (!msg)
> > -		return -ENOMEM;
> > -
> >   	arg.session = session;
> >   	arg.ino = ceph_vino(inode).ino;
> >   	arg.cid = 0;
> > @@ -1524,6 +1548,18 @@ static inline int __send_flush_snap(struct inode *inode,
> >   	arg.flags = 0;
> >   	arg.wake = false;
> >   
> > +	/*
> > +	 * No fscrypt_auth changes from a capsnap. It will need
> > +	 * to update fscrypt_file on size changes (TODO).
> > +	 */
> > +	arg.fscrypt_auth_len = 0;
> > +	arg.fscrypt_file_len = 0;
> > +
> > +	msg = ceph_msg_new(CEPH_MSG_CLIENT_CAPS, cap_msg_size(&arg),
> > +			   GFP_NOFS, false);
> > +	if (!msg)
> > +		return -ENOMEM;
> > +
> >   	encode_cap_msg(msg, &arg);
> >   	ceph_con_send(&arg.session->s_con, msg);
> >   	return 0;
> 

-- 
Jeff Layton <jlayton@kernel.org>

