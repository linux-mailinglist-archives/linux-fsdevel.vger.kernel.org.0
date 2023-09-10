Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B631A799DFD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Sep 2023 14:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346661AbjIJMDo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Sep 2023 08:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjIJMDn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Sep 2023 08:03:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167E3CC5;
        Sun, 10 Sep 2023 05:03:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29A7C433C7;
        Sun, 10 Sep 2023 12:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694347418;
        bh=QN+hc+RKRwPGNFIhrDfc+9/IkGKeam30JWG3ggY8AtY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=L3fYdoxgBp6pWojJEf6a2gM6/+MgKWxukR8X+K7BHAe8VQpcLBVccLMEsmfcdq4aw
         A8pgB9ddL3Rc8OypnsmuYIpoEsGuHOHHGVQR21Dw/+h7vwBFuAAbWn3Z2Q0/TztT9Y
         fPhUAhBOHBEQMF294g46GBRMO7HkudRjZHxNOcFy8Y+EibvzDFJePxKm5Pi+pyVVRr
         RXGJfI38I8zBNbTZW0vDxF5IeqIaBEuGIYyBdKf0hf94fvHqo/vyz/tRvXCTc4X7vV
         A5DyRYwKoJR4hZYT0PZXa8BZzJW4nFxEsEdIKf/QJHTLpmd3XE8Bhb/yJ+6g7jQjVP
         pvxrqPys7ou9Q==
Message-ID: <07bb387b256ff9ae144bd7734c99ad068435fc42.camel@kernel.org>
Subject: Re: [PATCH] fs: fix regression querying for ACL on fs's that don't
 support them
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Date:   Sun, 10 Sep 2023 08:03:35 -0400
In-Reply-To: <20230910-gingen-maulkorb-918c8c2ce6bf@brauner>
References: <20230908-acl-fix-v1-1-1e6b76c8dcc8@kernel.org>
         <20230910-gingen-maulkorb-918c8c2ce6bf@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2023-09-10 at 12:14 +0200, Christian Brauner wrote:
> On Fri, Sep 08, 2023 at 05:05:27PM -0400, Jeff Layton wrote:
> > In the not too distant past, the VFS ACL infrastructure would return
> > -EOPNOTSUPP on filesystems (like NFS) that set SB_POSIXACL but that
> > don't supply a get_acl or get_inode_acl method. On more recent kernels
> > this returns -ENODATA, which breaks one method of detecting when ACLs
> > are supported.
> >=20
> > Fix __get_acl to also check whether the inode has a "get_(inode_)?acl"
> > method and to just return -EOPNOTSUPP if not.
> >=20
> > Reported-by: Ondrej Valousek <ondrej.valousek.xm@renesas.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > This patch is another approach to fixing this issue. I don't care too
> > much either way which approach we take, but this may fix the problem
> > for other filesystems too. Should we take a belt and suspenders
> > approach here and fix it in both places?
> > ---
> >  fs/posix_acl.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> > index a05fe94970ce..4c7c62040c43 100644
> > --- a/fs/posix_acl.c
> > +++ b/fs/posix_acl.c
> > @@ -130,8 +130,12 @@ static struct posix_acl *__get_acl(struct mnt_idma=
p *idmap,
> >  	if (!is_uncached_acl(acl))
> >  		return acl;
> > =20
> > -	if (!IS_POSIXACL(inode))
> > -		return NULL;
> > +	/*
> > +	 * NB: checking this after checking for a cached ACL allows tmpfs
> > +	 * (which doesn't specify a get_acl operation) to work properly.
> > +	 */
> > +	if (!IS_POSIXACL(inode) || (!inode->i_op->get_acl && !inode->i_op->ge=
t_inode_acl))
> > +		return ERR_PTR(-EOPNOTSUPP);
>=20
> Hmmm, I think that'll cause issues for permission checking during
> lookup:
>=20
> generic_permission()
> -> acl_permission_check()
>    -> check_acl()
>       -> get_inode_acl()
>          -> __get_acl()
>             // return ERR_PTR(-EOPNOTSUPP) instead of NULL
>=20
> Before this change this would've returned NULL and thus check_acl()
> would've returned EAGAIN which would've informed acl_permission_check()
> to continue with non-ACL based permission checking.
>=20
> Now you're going to error out with EOPNOTSUPP and cause permission
> checking to fallback to CAP_DAC_READ_SEARCH/CAP_DAC_OVERRIDE.
>=20
> So if you want this change you'll either need to change check_acl() as we=
ll.
> Unless I'm misreading.

Ok, I didn't see problems in testing this with xfstests, but maybe it
didn't tickle that bug in the right way.

Instead of this, what if we were to add a new SB_NOUMASK flag? NFS could
set that, and then we could fix the places that NFS needs to use that
instead. That might bring more clarity to this code -- SB_POSIXACL would
really mean that ACLs were supported.

I'll see what I can put together...

Thanks!
--
Jeff Layton <jlayton@kernel.org>
