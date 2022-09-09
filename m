Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D975B4161
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 23:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiIIVXc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 17:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiIIVXb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:23:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EA8EC77D;
        Fri,  9 Sep 2022 14:23:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A51CFB82628;
        Fri,  9 Sep 2022 21:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9566BC433D6;
        Fri,  9 Sep 2022 21:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662758603;
        bh=GIfHdGft0Lzt3WDIoEI411kBlv+ZkUVLai/Bwx7Bpu0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pSqKKMEjppbUOdl7y+q6d/EJmw19UmffNqTVbjRA6GzFiU6iPrCfQ87vBCNCyoRYY
         +JrM3HQaX2MgIgtI27xo98SX8v2IiRvdr9q3ttEJBZBoYl8AgKmYA80a/cyBdstuqJ
         Uah/ueYLm6WqXHlEK8yrvxHkBgXFsRioSHp2UKJTcX/+xY1caoS276S39iDGzrk97S
         qSG1mj8s1QnnUN5Dazlg25sswChtztNfvRV0iyOy2oIzfTlZ3xsLCuB2w33E3Ikslf
         d85qoaf1G/m0T9uDv/v5RFhV93kUYrPAmU0XHbiUxYE3wlgdvg5Th3QftZMgCMECez
         bkEBZ33pBtF4Q==
Message-ID: <6b2f3bd41cb194944fe457d659618d91020a6999.camel@kernel.org>
Subject: Re: [PATCH] tmpfs: add support for an i_version counter
From:   Jeff Layton <jlayton@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     hughd@google.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Date:   Fri, 09 Sep 2022 17:23:21 -0400
In-Reply-To: <20220909140344.16f2bf7fbc11a5ac62b932bc@linux-foundation.org>
References: <20220909130031.15477-1-jlayton@kernel.org>
         <20220909140344.16f2bf7fbc11a5ac62b932bc@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-09-09 at 14:03 -0700, Andrew Morton wrote:
> On Fri,  9 Sep 2022 09:00:31 -0400 Jeff Layton <jlayton@kernel.org> wrote=
:
>=20
> > NFSv4 mandates a change attribute to avoid problems with timestamp
> > granularity, which Linux implements using the i_version counter. This i=
s
> > particularly important when the underlying filesystem is fast.
> >=20
> > Give tmpfs an i_version counter. Since it doesn't have to be persistent=
,
> > we can just turn on SB_I_VERSION and sprinkle some inode_inc_iversion
> > calls in the right places.
> >=20
> > Also, while there is no formal spec for xattrs, most implementations
> > update the ctime on setxattr. Fix shmem_xattr_handler_set to update the
> > ctime and bump the i_version appropriately.
> >=20
> > ...
> >=20
> > --- a/fs/posix_acl.c
> > +++ b/fs/posix_acl.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/user_namespace.h>
> >  #include <linux/namei.h>
> >  #include <linux/mnt_idmapping.h>
> > +#include <linux/iversion.h>
> > =20
> >  static struct posix_acl **acl_by_type(struct inode *inode, int type)
> >  {
> > @@ -1073,6 +1074,8 @@ int simple_set_acl(struct user_namespace *mnt_use=
rns, struct inode *inode,
> >  	}
> > =20
> >  	inode->i_ctime =3D current_time(inode);
> > +	if (IS_I_VERSION(inode))
> > +		inode_inc_iversion(inode);
> >  	set_cached_acl(inode, type, acl);
> >  	return 0;
> >  }
>=20
> adds a kilobyte of text to shmem.o because the quite large
> inode_maybe_inc_iversion() get inlined all over the place.  Why oh why.
>=20
> Is there any reason not to do the obvious?
>=20

No reason at all:

Acked-by: Jeff Layton <jlayton@kernel.org>

> --- a/include/linux/iversion.h~a
> +++ a/include/linux/iversion.h
> @@ -177,56 +177,7 @@ inode_set_iversion_queried(struct inode
>  				I_VERSION_QUERIED);
>  }
> =20
> -/**
> - * inode_maybe_inc_iversion - increments i_version
> - * @inode: inode with the i_version that should be updated
> - * @force: increment the counter even if it's not necessary?
> - *
> - * Every time the inode is modified, the i_version field must be seen to=
 have
> - * changed by any observer.
> - *
> - * If "force" is set or the QUERIED flag is set, then ensure that we inc=
rement
> - * the value, and clear the queried flag.
> - *
> - * In the common case where neither is set, then we can return "false" w=
ithout
> - * updating i_version.
> - *
> - * If this function returns false, and no other metadata has changed, th=
en we
> - * can avoid logging the metadata.
> - */
> -static inline bool
> -inode_maybe_inc_iversion(struct inode *inode, bool force)
> -{
> -	u64 cur, old, new;
> -
> -	/*
> -	 * The i_version field is not strictly ordered with any other inode
> -	 * information, but the legacy inode_inc_iversion code used a spinlock
> -	 * to serialize increments.
> -	 *
> -	 * Here, we add full memory barriers to ensure that any de-facto
> -	 * ordering with other info is preserved.
> -	 *
> -	 * This barrier pairs with the barrier in inode_query_iversion()
> -	 */
> -	smp_mb();
> -	cur =3D inode_peek_iversion_raw(inode);
> -	for (;;) {
> -		/* If flag is clear then we needn't do anything */
> -		if (!force && !(cur & I_VERSION_QUERIED))
> -			return false;
> -
> -		/* Since lowest bit is flag, add 2 to avoid it */
> -		new =3D (cur & ~I_VERSION_QUERIED) + I_VERSION_INCREMENT;
> -
> -		old =3D atomic64_cmpxchg(&inode->i_version, cur, new);
> -		if (likely(old =3D=3D cur))
> -			break;
> -		cur =3D old;
> -	}
> -	return true;
> -}
> -
> +bool inode_maybe_inc_iversion(struct inode *inode, bool force);
> =20
>  /**
>   * inode_inc_iversion - forcibly increment i_version
> --- a/fs/libfs.c~a
> +++ a/fs/libfs.c
> @@ -15,6 +15,7 @@
>  #include <linux/mutex.h>
>  #include <linux/namei.h>
>  #include <linux/exportfs.h>
> +#include <linux/iversion.h>
>  #include <linux/writeback.h>
>  #include <linux/buffer_head.h> /* sync_mapping_buffers */
>  #include <linux/fs_context.h>
> @@ -1529,3 +1530,53 @@ void generic_set_encrypted_ci_d_ops(stru
>  #endif
>  }
>  EXPORT_SYMBOL(generic_set_encrypted_ci_d_ops);
> +
> +/**
> + * inode_maybe_inc_iversion - increments i_version
> + * @inode: inode with the i_version that should be updated
> + * @force: increment the counter even if it's not necessary?
> + *
> + * Every time the inode is modified, the i_version field must be seen to=
 have
> + * changed by any observer.
> + *
> + * If "force" is set or the QUERIED flag is set, then ensure that we inc=
rement
> + * the value, and clear the queried flag.
> + *
> + * In the common case where neither is set, then we can return "false" w=
ithout
> + * updating i_version.
> + *
> + * If this function returns false, and no other metadata has changed, th=
en we
> + * can avoid logging the metadata.
> + */
> +bool inode_maybe_inc_iversion(struct inode *inode, bool force)
> +{
> +	u64 cur, old, new;
> +
> +	/*
> +	 * The i_version field is not strictly ordered with any other inode
> +	 * information, but the legacy inode_inc_iversion code used a spinlock
> +	 * to serialize increments.
> +	 *
> +	 * Here, we add full memory barriers to ensure that any de-facto
> +	 * ordering with other info is preserved.
> +	 *
> +	 * This barrier pairs with the barrier in inode_query_iversion()
> +	 */
> +	smp_mb();
> +	cur =3D inode_peek_iversion_raw(inode);
> +	for (;;) {
> +		/* If flag is clear then we needn't do anything */
> +		if (!force && !(cur & I_VERSION_QUERIED))
> +			return false;
> +
> +		/* Since lowest bit is flag, add 2 to avoid it */
> +		new =3D (cur & ~I_VERSION_QUERIED) + I_VERSION_INCREMENT;
> +
> +		old =3D atomic64_cmpxchg(&inode->i_version, cur, new);
> +		if (likely(old =3D=3D cur))
> +			break;
> +		cur =3D old;
> +	}
> +	return true;
> +}
> +EXPORT_SYMBOL(inode_maybe_inc_iversion);
> _
>=20

--=20
